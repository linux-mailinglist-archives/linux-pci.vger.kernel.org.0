Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7674C131035
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgAFKTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 05:19:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46488 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgAFKTT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 05:19:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 006AJ9l9108499;
        Mon, 6 Jan 2020 04:19:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578305949;
        bh=0W8h6q1DjqH6SYZZFUMS/H0MQcTQzS4jdk+GtCZx1VE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ctDffj4WfgDDK+d7ibzP0+cVRD3MpLAtsmD+a8rA4W2WkVWZp7roPUyvw9ymVrqCZ
         O+lKYsRA/jwqIs/iec2UptS9n9P8ABX5Uj2d/U0NSYvKy59ncJ61RN/UUUk5Y/N+e2
         2ucFEUu4DEKavGS5tu031/XI/dRTOKBrWlDmLK+g=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006AJ95x031936;
        Mon, 6 Jan 2020 04:19:09 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 6 Jan
 2020 04:19:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 6 Jan 2020 04:19:09 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 006AIqXu118652;
        Mon, 6 Jan 2020 04:19:06 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 04/14] PCI: cadence: Add support to use custom read and write accessors
Date:   Mon, 6 Jan 2020 15:50:48 +0530
Message-ID: <20200106102058.19183-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106102058.19183-1-kishon@ti.com>
References: <20200106102058.19183-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to use custom read and write accessors. Platforms that
don't support half word or byte access or any other constraint
while accessing registers can use this feature to populate custom
read and write accessors. These custom accessors are used for both
standard register access and configuration space register access of
the PCIe host bridge.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 107 +++++++++++++++---
 1 file changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 4f6bec506841..391636a9c084 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -224,6 +224,11 @@ enum cdns_pcie_msg_routing {
 	MSG_ROUTING_GATHER,
 };
 
+struct cdns_pcie_ops {
+	u32	(*read)(void __iomem *addr, int size);
+	void	(*write)(void __iomem *addr, int size, u32 value);
+};
+
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
@@ -240,7 +245,7 @@ struct cdns_pcie {
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
-	const struct cdns_pcie_common_ops *ops;
+	const struct cdns_pcie_ops *ops;
 };
 
 /**
@@ -311,69 +316,145 @@ struct cdns_pcie_ep {
 /* Register access */
 static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
 {
-	writeb(value, pcie->reg_base + reg);
+	void __iomem *addr = pcie->reg_base + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x1, value);
+		return;
+	}
+
+	writeb(value, addr);
 }
 
 static inline void cdns_pcie_writew(struct cdns_pcie *pcie, u32 reg, u16 value)
 {
-	writew(value, pcie->reg_base + reg);
+	void __iomem *addr = pcie->reg_base + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x2, value);
+		return;
+	}
+
+	writew(value, addr);
 }
 
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
 {
-	writel(value, pcie->reg_base + reg);
+	void __iomem *addr = pcie->reg_base + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x4, value);
+		return;
+	}
+
+	writel(value, addr);
 }
 
 static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 {
-	return readl(pcie->reg_base + reg);
+	void __iomem *addr = pcie->reg_base + reg;
+
+	if (pcie->ops && pcie->ops->read)
+		return pcie->ops->read(addr, 0x4);
+
+	return readl(addr);
 }
 
 /* Root Port register access */
 static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
 				       u32 reg, u8 value)
 {
-	writeb(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x1, value);
+		return;
+	}
+
+	writeb(value, addr);
 }
 
 static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 				       u32 reg, u16 value)
 {
-	writew(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x2, value);
+		return;
+	}
+
+	writew(value, addr);
 }
 
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
 {
-	writeb(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x1, value);
+		return;
+	}
+
+	writeb(value, addr);
 }
 
 static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u16 value)
 {
-	writew(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x2, value);
+		return;
+	}
+
+	writew(value, addr);
 }
 
 static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u32 value)
 {
-	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	if (pcie->ops && pcie->ops->write) {
+		pcie->ops->write(addr, 0x4, value);
+		return;
+	}
+
+	writel(value, addr);
 }
 
 static inline u8 cdns_pcie_ep_fn_readb(struct cdns_pcie *pcie, u8 fn, u32 reg)
 {
-	return readb(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	if (pcie->ops && pcie->ops->read)
+		return pcie->ops->read(addr, 0x1);
+
+	return readb(addr);
 }
 
 static inline u16 cdns_pcie_ep_fn_readw(struct cdns_pcie *pcie, u8 fn, u32 reg)
 {
-	return readw(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	if (pcie->ops && pcie->ops->read)
+		return pcie->ops->read(addr, 0x2);
+
+	return readw(addr);
 }
 
 static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 {
-	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	if (pcie->ops && pcie->ops->read)
+		return pcie->ops->read(addr, 0x4);
+
+	return readl(addr);
 }
 
 #ifdef CONFIG_PCIE_CADENCE_HOST
-- 
2.17.1

