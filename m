Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37E33FF20E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbhIBRGy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 13:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346502AbhIBRGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Sep 2021 13:06:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E2E76108B;
        Thu,  2 Sep 2021 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630602353;
        bh=e+/AnjT8Zm8uH3uMK3iOwFv19CcJkeFgN8UNRXpyv0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XK3oraMhYfMxHvTq2ofye0fkFiQ5BC7i7jw8k2mhUcjS+gXuuohitLViAgvxiO31z
         Zf+9YUVXaT5QxbyEAS3NQIrn67/KP72OKi8Gg9OcwTASfntcOAuNom01yN0CaE0zmz
         dnkNWFxvPjXbPfscOOqtQbg2bgnZnnrh3LbiaOTWsRjDErI1K2OnlxnjW/SRe8Uj2q
         DefFdm64BFQEol6Igf1rV1ohXeGIfJYK2dM9qDLDib7jSuRdxaTGDvIGpbMvDMR0Re
         9T9Zysz1KygtJX7iR3lha2arGnqtzShWvgDxQQx6IjRPYcjKC4iM3+hQOQ5g1Cq9u4
         TiXFG/UpA4ZVw==
Date:   Thu, 2 Sep 2021 12:05:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vishal Aslot <os.vaslot@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: ibmphp: Fix double unmap of io_mem
Message-ID: <20210902170552.GA345124@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818165751.591185-1-os.vaslot@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, author of the TODO you refer to]

On Wed, Aug 18, 2021 at 11:57:51AM -0500, Vishal Aslot wrote:
> ebda_rsrc_controller() calls iounmap(io_mem) on the error path. It's
> caller, ibmphp_access_ebda() also calls iounmap(io_mem) on good and
> error paths. Removing the iounmap(io_mem) invocation inside
> ebda_rsrc_controller().
> 
> Signed-off-by: Vishal Aslot <os.vaslot@gmail.com>

Applied to pci/hotplug for v5.15, thanks!

I also removed the item from the TODO list, so the patch looks like
this:

commit faa2e05ad0dc ("PCI: ibmphp: Fix double unmap of io_mem")
Author: Vishal Aslot <os.vaslot@gmail.com>
Date:   Wed Aug 18 11:57:51 2021 -0500

    PCI: ibmphp: Fix double unmap of io_mem
    
    ebda_rsrc_controller() calls iounmap(io_mem) on the error path. Its caller,
    ibmphp_access_ebda(), also calls iounmap(io_mem) on good and error paths.
    
    Remove the iounmap(io_mem) invocation from ebda_rsrc_controller().
    
    [bhelgaas: remove item from TODO]
    Link: https://lore.kernel.org/r/20210818165751.591185-1-os.vaslot@gmail.com
    Signed-off-by: Vishal Aslot <os.vaslot@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index a32070be5adf..cc6194aa24c1 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -40,9 +40,6 @@ ibmphp:
 
 * The return value of pci_hp_register() is not checked.
 
-* iounmap(io_mem) is called in the error path of ebda_rsrc_controller()
-  and once more in the error path of its caller ibmphp_access_ebda().
-
 * The various slot data structures are difficult to follow and need to be
   simplified.  A lot of functions are too large and too complex, they need
   to be broken up into smaller, manageable pieces.  Negative examples are
diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 11a2661dc062..7fb75401ad8a 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -714,8 +714,7 @@ static int __init ebda_rsrc_controller(void)
 		/* init hpc structure */
 		hpc_ptr = alloc_ebda_hpc(slot_num, bus_num);
 		if (!hpc_ptr) {
-			rc = -ENOMEM;
-			goto error_no_hpc;
+			return -ENOMEM;
 		}
 		hpc_ptr->ctlr_id = ctlr_id;
 		hpc_ptr->ctlr_relative_id = ctlr;
@@ -910,8 +909,6 @@ static int __init ebda_rsrc_controller(void)
 	kfree(tmp_slot);
 error_no_slot:
 	free_ebda_hpc(hpc_ptr);
-error_no_hpc:
-	iounmap(io_mem);
 	return rc;
 }
 
> ---
> 
> Why am I fixing this?
> I found this clean up item in drivers/pci/hotplug/TODO [lines 43-44]
> and decided to fix it. This is my 2nd patch ever in linux so my
> apologies for any style issues. I am very teachable. :)
> 
>  drivers/pci/hotplug/ibmphp_ebda.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
> index 11a2661dc062..7fb75401ad8a 100644
> --- a/drivers/pci/hotplug/ibmphp_ebda.c
> +++ b/drivers/pci/hotplug/ibmphp_ebda.c
> @@ -714,8 +714,7 @@ static int __init ebda_rsrc_controller(void)
>  		/* init hpc structure */
>  		hpc_ptr = alloc_ebda_hpc(slot_num, bus_num);
>  		if (!hpc_ptr) {
> -			rc = -ENOMEM;
> -			goto error_no_hpc;
> +			return -ENOMEM;
>  		}
>  		hpc_ptr->ctlr_id = ctlr_id;
>  		hpc_ptr->ctlr_relative_id = ctlr;
> @@ -910,8 +909,6 @@ static int __init ebda_rsrc_controller(void)
>  	kfree(tmp_slot);
>  error_no_slot:
>  	free_ebda_hpc(hpc_ptr);
> -error_no_hpc:
> -	iounmap(io_mem);
>  	return rc;
>  }
>  
> -- 
> 2.27.0
> 
