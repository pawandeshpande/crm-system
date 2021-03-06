(in-package :crm-system)
(clsql:file-enable-sql-reader-syntax)

(defun crm-controller-delete-company ()
(if (is-crm-session-valid?)
    (let ((id (hunchentoot:parameter "id")) )
      (delete-crm-company id)
      (hunchentoot:redirect "/list-companies"))
     (hunchentoot:redirect "/login")))


(defun crm-controller-list-companies ()
(if (is-crm-session-valid?)
   (let (( companies (list-crm-companies)))
    (standard-page (:title "List companies")
      (:table :cellpadding "0" :cellspacing "0" :border "1"
     (loop for company in companies
       do (htm (:tr (:td :colspan "3" :height "12px" (str (slot-value company 'name)))
		    (:td :colspan "12px" (:a :href  (format nil  "/delcomp?id=~A" (slot-value company 'row-id)) "Delete"))
		    
		    ))))))
 (hunchentoot:redirect "/login")))

(defun get-login-tenant-id ()
  (hunchentoot:session-value :login-tenant-id))
