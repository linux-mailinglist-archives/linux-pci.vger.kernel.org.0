Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFC95ACD5C
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiIEICY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiIEICU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:02:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BEA46DAD
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364939; x=1693900939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n92g9MSOjk5MfVSpWVlvJzAU0ITXzqX44z4m4ZEX2rk=;
  b=Luz+O/KoVu88styAEIi+LfiMoEFe48rAPpJiRYtvQ373mg6CusB4YJhz
   imTUsNNBFPOOuO6tCQ95m1xMC0wjuMwUklb+saSRNFmATG3fxcZ2Me5e7
   YzfQYf+RLi2Mjh24N1+R8RQ3cbnmtj56h4wBGIUI3eA7xJ3R7WKSbL6bm
   q8sXjij+AMQShD8PrusvUH/M7NmhOb9vAtfboH6HKHdms5R5zoU3FBbOy
   AoU6FFofmdaZkQtnDq8qW1jVwOF86WfuiqF5IIQ/8Mgk/qvwDl6ZqbQZt
   Jt2JJkrqYX2idLn1xYQGLSGU9cGKW9j60GSNElXP8mzJRrtT8fNyVspx2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="322501314"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="322501314"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="942012280"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2022 01:02:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CB03F238; Mon,  5 Sep 2022 11:02:32 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/6] PCI: Move pci_assign_unassigned_root_bus_resources()
Date:   Mon,  5 Sep 2022 11:02:29 +0300
Message-Id: <20220905080232.36087-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We need to be able to call pci_bridge_distribute_available_resources()
from this function so move it accordingly to avoid need for forward
declaration.

No functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 226 ++++++++++++++++++++--------------------
 1 file changed, 113 insertions(+), 113 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8cb68e6f6ef9..3b981da0fb4e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1745,119 +1745,6 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 }
 #endif
 
-/*
- * First try will not touch PCI bridge res.
- * Second and later try will clear small leaf bridge res.
- * Will stop till to the max depth if can not find good one.
- */
-void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
-{
-	LIST_HEAD(realloc_head);
-	/* List of resources that want additional resources */
-	struct list_head *add_list = NULL;
-	int tried_times = 0;
-	enum release_type rel_type = leaf_only;
-	LIST_HEAD(fail_head);
-	struct pci_dev_resource *fail_res;
-	int pci_try_num = 1;
-	enum enable_type enable_local;
-
-	/* Don't realloc if asked to do so */
-	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
-	if (pci_realloc_enabled(enable_local)) {
-		int max_depth = pci_bus_get_depth(bus);
-
-		pci_try_num = max_depth + 1;
-		dev_info(&bus->dev, "max bus depth: %d pci_try_num: %d\n",
-			 max_depth, pci_try_num);
-	}
-
-again:
-	/*
-	 * Last try will use add_list, otherwise will try good to have as must
-	 * have, so can realloc parent bridge resource
-	 */
-	if (tried_times + 1 == pci_try_num)
-		add_list = &realloc_head;
-	/*
-	 * Depth first, calculate sizes and alignments of all subordinate buses.
-	 */
-	__pci_bus_size_bridges(bus, add_list);
-
-	/* Depth last, allocate resources and update the hardware. */
-	__pci_bus_assign_resources(bus, add_list, &fail_head);
-	if (add_list)
-		BUG_ON(!list_empty(add_list));
-	tried_times++;
-
-	/* Any device complain? */
-	if (list_empty(&fail_head))
-		goto dump;
-
-	if (tried_times >= pci_try_num) {
-		if (enable_local == undefined)
-			dev_info(&bus->dev, "Some PCI device resources are unassigned, try booting with pci=realloc\n");
-		else if (enable_local == auto_enabled)
-			dev_info(&bus->dev, "Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off\n");
-
-		free_list(&fail_head);
-		goto dump;
-	}
-
-	dev_info(&bus->dev, "No. %d try to assign unassigned res\n",
-		 tried_times + 1);
-
-	/* Third times and later will not check if it is leaf */
-	if ((tried_times + 1) > 2)
-		rel_type = whole_subtree;
-
-	/*
-	 * Try to release leaf bridge's resources that doesn't fit resource of
-	 * child device under that bridge.
-	 */
-	list_for_each_entry(fail_res, &fail_head, list)
-		pci_bus_release_bridge_resources(fail_res->dev->bus,
-						 fail_res->flags & PCI_RES_TYPE_MASK,
-						 rel_type);
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
-	free_list(&fail_head);
-
-	goto again;
-
-dump:
-	/* Dump the resource on buses */
-	pci_bus_dump_resources(bus);
-}
-
-void __init pci_assign_unassigned_resources(void)
-{
-	struct pci_bus *root_bus;
-
-	list_for_each_entry(root_bus, &pci_root_buses, node) {
-		pci_assign_unassigned_root_bus_resources(root_bus);
-
-		/* Make sure the root bridge has a companion ACPI device */
-		if (ACPI_HANDLE(root_bus->bridge))
-			acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
-	}
-}
-
 static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 				 struct list_head *add_list,
 				 resource_size_t new_size)
