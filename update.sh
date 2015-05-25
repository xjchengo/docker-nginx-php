#$!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
    versions=( *.*/ )
fi
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
    if [ ! -d "$version" ]; then
        mkdir $version
    fi

    cp docker-entrypoint.sh $version
    cp Dockerfile $version
    sed -i "s/FROM php:fpm/FROM php:$version-fpm/" $version/Dockerfile
    cp sources.list $version
    cp supervisord.conf $version
done
