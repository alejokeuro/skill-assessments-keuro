# Answers to questions from "Linux for Bioinformatics"

**Q1. What is your home directory?**

A: `/home/ubuntu`

**Q2. What is the output of this command?**

A: `hello_world.txt`

**Q3. What is the output of each ls command?**

A: `ls my_folder` simply returns nothing, returning control to the prompt; `ls my_folder2` returns `hello_world.txt`.

**Q4. What is the output of each?**

A: Issuing command `ls my_folder*` yields the following result:

```
my_folder:

my_folder2:

my_folder3:
hello_world.txt
```
**Q5. What editor did you use and what was the command to save your file changes?**

A: I used `nano`, and the command to save the changes was `Ctrl+O`.

**Q6. What is the error?**

A: I get the following message: `Permission denied (publickey,gssapi-keyex,gssapi-with-mic)`

**Q7. What was the solution?**

A: The solution consisted in:

1. Once logged as the default user (`ubuntu`), switching to `sudouser`. 
2. Creating the directory `/home/sudouser/.ssh/`
3. Switching back to `ubuntu` user and copying its `authorized_keys` file into `sudouser`'s file. Namely, executing: 
```
$sudo cp .ssh/authorized_keys /home/sudouser/.ssh/authorized_keys 
```
4. After fiddling around with permissions on `/home/sudouser/.ssh` directory and `/home/sudouser/.ssh/authorized_keys` file (by following reccomendations in this answer: https://superuser.com/a/925859 ) I finally managed to connect to the remote server through ssh, using the `sudouser` user. 

**Q8. what does the `sudo docker run` part of the command do? and what does the `salmon swim` part of the command do?**

A: `sudo docker run` is meant to run a command from a docker image (the `combine/salmon` image, in this case). `swim` is a command of the `salmon` application: toghether, `salmon swim` *perform [a] super-secret operation*, according to salmon documentation.

**Q9. What is the output of this command?**

A: First, I get prompted to input `serveruser`'s password. After I do it, I get the message: `serveruser is not in the sudoers file.  This incident will be reported.`

**Q10. What is the output of `flask --version`?**

A: The output is:
```
Python 3.10.6
Flask 2.2.2
Werkzeug 2.2.2
```

**Q11. What is the output of `mamba -V`?**

A: It is:

```
conda 22.9.0
```

**Q12. What is the output of `which python`?**

A: `/home/serveruser/mambaforge/envs/py27/bin/python`

**Q13. What is the output of `which python` now?**

A: `/home/serveruser/mambaforge/bin/python`

**Q14. What is the output of `salmon -h`?**

A: It is a message regarding the salmon tool usage and its available commands.

**Q15. What does the `-o athal.fa.gz` part of the command do?**

A: It's telling `curl` to save the output of the command to be saved into file `athal.fa.gz` in the working directory.

**Q16. What is a `.gz` file?**

A: It is a compressed file, associated with the `gzip` tool.

**Q17. What does the `zcat` command do?**

A: It uncompresses the file and return its content into standard output (the console).

**Q18. what does the `head` command do?**

A: It prints the first lines of a file (or, of the output of another command, as in the present case) to stdout.

**Q19. what does the number `100` signify in the command?**

A: It specifies the number of lines we want to read from the beginning of the file.

**Q20. What is `|` doing?** -- **Hint** using `|` in Linux is called "piping"

A: It is taking `zcat`'s output as `head`'s input. 

**Q21. What is a `.fa` file? What is this file format used for?**

A: It's the fasta file format. It is used to store biological sequence data (aminoacids of nucleotides). Stored sequences are separated by metadata lines, starting with a "`>`" symbol.

**Q22. What format are the downloaded sequencing reads in?**

A: The file format is `.sra`

**Q23. What is the total size of the disk?**

A: 7.6 Gb

**Q24. How much space is remaining on the disk?**

A: 2.2 Gb

**Q25. What went wrong?**

A: I get the message "`storage exhausted while writing file within file system module`" printed on the screen many times. So, apparently I've run out of space when attempting to create a `.fastq` file off the `.sra` file.

**Q26: What was your solution?**

A: To use the `-gzip` option of the fastq-dump tool in order to have the output compressed in a `gzip` file.




