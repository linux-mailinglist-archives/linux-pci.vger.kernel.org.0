Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8218D621E48
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 22:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKHVLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 16:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKHVLe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 16:11:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CBF3C6FE
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 13:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5393261796
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 21:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868B8C433D6;
        Tue,  8 Nov 2022 21:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667941892;
        bh=fe8RyaXeCMWVPPuRtO/tR3bFN0DZpW7Rm5LGPyyUTpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vNATASlgCulDQmUW6Upk5NK92gLNBmt4by/A0X7jpw9nWW5qhMtlusBJ7EP8F2RuW
         CtsWRC3MR+I8PcvACAz13ZWjA6QMJic86qD8m6HaB0LXdlD0fwJ/ZUboF5QjXI+lWR
         eEV5nx1TIoDbRb4Su3qOhvbx369RG+NYYFrUzPkBRn8sHoQvwG5vLwQETC+IdiOS1Z
         61mXwxh/KOXlg73HPKy4Dt1TzOPhjhFOKWdztDOkDIiectJYbqfd7GpMXXXsL6rcdf
         d79eLRFEj6cotfQChnoXFo3D7fpAotpJvoXesQaqV/xlNUm9BxR6lOjRmTU9cdZ8PB
         5p0EA2x02/NhA==
Date:   Tue, 8 Nov 2022 15:11:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <20221108211130.GA501583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103103254.30497-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 03, 2022 at 12:32:53PM +0200, Mika Westerberg wrote:
> It is possible to have PCIe switch upstream port a multifunction device.

I can't quite parse this.  I guess the point is that a Switch Upstream
Port may be one of the functions of a multifunction device?

> The resource distribution code does not take this into account properly
> and therefore it expands the upstream port resource windows too much,
> not leaving space for the other functions (in the multifunction device)
> and this leads to an issue that Jonathan reported. He runs QEMU with
> the following topoology (QEMU parameters):
> 
>  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
>  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
>  -device e1000,bus=root_port13,addr=0.1 			\
>  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
>  -device e1000,bus=fun1
> 
> The first e1000 NIC here is another function in the switch upstream
> port. This leads to following errors:
> 
>   pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
>   pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
>   pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
>   e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> 
> Fix this by taking into account the possible multifunction devices when
> uptream port resources are distributed.

Can you include the link to Jonathan's report?

> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Hi,
> 
> This is the formal patch that resulted from the discussion here:
> 
> https://lore.kernel.org/linux-pci/20220905080232.36087-5-mika.westerberg@linux.intel.com/T/#m724289d0ee0c1ae07628744c283116e60efaeaf1
> 
> Only change from that version is that we loop through all resources of
> the multifunction device.
> 
>  drivers/pci/setup-bus.c | 63 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..c8787b187ee4 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1830,10 +1830,65 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 * bridges below.
>  	 */
>  	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> +		/* Upstream port must be the first */

Do you have any citation or reasoning for this handy?  We had this
assumption before, and it seems true that an Upstream Port must be
Function 0 because a variety of Link-related things have to be in
Function 0, e.g., ARI ASPM Control, ARI Clock PM, Autonomous Width
Disable, Flit Mode Disable, LTR Enable, OBFF Enable, etc.  But those
are all pretty oblique.

I guess it's better to have the comment than not, but is the sort of
assertion that makes one wonder why it is true.

> +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> +		if (!bridge->subordinate)
> +			return;
> +
> +		/*
> +		 * It is possible to have switch upstream port as a part
> +		 * of a multifunction device. For this reason reduce the
> +		 * resources occupied by the other functions before
> +		 * distributing the rest.

The space consumed by the peer functions of the Switch Upstream Port
is determined by their BAR sizes, so I don't think we actually reduce
that.

I *think* the point here is to reduce the space available for
distribution by the amount required by the peers of the Switch
Upstream Port, right?  I.e., "mmio" is the amount of space we have to
distribute, and before splitting it across devices on the secondary
bus, we need to save out the space required for peers on the primary
bus.

> +		 */
> +		list_for_each_entry(dev, &bus->devices, bus_list) {
> +			int i;
> +
> +			if (dev == bridge)
> +				continue;
> +
> +			/*
> +			 * It should be multifunction but if not stop
> +			 * the distribution and bail out.
> +			 */
> +			if (!dev->multifunction)
> +				return;

Why do we bother with this?  If there are multiple devices on the bus,
don't we want to consider them all, regardless of whether
dev->multifunction is set?  It seems like a gratuitous check.

> +			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +				const struct resource *dev_res = &dev->resource[i];
> +				resource_size_t dev_sz;
> +				struct resource *b_res;
> +
> +				if (dev_res->flags & IORESOURCE_IO) {
> +					b_res = &io;
> +				} else if (dev_res->flags & IORESOURCE_MEM) {
> +					if (dev_res->flags & IORESOURCE_PREFETCH)
> +						b_res = &mmio_pref;
> +					else
> +						b_res = &mmio;
> +				} else {
> +					continue;
> +				}
> +
> +				/* Size aligned to bridge window */
> +				align = pci_resource_alignment(bridge, b_res);
> +				dev_sz = ALIGN(resource_size(dev_res), align);
> +
> +				pci_dbg(dev, "%pR aligned to %llx\n", dev_res,

%#llx to avoid confusion and match other output.

> +					(unsigned long long)dev_sz);
> +
> +				if (dev_sz >= resource_size(b_res))
> +					memset(b_res, 0, sizeof(*b_res));
> +				else
> +					b_res->end -= dev_sz;
> +
> +				pci_dbg(bridge, "updated available to %pR\n", b_res);
> +			}
> +		}
> +
> +		pci_bus_distribute_available_resources(bridge->subordinate,
> +						       add_list, io, mmio,
> +						       mmio_pref);
>  		return;
>  	}
>  
> -- 
> 2.35.1
> 
