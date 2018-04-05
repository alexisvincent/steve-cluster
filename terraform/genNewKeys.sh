ssh-keygen -f gateway_ssh

cp gateway_ssh ~/.ssh/
cp gateway_ssh.pub ~/.ssh/

sed 's/^/ssh_authorized_key = "/;s/$/"/' -i gateway_ssh.pub
awk 'NR==FNR { a[n++]=$0; next } 
/ssh_authorized_key =/ { for (i=0;i<n;++i) print a[i]; next }
1' gateway_ssh.pub terraform.tfvars > tmp && mv tmp terraform.tfvars

rm gateway_ssh
rm gateway_ssh.pub
