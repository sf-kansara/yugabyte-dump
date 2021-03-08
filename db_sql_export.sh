POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

#Var parsing logic: https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
case $key in
  -h)
  DB_HOST="$2"
  shift # past argument
  shift # past value
  ;;
  -p)
  DB_PORT="$2"
  shift # past argument
  shift # past value
  ;;
  -U)
  DB_USERNAME="$2"
  shift # past argument
  shift # past value
  ;;
  --db-names)
  DB_NAMES="$2"
  shift # past argument
  shift # past value
  ;;
  --schema)
  DB_SCHEMA="$2"
  shift # past argument
  shift # past value
  ;;
  *)    # unknown option
  POSITIONAL+=("$1") # save it in an array for later
  shift # past argument
  ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

START_TS=$(date +"%Y%m%d-%H:%M:%S")
DUMP_FOLDER="db-sql-dump-${START_TS}"

mkdir -p $DUMP_FOLDER

for i in $(echo $DB_NAMES | sed "s/,/ /g")
do
  echo
  echo "Creating .sql dump for ${i}"
  OP_STR="/home/ec2-user/yugabyte-db/yb-software/yugabyte-2.5.1.0/postgres/bin/ysql_dump --file \"${DUMP_FOLDER}/${i}.sql\" --host ${DB_HOST} --port ${DB_PORT} --username ${DB_USERNAME} --disable-triggers --no-owner --no-privileges --no-unlogged-table-data --encoding \"UTF8\" --schema \"${DB_SCHEMA}\" \"${i}\""
  (eval $OP_STR && echo ".sql dump successful for ${i}") || echo ".sql dump failed for ${i}"
done
