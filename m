Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE12663D45D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiK3LXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 06:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiK3LWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 06:22:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D06527CE3
        for <linux-pci@vger.kernel.org>; Wed, 30 Nov 2022 03:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669807317; x=1701343317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUtrKtKNQGmO6N8a0d2o7ioGhovPD8Vg70nilxk1F0E=;
  b=g7YuIqM7RdtYIoF8oOarsFBH/f9EzXSDAOnW9yHWloQD6KSIDaNxuP5z
   hzJP79AxkoU6g7xdB6UVXFgFhpx4aCua5mYx7XrDSaDvrkTriMdp6aO92
   c7jarqF6mrDXQFDYPOk3U3VDXTsfqVCglOlHscjEKhbyy2hf2fs66YQFD
   Mc3W6VwedD/JnnUcL/vqzdXXIAFN2ZkmtEW5E7d2/iM8xRn7Ap49nAjpL
   XygQbxCx0ez3YRVucxkEqvqGb1jN57ekrtJOTNLq704rmlb3pAD26CFk2
   PF7VLntF2jZV9Yhmx3XOPcZ/Fty760GoKA0cy0UFr7NeUJpS2EhTZ26w2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342291715"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="342291715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 03:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="676790604"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="676790604"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2022 03:21:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B35543BC; Wed, 30 Nov 2022 13:22:21 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 1/2] PCI: Take other bus devices into account when distributing resources
Date:   Wed, 30 Nov 2022 13:22:20 +0200
Message-Id: <20221130112221.66612-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130112221.66612-1-mika.westerberg@linux.intel.com>
References: <20221130112221.66612-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A PCI bridge may reside on a bus with other devices as well. The
resource distribution code does not take this into account properly and
therefore it expands the bridge resource windows too much, not leaving
space for the other devices (or functions a multifunction device) and
this leads to an issue that Jonathan reported. He runs QEMU with the
following topoology (QEMU parameters):

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
 drivers/pci/setup-bus.c | 66 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b4096598dbcb..d456175ddc4f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1830,10 +1830,68 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * bridges below.
 	 */
 	if (hotplug_bridges + normal_bridges == 1) {
-		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate)
-			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, io, mmio, mmio_pref);
+		bridge = NULL;
+
+		/* Find the single bridge on this bus first */
+		for_each_pci_bridge(dev, bus) {
+			bridge = dev;
+			break;
+		}
+
+		if (WARN_ON_ONCE(!bridge))
+			return;
+		if (!bridge->subordinate)
+			return;
+
+		/*
+		 * Reduce the space available for distribution by the
+		 * amount required by the other devices on the same bus
+		 * as this bridge.
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
+				if (!dev_sz)
+					continue;
+
+				pci_dbg(dev, "resource %pR aligned to %#llx\n",
+					dev_res, (unsigned long long)dev_sz);
+
+				if (dev_sz > resource_size(b_res))
+					memset(b_res, 0, sizeof(*b_res));
+				else
+					b_res->end -= dev_sz;
+
+				pci_dbg(bridge, "updated available resources to %pR\n",
+					b_res);
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

