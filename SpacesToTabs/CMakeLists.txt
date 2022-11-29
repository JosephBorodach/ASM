cmake_minimum_required(VERSION 3.23)
project(SpacesToTabs)

set(CMAKE_CXX_STANDARD 14)

add_executable(SpacesToTabs main.cpp entab_broken.cpp entab_broken.h entab.c)
