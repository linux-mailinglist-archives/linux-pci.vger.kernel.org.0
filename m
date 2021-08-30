Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548963FAFBA
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 04:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbhH3CXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Aug 2021 22:23:54 -0400
Received: from mx.socionext.com ([202.248.49.38]:31272 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236202AbhH3CXx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 29 Aug 2021 22:23:53 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Aug 2021 11:23:00 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id F318B2021820;
        Mon, 30 Aug 2021 11:22:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 30 Aug 2021 11:22:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 24C7EB62B7;
        Mon, 30 Aug 2021 11:22:59 +0900 (JST)
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
Subject: [PATCH v2 2/2] PCI: uniphier: Serialize INTx masking/unmasking
Date:   Mon, 30 Aug 2021 11:22:38 +0900
Message-Id: <1630290158-31264-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The condition register PCI_RCV_INTX is used in irq_mask() and irq_unmask()
callbacks. Accesses to register can occur at the same time without a lock.
Add a lock into each callback to prevent the issue.

Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
Suggested-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 26f630c..0ddeec0 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -186,11 +186,16 @@ static void uniphier_pcie_irq_mask(struct irq_data *d)
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	unsigned long flags;
 	u32 val;
 
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	val = readl(priv->base + PCL_RCV_INTX);
 	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
 	writel(val, priv->base + PCL_RCV_INTX);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static void uniphier_pcie_irq_unmask(struct irq_data *d)
@@ -198,11 +203,16 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
+	unsigned long flags;
 	u32 val;
 
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
 	val = readl(priv->base + PCL_RCV_INTX);
 	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
 	writel(val, priv->base + PCL_RCV_INTX);
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static struct irq_chip uniphier_pcie_irq_chip = {
-- 
2.7.4

