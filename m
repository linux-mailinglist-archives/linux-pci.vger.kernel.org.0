Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D144F917
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhKNQm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 11:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNQm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 11:42:56 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24002C061746
        for <linux-pci@vger.kernel.org>; Sun, 14 Nov 2021 08:39:59 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 44AB4100D940E;
        Sun, 14 Nov 2021 17:39:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 160972B0CF5; Sun, 14 Nov 2021 17:39:58 +0100 (CET)
Date:   Sun, 14 Nov 2021 17:39:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-pci@vger.kernel.org, mst@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <20211114163958.GA7211@wunner.de>
References: <20211111090225.946381-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111090225.946381-1-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 10:02:24AM +0100, Gerd Hoffmann wrote:
> The PCIe specification asks the OS to wait five seconds after the

The spec reference Bjorn asked for is: PCIe r5.0, sec. 6.7.1.5

> attention button has been pressed before actually un-plugging the
> device.  This gives the operator the chance to cancel the operation
> by pressing the attention button again within those five seconds.
> 
> For physical hardware this makes sense.  Picking the wrong button
> by accident can easily happen and it can be corrected that way.
> 
> For virtual hardware the benefits are questionable.  Typically
> users find the five second delay annoying.

Why does virtual hardware implement the Attention Button if it's
perceived as annoying?  Just amend qemu so that it doesn't advertise
presence of an Attention Button to get rid of the delay.  (Clear the
Attention Button Present bit in the Slot Capabilities register.)

An Attention Button doesn't make any sense for virtual hardware
except to test or debug support for it in the kernel.  Just make
presence of the Attention Button optional and be done with it.

You'll still be able to bring down the slot in software via the
"remove" attribute in sysfs.

Same for the 1 second delay in remove_board().  That's mandated by
PCIe r5.0, sec. 6.7.1.8, but it's only observed if a Power Controller
is present.  So just clear the Power Controller Present bit in the
Slot Capabilities register and the delay is gone.


> @@ -109,6 +110,8 @@ struct controller {
>  	unsigned int ist_running;
>  	int request_result;
>  	wait_queue_head_t requester;
> +
> +	bool is_virtual;
>  };

This is a quirk for a specific device, so please move it further up to the
/* capabilities and quirks */ section of struct controller.


> @@ -227,6 +227,11 @@ static int pciehp_probe(struct pcie_device *dev)
>  		goto err_out_shutdown_notification;
>  	}
>  
> +	if (dev->port->vendor == PCI_VENDOR_ID_REDHAT &&
> +	    dev->port->device == 0x000c)
> +		/* qemu pcie root port */
> +		ctrl->is_virtual = true;
> +

Move this to pcie_init() in pciehp_hpc.c below the existing quirks for
hotplug_user_indicators and is_thunderbolt.


> +static bool fast_virtual_unplug = true;
> +module_param(fast_virtual_unplug, bool, 0644);

An integer parameter to configure a custom delay would be nicer IMO.
Of course, anything else than 5 sec deviates from the spec.

Thanks,

Lukas
