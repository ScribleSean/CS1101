;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname kratman-a-arackal-s-hw4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;; Homework #4


(define TODO 0) ;delete me when finished


;; Question 1


;;Student is a (make-student (String String))
;;name is the name of the student
;;email is the email address of the student
(define-struct student (name email))

(define SEAN (make-student "Sean Arackal" "sarackal@wpi.edu"))
(define ABBEY (make-student "Abigail Kratman" "aekratman@wpi.edu"))
(define BRIAN (make-student "Brian Jin" "bjin@wpi.edu"))
(define MARK (make-student "Mark Zuckerberg" "mzuck@wpi.edu"))


;; A ListOfStudent is one of
;;empty
;;(list Student ListOfStudent)

(define HWGROUP1 (list SEAN ABBEY))
(define HWGROUP2 (list BRIAN MARK))


;;ProjectNode is a (make-projectnode (Number String String ListOfStudent BST BST))
;interp:  represents a project
;;project-id is
;;title is the title of the project
;;advisor is the advisor of the project
;;students is the list of students partaking in the project
;;left is a BST
;;right is a BST

;; a BST is one of
;;   false
;;   ProjectNode
;;INVARIANT:
;;         key > all keys in left subtree
;;         key < all keys in right subtree
;;All keys are unique, i.e. no key appears twice in a BST
(define-struct projectnode (project-id title advisor students left right))


;;Question 2


(define ROBOTICS (make-projectnode 05.1101 "sd" "sd" HWGROUP1
                                   (make-projectnode 03.1101 "sd" "sd" HWGROUP2 false false)
                                   (make-projectnode 08.1101 "sd" "sd" HWGROUP1
                                                     (make-projectnode 06.1101 "sd" "sd" HWGROUP1 false false)
                                                     (make-projectnode 09.1101 "sd" "sd" HWGROUP2 false false))))
                                                     
                                                     
;; 3: TODO write 3 templates in comments for Student, ListOfStudent, BST

;; 4: TODO signature, purpose, code, >=4 tests
(define (any-in-dept? a-bst dept) TODO)

;; 5: TODO signature, purpose, code, tests
(define (drop-student a-bst proj email) TODO)

;; 6: TODO signature, purpose, code, tests
(define (list-projects-in-order-by-id-num a-bst) TODO)

;; 7: TODO signature, purpose, code, >=3 tests
(define (add-project a-bst proj title advisor) TODO)