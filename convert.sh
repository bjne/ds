csv2ds --compress-gz --compress-level=9 --extent-size=100000 --xml-desc-file=weblog_ds.xml --null-string="[NULL]" --field-separator=0x09 in.csv out.ds
ds2txt --select weblog src_addr --header-only-once --where weblog 'request_uri != "/"' out.ds
dsstatgroupby weblog basic 'request_size' group by referer from out.ds
