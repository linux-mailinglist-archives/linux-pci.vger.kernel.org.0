Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF6429597
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhJKR1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 13:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233171AbhJKR1R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 13:27:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F27E60E74;
        Mon, 11 Oct 2021 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633973116;
        bh=JjOhJowHWytfk/w6pKOZd4yHUqbjXchTEm9nBXWKsgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MBRVVWzotINhTQZXUPmriGVNEkkDgFW7HcI7a0Slufsv2nles2KwyB59I1fHLaKzu
         HiayiYLynY0KI/QtXFLikdp7ExRqxeXSDun+dXJS+8ukkkFQsrS8GsCxTzbn38Mc26
         o/4OgYLuGCf4jQmJ8rA4fdSND8s9gDLo92m+w3/3e93jojrUvN68SaNf37JRqgv5iA
         0l5OGE6iN2JxghHiy3gO3gzihLc5+C2S8SjBCH3AzH+NeD8lAxExqCcGlUmHKS+kaU
         HaTkcSjJtTU6inckX5G0Vh02cpzr1W5TuvImi3DTzGrMj3aFeLSPtq2ssPM2MO+Jfa
         Qjg4KcZzlAmWA==
Date:   Mon, 11 Oct 2021 12:25:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] PCI: pciehp: Ignore Link Down/Up caused by
 error-induced Hot Reset
Message-ID: <20211011172515.GA1663896@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010091407.GA13471@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 10, 2021 at 11:14:07AM +0200, Lukas Wunner wrote:
> On Thu, Oct 07, 2021 at 06:00:20PM -0500, Bjorn Helgaas wrote:
> > On Sat, Jul 31, 2021 at 02:39:01PM +0200, Lukas Wunner wrote:
> > > The issue isn't DPC-specific, it also occurs when an error is handled by
> > > AER through aer_root_reset().  So while the issue was noticed only now,
> > > it's been around since 2006 when AER support was first introduced.
> > > 
> > > Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
> [...]
> > > Cc: stable@vger.kernel.org # v2.6.19+: ba952824e6c1: PCI/portdrv: Report reset for frozen channel
> > 
> > Have you tried backporting this to v2.6.19?  I bet it's tough.  Not
> > sure we should suggest that stable pick this up unless there's a
> > reasonable path to do that.
> 
> The oldest kernel.org stable release that still receives updates is v4.4.
> There may be older distribution kernels out there which continue to be
> supported.  We don't know for sure, so I think it's customary to tag
> the release that introduced an issue and leave it to the stable and
> distribution maintainers to choose what they backport.
> 
> It's true that patches often do not apply cleanly to older releases.
> There are some good folks who regularly take up the thankless task of
> backporting (Sudip Mukherjee to name but one), but I've also frequently
> backported patches myself where necessary.
> 
> 
> > > +config PCI_ERROR_RECOVERY
> > > +	def_bool PCIEAER || EEH
> > 
> > I'm having a hard time connecting this to the code.
> [...]
> > But this still seems like it's kind of dangling.  It's not obvious to
> > me why pciehp_slot_reset() should be inside that #ifdef.  Do we need
> > the #ifdef for a functional reason, or is it there because we know it
> > will never be called?  If the latter, I don't think the savings are
> > worth it.
> 
> The motivation for the #ifdef was merely to reduce code size if neither
> of PCIEAER or EEH is enabled.  Happy to remove it.

That'd be great.

> I have a different question though.  We've often discussed deprecating
> portdrv and moving port services to the core instead.  I've stumbled
> across commit a39bd851dccf ("PCI/PM: Clear PCIe PME Status bit in core,
> not PCIe port driver"), wherein you moved pcie_pme_root_status_cleanup()
> from portdrv to the core, which allowed you to drop the ->resume_noirq
> callback from portdrv.
> 
> I've been thinking what moving port services to the core would look like
> and what your vision for that might be.  If that commit is any indication,
> it seems you'd probably prefer that pciehp_slot_reset() (as introduced in
> the present patch) is called directly from report_slot_reset() in
> drivers/pci/pcie/err.c.
> 
> That would eliminate much of the plumbing contained in the present patch
> to allow each port service driver to define a ->slot_reset callback and
> iterate over those callbacks.  pciehp is probably the only port service
> which requires special handling upon ->slot_reset and the same goes for
> a lot of the error handling and power management callbacks defined by
> port services.  So all that plumbing is probably just a very roundabout
> way of doing things.
> 
> When calling into port service code from core code, one needs to find
> the port service's driver data.  For now we can resort to
> pcie_port_find_device(), but I imagine once we move all port services
> to the core, we'll be able to access their data directly from
> struct pci_dev, e.g. via pdev->hotplug or pdev->pcie->hotplug pointers.

We managed to get rid of pcie_port_find_service() recently, and I'd
love to get rid of pcie_port_find_device() as well.  I'd like to get
rid of struct pcie_device, too, but that's visible via sysfs and would
be harder.  But maybe we could at least stop using it internally.

I don't know exactly what the ->slot_reset() path would look like, and
I'm not suggesting you need to change that for this patch.

Bjorn
