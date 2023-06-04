;; Author: Philipp Kapinos
;; Version: 0.0.2

(defvar m-org-babel-timer nil
"Timer for delaying the execution")

(defun mermaid-org-babel-execute-on-change (beg end _)
  "Execute the current Org Babel code block and update the Mermaid diagram on buffer change."
    (when (and (eq major-mode 'org-mode)
	       (org-in-src-block-p)
	       (string= (org-element-property :language (org-element-context)) "mermaid"))
      (mermaid-org-timer)))
       
(defun mermaid-org-timer ()
  (when m-org-babel-timer
    (cancel-timer m-org-babel-timer))
  (setq m-org-babel-timer (run-with-idle-timer 1 nil #'mermaid-org-babel-execute-and-display)))

(defun mermaid-org-babel-execute-and-display ()
	"Execute the Org Babel code block and display the Mermaid diagram."
    (org-babel-execute-src-block)
    (org-redisplay-inline-images))

(defvar mermaid-org-babel-execute-enabled t
  "Variable for activation/deactivation of `mermaid-org-babel-execute-on-change'.")

(defun mermaid-org-render-toggle ()
  "Function to switch hook `mermaid-org-babel-execute-on-change'."
  (interactive)
  (setq mermaid-org-babel-execute-enabled (not mermaid-org-babel-execute-enabled))
  (if mermaid-org-babel-execute-enabled
      (progn
	(add-hook 'after-change-functions #'mermaid-org-babel-execute-on-change)
	(message "Hook added for auto rendering"))
    (progn
      (remove-hook 'after-change-functions #'mermaid-org-babel-execute-on-change)
      (message "Hook removed for auto rendering"))))

