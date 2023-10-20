FROM python:3.11.4-alpine

WORKDIR /usr/src/app

# prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
# ensure Python output is sent directly to the terminal without buffering
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

ENV PATH="/py/bin:$PATH"
ENV DEBUG="1"
ENV SECRET_KEY="mysecretkey"
ENV ALLOWED_HOSTS=localhost,127.0.0.1
RUN chmod +x ./entrypoint.sh

COPY ./entrypoint.sh /usr/src/app/entrypoint.sh

COPY . /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]