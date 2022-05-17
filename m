Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38452A9F8
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351343AbiEQSGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 14:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352084AbiEQSGH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 14:06:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046250B1F;
        Tue, 17 May 2022 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652810749; x=1684346749;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G5Wv9shpOpxZTi2I/lWPe2CBntwVSC8iH9Z7DnGd2zo=;
  b=Ce8caY3KTpwcG1kJRg521Hgq68jJuqxCs+ak/crw7MMv/G+pXOD9349g
   7x8ZQDpnxI8lQTxx40/scBbtVHLBReCxLBBk1ptqPLKjeWouOHmiYcHbw
   KJe2GPe2OxWuPFIpuLOyNXT+8RToL4CUvVDNeT26JVhRzaSgZgdpaNDMk
   On3xZbla9cRsVxmGnj+FFYSwn/1lrhNq8C1g2cSNm0eAbEIRqt0JaXWV9
   BC3/u5UiINpsLlEX0HSC2aTa1IROGTeYc6AX6bcriIUQsaXgcKm74u7sa
   jsICuqR2HAPlI7PHmho3AjLJ7WlnqHtEYrnPxWg0//7pItpEfshqXnP7O
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="296556739"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="296556739"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="545024206"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2022 11:05:48 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id DE05A5807E8;
        Tue, 17 May 2022 11:05:48 -0700 (PDT)
Message-ID: <92f32b4703091acb0aaf3f784be448d469e9e2fa.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Jingar, Rajvi" <rajvi.jingar@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Tue, 17 May 2022 11:05:48 -0700
In-Reply-To: <CAJZ5v0iNaAd=yP3DgDVVpffKU6kt+nSpPeqxWJyRddaX5K4FRA@mail.gmail.com>
References: <CAJZ5v0g6GdKfN4b5uwHEhh4hBuG=haVHaXc-XuMQLe8Wd41Y3g@mail.gmail.com>
         <20220517144846.GA1068039@bhelgaas>
         <CAJZ5v0iNaAd=yP3DgDVVpffKU6kt+nSpPeqxWJyRddaX5K4FRA@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2022-05-17 at 16:54 +0200, Rafael J. Wysocki wrote:
> On Tue, May 17, 2022 at 4:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > On Mon, May 16, 2022 at 10:59:32PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, May 16, 2022 at 10:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, May 13, 2022 at 10:00:48PM +0000, Jingar, Rajvi wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > > Sent: Thursday, May 12, 2022 11:36 AM
> > > > > > To: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> > > > > > <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > > > > > David Box
> > > > > > <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>;
> > > > > > Linux
> > > > > > Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> > > > > > pm@vger.kernel.org>
> > > > > > Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to
> > > > > > disable PTM
> > > > > > 
> > > > > > On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > > > > > > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org>
> > > > > > > wrote:
> > > > > > > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> > > > > > 
> > > > > > > > > Something like this should suffice IMV:
> > > > > > > > > 
> > > > > > > > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > > > > > > > > 
> > > > > > > > >         pci_disable_ptm(pci_dev);
> > > > > > > > 
> > > > > > > > It makes sense to me that we needn't disable PTM if the device is
> > > > > > > > in
> > > > > > > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > > > > > > driver did.  Why is that important?  Why should we not do the
> > > > > > > > following?
> > > > > > > > 
> > > > > > > >   if (pci_dev->current_state != PCI_D3cold)
> > > > > > > >     pci_disable_ptm(pci_dev);
> > > > > > > 
> > > > > > > We can do this too.  I thought we could skip the power state
> > > > > > > check if dev_state_saved was unset, because then we would know
> > > > > > > that the power state was not D3cold.  It probably isn't worth
> > > > > > > the hassle though.
> > > > > 
> > > > > We see issue with certain platforms where only checking if device
> > > > > power state in D3Cold is not enough and the !dev_state_saved check
> > > > > is needed when disabling PTM. Device like nvme is relying on ASPM,
> > > > > it stays in D0 but state is saved. Touching the config space wakes
> > > > > up the device which prevents the system from entering into low power
> > > > > state.
> > > > 
> > > > Correct me if I'm wrong: for NVMe devices, nvme_suspend() has already
> > > > saved state and put the device in some low-power state.  Disabling PTM
> > > > here is functionally OK but prevents a system low power state, so you
> > > > want to leave PTM enabled.
> > > > 
> > > > But I must be missing something because pci_prepare_to_sleep()
> > > > currently disables PTM for Root Ports.  If we leave PTM enabled on
> > > > NVMe but disable it on the Root Port above it, any PTM Request from
> > > > NVMe will cause an Unsupported Request error.
> > > > 
> > > > Disabling PTM must be coordinated across PTM Requesters and PTM
> > > > Responders.  That means the decision to disable cannot depend on
> > > > driver-specific things like whether the driver has saved state.
> > > 
> > > Setting state_saved generally informs pci_pm_suspend_noirq() that the
> > > device has already been handled and it doesn't need to do anything to
> > > it.
> > > 
> > > But you are right that PTM should be disabled on downstream devices as
> > > well as on the ports that those devices are connected to and it can be
> > > done even if the given device has already been handled, so the
> > > state_saved value is technically irrelevant.
> > > 
> > > That's why I suggested to check if the power state is between D0 and
> > > D3cold (exclusive) and only disable PTM if that is the case.  It is
> > > pointless to disable PTM for devices in D3cold and it may be harmful
> > > for devices that are left in D0.
> > 
> > "... it may be harmful for devices that are left in D0" -- I want to
> > understand this better.  It sounds like nvme_suspend() leaves the
> > device in some device-specific low-power flavor of D0, and subsequent
> > config accesses take it out of that low-power situation?
> 

This is exactly what we see. It's not all machines, but in our lab we've seen in
it on 3 production systems out of about 20. And they were all different
generations, a 7th, 8th, and 10th gen.

nvme_suspend is relying on NVMe APST / PCIe ASPM to put the device in a low
power state. The link state will be L1 or deeper while the device remains in D0.

https://nvmexpress.org/resources/nvm-express-technology-features/nvme-technology-power-features/


> That's my understanding of it.
> 
> > If that's the case, it sounds a little brittle.  I don't think it's
> > obvious that "pci_dev->state_saved was set by the driver" means "no
> > config accesses allowed in pci_pm_suspend_noirq()."
> 
> Well, yes and no.  The device may be in D3cold then, so
> pci_pm_suspend_noirq() should at least check that before accessing its
> config space.
> 
> > And pci_pm_suspend_noirq() calls quirks via pci_fixup_device(), which are
> > very likely to do config accesses.
> > 
> > Maybe PTM needs to be disabled earlier, e.g., in pci_pm_suspend()?  I
> > don't think PTM uses any interrupts, so there's probably no reason
> > interrupts need to be disabled before disabling PTM.
> 
> That certainly is worth investigation.  For one, I don't see any
> obvious downsides of doing so.

We will look at this.

David


