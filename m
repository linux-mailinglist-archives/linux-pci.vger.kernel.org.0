Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496A4617AD8
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKCKci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiKCKcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 06:32:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F518101F5
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667471555; x=1699007555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5kEMXnOdyCiSW1FYuTGuu7P7XBluCpbqOiH06BNguVc=;
  b=QGoFzrERrTAo0Iyw1U39smZxeT8d/JJPsrBTJY43AYJkGy9wL6Uk7CpS
   3zJalUZfWQDn61cZ5DrfBxe7zsjWzwM7I86LZseMF1JwYO0D8BkUGcwPL
   KZ+n2yd9S/5msCkb1Wk2g8oHoyl9Slir/KI1xxaTAibhkdggmI6M+yWww
   Pfc9E7l1OEhlJV57C3lLXJa+zk0LSJ05I9zpmP9uBtq5Hy8IccVohcOSF
   /TB1WDDaaahstydAvhLQiXzPIXIzk8mINSpxZpFuMZXH+9AgU4FnrUj98
   DRKxsXeJSl/jBScc0OEYYevnqQ9iTemTmFltgEVMP+QT953WKaR6SMZAT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289359454"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289359454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 03:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="665919795"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="665919795"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2022 03:32:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CCA4284; Thu,  3 Nov 2022 12:32:54 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] Revert "Revert "PCI: Distribute available resources for root buses, too""
Date:   Thu,  3 Nov 2022 12:32:54 +0200
Message-Id: <20221103103254.30497-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103103254.30497-1-mika.westerberg@linux.intel.com>
References: <20221103103254.30497-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 5632e2beaf9d5dda694c0572684dea783d8a9492.

Now that pci_bridge_distribute_available_resources() takes multifunction
devices int account we can revert this revert to fix the original issue.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi Bjorn,

Let me know if you prefer re-sending the original patch over the revert.

 drivers/pci/setup-bus.c | 62 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c8787b187ee4..e512f9ecb9d0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1768,7 +1768,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 	}
 
 	res->end = res->start + new_size - 1;
-	remove_from_list(add_list, res);
+
+	/* If the resource is part of the add_list remove it now */
+	if (add_list)
+		remove_from_list(add_list, res);
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
@@ -1978,6 +1981,8 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 	if (!bridge->is_hotplug_bridge)
 		return;
 
+	pci_dbg(bridge, "distributing available resources\n");
+
 	/* Take the initial extra resources from the hotplug port */
 	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
 	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
@@ -1989,6 +1994,59 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
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
 /*
  * First try will not touch PCI bridge res.
  * Second and later try will clear small leaf bridge res.
@@ -2028,6 +2086,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	 */
 	__pci_bus_size_bridges(bus, add_list);
 
+	pci_root_bus_distribute_available_resources(bus, add_list);
+
 	/* Depth last, allocate resources and update the hardware. */
 	__pci_bus_assign_resources(bus, add_list, &fail_head);
 	if (add_list)
-- 
2.35.1

