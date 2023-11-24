## Bash Monitor

A simple URL watcher utility based on HTTP requests and powered by bash. Sends alert messages to Telegram channels.

### Prerequisites
If you don't have one, create a Telegram Bot using [@BotFather](https://telegram.me/BotFather). Create a chat (group) and invite [@RawDataBot](https://telegram.me/rawdatabot) to get the channel id.

Must have `curl` installed.

### Installation

- Running on host:

```
git clone https://github.com/bdaviddvlp/bash-monitor.git
cd bash-monitor
cp .env.example .env # replace credentials to yours
cd config
cp example.bash-monitor.conf bash-monitor.conf # add urls you want to monitor
```

- Running in docker container:

```
docker-compose up -d
```

### Usage

On host:

- Start the monitor: `./init_monitor.sh`
- List running processes `./show_status.sh`
- Kill running proceses `./kill_monitor.sh`

In container:

 - List running processes: `docker exec -it bash-monitor-app-1 /app/show_status.sh`
 - Stop monitor: `docker-compose down`


### Improvements planned

- Make it possible to run and deploy by Docker container
- Implement ping feature
- Implement keyword feature
- Logging incidents and resolved events

*Any contribution is appreciated*