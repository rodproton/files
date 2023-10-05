#!/bin/bash

wget -O package.tar https://download.mozilla.org/\?product\=firefox-latest-ssl\&os\=linux64\&lang\=en-US

sudo tar -xvf package.tar -C /opt/ 

rm package.tar

sudo cat > /usr/share/applications/firefox.desktop << "EOF"
[Desktop Entry]
Name=Firefox
Comment=Web Browser
Exec=/opt/firefox/firefox %u
Terminal=false
Type=Application
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
Actions=Private;

[Desktop Action Private]
Exec=/opt/firefox/firefox --private-window %u
Name=Open in private mode
EOF

sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox
