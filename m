Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A127520A40A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404761AbgFYRa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 13:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404698AbgFYRa4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 13:30:56 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D0320789;
        Thu, 25 Jun 2020 17:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593106255;
        bh=FwCQ696O7Br9AROnL6MUzsJIYGTIRPIdruuU47avOfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VcR6UPQLooXvts5AMZD1x7Qy6i3ZI74p0iNvVpd12tmDSmSQ7d1+khqitauC42+as
         fL/B9TaT3Ea4Mzg8BtsqeXk86xor0VZGaXUdnT1M/6KjNXZ5e/c1PRIPWmqMbLR+VY
         Ls07poO3E+Yr065NFY9vxfsjXA1nyn/pwH3UN8Xg=
Date:   Thu, 25 Jun 2020 12:30:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>, shyjumon.n@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Message-ID: <20200625173053.GA2694537@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i8dCN=HMFk_+ZX-Wr73P6kdQBtV0i3FtrZrO9cegXsvQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 25, 2020 at 01:30:53PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2020 at 11:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> > > StorageD3Enable is a boolean property that indicates that the
> > > platform wants to use D3 for PCIe storage drives during
> > > suspend-to-idle. It is a BIOS work around that is currently in
> > > use on shipping systems like some Intel Comet Lake platforms. It
> > > is meant to change default driver policy for suspend that may
> > > cause higher power consumption.

> > > +/**
> > > + * pci_acpi_storage_d3 - whether root port requests D3 for idle suspend
> > > + * @pdev: PCI device to check
> > > + *
> > > + * Returns true if the ACPI companion device contains the "StorageD3Enable"
> > > + * _DSD property and the value is 1. This indicates that the root port is
> > > + * used by a storage device and the platform is requesting D3 for the
> > > + * device during suspend to idle in order to support platform pm.
> > > + */
> > > +bool pci_acpi_storage_d3(struct pci_dev *dev)
> > > +{
> > > +     const struct fwnode_handle *fwnode;
> > > +     struct acpi_device *adev;
> > > +     struct pci_dev *root;
> > > +     acpi_handle handle;
> > > +     acpi_status status;
> > > +     bool ret = false;
> > > +     u8 val;
> > > +
> > > +     /*
> > > +      * Look for _DSD property specifying that the storage device on
> > > +      * the port must use D3 to support deep platform power savings during
> > > +      * suspend-to-idle
> > > +      */
> > > +     root = pci_find_pcie_root_port(dev);
> >
> > I think this would need to be updated to apply to v5.8-rc1 after
> > 6ae72bfa656e ("PCI: Unify pcie_find_root_port() and
> > pci_find_pcie_root_port()").
> >
> > https://git.kernel.org/linus/6ae72bfa656e
> >
> > > +     if (!root)
> > > +             return false;
> > > +
> > > +     adev = ACPI_COMPANION(&root->dev);
> > > +     if (!adev) {
> > > +             /*
> > > +              * It is possible that the ACPI companion is not yet bound
> > > +              * for the root port so look it up manually here.
> > > +              */
> > > +             if (!adev && !pci_dev_is_added(root))
> > > +                     adev = acpi_pci_find_companion(&root->dev);
> >
> > I see that you copied this "ACPI companion not yet bound" thing from
> > acpi_pci_bridge_d3().  But it's ugly.
> >
> > Isn't there a way we can bind the ACPI companion during normal PCI
> > enumeration so we don't need this exception case?
> >
> > I really do not like the idea of putting this code in the PCI core
> > because AFAICT the PCI core can do nothing with this information.
> >
> > If we could make sure during enumeration that the root port always has
> > an ACPI companion, this code could go to the nvme driver itself.  And
> > we could also clean up the ugliness in acpi_pci_bridge_d3().
> >
> > Rafael, is that possible?  I don't really know how the companion
> > device gets set.
> 
> That's a bit convoluted.
> 
> device_add() calls device_platform_notify(), before calling bus_add_device().
> 
> device_platform_notify() calls acpi_platform_notify() which invokes
> acpi_device_notify() that looks for the companion via
> type->find_companion() which for PCI points to
> acpi_pci_find_companion().  If found, the companion is attached to the
> dev structure as a physical_node, via acpi_bind_one().
> 
> So by the time bus_probe_device() runs, the companion should be there
> already - if it is there at all.
> 
> The parent ACPI companion should be present when the child is probing
> too, as per the above.
> 
> > Maybe this is could be done somewhere around pci_device_add()?
> 
> It is done in there.
> 
> It is not necessary to call acpi_pci_find_companion() from
> pci_acpi_storage_d3() as long as that function is required to be
> called by the target device's driver probe or later.

OK, great.  IIUC, that means this function doesn't need to be in
drivers/pci and it could be moved to the NVMe code.

> Ths acpi_pci_bridge_d3() case is different, though, AFAICS, because it
> is invoked in the pci_pm_init() path, via pci_bridge_d3_possible(),
> and that gets called from pci_device_add() *before* calling
> device_add().
> 
> Mika, is that why acpi_pci_find_companion() gets called from
> acpi_pci_bridge_d3()?

Is pdev->bridge_d3 really needed before pci_device_add()?  It would be
really nice if there were a way to get rid of that manual lookup of
the companion device in acpi_pci_bridge_d3().

Bjorn
