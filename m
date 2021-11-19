Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC3A4577F6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 21:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhKSU6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 15:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232523AbhKSU6T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 15:58:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EFA061A6C;
        Fri, 19 Nov 2021 20:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637355316;
        bh=kTtViGsleJDtOwfixieIl9J0AXpWncyP+fhWRRK9k88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cUTEFZr/VWA5wH2Ue1Fy0+pD+zyc8QHHs3VZ/N7dQYRaJTiV4mBxjuHxpd17Cl+qQ
         28iK7TByWc6Co4JM2rY4lgk5QpEq1TKnBQxb5DFkTAuz6e4rCJrQYtpmxf4d/v582k
         smTw1R6oUJDKkEhFm2viJZTmqi5kXEKklHuWxNATfxjqSazQbLoEv/WzRlRCGFAtb3
         Lgzxe7bLeZxsyDc/I+6iQy6IWISuXo6ckokCb3CqnLHPp05A/52V5mDOy27Z7B5HWX
         oYq2xKKB6ll0YB14NzZLZtBMz/ubtKI4gXDvkzaPEmbZCf7Z7AjdrkvsAYpNvjGUga
         JVF1fcnN2WgjQ==
Date:   Fri, 19 Nov 2021 14:55:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v5] PCI: vmd: Clean up domain before enumeration
Message-ID: <20211119205515.GA1962933@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b5f6d3-ff52-1bf6-994e-2aa0421c011a@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 01:48:59PM -0700, Patel, Nirmal wrote:
> On 11/16/2021 3:11 PM, Nirmal Patel wrote:
> > During VT-d pass-through, the VMD driver occasionally fails to
> > enumerate underlying NVMe devices when repetitive reboots are
> > performed in the guest OS. The issue can be resolved by resetting
> > VMD root ports for proper enumeration and triggering secondary bus
> > reset which will also propagate reset through downstream bridges.
> >
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
> > ---
> > ---
> > v4->v5: Fixing small nitpick fix.
> > v3->v4: Using pci_reset_bus function for secondary bus reset instead of
> >         manually triggering secondary bus reset, addressing review
> >         comments of v3.
> > v2->v3: Combining two functions into one, Remove redundant definations
> >         and Formatting fixes
> >
> >  drivers/pci/controller/vmd.c | 37 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index a5987e52700e..a905fce6232f 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -498,6 +498,40 @@ static inline void vmd_acpi_begin(void) { }
> >  static inline void vmd_acpi_end(void) { }
> >  #endif /* CONFIG_ACPI */
> >  
> > +static void vmd_domain_reset(struct vmd_dev *vmd)
> > +{
> > +	u16 bus, max_buses = resource_size(&vmd->resources[0]);
> > +	u8 dev, functions, fn, hdr_type;
> > +	char __iomem *base;
> > +
> > +	for (bus = 0; bus < max_buses; bus++) {
> > +		for (dev = 0; dev < 32; dev++) {
> > +			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> > +						PCI_DEVFN(dev, 0), 0);
> > +
> > +			hdr_type = readb(base + PCI_HEADER_TYPE) &
> > +					 PCI_HEADER_TYPE_MASK;
> > +
> > +			functions = (hdr_type & 0x80) ? 8 : 1;
> > +			for (fn = 0; fn < functions; fn++) {
> > +				base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> > +						PCI_DEVFN(dev, fn), 0);
> > +
> > +				hdr_type = readb(base + PCI_HEADER_TYPE) &
> > +						PCI_HEADER_TYPE_MASK;
> > +
> > +				if (hdr_type != PCI_HEADER_TYPE_BRIDGE ||
> > +				    (readw(base + PCI_CLASS_DEVICE) !=
> > +				     PCI_CLASS_BRIDGE_PCI))
> > +					continue;
> > +
> > +				memset_io(base + PCI_IO_BASE, 0,
> > +					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> > +			}
> > +		}
> > +	}
> > +}
> > +
> >  static void vmd_attach_resources(struct vmd_dev *vmd)
> >  {
> >  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> > @@ -801,6 +835,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >  	vmd_acpi_begin();
> >  
> >  	pci_scan_child_bus(vmd->bus);
> > +	vmd_domain_reset(vmd);
> > +	list_for_each_entry(child, &vmd->bus->children, node)
> > +		pci_reset_bus(child->self);
> >  	pci_assign_unassigned_bus_resources(vmd->bus);
> >  
> >  	/*
> 
> Hi
> 
> Gentle ping. Please let me know if you are okay with these changes
> (with Jon's Reviewed-by). Thanks.

This got assigned to me by mistake, so I just reassigned it to Lorenzo
in patchwork.  There's no hurry, we're only at v5.16-rc1.  It doesn't
appear to be a candidate for v5.16, and there's always "cc: stable" if
appropriate.

Bjorn
