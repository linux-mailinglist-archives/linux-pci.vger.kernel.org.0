Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5352063BDA9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiK2KLq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 05:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiK2KLb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 05:11:31 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E13443AE7
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2022 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669716586; x=1701252586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iVANpgmZupLr13mbJKcI1dFVG3ai02JsV24epyo+5Dk=;
  b=LPRnmqYbuBZJHnXWk+KISOXTf6CwYUowRYvCzXxOpoFJYTYTlMi1UKeM
   hiZYMh/kHLSITgDhP3zwCi44C2xGt/KTgtPQz5WPcoK3qN6aleRvctIYo
   VHZBYKJpcDU//smrV9gWRxMa3jC7VNKZtelVveTfupx56tGMAHHa4YPeO
   1PUKN8KDw4XNn2hfoNdwVDGoEXqf8NDPuLi2MPMzTTKL/EhctlwtuIv/7
   q36vCsU5amovHHZsMIngK54VumschSlog7cmbSPNcqCkEzahr34Ul8lxL
   x/efSiNuYfcgUDcfj0XZsqhyXQsLv6Op0t+XZwPPsam3HorxT0LpEAJTf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="298423103"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="298423103"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 02:09:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="712317627"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="712317627"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2022 02:09:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 747F1179; Tue, 29 Nov 2022 12:09:40 +0200 (EET)
Date:   Tue, 29 Nov 2022 12:09:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <Y4XaZPav0Dl/fA16@black.fi.intel.com>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
 <20221128203932.GA644781@bhelgaas>
 <20221128150617.14c98c2e.alex.williamson@redhat.com>
 <20221129064812.GA1555@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129064812.GA1555@wunner.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Nov 29, 2022 at 07:48:12AM +0100, Lukas Wunner wrote:
> On Mon, Nov 28, 2022 at 03:06:17PM -0700, Alex Williamson wrote:
> > Agreed.  Is this convoluted removal process being used to force a SBR,
> > versus a FLR or PM reset that might otherwise be used by twiddling the
> > reset attribute of the GPU directly?  If so, the reset_method attribute
> > can be used to force a bus reset and perform all the state save/restore
> > handling to avoid reallocating BARs.  A reset from the upstream switch
> > port would only be necessary if you have some reason to also reset the
> > switch downstream ports.  Thanks,
> 
> A Secondary Bus Reset is only offered as a reset_method if the
> device to be reset is the *only* child of the upstream bridge.
> I.e. if the device to be reset has siblings or children,
> a Secondary Bus Reset is not permitted.
> 
> Modern GPUs (including the one Mika is referring to) consist of
> a PCIe switch with the GPU, HD audio and telemetry devices below
> Downstream Bridges.  A Secondary Bus Reset of the Root Port is
> not allowed in this case because the Switch Upstream Port has
> children.
> 
> See this code in pci_parent_bus_reset():
> 
> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> 		return -ENOTTY;
> 
> The dev->subordinate check disallows a SBR if there are children.
> Note that the code should probably instead check for...
> (dev->subordinate && !list_empty(dev->subordinate->devices))
> ...because the port may have a subordinate bus without children
> (may have been removed for example).
> 
> The "no siblings" rule is enforced by:
> 
> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> 		if (pdev != dev)
> 			return -ENOTTY;
> 
> Note that the devices list is iterated without holding pci_bus_sem,
> which looks fishy.
> 
> That said, it *is* possible that a Secondary Bus Reset is erroneously
> offered despite these checks because we perform them early on device
> enumeration when the subordinate bus hasn't been scanned yet.

Thanks Lukas for the good explanation :) I think because of the above
our GPU folks do Secondary Bus Reset directly by poking the config space
through setpci or so, and I guess this is why they need the "remove"
phase as well.

> So if the Root Port offers other reset methods besides SBR and the
> user switches to one of them, then reinstates the defaults,
> suddenly SBR will disappear because the subordinate bus has since
> been scanned.  What's missing here is that we re-check availability
> of the reset methods on siblings and the parent when a device is
> added or removed.  This is also necessary to make reset_method
> work properly with hotplug.  However, the result may be that the
> reset_method attribute in sysfs may become invisible after adding
> a device (because there is no reset method available) and reappear
> after removing a device.
> 
> So the reset_method logic is pretty broken right now I'm afraid.
> 
> In any case, for Mika's use case it would be useful to have a
> "reset_subordinate" attribute on ports capable of a SBR such that
> the entire hierarchy below is reset.  The "reset" attribute is
> insufficient.

Yes, that would be useful indeed.
