# Cerebro-FileShare-Lab
In this home lab, I demonstrate folder and file sharing, access permissions (Share-Level Permissions), network drive mapping, and user restrictions within an Active Directory environment populated using a custom X-Men–themed user creation script: [Cerebro-AD-Creator]( https://github.com/AyboFrankOz/Cerebro-AD-Creator)

## Step 0 Tidying Up
Before we start, let’s create an OU for our existing Groups (Executive, Finance, HR, Marketing, Operations, Sales, Security, Technology, All). On Domain Control (DC), go to "Active Directory and Users". Right-click on the domain > New > Organizational Unit
![Active Directory and Users](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/4bf4a3072989040710248bb73e99aeee2d014f63/Images/New%20OU%20and%20Grouping%20(1).PNG)

Type the name of the group, uncheck “Protect container from accidental deletion” and click OK.
![New OU](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/4bf4a3072989040710248bb73e99aeee2d014f63/Images/New%20OU%20and%20Grouping%20(2).PNG)

Select all 9 groups shown below, then drag them into the new OU we just created.
![Moving groups to Groups OU](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/4bf4a3072989040710248bb73e99aeee2d014f63/Images/New%20OU%20and%20Grouping%20(3).PNG)

Active Directory Domain Services will show a warning; click Yes. 
![Moving groups to Groups OU](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/4bf4a3072989040710248bb73e99aeee2d014f63/Images/New%20OU%20and%20Grouping%20(4).PNG)

Now, they are all located under the OU.
![Moving groups to Groups OU](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/4bf4a3072989040710248bb73e99aeee2d014f63/Images/New%20OU%20and%20Grouping%20(5).PNG)

Click on Groups OU, then "Create a new group in the current container". 
![Create a new group](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/4bf4a3072989040710248bb73e99aeee2d014f63/Images/Create%20a%20new%20group.PNG)

Type "Helpdesk" and click OK. This step is important as we will run a script later on. If this group doesn't exist by the time we run the script, it will fail.
![Create a new group](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/New%20OU%20and%20Grouping%20(6).PNG)

Let's add the user with admin rights in this group, in our case, "Frank". Simply right-click on Frank > "Add to a group".
![Adding a user to a group](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Adding%20a%20user%20to%20a%20group%20(1).PNG)

If you don't know where "Frank" is, click on "Find  objects in ADDS".
![Finding a user](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Finding%20a%20user%20(1).PNG)

Make sure "Entire Directory" is selected, type the user's name, Frank, and click on "Find now".
![Finding a user](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Finding%20a%20user%20(2).PNG)

Right-click on the user and "Add to a group".
![Finding a user](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Finding%20a%20user%20(3).PNG)

In the Name field, type Helpdesk. If you don't know the full group name, you can type a partial name, such as hel or helpd, then click the Check Names button. If no other group starts with those letters, the system will automatically complete the full name. If multiple groups match, a list of options will appear — simply select Helpdesk from the list.
![Adding a user to a group](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Adding%20a%20user%20to%20a%20group%20(2).PNG)

## Step 1 Creating Folders

On DC, go to the C Drive, create a folder, and name it "Shared". Right click > New Folder
![Creating folders](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Creating%20folders%20(1).PNG)

Inside the main folder, create the following subfolders manually: Executive, Finance, HR, Marketing, Operations, Sales, Security, Technology, All and Helpdesk.
![Creating folders](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Creating%20folders%20(2).PNG)

or via the script:[Creating 10 folders](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Creating%2010%20folders.ps1)

![Creating folders](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Creating%20folders%20(3).PNG)
![Creating folders](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/b2e62699c3037d3fbf31402ac406557e0af5208e/Images/Creating%20folders%20(4).PNG)

## Step 2 Assigning Access Permissions (Share-Level Permissions)
There are three types of Share-Level Permissions: Read, Change, and Full Control.
+ Users with Read can view files and subfolders, open and read file contents, run executable files, but cannot make any modifications.
+ Users with Change can create new files and folders, edit and modify existing files, delete files and folders, plus the actions that users with Read permission do.
+ Users with Full Control can change permissions on the share, take ownership of files, plus the actions that users with Change permission do.

In this lab, each department will have its own folder, while the Helpdesk is granted **Full Control** over all folders to act as the central management group. The Executives will be granted **Change** permission on all folders. On DC, go to Local Disk > Shared. Right-click on the Executives folder, then "Properties"
![Assigning Users](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/38425b412ef4b20c9e418fde09db057578469368/Images/Assigning%20Access%20(1).PNG)

"Executive properties" will open. Click on the "Sharing" tab, then "Advanced Sharing". A new window will open. Check "Share this folder" option. Click on "Permissions". Permissions window will open. Click on "Add" and another window will open. In this window, we will select the groups that we want to give access to. Type "Executives" and "Helpdesk" and click OK.
![Assigning Users](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/38425b412ef4b20c9e418fde09db057578469368/Images/Assigning%20Access%20(2).PNG)

First, click on "Everyone" then "Remove". Next, click on "Executive" group and check "Allow" option for Change. 
![Assigning Users](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/38425b412ef4b20c9e418fde09db057578469368/Images/Assigning%20Access%20(3).PNG)

Click on "Helpdesk" group and check "Allow" option for Change and Full Control.
![Assigning Users](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/38425b412ef4b20c9e418fde09db057578469368/Images/Assigning%20Access%20(4).PNG)

Now, we have to assign permissions to other groups. For example, the Marketing group should access "Marketing" and "All Employees" folders, but should not access any other folders. Meanwhile, the Executive group and the Helpdesk group should be able to access this "Marketing" folder. If you don't want to give permissions to other groups manually, you can run [Assign Permissions](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/d8dae3bbb17ca304876bb30792603148227e04d8/Assign%20Permissions.ps1) script.

![Permission Script](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/d8dae3bbb17ca304876bb30792603148227e04d8/Images/Permission%20Script%20(1).PNG)

![Permission Script](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/d8dae3bbb17ca304876bb30792603148227e04d8/Images/Permission%20Script%20(2).PNG)

This script automates permission assignment by mapping each department folder to its corresponding security group with read-only access, while granting the "Helpdesk" group **full control** across all folders. It also gives the "Executive" group **Change** permission and removes default inherited permissions for the “Everyone” group.

## Step 3 Verification

As seen below, Hank McCoy (Username: Beast) is Chief Technology Officer and in the Executive Group.
![Testing user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/00796a4f7b7c31fd73c57c148b6eac8559b6f830/Images/Test%20Beast%20(0).PNG)

When he signs in, 
![Testing user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/cd49e9f28d29d416066e203bbfac2706ed0e480b/Images/Test%20Beast%20(1.1).PNG)

He can access all folders. He can access the Executive folder. 
![Testing user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/00796a4f7b7c31fd73c57c148b6eac8559b6f830/Images/Test%20Beast%20(1).PNG)

He can access the Technology folder. 
![Testing user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/00796a4f7b7c31fd73c57c148b6eac8559b6f830/Images/Test%20Beast%20(2).PNG)

He can access the Marketing folder. 
![Testing user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/00796a4f7b7c31fd73c57c148b6eac8559b6f830/Images/Test%20Beast%20(3).PNG)

Meanwhile, Booby Drake (Username: Iceman) is the Creative Marketing Director and in the Marketing Group.
![Testing another user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Test%20Iceman%20(1).PNG)

When he signs in, 
![Testing another user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Test%20Iceman%20(2).PNG)

He can access the Marketing folder.
![Testing another user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Test%20Iceman%20(3).PNG)

But he cannot access the Sales folder.
![Testing another user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Test%20Iceman%20(4).PNG)

## Step 4 Mapping Drive
Mapping a drive is the process of assigning a network shared folder or resource to a drive letter on a user's computer, so it appears like a local drive. Go to File Explorer and right-click on Network > Map network drive
![Mapping a drive](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Mapping%20a%20Drive%20(1).PNG)

Give a drive letter and type the path of the folder or resource, in our case, \\DC01\Marketing > Finish.
![Mapping a drive](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Mapping%20a%20Drive%20(2).PNG)

Once it is done, it will appear under Network Locations when you click "This PC". You can also drag it to the Desktop to create a shortcut to that drive.
![Mapping a drive](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Mapping%20a%20Drive%20(3).PNG)

## Step 5 Restrictions

In real network environments, sharing folders through Active Directory keeps data secure, organized, accessible, and easy to manage across an entire organization. However, sharing large files or using the company storage as personal storage areas can cause several issues if not managed properly, such as network performance, storage space, slow file access, backup time, and version conflicts. Thus, it needs to be carefully managed to avoid performance, storage, and collaboration issues.

We may want to prevent users from uploading large or non-business-related files (such as .mp4 videos) to shared folders. This can be achieved by configuring File Server Resource Manager (FSRM). Let's restrict the "All Employees" folder so users cannot upload MP3 or MP4 files. On the DC, run Server Manager, Manage > Add Roles and Features.
![Setting up FSRM](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/726650acb9c5a6b7b2296686e1c6eab01e81b477/Images/Setting%20up%20FSRM%20(1).PNG)

Wizard will start. Click on "Next" until you see the "Select Server Roles" page. Click on "File Server Resource Manager".
![Setting up FSRM](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/709e5939f48c00a5ad9fb207081ddc9ee71c8172/Images/Setting%20up%20FSRM%20(2).PNG)

Click "Add Features". Proceed with the installation, as we don't have to change any default settings. Once the installation is done, click "Close" to close the wizard. On Server Manager, click on Tools > File Server Resource Manager. 

On FSRM, click on "File Screening Management" under File Server Resource Manager (Local). Then File Screens. Right-click on the blank page and "Create File Screen".
![FSRM Configuration](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/160bce372adda68bc0d848571b0745e6256052bb/Images/FSRM%20Configuration%20(1).PNG)

Click "Browse" for the path you want to restrict, 
![FSRM Configuration](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/160bce372adda68bc0d848571b0745e6256052bb/Images/FSRM%20Configuration%20(2).PNG)

C:\Shared\All Employees, in our case
![FSRM Configuration](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/160bce372adda68bc0d848571b0745e6256052bb/Images/FSRM%20Configuration%20(3).PNG)

Select the appropriate option, "Block Audio and Video Files" in our case
![FSRM Configuration](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/160bce372adda68bc0d848571b0745e6256052bb/Images/FSRM%20Configuration%20(4).PNG)

Click the "Create" button.
![FSRM Configuration](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/160bce372adda68bc0d848571b0745e6256052bb/Images/FSRM%20Configuration%20(5).PNG)

Let's try to upload an MP4 file with Booby Drake (Username: Iceman)
![Testing another user access](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/40b87ff337d873f21d8407a65a1d70fe8979a48a/Images/Test%20Iceman%20(2).PNG)

When the user tries to upload the file to "All Employees" folder...
![Testing FSRM](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/9339dad8869b4f66fd2720177b9ad4f13f8381cf/Images/Test%20FSRM%20(1).PNG)

... access would be denied.
![Testing FSRM](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/9339dad8869b4f66fd2720177b9ad4f13f8381cf/Images/Test%20FSRM%20(2).PNG)

If we go to Event Viewer from Server Manager > Tools > Event Viewer
![Event Viewer Logs](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/6533af84680189794bb415f282f95f19e40fe4cf/Images/Event%20Viewer%20(1).PNG)

Click on "Windows Logs" under "Event Viewer (Local)", then "Application". We can see a Warning that states "The system detected that user Iceman attempted to save an MP4 file on C:\Shared\All Employees on server DC01. This file matches the "Audio and Video Files" file group which is not permitted on the system.
![Event Viewer Logs](https://github.com/AyboFrankOz/Cerebro-FileShare-Lab/blob/aeceeddc700e60ccf4c481957a82b3eb9499e71d/Images/Event%20Viewer%20(2).PNG)
