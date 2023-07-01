#!/bin/bash
#docker build -t my_php .
#docker run -it --rm my_php bash
docker run -it --rm -v $(pwd):/app -p 8080:8080 my_php php -S 0.0.0.0:8080 -t public
