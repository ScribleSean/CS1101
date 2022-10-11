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

(check-expect (helper-new-user "Shawn") (list (make-user "Shawn" empty)))

;; add-new-user: String --> (void)
;; adds a new user with given username 
(define (add-new-user username)
  (set! mailsys (helper-new-user username)))
;; EFFECT: May increase the length of the Mail system.

;; Question 4


;;helper-find-user: String ListOfUsername --> Username
;;helper function for helper-send-email to find a username in a given ListOfUsername

(define (helper-find-user recipient-name alou)
 (cond [(empty? alou) (error "username not found")]
       [(cons? alou) (if (string=? recipient-name (user-username (first alou)))
                         (first alou)
                         (helper-find-user recipient-name (rest alou)))]))

(check-expect (helper-find-user "Sean" (list (make-user "Abbey" empty) (make-user "Shawn" empty) (make-user "Sean" empty) (make-user "Shaun" false))) (make-user "Sean" empty))

;;helper-send-email: String String String ListOfUsername --> (void)
;;helper function for send-email-message
(define (helper-send-email sender-name recipient-name email alou)
  (set-user-mailbox! (helper-find-user recipient-name alou)
                     (cons (make-message (helper-find-user recipient-name alou) email false)
                     (user-mailbox (helper-find-user recipient-name alou)))))

;; send-email-message: String String String --> (void)
;; to store a new unread message in the recipient's mailbox.
;;EFFECT: May increase the length of mailsys.
(define (send-email-message sender-name recipient-name email)
  (helper-send-email sender-name recipient-name email mailsys))


;; Question 5


;; helper-get-all-unread-messages: ListOfMessage --> ListOfMessage  
;; helper function for get-all-unread-messages that checks if a message is unread or not and conses it on a list
(define (helper-get-all-unread-messages mailbox)
  (cond [(empty? mailbox) empty]
        [(cons? mailbox)
         (if (boolean=? (message-read? (first mailbox)) false)
             (begin
              (set-message-read?! (first mailbox) true)
             (cons (first mailbox) (helper-get-all-unread-messages (rest mailbox))))
      (helper-get-all-unread-messages (rest mailbox)))]))

(check-expect (helper-get-all-unread-messages (list (make-message "Hope" "Snuff that girl!" true)
                                                    (make-message "Bobby" "This is Urinetown!" false)
                                                    (make-message "Caldwell" "Don't be the bunny." false)))
              (list (make-message "Bobby" "This is Urinetown!" true)
                    (make-message "Caldwell" "Don't be the bunny." true)))
 
 
;; get-all-unread-messages: String -> ListOfMessages
;;  consumes a username and produces a ListOfMessages of unread messages in the user's inbox.
;; EFFECT: all unread messages in the named user's mailbox are set to read.

(define (get-all-unread-messages username)
  (helper-get-all-unread-messages (user-mailbox (helper-find-user username mailsys))))
 
;; check-expects are provided in Question 7


;; Question 6


;; highest-user: String String -> String 
;; helper function for helper-mtm that produces the user with the highest number of messages between two users.

(define (highest-user firstuser seconduser)
  (if (> (length (user-mailbox firstuser)) (length (user-mailbox seconduser)))
      firstuser
      seconduser))

;; helper-mtm: ListOfUser Number -> User
;; helper function for most-total-messages that produces the user with the highest number of messages in the mailsystem.

(define (helper-mtm mailsys acc)
  (cond [(empty? mailsys) acc ]
        [(cons? mailsys) 
                 (helper-mtm (rest mailsys) (highest-user (first mailsys) acc))]))

;; most-total-messages 
;; consumes nothing and produces the user in the mailsystem with the largest number of messages in their mailbox.

(define (most-total-messages)
  (cond [(empty? mailsys) (error "There are no users in this mail system.") ]
  [(cons? mailsys) (helper-mtm mailsys (first mailsys))]))


;; Question 7


;; Test Cases for Question 2
;mailsys
;(add-new-user "Gompei")
;(add-new-user "Attila")
;mailsys

;; Test Cases for Question 4
;mailsys
;(send-email-message "Gompei" "Attila" "Goat big or goat home!")
;mailsys
;(send-email-message "Attila" "Gompei" "You must be quackers!")
;(send-email-message "Gompei" "Attila" "You have goat to be kidding!")
;mailsys


;; Test Cases for Question 5


#;(check-expect (get-all-unread-messages "Attila") (shared ((-1- (make-message -2- "You have goat to be kidding!" true))
                                                          (-2- (make-user "Attila" (list -1- -6-)))
                                                          (-6- (make-message -2- "Goat big or goat home!" true))) (list -1- -6-)))

;; Test Cases for Question 6
;; Starter code says no test cases required.


;; Question 8
;; helpersum: ListOfString Number -> Number
;; produces the sum of the accumilator with the sum of all the lengths in the strings
(define (helpersum a-los acc)
  (cond [(empty? a-los) acc]
        [(cons? a-los) (helpersum (rest a-los) (+ (string-length (first a-los)) acc))]))

(check-expect (helpersum (list "1" "22" "333") 0) 6)
(check-expect (helpersum empty 0) 0)

;; sum-of-string-lengths: ListOfString -> Number
;; consumes a ListOfString and produces the sum of the lengths of the strings in the list.

(define (sum-of-string-lengths a-los)
  (helpersum a-los 0))

(check-expect (sum-of-string-lengths (list "Thr" "Tw" "O")) 6)
(check-expect (sum-of-string-lengths (list "ABCD" "EFGH" "IJKL")) 12) 



;; Question 9

;; helper-one-long-string: ListOfString String -> String
;; helper function for one-long-string which takes in a ListOfString and a string and produces a string
;; of the entire ListOfString accumelated together.

(define (helper-one-long-string a-los acc)
    (cond [(empty? a-los) acc]
        [(cons? a-los) (helper-one-long-string (rest a-los) (string-append acc (first a-los)))]))

(check-expect (helper-one-long-string empty "") "")
(check-expect (helper-one-long-string (list "1" "22" "333") "") "122333")

;; one-long-string: ListOfString -> String
;; consumes a ListOfString and produces one string containing
;; all the strings in the list in the order they appear in the list.  
(define (one-long-string a-los)
  (helper-one-long-string a-los ""))
                                               
(check-expect (one-long-string (list "Alice" "Bob")) "AliceBob")
(check-expect (one-long-string (list "American" "Idiot" "By" "Green" "Day")) "AmericanIdiotByGreenDay")


;; Thank you!