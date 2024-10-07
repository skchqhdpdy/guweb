if [ ! -d "../bancho.py" ]; then
    echo You need Install bancho.py First!!
    exit
fi

export $(grep -v '^#' ../bancho.py/.env | xargs) #환경변수 가져옴

#python3
echo python3-venv install
sudo apt install -y python3-venv
if [ ! -d "../venv" ]; then
    python3 -m venv ../venv
    sudo ln -r -s ../venv/bin/python ../venv/bin/py && sudo ln -r -s ../venv/bin/python ../venv/bin/chopy && sudo ln -r -s ../venv/bin/python ../venv/bin/guweb
    source ../venv/bin/activate
    pip install -r ext/requirements.txt
fi

#nginx
sudo ln -r -s ext/nginx.conf /etc/nginx/sites-enabled/guweb.conf
sudo sed -i "s/web.example.com/${DOMAIN}/" ext/nginx.conf
sudo sed -i "s|fullchain.pem|${SSL_CERT_PATH}|" ext/nginx.conf
sudo sed -i "s|privkey.pem|${SSL_KEY_PATH}|" ext/nginx.conf
sudo vim ext/nginx.conf

#config.py
sudo cp ext/config.sample.py config.py
sudo sed -i "s/gulag.ca/${DOMAIN}/" config.py
sudo sed -i "s/'db': 'gulag'/'db': '${DB_NAME}'/" config.py
sudo sed -i "s/'user': 'cmyui'/'user': '${DB_USER}'/" config.py
sudo sed -i "s/'password': 'changeme'/'password': '${DB_PASS}'/" config.py
sudo sed -i "s|/path/to/gulag/|$(echo "$DATA_DIRECTORY" | sed 's|.data||')|g" config.py
sudo vim config.py