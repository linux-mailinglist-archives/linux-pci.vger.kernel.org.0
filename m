Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2C139A81
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 21:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMUH7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 15:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgAMUH7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 15:07:59 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD1672084D;
        Mon, 13 Jan 2020 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578946078;
        bh=O0K16XQn8uPCH5+iYfVbIfAs5xSRq+A5ma0gRsIAXPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bKewygt7CpRB4fM3uRvYlASHYFGvm+V67n6VI6W4z9+kGWeJIDToKFm5hF3KqcMBc
         XJSBDrIwlRwU+FVDJgsMfz78Z9IJVZSpX22kuTp2aHe2lQ6BFc5oBDdpJ0dBnKJbx0
         5hpewe6e9esnOD3Tg+nGTsELDm5Y8V5w9JFjxoqk=
Date:   Mon, 13 Jan 2020 14:07:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5] PCI: Fix disabling of bridge BARs when assigning bus
 resources
Message-ID: <20200113200756.GA97441@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108213208.4612-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 08, 2020 at 02:32:08PM -0700, Logan Gunthorpe wrote:
> One odd quirk of PLX switches is that their upstream bridge port has
> 256K of space allocated behind its BAR0 (most other bridge
> implementations do not report any BAR space). The lspci for such  device
> looks like:
> 
>   04:00.0 PCI bridge: PLX Technology, Inc. PEX 8724 24-Lane, 6-Port PCI
>             Express Gen 3 (8 GT/s) Switch, 19 x 19mm FCBGA (rev ca)
> 	    (prog-if 00 [Normal decode])
>       Physical Slot: 1
>       Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0
>       Memory at 90a00000 (32-bit, non-prefetchable) [size=256K]
>       Bus: primary=04, secondary=05, subordinate=0a, sec-latency=0
>       I/O behind bridge: 00002000-00003fff
>       Memory behind bridge: 90000000-909fffff
>       Prefetchable memory behind bridge: 0000380000800000-0000380000bfffff
>       Kernel driver in use: pcieport
> 
> It's not clear what the purpose of the memory at 0x90a00000 is, and
> currently the kernel never actually uses it for anything. In most cases,
> it's safely ignored and does not cause a problem.
> 
> However, when the kernel assigns the resource addresses (with the
> pci=realloc command line parameter, for example) it can inadvertently
> disable the struct resource corresponding to the BAR. When this happens,
> lspci will report this memory as ignored:
> 
>    Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]
> 
> This is because the kernel reports a zero start address and zero flags
> in the corresponding sysfs resource file and in /proc/bus/pci/devices.
> Investigation with 'lspci -x', however shows the BIOS-assigned address
> will still be programmed in the device's BAR registers.
> 
> It's clearly a bug that the kernel's view of the registers differs from
> what's actually programmed in the BAR, but in most cases, this still
> won't result in a visible issue because nothing uses the memory,
> so nothing is affected. However, a big problem shows up when an IOMMU
> is in use: the IOMMU will not reserve this space in the IOVA because the
> kernel no longer thinks the range is valid. (See
> dmar_init_reserved_ranges() for the Intel implementation of this.)
> 
> Without the proper reserved range, we have a situation where a DMA
> mapping may occasionally allocate an IOVA which the PCI bus will actually
> route to a BAR in the PLX switch. This will result in some random DMA
> writes not actually writing to the RAM they are supposed to, or random
> DMA reads returning all FFs from the PLX BAR when it's supposed to have
> read from RAM.
> 
> The problem is caused in pci_assign_unassigned_root_bus_resources().
> When any resource from a bridge device fails to get assigned, the code
> sets the resource's flags to zero. This makes sense for bridge resources,
> as they will be re-enabled later, but for regular BARs, it disables them
> permanently.
> 
> The code in question seems to intend to check if "dev->subordinate" is
> zero to determine whether a device is a bridge, however this is not
> likely valid as there might be a bridge without a subordinate bus due to
> running out of bus numbers or other cases.
> 
> To fix these issues we instead check that the idx is in the
> PCI_BRIDGE_RESOURCES range which are only used for bridge windows and
> thus is sufficient for the "dev->subordinate" check and will also
> prevent the bug above from clobbering PLX devices' regular BARs.
> 
> The bug was caused in pci_assign_unassigned_root_bus_resources() but the
> same pattern is in pci_assign_unassigned_bridge_resources() so we
> changed the code for consistency in both places.
> 
> Reported-by: Kit Chow <kchow@gigaio.com>
> Fixes: da7822e5ad71 ("PCI: update bridge resources to get more big ranges when allocating space (again)")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/resource for v5.6, thanks!

