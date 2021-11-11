Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B944DD50
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 22:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhKKVxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 16:53:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231825AbhKKVxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 16:53:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5810B61452;
        Thu, 11 Nov 2021 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636667421;
        bh=M1FEPZ7fjFY9Eh2rbceS+GiLNn+guidRFW3XxuLsd0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TBAZKpGbPrwpBtFRsQq/5XhWYV7MlstbVm20OtRwDYbbgAuciVWYvGCbLE/NfuSny
         /SZUpKOcpQQDEuDdNj+6hB0zCL5alXlqV8xIdFnHdj5950lAU3GDwDfsqdQd7AO3Rn
         tohwoUP1I5z05WiqtVL/AkYEtLhJaC0EHJWdd4TK+CnZUKSytBAv0VPmDnG8ly0khf
         UL4ZpxkMZ/M58e9BnSDs6R+dYFDuzYHy4A2NK76um0laK0OzGrr5fLy11ZY8x9B6vi
         0CyROc61Bwvx9BKWGHsIGUT53mJnFkbyj6Dygnug7Lkxsll/buPrkt9MTPBjIO2B9M
         /FimHFb2YzdcQ==
Date:   Thu, 11 Nov 2021 15:50:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-pci@vger.kernel.org, mst@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211111215019.GA1332430@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111090225.946381-1-kraxel@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas]

If you update or repost this, please note and follow previous history
of subject lines, e.g., "git log --oneline drivers/pci/hotplug/pciehp*".

On Thu, Nov 11, 2021 at 10:02:24AM +0100, Gerd Hoffmann wrote:
> The PCIe specification asks the OS to wait five seconds after the
> attention button has been pressed before actually un-plugging the
> device.  This gives the operator the chance to cancel the operation
> by pressing the attention button again within those five seconds.

Would be nice to include the specific reference here (spec name,
revision, and section).

> For physical hardware this makes sense.  Picking the wrong button
> by accident can easily happen and it can be corrected that way.
> 
> For virtual hardware the benefits are questionable.  Typically
> users find the five second delay annoying.
> 
> This patch adds the fast_virtual_unplug module parameter to the
> pciehp driver.  When enabled (which is the default) the linux
> kernel will simply skip the delay for virtual pcie ports, which
> reduces the total time for the unplug operation from 6-7 seconds
> to 1-2 seconds.

Include an example of use, e.g., "pci=fast_virtual_unplug" or
whatever.  Also probably update
Documentation/admin-guide/kernel-parameters.txt.

"Virtual" doesn't seem like quite the right descriptor here.  That's
one use case, but I think the parameter should describe the actual
*effect*, not the use case, e.g., something related to the delay after
the attention button.

If it's practical, I think it would be nicer to have a sysfs attribute
instead of a kernel boot parameter.  Then we wouldn't have to reboot
to change this, and it could be generalized to allow arbitrary delays,
i.e., no delay, 5 seconds, or whatever the admin decides.

I really hate the portdrv sysfs structure (pcie004, etc.) though, so I
would avoid putting it there if possible.  I don't know if other
hotplug drivers have similar delays.  If they do, would be nice to at
least have the potential for the mechanism to work for them all, even
if we don't implement it for all of them.

> Virtual pcie ports are identified by PCI ID.  For now the qemu
> pcie root ports are detected, other hardware can be added easily.

s/pcie/PCIe/ in English text and comments (above and below).

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/pci/hotplug/pciehp.h      |  3 +++
>  drivers/pci/hotplug/pciehp_core.c |  5 +++++
>  drivers/pci/hotplug/pciehp_ctrl.c | 11 ++++++++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 69fd401691be..131ffec2e947 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -79,6 +79,7 @@ extern int pciehp_poll_time;
>   * @request_result: result of last user request submitted to the IRQ thread
>   * @requester: wait queue to wake up on completion of user request,
>   *	used for synchronous slot enable/disable request via sysfs
> + * @is_virtual: virtual machine pcie port.
>   *
>   * PCIe hotplug has a 1:1 relationship between controller and slot, hence
>   * unlike other drivers, the two aren't represented by separate structures.
> @@ -109,6 +110,8 @@ struct controller {
>  	unsigned int ist_running;
>  	int request_result;
>  	wait_queue_head_t requester;
> +
> +	bool is_virtual;

Most (but sadly not all) previous similar flags are "unsigned int :1".
None are bool.

>  };
>  
>  /**
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ad3393930ecb..28867ec33f5b 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -227,6 +227,11 @@ static int pciehp_probe(struct pcie_device *dev)
>  		goto err_out_shutdown_notification;
>  	}
>  
> +	if (dev->port->vendor == PCI_VENDOR_ID_REDHAT &&
> +	    dev->port->device == 0x000c)
> +		/* qemu pcie root port */
> +		ctrl->is_virtual = true;
> +
>  	pciehp_check_presence(ctrl);
>  
>  	return 0;
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 529c34808440..119bb11f87d6 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -15,12 +15,17 @@
>  
>  #define dev_fmt(fmt) "pciehp: " fmt
>  
> +#include <linux/moduleparam.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci.h>
>  #include "pciehp.h"
>  
> +static bool fast_virtual_unplug = true;
> +module_param(fast_virtual_unplug, bool, 0644);
> +MODULE_PARM_DESC(fast_virtual_unplug, "Fast unplug (don't wait 5 seconds) for virtual machines.");
> +
>  /* The following routines constitute the bulk of the
>     hotplug controller logic
>   */
> @@ -176,7 +181,11 @@ void pciehp_handle_button_press(struct controller *ctrl)
>  		/* blink power indicator and turn off attention */
>  		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
>  				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
> -		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
> +		if (ctrl->is_virtual && fast_virtual_unplug) {
> +			schedule_delayed_work(&ctrl->button_work, 1);

Why schedule_delayed_work() instead of schedule_work()?  And if
schedule_delayed_work(), why a delay of 1 instead of 0?

> +		} else {
> +			schedule_delayed_work(&ctrl->button_work, 5 * HZ);
> +		}
>  		break;
>  	case BLINKINGOFF_STATE:
>  	case BLINKINGON_STATE:
> -- 
> 2.33.1
> 
