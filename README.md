# org-mermaid-render
Evaluates org mermaid source blocks automatically and shows the corresponding mermaid diagram in the Org file

Setup:
Install accodrding to https://github.com/arnm/ob-mermaid

Checkout this repo. 

Add the following line to your init.el
```
(load "/your/path/to/org-mermaid-render.el")
(add-hook 'after-change-functions #'mermaid-org-babel-execute-on-change)
```

/your/path/to must be replaced with your local pathing to this repo.

~add hook~ activates the toggle to render your mermaid diagrams automatically. 

to toggle use M-x mermaid-org-render-toggle

