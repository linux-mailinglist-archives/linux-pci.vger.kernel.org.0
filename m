Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABF134EE6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAHVcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:32:16 -0500
Received: from ale.deltatee.com ([207.54.116.67]:49790 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHVcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:32:16 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ipIw1-0000nK-T2; Wed, 08 Jan 2020 14:32:15 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ipIvz-0001D7-3B; Wed, 08 Jan 2020 14:32:11 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kit Chow <kchow@gigaio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed,  8 Jan 2020 14:32:08 -0700
Message-Id: <20200108213208.4612-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kchow@gigaio.com, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au, mika.westerberg@linux.intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v5] PCI: Fix disabling of bridge BARs when assigning bus resources
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One odd quirk of PLX switches is that their upstream bridge port has
256K of space allocated behind its BAR0 (most other bridge
implementations do not report any BAR space). The lspci for such  device
looks like:

  04:00.0 PCI bridge: PLX Technology, Inc. PEX 8724 24-Lane, 6-Port PCI
            Express Gen 3 (8 GT/s) Switch, 19 x 19mm FCBGA (rev ca)
	    (prog-if 00 [Normal decode])
      Physical Slot: 1
      Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0
      Memory at 90a00000 (32-bit, non-prefetchable) [size=256K]
      Bus: primary=04, secondary=05, subordinate=0a, sec-latency=0
      I/O behind bridge: 00002000-00003fff
      Memory behind bridge: 90000000-909fffff
      Prefetchable memory behind bridge: 0000380000800000-0000380000bfffff
      Kernel driver in use: pcieport

It's not clear what the purpose of the memory at 0x90a00000 is, and
currently the kernel never actually uses it for anything. In most cases,
it's safely ignored and does not cause a problem.

However, when the kernel assigns the resource addresses (with the
pci=realloc command line parameter, for example) it can inadvertently
disable the struct resource corresponding to the BAR. When this happens,
lspci will report this memory as ignored:

   Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]

This is because the kernel reports a zero start address and zero flags
in the corresponding sysfs resource file and in /proc/bus/pci/devices.
Investigation with 'lspci -x', however shows the BIOS-assigned address
will still be programmed in the device's BAR registers.

It's clearly a bug that the kernel's view of the registers differs from
what's actually programmed in the BAR, but in most cases, this still
won't result in a visible issue because nothing uses the memory,
so nothing is affected. However, a big problem shows up when an IOMMU
is in use: the IOMMU will not reserve this space in the IOVA because the
kernel no longer thinks the range is valid. (See
dmar_init_reserved_ranges() for the Intel implementation of this.)

Without the proper reserved range, we have a situation where a DMA
mapping may occasionally allocate an IOVA which the PCI bus will actually
route to a BAR in the PLX switch. This will result in some random DMA
writes not actually writing to the RAM they are supposed to, or random
DMA reads returning all FFs from the PLX BAR when it's supposed to have
read from RAM.

The problem is caused in pci_assign_unassigned_root_bus_resources().
When any resource from a bridge device fails to get assigned, the code
sets the resource's flags to zero. This makes sense for bridge resources,
as they will be re-enabled later, but for regular BARs, it disables them
permanently.

The code in question seems to intend to check if "dev->subordinate" is
zero to determine whether a device is a bridge, however this is not
likely valid as there might be a bridge without a subordinate bus due to
running out of bus numbers or other cases.

To fix these issues we instead check that the idx is in the
PCI_BRIDGE_RESOURCES range which are only used for bridge windows and
thus is sufficient for the "dev->subordinate" check and will also
prevent the bug above from clobbering PLX devices' regular BARs.

The bug was caused in pci_assign_unassigned_root_bus_resources() but the
same pattern is in pci_assign_unassigned_bridge_resources() so we
changed the code for consistency in both places.

Reported-by: Kit Chow <kchow@gigaio.com>
Fixes: da7822e5ad71 ("PCI: update bridge resources to get more big ranges when allocating space (again)")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


v5 fixes a bunch of nits in the commit message and makes the same change to
the same pattern in both pci_assign_unassigned_root_bus_resources() and
pci_assign_unassigned_bridge_resources().

The patch is based on v5.5-rc5 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem pci_realloc_v5

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f279826204eb..416cb625395e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1803,11 +1803,15 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	/* Restore size and flags */
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
+		int idx;

 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
+
+		idx = res - &fail_res->dev->resource[0];
+		if (idx >= PCI_BRIDGE_RESOURCES &&
+		    idx <= PCI_BRIDGE_RESOURCE_END)
 			res->flags = 0;
 	}
 	free_list(&fail_head);
@@ -2055,11 +2059,15 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	/* Restore size and flags */
 	list_for_each_entry(fail_res, &fail_head, list) {
 		struct resource *res = fail_res->res;
+		int idx;

 		res->start = fail_res->start;
 		res->end = fail_res->end;
 		res->flags = fail_res->flags;
-		if (fail_res->dev->subordinate)
+
+		idx = res - &fail_res->dev->resource[0];
+		if (idx >= PCI_BRIDGE_RESOURCES &&
+		    idx <= PCI_BRIDGE_RESOURCE_END)
 			res->flags = 0;
 	}
 	free_list(&fail_head);
--
2.20.1
