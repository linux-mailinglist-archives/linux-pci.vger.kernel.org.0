Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883EB27A530
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI1B0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:26:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:64441 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgI1B0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:26:08 -0400
IronPort-SDR: zpfYRArASu6XaUezuyRIHuBCWCxdFNcxNJU/96qiJXBvvP36OHAYAKvLMbH5scvk6JDetLbUSW
 PSVg3ZEc5PCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="141939476"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="141939476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:26:23 -0700
IronPort-SDR: 97q8wsth1ijdCrQtfVzMUbssknhglp8wwkIh5U76AoMCcssH/ZG9TXFg2shaAZZoDAUslv6pHh
 HbW5CFyEzlVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="456639876"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2020 18:26:22 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/3] PCI: Create helper to release/restore bridge resources
Date:   Sun, 27 Sep 2020 21:06:07 -0400
Message-Id: <20200928010609.5375-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200928010609.5375-1-jonathan.derrick@intel.com>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moves bridge release and restore code into a common helper. No
functional changes.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/setup-bus.c | 49 +++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3951e02b7ded..f22502e8e6e6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2047,6 +2047,33 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 					       available_mmio_pref);
 }
 
+static void release_and_restore_resources(struct list_head *head)
+{
+	struct pci_dev_resource *dev_res;
+
+	list_for_each_entry(dev_res, head, list)
+		pci_bus_release_bridge_resources(dev_res->dev->bus,
+						 dev_res->flags & PCI_RES_TYPE_MASK,
+						 whole_subtree);
+
+	/* Restore size and flags */
+	list_for_each_entry(dev_res, head, list) {
+		struct resource *res = dev_res->res;
+		int idx;
+
+		res->start = dev_res->start;
+		res->end = dev_res->end;
+		res->flags = dev_res->flags;
+
+		if (pci_is_bridge(dev_res->dev)) {
+			idx = res - &dev_res->dev->resource[0];
+			if (idx >= PCI_BRIDGE_RESOURCES &&
+			    idx <= PCI_BRIDGE_RESOURCE_END)
+				res->flags = 0;
+		}
+	}
+}
+
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
@@ -2088,27 +2115,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 	 * Try to release leaf bridge's resources that aren't big enough
 	 * to contain child device resources.
 	 */
-	list_for_each_entry(fail_res, &fail_head, list)
-		pci_bus_release_bridge_resources(fail_res->dev->bus,
-						 fail_res->flags & PCI_RES_TYPE_MASK,
-						 whole_subtree);
-
-	/* Restore size and flags */
-	list_for_each_entry(fail_res, &fail_head, list) {
-		struct resource *res = fail_res->res;
-		int idx;
-
-		res->start = fail_res->start;
-		res->end = fail_res->end;
-		res->flags = fail_res->flags;
-
-		if (pci_is_bridge(fail_res->dev)) {
-			idx = res - &fail_res->dev->resource[0];
-			if (idx >= PCI_BRIDGE_RESOURCES &&
-			    idx <= PCI_BRIDGE_RESOURCE_END)
-				res->flags = 0;
-		}
-	}
+	release_and_restore_resources(&fail_head);
 	free_list(&fail_head);
 
 	goto again;
-- 
2.18.1

