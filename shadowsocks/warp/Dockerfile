FROM debian:bookworm

RUN apt update &&\
    apt install -y gpg curl &&\
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg |\
	 gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg &&\
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bookworm main' > /etc/apt/sources.list.d/cloudflare-client.list &&\
    apt update &&\
    apt install -y cloudflare-warp &&\
    apt clean

ADD ./entrypoint.sh .

ENTRYPOINT ./entrypoint.sh 
