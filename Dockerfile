FROM bcgovimages/von-image:next-1

ADD requirements.txt .
ADD requirements.dev.txt .

RUN pip3 install --no-cache-dir -r requirements.txt -r requirements.dev.txt

ADD tails_server ./tails_server
ADD bin ./bin
ADD README.md ./
ADD setup.py ./

RUN pip3 install --no-cache-dir -e .

RUN mkdir /tmp/tails-files

CMD tails-server \
    --host vswrepo.com \
    --port 6543 \ 
    --storage-path /tmp/tails-files \
    --log-level INFO
