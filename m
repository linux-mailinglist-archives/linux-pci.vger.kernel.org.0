Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87E1617AD7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 11:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiKCKcg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKCKcf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 06:32:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7884FDF34
        for <linux-pci@vger.kernel.org>; Thu,  3 Nov 2022 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667471554; x=1699007554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0qoSDSzgkyVZU1lr5PQGbJKlPX8Fkq7Yx4H/maVYt0s=;
  b=CSDwAaGcAHKDUAL1hi8TRaL6yA6qkRILzw9WIuzeIzBn7Kg+jui9DiRv
   JFsjWH0ShWur70WXDcHRqYWZ6Wym6cUTJZeGu3Jbm7eDJNyfbdgjrWUNE
   1HRwAtrRVMiQjcD/kiwfkEl93ov45hO/ngZK1QSJ4+oYfDIEjHp2t2rfq
   tuEPuGJoFOai4Onzoio+nA+fcS031Ath5vWEcbu+LqgJJ/iMm8wibaUhK
   8kuLpdt99UyMzOXhgsiOO4dmT6Zoxt4skauHVsXluhkkuFtMdVpf782f8
   RHheyGEXRcuVaty9Jhl2x7mM3pqK5/Oy+IZ/HsDWMWBa/miCkFvwc1Ki4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="289359453"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="289359453"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 03:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="665919792"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="665919792"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2022 03:32:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C4638155; Thu,  3 Nov 2022 12:32:54 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] PCI: Take multifunction devices into account when distributing resources
Date:   Thu,  3 Nov 2022 12:32:53 +0200
Message-Id: <20221103103254.30497-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

It is possible to have PCIe switch upstream port a multifunction device.
The resource distribution code does not take this into account properly
and therefore it expands the upstream port resource windows too much,
not leaving space for the other functions (in the multifunction device)
and this leads to an issue that Jonathan reported. He runs QEMU with
the following topoology (QEMU parameters):

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

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Hi,

This is the formal patch that resulted from the discussion here:

https://lore.kernel.org/linux-pci/20220905080232.36087-5-mika.westerberg@linux.intel.com/T/#m724289d0ee0c1ae07628744c283116e60efaeaf1

Only change from that version is that we loop through all resources of
the multifunction device.

 drivers/pci/setup-bus.c | 63 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b4096598dbcb..c8787b187ee4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1830,10 +1830,65 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
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
+		 * It is possible to have switch upstream port as a part
+		 * of a multifunction device. For this reason reduce the
+		 * resources occupied by the other functions before
+		 * distributing the rest.
+		 */
+		list_for_each_entry(dev, &bus->devices, bus_list) {
+			int i;
+
+			if (dev == bridge)
+				continue;
+
+			/*
+			 * It should be multifunction but if not stop
+			 * the distribution and bail out.
+			 */
+			if (!dev->multifunction)
+				return;
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
+				pci_dbg(dev, "%pR aligned to %llx\n", dev_res,
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

