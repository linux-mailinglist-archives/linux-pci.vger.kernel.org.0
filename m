Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCEA15DCE5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 16:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387683AbgBNP4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 10:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387675AbgBNP4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6DEF222C4;
        Fri, 14 Feb 2020 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695771;
        bh=4SZ3LZ4NJqJF+7zF2Dlcszw7U77PR0xJMMQ+rBFKY8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzuqnol1/wKDLRsHPHss3xpxNEnPloYE7PsYhIN6cN8Qqwpxj9JMGjCQsWmY3o2/i
         YPa0pxHd/qXbMM8aENBEpsDkVrYvdFCQ6NBzYQixXpizvNGFfFJJiziFIr0iFontil
         1xZFsugvE9PKYMLyiKBElQl+ooi3wFJVDju82NZE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>, Kit Chow <kchow@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 337/542] PCI: Don't disable bridge BARs when assigning bus resources
Date:   Fri, 14 Feb 2020 10:45:29 -0500
Message-Id: <20200214154854.6746-337-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Logan Gunthorpe <logang@deltatee.com>

[ Upstream commit 9db8dc6d0785225c42a37be7b44d1b07b31b8957 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f279826204eb4..591161ce0f516 100644
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
 
-- 
2.20.1