@@ -2047,6 +1934,119 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 					       available_mmio_pref);
 }
 
+/*
+ * First try will not touch PCI bridge res.
+ * Second and later try will clear small leaf bridge res.
+ * Will stop till to the max depth if can not find good one.
+ */
+void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
+{
+	LIST_HEAD(realloc_head);
+	/* List of resources that want additional resources */
+	struct list_head *add_list = NULL;
+	int tried_times = 0;
+	enum release_type rel_type = leaf_only;
+	LIST_HEAD(fail_head);
+	struct pci_dev_resource *fail_res;
+	int pci_try_num = 1;
+	enum enable_type enable_local;
+
+	/* Don't realloc if asked to do so */
+	enable_local = pci_realloc_detect(bus, pci_realloc_enable);
+	if (pci_realloc_enabled(enable_local)) {
+		int max_depth = pci_bus_get_depth(bus);
+
+		pci_try_num = max_depth + 1;
+		dev_info(&bus->dev, "max bus depth: %d pci_try_num: %d\n",
+			 max_depth, pci_try_num);
+	}
+
+again:
+	/*
+	 * Last try will use add_list, otherwise will try good to have as must
+	 * have, so can realloc parent bridge resource
+	 */
+	if (tried_times + 1 == pci_try_num)
+		add_list = &realloc_head;
+	/*
+	 * Depth first, calculate sizes and alignments of all subordinate buses.
+	 */
+	__pci_bus_size_bridges(bus, add_list);
+
+	/* Depth last, allocate resources and update the hardware. */
+	__pci_bus_assign_resources(bus, add_list, &fail_head);
+	if (add_list)
+		BUG_ON(!list_empty(add_list));
+	tried_times++;
+
+	/* Any device complain? */
+	if (list_empty(&fail_head))
+		goto dump;
+
+	if (tried_times >= pci_try_num) {
+		if (enable_local == undefined)
+			dev_info(&bus->dev, "Some PCI device resources are unassigned, try booting with pci=realloc\n");
+		else if (enable_local == auto_enabled)
+			dev_info(&bus->dev, "Automatically enabled pci realloc, if you have problem, try booting with pci=realloc=off\n");
+
+		free_list(&fail_head);
+		goto dump;
+	}
+
+	dev_info(&bus->dev, "No. %d try to assign unassigned res\n",
+		 tried_times + 1);
+
+	/* Third times and later will not check if it is leaf */
+	if ((tried_times + 1) > 2)
+		rel_type = whole_subtree;
+
+	/*
+	 * Try to release leaf bridge's resources that doesn't fit resource of
+	 * child device under that bridge.
+	 */
+	list_for_each_entry(fail_res, &fail_head, list)
+		pci_bus_release_bridge_resources(fail_res->dev->bus,
+						 fail_res->flags & PCI_RES_TYPE_MASK,
+						 rel_type);
+
+	/* Restore size and flags */
+	list_for_each_entry(fail_res, &fail_head, list) {
+		struct resource *res = fail_res->res;
+		int idx;
+
+		res->start = fail_res->start;
+		res->end = fail_res->end;
+		res->flags = fail_res->flags;
+
+		if (pci_is_bridge(fail_res->dev)) {
+			idx = res - &fail_res->dev->resource[0];
+			if (idx >= PCI_BRIDGE_RESOURCES &&
+			    idx <= PCI_BRIDGE_RESOURCE_END)
+				res->flags = 0;
+		}
+	}
+	free_list(&fail_head);
+
+	goto again;
+
+dump:
+	/* Dump the resource on buses */
+	pci_bus_dump_resources(bus);
+}
+
+void __init pci_assign_unassigned_resources(void)
+{
+	struct pci_bus *root_bus;
+
+	list_for_each_entry(root_bus, &pci_root_buses, node) {
+		pci_assign_unassigned_root_bus_resources(root_bus);
+
+		/* Make sure the root bridge has a companion ACPI device */
+		if (ACPI_HANDLE(root_bus->bridge))
+			acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
+	}
+}
+
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 {
 	struct pci_bus *parent = bridge->subordinate;
-- 
2.35.1

