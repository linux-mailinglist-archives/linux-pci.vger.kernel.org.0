Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ACB47DCA4
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbhLWBLh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbhLWBLg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B7C061574;
        Wed, 22 Dec 2021 17:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A1DE61D45;
        Thu, 23 Dec 2021 01:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBD6C36AEB;
        Thu, 23 Dec 2021 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221895;
        bh=OUS6SZ3H86mzld6IWPyuVgKtmVSAm+sRnOU5MJr56+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ja010Bek3D4n6/Sbi1Qu76SZQ+avlrgQBVOFQynq8Qq2fXJm/ftLA6T5yQmykl0PC
         DhY+XM1rhCb2cykZI1w3L6K9LUr5eFqLdgfKQHiJP+jWdQDeXwFLKBiy5SbuobZsee
         5zPArdDFCJHi0V+hH/eiIU7TrVbokvrzmd/1tB3w8OOAC5xkOJPOtgWdV7H3s6OJAv
         gGSQbAtUOKIJjYxP5cwz0JNoOLl3TT6eTo9GlJy0Pq5UcLR/kisGylV2bX++I6YTWw
         i/ceQz2ieZqbcelV3sWPsbw/HBLUPqRyM3p98S93XzQEStZa/puE+iTvW28dUWGG0o
         E1tFzNsmzwZ+w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 14/23] PCI: mediatek-gen3: Rename mtk_pcie_port to mtk_gen3_pcie
Date:   Wed, 22 Dec 2021 19:10:45 -0600
Message-Id: <20211223011054.1227810-15-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

Rename struct mtk_pcie_port to mtk_gen3_pcie to match the convention of
<driver>_pcie. No functional change intended.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 372 ++++++++++----------
 1 file changed, 186 insertions(+), 186 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 17c59b0d6978..be513fb390cf 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -110,7 +110,7 @@ struct mtk_msi_set {
 };
 
 /**
- * struct mtk_pcie_port - PCIe port information
+ * struct mtk_gen3_pcie - PCIe port information
  * @dev: pointer to PCIe device
  * @base: IO mapped register base
  * @reg_base: physical register base
@@ -129,7 +129,7 @@ struct mtk_msi_set {
  * @lock: lock protecting IRQ bit map
  * @msi_irq_in_use: bit map for assigned MSI IRQ
  */
