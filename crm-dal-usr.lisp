(in-package :crm-system)
(clsql:file-enable-sql-reader-syntax)
(clsql:def-view-class crm-users ()
  ((row-id
    :db-kind :key
    :db-constraints :not-null
    :type integer
    :initarg row-id)
   (NAME
    :accessor name
    :DB-CONSTRAINTS :NOT-NULL
    :TYPE (string 30)
    :INITARG :name)
   (username
    :ACCESSOR username 
    :type (string 30)
    :initarg :username)
   (password
    :accessor password
    :type (string 30)
    :initarg :password)
   (email
    :accessor email
    :type (string 255)
    :initarg :email)

   (deleted-state
    :type (string 1)
    :void-value "N"
    :initarg :deleted-state)

   (created-by
    :TYPE INTEGER
    :INITARG :created-by)
   (user-created-by
    :ACCESSOR user-created-by
    :DB-KIND :JOIN
    :DB-INFO (:JOIN-CLASS crm-users
                          :HOME-KEY created-by
                          :FOREIGN-KEY row-id
                          :SET NIL))
   (updated-by
    :TYPE INTEGER
    :INITARG :updated-by)
   (user-updated-by
    :ACCESSOR user-updated-by
    :DB-KIND :JOIN
    :DB-INFO (:JOIN-CLASS crm-users
                          :HOME-KEY updated-by
                          :FOREIGN-KEY row-id
                          :SET NIL))
   (tenant-id
    :type integer
    :initarg :tenant-id)
   (COMPANY
    :ACCESSOR users-company
    :DB-KIND :JOIN
    :DB-INFO (:JOIN-CLASS crm-company
	                  :HOME-KEY tenant-id
                          :FOREIGN-KEY row-id
                          :SET T))

   
   (parent-id
    :type integer
    :initarg :parent-id)
   (manager
    :accessor users-manager
    :db-kind :join
    :db-info (:join-class crm_users
                          :home-key parent-id
                          :foreign-key row-id
                          :set nil)))

   
  (:BASE-TABLE crm_users))



