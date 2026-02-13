@echo off
chcp 65001 >nul
color 0A
cls
echo.
echo ╔════════════════════════════════════════════════╗
echo ║   🚀 Chiang Mai Trip Planner                   ║
echo ║      กำลังเริ่มต้น...                          ║
echo ╚════════════════════════════════════════════════╝
echo.

REM Check if venv exists
REM If venv exists but python exe inside it is missing, remove it to recreate
if exist "venv\" (
    if not exist "venv\Scripts\python.exe" (
        echo ⚠️ พบ venv ที่เสียหาย — ลบและสร้างใหม่...
        rmdir /s /q venv
    )
)

if not exist "venv\" (
    echo 📦 สร้าง Virtual Environment...
    REM Prefer the python launcher; fall back to python if launcher not available
    py -3 -m venv venv 2>nul || python -m venv venv
    if errorlevel 1 (
        echo.
        echo ❌ ผิดพลาด: Python ยังไม่ติดตั้ง หรือไม่พบตัวเรียกใช้ Python
        echo ให้ดาวน์โหลดจาก: https://www.python.org/downloads/
        pause
        exit /b 1
    )
)

REM Activate venv
echo 🔌 Activate Virtual Environment...
call venv\Scripts\activate.bat

REM Install requirements
echo 📥 ติดตั้ง Libraries...
pip install -q flask flask-cors pandas reportlab requests

REM Run app
echo.
echo ✅ เริ่มต้น Flask Server...
echo.
echo 🌐 เปิดเบราว์เซอร์ไปที่: http://localhost:5000
echo.
echo ⚠️  ปิดหน้า CMD นี้เพื่อหยุด Server
echo.

python app.py

pause