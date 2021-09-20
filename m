Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA940410F91
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 08:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhITGn2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 02:43:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48778 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhITGn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 02:43:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fjjs073480;
        Mon, 20 Sep 2021 01:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632120105;
        bh=irwwhPCzZ2l+G6tBT9VTTRVLR5kG5CHiPJsvsZ/kQQg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fvKpEbKaHeIpTobTTWtNB6jtG/15gld1qmcOrb242Jd7LAHjhKZzfCutKrPj8HtUI
         PAiMDe2AfEyBk4H3VkssyoZ8AE0O6drNVTEVdVh1BjKZwi2RKO4PazeqMW8z+2HT5g
         IO0iBCZISgG1OrLYYiSuzAhIPSPZiG/Y/A06h+Ok=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18K6fjbj064810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 01:41:45 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 01:41:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 01:41:45 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fYa7015912;
        Mon, 20 Sep 2021 01:41:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 2/3] PCI: Export find_pci_root_bus()
Date:   Mon, 20 Sep 2021 12:11:32 +0530
Message-ID: <20210920064133.14115-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210920064133.14115-1-kishon@ti.com>
References: <20210920064133.14115-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export find_pci_root_bus() in order for other subsystems (like
IRQCHIP) to find the root bus of a particual PCIe device.

This is done in preparation for GIC ITS to walk the PCIe bus for
calculating the total number of interrupt vectors that has to be
supported by a specific GIC ITS device ID, specifically when
"msi-map-mask" is populated in device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/host-bridge.c | 3 ++-
 include/linux/pci.h       | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index afa50b446567..4ec34d040c02 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -9,13 +9,14 @@
 
 #include "pci.h"
 
-static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
+struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 {
 	while (bus->parent)
 		bus = bus->parent;
 
 	return bus;
 }
+EXPORT_SYMBOL_GPL(find_pci_root_bus);
 
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8500fec56e50..b33ef3e08a2f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1475,6 +1475,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		    void *userdata, u32 rid, u32 mask);
+struct pci_bus *find_pci_root_bus(struct pci_bus *bus);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
-- 
2.17.1

