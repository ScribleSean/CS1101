;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname kratman-a-arackal-s-hw3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;;Homework #3


;;Question 1


;;Merchandise is a (make-merchandise (String String Boolean Natural Number))
;;name is the name of the various item sold
;;kind is the kind (action figure, board game, costume, manga/comic book, trading card, etc.) of  item sold
;;autographed? shows whether or not the item is autographed
;;quantity is the quantity of items sold
;;price is the price of a single item
(define-struct merchandise (name kind autographed? quantity price))

(define BUZZ (make-merchandise "Buzz Lightyear" "action figure" false 340 6.99))
(define ONUW (make-merchandise "One Night Ultimate Werewolf" "board game" false 720 12.99))
(define JETER (make-merchandise "Derek Jeter 1996 Yankees Bronze" "trading card" true 12 899.99))
(define NEWMUTANTS (make-merchandise "The New Mutants Classic #4" "manga/comic book" true 1 10))
(define BLAIRWITCHCARD (make-merchandise "Blair Witch Trading Card Set" "trading card" true 10 4))
(define DEPARTMENTOFTRUTH (make-merchandise "The Department of Truth #8" "manga/comic book" false 1 4))
(define MONOPOLY (make-merchandise "Monopoly" "board game" false 100 16))
(define GHOSTFACE (make-merchandise "Scream Mask" "halloween costume" false 300 10))


(check-expect NEWMUTANTS (make-merchandise "The New Mutants Classic #4" "manga/comic book" true 1 10)) ;; The expected merchandise struct for the New Mutants comic.
(check-expect JETER (make-merchandise "Derek Jeter 1996 Yankees Bronze" "trading card" true 12 899.99)) ;; The expected merchandise struct for the Derek Jeter trading cards.
(check-expect ONUW (make-merchandise "One Night Ultimate Werewolf" "board game" false 720 12.99)) ;; The expected merchandise struct for the One Night Ultimate Werewolf board games.
(check-expect BUZZ (make-merchandise "Buzz Lightyear" "action figure" false 340 6.99)) ;; The expected merchandise struct for the Buzz Lightyear action figures.
(check-expect BLAIRWITCHCARD (make-merchandise "Blair Witch Trading Card Set" "trading card" true 10 4)) ;; The expected merchandise struct for the Blair Witch trading cards.
(check-expect DEPARTMENTOFTRUTH (make-merchandise "The Department of Truth #8" "manga/comic book" false 1 4)) ;; The expected merchandise struct for the Department of Truth comics.


;;Question 2


;;merchandise-func: Merchandise ... --> ...
#;(define (merchandise-func a-merchandise ...)
  (merchandise-name a-merchandise ...)
  (merchandise-kind a-merchandise ...)
  (merchandise-autographed? a-merchandise ...)
  (merchandise-quantity a-merchandise ...)
  (merchandise-price a-merchandise ...))


;;Question 3


;;A Receiept is one of
;;empty
;;(cons Merchandise Receiept)
(define Receipt1 (list BUZZ ONUW))
(define Receipt2 (list ONUW BUZZ JETER))
(define Receipt3 (list BUZZ JETER ONUW BLAIRWITCHCARD))
(define Receipt4 (list NEWMUTANTS JETER ONUW))
(define Receipt5 (list NEWMUTANTS ONUW JETER BLAIRWITCHCARD DEPARTMENTOFTRUTH))
(define Receipt6 (list BLAIRWITCHCARD ONUW MONOPOLY))
(define Receipt7 (list JETER MONOPOLY GHOSTFACE))


;;Question 4


; ;; lom-fcn:  ListOfMerchandise -> ...
#;(define (lom-fcn alom)
   (cond [(empty? alom)  ...]
         [(cons? alom)  ...
          (merchandise-fcn (first alom))
          (lom-fcn (rest alom))]))


;;Question 5


;;autograph-cheap-check: ListOfMerchandise Number --> Boolean
;;helper-function to see if given Merchandise in a list is autographed and less than a consumed number COST
(define (autograph-cheap-check alom COST)
  (and (< (merchandise-price (first alom)) COST) (merchandise-autographed? (first alom))))

(check-expect (autograph-cheap-check Receipt1 10000) false)
(check-expect (autograph-cheap-check Receipt7 10000) true)
  

;;list-cheapautograph: ListOfMerchandise Number --> ListOfMerchandise
;To consume a Receipt and return merchandises in that list that are less than a given price and are autographed
(define (list-cheap-autograph alom COST)
   (cond [(empty? alom) empty] 
         [(cons? alom)
          (if (autograph-cheap-check alom COST)
          (cons (first alom) (list-cheap-autograph (rest alom) COST))
          (list-cheap-autograph (rest alom) COST))]))
 
(check-expect (list-cheap-autograph Receipt1 999) empty) ;; signed & under $999 in Receipt 1
(check-expect (list-cheap-autograph Receipt2 500) empty)  ;; signed & under $500 in Receipt 2
(check-expect (list-cheap-autograph Receipt2 1000) (list JETER))  ;; signed & under $1000 in Receipt 2
(check-expect (list-cheap-autograph Receipt3 300) (list BLAIRWITCHCARD)) ;; signed & under $300 in Receipt 3
(check-expect (list-cheap-autograph Receipt4 600) (list NEWMUTANTS)) ;; signed & under $600 in Receipt 4
(check-expect (list-cheap-autograph Receipt5 20000) (list NEWMUTANTS JETER BLAIRWITCHCARD)) ;; signed & under $20,000 in Receipt 5
(check-expect (list-cheap-autograph Receipt6 200) (list BLAIRWITCHCARD)) ;; signed & under $200 in Receipt 6
(check-expect (list-cheap-autograph Receipt7 900) (list JETER)) ;; signed & under $900 in Receipt 7




