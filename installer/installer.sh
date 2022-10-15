path='C:/'
read -e -i "$path" -p "directory path > " input
path="${input:-$path}"

cp ../source/springEasy.sh $path

echo 'alias spe="'$path'springEasy.sh"' >> ~/.bashrc | source ~/.bashrc

echo "if spe comand doesn't work please run: source ~/.bashrc"