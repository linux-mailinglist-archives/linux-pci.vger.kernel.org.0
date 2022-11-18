Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00C862F037
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiKRI4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 03:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiKRI4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 03:56:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12A6153C
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 00:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668761810; x=1700297810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kH2Sh7EE7xcTS8i+VAqXPZyLduyKDe3SpSRpBYhTC70=;
  b=Kkg+hHWFyBZPIUJRkhp06Vqlc3hWtvmsH1L/VGGGkoBF6jH1IaAZ8ZiK
   hPABZN13UZcl/O8J3kGhCc/TnerVKsCz+B59com0ZZJnuV1ViC5amL1WT
   jELJ6ZcFfYk+OfiNN/760KuIj7XtP9W4zzDU2z0xofMB1jZz/PmdIFB5b
   0lpmVPgaQdXrWI6C5jxFN0ZaEGb8jp1YQMP+PEGkYv0tSIXXryN0LXAo8
   dljWzok1US+uxUaWMGdWYfdL7GypVmPNl++c3E5yJJYfmBNSC6RmjesvS
   d+MIAT5yB3a/YLK/ddCgOBU6R+hZRCZp3F2EgpfBjb/CiJSGjAgf7tg/n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="311796024"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="311796024"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 00:56:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="745921930"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="745921930"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2022 00:56:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1379C10E; Fri, 18 Nov 2022 10:57:12 +0200 (EET)
Date:   Fri, 18 Nov 2022 10:57:12 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <Y3dI6K8o+j1nE4Lf@black.fi.intel.com>
References: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
 <20221117231034.GA1227944@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221117231034.GA1227944@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 05:10:34PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 14, 2022 at 01:59:52PM +0200, Mika Westerberg wrote:
> > PCIe switch upstream port may be one of the functions of a multifunction
> > device.
> 
> I don't think this is specific to PCIe, is it?  Can't we have a
> multi-function device where one function is a conventional PCI bridge?
> Actually, I don't think "multi-function" is relevant at all -- you
> iterate over all the devices on the bus below.  For PCIe, that likely
> means multiple functions of the same device, but it could be separate
> devices in conventional PCI.

Yes it can be but I was trying to explain the problem we encountered and
that's related to PCIe.

I can leave this out if you think it is better that way.

> > The resource distribution code does not take this into account
> > properly and therefore it expands the upstream port resource windows too
> > much, not leaving space for the other functions (in the multifunction
> > device)
> 
> I guess the window expansion here is done by adjust_bridge_window()?

Yes but the resources are distributed in pci_bus_distribute_available_resources().

> 
> > and this leads to an issue that Jonathan reported. He runs QEMU
> > with the following topoology (QEMU parameters):
> > 
> >  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
> >  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
> >  -device e1000,bus=root_port13,addr=0.1 			\
> >  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
> >  -device e1000,bus=fun1
> > 
> > The first e1000 NIC here is another function in the switch upstream
> > port. This leads to following errors:
> > 
> >   pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
> >   pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
> >   pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
> >   e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> 
> To make sure I have this right:
> 
>   00:04.0 Root Port; makes [mem 0x10200000-0x103fffff] available on bus 02
>   02:00.0 Switch Upstream Port; makes that entire window available on bus 03
>   02:00.1 NIC (nothing left for it)

Correct

> 
> > Fix this by taking into account the possible multifunction devices when
> > uptream port resources are distributed.
> > 
> > Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > The previous version of the series can be found here:
> > 
> >   https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/
> > 
> > Changes from v1:
> >   * Re-worded the commit message to hopefully explain the problem
> >     better
> >   * Added Link: to the bug report
> >   * Update the comment according to Bjorn's suggestion
> >   * Dropped the ->multifunction check
> >   * Use %#llx in log format.
> > 
> >  drivers/pci/setup-bus.c | 56 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 52 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index b4096598dbcb..f3f39aa82dda 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1830,10 +1830,58 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	 * There is only one bridge on the bus so it gets all available
> >  	 * resources which it can then distribute to the possible hotplug
> >  	 * bridges below.
> 
> This comment might need to be updated (even if there's only one
> bridge, we're going to account for other functions in the
> multi-function device).
> 
> But might we not have other devices on the bus even if they're not in
> the same multi-function device?  What if we had this scenario?
> 
>   00:1f.0 bridge window [mem 0x10200000-0x103fffff] to [bus 04-05]
>   04:00.0 bridge to [bus 05]
>   04:01.0 NIC [mem size 0x00020000]
>   04:02.0 NIC [mem size 0x00020000]
> 
> We can't let 04:00.0 route the entire [mem 0x10200000-0x103fffff]
> window to bus 05.

Good point. I will update the comment accordingly.

> >  	if (hotplug_bridges + normal_bridges == 1) {
> > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > -		if (dev->subordinate)
> > -			pci_bus_distribute_available_resources(dev->subordinate,
> > -				add_list, io, mmio, mmio_pref);
> > +		/* Upstream port must be the first */
> > +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > +		if (!bridge->subordinate)
> > +			return;
> > +
> > +		/*
> > +		 * It is possible to have switch upstream port as a part of a
> > +		 * multifunction device. For this reason reduce the space
> > +		 * available for distribution by the amount required by the
> > +		 * peers of the upstream port.
> > +		 */
> > +		list_for_each_entry(dev, &bus->devices, bus_list) {
> 
> It seems like maybe we ought to do this regardless of how many bridges
> there are on the bus.  Don't we always want to assign space to devices
> on this bus before distributing the leftovers to downstream buses?

Yes we do.

> E.g., maybe this should be done before the adjust_bridge_window()
> calls?

With the current code it is clear that we deal with the upstream port.
At least in PCIe it is not allowed to have anything else than downstream
ports on that internal bus so the only case we would need to do this is
the switch upstream port.

Let me know if you still want me to move this before adjust_bridge_window()
I can do that in v3. Probably needs a comment too.
