BEGIN {
	i = 0;
}

{
    split($1, addr, ":");
    printf("backend_hostname%d = '%s'\n", i, addr[1]);
    printf("backend_port%d = %d\n", i, addr[2]);
    printf("backend_weight%d = %d\n", i, $2);
    printf("backend_application_name%d = '%s'\n", i, $3);
    printf("backend_flag%d = 'ALLOW_TO_FAILOVER'\n", i);
	i = i + 1;
}
