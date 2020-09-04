Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8511125D6E3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Sep 2020 12:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgIDK4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Sep 2020 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDK4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2020 06:56:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07824C061244;
        Fri,  4 Sep 2020 03:56:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so5655362edb.8;
        Fri, 04 Sep 2020 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhNQ8D3BceLMp/Okz4MBRSXUN8u38ft8so41n8iznt0=;
        b=NMEOwjUQa2ASkPKbGuDlRWMaaFYaPE+OriPMWRMr/hQyOREacWsQT5fF5dn28QwFF2
         pMKY0keCbY4o9qv7xnSy3KGgdsYFJIdSWsNcb45/ke3LfcUjvzRRV7PYLPe9P4i4+9/0
         lAy2aj0G1lOnIQlOjzafy4WC0h9wCtWYckWmGD01vD5BXV2Yt26ZCYDZ4jBtrXf5Ooo9
         RAclKf9cteluO/Jrd//ksMZtrWPYJfFaxnN4aWUv2yzcDdFrrJMIKMZWZKbZJoZOgpqu
         pp5j1CgUMB2K5GgqFXS2cxJ98I8l7CxraFI+4Gqk31RCjtrNdI5QpRKLM9OIMOXTYcsF
         HtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dhNQ8D3BceLMp/Okz4MBRSXUN8u38ft8so41n8iznt0=;
        b=okxfzlTng41dBZnP1ncfn+brPc1nVrZm+SzjQ64HHhxRVSJKFpOhwzvvMb7XTgz9Aa
         EPuANiaKKiOcwZpgfIbT8LWUAd9KNqZwonYItoTpukN39P38NLts354ah8awdSHQF4dT
         bbcKuG5o6AiG0WncDIThDbUqT9RwK/jGeZsrafcmXHM8KCKcOceiV4gWOg/PqGXfxYmj
         5f/pTlaUnA382V5jUnl5Giw3VJrWgVH7PU4twQaqiOe9mlh8FxubEy+r/12G33xktT0e
         gVSz94TvUkqRVAN2L/pOszt2Upt8nySEqmkqKiCPM2RIxQL0baCUMpDJsY5VjAMZ8SNT
         r+VA==
X-Gm-Message-State: AOAM5311WQYtwKhaC0PPOhhROIzUwQ2FbDk2qtuRGeFvv3QG3eE5cU9A
        6TSqWBawNJ/eIDc4FwBbESKRHYRd8jrozw==
X-Google-Smtp-Source: ABdhPJxPPi6MdoeknOvOxBhaCc7DV7OibGUpN+irHItDyqYO9QFsFI/nxokrGXcstxzHb/l+phLcdw==
X-Received: by 2002:a05:6402:847:: with SMTP id b7mr8169800edz.39.1599216978461;
        Fri, 04 Sep 2020 03:56:18 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g11sm5568391edj.85.2020.09.04.03.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 03:56:17 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: Convert to MSI domains
Date:   Fri,  4 Sep 2020 12:56:13 +0200
Message-Id: <20200904105613.444945-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

In anticipation of the removal of the msi_controller structure, convert
the Tegra host controller driver to MSI domains.

We end-up with the usual two domain structure, the top one being a
generic PCI/MSI domain, the bottom one being Tegra-specific and handling
the actual HW interrupt allocation.

While at it, convert the normal interrupt handler to a chained handler,
handle the controller's MSI IRQ edge triggered, support multiple MSIs
per device and use the AFI_MSI_EN_VEC* registers to provide MSI masking.

