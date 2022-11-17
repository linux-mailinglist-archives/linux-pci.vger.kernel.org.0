Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF26C62E958
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 00:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKQXKk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 18:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQXKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 18:10:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DABD17883
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 15:10:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD99DB8221B
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 23:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F7DC433D6;
        Thu, 17 Nov 2022 23:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668726636;
        bh=KZ4KEvgXVZYy9Vao28u8QBCp+2ydIWYXoW/oAHNmYIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MvSo79nLGDHwRQAk5orQuYuxc8zcFH7BkOnKyc0HFYxQ+3+rzWnYCkyP6ZgPOkqa5
         e9Cp2Fkp681S3bNz1vvX4mQ0wJ9YQJS3pT6WBi/Qx3LAbur6eRqSGc+Txvwy0/YjOK
         Cy80p+K98PUmYezq0JNATlH/QBwHTCkmY5J7rGOOT6mm64+IXXPnWwHfM6I9M2KvPK
         KFPk7wXCW2eIUR8mcBsttkGZlojiYAi1JhujP+DN4Ls8ZHa4rqKsX4DzdBUsSrNf8y
         iton8yi3b1XARLcpIGEJJ43BuVPHD73OMan5ep0TjT1V30fd0sWOpl2cC20oD2rZUn
         /PVaQ+4QgrQ5Q==
Date:   Thu, 17 Nov 2022 17:10:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <20221117231034.GA1227944@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 01:59:52PM +0200, Mika Westerberg wrote:
> PCIe switch upstream port may be one of the functions of a multifunction
> device.

I don't think this is specific to PCIe, is it?  Can't we have a
multi-function device where one function is a conventional PCI bridge?
Actually, I don't think "multi-function" is relevant at all -- you
iterate over all the devices on the bus below.  For PCIe, that likely
means multiple functions of the same device, but it could be separate
devices in conventional PCI.

> The resource distribution code does not take this into account
> properly and therefore it expands the upstream port resource windows too
> much, not leaving space for the other functions (in the multifunction
> device)

I guess the window expansion here is done by adjust_bridge_window()?

> and this leads to an issue that Jonathan reported. He runs QEMU
> with the following topoology (QEMU parameters):
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

To make sure I have this right:

  00:04.0 Root Port; makes [mem 0x10200000-0x103fffff] available on bus 02
  02:00.0 Switch Upstream Port; makes that entire window available on bus 03
  02:00.1 NIC (nothing left for it)

> Fix this by taking into account the possible multifunction devices when
> uptream port resources are distributed.
> 
> Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> The previous version of the series can be found here:
> 
>   https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/
> 
> Changes from v1:
>   * Re-worded the commit message to hopefully explain the problem
>     better
>   * Added Link: to the bug report
>   * Update the comment according to Bjorn's suggestion
>   * Dropped the ->multifunction check
>   * Use %#llx in log format.
> 
>  drivers/pci/setup-bus.c | 56 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..f3f39aa82dda 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1830,10 +1830,58 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 * There is only one bridge on the bus so it gets all available
>  	 * resources which it can then distribute to the possible hotplug
>  	 * bridges below.

This comment might need to be updated (even if there's only one
bridge, we're going to account for other functions in the
multi-function device).

But might we not have other devices on the bus even if they're not in
the same multi-function device?  What if we had this scenario?

  00:1f.0 bridge window [mem 0x10200000-0x103fffff] to [bus 04-05]
  04:00.0 bridge to [bus 05]
  04:01.0 NIC [mem size 0x00020000]
  04:02.0 NIC [mem size 0x00020000]

We can't let 04:00.0 route the entire [mem 0x10200000-0x103fffff]
window to bus 05.

>  	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> +		/* Upstream port must be the first */
> +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> +		if (!bridge->subordinate)
> +			return;
> +
> +		/*
> +		 * It is possible to have switch upstream port as a part of a
> +		 * multifunction device. For this reason reduce the space
> +		 * available for distribution by the amount required by the
> +		 * peers of the upstream port.
> +		 */
> +		list_for_each_entry(dev, &bus->devices, bus_list) {

It seems like maybe we ought to do this regardless of how many bridges
there are on the bus.  Don't we always want to assign space to devices
on this bus before distributing the leftovers to downstream buses?
E.g., maybe this should be done before the adjust_bridge_window()
calls?

> +			int i;
> +
> +			if (dev == bridge)
> +				continue;
> +
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
> +				pci_dbg(dev, "%pR aligned to %#llx\n", dev_res,
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
