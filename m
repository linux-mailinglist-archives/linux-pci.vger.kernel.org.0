Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50193FAFB8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 04:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhH3CXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Aug 2021 22:23:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:30603 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhH3CXw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Aug 2021 22:23:52 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Aug 2021 11:22:58 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D2F9C2059036;
        Mon, 30 Aug 2021 11:22:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 30 Aug 2021 11:22:58 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 94A1FB62B7;
        Mon, 30 Aug 2021 11:22:57 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 1/2] PCI: uniphier: Fix INTx mask/unmask bit operation and remove ack function
Date:   Mon, 30 Aug 2021 11:22:37 +0900
Message-Id: <1630290158-31264-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

INTX mask and unmask fields in PCL_RCV_INTX register should only be
set/reset for each bit. Clearing by PCL_RCV_INTX_ALL_MASK should be
removed.

INTX status fields in PCL_RCV_INTX register only indicates each INTX
interrupt status, so the handler can't clear by writing 1 to the field.
The status is expected to be cleared by the interrupt origin.
The ack function has no meaning, so should remove it.

Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index ebe43e9..26f630c 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -181,19 +181,6 @@ static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
 	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
 }
 
-static void uniphier_pcie_irq_ack(struct irq_data *d)
-{
-	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
-	u32 val;
-
-	val = readl(priv->base + PCL_RCV_INTX);
-	val &= ~PCL_RCV_INTX_ALL_STATUS;
-	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
-	writel(val, priv->base + PCL_RCV_INTX);
-}
-
 static void uniphier_pcie_irq_mask(struct irq_data *d)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
@@ -202,7 +189,6 @@ static void uniphier_pcie_irq_mask(struct irq_data *d)
 	u32 val;
 
 	val = readl(priv->base + PCL_RCV_INTX);
-	val &= ~PCL_RCV_INTX_ALL_MASK;
 	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
 	writel(val, priv->base + PCL_RCV_INTX);
 }
@@ -215,14 +201,12 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
 	u32 val;
 
 	val = readl(priv->base + PCL_RCV_INTX);
-	val &= ~PCL_RCV_INTX_ALL_MASK;
 	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
 	writel(val, priv->base + PCL_RCV_INTX);
 }
 
 static struct irq_chip uniphier_pcie_irq_chip = {
 	.name = "PCI",
-	.irq_ack = uniphier_pcie_irq_ack,
 	.irq_mask = uniphier_pcie_irq_mask,
 	.irq_unmask = uniphier_pcie_irq_unmask,
 };
-- 
2.7.4

