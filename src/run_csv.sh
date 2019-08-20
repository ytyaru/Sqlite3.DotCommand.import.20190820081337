SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

echo "id,name,class
1,Yamada,A
2,Suzuki,B
3,Tanaka,A" > users.csv

# テーブルが未存なら
sqlite3 :memory: \
".mode csv" \
".import users.csv users" \
".tables" \
"select sql from sqlite_master;" \
".headers on" \
".mode column" \
"select * from users;"

# テーブルが既存なら
sqlite3 :memory: \
".mode csv" \
".import users.csv users" \
".tables" \
"select sql from sqlite_master;" \
".headers on" \
".mode column" \
"select * from users;" \
".import users.csv users" \
"select * from users;"

