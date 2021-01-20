Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA56E2FD3DA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbhATPWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 10:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731718AbhATPIt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 10:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B86723356;
        Wed, 20 Jan 2021 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611155286;
        bh=kXcpbMPoJ6Hgqyt6S37zoGGfoWHPfap38RlnDm9KuUw=;
        h=From:To:Cc:Subject:Date:From;
        b=ldZUwFf/0USk4fwQJP7Mgm4sQaT0rlOakyX1Ozgf+XSPlMI506+zWWzGd9B43taRN
         XSYG8NXFVVRa6vK3aFG13qQMB5lKvBz4JDXb5V7BeI845gP2BkQUDFyc1BVzELjYRF
         HOmbsXhEgxM6M1kHgKgcRbAetR6dYKgOkspDtrMObnQJDaWz5OKWOVc/QBmOXlEkU/
         2N0WkM9Zv8RjMo1i+uV6bS9iC0e3l8QBqhun+q5JYgXx5cD9XkHalKgijCXzRIYFMm
         /3oxKLv50wNcsMFmjPCFBKEYU5QOIKnq+GXstmha980+qUN4su27KcVZTHSIusjEoV
         szTuADTgPeyUg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pci: remove tango host controller driver
Date:   Wed, 20 Jan 2021 16:07:29 +0100
Message-Id: <20210120150800.1650898-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The tango platform is getting removed, so the driver is no
longer needed.

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/controller/Kconfig      |  14 --
 drivers/pci/controller/Makefile     |   1 -
 drivers/pci/controller/pcie-tango.c | 341 ----------------------------
 3 files changed, 356 deletions(-)
 delete mode 100644 drivers/pci/controller/pcie-tango.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..8c85c16594f2 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -242,20 +242,6 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
 
-config PCIE_TANGO_SMP8759
-	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
-	depends on ARCH_TANGO && PCI_MSI && OF
-	depends on BROKEN
-	select PCI_HOST_COMMON
-	help
-	  Say Y here to enable PCIe controller support for Sigma Designs
-	  Tango SMP8759-based systems.
-
-	  Note: The SMP8759 controller multiplexes PCI config and MMIO
-	  accesses, and Linux doesn't provide a way to serialize them.
-	  This can lead to data corruption if drivers perform concurrent
-	  config and MMIO accesses.
-
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
 	tristate "Intel Volume Management Device Driver"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 04c6edc285c5..b3a7912f8a5c 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
-obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
 obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
