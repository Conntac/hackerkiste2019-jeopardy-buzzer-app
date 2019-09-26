#include "buzzerengine.h"

#include <QWebSocket>
#include <QLoggingCategory>

Q_LOGGING_CATEGORY(logBuzzerEngine, "buzzer_engine");

class BuzzerEngine::Private : public QObject
{
    Q_OBJECT

public:
    Private(BuzzerEngine *q)
    : q(q)
    {
        socket = new QWebSocket(QString(), QWebSocketProtocol::VersionLatest, this);
        connect(socket, &QWebSocket::connected, this, &BuzzerEngine::Private::onConnected);
        connect(socket, &QWebSocket::disconnected, this, &BuzzerEngine::Private::onDisconnected);
        connect(socket, &QWebSocket::textMessageReceived, this, &BuzzerEngine::Private::onTextMessageReceived);
    }

    BuzzerEngine *q;

    // Properties
    QWebSocket *socket;

    QString playerName;

    BuzzerEngine::State state = BuzzerEngine::Disconnected;
    BuzzerEngine::BuzzerState buzzerState = BuzzerEngine::Unavailable;

    // Functions
    void setState(BuzzerEngine::State state);
    void setBuzzerState(BuzzerEngine::BuzzerState buzzerState);

public slots:
    void onConnected();
    void onDisconnected();
    void onTextMessageReceived(const QString &textMessage);
};

void BuzzerEngine::Private::setState(BuzzerEngine::State state)
{
    if (this->state == state) {
        return;
    }

    this->state = state;

    emit q->stateChanged(state);
}

void BuzzerEngine::Private::setBuzzerState(BuzzerEngine::BuzzerState buzzerState)
{
    if (this->buzzerState == buzzerState) {
        return;
    }

    this->buzzerState = buzzerState;

    emit q->buzzerStateChanged(buzzerState);
}

void BuzzerEngine::Private::onConnected()
{
    setState(BuzzerEngine::Connected);

    socket->sendTextMessage(QString("hello %1").arg(playerName));
}

void BuzzerEngine::Private::onDisconnected()
{
    setState(BuzzerEngine::Disconnected);
}

void BuzzerEngine::Private::onTextMessageReceived(const QString &textMessage)
{
    QString msg = textMessage.trimmed();

    qCDebug(logBuzzerEngine) << "onTextMessageReceived:" << msg;

    switch(state) {
    case BuzzerEngine::Disconnected:
        break;
    case BuzzerEngine::Connected:
        if (msg == "welcome") {
            setState(BuzzerEngine::Registered);
        } else if (msg.startsWith("not welcome")) {
            q->disconnect();
        }
        break;
    case BuzzerEngine::Registered:
        break;
    }
}


BuzzerEngine::BuzzerEngine(QObject *parent)
: QObject(parent)
, d(new Private(this))
{
}

BuzzerEngine::~BuzzerEngine()
{
    delete d;
}

BuzzerEngine::State BuzzerEngine::state() const
{
    return d->state;
}

BuzzerEngine::BuzzerState BuzzerEngine::buzzerState() const
{
    return d->buzzerState;
}

void BuzzerEngine::setName(const QString &name)
{
    if (d->playerName == name) {
        return;
    }

    d->playerName = name;

    emit nameChanged(name);
}

QString BuzzerEngine::name() const
{
    return d->playerName;
}

void BuzzerEngine::classBegin()
{
}

void BuzzerEngine::componentComplete()
{
}

void BuzzerEngine::connect(const QUrl &address)
{
    d->socket->open(address);
}

void BuzzerEngine::disconnect()
{
    d->socket->close();
}

void BuzzerEngine::buzz()
{
    d->socket->sendTextMessage("buzz");
}

#include "buzzerengine.moc"
