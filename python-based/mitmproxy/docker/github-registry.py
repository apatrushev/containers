import os
import base64
from mitmproxy import ctx
import mitmproxy.http


USER = os.environ['GITHUB_USER']
TOKEN = os.environ['GITHUB_TOKEN']


class LocalRedirect:
    def request(self, flow: mitmproxy.http.HTTPFlow):
        scope = flow.request.query.pop('scope', None)
        if scope is not None:
            if ':library/' in scope:
                scope = scope.replace(':library/', f':{USER}/')
                flow.request.query['account'] = f'{USER}'
                auth = base64.b64encode(f'{USER}:{TOKEN}'.encode()).decode()
                flow.request.headers['authorization'] = f'Basic {auth}'
            flow.request.query['scope'] = scope
        if '/library/' in flow.request.path:
            flow.request.path = flow.request.path.replace('/library/', f'/{USER}/')
        if 'registry-1.docker.io' in flow.request.pretty_host:
            ctx.log.info(f'pretty host is: {flow.request.pretty_host}')
            flow.request.host = 'ghcr.io'
            flow.request.port = 443
            flow.request.scheme = 'https'


addons = [
    LocalRedirect()
]
