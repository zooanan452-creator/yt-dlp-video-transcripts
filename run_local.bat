@echo off
chcp 65001 >nul
setlocal

REM ============================================================
REM  YouTube 频道字幕下载（本机运行，Windows）
REM  双击即可。每次抓取频道最新 N 个视频的中文字幕。
REM  需要本机已安装 Python 3.9+ 并且能访问 YouTube。
REM ============================================================

set "CHANNEL=https://www.youtube.com/@ltshijie"
set "LANGCODE=zh"
set "MAXVIDEOS=5"

set "ROOT=%~dp0"
set "OUT=%ROOT%output"

where python >nul 2>nul
if errorlevel 1 (
  echo [错误] 没有找到 python，请先安装 Python 3.9+ 并加入 PATH。
  pause
  exit /b 1
)

python -c "import yt_dlp" >nul 2>nul
if errorlevel 1 (
  echo 首次运行，正在安装 yt-dlp ...
  python -m pip install -U yt-dlp
)

if exist "%OUT%" rmdir /s /q "%OUT%"

echo.
echo 频道：%CHANNEL%
echo 语言：%LANGCODE%   数量：%MAXVIDEOS%
echo.

python "%ROOT%scripts\channel_transcripts.py" "%CHANNEL%" -o "%OUT%" --lang %LANGCODE% --max-videos %MAXVIDEOS% --retries 5 --retry-delay 5

echo.
echo 完成。字幕在：%OUT%
pause
