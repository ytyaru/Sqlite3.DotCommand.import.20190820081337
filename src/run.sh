SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd "$SCRIPT_DIR"
./run_csv.sh
./run_csv_type_text.sh
./run_tsv.sh
./run_list.sh
./run_html.sh
./run_insert_can_not.sh

