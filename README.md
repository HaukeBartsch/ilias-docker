# ilias-docker version 5.4

We start with a mysql docker and add the other libraries we need.

How to run the container
```
docker run --name=mysqlCon -p 3306:3306 -d ilias-docker
```
Here is a link to the description of the project:https://docu.ilias.de/ilias.php?ref_id=1719&obj_id=124773&cmd=layout&cmdClass=illmpresentationgui&cmdNode=ba&baseClass=ilLMPresentationGUI .

After creating the docker container you need to run the Ilias setup wizard on:
```
http://localhost/setup/setup.php
```