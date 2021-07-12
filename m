Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2EE3C5BF5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 14:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhGLMSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 08:18:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:58818 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhGLMSo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 08:18:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="231757423"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="231757423"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 05:15:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="561728268"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 05:15:24 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m2uqD-00CDRM-JN; Mon, 12 Jul 2021 15:15:17 +0300
Date:   Mon, 12 Jul 2021 15:15:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Tan Jui Nee <jui.nee.tan@intel.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Peter Tyser <ptyser@xes-inc.com>, hdegoede@redhat.com
Subject: Re: [PATCH v1 3/7] PCI: New Primary to Sideband (P2SB) bridge
 support library
Message-ID: <YOwyVXz9QMyRqs4B@smile.fi.intel.com>
References: <YGYPiCekM3clFEsD@smile.fi.intel.com>
 <20210401184446.GA1528755@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401184446.GA1528755@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 01:44:46PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 01, 2021 at 09:23:04PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 01, 2021 at 11:42:56AM -0500, Bjorn Helgaas wrote:
> > > On Thu, Apr 01, 2021 at 06:45:02PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Mar 09, 2021 at 09:42:52AM +0100, Henning Schild wrote:
> > > > > Am Mon, 8 Mar 2021 19:42:21 -0600
> > > > > schrieb Bjorn Helgaas <helgaas@kernel.org>:
> > > > > > On Mon, Mar 08, 2021 at 09:16:50PM +0200, Andy Shevchenko wrote:
> > > > > > > On Mon, Mar 08, 2021 at 12:52:12PM -0600, Bjorn Helgaas wrote:  
> > > > > > > > On Mon, Mar 08, 2021 at 02:20:16PM +0200, Andy Shevchenko wrote:  
> > > > 
> > > > ...
> > > > 
> > > > > > > > > +	/* Read the first BAR of the device in question */
> > > > > > > > > +	__pci_bus_read_base(bus, devfn, pci_bar_unknown, mem,
> > > > > > > > > PCI_BASE_ADDRESS_0, true);  
> > > > > > > > 
> > > > > > > > I don't get this.  Apparently this normally hidden device is
> > > > > > > > consuming PCI address space.  The PCI core needs to know
> > > > > > > > about this.  If it doesn't, the PCI core may assign this
> > > > > > > > space to another device.  
> > > > > > > 
> > > > > > > Right, it returns all 1:s to any request so PCI core *thinks*
> > > > > > > it's plugged off (like D3cold or so).  
> > > > > > 
> > > > > > I'm asking about the MMIO address space.  The BAR is a register
> > > > > > in config space.  AFAICT, clearing P2SBC_HIDE_BYTE makes that
> > > > > > BAR visible.  The BAR describes a region of PCI address space.
> > > > > > It looks like setting P2SBC_HIDE_BIT makes the BAR disappear
> > > > > > from config space, but it sounds like the PCI address space
> > > > > > *described* by the BAR is still claimed by the device.  If the
> > > > > > device didn't respond to that MMIO space, you would have no
> > > > > > reason to read the BAR at all.
> > > > > > 
> > > > > > So what keeps the PCI core from assigning that MMIO space to
> > > > > > another device?
> > > > > 
> > > > > The device will respond to MMIO while being hidden. I am afraid
> > > > > nothing stops a collision, except for the assumption that the BIOS
> > > > > is always right and PCI devices never get remapped. But just
> > > > > guessing here.
> > > > > 
> > > > > I have seen devices with coreboot having the P2SB visible, and
> > > > > most likely relocatable. Making it visible in Linux and not hiding
> > > > > it again might work, but probably only as long as Linux will not
> > > > > relocate it.  Which i am afraid might seriously upset the BIOS,
> > > > > depending on what a device does with those GPIOs and which parts
> > > > > are implemented in the BIOS.
> > > > 
> > > > So the question is, do we have knobs in PCI core to mark device
> > > > fixes in terms of BARs, no relocation must be applied, no other
> > > > devices must have the region?
> > > 
> > > I think the closest thing is the IORESOURCE_PCI_FIXED bit that we use
> > > for things that must not be moved.  Generally PCI resources are
> > > associated with a pci_dev, and we set IORESOURCE_PCI_FIXED for BARs,
> > > e.g., dev->resource[n].  We do that for IDE legacy regions (see
> > > LEGACY_IO_RESOURCE), Langwell devices (pci_fixed_bar_fixup()),
> > > "enhanced allocation" (pci_ea_flags()), and some quirks (quirk_io()).
> > > 
> > > In your case, the device is hidden so it doesn't respond to config
> > > accesses, so there is no pci_dev for it.
> > 
> > Yes, and the idea is to unhide it on the early stage.
> > Would it be possible to quirk it to fix the IO resources?
> 
> If I read your current patch right, it unhides the device, reads the
> BAR, then hides the device again.  I didn't see that it would create a
> pci_dev for it.
> 
> If you unhide it and then enumerate it normally (and mark the BAR as
> IORESOURCE_PCI_FIXED to make sure we never move it), that might work.
> Then there should be a pci_dev for it, and it would then show up in
> sysfs, lspci, etc.  And we should insert the BAR in iomem_resource, so
> we should see it in /proc/iomem and we won't accidentally put
> something else on top of it.

If the PCI device is present and we have ACPI description for the one or more
devices (currently pin control), wouldn't be a conflicting resources issue?

When would be the suitable place to avoid that?

> > > resource, fills it in, sets IORESOURCE_PCI_FIXED, and does something
> > > similar to pci_claim_resource()?

-- 
With Best Regards,
Andy Shevchenko


