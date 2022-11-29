Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3969663C361
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiK2PQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 10:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiK2PP6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 10:15:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C5C3F063
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669734957; x=1701270957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G7F2v4Ree5SosAYNl/TXBuLbKUECUfZINv3+4Ty+LpU=;
  b=BFma/SpVVhozpVHeuh+39rUFHGtNX8fxq7VhOtT97mxhchdZE6tvCnDk
   cQEsSMginG9lw61y4NTT/clnh547J8tH8HizdfNzhWWgAbj6pIQUEU68D
   e/QcUgeguU1M33hrEUMHYr8lKoyw29fX1fi0S4w/WjYOqJpsqTgTIM7iU
   Qc13lsAef3xKDINjxF5Zf232jM/s5rKnUUO1GJc5DT8+oOw5lHLDa42LU
   KzsB3v+ihmQqCRyG7cyKlCdmzO9Xnpps91CwKTTlpnXdcWyc2F/xni63R
   OzHg8EoiT5t9KAk/l9k7vQhsdoskDwCzTOXvt3lgQJLm/yfUJHbQaxea4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="401421884"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="401421884"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 07:06:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="818242219"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="818242219"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 29 Nov 2022 07:06:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D14A4179; Tue, 29 Nov 2022 17:07:21 +0200 (EET)
Date:   Tue, 29 Nov 2022 17:07:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <Y4YgKaml6nh5cB9r@black.fi.intel.com>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
 <20221128203932.GA644781@bhelgaas>
 <20221128150617.14c98c2e.alex.williamson@redhat.com>
 <20221129064812.GA1555@wunner.de>
 <20221129065242.07b5bcbf.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129065242.07b5bcbf.alex.williamson@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Nov 29, 2022 at 06:52:42AM -0700, Alex Williamson wrote:
> On Tue, 29 Nov 2022 07:48:12 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
> > On Mon, Nov 28, 2022 at 03:06:17PM -0700, Alex Williamson wrote:
> > > Agreed.  Is this convoluted removal process being used to force a SBR,
> > > versus a FLR or PM reset that might otherwise be used by twiddling the
> > > reset attribute of the GPU directly?  If so, the reset_method attribute
> > > can be used to force a bus reset and perform all the state save/restore
> > > handling to avoid reallocating BARs.  A reset from the upstream switch
> > > port would only be necessary if you have some reason to also reset the
> > > switch downstream ports.  Thanks,  
> > 
> > A Secondary Bus Reset is only offered as a reset_method if the
> > device to be reset is the *only* child of the upstream bridge.
> > I.e. if the device to be reset has siblings or children,
> > a Secondary Bus Reset is not permitted.
> > 
> > Modern GPUs (including the one Mika is referring to) consist of
> > a PCIe switch with the GPU, HD audio and telemetry devices below
> > Downstream Bridges.  A Secondary Bus Reset of the Root Port is
> > not allowed in this case because the Switch Upstream Port has
> > children.
> 
> I didn't see such functions in the log provided, the GPU in question
> seems to be a single function device at 53:00.0.  This matches what
> I've seen on an ARC A380 GPU where the GPU and HD audio are each single
> function devices under separate downstream ports of a PCIe switch.

Yes, this one is similar. There is a PCIe switch and then bunch of
devices connected to the downstream ports. One of them being the GPU.

Sorry if I missed that part in the report.

There are typically multiple of these cards and they want to perform the
reset seperately for each.

> > See this code in pci_parent_bus_reset():
> > 
> > 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> > 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> > 		return -ENOTTY;
> > 
> > The dev->subordinate check disallows a SBR if there are children.
> > Note that the code should probably instead check for...
> > (dev->subordinate && !list_empty(dev->subordinate->devices))
> > ...because the port may have a subordinate bus without children
> > (may have been removed for example).
> > 
> > The "no siblings" rule is enforced by:
> > 
> > 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> > 		if (pdev != dev)
> > 			return -ENOTTY;
> > 
> > Note that the devices list is iterated without holding pci_bus_sem,
> > which looks fishy.
> > 
> > That said, it *is* possible that a Secondary Bus Reset is erroneously
> > offered despite these checks because we perform them early on device
> > enumeration when the subordinate bus hasn't been scanned yet.
> > 
> > So if the Root Port offers other reset methods besides SBR and the
> > user switches to one of them, then reinstates the defaults,
> > suddenly SBR will disappear because the subordinate bus has since
> > been scanned.  What's missing here is that we re-check availability
> > of the reset methods on siblings and the parent when a device is
> > added or removed.  This is also necessary to make reset_method
> > work properly with hotplug.  However, the result may be that the
> > reset_method attribute in sysfs may become invisible after adding
> > a device (because there is no reset method available) and reappear
> > after removing a device.
> > 
> > So the reset_method logic is pretty broken right now I'm afraid.
> 
> I haven't checked for a while, but I thought we exposed SBR regardless
> of siblings, though it can't be accessed via the reset attribute if
> there are siblings.  That allows that the sibling devices could be soft
> removed, a reset performed, and the bus re-scanned.  If there are in
> fact sibling devices, it would make more sense to remove only those to
> effect a bus reset to avoid the resource issues with rescanning SR-IOV
> on the GPU.

If I understand correctly they perform the reset just above the upstream
port of the PCIe switch so that it resets the whole "card".
> 
> > In any case, for Mika's use case it would be useful to have a
> > "reset_subordinate" attribute on ports capable of a SBR such that
> > the entire hierarchy below is reset.  The "reset" attribute is
> > insufficient.
> 
> I'll toss out that a pretty simple vfio tool can be written to bind all
> the siblings on a bus enabling the hot reset ioctl in vfio.  Thanks,

Sounds good but unfortunately I'm not fluent in vfio so I have no idea
how this simple tool could be done :( Do you have any examples or
pointers that we could use to try this out?

Thanks!
