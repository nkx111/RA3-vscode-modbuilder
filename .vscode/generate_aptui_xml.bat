@echo off
setlocal EnableDelayedExpansion

REM 检查环境变量是否存在
if not defined WORKSPACE_FOLDER (
    echo Error: WORKSPACE_FOLDER must be set as environment variable
    exit /b 1
)
if not defined WORKSPACE_FOLDER_BASENAME (
    echo Error: WORKSPACE_FOLDER_BASENAME must be set as environment variable
    exit /b 1
)

REM 设置目标目录
set "aptui_dir=%WORKSPACE_FOLDER%\data\aptui"

REM 创建目录如果不存在
if not exist "%aptui_dir%" mkdir "%aptui_dir%"

REM 遍历子文件夹并生成XML文件
for /d %%i in ("%aptui_dir%\*") do (
    set "folder_name=%%~ni"
    set "xml_file=%aptui_dir%\!folder_name!.xml"
    
    REM 写入XML内容
    (
        echo ^<?xml version="1.0"?^>
        echo ^<AssetDeclaration xmlns="uri:ea.com:eala:asset"^>
        echo     ^<Includes^>
        echo         ^<Include type="all" source="DATA:%WORKSPACE_FOLDER_BASENAME%\data\aptui\!folder_name!\!folder_name!.xml" /^>
        echo     ^</Includes^>
        echo ^</AssetDeclaration^>
    ) > "!xml_file!"
    echo Generated !xml_file!
)

echo AptUI XML generation completed.
endlocal