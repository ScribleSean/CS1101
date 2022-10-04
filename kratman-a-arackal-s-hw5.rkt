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
;;check-expect

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


;;Question 
;; Part 2: Higher Order Functions


;;Question 8



