(in-package :crm-system)
(clsql:file-enable-sql-reader-syntax)

  
(defun crm-controller-list-users ()
(if (is-crm-session-valid?)
   (let (( crmusers (list-crm-users)))
     (standard-page (:title "List CRM Users")
       (:h3 "Users")

      (:table :class "table table-striped"  
	      (:thead (:tr (:th "User Name") (:th "Action")))(:tbody
     (loop for crmuser in crmusers
       do (htm (:tr (:td  :height "12px" (str (slot-value crmuser 'name)))
		    (:td :height "12px" (:a :href  (format nil  "/deluser?id=~A" (slot-value crmuser 'row-id)) "Delete")))))))))
   (hunchentoot:redirect "/login")))


(defun crm-controller-new-user ()
 (if (is-crm-session-valid?)
      (standard-page (:title "Add a new User")
	(:h1 "Add a new User")
	(:form :action "/user-added" :method "post" 
	       (:p "Name: "
		   (:input :type "text"  
			   :name "name" 
			   :class "txt")
		   (:p "Username: " (:input :type "text"  
					    :name "username" 
					    :class "txt"))
		   (:p "Password: " (:input :type "password"  
					    :name "password" 
					    :class "password"))
		   (:p "Email: " (:input :type "text"  
					 :name "email" 
					 :class "txt"))

		   ;; Add a drop down list of available roles for the user.
				  
				  
		   (:p (:input :type "submit" 
			       :value "Add" 
			       :class "btn")))))
      (hunchentoot:redirect "/login")))


(defun crm-controller-user-added ()
  (if (is-crm-session-valid?)
      (let  ((name (hunchentoot:parameter "name"))
	     (username (hunchentoot:parameter "username"))
	     (password (hunchentoot:parameter "password"))
	     (email (hunchentoot:parameter "email")))
    
	(unless (and  ( or (null name) (zerop (length name)))
		      ( or (null username) (zerop (length username)))
		      ( or (null password) (zerop (length password)))
		      ( or (null email) (zerop (length email))))		
	  (new-crm-user name username password email (get-login-tenant-id)))
	(hunchentoot:redirect  "/crmindex"))
      (hunchentoot:redirect "/login")))



(defun new-crm-user(name uname passwd email-address tenant-id )
 (if ( is-crm-session-valid?)
	;; if session is valid then go ahead and create the company
    (create-crm-user name uname passwd email-address tenant-id)
     ;; else redirect to the login page
    (hunchentoot:redirect "/login")))


(defun get-login-userid ()
     (hunchentoot:session-value :login-userid))

(defun get-current-login-username ()
  (hunchentoot:session-value :login-username))
