# To-do application using Django and React
*Author: [Fernando França (フランサ)](https://github.com/furansa/django-react-todo-app)*

*Last update: Thu Oct  12 22:03:58 EDT 2019*

This is a Django + React **to-do** application running inside Docker. This example 
is based on this [article](https://scotch.io/tutorials/build-a-to-do-application-using-django-and-react) 
with my personnal modifications to run inside a Docker container.

To build the application image:
```bash
$ docker build -t todo-base ./
```

To start the container:
```bash
$ docker run -d \
--name todo-test \
-p 8000:8000 \
-p 3000:3000 \
-v "${PWD}"/scripts:/tmp/scripts:ro \
-v "${PWD}"/app:/home/todo \
todo-base
```

The container will mount the volumes directories indicated by the **-v** option, 
the **${PWD}/app** is the directory where the code will reside, and for the sake 
of convenience, the **entrypoint.sh** is mounted as read-only inside the container. 
You can use the option **cached** on the **app** volume mount if you want to improve 
performance a little bit on Os X.

On the very first time, the **entrypoint.sh** script will create a new project 
called **backend** and inside it, create a application called **todo**. The root 
path to the application inside the container will be **/home/todo/**.

Now you can start to write your code on the host machine and it will automatically 
be updated inside the running container. To access the backend application (API) 
from the host machine open a browser to **http://localhost:8000**.

Also, at the first time, the frontend application will be created inside the 
**frontend** directory with all the required packages, to access the frontend 
application got to **http://localhost:3000**.

To access the container for debugging with the application running in foreground:
```bash
docker exec -it tictactoe-test bash
```

To access the container for debugging without the application running, check the 
**entrypoint.sh** script and uncomment the final lines.
