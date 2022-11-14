Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6011F627D3D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 13:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiKNMCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 07:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiKNMBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 07:01:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533AA20F6B
        for <linux-pci@vger.kernel.org>; Mon, 14 Nov 2022 03:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668427172; x=1699963172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IaLeSaxKsyOtY3IrFW2I80HKnX1Bge+quXqgmQZ6jvA=;
  b=O7liU1mB/+8ewfeHEQg2C7Z0HmaLMg31E9iZ0Q2NPOkxgNUMF6qQu2Ut
   qOzHp3lflvYyO1MDN+fXf5mVt8zK4IAizGxIc6fzCjPWMBg35uOKrTdR+
   puHAYPsg201HF86TCNNeFA9hLnnzk+8VdzutiEc4jZBnrouIDfNI0jwBD
   /BGstGl2WyEh+gdLx4UcYQkrUjS0UjCDf0cz/dtj6xuqLEob53DyPqcRE
   EB4DxKUujk6RlwtICLpe7byyMqy8P9EMDgvCuVnKTCapskdwrifQB8vAa
   JypXMzSAIX1y/Er71Hhq+YiAr4WjZdU7PkN8rybdwt/Y3ikebqNtxsF4S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="313096673"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="313096673"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 03:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="616284639"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="616284639"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2022 03:59:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2DD9932E; Mon, 14 Nov 2022 13:59:53 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/2] PCI: Take multifunction devices into account when distributing resources
Date:   Mon, 14 Nov 2022 13:59:52 +0200
Message-Id: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe switch upstream port may be one of the functions of a multifunction
device. The resource distribution code does not take this into account
properly and therefore it expands the upstream port resource windows too
much, not leaving space for the other functions (in the multifunction
device) and this leads to an issue that Jonathan reported. He runs QEMU
with the following topoology (QEMU parameters):

 -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
 -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
 -device e1000,bus=root_port13,addr=0.1 			\
 -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
 -device e1000,bus=fun1

The first e1000 NIC here is another function in the switch upstream
port. This leads to following errors:

  pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
  pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
  pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
  e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]

Fix this by taking into account the possible multifunction devices when
uptream port resources are distributed.

Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
The previous version of the series can be found here:

  https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/

Changes from v1:
  * Re-worded the commit message to hopefully explain the problem
    better
  * Added Link: to the bug report
  * Update the comment according to Bjorn's suggestion
  * Dropped the ->multifunction check
  * Use %#llx in log format.

 drivers/pci/setup-bus.c | 56 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b4096598dbcb..f3f39aa82dda 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1830,10 +1830,58 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * bridges below.
 	 */
 	if (hotplug_bridges + normal_bridges == 1) {
-		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate)
-			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, io, mmio, mmio_pref);
+		/* Upstream port must be the first */
+		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
+		if (!bridge->subordinate)
+			return;
+
+		/*
+		 * It is possible to have switch upstream port as a part of a
+		 * multifunction device. For this reason reduce the space
+		 * available for distribution by the amount required by the
+		 * peers of the upstream port.
+		 */
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			int i;
+
+			if (dev == bridge)
+				continue;
+
+			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+				const struct resource *dev_res = &dev->resource[i];
+				resource_size_t dev_sz;
+				struct resource *b_res;
+
+				if (dev_res->flags & IORESOURCE_IO) {
+					b_res = &io;
+				} else if (dev_res->flags & IORESOURCE_MEM) {
+					if (dev_res->flags & IORESOURCE_PREFETCH)
+						b_res = &mmio_pref;
+					else
+						b_res = &mmio;
+				} else {
+					continue;
+				}
+
+				/* Size aligned to bridge window */
+				align = pci_resource_alignment(bridge, b_res);
+				dev_sz = ALIGN(resource_size(dev_res), align);
+
+				pci_dbg(dev, "%pR aligned to %#llx\n", dev_res,
+					(unsigned long long)dev_sz);
+
+				if (dev_sz >= resource_size(b_res))
+					memset(b_res, 0, sizeof(*b_res));
+				else
+					b_res->end -= dev_sz;
+
+				pci_dbg(bridge, "updated available to %pR\n", b_res);
+			}
+		}
+
+		pci_bus_distribute_available_resources(bridge->subordinate,
+						       add_list, io, mmio,
+						       mmio_pref);
 		return;
 	}
 
-- 
2.35.1

