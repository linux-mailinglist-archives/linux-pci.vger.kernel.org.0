Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789D55ACD60
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 10:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiIEIC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbiIEICW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 04:02:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA07D481D9
        for <linux-pci@vger.kernel.org>; Mon,  5 Sep 2022 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662364942; x=1693900942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZEHX1TDGIeGNxrXwJV4wvg39y+Y4Cwd98eJUrcFG1ME=;
  b=fdzEmvi8jyK0Htuo+xqnodK94ULQzZEQlVP9IvMORzFLAa/pMOeZ3lNP
   LPEAVBvxatuEcJFlzBIdpYmirB63PI+32I+L5Eg36PPUcI9r5QBhU3nuS
   9gkbEW93L+srihC/FxfHiA8ZtoKI1aT7GfyTImgj32TUPTigAu8TjFp2R
   yI8Ii4agWo/8PTK2Qsm6crs37QtPLhSV0VNZ+bu9RE70JCGQnqDUax2It
   kV5ugAKp1XuAXY2B691Q/242qfHp6/5rMNSqAmBDHqRj7ySZFuzpJBgJj
   AVQJT5sR7LIHKYi2TZsMe7Jp7uJ7AMLEU0ZDTmvukHv6YL9uiNOarKWNq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="283328123"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="283328123"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 01:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="564666855"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Sep 2022 01:02:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D2A662E7; Mon,  5 Sep 2022 11:02:32 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 4/6] PCI: Distribute available resources for root buses too
Date:   Mon,  5 Sep 2022 11:02:30 +0300
Message-Id: <20220905080232.36087-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
References: <20220905080232.36087-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Chris Chiu <chris.chiu@canonical.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 62 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3b981da0fb4e..df9fc974b313 100644
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
@@ -1923,6 +1926,8 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 	if (!bridge->is_hotplug_bridge)
 		return;
 
+	pci_dbg(bridge, "distributing available resources\n");
+
 	/* Take the initial extra resources from the hotplug port */
 	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
 	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
@@ -1934,6 +1939,59 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
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
@@ -1973,6 +2031,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	 */
 	__pci_bus_size_bridges(bus, add_list);
 
+	pci_root_bus_distribute_available_resources(bus, add_list);
+
 	/* Depth last, allocate resources and update the hardware. */
 	__pci_bus_assign_resources(bus, add_list, &fail_head);
 	if (add_list)
-- 
2.35.1

