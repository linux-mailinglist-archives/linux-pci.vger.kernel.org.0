Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5446023EB7E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgHGKZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 06:25:34 -0400
Received: from mx.socionext.com ([202.248.49.38]:31586 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgHGKZe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Aug 2020 06:25:34 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Aug 2020 19:25:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 1156260060;
        Fri,  7 Aug 2020 19:25:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 7 Aug 2020 19:25:31 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 7AE2F1A0507;
        Fri,  7 Aug 2020 19:25:31 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v6 3/6] PCI: uniphier: Add misc interrupt handler to invoke PME and AER
Date:   Fri,  7 Aug 2020 19:25:19 +0900
Message-Id: <1596795922-705-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1596795922-705-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds misc interrupt handler to detect and invoke PME/AER event.

In UniPhier PCIe controller, PME/AER signals are assigned to the same
signal as MSI by the internal logic. These signals should be detected by
the internal register, however, DWC MSI handler can't handle these signals.

DWC MSI handler calls .msi_host_isr() callback function, that detects
PME/AER signals with the internal register and invokes the interrupt
with PME/AER vIRQ numbers.

These vIRQ numbers is obtained from portdrv in uniphier_add_pcie_port()
function.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 77 +++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 3a7f403..55a7166 100644
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
@@ -167,7 +172,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
 
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
 
@@ -231,28 +244,52 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
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
+
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
@@ -330,6 +367,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
 
 static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
 	.host_init = uniphier_pcie_host_init,
+	.msi_host_isr = uniphier_pcie_msi_host_isr,
 };
 
 static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
@@ -338,6 +376,7 @@ static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
 	struct dw_pcie *pci = &priv->pci;
 	struct pcie_port *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
+	struct pci_dev *pcidev;
 	int ret;
 
 	pp->ops = &uniphier_pcie_host_ops;
@@ -354,6 +393,22 @@ static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
 		return ret;
 	}
 
+	/* irq for PME */
+	list_for_each_entry(pcidev, &pp->root_bus->devices, bus_list) {
+		priv->pme_irq =
+			pcie_port_service_get_irq(pcidev, PCIE_PORT_SERVICE_PME);
+		if (priv->pme_irq)
+			break;
+	}
+
+	/* irq for AER */
+	list_for_each_entry(pcidev, &pp->root_bus->devices, bus_list) {
+		priv->aer_irq =
+			pcie_port_service_get_irq(pcidev, PCIE_PORT_SERVICE_AER);
+		if (priv->aer_irq)
+			break;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

