FROM mrndrsn/siege:latest

WORKDIR /root

COPY siegerc /root/.siegerc
COPY urls.txt /root/
COPY startup.sh /root/