I added a check of pci_is_bridge() as another hint that this is really
a bridge-specific issue.  Let me know if that breaks anything.

commit 9db8dc6d0785 ("PCI: Don't disable bridge BARs when assigning bus resources")
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Wed Jan 8 14:32:08 2020 -0700

    PCI: Don't disable bridge BARs when assigning bus resources
    
    Some PCI bridges implement BARs in addition to bridge windows.  For
    example, here's a PLX switch:
    
      04:00.0 PCI bridge: PLX Technology, Inc. PEX 8724 24-Lane, 6-Port PCI
                Express Gen 3 (8 GT/s) Switch, 19 x 19mm FCBGA (rev ca)
    	    (prog-if 00 [Normal decode])
          Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0
          Memory at 90a00000 (32-bit, non-prefetchable) [size=256K]
          Bus: primary=04, secondary=05, subordinate=0a, sec-latency=0
          I/O behind bridge: 00002000-00003fff
          Memory behind bridge: 90000000-909fffff
          Prefetchable memory behind bridge: 0000380000800000-0000380000bfffff
    
    Previously, when the kernel assigned resource addresses (with the
    pci=realloc command line parameter, for example) it could clear the struct
    resource corresponding to the BAR.  When this happened, lspci would report
    this BAR as "ignored":
    
       Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]
    
    This is because the kernel reports a zero start address and zero flags
    in the corresponding sysfs resource file and in /proc/bus/pci/devices.
    Investigation with 'lspci -x', however, shows the BIOS-assigned address
    will still be programmed in the device's BAR registers.
    
    It's clearly a bug that the kernel lost track of the BAR value, but in most
    cases, this still won't result in a visible issue because nothing uses the
    memory, so nothing is affected.  However, when an IOMMU is in use, it will
    not reserve this space in the IOVA because the kernel no longer thinks the
    range is valid.  (See dmar_init_reserved_ranges() for the Intel
    implementation of this.)
    
    Without the proper reserved range, a DMA mapping may allocate an IOVA that
    matches a bridge BAR, which results in DMA accesses going to the BAR
    instead of the intended RAM.
    
    The problem was in pci_assign_unassigned_root_bus_resources().  When any
    resource from a bridge device fails to get assigned, the code set the
    resource's flags to zero.  This makes sense for bridge windows, as they
    will be re-enabled later, but for regular BARs, it makes the kernel
    permanently lose track of the fact that they decode address space.
    
    Change pci_assign_unassigned_root_bus_resources() and
    pci_assign_unassigned_bridge_resources() so they only clear "res->flags"
    for bridge *windows*, not bridge BARs.
    
    Fixes: da7822e5ad71 ("PCI: update bridge resources to get more big ranges when allocating space (again)")
    Link: https://lore.kernel.org/r/20200108213208.4612-1-logang@deltatee.com
    [bhelgaas: commit log, check for pci_is_bridge()]
    Reported-by: Kit Chow <kchow@gigaio.com>
    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f279826204eb..591161ce0f51 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1803,12 +1803,18 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	/* Restore size and flags */
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
+		int idx;
 
 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
-			res->flags = 0;
+
+		if (pci_is_bridge(fail_res->dev)) {
+			idx = res - &fail_res->dev->resource[0];
+			if (idx >= PCI_BRIDGE_RESOURCES &&
+			    idx <= PCI_BRIDGE_RESOURCE_END)
+				res->flags = 0;
+		}
 	}
 	free_list(&fail_head);
 
@@ -2055,12 +2061,18 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	/* Restore size and flags */
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
+		int idx;
 
 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
-			res->flags = 0;
+
+		if (pci_is_bridge(fail_res->dev)) {
+			idx = res - &fail_res->dev->resource[0];
+			if (idx >= PCI_BRIDGE_RESOURCES &&
+			    idx <= PCI_BRIDGE_RESOURCE_END)
+				res->flags = 0;
+		}
 	}
 	free_list(&fail_head);
 
