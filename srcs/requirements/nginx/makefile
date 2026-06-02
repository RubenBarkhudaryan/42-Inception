all:
	docker rmi nginx_img:01
	docker build -t nginx_img:01 .
	clear
	docker run -p 443:443 --rm --name cont1 nginx_img:01