Signed-off-by: Marc Zyngier <maz@kernel.org>
[treding@nvidia.com: fix, clean up and address TODOs from Marc's draft]
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
This is basically Marc's patch from here:

  https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/tegra-msi&id=8ba6858f07a7554d4e56a6d5103cd914dcf23af0

That didn't work as-is, but it was pretty easy to get it to build and
run properly. Once I had that I went through Marc's list of TODOs and
addressed them, which was also not very difficult.

I haven't done any extensive testing, but I can boot fine over NFS with
a PCI Ethernet card. Given how fundamental this is, I would expect that
to be a good enough test.

Marc, I've kept your authorship on this. There are substantial changes
from your version, but you had laid out the plan for all these changes,
so it seemed fair. However, let me know if you're not comfortable with
taking responsibility for any potential bugs I've introduced.

I had originally considered sending this out as a series with more
intermediate steps, but it turns out most of the TODO's that Marc had
listed are related, so this could've been at maximum two or three
patches. That didn't seem worth splitting up for. I think most of this
work is still all related to the MSI domain conversion, so it makes
sense to keep it in one patch.

 drivers/pci/controller/pci-tegra.c | 316 +++++++++++++++--------------
 1 file changed, 165 insertions(+), 151 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index c1d34353c29b..f7f92718ce40 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -78,23 +79,8 @@
 #define AFI_MSI_FPCI_BAR_ST	0x64
 #define AFI_MSI_AXI_BAR_ST	0x68
 
-#define AFI_MSI_VEC0		0x6c
-#define AFI_MSI_VEC1		0x70
-#define AFI_MSI_VEC2		0x74
-#define AFI_MSI_VEC3		0x78
-#define AFI_MSI_VEC4		0x7c
-#define AFI_MSI_VEC5		0x80
-#define AFI_MSI_VEC6		0x84
-#define AFI_MSI_VEC7		0x88
-
-#define AFI_MSI_EN_VEC0		0x8c
-#define AFI_MSI_EN_VEC1		0x90
-#define AFI_MSI_EN_VEC2		0x94
-#define AFI_MSI_EN_VEC3		0x98
-#define AFI_MSI_EN_VEC4		0x9c
-#define AFI_MSI_EN_VEC5		0xa0
-#define AFI_MSI_EN_VEC6		0xa4
-#define AFI_MSI_EN_VEC7		0xa8
+#define AFI_MSI_VEC(x)		(0x6c + ((x) * 4))
+#define AFI_MSI_EN_VEC(x)	(0x8c + ((x) * 4))
 
 #define AFI_CONFIGURATION		0xac
 #define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
@@ -280,13 +266,15 @@
 #define LINK_RETRAIN_TIMEOUT 100000 /* in usec */
 
 struct tegra_msi {
-	struct msi_controller chip;
 	DECLARE_BITMAP(used, INT_PCI_MSI_NR);
 	struct irq_domain *domain;
 	struct mutex lock;
 	void *virt;
 	dma_addr_t phys;
 	int irq;
+
+	struct irq_chip top, bottom;
+	struct msi_domain_info info;
 };
 
 /* used to differentiate between Tegra SoC generations */
@@ -333,11 +321,6 @@ struct tegra_pcie_soc {
 	} ectl;
 };
 
-static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
-{
-	return container_of(chip, struct tegra_msi, chip);
-}
-
 struct tegra_pcie {
 	struct device *dev;
 
@@ -372,6 +355,11 @@ struct tegra_pcie {
 	struct dentry *debugfs;
 };
 
+static inline struct tegra_pcie *msi_to_pcie(struct tegra_msi *msi)
+{
+	return container_of(msi, struct tegra_pcie, msi);
+}
+
 struct tegra_pcie_port {
 	struct tegra_pcie *pcie;
 	struct device_node *np;
@@ -1432,7 +1420,6 @@ static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
 	}
 }
 
-
 static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1509,6 +1496,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 phys_put:
 	if (soc->program_uphy)
 		tegra_pcie_phys_put(pcie);
+
 	return err;
 }
 
@@ -1551,56 +1539,25 @@ static void tegra_pcie_pme_turnoff(struct tegra_pcie_port *port)
 	afi_writel(pcie, val, AFI_PCIE_PME);
 }
 