-struct mtk_pcie_port {
+struct mtk_gen3_pcie {
 	struct device *dev;
 	void __iomem *base;
 	phys_addr_t reg_base;
@@ -162,7 +162,7 @@ struct mtk_pcie_port {
 static void mtk_pcie_config_tlp_header(struct pci_bus *bus, unsigned int devfn,
 					int where, int size)
 {
-	struct mtk_pcie_port *port = bus->sysdata;
+	struct mtk_gen3_pcie *pcie = bus->sysdata;
 	int bytes;
 	u32 val;
 
@@ -171,15 +171,15 @@ static void mtk_pcie_config_tlp_header(struct pci_bus *bus, unsigned int devfn,
 	val = PCIE_CFG_FORCE_BYTE_EN | PCIE_CFG_BYTE_EN(bytes) |
 	      PCIE_CFG_HEADER(bus->number, devfn);
 
-	writel_relaxed(val, port->base + PCIE_CFGNUM_REG);
+	writel_relaxed(val, pcie->base + PCIE_CFGNUM_REG);
 }
 
 static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 				      int where)
 {
-	struct mtk_pcie_port *port = bus->sysdata;
+	struct mtk_gen3_pcie *pcie = bus->sysdata;
 
-	return port->base + PCIE_CFG_OFFSET_ADDR + where;
+	return pcie->base + PCIE_CFG_OFFSET_ADDR + where;
 }
 
 static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
@@ -207,7 +207,7 @@ static struct pci_ops mtk_pcie_ops = {
 	.write = mtk_pcie_config_write,
 };
 
-static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
+static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 				    resource_size_t cpu_addr,
 				    resource_size_t pci_addr,
 				    resource_size_t size,
@@ -217,12 +217,12 @@ static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
 	u32 val;
 
 	if (num >= PCIE_MAX_TRANS_TABLES) {
-		dev_err(port->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
+		dev_err(pcie->dev, "not enough translate table for addr: %#llx, limited to [%d]\n",
 			(unsigned long long)cpu_addr, PCIE_MAX_TRANS_TABLES);
 		return -ENODEV;
 	}
 
-	table = port->base + PCIE_TRANS_TABLE_BASE_REG +
+	table = pcie->base + PCIE_TRANS_TABLE_BASE_REG +
 		num * PCIE_ATR_TLB_SET_OFFSET;
 
 	writel_relaxed(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(size) - 1),
@@ -244,63 +244,63 @@ static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
 	return 0;
 }
 
-static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
+static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 	u32 val;
 
 	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
-		struct mtk_msi_set *msi_set = &port->msi_sets[i];
+		struct mtk_msi_set *msi_set = &pcie->msi_sets[i];
 
-		msi_set->base = port->base + PCIE_MSI_SET_BASE_REG +
+		msi_set->base = pcie->base + PCIE_MSI_SET_BASE_REG +
 				i * PCIE_MSI_SET_OFFSET;
-		msi_set->msg_addr = port->reg_base + PCIE_MSI_SET_BASE_REG +
+		msi_set->msg_addr = pcie->reg_base + PCIE_MSI_SET_BASE_REG +
 				    i * PCIE_MSI_SET_OFFSET;
 
 		/* Configure the MSI capture address */
 		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
 		writel_relaxed(upper_32_bits(msi_set->msg_addr),
-			       port->base + PCIE_MSI_SET_ADDR_HI_BASE +
+			       pcie->base + PCIE_MSI_SET_ADDR_HI_BASE +
 			       i * PCIE_MSI_SET_ADDR_HI_OFFSET);
 	}
 
-	val = readl_relaxed(port->base + PCIE_MSI_SET_ENABLE_REG);
+	val = readl_relaxed(pcie->base + PCIE_MSI_SET_ENABLE_REG);
 	val |= PCIE_MSI_SET_ENABLE;
-	writel_relaxed(val, port->base + PCIE_MSI_SET_ENABLE_REG);
+	writel_relaxed(val, pcie->base + PCIE_MSI_SET_ENABLE_REG);
 
-	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	val = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
 	val |= PCIE_MSI_ENABLE;
-	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
+	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
 }
 
-static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
+static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 {
 	struct resource_entry *entry;
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	unsigned int table_index = 0;
 	int err;
 	u32 val;
 
 	/* Set as RC mode */
-	val = readl_relaxed(port->base + PCIE_SETTING_REG);
+	val = readl_relaxed(pcie->base + PCIE_SETTING_REG);
 	val |= PCIE_RC_MODE;
-	writel_relaxed(val, port->base + PCIE_SETTING_REG);
+	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
 
 	/* Set class code */
-	val = readl_relaxed(port->base + PCIE_PCI_IDS_1);
+	val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
 	val &= ~GENMASK(31, 8);
 	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
-	writel_relaxed(val, port->base + PCIE_PCI_IDS_1);
+	writel_relaxed(val, pcie->base + PCIE_PCI_IDS_1);
 
 	/* Mask all INTx interrupts */
-	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	val = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
 	val &= ~PCIE_INTX_ENABLE;
-	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
+	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
 
 	/* Assert all reset signals */
-	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
+	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
 	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
-	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
+	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 
 	/*
 	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal)
@@ -312,19 +312,19 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 
 	/* De-assert reset signals */
 	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
-	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
+	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 
 	/* Check if the link is up or not */
-	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
+	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
 				 !!(val & PCIE_PORT_LINKUP), 20,
 				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
 	if (err) {
-		val = readl_relaxed(port->base + PCIE_LTSSM_STATUS_REG);
-		dev_err(port->dev, "PCIe link down, ltssm reg val: %#x\n", val);
+		val = readl_relaxed(pcie->base + PCIE_LTSSM_STATUS_REG);
+		dev_err(pcie->dev, "PCIe link down, ltssm reg val: %#x\n", val);
 		return err;
 	}
 
-	mtk_pcie_enable_msi(port);
+	mtk_pcie_enable_msi(pcie);
 
 	/* Set PCIe translation windows */
 	resource_list_for_each_entry(entry, &host->windows) {
@@ -347,12 +347,12 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 
 		pci_addr = res->start - entry->offset;
 		size = resource_size(res);
-		err = mtk_pcie_set_trans_table(port, cpu_addr, pci_addr, size,
+		err = mtk_pcie_set_trans_table(pcie, cpu_addr, pci_addr, size,
 					       type, table_index);
 		if (err)
 			return err;
 
-		dev_dbg(port->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
+		dev_dbg(pcie->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
 			range_type, table_index, (unsigned long long)cpu_addr,
 			(unsigned long long)pci_addr, (unsigned long long)size);
 
@@ -396,7 +396,7 @@ static struct msi_domain_info mtk_msi_domain_info = {
 static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
-	struct mtk_pcie_port *port = data->domain->host_data;
+	struct mtk_gen3_pcie *pcie = data->domain->host_data;
 	unsigned long hwirq;
 
 	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
@@ -404,7 +404,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_hi = upper_32_bits(msi_set->msg_addr);
 	msg->address_lo = lower_32_bits(msi_set->msg_addr);
 	msg->data = hwirq;
-	dev_dbg(port->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
+	dev_dbg(pcie->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
 		hwirq, msg->address_hi, msg->address_lo, msg->data);
 }
 
@@ -421,33 +421,33 @@ static void mtk_msi_bottom_irq_ack(struct irq_data *data)
 static void mtk_msi_bottom_irq_mask(struct irq_data *data)
 {
 	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
-	struct mtk_pcie_port *port = data->domain->host_data;
+	struct mtk_gen3_pcie *pcie = data->domain->host_data;
 	unsigned long hwirq, flags;
 	u32 val;
 
 	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
 
-	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	raw_spin_lock_irqsave(&pcie->irq_lock, flags);
 	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
 	val &= ~BIT(hwirq);
 	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
-	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->irq_lock, flags);
 }
 
 static void mtk_msi_bottom_irq_unmask(struct irq_data *data)
 {
 	struct mtk_msi_set *msi_set = irq_data_get_irq_chip_data(data);
-	struct mtk_pcie_port *port = data->domain->host_data;
+	struct mtk_gen3_pcie *pcie = data->domain->host_data;
 	unsigned long hwirq, flags;
 	u32 val;
 
 	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
 
-	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	raw_spin_lock_irqsave(&pcie->irq_lock, flags);
 	val = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
 	val |= BIT(hwirq);
 	writel_relaxed(val, msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
-	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->irq_lock, flags);
 }
 
 static struct irq_chip mtk_msi_bottom_irq_chip = {
@@ -463,22 +463,22 @@ static int mtk_msi_bottom_domain_alloc(struct irq_domain *domain,
 				       unsigned int virq, unsigned int nr_irqs,
 				       void *arg)
 {
-	struct mtk_pcie_port *port = domain->host_data;
+	struct mtk_gen3_pcie *pcie = domain->host_data;
 	struct mtk_msi_set *msi_set;
 	int i, hwirq, set_idx;
 
-	mutex_lock(&port->lock);
+	mutex_lock(&pcie->lock);
 
-	hwirq = bitmap_find_free_region(port->msi_irq_in_use, PCIE_MSI_IRQS_NUM,
+	hwirq = bitmap_find_free_region(pcie->msi_irq_in_use, PCIE_MSI_IRQS_NUM,
 					order_base_2(nr_irqs));
 
-	mutex_unlock(&port->lock);
+	mutex_unlock(&pcie->lock);
 
 	if (hwirq < 0)
 		return -ENOSPC;
 
 	set_idx = hwirq / PCIE_MSI_IRQS_PER_SET;
-	msi_set = &port->msi_sets[set_idx];
+	msi_set = &pcie->msi_sets[set_idx];
 
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, hwirq + i,
@@ -491,15 +491,15 @@ static int mtk_msi_bottom_domain_alloc(struct irq_domain *domain,
 static void mtk_msi_bottom_domain_free(struct irq_domain *domain,
 				       unsigned int virq, unsigned int nr_irqs)
 {
-	struct mtk_pcie_port *port = domain->host_data;
+	struct mtk_gen3_pcie *pcie = domain->host_data;
 	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
 
-	mutex_lock(&port->lock);
+	mutex_lock(&pcie->lock);
 
-	bitmap_release_region(port->msi_irq_in_use, data->hwirq,
+	bitmap_release_region(pcie->msi_irq_in_use, data->hwirq,
 			      order_base_2(nr_irqs));
 
-	mutex_unlock(&port->lock);
+	mutex_unlock(&pcie->lock);
 
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
@@ -511,28 +511,28 @@ static const struct irq_domain_ops mtk_msi_bottom_domain_ops = {
 
 static void mtk_intx_mask(struct irq_data *data)
 {
-	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
+	struct mtk_gen3_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 val;
 
-	raw_spin_lock_irqsave(&port->irq_lock, flags);
-	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	raw_spin_lock_irqsave(&pcie->irq_lock, flags);
+	val = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
 	val &= ~BIT(data->hwirq + PCIE_INTX_SHIFT);
-	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
-	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
+	raw_spin_unlock_irqrestore(&pcie->irq_lock, flags);
 }
 
 static void mtk_intx_unmask(struct irq_data *data)
 {
-	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
+	struct mtk_gen3_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 val;
 
-	raw_spin_lock_irqsave(&port->irq_lock, flags);
-	val = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	raw_spin_lock_irqsave(&pcie->irq_lock, flags);
+	val = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
 	val |= BIT(data->hwirq + PCIE_INTX_SHIFT);
-	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
-	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
+	raw_spin_unlock_irqrestore(&pcie->irq_lock, flags);
 }
 
 /**
@@ -545,11 +545,11 @@ static void mtk_intx_unmask(struct irq_data *data)
  */
 static void mtk_intx_eoi(struct irq_data *data)
 {
-	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
+	struct mtk_gen3_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long hwirq;
 
 	hwirq = data->hwirq + PCIE_INTX_SHIFT;
-	writel_relaxed(BIT(hwirq), port->base + PCIE_INT_STATUS_REG);
+	writel_relaxed(BIT(hwirq), pcie->base + PCIE_INT_STATUS_REG);
 }
 
 static struct irq_chip mtk_intx_irq_chip = {
@@ -573,13 +573,13 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.map = mtk_pcie_intx_map,
 };
 
-static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port)
+static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = pcie->dev;
 	struct device_node *intc_node, *node = dev->of_node;
 	int ret;
 
-	raw_spin_lock_init(&port->irq_lock);
+	raw_spin_lock_init(&pcie->irq_lock);
 
 	/* Setup INTx */
 	intc_node = of_get_child_by_name(node, "interrupt-controller");
@@ -588,28 +588,28 @@ static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
-	if (!port->intx_domain) {
+	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops, pcie);
+	if (!pcie->intx_domain) {
 		dev_err(dev, "failed to create INTx IRQ domain\n");
 		return -ENODEV;
 	}
 
 	/* Setup MSI */
-	mutex_init(&port->lock);
+	mutex_init(&pcie->lock);
 
-	port->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
-				  &mtk_msi_bottom_domain_ops, port);
-	if (!port->msi_bottom_domain) {
+	pcie->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
+				  &mtk_msi_bottom_domain_ops, pcie);
+	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
 		ret = -ENODEV;
 		goto err_msi_bottom_domain;
 	}
 
-	port->msi_domain = pci_msi_create_irq_domain(dev->fwnode,
+	pcie->msi_domain = pci_msi_create_irq_domain(dev->fwnode,
 						     &mtk_msi_domain_info,
-						     port->msi_bottom_domain);
-	if (!port->msi_domain) {
+						     pcie->msi_bottom_domain);
+	if (!pcie->msi_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
 		ret = -ENODEV;
 		goto err_msi_domain;
@@ -618,32 +618,32 @@ static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port)
 	return 0;
 
 err_msi_domain:
-	irq_domain_remove(port->msi_bottom_domain);
+	irq_domain_remove(pcie->msi_bottom_domain);
 err_msi_bottom_domain:
-	irq_domain_remove(port->intx_domain);
+	irq_domain_remove(pcie->intx_domain);
 
 	return ret;
 }
 
-static void mtk_pcie_irq_teardown(struct mtk_pcie_port *port)
+static void mtk_pcie_irq_teardown(struct mtk_gen3_pcie *pcie)
 {
-	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
 
-	if (port->intx_domain)
-		irq_domain_remove(port->intx_domain);
+	if (pcie->intx_domain)
+		irq_domain_remove(pcie->intx_domain);
 
-	if (port->msi_domain)
-		irq_domain_remove(port->msi_domain);
+	if (pcie->msi_domain)
+		irq_domain_remove(pcie->msi_domain);
 
-	if (port->msi_bottom_domain)
-		irq_domain_remove(port->msi_bottom_domain);
+	if (pcie->msi_bottom_domain)
+		irq_domain_remove(pcie->msi_bottom_domain);
 
-	irq_dispose_mapping(port->irq);
+	irq_dispose_mapping(pcie->irq);
 }
 
-static void mtk_pcie_msi_handler(struct mtk_pcie_port *port, int set_idx)
+static void mtk_pcie_msi_handler(struct mtk_gen3_pcie *pcie, int set_idx)
 {
-	struct mtk_msi_set *msi_set = &port->msi_sets[set_idx];
+	struct mtk_msi_set *msi_set = &pcie->msi_sets[set_idx];
 	unsigned long msi_enable, msi_status;
 	irq_hw_number_t bit, hwirq;
 
@@ -658,59 +658,59 @@ static void mtk_pcie_msi_handler(struct mtk_pcie_port *port, int set_idx)
 
 		for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
 			hwirq = bit + set_idx * PCIE_MSI_IRQS_PER_SET;
-			generic_handle_domain_irq(port->msi_bottom_domain, hwirq);
+			generic_handle_domain_irq(pcie->msi_bottom_domain, hwirq);
 		}
 	} while (true);
 }
 
 static void mtk_pcie_irq_handler(struct irq_desc *desc)
 {
-	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct mtk_gen3_pcie *pcie = irq_desc_get_handler_data(desc);
 	struct irq_chip *irqchip = irq_desc_get_chip(desc);
 	unsigned long status;
 	irq_hw_number_t irq_bit = PCIE_INTX_SHIFT;
 
 	chained_irq_enter(irqchip, desc);
 
-	status = readl_relaxed(port->base + PCIE_INT_STATUS_REG);
+	status = readl_relaxed(pcie->base + PCIE_INT_STATUS_REG);
 	for_each_set_bit_from(irq_bit, &status, PCI_NUM_INTX +
 			      PCIE_INTX_SHIFT)
-		generic_handle_domain_irq(port->intx_domain,
+		generic_handle_domain_irq(pcie->intx_domain,
 					  irq_bit - PCIE_INTX_SHIFT);
 
 	irq_bit = PCIE_MSI_SHIFT;
 	for_each_set_bit_from(irq_bit, &status, PCIE_MSI_SET_NUM +
 			      PCIE_MSI_SHIFT) {
-		mtk_pcie_msi_handler(port, irq_bit - PCIE_MSI_SHIFT);
+		mtk_pcie_msi_handler(pcie, irq_bit - PCIE_MSI_SHIFT);
 
-		writel_relaxed(BIT(irq_bit), port->base + PCIE_INT_STATUS_REG);
+		writel_relaxed(BIT(irq_bit), pcie->base + PCIE_INT_STATUS_REG);
 	}
 
 	chained_irq_exit(irqchip, desc);
 }
 
-static int mtk_pcie_setup_irq(struct mtk_pcie_port *port)
+static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	int err;
 
-	err = mtk_pcie_init_irq_domains(port);
+	err = mtk_pcie_init_irq_domains(pcie);
 	if (err)
 		return err;
 
-	port->irq = platform_get_irq(pdev, 0);
-	if (port->irq < 0)
-		return port->irq;
+	pcie->irq = platform_get_irq(pdev, 0);
+	if (pcie->irq < 0)
+		return pcie->irq;
 
-	irq_set_chained_handler_and_data(port->irq, mtk_pcie_irq_handler, port);
+	irq_set_chained_handler_and_data(pcie->irq, mtk_pcie_irq_handler, pcie);
 
 	return 0;
 }
 
-static int mtk_pcie_parse_port(struct mtk_pcie_port *port)
+static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *regs;
 	int ret;
@@ -718,77 +718,77 @@ static int mtk_pcie_parse_port(struct mtk_pcie_port *port)
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
 	if (!regs)
 		return -EINVAL;
-	port->base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(port->base)) {
+	pcie->base = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(pcie->base)) {
 		dev_err(dev, "failed to map register base\n");
-		return PTR_ERR(port->base);
+		return PTR_ERR(pcie->base);
 	}
 
-	port->reg_base = regs->start;
+	pcie->reg_base = regs->start;
 
-	port->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
-	if (IS_ERR(port->phy_reset)) {
-		ret = PTR_ERR(port->phy_reset);
+	pcie->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
+	if (IS_ERR(pcie->phy_reset)) {
+		ret = PTR_ERR(pcie->phy_reset);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to get PHY reset\n");
 
 		return ret;
 	}
 
-	port->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
-	if (IS_ERR(port->mac_reset)) {
-		ret = PTR_ERR(port->mac_reset);
+	pcie->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
+	if (IS_ERR(pcie->mac_reset)) {
+		ret = PTR_ERR(pcie->mac_reset);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to get MAC reset\n");
 
 		return ret;
 	}
 
-	port->phy = devm_phy_optional_get(dev, "pcie-phy");
-	if (IS_ERR(port->phy)) {
-		ret = PTR_ERR(port->phy);
+	pcie->phy = devm_phy_optional_get(dev, "pcie-phy");
+	if (IS_ERR(pcie->phy)) {
+		ret = PTR_ERR(pcie->phy);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "failed to get PHY\n");
 
 		return ret;
 	}
 
-	port->num_clks = devm_clk_bulk_get_all(dev, &port->clks);
-	if (port->num_clks < 0) {
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0) {
 		dev_err(dev, "failed to get clocks\n");
-		return port->num_clks;
+		return pcie->num_clks;
 	}
 
 	return 0;
 }
 
-static int mtk_pcie_power_up(struct mtk_pcie_port *port)
+static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 {
-	struct device *dev = port->dev;
+	struct device *dev = pcie->dev;
 	int err;
 
 	/* PHY power on and enable pipe clock */
-	reset_control_deassert(port->phy_reset);
+	reset_control_deassert(pcie->phy_reset);
 
-	err = phy_init(port->phy);
+	err = phy_init(pcie->phy);
 	if (err) {
 		dev_err(dev, "failed to initialize PHY\n");
 		goto err_phy_init;
 	}
 
-	err = phy_power_on(port->phy);
+	err = phy_power_on(pcie->phy);
 	if (err) {
 		dev_err(dev, "failed to power on PHY\n");
 		goto err_phy_on;
 	}
 
 	/* MAC power on and enable transaction layer clocks */
-	reset_control_deassert(port->mac_reset);
+	reset_control_deassert(pcie->mac_reset);
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	err = clk_bulk_prepare_enable(port->num_clks, port->clks);
+	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err) {
 		dev_err(dev, "failed to enable clocks\n");
 		goto err_clk_init;
@@ -799,55 +799,55 @@ static int mtk_pcie_power_up(struct mtk_pcie_port *port)
 err_clk_init:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-	reset_control_assert(port->mac_reset);
-	phy_power_off(port->phy);
+	reset_control_assert(pcie->mac_reset);
+	phy_power_off(pcie->phy);
 err_phy_on:
-	phy_exit(port->phy);
+	phy_exit(pcie->phy);
 err_phy_init:
-	reset_control_assert(port->phy_reset);
+	reset_control_assert(pcie->phy_reset);
 
 	return err;
 }
 
-static void mtk_pcie_power_down(struct mtk_pcie_port *port)
+static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
 {
-	clk_bulk_disable_unprepare(port->num_clks, port->clks);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
-	pm_runtime_put_sync(port->dev);
-	pm_runtime_disable(port->dev);
-	reset_control_assert(port->mac_reset);
+	pm_runtime_put_sync(pcie->dev);
+	pm_runtime_disable(pcie->dev);
+	reset_control_assert(pcie->mac_reset);
 
-	phy_power_off(port->phy);
-	phy_exit(port->phy);
-	reset_control_assert(port->phy_reset);
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+	reset_control_assert(pcie->phy_reset);
 }
 
-static int mtk_pcie_setup(struct mtk_pcie_port *port)
+static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 {
 	int err;
 
-	err = mtk_pcie_parse_port(port);
+	err = mtk_pcie_parse_port(pcie);
 	if (err)
 		return err;
 
 	/* Don't touch the hardware registers before power up */
-	err = mtk_pcie_power_up(port);
+	err = mtk_pcie_power_up(pcie);
 	if (err)
 		return err;
 
 	/* Try link up */
-	err = mtk_pcie_startup_port(port);
+	err = mtk_pcie_startup_port(pcie);
 	if (err)
 		goto err_setup;
 
-	err = mtk_pcie_setup_irq(port);
+	err = mtk_pcie_setup_irq(pcie);
 	if (err)
 		goto err_setup;
 
 	return 0;
 
 err_setup:
-	mtk_pcie_power_down(port);
+	mtk_pcie_power_down(pcie);
 
 	return err;
 }
@@ -855,30 +855,30 @@ static int mtk_pcie_setup(struct mtk_pcie_port *port)
 static int mtk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct mtk_pcie_port *port;
+	struct mtk_gen3_pcie *pcie;
 	struct pci_host_bridge *host;
 	int err;
 
-	host = devm_pci_alloc_host_bridge(dev, sizeof(*port));
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!host)
 		return -ENOMEM;
 
-	port = pci_host_bridge_priv(host);
+	pcie = pci_host_bridge_priv(host);
 
-	port->dev = dev;
-	platform_set_drvdata(pdev, port);
+	pcie->dev = dev;
+	platform_set_drvdata(pdev, pcie);
 
-	err = mtk_pcie_setup(port);
+	err = mtk_pcie_setup(pcie);
 	if (err)
 		return err;
 
 	host->ops = &mtk_pcie_ops;
-	host->sysdata = port;
+	host->sysdata = pcie;
 
 	err = pci_host_probe(host);
 	if (err) {
-		mtk_pcie_irq_teardown(port);
-		mtk_pcie_power_down(port);
+		mtk_pcie_irq_teardown(pcie);
+		mtk_pcie_power_down(pcie);
 		return err;
 	}
 
@@ -887,66 +887,66 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 static int mtk_pcie_remove(struct platform_device *pdev)
 {
-	struct mtk_pcie_port *port = platform_get_drvdata(pdev);
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
+	struct mtk_gen3_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
 	pci_unlock_rescan_remove();
 
-	mtk_pcie_irq_teardown(port);
-	mtk_pcie_power_down(port);
+	mtk_pcie_irq_teardown(pcie);
+	mtk_pcie_power_down(pcie);
 
 	return 0;
 }
 
-static void __maybe_unused mtk_pcie_irq_save(struct mtk_pcie_port *port)
+static void __maybe_unused mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 
-	raw_spin_lock(&port->irq_lock);
+	raw_spin_lock(&pcie->irq_lock);
 
-	port->saved_irq_state = readl_relaxed(port->base + PCIE_INT_ENABLE_REG);
+	pcie->saved_irq_state = readl_relaxed(pcie->base + PCIE_INT_ENABLE_REG);
 
 	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
-		struct mtk_msi_set *msi_set = &port->msi_sets[i];
+		struct mtk_msi_set *msi_set = &pcie->msi_sets[i];
 
 		msi_set->saved_irq_state = readl_relaxed(msi_set->base +
 					   PCIE_MSI_SET_ENABLE_OFFSET);
 	}
 
-	raw_spin_unlock(&port->irq_lock);
+	raw_spin_unlock(&pcie->irq_lock);
 }
 
-static void __maybe_unused mtk_pcie_irq_restore(struct mtk_pcie_port *port)
+static void __maybe_unused mtk_pcie_irq_restore(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 
-	raw_spin_lock(&port->irq_lock);
+	raw_spin_lock(&pcie->irq_lock);
 
-	writel_relaxed(port->saved_irq_state, port->base + PCIE_INT_ENABLE_REG);
+	writel_relaxed(pcie->saved_irq_state, pcie->base + PCIE_INT_ENABLE_REG);
 
 	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
-		struct mtk_msi_set *msi_set = &port->msi_sets[i];
+		struct mtk_msi_set *msi_set = &pcie->msi_sets[i];
 
 		writel_relaxed(msi_set->saved_irq_state,
 			       msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
 	}
 
-	raw_spin_unlock(&port->irq_lock);
+	raw_spin_unlock(&pcie->irq_lock);
 }
 
-static int __maybe_unused mtk_pcie_turn_off_link(struct mtk_pcie_port *port)
+static int __maybe_unused mtk_pcie_turn_off_link(struct mtk_gen3_pcie *pcie)
 {
 	u32 val;
 
-	val = readl_relaxed(port->base + PCIE_ICMD_PM_REG);
+	val = readl_relaxed(pcie->base + PCIE_ICMD_PM_REG);
 	val |= PCIE_TURN_OFF_LINK;
-	writel_relaxed(val, port->base + PCIE_ICMD_PM_REG);
+	writel_relaxed(val, pcie->base + PCIE_ICMD_PM_REG);
 
 	/* Check the link is L2 */
-	return readl_poll_timeout(port->base + PCIE_LTSSM_STATUS_REG, val,
+	return readl_poll_timeout(pcie->base + PCIE_LTSSM_STATUS_REG, val,
 				  (PCIE_LTSSM_STATE(val) ==
 				   PCIE_LTSSM_STATE_L2_IDLE), 20,
 				   50 * USEC_PER_MSEC);
@@ -954,46 +954,46 @@ static int __maybe_unused mtk_pcie_turn_off_link(struct mtk_pcie_port *port)
 
 static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 {
-	struct mtk_pcie_port *port = dev_get_drvdata(dev);
+	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
 	u32 val;
 
 	/* Trigger link to L2 state */
-	err = mtk_pcie_turn_off_link(port);
+	err = mtk_pcie_turn_off_link(pcie);
 	if (err) {
-		dev_err(port->dev, "cannot enter L2 state\n");
+		dev_err(pcie->dev, "cannot enter L2 state\n");
 		return err;
 	}
 
 	/* Pull down the PERST# pin */
-	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
+	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
 	val |= PCIE_PE_RSTB;
-	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
+	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 
-	dev_dbg(port->dev, "entered L2 states successfully");
+	dev_dbg(pcie->dev, "entered L2 states successfully");
 
-	mtk_pcie_irq_save(port);
-	mtk_pcie_power_down(port);
+	mtk_pcie_irq_save(pcie);
+	mtk_pcie_power_down(pcie);
 
 	return 0;
 }
 
 static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 {
-	struct mtk_pcie_port *port = dev_get_drvdata(dev);
+	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
 
-	err = mtk_pcie_power_up(port);
+	err = mtk_pcie_power_up(pcie);
 	if (err)
 		return err;
 
-	err = mtk_pcie_startup_port(port);
+	err = mtk_pcie_startup_port(pcie);
 	if (err) {
-		mtk_pcie_power_down(port);
+		mtk_pcie_power_down(pcie);
 		return err;
 	}
 
-	mtk_pcie_irq_restore(port);
+	mtk_pcie_irq_restore(pcie);
 
 	return 0;
 }
-- 
2.25.1

