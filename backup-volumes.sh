for i in `docker inspect --format='{{.Name}}' $(docker ps -q) | cut -f2 -d\/`
        do container_name=$i
        mkdir -p $backup_path/$container_name
        echo -n "$container_name - "

	#docker run --rm \
  	#--volumes-from $container_name \
  	#-v $backup_path:/backup \
  	#-e TAR_OPTS="$tar_opts" \
  	#alanjohnwilliams/docker-backup \
        #backup "$container_name/$container_name-volume.tar.xz"

	docker run --rm \
  	--volumes-from $container_name \
  	-v $backup_path:/backup \
  	-e RSYNC_OPTS="$tar_opts" \
  	alanjohnwilliams/docker-rsync \
        backup "/backup/$container_name"

	if [ $? -ne 0 ]; then
    		echo "Error"
        else
    		echo "OK"
	fi
done
