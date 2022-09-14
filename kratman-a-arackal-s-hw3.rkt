;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname kratman-a-arackal-s-hw3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;;Homework #3


;;Question 1


;;Merchandise is a (make-Merchandise (String String Boolean Natural Number))
;;name is the name of the various item sold
;;kind is the kind (action figure, board game, costume, manga/comic book, trading card, etc.) of  item sold
;;autographed? shows whether or not the item is autographed
;;quantity is the quantity of items sold
;;price is the price of a single item
(define-struct Merchandise (name kind autographed? quantity price))

(define BUZZ (make-Merchandise "Buzz Lightyear" "action figure" false 340 6.99))
(define ONUW (make-Merchandise "One Night Ultimate Werewolf" "board game" false 720 12.99))
(define JETER (make-Merchandise "Derek Jeter 1996 Yankees Bronze" "trading card" true 12 899.99))


;;Question 2


;;Merchandise-func: Merchandise ... --> ...
#;(define (Merchandise-func a-Merchandise ...)
  (Merchandise-name a-Merchandise ...)
  (Merchandise-kind a-Merchandise ...)
  (Merchandise-autographed? a-Merchandise ...)
  (Merchandise-quantity a-Merchandise ...)
  (Merchandise-price a-Merchandise ...))


;;Question 3

;;A Reciept is one of
;;empty
;;(cons Merchandise Reciept)
(define Reciept1 (cons BUZZ (cons ONUW empty)))
(define Recipet2 (cons ONUW (cons BUZZ (cons JETER empty))))


;;Question 4


; ;; loc-fcn:  ListOfCourse -> ...
#;(define (loc-fcn aloc)
   (cond [(empty? aloc)  ...]
         [(cons? aloc)  ...
          (loc-helper-fcn (first aloc))
          (loc-fcn (rest aloc))]))


;;Question 5


;;signature
;purpose
(define (list-cheap-autograph aloc COST)
   (cond [(empty? aloc) empty]
         [(cons? aloc)
          (if (and (< (Merchandise-price (first aloc)) COST) (Merchandise-autographed? (first aloc))) ;;helper for (and) required
          (cons (first aloc) (list-cheap-autograph (rest aloc) COST))
          (list-cheap-autograph (rest aloc) COST))]))

(check-expect (list-cheap-autograph Reciept1 999) empty)
(check-expect (list-cheap-autograph Recipet2 999) (cons JETER empty))

