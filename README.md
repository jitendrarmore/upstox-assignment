# upstox-assignment

1. Create a “daemon supervisor”. This tool should check that the process is running and at all times and starts it in the case it is down.

It should take these as a parameters:
	- Seconds to wait between attempts to restart service
	- Number of attempts before giving up
	- Name of the process to supervise
	- Check interval in seconds
	- Generate logs in case of events.
Provide the source code and output of supervisor runs for the following examples:
bash -c "sleep 1 && exit 0"
bash -c "sleep 5 && exit 0"
bash -c "sleep 1 && exit 1"
sh -c "sleep 10 && exit 1"
bash -c "if [ -f lock ]; then exit 1; fi; sleep 10 && touch lock && exit 1"
bash -c "if [ -f lock ]; then exit 1; fi; sleep 10 && touch lock && exit 1" (with 1 attempt only)


2. 	Attached you will find a JSON file (meta.json) that contains an array of objects each of which has a "creationTimestamp" field.
i).  Create a script which takes two inputs, number of days and match pattern
ii). After giving input the script should display the count of objects that will match below conditions.
	Objects created before a number of days provided.
	Objects that only match the pattern.


3. Write an ansible script to Harden the linux VM (Cover all the necessary aspects)



