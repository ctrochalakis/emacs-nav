;; Copyright 2009 Google Inc. All Rights Reserved.
;;
;; Author: issactrotts@google.com
;;
;; LICENSE
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;      http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.


(load-file "nav.el")


(defmacro nav-assert (expression)
  `(if (not ,expression)
       (throw 'nav-assertion-failed ',expression)))


(progn
  (nav-assert (equal '() (nav-filter '() 'stringp)))
  (nav-assert (equal '("a" "b") (nav-filter '("a" "b") 'stringp)))
  (nav-assert (equal '() (nav-filter '(1) 'stringp))))


(progn
  (nav-assert (string= "" (nav-join "" '())))
  (nav-assert (string= "" (nav-join "--" '())))
  (nav-assert (string= "a" (nav-join "--" '("a"))))
  (nav-assert (string= "aye--bee" (nav-join "--" '("aye" "bee")))))


(progn
  (nav-assert (equal '() (nav-filter-out-boring-filenames '() '())))
  (nav-assert (equal '("a" "b.foo") (nav-filter-out-boring-filenames '("a" "b.foo") '())))
  (nav-assert (equal '("a") (nav-filter-out-boring-filenames '("a" "b.foo") '("\\.foo$")))))


(progn
  (nav-assert (eq nil (nav-dir-files-or-nil "$")))
  (nav-assert (nav-dir-files-or-nil "."))
  (nav-assert (nav-dir-files-or-nil ".."))
  (nav-assert (nav-dir-files-or-nil "/")))


(progn
  (nav-assert (string= "qux" (nav-dir-suffix "/qux/")))
  (nav-assert (string= "qux" (nav-dir-suffix "qux/")))
  (nav-assert (string= "bar" (nav-dir-suffix "/foo/bar/")))
  (nav-assert (string= "bar" (nav-dir-suffix "/foo/bar"))))


(progn
  (nav-assert (string= "" (nav-make-grep-list-cmd "pat" '())))
  (nav-assert (string= "grep -il 'pat' file1 file2"
                       (nav-make-grep-list-cmd "pat" '("file1" "file2")))))