;;Question 6 


 
;;trading-card? : String --> Boolean
;;helper-function to check if given Merchandise-kind is a trading card or not
(define (trading-card? merch-type)
  (string=? merch-type "trading card"))

;;count-trading-cards: ListOfMerchandise --> Natural
;;consumes a receipt and returns the total number of items in the order that are trading cards
(define (count-trading-cards alom)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (if (trading-card? (merchandise-kind(first alom)))
             (+ (merchandise-quantity (first alom)) (count-trading-cards (rest alom)))
             (count-trading-cards (rest alom)))]))

(check-expect (count-trading-cards Receipt1) 0) ;; The total number of trading cards in Receipt 1
(check-expect (count-trading-cards Receipt2) 12) ;; The total number of trading cards in Receipt 2
(check-expect (count-trading-cards Receipt3) 22) ;; The total number of trading cards in Receipt 3
(check-expect (count-trading-cards Receipt4) 12) ;; The total number of trading cards in Receipt 4
(check-expect (count-trading-cards Receipt5) 22) ;; The total number of trading cards in Receipt 5
(check-expect (count-trading-cards Receipt6) 10) ;; The total number of trading cards in Receipt 6
(check-expect (count-trading-cards Receipt7) 12) ;; The total number of trading cards in Receipt 7


;;Question 7


;;merchandise-cost: ListOfMerchandise --> Number
;;helper-function to find the product of the cost and quantity of a given merchandise in a list. Or it's total cost.
(define (merchandise-cost alom)
  (* (merchandise-quantity (first alom)) (merchandise-price (first alom))))

;;receipt-total: ListOfMerchandise --> Number
;;consumes a receipt and produces the total cost of all the merchandise items.
(define (receipt-total alom)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (+ (merchandise-cost alom) (receipt-total (rest alom)))]))

(check-expect (receipt-total Receipt1) 11729.40) ;; The total cost of all merchandise in Receipt 1
(check-expect (receipt-total Receipt2) 22529.28) ;; The total cost of all merchandise in Receipt 2
(check-expect (receipt-total Receipt3) 22569.28) ;; The total cost of all merchandise in Receipt 3
(check-expect (receipt-total Receipt4) 20162.68) ;; The total cost of all merchandise in Receipt 4
(check-expect (receipt-total Receipt5) 20206.68) ;; The total cost of all merchandise in Receipt 5
(check-expect (receipt-total Receipt6) 10992.80) ;; The total cost of all merchandise in Receipt 6
(check-expect (receipt-total Receipt7) 15399.88) ;; The total cost of all merchandise in Receipt 7


;Question 8


;;board-games-cost ListOfMerchandise --> Number
;;finds the total cost of all the board games contained in the receipt
(define (board-games-cost alom)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (if (string=? (merchandise-kind (first alom)) "board game")
             (+ (merchandise-cost alom) (board-games-cost (rest alom)))
             (board-games-cost (rest alom)))]))

(check-expect (board-games-cost Receipt1) 9352.80) ;; The total cost of all the board games in Receipt 1
(check-expect (board-games-cost Receipt2) 9352.80) ;; The total cost of all the board games in Receipt 2
(check-expect (board-games-cost Receipt3) 9352.80) ;; The total cost of all the board games in Receipt 3
(check-expect (board-games-cost Receipt4) 9352.80) ;; The total cost of all the board games in Receipt 4
(check-expect (board-games-cost Receipt5) 9352.80) ;; The total cost of all the board games in Receipt 5
(check-expect (board-games-cost Receipt6) 10952.80);; The total cost of all the board games in Receipt 6
(check-expect (board-games-cost Receipt7) 1600.00) ;; The total cost of all the board games in Receipt 7




;;Question 9


;;halloween-sale: ListOfMerchandise Number --> Number
;;consumes a receipt and a number representing the discount on costume items and produces the total cost of the receipt, with the discount applied only to costume merchandise.
(define (halloween-sale alom discount)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (if (string=? (merchandise-kind (first alom)) "halloween costume")
              (+ (* discount (merchandise-cost alom)) (halloween-sale (rest alom) discount))
              (+ (merchandise-cost alom) (halloween-sale (rest alom) discount)))]))

(check-expect (halloween-sale Receipt1 0.25) 11729.40)  ;; The total cost of all the merchandise in Receipt 1, including a 25% discount on halloween costumes.
(check-expect (halloween-sale Receipt2 0.12) 22529.28)  ;; The total cost of all the merchandise in Receipt 2, including a 12% discount on halloween costumes.
(check-expect (halloween-sale Receipt3 0.62) 22569.28)  ;; The total cost of all the merchandise in Receipt 3, including a 62% discount on halloween costumes.
(check-expect (halloween-sale Receipt4 0.20) 20162.68)  ;; The total cost of all the merchandise in Receipt 4, including a 20% discount on halloween costumes.
(check-expect (halloween-sale Receipt5 0.19) 20206.68)  ;; The total cost of all the merchandise in Receipt 5, including a 19% discount on halloween costumes.
(check-expect (halloween-sale Receipt6 0.50) 10992.80)  ;; The total cost of all the merchandise in Receipt 6, including a 50% discount on halloween costumes.
(check-expect (halloween-sale Receipt7 0.30) 13299.88)  ;; The total cost of all the merchandise in Receipt 7, including a 30% discount on halloween costumes.


;;Thank you!!
 