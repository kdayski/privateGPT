FROM python:3.11.6

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app/privateGPT

COPY . .

RUN pip install poetry

RUN poetry config virtualenvs.create false \
    && poetry install --with ui,local
RUN poetry install --extras chroma

RUN ./scripts/setup

EXPOSE 8001

CMD ["poetry", "run", "python3.11", "-m", "private_gpt"]
