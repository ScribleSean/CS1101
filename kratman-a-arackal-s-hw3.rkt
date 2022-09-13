;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname kratman-a-arackal-s-hw3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;;Homework #3

;;Merchandise is a (make-Merchandise (String String Boolean Number Number))
;;name is the name of the various item sold, 
;;kind is the kind (action figure, board game, costume, manga/comic book, trading card, etc.) of  item sold
;;autographed? shows whether or not the item is autographed
;;quantity is the quantity of items sold
;;price is the price of a single item
(define-struct Merchandise (make-Merchandise name kind autographed? quantity price))

;;Merchandise-func: Merchandise ... --> ...
#;(define (Merchandise-func a-Merchandise ...)
  ...(Merchandise-name a-Merchandise)...
  ...(Merchandise-kind a-Merchandise)...
  ...(Merchandise-autographed? a-Merchandise)...
  ...(Merchandise-quantity a-Merchandise)...
  ...(Merchandise-price a-Merchandise)...)