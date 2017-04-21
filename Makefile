build:
	docker build -t jmcarbo/docker-caddy --build-arg plugins="awslambda,cors,expires,filter,git,filemanager,hugo,ipfilter,jsonp,jwt,locale,mailout,minify,multipass,prometheus,ratelimit,realip,search,upload" .

run:
	docker run -ti -p 2015:2015 --rm jmcarbo/docker-caddy
