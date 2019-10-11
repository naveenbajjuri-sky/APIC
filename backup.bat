@echo off
SET /p userId= APIM UserId:
SET /p password= Password:

CALL apic login --username "%userId%" --password "%password%" --server "https://api-manager-ui.vm014074.bskyb.com" --realm provider/default-idp-2

CALL set currentDate=%DATE:~0,2%%DATE:~3,2%%DATE:~6,4%
CALL set currentDate=%currentDate: =0%
CALL set currentTimeStamp=%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
CALL set currentTimeStamp=%currentTimeStamp: =0%
ECHO %currentDate%%currentTimeStamp%

CALL md %currentDate%%currentTimeStamp%

FOR /F "tokens=1 delims= " %%I IN ( 'CALL apic draft-products:list-all -o sky-apic-test -s "https://api-manager-ui.vm014074.bskyb.com" ')  DO (
     SETLOCAL ENABLEDELAYEDEXPANSION
     SET "apiName=%%I"
	 CALL apic draft-products:get --format yaml -o sky-apic-test -s "https://api-manager-ui.vm014074.bskyb.com" --output %currentDate%%currentTimeStamp% %%I
)

echo "*********************"
echo "Products backup completed"
echo "*********************"