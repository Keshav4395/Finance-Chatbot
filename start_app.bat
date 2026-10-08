@echo off
title FinBase AI Assistant Launcher
color 0A

echo ========================================================
echo   Starting FinBase AI Customer Support Assistant...
echo ========================================================
echo.

:: 1. Start the FastAPI Backend in a separate window
echo [1/2] Launching Backend Server on port 8000...
start "FinBase Backend (FastAPI)" cmd /k "cd /d %~dp0backend && .\venv\Scripts\activate && python -m uvicorn app.main:app --host 0.0.0.0 --port 8000"

:: Brief pause so backend initializes first
timeout /t 3 /nobreak >nul

:: 2. Start the React Frontend in a separate window
echo [2/2] Launching Frontend UI on port 5173...
start "FinBase Frontend (React)" cmd /k "cd /d %~dp0frontend && npm run dev"

echo.
echo ========================================================
echo   SUCCESS! Both services are now running:
echo   - Frontend Chat UI : http://localhost:5173
echo   - Backend Swagger   : http://localhost:8000/docs
echo ========================================================
echo.
echo You can close this launcher window. (Keep the other 2 open!)
pause
