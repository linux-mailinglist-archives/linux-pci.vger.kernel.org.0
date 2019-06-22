Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F584F841
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVVDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 17:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFVVDk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jun 2019 17:03:40 -0400
Received: from localhost (173.sub-174-234-4.myvzw.com [174.234.4.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA67F20657;
        Sat, 22 Jun 2019 21:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561237419;
        bh=nb6TH9VIl779URO+eN/PRQF37XVlb6F19oGN4sP9cX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThZ3uy7BoNdzKX2SUuzKvZWfGiRnMRWBuMfK8ju8oDPqB1xshh0mxSmeKrhZeUj7e
         UnutaECcekgA9IUB7pjJT3sf61qRUaYM8EBoN1ryWImzAt+Tq1f5Li8oBpJqAy6sQp
         J38thrmemINWfxkxbpum39iH6WCIrhjqBp0t7wdU=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: Simplify pci_bus_distribute_available_resources()
Date:   Sat, 22 Jun 2019 16:03:10 -0500
Message-Id: <20190622210310.180905-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190622210310.180905-1-helgaas@kernel.org>
References: <20190622210310.180905-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Reorder pci_bus_distribute_available_resources() to group related code
together.  No functional change intended.

Link: https://lore.kernel.org/r/PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
Based-on-patch-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
[bhelgaas: extracted from larger patch]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

---

The original order was:

  1) remaining_io = available_io

  2) for_each_pci_bridge(dev, bus)
       # count hotplug_bridges, normal_bridges

  3) for_each_pci_bridge(dev, bus)
       if (!dev->is_hotplug_bridge)
	 # reduce remaining_io by dev window

  4) if (hotplug_bridges + normal_bridges == 1)
       # distribute available_io to the single bridge
       # return

  5) for_each_pci_bridge(dev, bus)
       # distribute remaining_io to hotplug bridges

Blocks 2 and 4 don't require remaining_io, so do them first.  Blocks 1, 3,
5 deal with remaining_io, so group them together.
---
 drivers/pci/setup-bus.c | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0cdd5ff389de..af28af898e42 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1860,16 +1860,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	extend_bridge_window(bridge, mmio_pref_res, add_list,
 			     available_mmio_pref);
 
-	/*
-	 * Calculate the total amount of extra resource space we can
-	 * pass to bridges below this one.  This is basically the
-	 * extra space reduced by the minimal required space for the
-	 * non-hotplug bridges.
-	 */
-	remaining_io = available_io;
-	remaining_mmio = available_mmio;
-	remaining_mmio_pref = available_mmio_pref;
-
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
 	 * are on this bus.  We will distribute the additional available
@@ -1882,6 +1872,31 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			normal_bridges++;
 	}
 
+	/*
+	 * There is only one bridge on the bus so it gets all available
+	 * resources which it can then distribute to the possible hotplug
+	 * bridges below.
+	 */
+	if (hotplug_bridges + normal_bridges == 1) {
+		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
+		if (dev->subordinate) {
+			pci_bus_distribute_available_resources(dev->subordinate,
+				add_list, available_io, available_mmio,
+				available_mmio_pref);
+		}
+		return;
+	}
+
+	/*
+	 * Calculate the total amount of extra resource space we can
+	 * pass to bridges below this one.  This is basically the
+	 * extra space reduced by the minimal required space for the
+	 * non-hotplug bridges.
+	 */
+	remaining_io = available_io;
+	remaining_mmio = available_mmio;
+	remaining_mmio_pref = available_mmio_pref;
+
 	for_each_pci_bridge(dev, bus) {
 		const struct resource *res;
 
@@ -1905,21 +1920,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			remaining_mmio_pref -= resource_size(res);
 	}
 
-	/*
-	 * There is only one bridge on the bus so it gets all available
-	 * resources which it can then distribute to the possible hotplug
-	 * bridges below.
-	 */
-	if (hotplug_bridges + normal_bridges == 1) {
-		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate) {
-			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, available_io, available_mmio,
-				available_mmio_pref);
-		}
-		return;
-	}
-
 	/*
 	 * Go over devices on this bus and distribute the remaining
 	 * resource space between hotplug bridges.
-- 
2.22.0.410.gd8fdbe21b5-goog

