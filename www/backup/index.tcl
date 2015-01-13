ad_page_contract {
    Backup
} {
    
}

set page_title "Backup"

set context [list $page_title]

set path [im_backup_path]
set html ""

if {![file exists $path]} {
    append html "<font color=red>
        Backup path doesn't exist - please correct the
        <a href='/intranet/admin/parameters'>BackupBasePathUnix parameter</a>.
</font>"
}

if [catch {
   set files [glob $path*.gz]
   foreach file [lsort $files] {
     append html "
       <tr>
         <td>  <a href=[file tail $file]>[file tail $file]</a> </td> <td> ([expr [file size $file] / 1000]k) </td> <td> [ns_fmttime [file mtime $file] "%d/%m/%Y - %H:%M:%S"] </td>
      </tr> 
      "
   }


} errmsg] {
	append html "<p>Could not find any files</p>"
	ns_log notice "$errmsg"
}


