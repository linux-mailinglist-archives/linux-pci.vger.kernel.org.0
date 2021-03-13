Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE9339D30
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 10:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhCMJSH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 04:18:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhCMJRy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Mar 2021 04:17:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF3D5ABD7;
        Sat, 13 Mar 2021 09:17:52 +0000 (UTC)
Date:   Sat, 13 Mar 2021 10:17:51 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, mmc@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpadlpar: fix potential drc_name corruption in store
 functions
Message-ID: <20210313091751.GM6564@kitsune.suse.cz>
References: <20210310223021.423155-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310223021.423155-1-tyreld@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 10, 2021 at 04:30:21PM -0600, Tyrel Datwyler wrote:
> Both add_slot_store() and remove_slot_store() try to fix up the drc_name
> copied from the store buffer by placing a NULL terminator at nbyte + 1
> or in place of a '\n' if present. However, the static buffer that we
> copy the drc_name data into is not zeored and can contain anything past
> the n-th byte. This is problematic if a '\n' byte appears in that buffer
> after nbytes and the string copied into the store buffer was not NULL
> terminated to start with as the strchr() search for a '\n' byte will mark
> this incorrectly as the end of the drc_name string resulting in a drc_name
> string that contains garbage data after the n-th byte. The following
> debugging shows an example of the drmgr utility writing "PHB 4543" to
> the add_slot sysfs attribute, but add_slot_store logging a corrupted
> string value.
> 
> [135823.702864] drmgr: drmgr: -c phb -a -s PHB 4543 -d 1
> [135823.702879] add_slot_store: drc_name = PHB 4543°|<82>!, rc = -19
> 
> Fix this by NULL terminating the string when we copy it into our static
> buffer by coping nbytes + 1 of data from the store buffer. The code has
Why is it OK to copy nbytes + 1 and why is it expected that the buffer
contains a nul after the content?

Isn't it much saner to just nul terminate the string after copying?

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index cdbfa5df3a51..cfbad67447da 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -35,11 +35,11 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);
+	&drc_name[nbytes] = '\0';
 
 	end = strchr(drc_name, '\n');
-	if (!end)
-		end = &drc_name[nbytes];
-	*end = '\0';
+	if (end)
+		*end = '\0';
 
 	rc = dlpar_add_slot(drc_name);
 	if (rc)
@@ -66,11 +66,11 @@ static ssize_t remove_slot_store(struct kobject *kobj,
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);
+	&drc_name[nbytes] = '\0';
 
 	end = strchr(drc_name, '\n');
-	if (!end)
-		end = &drc_name[nbytes];
-	*end = '\0';
+	if (end)
+		*end = '\0';
 
 	rc = dlpar_remove_slot(drc_name);
 	if (rc)

Thanks

Michal

> already made sure that nbytes is not >= MAX_DRC_NAME_LEN and the store
> buffer is guaranteed to be zeroed beyond the nth-byte of data copied
> from the user. Further, since the string is now NULL terminated the code
> only needs to change '\n' to '\0' when present.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  drivers/pci/hotplug/rpadlpar_sysfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
> index cdbfa5df3a51..375087921284 100644
> --- a/drivers/pci/hotplug/rpadlpar_sysfs.c
> +++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
> @@ -34,12 +34,11 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	if (nbytes >= MAX_DRC_NAME_LEN)
>  		return 0;
>  
> -	memcpy(drc_name, buf, nbytes);
> +	memcpy(drc_name, buf, nbytes + 1);
>  
>  	end = strchr(drc_name, '\n');
> -	if (!end)
> -		end = &drc_name[nbytes];
> -	*end = '\0';
> +	if (end)
> +		*end = '\0';
>  
>  	rc = dlpar_add_slot(drc_name);
>  	if (rc)
> @@ -65,12 +64,11 @@ static ssize_t remove_slot_store(struct kobject *kobj,
>  	if (nbytes >= MAX_DRC_NAME_LEN)
>  		return 0;
>  
> -	memcpy(drc_name, buf, nbytes);
> +	memcpy(drc_name, buf, nbytes + 1);
>  
>  	end = strchr(drc_name, '\n');
> -	if (!end)
> -		end = &drc_name[nbytes];
> -	*end = '\0';
> +	if (end)
> +		*end = '\0';
>  
>  	rc = dlpar_remove_slot(drc_name);
>  	if (rc)
> -- 
> 2.27.0
> 
