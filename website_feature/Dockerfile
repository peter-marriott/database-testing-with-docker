# Pull base image.
FROM python:2.7

COPY . /src
WORKDIR /src
RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python", "-u", "/src/web_service.py"]
