#!/bin/bash

function Update() {
    GetOSName
    local OSType=$?
    echo "更新APT仓库中..."
    rm -rf ./deb/db ./deb/dist ./deb/pool
    if [ "$OSType" == "0" ]; then
        echo "正在安装reprepro"
        sudo dnf install reprepro -y
    elif [ "$OSType" == "1" ]; then
        echo "正在安装reprepro"
        sudo apt install reprepro -y
    fi
    reprepro -C main -b ./deb includedeb nini ./download/*.deb
    echo "APT仓库更新完成"
    echo "更新RPM仓库中..."
    rm -f ./rpm/dist/*.rpm
    mv ./download/*.rpm ./rpm/dist/
    if [ "$OSType" == "0" ]; then
        echo "正在安装createrepo"
        sudo dnf install createrepo -y
    elif [ "$OSType" == "1" ]; then
        echo "正在安装createrepo"
        sudo apt install createrepo -y
    fi
    createrepo --update ./rpm/dist
    echo "RPM仓库更新完成"
    echo "All done~"
}
function GetOSName() {
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        Name='CentOS'
        OS=0
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        Name='Debian'
        OS=1
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        Name='Ubuntu'
        OS=2
    else
        Name='unknow'
    fi
    if [ $Name != 'unknow' ]; then
        echo -e '检测到您的系统为: '$Name''
        return $OS
    else
        echo -e '不支持的操作系统，请更换为 CentOS / Debian / Ubuntu 后重试。'
        exit 1
    fi
}

Update
LatestVer="${GITHUB_REF#"refs/tags/"}"
git config --local user.name 'github-actions[bot]'
git config --local user.email '41898282+github-actions[bot]@users.noreply.github.com'
git add --all
git commit -m "update to $LatestVer"
echo $LatestVer | sed 's/-/~/g' > LatestVer
git tag -d "$LatestVer"
git tag "$LatestVer"
git push
git push --tags
