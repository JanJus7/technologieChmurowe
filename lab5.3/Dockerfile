ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}

WORKDIR /app

COPY /myapp .

RUN pip install -r requirements.txt

CMD ["python", "app.py"]