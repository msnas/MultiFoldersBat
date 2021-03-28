@echo off 

REM Isto é um simples batch comando que cria pastas com o nome escolhido
REM pelo utilizador e o mês, dia e ano em que a execução foi feita

set /p folder="Nome da pasta: "
echo %folder%

REM Vamos certificar que o utilizador possua em modo UTF-8
REM Caso seja necessário mudar para uma outra codificação, poderá mudar de acordo de acordo com o seguinte site:
REM https://ss64.com/nt/chcp.html

chcp 65001

REM Para dar valores as variáveis que iremos utilizar no loop, será necessário dar enable ao seguinte comando
setlocal enableDelayedExpansion

REM Cria-se então uma variável com o nº:mês
REM Por motivos de utilização, deixou-se em inglês
set "months= 1:Jan 2:Feb 3:Mar 4:Apr 5:May 6:Jun 7:Jul 8:Aug 9:Sep 10:Oct 11:Nov 12:Dec"

REM Vamos utilizar um comando win32_localtime que retorna os valores que queremos
for /f "skip=1 tokens=1,2" %%X in (
  '"wmic path win32_localtime get month, year"'
) do if "%%Y" neq "" for /f %%M in ("!months:* %%X:=!") do (
  set "month=%%M"
  set "year=%%Y"
)
set day=%date:~0,2%

REM Iremos criar as pastas dentro da já escolhida
REM Por motivos de utilização, foi necessário criar desta forma, no entanto estão livres de mudar para o que pretenderem
mkdir %folder%" (!month! %day%, !year!")"\(1) "%folder%" (Original)
mkdir %folder%" (!month! %day%, !year!")"\(1) "%folder%" (Original)\"%folder%" - Homogeneidade"
mkdir %folder%" (!month! %day%, !year!")"\(2) "%folder%" (Pré-Revisão)
mkdir %folder%" (!month! %day%, !year!")"\(3) "%folder%" (Pós-Revisão)
