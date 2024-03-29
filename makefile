#------Colors--------
EOC		=	"\033[0;0m"
RED		=	"\033[1;31m"
YELLOW	=	"\033[1;33m"
GREEN	=	"\033[1;32m"
#====================

all: up

up:	add_volumes
	sudo sh -c 'echo "127.0.0.1 tdesmet.42.fr" >> /etc/hosts'; \
	docker compose -f ./srcs/docker-compose.yml up -d --build; \

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

add_volumes:
	@sudo mkdir -p /home/tdesmet/data/mariadb
	@sudo mkdir -p /home/tdesmet/data/wordpress

clean_volumes:

		docker volume rm mdb_volume wp_volume > /dev/null; \
		sudo rm -rf /home/tdesmet/data/mariadb; \
		sudo rm -rf /home/tdesmet/data/wordpress; \

clean:
	@docker compose -f ./srcs/docker-compose.yml down --rmi all
	@docker system prune -af
	@make -s clean_volumes
	@sudo sed -i -e '/127.0.0.1 tdesmet.42.fr/d' /etc/hosts; \

re: stop all


