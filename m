Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B752FAD47
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbhARWXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 17:23:33 -0500
Received: from mx.socionext.com ([202.248.49.38]:16111 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbhARWXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 17:23:32 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Jan 2021 07:09:57 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 19A9C205902B;
        Tue, 19 Jan 2021 07:09:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 19 Jan 2021 07:09:57 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B92F5B1D40;
        Tue, 19 Jan 2021 07:09:56 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v9 3/3] PCI: uniphier: Add misc interrupt handler to invoke PME and AER
Date:   Tue, 19 Jan 2021 07:09:45 +0900
Message-Id: <1611007785-25771-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611007785-25771-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1611007785-25771-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds misc interrupt handler to detect and invoke PME/AER event.

In UniPhier PCIe controller, PME/AER signals are assigned to the same
signal as MSI by the internal logic. These signals should be detected by
the internal register, however, DWC MSI handler can't handle these signals.

DWC MSI handler calls .msi_host_isr() callback function, that detects
PME/AER signals using the internal register and invokes the interrupt
with PME/AER vIRQ numbers.

These vIRQ numbers is obtained by uniphier_pcie_port_get_irq() function,
that finds the device that matches PME/AER from the devices associated
with Root Port, and returns its vIRQ number.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 101 +++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 7e8bad3..bc4db6f 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -21,6 +21,7 @@
 #include <linux/reset.h>
 
 #include "pcie-designware.h"
+#include "../../pcie/portdrv.h"
 
 #define PCL_PINCTRL0			0x002c
 #define PCL_PERST_PLDN_REGEN		BIT(12)
@@ -44,7 +45,9 @@
 #define PCL_SYS_AUX_PWR_DET		BIT(8)
 
 #define PCL_RCV_INT			0x8108
+#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
 #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
+#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
 #define PCL_CFG_BW_MGT_STATUS		BIT(4)
 #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
 #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
@@ -68,6 +71,8 @@ struct uniphier_pcie_priv {
 	struct reset_control *rst;
 	struct phy *phy;
 	struct irq_domain *legacy_irq_domain;
+	int aer_irq;
+	int pme_irq;
 };
 
 #define to_uniphier_pcie(x)	dev_get_drvdata((x)->dev)
@@ -164,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
 
 static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
 {
-	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
+	u32 val;
+
+	val = PCL_RCV_INT_ALL_ENABLE;
+	if (pci_msi_enabled())
+		val |= PCL_RCV_INT_ALL_INT_MASK;
+	else
+		val |= PCL_RCV_INT_ALL_MSI_MASK;
+
+	writel(val, priv->base + PCL_RCV_INT);
 	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
 }
 
@@ -228,28 +241,51 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
 	.map = uniphier_pcie_intx_map,
 };
 
-static void uniphier_pcie_irq_handler(struct irq_desc *desc)
+static void uniphier_pcie_misc_isr(struct pcie_port *pp, bool is_msi)
 {
-	struct pcie_port *pp = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned long reg;
-	u32 val, bit, virq;
+	u32 val;
 
-	/* INT for debug */
 	val = readl(priv->base + PCL_RCV_INT);
 
 	if (val & PCL_CFG_BW_MGT_STATUS)
 		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
 	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
 		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
-	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
-		dev_dbg(pci->dev, "Root Error\n");
-	if (val & PCL_CFG_PME_MSI_STATUS)
-		dev_dbg(pci->dev, "PME Interrupt\n");
+
+	if (is_msi) {
+		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
+			dev_dbg(pci->dev, "Root Error Status\n");
+			if (priv->aer_irq)
+				generic_handle_irq(priv->aer_irq);
+		}
+
+		if (val & PCL_CFG_PME_MSI_STATUS) {
+			dev_dbg(pci->dev, "PME Interrupt\n");
+			if (priv->pme_irq)
+				generic_handle_irq(priv->pme_irq);
+		}
+	}
 
 	writel(val, priv->base + PCL_RCV_INT);
+}
+
+static void uniphier_pcie_msi_host_isr(struct pcie_port *pp)
+{
+	uniphier_pcie_misc_isr(pp, true);
+}
+
+static void uniphier_pcie_irq_handler(struct irq_desc *desc)
+{
+	struct pcie_port *pp = irq_desc_get_handler_data(desc);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long reg;
+	u32 val, bit, virq;
+
+	uniphier_pcie_misc_isr(pp, false);
 
 	/* INTx */
 	chained_irq_enter(chip, desc);
@@ -317,8 +353,45 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static int uniphier_pcie_port_get_irq(struct pcie_port *pp, u32 service)
+{
+	struct pci_dev *pcidev;
+	int irq = 0;
+
+	if (!IS_ENABLED(CONFIG_PCIEAER) && !IS_ENABLED(CONFIG_PCIE_PME))
+		return 0;
+
+	/*
+	 * Finds the device that matches 'service' from the devices
+	 * associated with Root Port, and returns its vIRQ number.
+	 */
+	list_for_each_entry(pcidev, &pp->bridge->bus->devices, bus_list) {
+		irq = pcie_port_service_get_irq(pcidev, service);
+		if (irq)
+			break;
+	}
+
+	return irq;
+}
+
+static int uniphier_pcie_host_init_complete(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+
+	if (IS_ENABLED(CONFIG_PCIE_PME))
+		priv->pme_irq =
+			uniphier_pcie_port_get_irq(pp, PCIE_PORT_SERVICE_PME);
+	if (IS_ENABLED(CONFIG_PCIEAER))
+		priv->aer_irq =
+			uniphier_pcie_port_get_irq(pp, PCIE_PORT_SERVICE_AER);
+
+	return 0;
+}
+
 static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
 	.host_init = uniphier_pcie_host_init,
+	.msi_host_isr = uniphier_pcie_msi_host_isr,
 };
 
 static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
@@ -398,7 +471,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
 
 	priv->pci.pp.ops = &uniphier_pcie_host_ops;
 
-	return dw_pcie_host_init(&priv->pci.pp);
+	ret = dw_pcie_host_init(&priv->pci.pp);
+	if (ret)
+		return ret;
+
+	return uniphier_pcie_host_init_complete(&priv->pci.pp);
 }
 
 static const struct of_device_id uniphier_pcie_match[] = {
-- 
2.7.4

