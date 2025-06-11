FROM python:slim

WORKDIR /app

COPY myapp/ .

RUN pip install -r requirements.txt

CMD ["python", "app.py"]