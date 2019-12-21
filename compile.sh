docker-compose run app /bin/bash -lc "nasm -f elf64 ./src/app.asm -o ./src/app.o"
docker-compose run app /bin/bash -lc "ld ./src/app.o -o ./bin/app"