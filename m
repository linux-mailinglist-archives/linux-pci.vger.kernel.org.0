Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE677633C4E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 13:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiKVMVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 07:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiKVMVM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 07:21:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B74AF08
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 04:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669119671; x=1700655671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/QCCd2hQOUkjYvW2iNs4k2Ykntj36pFyXgTIXwWsk+U=;
  b=Z3Dot18jQPztGLmL+EriYsXP82mr0NP7mm0esz6yUZgKiZy/gRwbNy32
   UiMmccURPvIeBO2cPxeNf2ChkIzYKd18aOwDCwviNZykHLtWPDtxDPbwk
   NGCOrFYh1poulzV1Vq0mIMYY4hWbBDrl13QWp1D0g7ZjYStZw+AgBraAM
   MwgUINijSyvK2CwRNmZtRCgQpvc5aE/eyAW/WURDqleSz6Dp8gNyanLBb
   2fG2BnR/bvXOAWap65oX1JG8beyJJotCS629WWYVy4HjmXr/hdpomx+sT
   6l/qqmjVzXDRzCMpSHupp9CWWuRv0BBr1ZwT+SEwx54xtkTsqByjD6PAv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="313831254"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="313831254"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 04:21:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619194398"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="619194398"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2022 04:21:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CD583128; Tue, 22 Nov 2022 14:21:33 +0200 (EET)
Date:   Tue, 22 Nov 2022 14:21:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <Y3y+zSHG4X2iCQQ9@black.fi.intel.com>
References: <Y3tlRIG99P/amO9Q@black.fi.intel.com>
 <20221121224548.GA138441@bhelgaas>
 <Y3xvcvqgFbYMIIpl@black.fi.intel.com>
 <20221122114541.00005ff9@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221122114541.00005ff9@Huawei.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 22, 2022 at 11:45:41AM +0000, Jonathan Cameron wrote:
> On Tue, 22 Nov 2022 08:42:58 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Hi,
> > 
> > On Mon, Nov 21, 2022 at 04:45:48PM -0600, Bjorn Helgaas wrote:
> > > IIUC, the summary is this:
> > > 
> > >   00:02.0 bridge window [mem 0x10000000-0x102fffff] to [bus 01-02]
> > >   01:02.0 bridge window [mem 0x10000000-0x100fffff] to [bus 02]
> > >   01:03.0 NIC BAR [mem 0x10200000-0x1021ffff]
> > >   01:04.0 NIC BAR [mem 0x10220000-0x1023ffff]
> > >   02:05.0 NIC BAR [mem 0x10080000-0x1009ffff]
> > > 
> > > and it's the same with and without the current patch.
> > > 
> > > Are all these assignments done by BIOS, or did Linux update them?  
> > 
> > > Did we exercise the same "distribute available resources" path as in
> > > the PCIe case?  I expect we *should*, because there really shouldn't
> > > be any PCI vs PCIe differences in how resources are handled.  This is
> > > why I'm not comfortable with assumptions here that depend on PCIe.
> > > 
> > > I can't tell from Jonathan's PCIe case whether we got a working config
> > > from BIOS or not because our logging of bridge windows is kind of
> > > poor.  
> > 
> > This is ARM64 so there is no "BIOS" involved (something similar though).
> 
> It's EDK2 in my tests  - so very similar to other arch.
> Possible to boot without though and rely on DT, but various things don't
> work yet...

Okay.

> > It is the same "system" that Jonathan used where the regression happened
> > with the multifunction PCIe configuration with the exception that I'm
> > now using PCI devices instead of PCIe as you asked.
> > 
> > I'm not 100% sure if the all the same code paths are used here, though.
> > 
> 
> I wondered if it was possibly to do with fairly minimal handling of pci-pxb
> (the weird root bridge) in EDK2, so tried the obvious of hanging your PCI
> test below one of those rather than directly below a normal bridge.
> Despite shuffling things around into configurations
> I thought might trigger the problem, it all seems fine.

I also did some other experiments like tried to add pcie-root-port first
but that did not trigger the issue either (unless I missed something).

> Note that I can't currently test the pxb-pcie configurations without EDK2
> as arm-virt doesn't provide the relevant DT for those root bridges yet
> (it's on my todo list as it's a prereq for getting the QEMU CXL ARM64
> emulation upstream)
> 
> So no guarantees as I don't understand fully why PCI is ending up
> with different handling.
> 
> From liberal distribution of printk()s it seems that for PCI bridges
> pci_bridge_resources_not_assigned() is false, but for PCI express
> example it is true.  My first instinct is quirk of the EDK2 handling? 
> I'll have a dig, but I'm not an expert in EDK2 at all, so may not get
> to the bottom of this.
> 
> Ultimately it seems that when the OS takes over the prefetchable memory
> resources are not configured for the PCIe case, but are for the PCI case.
> So we aren't currently walking the new code for PCI.

I think the reason why this "difference" is that we have this in
__pci_bus_size_bridges():

               if (bus->self->is_hotplug_bridge) {
                        additional_io_size  = pci_hotplug_io_size;
                        additional_mmio_size = pci_hotplug_mmio_size;
                        additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
                }

For QEMU PCIe root/downstream ports this might be true so we end up with
"additional resources" in the resource list and therfore the kernel
tries to do the allocation wrt. with PCI case it is not. I tried to end
up with the same code path in my command line with this:

  -device pci-bridge,chassis_nr=1,bus=br1,id=br2,shpc=on,addr=2

The "shpc=on" should make it hotplug bridge as well but apparently that
is not happening.
