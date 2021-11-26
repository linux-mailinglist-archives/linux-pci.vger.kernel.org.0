Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488DA45E96D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 09:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359607AbhKZIg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 03:36:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43552 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359513AbhKZIe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 03:34:56 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VagJ027167;
        Fri, 26 Nov 2021 02:31:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637915496;
        bh=dVjv3JdHHVlPFIfNTUhqsH8CuFCYe12oVt/3tyuSFCA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tohq3gqIrSL5xLKkePE4mHlqZgVlOTowf2tOQRq675T67NTu1fKqdSAWhsjSjSzdQ
         LN4IIXkP5K/F0mLz+CH/GgebZ2K0j51pKOW4CSI/O/UeEgjwIEfCykHPfy7HTAutQq
         CqhaWx9xscayqZrZSPWd4nuiG4/hoyoKnJ/D6zFo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8Vadk039514
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:31:36 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:31:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:31:35 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8VKEn127547;
        Fri, 26 Nov 2021 02:31:32 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/5] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
Date:   Fri, 26 Nov 2021 14:01:17 +0530
Message-ID: <20211126083119.16570-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126083119.16570-1-kishon@ti.com>
References: <20211126083119.16570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
(SPRZ452D–July 2018–Revised December 2019 [1]) mentions when an
inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
the bus may corrupt the packet payload and the corrupt data may
cause associated applications or the processor to hang.

The workaround for Errata #i2037 is to limit the maximum read
request size and maximum payload size to 128 bytes. Add workaround
for Errata #i2037 here. The errata and workaround is applicable
only to AM65x SR 1.0 and later versions of the silicon will have
this fixed.

[1] -> https://www.ti.com/lit/er/sprz452f/sprz452f.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 13f03a97714c..52d20fe17ee9 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -35,6 +35,11 @@
 #define PCIE_DEVICEID_SHIFT	16
 
 /* Application registers */
+#define PID				0x000
+#define RTL				GENMASK(15, 11)
+#define RTL_SHIFT			11
+#define AM6_PCI_PG1_RTL_VER		0x15
+
 #define CMD_STATUS			0x004
 #define LTSSM_EN_VAL		        BIT(0)
 #define OB_XLAT_EN_VAL		        BIT(1)
@@ -105,6 +110,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -528,7 +535,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
+	struct keystone_pcie *ks_pcie;
+	struct device *bridge_dev;
 	struct pci_dev *bridge;
+	u32 val;
+
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
@@ -540,6 +551,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -565,6 +581,32 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 			pcie_set_readrq(dev, 256);
 		}
 	}
+
+	/*
+	 * Memory transactions fail with PCI controller in AM654 PG1.0
+	 * when MRRS is set to more than 128 bytes. Force the MRRS to
+	 * 128 bytes in all downstream devices.
+	 */
+	if (pci_match_id(am6_pci_devids, bridge)) {
+		bridge_dev = pci_get_host_bridge_device(dev);
+		if (!bridge_dev && !bridge_dev->parent)
+			return;
+
+		ks_pcie = dev_get_drvdata(bridge_dev->parent);
+		if (!ks_pcie)
+			return;
+
+		val = ks_pcie_app_readl(ks_pcie, PID);
+		val &= RTL;
+		val >>= RTL_SHIFT;
+		if (val != AM6_PCI_PG1_RTL_VER)
+			return;
+
+		if (pcie_get_readrq(dev) > 128) {
+			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
+			pcie_set_readrq(dev, 128);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-- 
2.17.1

