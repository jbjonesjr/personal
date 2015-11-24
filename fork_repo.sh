#! /bin/bash



#hostname=github.com
#system_url=https://api.github.com
hostname=octodemo.com
system_url=https://octodemo.com/api/v3
username=jbjonesjr
pass_key=4adac4f249d0d5b1130cc750789f12bd90a8a507
repo=fork_test
org_base=fork_test_org

# Relevant APIS
# Create user
# https://developer.github.com/v3/users/administration/#create-a-new-user
# POST /admin/users

# Delete user
# https://developer.github.com/v3/users/administration/#delete-a-user
# DELETE /admin/users/:username

# Create an org
# https://developer.github.com/v3/enterprise/orgs/#create-an-organization
# POST /admin/organizations

# Create a repo
# https://developer.github.com/v3/repos/#create
# POST /user/repos
# POST /orgs/:org/repos

# Fork a repo
# https://developer.github.com/v3/repos/forks/#create-a-fork
# POST /repos/:owner/:repo/forks


user1=
user1_pass=
user2=
user2_pass=
user3=
user3_pass=
user4=
user4_pass=

# Create repo
echo "--Creating an inital repo on $hostname for this experiment, '$repo'"
echo '{ "name": "'"$repo"'", "description": "This is a repo to test forking repos",  "private": false }' | curl -H "Content-Type: application/json" -d @- -u $username:$pass_key -s -o /dev/null -w "%{http_code}" $system_url/user/repos && echo ""

#Push initial commit
echo "--Creating a local repo at ~/$repo"
mkdir ~/$repo
cd ~/$repo
git init
git remote add origin https://$username:$pass_key@$hostname/$username/$repo.git
git pull origin master
echo "--Creating an initial file"
echo "First file" > initial_file.md
git add initial_file.md
git commit -m "adding initial file to repo"
init_commit=`git log -1 --pretty="%H"`
echo "--Push the initial file remotely"
git push origin master

echo "--Ready to clean-up? press any key to continue."
read -n 1 -s
rm -rf ~/$repo
curl -X DELETE -u $username:$pass_key -i -s -o /dev/null -w "%{http_code}" $system_url/repos/$username/$repo && echo ""
