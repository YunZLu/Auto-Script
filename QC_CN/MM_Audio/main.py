import os
import aiohttp
from aiohttp import web
from urllib.parse import quote, unquote
import logging
import binascii
import asyncio
import json

# 设置日志记录
logging.basicConfig(level=logging.INFO)

# 基础目录路径
home_dir = os.path.expanduser("~/MM_Audio")

# 配置文件夹路径
config_dir = os.path.join(home_dir, "config_speakers")
default_config_path = os.path.join(config_dir, 'default.json')

# 临时文件夹路径
temp_dir = os.path.join(home_dir, "silly_tts_temp")
os.makedirs(temp_dir, exist_ok=True)  # 自动检查并创建

# 创建一个全局锁
request_lock = asyncio.Lock()

async def hello(request):
    return web.Response(text="success")

async def sound_api(request):
    async with request_lock:
        speaker = quote(request.match_info['speaker'])
        text = unquote(request.match_info['text'])  # 解码 text

        # 检查是否存在与 speaker 对应的配置文件
        speaker_config_path = os.path.join(config_dir, f"{speaker}.json")
        if os.path.exists(speaker_config_path):
            config_path = speaker_config_path
        else:
            config_path = default_config_path

        # 读取配置文件
        with open(config_path, 'r', encoding='utf-8') as f:
            config = json.load(f)

        group_id = config["group_id"]
        api_key = config["api_key"]
        request_params = config["request_params"]

        file_path = os.path.join(temp_dir, f"{speaker}.{text}.mp3")
        if not os.path.exists(file_path):
            api_url = f"https://api.minimax.chat/v1/t2a_v2?GroupId={group_id}"
            json_data = request_params.copy()
            json_data["text"] = text

            headers = {
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json"
            }
            try:
                async with aiohttp.ClientSession() as session:
                    async with session.post(api_url, json=json_data, headers=headers) as resp:
                        resp.raise_for_status()
                        response_data = await resp.json()
                        if response_data.get("data") is None:
                            logging.error("Response data is null")
                            return web.Response(status=500)
                        
                        audio_hex = response_data["data"]["audio"]
                        
                        # 将十六进制数据转换为二进制数据
                        audio_binary = binascii.unhexlify(audio_hex)
                        
                        # 保存二进制数据为MP3文件
                        with open(file_path, "wb") as f:
                            f.write(audio_binary)
            except aiohttp.ClientError as e:
                logging.error(f"Request failed: {e}")
                return web.Response(status=500)
            except IOError as e:
                logging.error(f"File operation failed: {e}")
                return web.Response(status=500)
            finally:
                # 每次请求完成后等待 2 秒
                await asyncio.sleep(2)

        return web.FileResponse(file_path)

app = web.Application()
app.add_routes([
    web.get('/', hello),
    web.get('/{speaker}/{text}', sound_api),
])

if __name__ == '__main__':
    server_port = input("请输入端口号，默认为5000，可无脑按回车\n")
    server_port = int(server_port) if server_port else 5000
    web.run_app(app, port=server_port)
    logging.info(f'Server running on http://127.0.0.1:{server_port}/')