-static int tegra_msi_alloc(struct tegra_msi *chip)
-{
-	int msi;
-
-	mutex_lock(&chip->lock);
-
-	msi = find_first_zero_bit(chip->used, INT_PCI_MSI_NR);
-	if (msi < INT_PCI_MSI_NR)
-		set_bit(msi, chip->used);
-	else
-		msi = -ENOSPC;
-
-	mutex_unlock(&chip->lock);
-
-	return msi;
-}
-
-static void tegra_msi_free(struct tegra_msi *chip, unsigned long irq)
+static void tegra_pcie_msi_irq(struct irq_desc *desc)
 {
-	struct device *dev = chip->chip.dev;
-
-	mutex_lock(&chip->lock);
-
-	if (!test_bit(irq, chip->used))
-		dev_err(dev, "trying to free unused MSI#%lu\n", irq);
-	else
-		clear_bit(irq, chip->used);
-
-	mutex_unlock(&chip->lock);
-}
-
-static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
-{
-	struct tegra_pcie *pcie = data;
-	struct device *dev = pcie->dev;
+	struct tegra_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct tegra_msi *msi = &pcie->msi;
-	unsigned int i, processed = 0;
+	struct device *dev = pcie->dev;
+	unsigned int i;
+
+	chained_irq_enter(chip, desc);
 
 	for (i = 0; i < 8; i++) {
-		unsigned long reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
+		unsigned long reg = afi_readl(pcie, AFI_MSI_VEC(i));
 
 		while (reg) {
 			unsigned int offset = find_first_bit(&reg, 32);
 			unsigned int index = i * 32 + offset;
 			unsigned int irq;
 
-			/* clear the interrupt */
-			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
-
-			irq = irq_find_mapping(msi->domain, index);
+			irq = irq_find_mapping(msi->domain->parent, index);
 			if (irq) {
 				if (test_bit(index, msi->used))
 					generic_handle_irq(irq);
@@ -1615,81 +1572,168 @@ static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
 			}
 
 			/* see if there's any more pending in this vector */
-			reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
-
-			processed++;
+			reg = afi_readl(pcie, AFI_MSI_VEC(i));
 		}
 	}
 
-	return processed > 0 ? IRQ_HANDLED : IRQ_NONE;
+	chained_irq_exit(chip, desc);
+}
+
+static void tegra_msi_top_irq_ack(struct irq_data *d)
+{
+	irq_chip_ack_parent(d);
+}
+
+static void tegra_msi_top_irq_mask(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void tegra_msi_top_irq_unmask(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static void tegra_msi_irq_ack(struct irq_data *d)
+{
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
+	struct tegra_pcie *pcie = msi_to_pcie(msi);
+	unsigned int index = d->hwirq / 32;
+
+	/* clear the interrupt */
+	afi_writel(pcie, BIT(d->hwirq % 32), AFI_MSI_VEC(index));
+}
+
+static void tegra_msi_irq_mask(struct irq_data *d)
+{
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
+	struct tegra_pcie *pcie = msi_to_pcie(msi);
+	unsigned int index = d->hwirq / 32;
+	u32 value;
+
+	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+	value &= ~BIT(d->hwirq % 32);
+	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
+}
+
+static void tegra_msi_irq_unmask(struct irq_data *d)
+{
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
+	struct tegra_pcie *pcie = msi_to_pcie(msi);
+	unsigned int index = d->hwirq / 32;
+	u32 value;
+
+	value = afi_readl(pcie, AFI_MSI_EN_VEC(index));
+	value |= BIT(d->hwirq % 32);
+	afi_writel(pcie, value, AFI_MSI_EN_VEC(index));
 }
 
-static int tegra_msi_setup_irq(struct msi_controller *chip,
-			       struct pci_dev *pdev, struct msi_desc *desc)
+static int tegra_msi_set_affinity(struct irq_data *d, const struct cpumask *mask, bool force)
 {
-	struct tegra_msi *msi = to_tegra_msi(chip);
-	struct msi_msg msg;
-	unsigned int irq;
+	return -EINVAL;
+}
+
+static void tegra_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(data);
+
+	msg->address_lo = lower_32_bits(msi->phys);
+	msg->address_hi = upper_32_bits(msi->phys);
+	msg->data = data->hwirq;
+}
+
+static int tegra_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
+{
+	struct tegra_msi *msi = domain->host_data;
+	unsigned int i;
 	int hwirq;
 
-	hwirq = tegra_msi_alloc(msi);
-	if (hwirq < 0)
-		return hwirq;
+	mutex_lock(&msi->lock);
 
-	irq = irq_create_mapping(msi->domain, hwirq);
-	if (!irq) {
-		tegra_msi_free(msi, hwirq);
-		return -EINVAL;
-	}
+	hwirq = bitmap_find_free_region(msi->used, INT_PCI_MSI_NR, order_base_2(nr_irqs));
 
-	irq_set_msi_desc(irq, desc);
+	mutex_unlock(&msi->lock);
 
-	msg.address_lo = lower_32_bits(msi->phys);
-	msg.address_hi = upper_32_bits(msi->phys);
-	msg.data = hwirq;
+	if (hwirq < 0)
+		return -ENOSPC;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, hwirq + i, &msi->bottom, domain->host_data,
+				    handle_edge_irq, NULL, NULL);
 
-	pci_write_msi_msg(irq, &msg);
+	tegra_cpuidle_pcie_irqs_in_use();
 
 	return 0;
 }
 
