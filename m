Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10E22183AA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgGHJar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 05:30:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59266 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgGHJaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 05:30:46 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0689UZoJ102974;
        Wed, 8 Jul 2020 04:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594200635;
        bh=fkBtp+U4H+Rsz2F0H88TEXPb+zBTcNhWs4srHjBvzA4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YbmnIA87qijELfDMqVIVbCOxjtDpG/fQequvcUHj0zHThJDnSfmoq6+KHm0CfSHV6
         cEgDuezF9cJ/NH6feu3tZfgclP35eG9ixUb3vjMKt4izyS4G2L6pZ8sLzxIbCUTews
         DAnxGeLIjoHn0RRg8f28UaDXpS/zENQx16naTmOI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0689UYYe043534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jul 2020 04:30:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 8 Jul
 2020 04:30:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 8 Jul 2020 04:30:34 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0689UJEK098512;
        Wed, 8 Jul 2020 04:30:31 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 03/14] PCI: cadence: Convert all r/w accessors to perform only 32-bit accesses
Date:   Wed, 8 Jul 2020 15:00:07 +0530
Message-ID: <20200708093018.28474-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708093018.28474-1-kishon@ti.com>
References: <20200708093018.28474-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Certain platforms like TI's J721E using Cadence PCIe IP can perform only
32-bit accesses for reading or writing to Cadence registers. Convert all
read and write accesses to 32-bit in Cadence PCIe driver in preparation
for adding PCIe support in TI's J721E SoC.

Also add spin lock to disable interrupts while modifying PCI_STATUS
register while raising legacy interrupt since PCI_STATUS is accessible
by both remote RC and EP and time between read and write should be
minimized.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  4 +
 drivers/pci/controller/cadence/pcie-cadence.h | 76 ++++++++++++++-----
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 4a829ccff7d0..c6eb2db94680 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -228,6 +228,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 				     u8 intx, bool is_asserted)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
+	unsigned long flags;
 	u32 offset;
 	u16 status;
 	u8 msg_code;
@@ -252,11 +253,13 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 		msg_code = MSG_CODE_DEASSERT_INTA + intx;
 	}
 
+	spin_lock_irqsave(&ep->lock, flags);
 	status = cdns_pcie_ep_fn_readw(pcie, fn, PCI_STATUS);
 	if (((status & PCI_STATUS_INTERRUPT) != 0) ^ (ep->irq_pending != 0)) {
 		status ^= PCI_STATUS_INTERRUPT;
 		cdns_pcie_ep_fn_writew(pcie, fn, PCI_STATUS, status);
 	}
+	spin_unlock_irqrestore(&ep->lock, flags);
 
 	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
 		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
@@ -464,6 +467,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
 	/* Reserve region 0 for IRQs */
 	set_bit(0, &ep->ob_region_map);
+	spin_lock_init(&ep->lock);
 
 	return 0;
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index bc49c22e48a9..a45c11158f49 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -304,6 +304,9 @@ struct cdns_pcie_rc {
  * @irq_pci_fn: the latest PCI function that has updated the mapping of
  *		the MSI/legacy IRQ dedicated outbound region.
  * @irq_pending: bitmask of asserted legacy IRQs.
+ * @lock: spin lock to disable interrupts while modifying PCIe controller
+ *        registers fields (RMW) accessible by both remote RC and EP to
+ *        minimize time between read and write
  */
 struct cdns_pcie_ep {
 	struct cdns_pcie	pcie;
@@ -315,54 +318,94 @@ struct cdns_pcie_ep {
 	u64			irq_pci_addr;
 	u8			irq_pci_fn;
 	u8			irq_pending;
+	/* protect writing to PCI_STATUS while raising legacy interrupts */
+	spinlock_t		lock;
 };
 
 
 /* Register access */
-static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
+static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
 {
-	writeb(value, pcie->reg_base + reg);
+	writel(value, pcie->reg_base + reg);
 }
 
-static inline void cdns_pcie_writew(struct cdns_pcie *pcie, u32 reg, u16 value)
+static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
 {
-	writew(value, pcie->reg_base + reg);
+	return readl(pcie->reg_base + reg);
 }
 
-static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
+static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
-	writel(value, pcie->reg_base + reg);
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 val = readl(aligned_addr);
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		WARN(1, "Address %p and size %d are not aligned\n", addr, size);
+		return 0;
+	}
+
+	if (size > 2)
+		return val;
+
+	return (val >> (8 * offset)) & ((1 << (size * 8)) - 1);
 }
 
-static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
+static inline void cdns_pcie_write_sz(void __iomem *addr, int size, u32 value)
 {
-	return readl(pcie->reg_base + reg);
+	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
+	unsigned int offset = (unsigned long)addr & 0x3;
+	u32 mask;
+	u32 val;
+
+	if (!IS_ALIGNED((uintptr_t)addr, size)) {
+		WARN(1, "Address %p and size %d are not aligned\n", addr, size);
+		return;
+	}
+
+	if (size > 2) {
+		writel(value, addr);
+		return;
+	}
+
+	mask = ~(((1 << (size * 8)) - 1) << (offset * 8));
+	val = readl(aligned_addr) & mask;
+	val |= value << (offset * 8);
+	writel(val, aligned_addr);
 }
 
 /* Root Port register access */
 static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
 				       u32 reg, u8 value)
 {
-	writeb(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x1, value);
 }
 
 static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
 				       u32 reg, u16 value)
 {
-	writew(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
 /* Endpoint Function register access */
 static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u8 value)
 {
-	writeb(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	cdns_pcie_write_sz(addr, 0x1, value);
 }
 
 static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
 					  u32 reg, u16 value)
 {
-	writew(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	cdns_pcie_write_sz(addr, 0x2, value);
 }
 
 static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
@@ -371,14 +414,11 @@ static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
 	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
 
-static inline u8 cdns_pcie_ep_fn_readb(struct cdns_pcie *pcie, u8 fn, u32 reg)
-{
-	return readb(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
-}
-
 static inline u16 cdns_pcie_ep_fn_readw(struct cdns_pcie *pcie, u8 fn, u32 reg)
 {
-	return readw(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
+
+	return cdns_pcie_read_sz(addr, 0x2);
 }
 
 static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
-- 
2.17.1

