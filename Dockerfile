FROM ubuntu:latest as builder

RUN apt update && apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y

WORKDIR /xmrig

COPY . /xmrig

RUN mkdir build && cd build && cmake .. && make -j$(nproc)

FROM ubuntu:latest as final

RUN apt update && apt install libuv1-dev libssl-dev libhwloc-dev -y

WORKDIR /xmrig

COPY --from=builder /xmrig/build/xmrig .

# VARIABLES
ENV POOL_URL="pool.supportxmr.com:3333"
ENV ACCESS_TOKEN="x"
ENV WORKER_NAME="x"
ENV THREADS="1"
ENV PRIORITY="0"
ENV USERNAME="x"
ENV PASSWORD="x"
ENV COIN="monero"
ENV DONATE_LEVEL="5"

CMD /xmrig/xmrig --http-access-token=$ACCESS_TOKEN --url=$POOL_URL --user=$USERNAME --pass=$PASSWORD --rig-id=$WORKER_NAME --threads=$THREADS --priority=$PRIORITY --coin=$COIN --donate-level=$DONATE_LEVEL