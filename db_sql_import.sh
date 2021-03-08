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
  --dump-folder)
  DUMP_FOLDER="$2"
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

for f in $DUMP_FOLDER/*.sql
do
  echo
  echo "Executing .sql dump for ${f}"
  DB_NAME=$(echo $(basename ${f}) | cut -f 1 -d '.')
  OP_STR="ysqlsh -h ${DB_HOST} -p ${DB_PORT} -U ${DB_USERNAME} -d ${DB_NAME} -f ${f}"
  (eval $OP_STR && echo ".sql dump successful for ${i}") || echo ".sql dump failed for ${i}"
done
