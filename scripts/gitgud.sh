# --------------------------------------------------------------------------------------#
# Jakub Dudek | jakub.a.dudek@gmail.com | MIT license                                   #
#                                                                                       #
# Not responsible for anything that breaks, you are using this at your own risk         #
#                                                                                       #
# Requires that following packages are installed and available in your $PATH:           #
# - fzf                                                                                 #
#                                                                                       #
# To install add "source /path/to/this/file/gitgud.sh" in your shell configuration file    #
# --------------------------------------------------------------------------------------#


# gitgud is a small set of scripts intended to improve your everyday experience with git

# gitgud
# ----------------
# prints helper menu

GREEN='\033[0;32m'
NC='\033[0m' # No Color
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

gitgud() {

    echo "
    ${BOLD}Gitgud commands${NORMAL}
    ${GREEN}------------------------------------------------------------------------${NC}
    ${BOLD}gr ${NORMAL}: 'git restore'
    Interactive restore, -f flag for full restore if staged

    ${BOLD}gn ${NORMAL}: 'git nuke'
    Full clear current working tree, cleans added files

    ${BOLD}gp ${NORMAL}: 'git push'
    Push, but automatically add upstream branch if one doesn't exists

    ${BOLD}gch ${NORMAL}: 'git checkout'
    Interactively checkout branch, --all to include remote branches"

    return 0
}

# gr | git restore 
# -------------------
# Interactively restore staged/unstaged changes
# "gr" : Your typical restore
# "gr -f" : Restores staged files completely instead of moving them to unstaged

gr() {
    # Check that we are in a project
    if ! is_git_repo 
    then
        echo "Not a git repository"
        return -1
    fi

    # List staged files, prepend green "Staged: "
    STAGED=$(git diff --staged --name-only | sed -e "s/^/${GREEN}Staged: ${NC}/") 

    # List unstaged files, prepend red "Unstaged: "
    UNSTAGED=$(git diff --name-only | sed -e "s/^/${RED}Unstaged: ${NC}/") 

    # Check for changes
    if [[ -z $STAGED && -z $UNSTAGED ]]
    then
        echo "No changes, working tree clean"
        return 0
    fi

    # Concat
    MSG="${STAGED}\n${UNSTAGED}"
    
    # Clear empty lines
    MSG=$(echo $MSG | sed '/^$/d')

    # Interactive select with fzf
    # Tail to maintain order since fzf flips
    # --ansi to maintain colors
    FILE=$(echo $MSG | tail -r | fzf --ansi --no-sort ) # Interactive select 


    # If -f flag, full restore 
    if [[ $1 == -f ]] 
    then
        FILE=$(echo $FILE | sed -E 's/^.*(Staged|Unstaged): //')
        git restore --staged $FILE
        git restore $FILE
        return 0
    fi
    
    # Restore if staged
    if [[ $FILE == Staged:* ]] # * is used for pattern matching
    then
        FILE=$(echo $FILE | sed -E 's/^.*(Staged|Unstaged): //')
        git restore --staged $FILE
        return 0
    fi

    # Restore if unstaged
    if [[ $FILE == Unstaged:* ]] # * is used for pattern matching
    then
        FILE=$(echo $FILE | sed -E 's/^.*(Staged|Unstaged): //')
        git restore $FILE
        return 0
    fi

    # Error out
    echo "Something went wrong :("
    return -1
}

# gn | git nuke
# -------------------
# Fully clear any uncommited changes, removes all new files

gn(){
    # Check that we are in a project
    if ! is_git_repo 
    then
        echo "Not a git repository"
        return -1
    fi

    if ! has_changes
    then
        echo "No changes, working tree clean"
	return -1
    fi
    
    echo
    echo ${BOLD}Following files will be nuked ${NC}
    echo ${BOLD}------------------------------------------------------------------------${NC}
    git status -s
    echo ${BOLD}------------------------------------------------------------------------${NC}
    read -q "response?Are you sure? [y/N] " response
        case "$response" in
            [yY][eE][sS]|[yY]) 
               git restore --staged .
               git restore .
               git clean -f .
	       return 0
            ;;
    *)
    ;;
    esac
    return -1
}

# gp | git push 
# -------------------
# Simple git push but adds remote origin if it doesn't exist as origin/current-branch-name

gp(){
    # Check that we are in a project
    if ! is_git_repo 
    then
        echo "Not a git repository"
        return -1
    fi

    git push || git branch --show-current | xargs git push -u origin
}

# gch | git checkout
# -------------------
# Interactively checkout branch, all git-branch flags work as expected
# "gch" : For local branches only
# "gch --all" : Includes remote branches

gch () {
    # Check that we are in a project
    if ! is_git_repo 
    then
        echo "Not a git repository"
        return -1
    fi

    git branch $1 | fzf | xargs git checkout 
}


#### Helpers ####
#-----------------
is_git_repo() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        return 0
    fi
    return -1
}

has_changes() {
    if [[ -z $(git status -s) ]]
    then
	return -1 
    else
	return 0 
    fi
}
