;; Author: Philipp Kapinos
;; Version: 0.0.1

(defvar m-org-babel-timer nil
"Timer for delaying the execution")

(defun mermaid-org-babel-execute-on-change (beg end _)
	"Execute the current Org Babel code block and update the Mermaid diagram on buffer change."
    (when (and (eq major-mode 'org-mode)
	       (org-in-src-block-p)
	       (string= (org-element-property :language (org-element-context)) "mermaid"))
        (when m-org-babel-timer
			(cancel-timer m-org-babel-timer))
        (setq m-org-babel-timer (run-with-idle-timer 1 nil
			#'mermaid-org-babel-execute-and-display beg end))))

(defun mermaid-org-babel-execute-and-display (beg end)
	"Execute the Org Babel code block and display the Mermaid diagram."
    (org-babel-execute-src-block)
    (org-redisplay-inline-images))

(add-hook 'after-change-functions #'mermaid-org-babel-execute-on-change)
