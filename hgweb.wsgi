#!/usr/bin/env python3
config = b"/home/vc/hgweb.conf"
# enable demandloading to reduce startup time
from mercurial import demandimport; demandimport.enable()
from mercurial.hgweb import hgweb, wsgicgi
application = hgweb(config)
wsgicgi.launch(application)
