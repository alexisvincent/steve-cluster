ssh-keygen -f /home/core/.ssh/id_rsa

sed 's/^/ssh_authorized_key = "/;s/$/"/' -i /home/core/.ssh/id_rsa.pub
awk 'NR==FNR { a[n++]=$0; next } 
/ssh_authorized_key =/ { for (i=0;i<n;++i) print a[i]; next }
1' /home/core/.ssh/id_rsa.pub terraform.tfvars > tmp && mv tmp terraform.tfvars
