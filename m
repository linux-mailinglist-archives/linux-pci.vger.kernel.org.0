Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF35958E1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiHPKsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiHPKsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:48:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E9B24B7
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644450; x=1692180450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MJ4dSvsrNn3RMNzqNeyobxHJuyQw2M91GQhuo05OH4=;
  b=h7Oqm5KYdjocVmSBtvYFChGnLikHm/ZTxugQfnOb4zFf/G061xZrRDXW
   eFhg7CdKusdRwkYSziwvaTzMrAoh5e/JHo/oxAUv+9JGla27KjZk8zZeA
   8rXknse+juZKY7kEZlVlK//PWKS2HuqjzhU0Ytbe2m4Qg3rKJUJotE3wT
   m/itrf6TOFMHpxaDQPENx998lCsIPwCcRha4p6zOqTKxWi9Z3lwqH0Gth
   7IdZsL4cTVLga6YbNs/DLbrvk6jsSRqn20gc0jzk0L/Zyqqk6DluAHTac
   lOru+L6A/FJzDcAw9PiuObQDzI0wnvx7gHLccZtG/BH8tL6pfQTdlkVZC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356180007"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356180007"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="606976869"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2022 03:07:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3435D3F5; Tue, 16 Aug 2022 13:07:41 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 3/6] PCI: Distribute available resources for root buses too
Date:   Tue, 16 Aug 2022 13:07:37 +0300
Message-Id: <20220816100740.68667-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently we distribute the spare resources only upon hot-add so if
there are PCI devices connected already when the initial root bus scan
is done, and they have not been fully configured by the BIOS, we may end
up allocating resources just enough to cover only what is currently
there. If some of those devices are hotplug bridges themselves we do not
leave any additional resource space for future expansion.

For this reason distribute the available resources for root buses too to
make this work the same way we do in the normal hotplug case.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
Reported-by: Chris Chiu <chris.chiu@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
The diffstat is quite big here but this is due the fact that we move the
pci_assign_unassigned_root_bus_resources() below
pci_bridge_distribute_available_resources() so we can call it without
adding forward declaration.

 drivers/pci/setup-bus.c | 288 ++++++++++++++++++++++++----------------
 1 file changed, 174 insertions(+), 114 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8cb68e6f6ef9..df9fc974b313 100644
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
@@ -1881,7 +1768,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 	}
 
 	res->end = res->start + new_size - 1;
-	remove_from_list(add_list, res);
+
+	/* If the resource is part of the add_list remove it now */
+	if (add_list)
+		remove_from_list(add_list, res);
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
@@ -2036,6 +1926,8 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 	if (!bridge->is_hotplug_bridge)
 		return;
 
+	pci_dbg(bridge, "distributing available resources\n");
+
 	/* Take the initial extra resources from the hotplug port */
 	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
 	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
@@ -2047,6 +1939,174 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 					       available_mmio_pref);
 }
 
+static bool pci_bridge_resources_not_assigned(struct pci_dev *dev)
+{
+	const struct resource *r;
+
+	/*
+	 * Check the child device's resources and if they are not yet
+	 * assigned it means we are configuring them (not the boot
+	 * firmware) so we should be able to extend the upstream
+	 * bridge's (that's the hotplug downstream PCIe port) resources
+	 * in the same way we do with the normal hotplug case.
+	 */
+	r = &dev->resource[PCI_BRIDGE_IO_WINDOW];
+	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
+		return false;
+	r = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
+	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
+		return false;
+	r = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
+		return false;
+
+	return true;
+}
+
+static void pci_root_bus_distribute_available_resources(struct pci_bus *bus,
+							struct list_head *add_list)
+{
+	struct pci_dev *dev, *bridge = bus->self;
+
+	for_each_pci_bridge(dev, bus) {
+		struct pci_bus *b;
+
+		b = dev->subordinate;
+		if (!b)
+			continue;
+
+		/*
+		 * Need to check "bridge" here too because it is NULL
+		 * in case of root bus.
+		 */
+		if (bridge && pci_bridge_resources_not_assigned(dev)) {
+			pci_bridge_distribute_available_resources(bridge, add_list);
+			/*
+			 * There is only PCIe upstream port on the bus
+			 * so we don't need to go futher.
+			 */
+			return;
+		}
+
+		pci_root_bus_distribute_available_resources(b, add_list);
+	}
+}
+
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
+	pci_root_bus_distribute_available_resources(bus, add_list);
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

