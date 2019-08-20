SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

echo "id,name,class
1,Yamada,A
222,Suzuki,B
3,Tanaka,A" > users.type.csv

# `.import`すると`TEXT`型になってしまうせいでソートが期待通りにならない
sqlite3 :memory: \
".mode csv" \
".import users.type.csv users" \
".tables" \
"select sql from sqlite_master;" \
".headers on" \
".mode column" \
"select * from users order by id;"

# 解法: テーブルを予め作っておく
sqlite3 :memory: \
"create table users(id integer primary key, name text not null, class text not null)" \
".mode csv" \
".import users.type.csv users" \
".tables" \
"select sql from sqlite_master;" \
".headers on" \
".mode column" \
"select * from users order by id;"

