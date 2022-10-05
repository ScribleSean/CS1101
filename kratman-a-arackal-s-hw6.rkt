;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname kratman-a-arackal-s-hw6) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #t)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;; Homework #6


;; Question 1


(define-struct message (username text read?))
;; Message is a (make-message String String Boolean)
;; interp: represents a message.
;; username is a String that represents message sender's username
;; text is a String that represents the text of the message
;; read? is a Boolean that represents whether or not the user has read the message

(define-struct user (username mailbox))
;; User is a (make-user String ListOfMessage)
;; interp: represents a user.
;; username is a String that represents a user's username
;; mailbox is a ListOfMessage that represents 


;; ListOfMessage is one of
;; empty
;; (cons Message ListOfMessage)



;; Question 2


(define mailsys empty) ;;empty email system with no users
(define newuser (make-user "Newuser" empty)) ;;user with name "Newuser" and an empty list of messages


;; Question 3

;; helper-new-user: ListOfString --> ListOfString
;; helper function for add-new-user that conses the new given username to mailsys

(define (helper-new-user username)
  (cons (make-user username empty) mailsys))

;; add-new-user: String --> (void)
;; adds a new user with given username 
(define (add-new-user username)
  (set! mailsys (helper-new-user username)))
;; EFFECT: May increase the length of the Mail system.

(add-new-user "Sean")
(add-new-user "Abbey")


;; Question 4


;;helper-find-user: String ListOfUsername --> Username
;;helper function for helper-send-email to find a username in a given ListOfUsername
(define (helper-find-user recipient-name alou)
 (cond [(empty? alou) (error "username not found")]
       [(cons? alou) (if (string=? recipient-name (user-username (first alou)))
                         (first alou)
                         (helper-find-user recipient-name (rest alou)))]))

;;helper-send-email: String String String ListOfUsername --> (void)
;;helper function for send-email-message
(define (helper-send-email sender-name recipient-name email alou)
  (set-user-mailbox! (helper-find-user recipient-name alou)
                     (cons (make-message (helper-find-user recipient-name alou) email true)
                     (user-mailbox (helper-find-user recipient-name alou)))))

;; send-email-message: String String String --> (void)
;; to store a new unread message in the recipient's mailbox.
(define (send-email-message sender-name recipient-name email)
  (helper-send-email sender-name recipient-name email mailsys))