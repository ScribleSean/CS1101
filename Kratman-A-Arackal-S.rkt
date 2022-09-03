;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Kratman-A-Arackal-S) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct date(year month day))
;;date is a (make-date Natural Natural Natural)
;;year: year of release
;;month: month of realease
;day: day of release

(define-struct film (title genre rating running-time opening-date nominations))
;;film is a (make-film String String String Natural Date Natural)
;;title: the title of the film (Up, Luca, Ratatouille)
;;genre: the title of the film (drama, comedy, family)
;;rating: the film's rating.  (G, PG, PG-13)
;;running-time: the running time of the film, in minutes 
;opening-date: the date the film opened at the theater
;;nominations: the number of Oscar (Academy Award) nominations the film received 

;;(define UP-DATE (make-date 2009 05 29))
(define UP (make-film "Up" "Family" "PG" 96 (make-date 2009 05 29) 5))
(define LUCA (make-film "Luca" "Family" "PG" 95 (make-date 2021 06 18) 1))
(define RATTA (make-film "Ratatouille" "Family" "PG" 111 (make-date 2007 06 27) 5))
