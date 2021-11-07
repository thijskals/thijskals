cd RSL

git config --global user.name "thijskals"
git config --global user.email "93706272+thijskals@user.noreply.github.com in github"
git init


git status
git add --all
git status
git commit -am "i-th set of working files including feature x"
git status


git remote add origin https://github.com/thijskals/thijskals.git
git push -u origin master

rm -rf .git


source ~/VE/bin/activate

pip uninstall numpy
sudo apt-get install libatlas-base-dev
pip3 install numpy
