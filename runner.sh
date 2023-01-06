
#! /bin/bash


REPOSITORYNAME=$1
REPOSITORYFULLNAME=$2
WORKDIR="/root/githubrunner"

echo "RepositoryName:"$REPOSITORYFULLNAME

cd $WORKDIR
pwd
echo "Clone Repository...."
echo "GitUser:"$GITUSER
echo "Token:"$GITTOKEN

#remove existing dir
rm -rf $REPOSITORYNAME

git clone https://$GITUSER:$GITTOKEN@github.com/$REPOSITORYFULLNAME.git

cd $REPOSITORYNAME
#chmod +x mvnw
#git pull


# run build.sh

echo "================ Runing Build Script ========="
#./mvnw clean install -Dmaven.test.skip
chmod +x build.sh && ./build.sh

echo "DONE"