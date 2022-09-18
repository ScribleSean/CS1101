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

;;A Receiept is one of
;;empty
;;(cons Merchandise Receiept)
(define Receipt1 (cons BUZZ (cons ONUW empty)))
(define Receipt2 (cons ONUW (cons BUZZ (cons JETER empty))))


;;Question 4


; ;; lom-fcn:  ListOfMerchandise -> ...
#;(define (lom-fcn alom)
   (cond [(empty? alom)  ...]
         [(cons? alom)  ...
          (lom-helper-fcn (first alom))
          (lom-fcn (rest alom))]))


;;Question 5


;;helper-function
;;
;;purpose

;;list-cheapautograph: ListOfMerchandise Number --> ListOfMerchandise
;To consume a Receiept and return merchandises in that list that are less than a given price and are autographed
(define (list-cheap-autograph alom COST)
   (cond [(empty? alom) empty]
         [(cons? alom)
          (if (and (< (Merchandise-price (first alom)) COST) (Merchandise-autographed? (first alom))) ;;helper for (and) required
          (cons (first alom) (list-cheap-autograph (rest alom) COST))
          (list-cheap-autograph (rest alom) COST))]))

(check-expect (list-cheap-autograph Receipt1 999) empty)
(check-expect (list-cheap-autograph Receipt2 999) (cons JETER empty))


;;Question 6


;;helper-function
;;trading-card? : String --> Boolean
;;purpose
(define (trading-card? merch-type)
  (string=? merch-type "trading card"))

;;count-trading-cards: ListOfMerchandise --> Natural
;;purpose
(define (count-trading-cards alom)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (if (trading-card? (Merchandise-kind(first alom)))
             (+ (Merchandise-quantity (first alom)) (count-trading-cards (rest alom)))
             (count-trading-cards (rest alom)))]))
             
(check-expect (count-trading-cards Receipt2) 12)


;;Question 7


;;receipt-total: ListOfMerchandise --> Number
;;purpose
(define (receipt-total alom)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (+ (* (Merchandise-quantity (first alom)) (Merchandise-price (first alom))) (receipt-total (rest alom)))])) ;;helper here

(check-expect (receipt-total Receipt1) 11729.4)


;Question 8


;;board-games-cost ListOfMerchandise --> Number
;;purpose
(define (board-games-cost alom)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (if (string=? (Merchandise-kind (first alom)) "board game")
             (+ (* (Merchandise-quantity (first alom)) (Merchandise-price (first alom))) (board-games-cost (rest alom))) ;;helper here
             (board-games-cost (rest alom)))]))

(check-expect (board-games-cost Receipt2) 9352.8)


;;Question 9


;;halloween-sale ListOfMerchandise Number --> Number
;;purpose
(define (halloween-sale alom discount)
  (cond [(empty? alom) 0]
        [(cons? alom)
         (if (string=? (Merchandise-kind (first alom)) "costume")
              (+ (* discount (Merchandise-quantity (first alom)) (Merchandise-price (first alom))) (halloween-sale (rest alom) discount))
              (+ (* (Merchandise-quantity (first alom)) (Merchandise-price (first alom))) (halloween-sale (rest alom) discount)))]))

(check-expect (halloween-sale Receipt1 0.25) 11729.4)
             