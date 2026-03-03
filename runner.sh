#! /bin/bash



# Load environment variables from .env file if exists
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

REPOSITORYNAME=$1
REPOSITORYFULLNAME=$2
BRANCH=$3
WORKDIR="/root/githubrunner"

echo "RepositoryName:"$REPOSITORYFULLNAME
echo "Branch:"$BRANCH

cd $WORKDIR
pwd
echo "Clone Repository...."
echo "GitUser:"$GITUSER
echo "Token:"$GITTOKEN

#remove existing dir
echo "remove existing directory"
rm -rf $REPOSITORYNAME

echo "Cloning branch $BRANCH https://$GITUSER:$GITTOKEN@github.com/$REPOSITORYFULLNAME.git"
#git clone https://$GITUSER:$GITTOKEN@github.com/$REPOSITORYFULLNAME.git

# Jika branch bukan main, tambahkan --branch $BRANCH
if [ "$BRANCH" != "main" ]; then
  git clone --branch "$BRANCH" https://$GITUSER:$GITTOKEN@github.com/$REPOSITORYFULLNAME.git
else
  git clone https://$GITUSER:$GITTOKEN@github.com/$REPOSITORYFULLNAME.git
fi
#git clone https://github.com/$REPOSITORYFULLNAME.git

cd $REPOSITORYNAME
#chmod +x mvnw
#git pull


# run build.sh

echo "================ Running Build Script ========="

case "$BRANCH" in
  "staging")
    echo "Running build-staging.sh"
    chmod +x build-staging.sh && ./build-staging.sh
    ;;
  "main")
    echo "Running build.sh"
    chmod +x build.sh && ./build.sh
    ;;
  "test")
    echo "Running build-test.sh"
    chmod +x build-test.sh && ./build-test.sh
    ;;
  *)
    echo "Running build-$BRANCH.sh"
    chmod +x build-$BRANCH.sh && ./build-$BRANCH.sh
    ;;
esac

echo "DONE"