Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71EB415211
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbhIVU5F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 16:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237922AbhIVU45 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 16:56:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA2761215;
        Wed, 22 Sep 2021 20:55:22 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9Gy-00CP8z-V3; Wed, 22 Sep 2021 21:55:21 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v4 08/10] PCI: apple: Implement MSI support
Date:   Wed, 22 Sep 2021 21:54:56 +0100
Message-Id: <20210922205458.358517-9-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922205458.358517-1-maz@kernel.org>
References: <20210922205458.358517-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Probe for the 'msi-ranges' property, and implement the MSI
support in the form of the usual two-level hierarchy.

Note that contrary to the wired interrupts, MSIs are shared among
all the ports.

Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 167 +++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 38b5e0b7b691..de1cbc28d849 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -116,10 +116,22 @@
 #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
 #define PORT_PREFMEM_ENABLE		0x00994
 
+/*
+ * The doorbell address is set to 0xfffff000, which by convention
+ * matches what MacOS does, and it is possible to use any other
+ * address (in the bottom 4GB, as the base register is only 32bit).
+ */
+#define DOORBELL_ADDR			0xfffff000
+
 struct apple_pcie {
+	struct mutex		lock;
 	struct device		*dev;
 	void __iomem            *base;
+	struct irq_domain	*domain;
+	unsigned long		*bitmap;
 	struct completion	event;
+	struct irq_fwspec	fwspec;
+	u32			nvecs;
 };
 
 struct apple_pcie_port {
@@ -140,6 +152,101 @@ static void rmw_clear(u32 clr, void __iomem *addr)
 	writel_relaxed(readl_relaxed(addr) & ~clr, addr);
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
+	struct irq_fwspec fwspec = pcie->fwspec;
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
+	fwspec.param[1] += hwirq;
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
 static void apple_port_irq_mask(struct irq_data *data)
 {
 	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -274,6 +381,15 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 
 	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
 
+	/* Configure MSI base address */
+	BUILD_BUG_ON(upper_32_bits(DOORBELL_ADDR));
+	writel_relaxed(lower_32_bits(DOORBELL_ADDR), port->base + PORT_MSIADDR);
+
+	/* Enable MSIs, shared between all ports */
+	writel_relaxed(0, port->base + PORT_MSIBASE);
+	writel_relaxed((ilog2(port->pcie->nvecs) << PORT_MSICFG_L2MSINUM_SHIFT) |
+		       PORT_MSICFG_EN, port->base + PORT_MSICFG);
+
 	return 0;
 }
 
@@ -438,6 +554,55 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	return 0;
 }
 
+static int apple_msi_init(struct apple_pcie *pcie)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct of_phandle_args args = {};
+	struct irq_domain *parent;
+	int ret;
+
+	ret = of_parse_phandle_with_args(to_of_node(fwnode), "msi-ranges",
+					 "#interrupt-cells", 0, &args);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32_index(to_of_node(fwnode), "msi-ranges",
+					 args.args_count + 1, &pcie->nvecs);
+	if (ret)
+		return ret;
+
+	of_phandle_args_to_fwspec(args.np, args.args, args.args_count,
+				  &pcie->fwspec);
+
+	pcie->bitmap = devm_bitmap_zalloc(pcie->dev, pcie->nvecs, GFP_KERNEL);
+	if (!pcie->bitmap)
+		return -ENOMEM;
+
+	parent = irq_find_matching_fwspec(&pcie->fwspec, DOMAIN_BUS_WIRED);
+	if (!parent) {
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
 static int apple_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -467,7 +632,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 		}
 	}
 
-	return 0;
+	return apple_msi_init(pcie);
 }
 
 static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
-- 
2.30.2

