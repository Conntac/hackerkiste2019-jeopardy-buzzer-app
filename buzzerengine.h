#ifndef BUZZERENGINE_H
#define BUZZERENGINE_H

#include <QObject>
#include <QQmlParserStatus>

class BuzzerEngine : public QObject
                   , public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(State state READ state NOTIFY stateChanged)
    Q_PROPERTY(BuzzerState buzzerState READ buzzerState NOTIFY buzzerStateChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    explicit BuzzerEngine(QObject *parent = nullptr);
    ~BuzzerEngine() override;

    enum State {
        Disconnected,
        Connected,
        Registered
    };
    Q_ENUM(State)

    State state() const;

    enum BuzzerState {
        Unavailable,
        Available,
        BuzzedFirst,
        BuzzedTooLate
    };
    Q_ENUM(BuzzerState)

    BuzzerState buzzerState() const;

    void setName(const QString &name);
    QString name() const;

    // QQmlParserStatus interface
    void classBegin() override;
    void componentComplete() override;

public slots:
    void connect(const QUrl &address);
    void disconnect();

    void buzz();

signals:
    void stateChanged(State state);
    void buzzerStateChanged(BuzzerState buzzerState);
    void nameChanged(const QString &name);

private:
    class Private;
    Private *d;
};

#endif // BUZZERENGINE_H
