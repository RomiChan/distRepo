echo "try to update apt repo..."
rm -rf ./deb/db ./deb/dist ./pool
reprepro -C main -b ./deb includedeb nini ./download/*.deb
echo "try to update rpm repo..."
rm -f ./rpm/dist/*.rpm
mv ./download/*.rpm ./rpm/dist/
createrepo --update ./rpm/dist



