;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname kratman-a-arackal-s-hw4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;;Homework #4


;; Question 1


;; Student is a (make-student (String String))
;;name is the name of the student
;; email is their email address

(define-struct student (name email))


(define ABBEY (make-student "Abbey" "aekratman@wpi.edu"))
(define PJ (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu"))
(define MARIEHEARST (make-student "Marie" "mkhearst@wpi.edu"))
(define SEAN (make-student "Sean" "sarackal@wpi.edu"))
(define MORGAN (make-student "Morgan" "mevasiliou@wpi.edu"))
(define MARIEHOWE (make-student "Marie" "mnhowe@wpi.edu"))
(define PETER (make-student "Peter" "pmhusman@wpi.edu"))

(define OCEAN (make-student "Ocean" "ocrosenberg@wpi.edu"))
(define MISCHA (make-student "Mischa" "mbachinsky@wpi.edu"))
(define NOEL (make-student "Noel" "ngruber@wpi.edu"))
(define CONSTANCE (make-student "Constance" "cblackwood@wpi.edu"))
(define RICKY (make-student "Ricky" "rpotts@wpi.edu"))
(define JANE (make-student "Jane" "jdoe@wpi.edu"))
  

;;A ListOfStudent is one of
;;empty
;;(cons Student ListOfStudent)

;; List examples with students

(define CompSciCrew (list ABBEY SEAN PJ MARIEHEARST))
(define MorganHall (list ABBEY PJ MORGAN MARIEHOWE))
(define LNL (list ABBEY PETER))
(define CHOIR (list OCEAN MISCHA NOEL CONSTANCE RICKY JANE))
(define-struct projectnode (project-id title advisor students left right))


;; a BST is one of
;;   false
;;   ProjectNode
;; a ProjectNode is a (make-projectnode Number String String ListOfStudent BST BST)

;;  interp:  represents a course's aspects.
;;    project-id represents the                              
;;    title represents the title of the project.
;;    advisor represents the teacher of the project.                                 
;;    students represents the students involved in the project.                               
;;    left is the left subtree                              
;;    right is the right subtree                        
;; INVARIANT for a given node:
;; project-id is > all project-id in its left child
;; project-id is < all project-id in its right child
;; the same key never appears twice in the tree

;; Examples of Lists
 
(define LNLPROJ (make-projectnode 46 "Middle" "Prof Cate" LNL
                                  (make-projectnode 45 "SecondSmall" "Prof Benjamin" LNL
                                                   (make-projectnode 43 "FirstSmall" "Prof Thomas" LNL
                                                                     false
                                                                     false)
                                                   false)
                                  (make-projectnode 48 "SecondLarge" "Prof Matthew" LNL
                                                    false
                                                   (make-projectnode 49 "FirstLarge" "Prof Cara" LNL
                                                                     false
                                                                     false))))

(define FROSH (make-projectnode 45.882 "CompSci Lab #2" "Prof Engling" CompSciCrew
                                  (make-projectnode 20 "New Student Orientation" "Prof Liv" MorganHall
                                                   (make-projectnode 10 "Projectionist's Practical" "Prof Thomas" LNL
                                                                     false
                                                                     false)
                                                   false)
                                  (make-projectnode 50 "CompSci Lab #2" "Prof Engling" CompSciCrew
                                                    false
                                                   (make-projectnode 70 "Peter's GPS Homework" "Prof San Martin" LNL
                                                                     false
                                                                     false))))

(define RIDETHECYCLONE (make-projectnode 50 "Space Age Bachelor Man" "Prof Karnak" CHOIR
                                         (make-projectnode 40 "Noel's Lament" "Prof Karnak" CHOIR
                                                           (make-projectnode 35 "What the World Needs" "Prof Karnak" CHOIR
                                                                             false
                                                                             false)
                                                           (make-projectnode 45 "Talia" "Prof Karnak" CHOIR
                                                                             false
                                                                             false))
                                         (make-projectnode 60 "The Ballad of Jane Doe" "Prof Karnak" CHOIR
                                                           false
                                                           (make-projectnode 65 "Sugar Cloud" "Prof Karnak" CHOIR
                                                                             false
                                                                             false))))
                                                           
 

                                         
;; Question 3


;; Student template
;; (define (student-func a-student)
;;         (... (student-name a-student)
;;              (student-email a-student))

;; ListOfStudent template
;(define (student-funct ListOfStudent ...)
 ; (cond [(empty? ListOfStudent) empty ]
  ;      [(cons? ListOfStudent) (... (first ListOfStudent)
   ;                         (receipt-func (rest ListOfStudent)))]))

;; BST template
; (define (fcn-for-bst BST)
;  (cond [(false? BST) empty]
;        [else
;         (... (projectnode-project-id BST)
;              (projectnode-title BST)
;              (projectnode-advisor BST)
;              (projectnode-students BST)
;              (fcn-for-bst (node-left BST))
;              (fcn-for-bst (node-right BST)))]))


;; Question 4 


;; Signature and Purpose:
;;any-in-dept? BST Natural -> Boolean 
;;consumes a BST and a number representing a department produces a boolean dependent on whether or not the rounded-down project ID
;; in the BST matches the given number.


(define (any-in-dept? a-bst dept) 
    (cond [(false? a-bst) false]
          [(projectnode? a-bst)(= (floor (projectnode-project-id a-bst)) dept)]))
 
                          
 
(check-expect (any-in-dept? (make-projectnode 6.009 "Fall Fair" "Prof Marcus" CHOIR false false) 6) true)

(check-expect (any-in-dept?  (make-projectnode 333.22 "Projectionist's Practical" "Prof Thomas" LNL false false) 333) true)

(check-expect (any-in-dept?  (make-projectnode 333.22 "Projectionist's Practical" "Prof Thomas" LNL false false) 600) false)

(check-expect (any-in-dept? FROSH 45) true)

(check-expect (any-in-dept? (make-projectnode 45.882 "CompSci Lab #2" "Prof Engling" CompSciCrew
                                  (make-projectnode 20 "New Student Orientation" "Prof Liv" MorganHall
                                                   (make-projectnode 10 "Projectionist's Practical" "Prof Thomas" LNL false false) false)
                                  (make-projectnode 80 "CompSci Lab #2" "Prof Engling" CompSciCrew false
                                                    (make-projectnode 100 "Peter's GPS Homework" "Prof San Martin" LNL false false))) 87) false)
(check-expect (any-in-dept? false 1) false)


;; Question 5


;; Signature and Purpose (Helper Function):
;;drop-student-from-list: ListOfStudents String -> ListOfStudents 
;;consumes a ListOfStudent and a string representing a student's email; produces a list with
;; the student who's email was given dropped.
           
(define (drop-student-from-list a-los email)
 (cond [(empty? a-los) empty]
          [(cons? a-los)  (if (string-ci=? (student-email (first a-los)) email)
                        (rest a-los) 
                        (cons (first a-los) (drop-student-from-list (rest a-los) email)))]))
  
(check-expect (drop-student-from-list empty "sarackal@wpi.edu") empty)

;; Signature and Purpose:
;;drop-student: BST Number String -> BST 
;;consumes a BST, a project ID, and a string representing a student's email; produces a BST of projects with
;; the student who's email was given dropped from the list of students in the BST.

(define (drop-student a-bst project-id email) 
    (cond [(false? a-bst) false] 
          [(projectnode? a-bst) 
           (cond [(= (projectnode-project-id a-bst) project-id)
                              (make-projectnode
                              (projectnode-project-id a-bst)
                              (projectnode-title a-bst)
                              (projectnode-advisor a-bst)
                              (drop-student-from-list (projectnode-students a-bst) email) ;ref
                              (projectnode-left a-bst)
                              (projectnode-right a-bst))]
 
          
                              [(< (projectnode-project-id a-bst) project-id)
                              (make-projectnode
                                (projectnode-project-id a-bst)
                                (projectnode-title a-bst)
                                (projectnode-advisor a-bst)
                                (projectnode-students a-bst)
                                (projectnode-left a-bst)
                                (drop-student (projectnode-right a-bst) project-id email))]
                                
                              [(> (projectnode-project-id a-bst) project-id)
                                (make-projectnode 
                                (projectnode-project-id a-bst)
                                (projectnode-title a-bst)
                                (projectnode-advisor a-bst)
                                (projectnode-students a-bst)
                                (drop-student (projectnode-left a-bst) project-id email)
                                (projectnode-right a-bst))])])) 
                               
(check-expect (drop-student LNLPROJ 48 "aekratman@wpi.edu")
              (make-projectnode 46 "Middle" "Prof Cate"
                                (list
                                 (make-student "Abbey" "aekratman@wpi.edu")
                                 (make-student "Peter" "pmhusman@wpi.edu"))
                                (make-projectnode 45 "SecondSmall" "Prof Benjamin"
                                                  (list (make-student "Abbey" "aekratman@wpi.edu")
                                                        (make-student "Peter" "pmhusman@wpi.edu"))
                                                  (make-projectnode 43 "FirstSmall" "Prof Thomas"
                                                                    (list (make-student "Abbey" "aekratman@wpi.edu")
                                                                          (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false)
                                                  false)
                                (make-projectnode 48 "SecondLarge" "Prof Matthew"
                                                  (list
                                                   (make-student "Peter" "pmhusman@wpi.edu"))
                                                  false
                                                  (make-projectnode 49 "FirstLarge" "Prof Cara"
                                                                    (list
                                                                     (make-student "Abbey" "aekratman@wpi.edu")
                                                                     (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false))))

(check-expect (drop-student LNLPROJ 45 "aekratman@wpi.edu")
              (make-projectnode 46 "Middle" "Prof Cate"
                                (list
                                 (make-student "Abbey" "aekratman@wpi.edu")
                                 (make-student "Peter" "pmhusman@wpi.edu"))
                                (make-projectnode 45 "SecondSmall" "Prof Benjamin"
                                                  (list
                                                   (make-student "Peter" "pmhusman@wpi.edu"))
                                                  (make-projectnode 43 "FirstSmall" "Prof Thomas"
                                                                    (list
                                                                     (make-student "Abbey" "aekratman@wpi.edu")
                                                                     (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false)
                                                  false)
                                (make-projectnode 48 "SecondLarge" "Prof Matthew"
                                                  (list
                                                   (make-student "Abbey" "aekratman@wpi.edu")
                                                   (make-student "Peter" "pmhusman@wpi.edu"))
                                                  false
                                                  (make-projectnode 49 "FirstLarge" "Prof Cara"
                                                                    (list
                                                                     (make-student "Abbey" "aekratman@wpi.edu")
                                                                     (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false))))
              
(check-expect (drop-student (make-projectnode 6.009 "Peter's GPS Homework" "Prof San Martin" LNL false false) 6.009 "aekratman@wpi.edu")
              (make-projectnode 6.009 "Peter's GPS Homework" "Prof San Martin" (list (make-student "Peter" "pmhusman@wpi.edu")) false false))


(check-expect (drop-student (make-projectnode 333.22 "Projectionist's Practical" "Prof Thomas" LNL false false) 333.22 "aekratman@wpi.edu")
              (make-projectnode 333.22 "Projectionist's Practical" "Prof Thomas" (list (make-student "Peter" "pmhusman@wpi.edu")) false false))

(check-expect (drop-student (make-projectnode 900 "The Saint Cassian Choir Trip" "Prof Marcus" CHOIR false false) 900 "jdoe@wpi.edu")
              (make-projectnode 900 "The Saint Cassian Choir Trip" "Prof Marcus" (list OCEAN MISCHA NOEL CONSTANCE RICKY) false false))


(check-expect (drop-student FROSH 45.882 "aekratman@wpi.edu") (make-projectnode 45.882 "CompSci Lab #2" "Prof Engling"
 (list (make-student "Sean" "sarackal@wpi.edu") (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu") (make-student "Marie" "mkhearst@wpi.edu"))
 (make-projectnode 20 "New Student Orientation" "Prof Liv" (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu") (make-student "Morgan" "mevasiliou@wpi.edu") (make-student "Marie" "mnhowe@wpi.edu"))
  (make-projectnode 10 "Projectionist's Practical" "Prof Thomas" (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu")) false false)
  false)
 (make-projectnode 50 "CompSci Lab #2" "Prof Engling" (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Sean" "sarackal@wpi.edu") (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu") (make-student "Marie" "mkhearst@wpi.edu"))
  false
  (make-projectnode 70 "Peter's GPS Homework" "Prof San Martin" (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu")) false false))))
 
(check-expect (drop-student false 1 "sarackal@wpi.edu") false)

(check-expect (drop-student FROSH 45.882 "sarackal@wpi.edu")
              (make-projectnode 45.882 "CompSci Lab #2" "Prof Engling"
                                (list (make-student "Abbey" "aekratman@wpi.edu")
                                      (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu")
                                      (make-student "Marie" "mkhearst@wpi.edu"))
                                (make-projectnode 20 "New Student Orientation" "Prof Liv"
                                                  (list (make-student "Abbey" "aekratman@wpi.edu")
                                                        (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu")
                                                        (make-student "Morgan" "mevasiliou@wpi.edu")
                                                        (make-student "Marie" "mnhowe@wpi.edu"))
                                                  (make-projectnode 10 "Projectionist's Practical" "Prof Thomas"
                                                                    (list (make-student "Abbey" "aekratman@wpi.edu")
                                                                          (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false)
                                                  false)
                                (make-projectnode 50 "CompSci Lab #2" "Prof Engling"
                                                  (list (make-student "Abbey" "aekratman@wpi.edu")
                                                        (make-student "Sean" "sarackal@wpi.edu")
                                                        (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu")
                                                        (make-student "Marie" "mkhearst@wpi.edu"))
                                                  false (make-projectnode 70 "Peter's GPS Homework" "Prof San Martin"
                                                                          (list (make-student "Abbey" "aekratman@wpi.edu")
                                                                                (make-student "Peter" "pmhusman@wpi.edu"))
                                                                          false
                                                                          false))))


;; Question 6


;; Signature and Purpose:
;;list-projects-in-order-by-id-num: BST -> List ;;of projects???
;;consumes a BST and produces a list of project titles in ascending (least to greatest) order by project ID.

 (define (list-projects-in-order-by-id-num a-bst)
  (cond [(false? a-bst) empty ] 
    [(projectnode? a-bst)
     (append (list-projects-in-order-by-id-num (projectnode-left a-bst))
             (list (projectnode-title a-bst))
                   (list-projects-in-order-by-id-num (projectnode-right a-bst))
                   )]))

 (check-expect (list-projects-in-order-by-id-num LNLPROJ)  (list "FirstSmall" "SecondSmall" "Middle" "SecondLarge" "FirstLarge"))
 (check-expect (list-projects-in-order-by-id-num RIDETHECYCLONE) (list "What the World Needs" "Noel's Lament" "Talia"
                                                                      "Space Age Bachelor Man" "The Ballad of Jane Doe" "Sugar Cloud"))

 
;; Question 7


;; Signature and Purpose:
;;add-project: BST Number String String -> BST 
;;consumes a BST and produces a BST exactly the samw as the original, save for
;; the new project being added to the tree. 


(define (add-project a-bst projnum title advisor) 
  (cond [(false? a-bst) (make-projectnode
                         projnum
                         title
                         advisor
                         empty
                         false
                         false
                         )]
        [(< (projectnode-project-id a-bst) projnum)
         (make-projectnode
          (projectnode-project-id a-bst)
          (projectnode-title a-bst)
          (projectnode-advisor a-bst)
          (projectnode-students a-bst)
          (projectnode-left a-bst)
          (add-project (projectnode-right a-bst) projnum title advisor))]
        [(> (projectnode-project-id a-bst) projnum)
         (make-projectnode
          (projectnode-project-id a-bst)
          (projectnode-title a-bst)
          (projectnode-advisor a-bst)
          (projectnode-students a-bst)
          (add-project (projectnode-left a-bst) projnum title advisor)
          (projectnode-right a-bst))]))



(check-expect (add-project LNLPROJ 90 "Testing" "Prof Abbey")
              (make-projectnode 46 "Middle" "Prof Cate"
                                (list
                                 (make-student "Abbey" "aekratman@wpi.edu")
                                 (make-student "Peter" "pmhusman@wpi.edu"))
                                (make-projectnode 45 "SecondSmall" "Prof Benjamin"
                                                  (list
                                                   (make-student "Abbey" "aekratman@wpi.edu")
                                                   (make-student "Peter" "pmhusman@wpi.edu"))
                                                  (make-projectnode 43 "FirstSmall" "Prof Thomas"
                                                                    (list
                                                                     (make-student "Abbey" "aekratman@wpi.edu")
                                                                     (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false)
                                                  false)
                                (make-projectnode 48 "SecondLarge" "Prof Matthew"
                                                  (list
                                                   (make-student "Abbey" "aekratman@wpi.edu")
                                                   (make-student "Peter" "pmhusman@wpi.edu"))
                                                  false
                                                  (make-projectnode 49 "FirstLarge" "Prof Cara"
                                                                    (list (make-student "Abbey" "aekratman@wpi.edu")
                                                                          (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    (make-projectnode 90 "Testing" "Prof Abbey"
                                                                                      empty
                                                                                      false
                                                                                      false)))))

(check-expect (add-project LNLPROJ 2 "Testing" "Prof Abbey")
              (make-projectnode 46 "Middle" "Prof Cate"
                                (list
                                 (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu"))
                                (make-projectnode 45 "SecondSmall" "Prof Benjamin"
                                                  (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu"))
                                                  (make-projectnode 43 "FirstSmall" "Prof Thomas"
                                                                    (list
                                                                     (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    (make-projectnode 2 "Testing" "Prof Abbey"
                                                                                      empty
                                                                                      false
                                                                                      false)
                                                                    false)
                                                  false)
                                (make-projectnode 48 "SecondLarge" "Prof Matthew"
                                                  (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu"))
                                                  false
                                                  (make-projectnode 49 "FirstLarge" "Prof Cara"
                                                                    (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false))))

(check-expect (add-project FROSH 23 "Attention Please" "Prof Sean")
              (make-projectnode 45.882 "CompSci Lab #2" "Prof Engling"
                                (list (make-student "Abbey" "aekratman@wpi.edu")(make-student "Sean" "sarackal@wpi.edu") (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu") (make-student "Marie" "mkhearst@wpi.edu"))
                                (make-projectnode 20 "New Student Orientation" "Prof Liv"
                                                  (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu") (make-student "Morgan" "mevasiliou@wpi.edu") (make-student "Marie" "mnhowe@wpi.edu"))
                                                  (make-projectnode 10 "Projectionist's Practical" "Prof Thomas"
                                                                    (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu")) false false)
                                                  (make-projectnode 23 "Attention Please" "Prof Sean"
                                                                    empty
                                                                    false
                                                                    false))
                                (make-projectnode 50 "CompSci Lab #2" "Prof Engling"
                                                  (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Sean" "sarackal@wpi.edu") (make-student "Joshua/Penny/PJ" "jalongo@wpi.edu") (make-student "Marie" "mkhearst@wpi.edu"))
                                                  false
                                                  (make-projectnode 70 "Peter's GPS Homework" "Prof San Martin"
                                                                    (list (make-student "Abbey" "aekratman@wpi.edu") (make-student "Peter" "pmhusman@wpi.edu"))
                                                                    false
                                                                    false))))

;;Thank you!!