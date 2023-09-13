Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0679E3ED
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 11:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbjIMJkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIMJkO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 05:40:14 -0400
X-Greylist: delayed 965 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 02:40:10 PDT
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC162196
        for <linux-pci@vger.kernel.org>; Wed, 13 Sep 2023 02:40:10 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 4deb2a05-8640-4544-89e5-1536601b7885;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 306FA1C03D9;
        Wed, 13 Sep 2023 18:24:03 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, linux-pci@vger.kernel.org
Subject: [RFC PATCH v2 07/30] drivers/pci: SH7751 PCI Host bridge controller driver.
Date:   Wed, 13 Sep 2023 18:23:32 +0900
Message-Id: <7f25af9e93fbb84c8e4fe6da3c0c13b0a6be2c73.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/pci/controller/pci-sh7751.c | 338 ++++++++++++++++++++++++++++
 1 file changed, 338 insertions(+)
 create mode 100644 drivers/pci/controller/pci-sh7751.c

diff --git a/drivers/pci/controller/pci-sh7751.c b/drivers/pci/controller/pci-sh7751.c
new file mode 100644
index 000000000000..f6718c6b403b
--- /dev/null
+++ b/drivers/pci/controller/pci-sh7751.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SH7751 PCI driver
+ * Copyright (C) 2023 Yoshinori Sato
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <asm-generic/pci.h>
+#include "pci-sh7751.h"
+
+#define pcic_writel(val, reg) __raw_writel(val, pci_reg_base + (reg))
+#define pcic_readl(reg) __raw_readl(pci_reg_base + (reg))
+
+DEFINE_RAW_SPINLOCK(pci_config_lock);
+
+/*
+ * PCIC fixups
+ */
+
+#define PCIMCR_MRSET 0x40000000
+#define PCIMCR_RFSH  0x00000004
+
+/* board depend PCI bus fixups */
+static void __init julian_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = __raw_readl(bcr + SH7751_BCR1);
+	bcr1 |= 0x00080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	mcr = __raw_readl(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, SH7751_PCICONF5);
+	pcic_writel(0xd0000000, SH7751_PCICONF6);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
+static void __init r2d_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = ioread32(bcr + SH7751_BCR1);
+	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	/* Enable all interrupts, so we known what to fix */
+	pcic_writel(0x0000c3ff, SH4_PCIINTM);
+	pcic_writel(0x0000380f, SH4_PCIAINTM);
+
+	pcic_writel(0xfb900047, SH7751_PCICONF1);
+	pcic_writel(0xab000001, SH7751_PCICONF4);
+
+	mcr = ioread32(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, SH7751_PCICONF5);
+	pcic_writel(0xd0000000, SH7751_PCICONF6);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
+static const __initconst struct fixups {
+	char *compatible;
+	void (*fixup)(void __iomem *pci_reg_base, void __iomem *bcr);
+} fixup_list[] = {
+	{
+		.compatible = "iodata,julian-pci",
+		.fixup = julian_fixup,
+	},
+	{
+		.compatible = "renesas,r2d-pci",
+		.fixup = r2d_fixup,
+	},
+};
+
+static void pcic_fixups(struct device_node *np,
+		       void __iomem *pcic, void __iomem *bcr)
+{
+	int i;
+	const struct fixups *f = fixup_list;
+
+	for (i = 0; i < ARRAY_SIZE(fixup_list); i++) {
+		if (of_device_is_compatible(np, f->compatible)) {
+			f->fixup(pcic, bcr);
+			break;
+		}
+	}
+}
+
+/*
+ * Direct access to PCI hardware...
+ */
+#define CONFIG_CMD(bus, devfn, where) \
+	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
+
+/*
+ * Functions for accessing PCI configuration space with type 1 accesses
+ */
+static int sh4_pci_read(struct pci_bus *bus, unsigned int devfn,
+			   int where, int size, u32 *val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pci_reg_base = (void __iomem *)cfg->res.start;
+	unsigned long flags;
+	u32 data;
+
+	/*
+	 * PCIPDR may only be accessed as 32 bit words,
+	 * so we must do byte alignment by hand
+	 */
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pcic_readl(SH4_PCIPDR);
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	switch (size) {
+	case 1:
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+		break;
+	case 2:
+		*val = (data >> ((where & 2) << 3)) & 0xffff;
+		break;
+	case 4:
+		*val = data;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * Since SH4 only does 32bit access we'll have to do a read,
+ * mask,write operation.
+ * We'll allow an odd byte offset, though it should be illegal.
+ */
+static int sh4_pci_write(struct pci_bus *bus, unsigned int devfn,
+			 int where, int size, u32 val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pci_reg_base = (void __iomem *)cfg->res.start;
+	unsigned long flags;
+	int shift;
+	u32 data;
+
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pcic_readl(SH4_PCIPDR);
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	switch (size) {
+	case 1:
+		shift = (where & 3) << 3;
+		data &= ~(0xff << shift);
+		data |= ((val & 0xff) << shift);
+		break;
+	case 2:
+		shift = (where & 2) << 3;
+		data &= ~(0xffff << shift);
+		data |= ((val & 0xffff) << shift);
+		break;
+	case 4:
+		data = val;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	pcic_writel(data, SH4_PCIPDR);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int area_sdram_check(void __iomem *pci_reg_base,
+			    void __iomem *bcr,
+			    unsigned int area)
+{
+	unsigned long word;
+
+	word = __raw_readl(bcr + SH7751_BCR1);
+	/* check BCR for SDRAM in area */
+	if (((word >> area) & 1) == 0) {
+		pr_info("PCI: Area %d is not configured for SDRAM. BCR1=0x%lx\n",
+		       area, word);
+		return 0;
+	}
+	pcic_writel(word, SH4_PCIBCR1);
+
+	word = __raw_readw(bcr + SH7751_BCR2);
+	/* check BCR2 for 32bit SDRAM interface*/
+	if (((word >> (area << 1)) & 0x3) != 0x3) {
+		pr_info("PCI: Area %d is not 32 bit SDRAM. BCR2=0x%lx\n",
+			area, word);
+		return 0;
+	}
+	pcic_writel(word, SH4_PCIBCR2);
+
+	return 1;
+}
+
+static int sh7751_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res, *wres;
+	u32 id;
+	u32 reg, word;
+	void __iomem *pci_reg_base;
+	void __iomem *bcr;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pci_reg_base = (void __iomem *)res->start;
+	if (IS_ERR(pci_reg_base))
+		return PTR_ERR(pci_reg_base);
+
+	wres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (IS_ERR(wres))
+		return PTR_ERR(wres);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	bcr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pci_reg_base))
+		return PTR_ERR(bcr);
+
+	/* check for SH7751/SH7751R hardware */
+	id = pcic_readl(SH7751_PCICONF0);
+	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
+	    id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
+		pr_warn("PCI: This is not an SH7751(R)\n");
+		return -ENODEV;
+	}
+	dev_info(&pdev->dev, "PCI core found at %p\n",
+		pci_reg_base);
+
+	/* Set the BCR's to enable PCI access */
+	reg = __raw_readl(bcr);
+	reg |= 0x80000;
+	__raw_writel(reg, bcr);
+
+	/* Turn the clocks back on (not done in reset)*/
+	pcic_writel(0, SH4_PCICLKR);
+	/* Clear Powerdown IRQ's (not done in reset) */
+	word = SH4_PCIPINT_D3 | SH4_PCIPINT_D0;
+	pcic_writel(word, SH4_PCIPINT);
+
+	/* set the command/status bits to:
+	 * Wait Cycle Control + Parity Enable + Bus Master +
+	 * Mem space enable
+	 */
+	word = SH7751_PCICONF1_WCC | SH7751_PCICONF1_PER |
+	       SH7751_PCICONF1_BUM | SH7751_PCICONF1_MES;
+	pcic_writel(word, SH7751_PCICONF1);
+
+	/* define this host as the host bridge */
+	word = PCI_BASE_CLASS_BRIDGE << 24;
+	pcic_writel(word, SH7751_PCICONF2);
+
+	/* Set IO and Mem windows to local address
+	 * Make PCI and local address the same for easy 1 to 1 mapping
+	 */
+	word = wres->end - wres->start - 1;
+	pcic_writel(word, SH4_PCILSR0);
+	/* Set the values on window 0 PCI config registers */
+	word = P2SEGADDR(wres->start);
+	pcic_writel(word, SH4_PCILAR0);
+	pcic_writel(word, SH7751_PCICONF5);
+
+	/* check BCR for SDRAM in specified area */
+	area_sdram_check(pci_reg_base, bcr, (wres->start >> 27) & 0x07);
+
+	/* configure the wait control registers */
+	word = __raw_readl(bcr + SH7751_WCR1);
+	pcic_writel(word, SH4_PCIWCR1);
+	word = __raw_readl(bcr + SH7751_WCR2);
+	pcic_writel(word, SH4_PCIWCR2);
+	word = __raw_readl(bcr + SH7751_WCR3);
+	pcic_writel(word, SH4_PCIWCR3);
+	word = __raw_readl(bcr + SH7751_MCR);
+	pcic_writel(word, SH4_PCIMCR);
+
+	pcic_fixups(pdev->dev.of_node, pci_reg_base, bcr);
+
+	/* SH7751 init done, set central function init complete */
+	/* use round robin mode to stop a device starving/overruning */
+	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
+	pcic_writel(word, SH4_PCICR);
+
+	return pci_host_common_probe(pdev);
+}
+
+static void __iomem *sh4_pci_map_bus(struct pci_bus *bus,
+				     unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pci_reg_base = (void __iomem *)cfg->res.start;
+
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	return pci_reg_base + SH4_PCIPDR;
+}
+
+static const struct pci_ecam_ops pci_sh7751_bus_ops = {
+	.pci_ops	= {
+		.map_bus	= sh4_pci_map_bus,
+		.read		= sh4_pci_read,
+		.write		= sh4_pci_write,
+	}
+};
+
+static const struct of_device_id sh7751_pci_of_match[] = {
+	{ .compatible = "renesas,sh7751-pci",
+	  .data = &pci_sh7751_bus_ops },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sh7751_pci_of_match);
+
+static struct platform_driver sh7751_pci_driver = {
+	.driver = {
+		.name = "sh7751-pci",
+		.of_match_table = sh7751_pci_of_match,
+	},
+	.probe = sh7751_pci_probe,
+};
+module_platform_driver(sh7751_pci_driver);
+
+MODULE_DESCRIPTION("SH7751 PCI driver");
-- 
2.39.2

