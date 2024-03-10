FROM python

WORKDIR /app

COPY . /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python","app.py" ]

RUN chmod +x test_app.py

RUN python test_app.py

EXPOSE 3000