Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76A467D1C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 19:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbhLCSVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 13:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbhLCSVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 13:21:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B13C061751
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 10:18:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD8E3B8266A
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 18:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179A5C53FAD;
        Fri,  3 Dec 2021 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638555489;
        bh=zRsjEafENhL4zBqz6g4jkgdwMTH2RkL44QINOPJ4/Ck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ey6vjHZw3bEFzy9F4qeM5qOB7cysnWKZ9V9o1WiYxBXrd+9Ws0Ck4kvdy0Rji526/
         +nSLhY9H4a6gX0/swvBrOOcw7pkozye+2f20d5YVcQ4FqO+477tVgQD9Dh1VdBFLWK
         c+cNpcb6cZKcaX3+iurfofHQ1xu/hhR4h9YqNVAos3qdtV61qFcE64y8gxPAj6e8zj
         PVzrKNtG7Hzh/uzzRh6t8qgm7IC9ptSlgt9O49O1FgqooikFquiN9G6Ama3/Cfl1Oa
         TD55umzStRXdRfLdUpV2O6BVHfDh4QSFudDLywkIUgGo0MYvqA0YF3zCwitwOOaDxU
         J0vdHu43N+nMQ==
Date:   Fri, 3 Dec 2021 12:18:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, jonathan.derrick@linux.dev,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5] PCI: vmd: Clean up domain before enumeration
Message-ID: <20211203181807.GA3009059@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116221136.85134-1-nirmal.patel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo]

On Tue, Nov 16, 2021 at 03:11:36PM -0700, Nirmal Patel wrote:
> During VT-d pass-through, the VMD driver occasionally fails to
> enumerate underlying NVMe devices when repetitive reboots are
> performed in the guest OS. The issue can be resolved by resetting
> VMD root ports for proper enumeration and triggering secondary bus
> reset which will also propagate reset through downstream bridges.

Hmm.  Does not say what the root cause is, just that it can be "fixed"
by a reset, but OK.

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
> ---
> ---
> v4->v5: Fixing small nitpick fix.
> v3->v4: Using pci_reset_bus function for secondary bus reset instead of
>         manually triggering secondary bus reset, addressing review
>         comments of v3.
> v2->v3: Combining two functions into one, Remove redundant definations
>         and Formatting fixes
> 
>  drivers/pci/controller/vmd.c | 37 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a5987e52700e..a905fce6232f 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -498,6 +498,40 @@ static inline void vmd_acpi_begin(void) { }
>  static inline void vmd_acpi_end(void) { }
>  #endif /* CONFIG_ACPI */
>  
> +static void vmd_domain_reset(struct vmd_dev *vmd)
> +{
> +	u16 bus, max_buses = resource_size(&vmd->resources[0]);
> +	u8 dev, functions, fn, hdr_type;
> +	char __iomem *base;

I don't understand what's going on here.

> +	for (bus = 0; bus < max_buses; bus++) {
> +		for (dev = 0; dev < 32; dev++) {
> +			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> +						PCI_DEVFN(dev, 0), 0);
> +
> +			hdr_type = readb(base + PCI_HEADER_TYPE) &
> +					 PCI_HEADER_TYPE_MASK;
> +			functions = (hdr_type & 0x80) ? 8 : 1;

This look like an open-coded version of pci_hdr_type() for every
possible device on every possible bus below the VMD, regardless of
whether that device actually exists.  So most of these reads will
result in Unsupported Request errors and 0xff data returns, which you
interpret as a multi-function device.

> +			for (fn = 0; fn < functions; fn++) {
> +				base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
> +						PCI_DEVFN(dev, fn), 0);
> +
> +				hdr_type = readb(base + PCI_HEADER_TYPE) &
> +						PCI_HEADER_TYPE_MASK;

So you open-code pci_hdr_type() again, for lots of functions that
don't exist.

> +				if (hdr_type != PCI_HEADER_TYPE_BRIDGE ||
> +				    (readw(base + PCI_CLASS_DEVICE) !=
> +				     PCI_CLASS_BRIDGE_PCI))
> +					continue;

This at least will skip the rest for functions that don't exist, since
hdr_type will be 0x7f (not 0x01, PCI_HEADER_TYPE_BRIDGE).

> +
> +				memset_io(base + PCI_IO_BASE, 0,
> +					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);

And here you clear the base & limit registers of the IO and MEM
windows of each bridge, again with basically a hand-written special
case of pci_write_config_*().

This looks like you're trying to disable the windows.  AFAICT, the
spec doesn't say what happens to the window base/limit registers after
reset, but it does say that reset clears the I/O Space Enable and
Memory Space Enable in the Command Register.  For bridges, that will
disable the windows.

Writing zero to both base & limit does not disable the windows; it
just sets them to [io 0x0000-0x0fff], [mem 0x00000000-0x000fffff],
etc.

So I'm not really convinced that this function is necessary at all,
given that you do a secondary bus reset on every VMD root port right
afterwards.

> +			}
> +		}
> +	}
> +}
> +
>  static void vmd_attach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> @@ -801,6 +835,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);
> +	vmd_domain_reset(vmd);
> +	list_for_each_entry(child, &vmd->bus->children, node)
> +		pci_reset_bus(child->self);
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
>  	/*
> -- 
> 2.27.0
> 
