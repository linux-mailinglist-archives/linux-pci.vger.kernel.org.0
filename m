Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC65641188
	for <lists+linux-pci@lfdr.de>; Sat,  3 Dec 2022 00:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLBXe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 18:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiLBXe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 18:34:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A83101E7
        for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2022 15:34:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAFBA62388
        for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2022 23:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2842BC433D6;
        Fri,  2 Dec 2022 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670024066;
        bh=XGUAQKVXraxBmCaFW8zcXlHEoVVLSsQQbTrHmut9tMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OS788bA5xdpS7TvkRcx0iIXuQ3+YKM7wpXjEieLsI1UtaTsCScp/v+xDWRLhaMv7E
         3AFz5fJmoaQx7rUCtdbsMzWG51OfqMiPMxqAaXuTuDZBi6SDWhyzbBaoRt11DTmu+F
         SW8a7v3lj9PzGKSJbW+jweat34Ci+c9DTpWvuKtu7CHuVkOD4xda/wEPmNj8nL5B62
         Q/OOc5adT2DRLAfNwp3twGUhIU3dPakA1vWxsmM+NBKE8rPCqF4Fnq24C9CXKGVO+O
         ytUzXgS+Fc1dOCsT3eug8ZvnNLYQRNZmRCZcSMMey4db3Y/I6Pk7wcIPVS7KHiflVk
         tXr2Fxesbu5Sg==
Date:   Fri, 2 Dec 2022 17:34:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <20221202233424.GA1070935@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130112221.66612-2-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

On Wed, Nov 30, 2022 at 01:22:20PM +0200, Mika Westerberg wrote:
> A PCI bridge may reside on a bus with other devices as well. The
> resource distribution code does not take this into account properly and
> therefore it expands the bridge resource windows too much, not leaving
> space for the other devices (or functions a multifunction device) and

functions *of* a 

> this leads to an issue that Jonathan reported. He runs QEMU with the
> following topoology (QEMU parameters):

topology

>  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
>  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
>  -device e1000,bus=root_port13,addr=0.1 			\
>  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
>  -device e1000,bus=fun1

If you use spaces instead of tabs above, the "\" will stay lined up
when git log indents.

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

"upstream", although I think I would word this so it's less
PCIe-centric.  IIUC, we just want to account for all the BARs on the
bus, whether they're in bridges, peers in a multi-function device, or
other devices.

> Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 66 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..d456175ddc4f 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1830,10 +1830,68 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 * bridges below.
>  	 */
>  	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> +		bridge = NULL;
> +
> +		/* Find the single bridge on this bus first */
> +		for_each_pci_bridge(dev, bus) {
> +			bridge = dev;
> +			break;
> +		}

If we just remember "bridge" in the loop before this hunk, could we
get rid of the loop here?  E.g.,

  bridge = NULL;
  for_each_pci_bridge(dev, bus) {
    bridge = dev;
    if (dev->is_hotplug_bridge)
      hotplug_bridges++;
    else
      normal_bridges++;
  }

> +
> +		if (WARN_ON_ONCE(!bridge))
> +			return;

Then I think this would be superfluous.

> +		if (!bridge->subordinate)
> +			return;
> +
> +		/*
> +		 * Reduce the space available for distribution by the
> +		 * amount required by the other devices on the same bus
> +		 * as this bridge.
> +		 */
> +		list_for_each_entry(dev, &bus->devices, bus_list) {
> +			int i;
> +
> +			if (dev == bridge)
> +				continue;

Why do we skip "bridge"?  Bridges are allowed to have two BARs
themselves, and it seems like they should be included here.

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
> +				if (!dev_sz)
> +					continue;
> +
> +				pci_dbg(dev, "resource %pR aligned to %#llx\n",
> +					dev_res, (unsigned long long)dev_sz);
> +
> +				if (dev_sz > resource_size(b_res))
> +					memset(b_res, 0, sizeof(*b_res));
> +				else
> +					b_res->end -= dev_sz;
> +
> +				pci_dbg(bridge, "updated available resources to %pR\n",
> +					b_res);
> +			}
> +		}

This only happens for buses with a single bridge.  Shouldn't it happen
regardless of how many bridges there are?

This block feels like something that could be split out to a separate
function.  It looks like it only needs "bus", "io", "mmio",
"mmio_pref", and maybe "bridge".

I don't understand the "bridge" part; it looks like that's basically
to use 4K alignment for I/O windows and 1M for memory windows?
Using "bridge" seems like a clunky way to figure that out.

Bjorn
