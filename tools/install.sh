# Allow ability to specify a protocol for git in the event git:// is 
# firewalled and/or any other reason you may have.
while getopts ":p:" OPTION
do
  case $OPTION in
    p) protocol=$OPTARG;;
    \?) echo "Invalid argument: -${OPTARG}." && usage >&2;;
  esac
done
shift $(($OPTIND - 1))

# Default to git:// if $protocol is not set.
if [ -z $protocol ]
then
  protocol=git
fi

if [ -d ~/.oh-my-zsh ]
then
  echo "You already have Oh My Zsh installed. You'll need to remove ~/.oh-my-zsh if you want to install"
  exit
else
  echo "Cloning Oh My Zsh..."
  echo "/usr/bin/env git clone ${protocol}://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh"
  /usr/bin/env git clone ${protocol}://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

echo "Looking for an existing zsh config..."
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
then
  echo "Found ~/.zshrc. Backing up to ~/.zshrc.pre-oh-my-zsh";
  cp ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
  rm ~/.zshrc;
fi

echo "Using the Oh My Zsh template file and adding it to ~/.zshrc"
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

echo "Copying your current PATH and adding it to the end of ~/.zshrc for you."
echo "export PATH=$PATH" >> ~/.zshrc

echo "Time to change your default shell to zsh!"
chsh -s /bin/zsh

echo "Hooray! Oh My Zsh has been installed."
/bin/zsh
source ~/.zshrc

