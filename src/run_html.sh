SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

echo -e "id\tname\tclass
1\tYamada\tA
2\tSuzuki\tB
3\tTanaka\tA" > users.tsv

sqlite3 :memory: \
".mode tabs" \
".import users.tsv users" \
".mode html" \
".output users.html" \
"select * from users;" \
".output stdout" \
".import users.html users" \
".headers on" \
".mode column" \
"select sql from sqlite_master;" \
"select * from users;"

cat users.html

