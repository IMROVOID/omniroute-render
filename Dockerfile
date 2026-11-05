FROM diegosouzapw/omniroute:latest

USER root
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
USER node

ENV PORT=20128
EXPOSE 20128

ENTRYPOINT ["/app/start.sh"]
