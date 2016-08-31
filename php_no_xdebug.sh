function php_no_xdebug {
    local temporaryPath="$(mktemp -t php.XXXX).ini"

    # Using awk to ensure that files ending without newlines do not lead to configuration error
    php -i | grep "\.ini" | grep -o -e '\(/[a-z0-9._-]\+\)\+\.ini' | grep -v xdebug | xargs awk 'FNR==1{print ""}1' > "$temporaryPath"

    php -n -c "$temporaryPath" "$@"
    rm -f "$temporaryPath"
}
php_no_xdebug "$@"
