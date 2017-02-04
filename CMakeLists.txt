cmake_minimum_required(VERSION 3.6)
project(CalcLanguage)

set(CMAKE_C_STANDARD 99)

set(SOURCE_FILES main.c parser_utils.c parser_utils.h scanner.h scanner.c parser.tab.c parser.tab.h)

add_executable(CalcLanguage ${SOURCE_FILES})