import json
import common
import base64
import os
from urllib.request import urlopen
from urllib.request import HTTPError
from os import path

resource_list = json.load(open(common.resource_list_path, 'r', encoding='utf-8'))

def grab_file(relative_url):
    print('*', relative_url)
    url = common.grab_url + relative_url
    save_path = path.join(common.output_dir, relative_url)
    os.makedirs(path.dirname(save_path), exist_ok=True)
    try:
        data = urlopen(url).read()
        open(save_path, 'wb').write(data)
    except HTTPError as err:
        print('   ', err)

os.makedirs(common.output_dir, exist_ok=True)

for url in resource_list['resources']:
    grab_file(url)

for url in resource_list['levels']:
    grab_file(url)
