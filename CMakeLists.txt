cmake_minimum_required(VERSION 3.16)

project(Beverage-Dispenser-Interface VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qmlmodules)

list(APPEND MODULE_DIRS ${CMAKE_BINARY_DIR}/qmlmodules)

set(QML_IMPORT_PATH ${MODULE_DIRS}
    CACHE STRING "Qt Creator 4.1 extra qml import paths"
    FORCE
)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Widgets Core)

add_subdirectory(ext/NaiSys-DesktopUtils/LibNetwork/)
add_subdirectory(ext/NaiSys-DesktopUtils/LibGui/)

qt_standard_project_setup()

qt_add_executable(appBeverage-Dispenser-Interface
    main.cpp
)

qt_add_qml_module(appBeverage-Dispenser-Interface
    URI Beverage-Dispenser-Interface
    VERSION 1.0
    QML_FILES Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appBeverage-Dispenser-Interface PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appBeverage-Dispenser-Interface
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appBeverage-Dispenser-Interface
    PRIVATE Qt6::Quick Qt6::Widgets
    naisysguiplugin
    naisysnetwork
)

include(GNUInstallDirs)
install(TARGETS appBeverage-Dispenser-Interface
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
