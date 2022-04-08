
apt update && apt upgrade -y 

# what we need to run python
apt install -y -q build-essential python3-pip python3-dev
# Upgrading dependencies
pip3 install -U pip setuptools wheel
# gunicorn - production server that will wrap up uvicorn, uvloop - high performance loop
pip3 install gunicorn uvloop httptools

cp .requirements.txt /app/requirements.txt

pip3 install -r /app/requirements.txt

cp ./service/ /app

# Super run script
/usr/local/bin/gunicorn \
  -b 0.0.0.0:80 \
  -w 4 \ # create 4 subprocesses to load balance 
  -k uvicorn.workers.UvicornWorker main:app \ # run in main:app
  --chdir /app