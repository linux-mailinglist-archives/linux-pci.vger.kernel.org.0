Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1E53ECD18
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhHPDSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:18:14 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45224 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S232756AbhHPDSI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:18:08 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] PCI: apple: Add MSI handling
Date:   Sun, 15 Aug 2021 23:16:19 -0400
Message-Id: <20210816031621.240268-5-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816031621.240268-1-alyssa@rosenzweig.io>
References: <20210816031621.240268-1-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add MSI handling to the Apple PCIe driver. As the hardware is ECAM
compliant, this code is the only hardware-specific piece required
after probing. This is sufficient to bring up Ethernet and the USB type
A ports.

Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 152 +++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 4ab767cf841b..04ebb9b956ae 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -119,6 +119,10 @@ struct apple_pcie {
 	struct mutex		lock;
 	struct device		*dev;
 	void __iomem            *rc;
+	struct irq_domain	*domain;
+	unsigned long		*bitmap;
+	u32			msi_base;
+	u32			nvecs;
 };
 
 static inline void rmwl(u32 clr, u32 set, void __iomem *addr)
@@ -126,6 +130,105 @@ static inline void rmwl(u32 clr, u32 set, void __iomem *addr)
 	writel_relaxed((readl_relaxed(addr) & ~clr) | set, addr);
 }
 
+static void apple_msi_top_irq_mask(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void apple_msi_top_irq_unmask(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip apple_msi_top_chip = {
+	.name			= "PCIe MSI",
+	.irq_mask		= apple_msi_top_irq_mask,
+	.irq_unmask		= apple_msi_top_irq_unmask,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+};
+
+static void apple_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	msg->address_hi = upper_32_bits(DOORBELL_ADDR);
+	msg->address_lo = lower_32_bits(DOORBELL_ADDR);
+	msg->data = data->hwirq;
+}
+
+static struct irq_chip apple_msi_bottom_chip = {
+	.name			= "MSI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_compose_msi_msg	= apple_msi_compose_msg,
+};
+
+static int apple_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
+{
+	struct apple_pcie *pcie = domain->host_data;
+	struct irq_fwspec fwspec;
+	unsigned int i;
+	int ret, hwirq;
+
+	mutex_lock(&pcie->lock);
+
+	hwirq = bitmap_find_free_region(pcie->bitmap, pcie->nvecs,
+					order_base_2(nr_irqs));
+
+	mutex_unlock(&pcie->lock);
+
+	if (hwirq < 0)
+		return -ENOSPC;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = hwirq + pcie->msi_base;
+	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &apple_msi_bottom_chip,
+					      domain->host_data);
+	}
+
+	return 0;
+}
+
+static void apple_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct apple_pcie *pcie = domain->host_data;
+
+	mutex_lock(&pcie->lock);
+
+	bitmap_release_region(pcie->bitmap, d->hwirq, order_base_2(nr_irqs));
+
+	mutex_unlock(&pcie->lock);
+}
+
+static const struct irq_domain_ops apple_msi_domain_ops = {
+	.alloc	= apple_msi_domain_alloc,
+	.free	= apple_msi_domain_free,
+};
+
+static struct msi_domain_info apple_msi_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
+	.chip	= &apple_msi_top_chip,
+};
+
 static int apple_pcie_setup_refclk(void __iomem *rc,
 				   void __iomem *port,
 				   unsigned int idx)
@@ -225,6 +328,53 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	return 0;
 }
 
+static int apple_msi_init(struct apple_pcie *pcie)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct device_node *parent_intc;
+	struct irq_domain *parent;
+	int ret;
+
+	ret = of_property_read_u32_index(to_of_node(fwnode), "msi-ranges",
+					 0, &pcie->msi_base);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(to_of_node(fwnode), "msi-ranges",
+					 1, &pcie->nvecs);
+	if (ret)
+		return ret;
+
+	pcie->bitmap = devm_bitmap_zalloc(pcie->dev, pcie->nvecs, GFP_KERNEL);
+	if (!pcie->bitmap)
+		return -ENOMEM;
+
+	parent_intc = of_irq_find_parent(to_of_node(fwnode));
+	parent = irq_find_host(parent_intc);
+	if (!parent_intc || !parent) {
+		dev_err(pcie->dev, "failed to find parent domain\n");
+		return -ENXIO;
+	}
+
+	parent = irq_domain_create_hierarchy(parent, 0, pcie->nvecs, fwnode,
+					     &apple_msi_domain_ops, pcie);
+	if (!parent) {
+		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+
+	pcie->domain = pci_msi_create_irq_domain(fwnode, &apple_msi_info,
+						 parent);
+	if (!pcie->domain) {
+		dev_err(pcie->dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int apple_m1_pci_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -267,7 +417,7 @@ static int apple_m1_pci_init(struct pci_config_window *cfg)
 		++i;
 	}
 
-	return 0;
+	return apple_msi_init(pcie);
 }
 
 static const struct pci_ecam_ops apple_m1_cfg_ecam_ops = {
-- 
2.30.2

