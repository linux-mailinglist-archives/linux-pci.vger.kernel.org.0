Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78546410F8F
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhITGnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 02:43:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54898 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhITGnP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 02:43:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fhlb114089;
        Mon, 20 Sep 2021 01:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632120103;
        bh=eb1cIdv3qoLYfUNttN6sbtnRdM99bDj5tbGobNqz3KU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BBsyILkPJrqg+OQ9BsLtftTlV2SpBRCTs64Diz0bi0duKWQRN+4U4GubwkTNmqygs
         0IsJyrjTm4qsTOHtb1qOq2dJPiV5kOx3VpGaXshAP/GBKkdL03xCWOjAh5qsFvz8WA
         ikfdd6p+pYguNfVXrQwc/E2JuQxyoIak8TjSQxqg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18K6fhUl075792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Sep 2021 01:41:43 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Sep 2021 01:41:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Sep 2021 01:41:41 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18K6fYa6015912;
        Mon, 20 Sep 2021 01:41:38 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 1/3] PCI: Add support in pci_walk_bus() to invoke callback matching RID
Date:   Mon, 20 Sep 2021 12:11:31 +0530
Message-ID: <20210920064133.14115-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210920064133.14115-1-kishon@ti.com>
References: <20210920064133.14115-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add two arguments to pci_walk_bus() [requestorID and mask], and add
support in pci_walk_bus() to invoke the *callback* only for devices
whose RequestorID after applying *mask* matches with *requestorID*
passed as argument.

This is done in preparation for calculating the total number of
interrupt vectors that has to be supported by a specific GIC ITS device ID,
specifically when "msi-map-mask" is populated in device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/bus.c   | 13 +++++++++----
 include/linux/pci.h |  7 +++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375f..e381e639ceaa 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -358,10 +358,12 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_add_devices);
 
-/** pci_walk_bus - walk devices on/under bus, calling callback.
+/** __pci_walk_bus - walk devices on/under bus matching requestor ID, calling callback.
  *  @top      bus whose devices should be walked
  *  @cb       callback to be called for each device found
  *  @userdata arbitrary pointer to be passed to callback.
+ *  @rid      Requestor ID that has to be matched for the callback to be invoked
+ *  @mask     Mask that has to be applied to pci_dev_id(), before compating it with @rid
  *
  *  Walk the given bus, including any bridged devices
  *  on buses under this bus.  Call the provided callback
@@ -371,8 +373,8 @@ EXPORT_SYMBOL(pci_bus_add_devices);
  *  other than 0, we break out.
  *
  */
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
-		  void *userdata)
+void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		    void *userdata, u32 rid, u32 mask)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -399,13 +401,16 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		} else
 			next = dev->bus_list.next;
 
+		if (mask != 0xffff && ((pci_dev_id(dev) & mask) != rid))
+			continue;
+
 		retval = cb(dev, userdata);
 		if (retval)
 			break;
 	}
 	up_read(&pci_bus_sem);
 }
-EXPORT_SYMBOL_GPL(pci_walk_bus);
+EXPORT_SYMBOL_GPL(__pci_walk_bus);
 
 struct pci_bus *pci_bus_get(struct pci_bus *bus)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cd8aa6fce204..8500fec56e50 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1473,14 +1473,17 @@ const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 		    int pass);
 
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
-		  void *userdata);
+void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		    void *userdata, u32 rid, u32 mask);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
 
+#define pci_walk_bus(top, cb, userdata) \
+	 __pci_walk_bus((top), (cb), (userdata), 0x0, 0xffff)
+
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
 
-- 
2.17.1

