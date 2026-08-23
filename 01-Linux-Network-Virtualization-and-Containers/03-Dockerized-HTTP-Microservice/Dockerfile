FROM python:3.9-slim



WORKDIR /HTTPServer



RUN pip install pip install --no-cache-dir \
flask==2.0.2 \
werkzeug==2.0.2



COPY HTTPServer.py .



EXPOSE 8000



CMD ["python", "HTTPServer.py"]