deleted file mode 100644
index 62a061f1d62e..000000000000
--- a/drivers/pci/controller/pcie-tango.c
+++ /dev/null
@@ -1,341 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
-#include <linux/pci-ecam.h>
-#include <linux/delay.h>
-#include <linux/msi.h>
-#include <linux/of_address.h>
-
-#define MSI_MAX			256
-
-#define SMP8759_MUX		0x48
-#define SMP8759_TEST_OUT	0x74
-#define SMP8759_DOORBELL	0x7c
-#define SMP8759_STATUS		0x80
-#define SMP8759_ENABLE		0xa0
-
-struct tango_pcie {
-	DECLARE_BITMAP(used_msi, MSI_MAX);
-	u64			msi_doorbell;
-	spinlock_t		used_msi_lock;
-	void __iomem		*base;
-	struct irq_domain	*dom;
-};
-
-static void tango_msi_isr(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct tango_pcie *pcie = irq_desc_get_handler_data(desc);
-	unsigned long status, base, virq, idx, pos = 0;
-
-	chained_irq_enter(chip, desc);
-	spin_lock(&pcie->used_msi_lock);
-
-	while ((pos = find_next_bit(pcie->used_msi, MSI_MAX, pos)) < MSI_MAX) {
-		base = round_down(pos, 32);
-		status = readl_relaxed(pcie->base + SMP8759_STATUS + base / 8);
-		for_each_set_bit(idx, &status, 32) {
-			virq = irq_find_mapping(pcie->dom, base + idx);
-			generic_handle_irq(virq);
-		}
-		pos = base + 32;
-	}
-
-	spin_unlock(&pcie->used_msi_lock);
-	chained_irq_exit(chip, desc);
-}
-
-static void tango_ack(struct irq_data *d)
-{
-	struct tango_pcie *pcie = d->chip_data;
-	u32 offset = (d->hwirq / 32) * 4;
-	u32 bit = BIT(d->hwirq % 32);
-
-	writel_relaxed(bit, pcie->base + SMP8759_STATUS + offset);
-}
-
-static void update_msi_enable(struct irq_data *d, bool unmask)
-{
-	unsigned long flags;
-	struct tango_pcie *pcie = d->chip_data;
-	u32 offset = (d->hwirq / 32) * 4;
-	u32 bit = BIT(d->hwirq % 32);
-	u32 val;
-
-	spin_lock_irqsave(&pcie->used_msi_lock, flags);
-	val = readl_relaxed(pcie->base + SMP8759_ENABLE + offset);
-	val = unmask ? val | bit : val & ~bit;
-	writel_relaxed(val, pcie->base + SMP8759_ENABLE + offset);
-	spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
-}
-
-static void tango_mask(struct irq_data *d)
-{
-	update_msi_enable(d, false);
-}
-
-static void tango_unmask(struct irq_data *d)
-{
-	update_msi_enable(d, true);
-}
-
-static int tango_set_affinity(struct irq_data *d, const struct cpumask *mask,
-			      bool force)
-{
-	return -EINVAL;
-}
-
-static void tango_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
-{
-	struct tango_pcie *pcie = d->chip_data;
-	msg->address_lo = lower_32_bits(pcie->msi_doorbell);
-	msg->address_hi = upper_32_bits(pcie->msi_doorbell);
-	msg->data = d->hwirq;
-}
-
-static struct irq_chip tango_chip = {
-	.irq_ack		= tango_ack,
-	.irq_mask		= tango_mask,
-	.irq_unmask		= tango_unmask,
-	.irq_set_affinity	= tango_set_affinity,
-	.irq_compose_msi_msg	= tango_compose_msi_msg,
-};
-
-static void msi_ack(struct irq_data *d)
-{
-	irq_chip_ack_parent(d);
-}
-
-static void msi_mask(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void msi_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip msi_chip = {
-	.name = "MSI",
-	.irq_ack = msi_ack,
-	.irq_mask = msi_mask,
-	.irq_unmask = msi_unmask,
-};
-
-static struct msi_domain_info msi_dom_info = {
-	.flags	= MSI_FLAG_PCI_MSIX
-		| MSI_FLAG_USE_DEF_DOM_OPS
-		| MSI_FLAG_USE_DEF_CHIP_OPS,
-	.chip	= &msi_chip,
-};
-
-static int tango_irq_domain_alloc(struct irq_domain *dom, unsigned int virq,
-				  unsigned int nr_irqs, void *args)
-{
-	struct tango_pcie *pcie = dom->host_data;
-	unsigned long flags;
-	int pos;
-
-	spin_lock_irqsave(&pcie->used_msi_lock, flags);
-	pos = find_first_zero_bit(pcie->used_msi, MSI_MAX);
-	if (pos >= MSI_MAX) {
-		spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
-		return -ENOSPC;
-	}
-	__set_bit(pos, pcie->used_msi);
-	spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
-	irq_domain_set_info(dom, virq, pos, &tango_chip,
-			pcie, handle_edge_irq, NULL, NULL);
-
-	return 0;
-}
-
-static void tango_irq_domain_free(struct irq_domain *dom, unsigned int virq,
-				  unsigned int nr_irqs)
-{
-	unsigned long flags;
-	struct irq_data *d = irq_domain_get_irq_data(dom, virq);
-	struct tango_pcie *pcie = d->chip_data;
-
-	spin_lock_irqsave(&pcie->used_msi_lock, flags);
-	__clear_bit(d->hwirq, pcie->used_msi);
-	spin_unlock_irqrestore(&pcie->used_msi_lock, flags);
-}
-
-static const struct irq_domain_ops dom_ops = {
-	.alloc	= tango_irq_domain_alloc,
-	.free	= tango_irq_domain_free,
-};
-
-static int smp8759_config_read(struct pci_bus *bus, unsigned int devfn,
-			       int where, int size, u32 *val)
-{
-	struct pci_config_window *cfg = bus->sysdata;
-	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
-	int ret;
-
-	/* Reads in configuration space outside devfn 0 return garbage */
-	if (devfn != 0)
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-
-	/*
-	 * PCI config and MMIO accesses are muxed.  Linux doesn't have a
-	 * mutual exclusion mechanism for config vs. MMIO accesses, so
-	 * concurrent accesses may cause corruption.
-	 */
-	writel_relaxed(1, pcie->base + SMP8759_MUX);
-	ret = pci_generic_config_read(bus, devfn, where, size, val);
-	writel_relaxed(0, pcie->base + SMP8759_MUX);
-
-	return ret;
-}
-
-static int smp8759_config_write(struct pci_bus *bus, unsigned int devfn,
-				int where, int size, u32 val)
-{
-	struct pci_config_window *cfg = bus->sysdata;
-	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
-	int ret;
-
-	writel_relaxed(1, pcie->base + SMP8759_MUX);
-	ret = pci_generic_config_write(bus, devfn, where, size, val);
-	writel_relaxed(0, pcie->base + SMP8759_MUX);
-
-	return ret;
-}
-
-static const struct pci_ecam_ops smp8759_ecam_ops = {
-	.pci_ops	= {
-		.map_bus	= pci_ecam_map_bus,
-		.read		= smp8759_config_read,
-		.write		= smp8759_config_write,
-	}
-};
-
-static int tango_pcie_link_up(struct tango_pcie *pcie)
-{
-	void __iomem *test_out = pcie->base + SMP8759_TEST_OUT;
-	int i;
-
-	writel_relaxed(16, test_out);
-	for (i = 0; i < 10; ++i) {
-		u32 ltssm_state = readl_relaxed(test_out) >> 8;
-		if ((ltssm_state & 0x1f) == 0xf) /* L0 */
-			return 1;
-		usleep_range(3000, 4000);
-	}
-
-	return 0;
-}
-
-static int tango_pcie_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct tango_pcie *pcie;
-	struct resource *res;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct irq_domain *msi_dom, *irq_dom;
-	struct of_pci_range_parser parser;
-	struct of_pci_range range;
-	int virq, offset;
-
-	dev_warn(dev, "simultaneous PCI config and MMIO accesses may cause data corruption\n");
-	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
-
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	pcie->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(pcie->base))
-		return PTR_ERR(pcie->base);
-
-	platform_set_drvdata(pdev, pcie);
-
-	if (!tango_pcie_link_up(pcie))
-		return -ENODEV;
-
-	if (of_pci_dma_range_parser_init(&parser, dev->of_node) < 0)
-		return -ENOENT;
-
-	if (of_pci_range_parser_one(&parser, &range) == NULL)
-		return -ENOENT;
-
-	range.pci_addr += range.size;
-	pcie->msi_doorbell = range.pci_addr + res->start + SMP8759_DOORBELL;
-
-	for (offset = 0; offset < MSI_MAX / 8; offset += 4)
-		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
-
-	virq = platform_get_irq(pdev, 1);
-	if (virq < 0)
-		return virq;
-
-	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
-	if (!irq_dom) {
-		dev_err(dev, "Failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	msi_dom = pci_msi_create_irq_domain(fwnode, &msi_dom_info, irq_dom);
-	if (!msi_dom) {
-		dev_err(dev, "Failed to create MSI domain\n");
-		irq_domain_remove(irq_dom);
-		return -ENOMEM;
-	}
-
-	pcie->dom = irq_dom;
-	spin_lock_init(&pcie->used_msi_lock);
-	irq_set_chained_handler_and_data(virq, tango_msi_isr, pcie);
-
-	return pci_host_common_probe(pdev);
-}
-
-static const struct of_device_id tango_pcie_ids[] = {
-	{
-		.compatible = "sigma,smp8759-pcie",
-		.data = &smp8759_ecam_ops,
-	},
-	{ },
-};
-
-static struct platform_driver tango_pcie_driver = {
-	.probe	= tango_pcie_probe,
-	.driver	= {
-		.name = KBUILD_MODNAME,
-		.of_match_table = tango_pcie_ids,
-		.suppress_bind_attrs = true,
-	},
-};
-builtin_platform_driver(tango_pcie_driver);
-
-/*
- * The root complex advertises the wrong device class.
- * Header Type 1 is for PCI-to-PCI bridges.
- */
-static void tango_fixup_class(struct pci_dev *dev)
-{
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0024, tango_fixup_class);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0028, tango_fixup_class);
-
-/*
- * The root complex exposes a "fake" BAR, which is used to filter
- * bus-to-system accesses.  Only accesses within the range defined by this
- * BAR are forwarded to the host, others are ignored.
- *
- * By default, the DMA framework expects an identity mapping, and DRAM0 is
- * mapped at 0x80000000.
- */
-static void tango_fixup_bar(struct pci_dev *dev)
-{
-	dev->non_compliant_bars = true;
-	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0x80000000);
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0024, tango_fixup_bar);
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIGMA, 0x0028, tango_fixup_bar);
-- 
2.29.2

