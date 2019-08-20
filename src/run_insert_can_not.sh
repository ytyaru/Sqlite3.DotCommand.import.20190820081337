SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"

echo -e "id\tname\tclass
1\tYamada\tA
2\tSuzuki\tB
3\tTanaka\tA" > users.tsv

sqlite3 :memory: \
".mode tabs" \
".import users.tsv users" \
".mode insert" \
".output users_insert.sql" \
"select * from users;" \
"delete from users;" \
".output stdout" \
".mode insert" \
".import users_insert.sql users" \
".headers on" \
".separator ' '" \
".mode column" \
"select sql from sqlite_master;" \
"select * from users;"

cat users_insert.sql 

# `.mode insert`のテーブル名が`"table"`になってしまう
sqlite3 :memory: \
".mode tabs" \
".import users.tsv users" \
".mode insert" \
"select * from users;"

# `.read`で取り込もうとするも失敗
sqlite3 :memory: \
".mode tabs" \
".import users.tsv users" \
".mode insert" \
".output users_insert.sql" \
"select * from users;" \
"delete from users;" \
".output stdout" \
".read users_insert.sql" \
".headers on" \
".separator ' '" \
".mode column" \
"select sql from sqlite_master;" \
"select * from users;"
cat users_insert.sql 

# 事前に`create table`して`.mode insert`してみる
sqlite3 :memory: \
"create table users(id integer primary key, name text not null, class text not null)" \
".mode tabs" \
".import users.tsv users" \
".mode insert" \
"select * from users;"

# 事前に`create table`, `insert`して`.mode insert`してみる
sqlite3 :memory: \
"create table users(id integer primary key, name text not null, class text not null)" \
"insert into users(name,class) values('AAA','A');" \
".mode insert" \
"select * from users;"

# `.mode insert`はテーブル名が`"table"`になってしまう？
# 引数にテーブル名を渡せばOK
sqlite3 :memory: \
"create table users(id integer primary key, name text not null, class text not null)" \
"insert into users(name,class) values('AAA','A');" \
".mode insert users" \
"select * from users;"

# `.mode insert`で`.import`できなかった
echo -e "id\tname\tclass
1\tYamada\tA
2\tSuzuki\tB
3\tTanaka\tA" > users.tsv

sqlite3 :memory: \
".mode tabs" \
".import users.tsv users" \
".mode insert users" \
".output users_insert.sql" \
"select * from users;" \
"delete from users;" \
".output stdout" \
".mode insert users" \
".import users_insert.sql users" \
".headers on" \
".separator ' '" \
".mode column" \
"select sql from sqlite_master;" \
"select * from users;"

cat users_insert.sql

# `.mode insert` + `.read`
sqlite3 :memory: \
".mode tabs" \
".import users.tsv users" \
".mode insert users" \
".output users_insert.sql" \
"select * from users;" \
"delete from users;" \
".output stdout" \
".read users_insert.sql" \
".headers on" \
".separator ' '" \
".mode column" \
"select sql from sqlite_master;" \
"select * from users;"

