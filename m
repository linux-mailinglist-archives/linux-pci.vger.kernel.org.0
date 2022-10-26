Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C076D60DD29
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 10:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJZIi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiJZIi1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 04:38:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16199B878A;
        Wed, 26 Oct 2022 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666773506; x=1698309506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G4Lc3lqjhLm2vHGA7odAfKTv5YXbVDc4UA8TyUelEHw=;
  b=SWiPf/kOgizgTAlom3otvZ6FyP3UzcA03Th/KPUJ5yO/Ol6LHHqnlSF6
   nlH6CEjHRI6kmlRblxQmE6GaHhNCiq/YhnhsJF3Xo14w8UI2zxdwAFSCa
   Pxsz2siQaY8NTN6Mumz+WOJ/nYa4856uoDws0H3I0h/bHTv536s6B/M0u
   SdtyYSohrJ/eq1gg/FNtFjdGzzdbIJe/2WpLNgPjAaPNEYduqM34r7JDz
   FV4CVxK27RmpD8lqSr1XdaYODs9NBI0QjqHUK4zoudWLotJISWzQ4JZXk
   4DwnfAzipzJkPriB0v6NGAgDJW7HsODpDExcJYUobagDgFrHTYOhfhPrS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="305508222"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="305508222"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="695279571"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="695279571"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2022 01:38:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B92763F9; Wed, 26 Oct 2022 11:38:32 +0300 (EEST)
Date:   Wed, 26 Oct 2022 11:38:32 +0300
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
Message-ID: <Y1jyCHS2ka2rYEtN@black.fi.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
 <20220905080232.36087-5-mika.westerberg@linux.intel.com>
 <20221014124553.0000696f@huawei.com>
 <Y0lkeieF3WNV3P3Q@black.fi.intel.com>
 <20221014154858.000079f2@huawei.com>
 <Y1ZzRmi9fL9yHf7I@black.fi.intel.com>
 <Y1Z2GGgfZyzC2d1N@black.fi.intel.com>
 <Y1fYNsjmUFZsvteT@black.fi.intel.com>
 <20221025150500.000059ba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025150500.000059ba@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 03:05:00PM +0100, Jonathan Cameron wrote:
> On Tue, 25 Oct 2022 15:36:06 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > On Mon, Oct 24, 2022 at 02:25:12PM +0300, Mika Westerberg wrote:
> > > On Mon, Oct 24, 2022 at 02:13:10PM +0300, Mika Westerberg wrote:  
> > > > Hi,
> > > > 
> > > > On Fri, Oct 14, 2022 at 03:48:58PM +0100, Jonathan Cameron wrote:  
> > > > > > Thanks for the detailed report! I wonder if you could try the below
> > > > > > patch and see if it changes anything?  
> > > > > Thanks for the quick response.
> > > > > 
> > > > > Doesn't fix it unfortunately.  
> > > > 
> > > > I'm back now.
> > > > 
> > > > Trying to reproduce this with mainline kernel (arm64 defconfig) and the
> > > > following command line:
> > > > 
> > > > qemu-system-aarch64 \
> > > >         -M virt,nvdimm=on,gic-version=3 -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
> > > >         -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd \
> > > >         -nographic -no-reboot  \
> > > >         -kernel Image \
> > > >         -initrd rootfs.cpio.bz2 \
> > > >         -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2 \
> > > >         -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
> > > >         -device e1000,bus=root_port13,addr=0.1 \
> > > >         -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3 \
> > > >         -device e1000,bus=fun1
> > > > 
> > > > But the resulting PCIe topology is pretty flat:
> > > > 
> > > > # lspci
> > > > 00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
> > > > 00:01.0 Ethernet controller: Red Hat, Inc. Virtio network device
> > > > 
> > > > I wonder what I'm missing here? Do I need to enable additional drivers
> > > > to get the topology to resemble yours?  
> > > 
> > > Nevermind, I was missing one \ in the command line ;-) Now I can see the
> > > topology similar to yours.  
> > 
> > I think I know what the problem is now - there is a multifunction device
> > with the switch upstream port and the resource distribution code is not
> > prepared to handle such (not sure how common this is in real hardware
> > but allowed by the PCIe spec).
> > 
> > Simple fix would be just ignore all resource distribution if we
> > encounter such topologies but I think can still allow it, just by
> > accounting the resources reserved for the multifunction device(s).
> > 
> > Can you try on your side so that you revert this revert:
> > 
> >   5632e2beaf9d ("Revert "PCI: Distribute available resources for root buses, too"")
> > 
> > and then apply the below patch and see if the problem goes away? Thanks!
> 
> Looks good on my more complex setup that I originally hit this problem on.

Thanks for checking!

> 
> A comment on the comment inline.
> 
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index dc6a30ee6edf..a7ca3fecf259 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1833,10 +1833,65 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	 * bridges below.
> >  	 */
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
> > +		 * It is possible to have switch upstream port as a part
> > +		 * of multifunction device, although not too common. For
> > +		 * this reason reduce the resources occupied by the
> > +		 * other functions before distributing the rest.
> > +		 */
> 
> I 'think' it's quite common. I don't have one to hand but
> drivers/pci/switches/switchtec.c has drivers for a management function that I
> think are an additional function alongside the USP on a wide range of
> switch chips.  It's possible those actually sit on their own port though or
> pretend to be below a DSP.

I see. Okay, I will update the comment accordingly and submit as a formal
patch along with the revert of the revert if no objections.
