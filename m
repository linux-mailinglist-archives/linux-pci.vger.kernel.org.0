Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7883D667080
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 12:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjALLIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 06:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjALLHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 06:07:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A1A44C63
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 02:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673521172; x=1705057172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FmrYbrp0mCXXDjfXC+BP0GpHSC+pCq4u9W2JoFIsGa8=;
  b=S/Yr5O2W22ctM3rl3c3eMDPk0f92fVZC9oVnIrfdDg+6YyYzJBEULhhh
   bdlw1ci5hZl8vivYlBspez9GnjERe/7arhDNqWerUYc3s5LGcfESqGUZL
   q4W8CISowq+OE2qSBlX5nMfXbqy21k/e0yd+xxPg6HmhLHr4DUIiMTUlG
   KG1F6NOHOP7ZtQiiNkZlzCqWrzT4nG8Pabv8kS/G3NqzI8VfSXoobcUZI
   x/JFUOEguC1n09AA59q6pxafr3H9XtpaS5Xf3h5aE1QPmO6x6XvDAyf+7
   Vhki99b/0W8K1m+27NTfu+cNDH/KGgwfcemxW0hDRis17cMnCys6kLfCb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="388141958"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="388141958"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="746515484"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="746515484"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2023 02:59:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B264231D; Thu, 12 Jan 2023 13:00:00 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 3/3] PCI: Distribute available resources for root buses too
Date:   Thu, 12 Jan 2023 13:00:00 +0200
Message-Id: <20230112110000.59974-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112110000.59974-1-mika.westerberg@linux.intel.com>
References: <20230112110000.59974-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously we distributed spare resources only upon hot-add, so if the
initial root bus scan found devices that had not been fully configured by
the BIOS, we allocated only enough resources to cover what was then
present. If some of those devices were hotplug bridges, we did not leave
any additional resource space for future expansion.

Distribute the available resources for root buses, too, to make this work
the same way as the normal hotplug case.

This is a new version of the patch after the revert due to the regression
reported by Jonathan Cameron. This one changes pci_bridge_resources_not_assigned()
to work with bridges that do not have all the resource windows
programmed by the boot firmware (previously we expected all I/O, memory
and prefetchable memory were all programmed).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
Link: https://lore.kernel.org/r/20220905080232.36087-5-mika.westerberg@linux.intel.com
Reported-by: Chris Chiu <chris.chiu@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 57 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 30b5388f4a1a..7c5747e4dca1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1770,7 +1770,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 	}
 
 	res->end = res->start + new_size - 1;
-	remove_from_list(add_list, res);
+
+	/* If the resource is part of the add_list remove it now */
+	if (add_list)
+		remove_from_list(add_list, res);
 }
 
 static void remove_dev_resource(struct resource *avail, struct pci_dev *dev,
@@ -1968,6 +1971,8 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 	if (!bridge->is_hotplug_bridge)
 		return;
 
+	pci_dbg(bridge, "distributing available resources\n");
+
 	/* Take the initial extra resources from the hotplug port */
 	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
 	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
@@ -1979,6 +1984,54 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 					       available_mmio_pref);
 }
 
+static bool pci_bridge_resources_not_assigned(struct pci_dev *dev)
+{
+	const struct resource *r;
+
+	/*
+	 * Check the child device's resources and if they are not yet assigned
+	 * it means we are configuring them (not the boot firmware) so we
+	 * should be able to extend the upstream bridge resources in the same
+	 * way we do with the normal hotplug case.
+	 */
+	r = &dev->resource[PCI_BRIDGE_IO_WINDOW];
+	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
+		return false;
+	r = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
+	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
+		return false;
+	r = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
+		return false;
+
+	return true;
+}
+
+static void
+pci_root_bus_distribute_available_resources(struct pci_bus *bus,
+					    struct list_head *add_list)
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
+		if (bridge && pci_bridge_resources_not_assigned(dev))
+			pci_bridge_distribute_available_resources(bridge,
+								  add_list);
+		else
+			pci_root_bus_distribute_available_resources(b, add_list);
+	}
+}
+
 /*
  * First try will not touch PCI bridge res.
  * Second and later try will clear small leaf bridge res.
@@ -2018,6 +2071,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	 */
 	__pci_bus_size_bridges(bus, add_list);
 
+	pci_root_bus_distribute_available_resources(bus, add_list);
+
 	/* Depth last, allocate resources and update the hardware. */
 	__pci_bus_assign_resources(bus, add_list, &fail_head);
 	if (add_list)
-- 
2.39.0

