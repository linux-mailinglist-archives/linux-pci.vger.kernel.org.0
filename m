Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B42F44DAE6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 18:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhKKRDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 12:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhKKRDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 12:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636650051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LvPJ3DPf50AjuLZNIBe+A/f3Y+TOfLYvCDVvaRUOQ0w=;
        b=VpLSFU3nSRhC1uTVQ2u+1wEZ7yBZ3zw/qMbTkCoJrvH2HiIZEpHuzgu7rv6vMONwUgEYBD
        B15mz8uUGzQFSwhFvM87ICdUqa6RFXcYhTAM6b8Nm2MO4KevLyWUM5Zpqim0T6ymZV5/Uh
        xEnHrkAfjnwpq4DKGC9Wuj2iRgjhcK4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-kVAdcbQgMGW2lat_AnkzeQ-1; Thu, 11 Nov 2021 12:00:50 -0500
X-MC-Unique: kVAdcbQgMGW2lat_AnkzeQ-1
Received: by mail-wm1-f72.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so2935709wms.7
        for <linux-pci@vger.kernel.org>; Thu, 11 Nov 2021 09:00:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LvPJ3DPf50AjuLZNIBe+A/f3Y+TOfLYvCDVvaRUOQ0w=;
        b=UaLNbgpYoqzatSn+kW1Xo/bwYuBz4XimiK9J4CYFftDmcFoX8/rdDD6YX8c5R8uNKn
         cbGYBxc+21ZO1rho/NhJq7By2nRlfChaT++e9bL8dpq5X53b924fGfLnHEfRS4fzGSSq
         JnHyz5bnMPX/4L3B0VhV0JaIsuFG0P9rUF4E92KgCxNRNNxgBAYQfqkn6i9w1mW+85z1
         tc95NUHpP0X/5QPsv3FdxJbFEPwMQthm4zh7jW6RuqYAk5EP3EtynrH9Dsd4I2Luebwh
         2orM0y8SwnnpgeUzlKIPHYwYTVXWdumZsBqE2mK3LejG7UT7lCu24HDDoBVPGScCO2+4
         pd2Q==
X-Gm-Message-State: AOAM5323563EMM3owhTDcgYtgV1AJsSPR38Ba7bqsCF5CJN1tsxrBlhP
        iJJL7UUTtuIniqdH4fyMTd1dBUSVuFS9lqvNtadw0RhvaBUP1kvwNnH3myeKQF8bN4VLMGuxQ/l
        vxObG5B24aKkwxNDniJo3
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr10528197wrm.79.1636650048804;
        Thu, 11 Nov 2021 09:00:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvi6BbO2p3v31Oc+9TVb84uceco+hGZ5RzQV4jqofLRZp76P1kQ9PyATS1+sO+pho+vH1fAQ==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr10528172wrm.79.1636650048606;
        Thu, 11 Nov 2021 09:00:48 -0800 (PST)
Received: from redhat.com ([2.55.135.246])
        by smtp.gmail.com with ESMTPSA id k37sm3644050wms.21.2021.11.11.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 09:00:47 -0800 (PST)
Date:   Thu, 11 Nov 2021 12:00:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211111115931-mutt-send-email-mst@kernel.org>
References: <20211111090225.946381-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111090225.946381-1-kraxel@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 10:02:24AM +0100, Gerd Hoffmann wrote:
> The PCIe specification asks the OS to wait five seconds after the
> attention button has been pressed before actually un-plugging the
> device.  This gives the operator the chance to cancel the operation
> by pressing the attention button again within those five seconds.
> 
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

BTW how come it's still taking seconds, not milliseconds?

> Virtual pcie ports are identified by PCI ID.  For now the qemu
> pcie root ports are detected, other hardware can be added easily.
> 
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
> +		} else {
> +			schedule_delayed_work(&ctrl->button_work, 5 * HZ);
> +		}
>  		break;
>  	case BLINKINGOFF_STATE:
>  	case BLINKINGON_STATE:
> -- 
> 2.33.1

