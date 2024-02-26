#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtQml/qqmlextensionplugin.h>

Q_IMPORT_QML_PLUGIN(libguiPlugin)

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.addImportPath(":/dev.naisys.net");
    const QUrl url(u"qrc:/Beverage-Dispenser-Interface/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