-static void tegra_msi_teardown_irq(struct msi_controller *chip,
-				   unsigned int irq)
+static void tegra_msi_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
 {
-	struct tegra_msi *msi = to_tegra_msi(chip);
-	struct irq_data *d = irq_get_irq_data(irq);
-	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
+
+	mutex_lock(&msi->lock);
 
-	irq_dispose_mapping(irq);
-	tegra_msi_free(msi, hwirq);
+	bitmap_release_region(msi->used, d->hwirq, order_base_2(nr_irqs));
+
+	mutex_unlock(&msi->lock);
 }
 
-static struct irq_chip tegra_msi_irq_chip = {
-	.name = "Tegra PCIe MSI",
-	.irq_enable = pci_msi_unmask_irq,
-	.irq_disable = pci_msi_mask_irq,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
+static const struct irq_domain_ops tegra_msi_domain_ops = {
+	.alloc = tegra_msi_domain_alloc,
+	.free = tegra_msi_domain_free,
 };
 
-static int tegra_msi_map(struct irq_domain *domain, unsigned int irq,
-			 irq_hw_number_t hwirq)
+static int tegra_allocate_domains(struct tegra_msi *msi)
 {
-	irq_set_chip_and_handler(irq, &tegra_msi_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
+	struct tegra_pcie *pcie = container_of(msi, struct tegra_pcie, msi);
+	struct fwnode_handle *fwnode = of_node_to_fwnode(pcie->dev->of_node);
+	struct irq_domain *parent;
 
-	tegra_cpuidle_pcie_irqs_in_use();
+	msi->top.name = "Tegra PCIe MSI";
+	msi->top.irq_ack = tegra_msi_top_irq_ack;
+	msi->top.irq_mask = tegra_msi_top_irq_mask;
+	msi->top.irq_unmask = tegra_msi_top_irq_unmask;
+
+	msi->info.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX;
+	msi->info.chip = &msi->top;
+
+	msi->bottom.name = "Tegra MSI";
+	msi->bottom.irq_ack = tegra_msi_irq_ack;
+	msi->bottom.irq_mask = tegra_msi_irq_mask;
+	msi->bottom.irq_unmask = tegra_msi_irq_unmask;
+	msi->bottom.irq_set_affinity = tegra_msi_set_affinity;
+	msi->bottom.irq_compose_msi_msg = tegra_compose_msi_msg;
+
+	parent = irq_domain_add_linear(NULL, INT_PCI_MSI_NR, &tegra_msi_domain_ops, msi);
+	if (!parent) {
+		dev_err(pcie->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->domain = pci_msi_create_irq_domain(fwnode, &msi->info, parent);
+	if (!msi->domain) {
+		dev_err(pcie->dev, "failed to create MSI domain\n");
+		irq_domain_remove(parent);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
 
-static const struct irq_domain_ops msi_domain_ops = {
-	.map = tegra_msi_map,
-};
+static void tegra_free_domains(struct tegra_msi *msi)
+{
+	struct irq_domain *parent = msi->domain->parent;
+
+	irq_domain_remove(msi->domain);
+	irq_domain_remove(parent);
+}
 
 static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 {
-	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct platform_device *pdev = to_platform_device(pcie->dev);
 	struct tegra_msi *msi = &pcie->msi;
 	struct device *dev = pcie->dev;
@@ -1697,15 +1741,10 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 
 	mutex_init(&msi->lock);
 
-	msi->chip.dev = dev;
-	msi->chip.setup_irq = tegra_msi_setup_irq;
-	msi->chip.teardown_irq = tegra_msi_teardown_irq;
-
-	msi->domain = irq_domain_add_linear(dev->of_node, INT_PCI_MSI_NR,
-					    &msi_domain_ops, &msi->chip);
-	if (!msi->domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = tegra_allocate_domains(msi);
+		if (err)
+			return err;
 	}
 
 	err = platform_get_irq_byname(pdev, "msi");
@@ -1714,12 +1753,7 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 
 	msi->irq = err;
 
-	err = request_irq(msi->irq, tegra_pcie_msi_irq, IRQF_NO_THREAD,
-			  tegra_msi_irq_chip.name, pcie);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
-		goto free_irq_domain;
-	}
+	irq_set_chained_handler_and_data(msi->irq, tegra_pcie_msi_irq, pcie);
 
 	/* Though the PCIe controller can address >32-bit address space, to
 	 * facilitate endpoints that support only 32-bit MSI target address,
@@ -1740,14 +1774,14 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 		goto free_irq;
 	}
 
-	host->msi = &msi->chip;
-
 	return 0;
 
 free_irq:
-	free_irq(msi->irq, pcie);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
 free_irq_domain:
-	irq_domain_remove(msi->domain);
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_free_domains(msi);
+
 	return err;
 }
 
@@ -1762,16 +1796,6 @@ static void tegra_pcie_enable_msi(struct tegra_pcie *pcie)
 	/* this register is in 4K increments */
 	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
 
-	/* enable all MSI vectors */
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC0);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC1);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC2);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC3);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC4);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC5);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC6);
-	afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC7);
-
 	/* and unmask the MSI interrupt */
 	reg = afi_readl(pcie, AFI_INTR_MASK);
 	reg |= AFI_INTR_MASK_MSI_MASK;
@@ -1786,16 +1810,16 @@ static void tegra_pcie_msi_teardown(struct tegra_pcie *pcie)
 	dma_free_attrs(pcie->dev, PAGE_SIZE, msi->virt, msi->phys,
 		       DMA_ATTR_NO_KERNEL_MAPPING);
 
-	if (msi->irq > 0)
-		free_irq(msi->irq, pcie);
-
 	for (i = 0; i < INT_PCI_MSI_NR; i++) {
 		irq = irq_find_mapping(msi->domain, i);
 		if (irq > 0)
 			irq_dispose_mapping(irq);
 	}
 
-	irq_domain_remove(msi->domain);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		tegra_free_domains(msi);
 }
 
 static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
@@ -1807,16 +1831,6 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
 	value &= ~AFI_INTR_MASK_MSI_MASK;
 	afi_writel(pcie, value, AFI_INTR_MASK);
 
-	/* disable all MSI vectors */
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC0);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC1);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC2);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC3);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC4);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC5);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC6);
-	afi_writel(pcie, 0, AFI_MSI_EN_VEC7);
-
 	return 0;
 }
 
-- 
2.28.0

