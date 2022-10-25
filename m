Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACE60CE6E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiJYOIp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiJYOIZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 10:08:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25EA248F2;
        Tue, 25 Oct 2022 07:05:04 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxYZN1Ndmz687w4;
        Tue, 25 Oct 2022 22:03:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:05:01 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 15:05:01 +0100
Date:   Tue, 25 Oct 2022 15:05:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Chris Chiu" <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>, <regressions@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: Regression: Re: [PATCH v2 4/6] PCI: Distribute available
 resources for root buses too
Message-ID: <20221025150500.000059ba@huawei.com>
In-Reply-To: <Y1fYNsjmUFZsvteT@black.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
        <20220905080232.36087-5-mika.westerberg@linux.intel.com>
        <20221014124553.0000696f@huawei.com>
        <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
        <20221014154858.000079f2@huawei.com>
        <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
        <Y1Z2GGgfZyzC2d1N@black.fi.intel.com>
        <Y1fYNsjmUFZsvteT@black.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Oct 2022 15:36:06 +0300
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
> 
> On Mon, Oct 24, 2022 at 02:25:12PM +0300, Mika Westerberg wrote:
> > On Mon, Oct 24, 2022 at 02:13:10PM +0300, Mika Westerberg wrote:  
> > > Hi,
> > > 
> > > On Fri, Oct 14, 2022 at 03:48:58PM +0100, Jonathan Cameron wrote:  
> > > > > Thanks for the detailed report! I wonder if you could try the below
> > > > > patch and see if it changes anything?  
> > > > Thanks for the quick response.
> > > > 
> > > > Doesn't fix it unfortunately.  
> > > 
> > > I'm back now.
> > > 
> > > Trying to reproduce this with mainline kernel (arm64 defconfig) and the
> > > following command line:
> > > 
> > > qemu-system-aarch64 \
> > >         -M virt,nvdimm=on,gic-version=3 -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
> > >         -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
> > >         -nographic -no-reboot  \
> > >         -kernel Image \
> > >         -initrd rootfs.cpio.bz2 \
> > >         -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2 \
> > >         -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
> > >         -device e1000,bus=root_port13,addr=0.1 \
> > >         -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3 \
> > >         -device e1000,bus=fun1
> > > 
> > > But the resulting PCIe topology is pretty flat:
> > > 
> > > # lspci
> > > 00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
> > > 00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device
> > > 
> > > I wonder what I'm missing here? Do I need to enable additional drivers
> > > to get the topology to resemble yours?  
> > 
> > Nevermind, I was missing one \ in the command line ;-) Now I can see the
> > topology similar to yours.  
> 
> I think I know what the problem is now - there is a multifunction device
> with the switch upstream port and the resource distribution code is not
> prepared to handle such (not sure how common this is in real hardware
> but allowed by the PCIe spec).
> 
> Simple fix would be just ignore all resource distribution if we
> encounter such topologies but I think can still allow it, just by
> accounting the resources reserved for the multifunction device(s).
> 
> Can you try on your side so that you revert this revert:
> 
>   5632e2beaf9d ("Revert "PCI: Distribute available resources for root buses, too"")
> 
> and then apply the below patch and see if the problem goes away? Thanks!

Looks good on my more complex setup that I originally hit this problem on.

A comment on the comment inline.

> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index dc6a30ee6edf..a7ca3fecf259 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1833,10 +1833,65 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 * bridges below.
>  	 */
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
> +		 * It is possible to have switch upstream port as a part
> +		 * of multifunction device, although not too common. For
> +		 * this reason reduce the resources occupied by the
> +		 * other functions before distributing the rest.
> +		 */

I 'think' it's quite common. I don't have one to hand but
drivers/pci/switches/switchtec.c has drivers for a management function that I
think are an additional function alongside the USP on a wide range of
switch chips.  It's possible those actually sit on their own port though or
pretend to be below a DSP.

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
> +
> +			for (i = 0; i < PCI_ROM_RESOURCE; i++) {
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
> +					dev_sz);
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

