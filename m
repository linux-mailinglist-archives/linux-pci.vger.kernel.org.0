Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58FC1ADDEB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgDQM7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 08:59:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47230 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbgDQM6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 08:58:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HCw9wr013747;
        Fri, 17 Apr 2020 07:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587128289;
        bh=DOBs9Avsla6Bvl41pGUSBS2Aw8GI+lo3Fc5IsqKblZY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KLz4FqKxWiDDhqCUEdPYrrxAUHBrrLTrgdQWGal0OKp0knS+dghLtntNbJrDMlFJO
         qaZOvAAm0fkLIkyyOD5dmy9jMS5zYgbFxZsOtKhKkRSmSspfHNj5hOSTMuqJZOW/0O
         arlyeeucNvzTEC4XuuVJrqhbpFrueYtBJv4WuJ5U=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HCw9jF056878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 07:58:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 07:58:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 07:58:08 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HCvsD8031089;
        Fri, 17 Apr 2020 07:58:05 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/14] PCI: cadence: Add support to use custom read and write accessors
Date:   Fri, 17 Apr 2020 18:27:42 +0530
Message-ID: <20200417125753.13021-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417125753.13021-1-kishon@ti.com>
References: <20200417125753.13021-1-kishon@ti.com>
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
index df14ad002fe9..70b6b25153e8 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -223,6 +223,11 @@ enum cdns_pcie_msg_routing {
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
@@ -239,7 +244,7 @@ struct cdns_pcie {
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
-	const struct cdns_pcie_common_ops *ops;
+	const struct cdns_pcie_ops *ops;
 };
 
 /**
@@ -299,69 +304,145 @@ struct cdns_pcie_ep {
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

