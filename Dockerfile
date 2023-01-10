FROM ubuntu:18.04
WORKDIR /aneka
COPY . ./
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y python3-pip tzdata && \
    dpkg-reconfigure -f noninteractive tzdata && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install -r requirements.txt && \
    apt-get install -y python3-opencv

CMD uwsgi -w aneka:app --http-socket :$PORT