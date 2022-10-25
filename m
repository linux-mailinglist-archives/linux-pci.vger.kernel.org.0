Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29C60CBF3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 14:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiJYMft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiJYMfs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 08:35:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9A1870A0;
        Tue, 25 Oct 2022 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666701347; x=1698237347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NWtuBKIvAI5JY/GHIG0db5ifhbCnkmUNenneTorvLZY=;
  b=TCKFY5m4W8QXM5rqdNBR2H2/PBPR4rZNBS1Xf//CnUEChdxPsPig3e7b
   DDjVH1/g7oj9HqbgDBJirdeVEmtfMvmtlsugbQhWfpLrEP6QhVCVBDQZK
   jGMbD0JfoI+emCRby0k9tWdK4xeuJYRMYCa02ZkGHvXjHcePkGflLFXDF
   3nn/U8I5TtrzUwmAdIq6sy1vxJV0XE1RmcmDptiXJYCOLDlOAvaEvcmxn
   INgGf6Ma7AovC/E+aNiMw/HO+gfvk/YoI8dtypSCndm5HUaUbPLdKRJL+
   C3j77Cub8XCJyW8hCvVRYcMkPM83oLiNWPuc7P10+n4acgtXYI8P6PbHp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290963219"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="290963219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 05:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631614369"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="631614369"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Oct 2022 05:35:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D7909291; Tue, 25 Oct 2022 15:36:06 +0300 (EEST)
Date:   Tue, 25 Oct 2022 15:36:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: Regression: Re: [PATCH v2 4/6] PCI: Distribute available
 resources for root buses too
Message-ID: <Y1fYNsjmUFZsvteT@black.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
 <20220905080232.36087-5-mika.westerberg@linux.intel.com>
 <20221014124553.0000696f@huawei.com>
 <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
 <20221014154858.000079f2@huawei.com>
 <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
 <Y1Z2GGgfZyzC2d1N@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Z2GGgfZyzC2d1N@black.fi.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Oct 24, 2022 at 02:25:12PM +0300, Mika Westerberg wrote:
> On Mon, Oct 24, 2022 at 02:13:10PM +0300, Mika Westerberg wrote:
> > Hi,
> > 
> > On Fri, Oct 14, 2022 at 03:48:58PM +0100, Jonathan Cameron wrote:
> > > > Thanks for the detailed report! I wonder if you could try the below
> > > > patch and see if it changes anything?
> > > Thanks for the quick response.
> > > 
> > > Doesn't fix it unfortunately.
> > 
> > I'm back now.
> > 
> > Trying to reproduce this with mainline kernel (arm64 defconfig) and the
> > following command line:
> > 
> > qemu-system-aarch64 \
> >         -M virt,nvdimm=on,gic-version=3 -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
> >         -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
> >         -nographic -no-reboot  \
> >         -kernel Image \
> >         -initrd rootfs.cpio.bz2 \
> >         -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2 \
> >         -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
> >         -device e1000,bus=root_port13,addr=0.1 \
> >         -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3 \
> >         -device e1000,bus=fun1
> > 
> > But the resulting PCIe topology is pretty flat:
> > 
> > # lspci
> > 00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
> > 00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device
> > 
> > I wonder what I'm missing here? Do I need to enable additional drivers
> > to get the topology to resemble yours?
> 
> Nevermind, I was missing one \ in the command line ;-) Now I can see the
> topology similar to yours.

I think I know what the problem is now - there is a multifunction device
with the switch upstream port and the resource distribution code is not
prepared to handle such (not sure how common this is in real hardware
but allowed by the PCIe spec).

Simple fix would be just ignore all resource distribution if we
encounter such topologies but I think can still allow it, just by
accounting the resources reserved for the multifunction device(s).

Can you try on your side so that you revert this revert:

  5632e2beaf9d ("Revert "PCI: Distribute available resources for root buses, too"")

and then apply the below patch and see if the problem goes away? Thanks!

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index dc6a30ee6edf..a7ca3fecf259 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1833,10 +1833,65 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * bridges below.
 	 */
 	if (hotplug_bridges + normal_bridges == 1) {
-		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate)
-			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, io, mmio, mmio_pref);
+		/* Upstream port must be the first */
+		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
+		if (!bridge->subordinate)
+			return;
+
+		/*
+		 * It is possible to have switch upstream port as a part
+		 * of multifunction device, although not too common. For
+		 * this reason reduce the resources occupied by the
+		 * other functions before distributing the rest.
+		 */
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			int i;
+
+			if (dev == bridge)
+				continue;
+
+			/*
+			 * It should be multifunction but if not stop
+			 * the distribution and bail out.
+			 */
+			if (!dev->multifunction)
+				return;
+
+			for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+				const struct resource *dev_res = &dev->resource[i];
+				resource_size_t dev_sz;
+				struct resource *b_res;
+
+				if (dev_res->flags & IORESOURCE_IO) {
+					b_res = &io;
+				} else if (dev_res->flags & IORESOURCE_MEM) {
+					if (dev_res->flags & IORESOURCE_PREFETCH)
+						b_res = &mmio_pref;
+					else
+						b_res = &mmio;
+				} else {
+					continue;
+				}
+
+				/* Size aligned to bridge window */
+				align = pci_resource_alignment(bridge, b_res);
+				dev_sz = ALIGN(resource_size(dev_res), align);
+
+				pci_dbg(dev, "%pR aligned to %llx\n", dev_res,
+					dev_sz);
+
+				if (dev_sz >= resource_size(b_res))
+					memset(b_res, 0, sizeof(*b_res));
+				else
+					b_res->end -= dev_sz;
+
+				pci_dbg(bridge, "updated available to %pR\n", b_res);
+			}
+		}
+
+		pci_bus_distribute_available_resources(bridge->subordinate,
+						       add_list, io, mmio,
+						       mmio_pref);
 		return;
 	}
 
