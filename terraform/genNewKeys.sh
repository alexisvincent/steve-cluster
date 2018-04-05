ssh-keygen -f id_rsa

cp id_rsa ~/.ssh/
cp id_rsa.pub ~/.ssh/

ssh-add ~/.ssh/id_rsa
ssh-add -L

sed 's/^/ssh_authorized_key = "/;s/$/"/' -i id_rsa.pub
awk 'NR==FNR { a[n++]=$0; next } 
/ssh_authorized_key =/ { for (i=0;i<n;++i) print a[i]; next }
1' id_rsa.pub terraform.tfvars > tmp && mv tmp terraform.tfvars

rm id_rsa
rm id_rsa.pub
