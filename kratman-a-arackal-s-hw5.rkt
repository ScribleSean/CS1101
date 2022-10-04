;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname kratman-a-arackal-s-hw5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;;Homework #5

;; Part 1: Hierarchies


;;Question 1


(define-struct river (name ph bloom? tributaries))
;;River is a (make-river String Number Boolean ListOfRiver)
;;interp: represents a river along with it's tributaries
;;name is a String that represents the rivers name
;;ph is Number that represents the ph of the water
;;bloom? is a Boolean that represents whether or not the river has algal blooms present
;;tributaries is a ListOfRiver that represents the tributaries of the river



;; ListOfRiver is one of
;; empty
;; (cons River ListOfRiver)


;; Question 2


(define RIVERTREE
  (make-river "River0" 13 false
              (list (make-river "River1" 10 false empty)
                    (make-river "River2" 2 false
                                (list (make-river "River3" 12 false empty))))))

(define LAKETREE
  (make-river "Lake0" 1 true
              (list (make-river "Lake1" 2 true
                                (list (make-river "Lake1a" 2 true empty)
                                      (make-river "Lake2b" 2 true empty)
                                      (make-river "Lake1c" 2 false
                                                  (list (make-river "Lake1ca" 2 false empty)))))
                    (make-river "Lake2" 3 false empty)
                    (make-river "Lake3" 4 false empty))))


;; Question 3


; ;; river-fcn:  River ->
; ;;
; (define (river-fcn a-river)
;   (...  (river-name a-river)
;         (river-ph a-river)
;         (river-bloom? a-river)
;         (lop-fcn (river-tributaries a-river))))
; 
; 
; ;; lop-fcn:  ListOfRiver ->
; ;;
; (define (lop-fcn alor)
;   (cond [(empty? alor) (...)]
;         [(cons? alor)  (...  (river-fcn (first alor))
;                              (lop-fcn (rest alor)))]))


;; Question 4


;;signature purpose of helper
(define (alkaline-river-list alor)
  (cond [(empty? alor) empty]
        [(cons? alor) (cons (list-alkaline-rivers (first alor))
                            (alkaline-river-list (rest alor)))]))

;;signature purpose
(define (list-alkaline-rivers a-river)
  (if (>= (river-ph a-river) 9.5)
      (cons (river-name a-river) (alkaline-river-list (river-tributaries a-river)))
      (alkaline-river-list (river-tributaries a-river))))

(check-expect (list-alkaline-rivers RIVERTREE) (list "River0" (list "River1") (list (list "River3"))))


;; Question 5


;;algae-free-helper? signature
;;helper purpose.
(define (algae-free-helper? a-lor)
  (cond [(empty? a-lor) true]
        [(cons? a-lor) (and (algae-free? (first a-lor))
                            (algae-free-helper? (rest a-lor)))]))


;;algae-free? River -> Boolean 
;;consumes a River and returns a boolean;
;;true if no river in the system has an algal bloom and false if any rivers in the systems have algal blooms.
(define (algae-free? a-river)
  (if (river-bloom? a-river)
      false
      (algae-free-helper? (river-tributaries a-river))))

(check-expect (algae-free? (make-river "Blooming River" 12 true empty)) false)
(check-expect (algae-free? RIVERTREE) true)


;; Question 6


;;signature purpose of helper
(define (raise-all-ph-list alor)
  (cond [(empty? alor) empty]
        [(cons? alor) (cons (raise-all-ph (first alor))
                            (raise-all-ph-list (rest alor)))]))
;;check-expect helper

;;signature purpose
(define (raise-all-ph a-river)
  (make-river (river-name a-river)
              (+ (river-ph a-river) 0.5)
              (river-bloom? a-river)
              (raise-all-ph-list (river-tributaries a-river))))

(check-expect (raise-all-ph RIVERTREE)
              (make-river "River0" 13.5 false
                          (list (make-river "River1" 10.5 false empty)
                                (make-river "River2" 2.5 false
                                            (list (make-river "River3" 12.5 false empty))))))
;;check-expect


;; Question 7


;signature purpose helper
(define (browse-river name alor)
  (cond [(empty? alor) false]
        [(cons? alor) (if (not (false? (find-subsystem name (first alor))))
                          (find-subsystem name (first alor))
                          (browse-river name (rest alor)))]))

(check-expect (browse-river "River1" empty) false)

;;signature purpose
(define (find-subsystem name a-river)
  (if (string=? name (river-name a-river))
      a-river
      (browse-river name (river-tributaries a-river))))

(check-expect (find-subsystem "River3" RIVERTREE) (make-river "River3" 12 false empty))




;; Part 2: Higher Order Functions


(define-struct merchandise (name kind autographed? quantity price))
;; a Merchandise is a (make-merchandise String String Boolean Natural Number)
;; interp:
;; Merchandise represents an item sold at a pop culture emporium, where
;; name is the name of the merchandise item
;; kind indicates whether the item is an action figure, board game, costume,
;; manga/comic book, trading card, etc.
;; autographed? is true if the item is autographed
;; quantity is the number of that item that is being purchased
;; price is the cost of a single item


;; a Receipt (ListOfMerchandise) is one of
;; empty, or
;; (cons Merchandise Receipt)

(define BUZZ (make-merchandise "Buzz Lightyear" "action figure" false 340 6.99))
(define ONUW (make-merchandise "One Night Ultimate Werewolf" "board game" false 720 12.99))
(define JETER (make-merchandise "Derek Jeter 1996 Yankees Bronze" "trading card" true 12 899.99))
(define Receipt1 (list BUZZ ONUW JETER))


;; Question 8


;;bargain-items: ListOfMerchandise -> ListOfString
;;consumes a list of merchandise items and produces a list of the names
;;of all the items with prices under $10.
(define (bargain-items alom)
  (local [(define (bargain-items-helper alom) (> (merchandise-price alom) 10))]
  (map merchandise-name (filter bargain-items-helper alom))))

(check-expect (bargain-items empty) empty)
(check-expect (bargain-items Receipt1)  (list "One Night Ultimate Werewolf" "Derek Jeter 1996 Yankees Bronze"))


;; Question 9


;;any-of-kind?: ListOfMerchandise String -> Boolean
;;consumes a ListOfMerchandise and a kind of merchandise item produces
;;true if there is an item of that kind in the ListOfMerchandise

(define (any-of-kind? alom type)
  (local [(define (merch-kind? alom) (string=? type (merchandise-kind  alom)))]
    (ormap merch-kind? alom)))


(check-expect (any-of-kind? empty "trading card") false)
(check-expect (any-of-kind? Receipt1 "action figure") true)
(check-expect (any-of-kind? Receipt1 "costume") false)


;; Question 10


;;list-cheap-autograph: ListOfMerchandise Number -> ListOfMerchandise
;;consumes a list of merchandise items and returns a list of those
;;autographed items that cost at most the given amount

(define (list-cheap-autograph alom cost)
  (local [(define (cheap-auto? a-merch) (<= (merchandise-price a-merch) cost))]
    (filter cheap-auto? alom)))

(check-expect (list-cheap-autograph empty 999.99) empty)
(check-expect (list-cheap-autograph Receipt1 12.99) (list BUZZ ONUW))
(check-expect (list-cheap-autograph Receipt1 12.98) (list BUZZ))
