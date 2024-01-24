FROM python:3.11-slim-buster

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/kdayski/privateGPT

WORKDIR /usr/src/app/privateGPT

RUN pip install poetry

RUN poetry config virtualenvs.create false \
    && poetry install --with ui,local

COPY ./scripts/setup ./scripts/setup

RUN ./scripts/setup

EXPOSE 8001

CMD ["poetry", "run", "python3.11", "-m", "private_gpt"]
