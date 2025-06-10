ARG PYTHON_VERSION=3.9
ARG APP_PORT=8000

FROM python:${PYTHON_VERSION}-alpine

ENV PYTHON_VER=${PYTHON_VERSION}
ENV PORT=${APP_PORT}

WORKDIR /app

COPY myapp/ .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE ${PORT}

VOLUME /app/data

CMD ["python", "app.py"]