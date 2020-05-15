Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17B1D4A3F
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEOJ7W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 05:59:22 -0400
Received: from mx.socionext.com ([202.248.49.38]:29843 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgEOJ7V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 May 2020 05:59:21 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 15 May 2020 18:59:19 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 888C360057;
        Fri, 15 May 2020 18:59:19 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 15 May 2020 18:59:19 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id D24FB1A12D0;
        Fri, 15 May 2020 18:59:18 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 2/5] PCI: uniphier: Add misc interrupt handler to invoke PME and AER
Date:   Fri, 15 May 2020 18:59:00 +0900
Message-Id: <1589536743-6684-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The misc interrupts consisting of PME, AER, and Link event, is handled
by INTx handler, however, these interrupts should be also handled by
MSI handler.

This adds the function uniphier_pcie_misc_isr() that handles misc
intterupts, which is called from both INTx and MSI handlers.
This function detects PME and AER interrupts with the status register,
and invoke PME and AER drivers related to INTx or MSI.

And this sets the mask for misc interrupts from INTx if MSI is enabled
and sets the mask for misc interrupts from MSI if MSI is disabled.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 53 +++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index a5401a0..a8dda39 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -44,7 +44,9 @@
 #define PCL_SYS_AUX_PWR_DET		BIT(8)
 
 #define PCL_RCV_INT			0x8108
+#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
 #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
+#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
 #define PCL_CFG_BW_MGT_STATUS		BIT(4)
 #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
 #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
@@ -167,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
 
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
 
@@ -231,28 +241,48 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
 	.map = uniphier_pcie_intx_map,
 };
 
-static void uniphier_pcie_irq_handler(struct irq_desc *desc)
+static void uniphier_pcie_misc_isr(struct pcie_port *pp)
 {
-	struct pcie_port *pp = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned long reg;
-	u32 val, bit, virq;
+	u32 val, virq;
 
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
+	if (pci_msi_enabled()) {
+		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
+			dev_dbg(pci->dev, "Root Error Status\n");
+			virq = irq_linear_revmap(pp->irq_domain, 0);
+			generic_handle_irq(virq);
+		}
+
+		if (val & PCL_CFG_PME_MSI_STATUS) {
+			dev_dbg(pci->dev, "PME Interrupt\n");
+			virq = irq_linear_revmap(pp->irq_domain, 0);
+			generic_handle_irq(virq);
+		}
+	}
 
 	writel(val, priv->base + PCL_RCV_INT);
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
+	/* misc interrupt */
+	uniphier_pcie_misc_isr(pp);
 
 	/* INTx */
 	chained_irq_enter(chip, desc);
@@ -330,6 +360,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
 
 static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
 	.host_init = uniphier_pcie_host_init,
+	.msi_host_isr = uniphier_pcie_misc_isr,
 };
 
 static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
-- 
2.7.4

