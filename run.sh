#!/bin/bash

# Maps simpleHTTPServer 8000 to 80 externally
# Makes blog directory appear in /project
# Makes pelican plugins dir appear in /project
# Makes pelican themes dir appear in /project
docker run \
-p 80:8000 \
-v ~/Stuff/blog-box:/project \
-v ~/Stuff/pelican-plugins:/project/pelican-plugins  \
-v ~/Stuff/pelican-themes:/project/pelican-themes \
-ti chrisramsay/pelicanbox:latest \
/bin/bash
