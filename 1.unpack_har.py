import json
import common
import base64
import os
from os import path

har_data = json.load(open(common.har_path, 'r', encoding='utf-8'))
har_entries = har_data['log']['entries']

resource_list = {
    'resources': [],
    'levels': []
}
hash_list = {}

def push_levels(temple):
    for item in temple['levels']:
        resource_list['levels'].append('data/' + item['filename'])

for entry in har_entries:
    url: str = entry['request']['url']
    if url.startswith(common.grab_url):
        url = url[len(common.grab_url):]
        if url.find('?') != -1:
            url = url[0:url.find('?')]
        if hash_list.get(url):
            continue
        hash_list[url] = True
        if url.find('/levels/') == -1:
            resource_list['resources'].append(url)
    if url.find('/temple.json') != -1:
        temple = entry['response']['content']['text']
        if entry['response']['content'].get('encoding') == 'base64':
            temple = base64.b64decode(temple).decode(encoding='utf-8')
        temple = json.loads(temple)
        push_levels(temple)

os.makedirs(path.dirname(common.resource_list_path), exist_ok=True)
json.dump(resource_list, open(common.resource_list_path, 'w', encoding='utf-8'), indent='  ')
