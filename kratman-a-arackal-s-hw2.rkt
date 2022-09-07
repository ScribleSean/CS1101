;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname kratman-a-arackal-s-hw2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Names: Abigail Kratman & Sean Arackal
;; WPI Usernames: aekratman & sarackal
;;Homework #2

;;Tornado is a (make-tornado (String Number Number))
;;scale is its Fujita scale rating ("F0", "F1", ... , "F5")
;;distance is the distance it travels (in miles)
;;max-winds is the maximum sustained wind in miles per hour
(define-struct tornado (scale distance max-winds))


;;hurricane is a (make-hurricane (String Natural Number Number String))
;;name is
;;category is
;;max-winds is
;;velocity is
;;heading is
(define-struct hurricane (name category max-winds velocity heading))

;;thunderstorm is a (make-thunderstorm (String Number Number Number))
;;heading is
;;velocity is
;;rainfall is
;;max-winds is
(define-struct thunderstorm (heading velocity rainfall max-winds))
