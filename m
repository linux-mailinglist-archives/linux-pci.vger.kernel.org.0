Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2377C94F8
	for <lists+linux-pci@lfdr.de>; Sat, 14 Oct 2023 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjJNOyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Oct 2023 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjJNOyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2023 10:54:23 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CC4DA
        for <linux-pci@vger.kernel.org>; Sat, 14 Oct 2023 07:54:19 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-2.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 55c299d5-380a-4292-9aa5-96132a7e41d3;
        Sat, 14 Oct 2023 23:54:18 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id 6E92C1C03DF;
        Sat, 14 Oct 2023 23:54:17 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH v3 09/35] drivers/pci/controller: SH7751 PCI Host bridge driver.
Date:   Sat, 14 Oct 2023 23:53:44 +0900
Message-Id: <f12aac0b3cf76ca42b2cacf7b5c149bb88228a6e.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci-sh7751.h move from "arch/sh/drivers/pci/pci-sh7751.h"
pci-sh7751.c convert from "arch/sh/drivers/pci/pci-sh7751.c"

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/pci/controller/Kconfig      |   9 +
 drivers/pci/controller/Makefile     |   1 +
 drivers/pci/controller/pci-sh7751.c | 285 ++++++++++++++++++++++++++++
 drivers/pci/controller/pci-sh7751.h | 267 ++++++++++++++++++++++++++
 4 files changed, 562 insertions(+)
 create mode 100644 drivers/pci/controller/pci-sh7751.c
 create mode 100644 drivers/pci/controller/pci-sh7751.h

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index c0c3f2824990..037ff44bd1e8 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -342,6 +342,15 @@ config PCIE_XILINX_CPM
 	  Say 'Y' here if you want kernel support for the
 	  Xilinx Versal CPM host bridge.
 
+config PCI_SH7751
+	bool "Renesas SH7751 PCI controller"
+	depends on OF
+	depends on CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST
+	select PCI_HOST_COMMON
+	help
+	  Say 'Y' here if you want kernel to support the Renesas SH7751 PCI
+	  Host Bridge driver.
+
 source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 37c8663de7fe..ce96cfe9f1f2 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
 obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
 obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
 obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
+obj-$(CONFIG_PCI_SH7751) += pci-sh7751.o
 
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
diff --git a/drivers/pci/controller/pci-sh7751.c b/drivers/pci/controller/pci-sh7751.c
new file mode 100644
index 000000000000..4aecd0224eb1
--- /dev/null
+++ b/drivers/pci/controller/pci-sh7751.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SH7751 PCI driver
+ * Copyright (C) 2023 Yoshinori Sato
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
+#include <asm/addrspace.h>
+#include "pci-sh7751.h"
+
+#define pcic_writel(val, base, reg) __raw_writel(val, base + (reg))
+#define pcic_readl(base, reg) __raw_readl(base + (reg))
+
+/*
+ * PCIC fixups
+ */
+
+static inline void pci_fixup_write_regs(struct device_node *np,
+					const char *prop,
+					void __iomem *pcic, int reg,
+					int nr_regs)
+{
+	int i;
+	u32 val;
+
+	for (i = 0; i < nr_regs; i++) {
+		if (of_property_read_u32_index(np, prop, i, &val))
+			pcic_writel(val, pcic, reg + i * 4);
+	}
+}
+
+#define SH7751_NUM_CONFIG 18
+static void pcic_fixups(struct device_node *np,
+		       void __iomem *pcic, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+	u32 val;
+	int i, r;
+	u32 pci_config[SH7751_NUM_CONFIG * 2];
+
+	const struct {
+		const char *name;
+		int reg;
+		int nr;
+	} reg_prop[] = {
+		/*
+		 *  The bus timing uses the bootloader settings,
+		 *  so do not change them here.
+		 */
+		{ "renesas,intm",  SH4_PCIINTM,  1, },
+		{ "renesas,aintm", SH4_PCIAINTM, 1, },
+		{ "renesas,lsr",   SH4_PCILSR0,  2, },
+		{ "renesas,lar",   SH4_PCILAR0,  2, },
+		{ "renesas,dmabt", SH4_PCIDMABT, 1, },
+		{ "renesas,pintm", SH4_PCIPINTM, 1, },
+	};
+
+	if (of_property_read_u32(np, "sh7751-pci,bcr1", &val)) {
+		bcr1 = ioread32(bcr + SH7751_BCR1);
+		bcr1 |= val;
+		pcic_writel(bcr1, pcic, SH4_PCIBCR1);
+	}
+	if (of_property_read_u32(np, "renesas,clkr", &val)) {
+		val |= 0xa5 << 24;
+		pcic_writel(val, pcic, SH4_PCIBCR1);
+	}
+	for (i = 0; i < ARRAY_SIZE(reg_prop); i++)
+		pci_fixup_write_regs(np, reg_prop[i].name, pcic,
+				     reg_prop[i].reg, reg_prop[i].nr);
+
+	memset(pci_config, 0, sizeof(pci_config));
+	if (of_property_read_u32_array(np, "renesas,config",
+				       pci_config, SH7751_NUM_CONFIG) == 0) {
+		for (i = 0; i < SH7751_NUM_CONFIG; i++) {
+			r = pci_config[i * 2];
+			/* CONFIG0 is read-only, so make it a sentinel. */
+			if (r == 0)
+				break;
+			pcic_writel(pci_config[i * 2 + 1], pcic,
+				    SH7751_PCICONF0 + r * 4);
+		}
+	}
+
+	if (of_property_read_u32(np, "sh7751-pci,mcrmask", &val)) {
+		mcr = ioread32(bcr + SH7751_MCR);
+		mcr &= ~val;
+		pcic_writel(mcr, pcic, SH4_PCIMCR);
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
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ */
+#define IO_REGION_BASE 0x1000
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	if (res->flags & IORESOURCE_IO) {
+		if (start < PCIBIOS_MIN_IO + IO_REGION_BASE)
+			start = PCIBIOS_MIN_IO + IO_REGION_BASE;
+
+		/*
+		 * Put everything into 0x00-0xff region modulo 0x400.
+		 */
+		if (start & 0x300)
+			start = (start + 0x3ff) & ~0x3ff;
+	}
+
+	return start;
+}
+
+static int area_sdram_check(struct device *dev, void __iomem *pcic,
+			    void __iomem *bcr, unsigned int area)
+{
+	unsigned long word;
+
+	word = __raw_readl(bcr + SH7751_BCR1);
+	/* check BCR for SDRAM in area */
+	if (((word >> area) & 1) == 0) {
+		dev_info(dev, "PCI: Area %d is not configured for SDRAM. BCR1=0x%lx\n",
+		       area, word);
+		return 0;
+	}
+	pcic_writel(word, pcic, SH4_PCIBCR1);
+
+	word = __raw_readw(bcr + SH7751_BCR2);
+	/* check BCR2 for 32bit SDRAM interface*/
+	if (((word >> (area << 1)) & 0x3) != 0x3) {
+		dev_info(dev, "PCI: Area %d is not 32 bit SDRAM. BCR2=0x%lx\n",
+			area, word);
+		return 0;
+	}
+	pcic_writel(word, pcic, SH4_PCIBCR2);
+
+	return 1;
+}
+
+static void set_pci_window(void __iomem *pcic, int no, struct resource *res)
+{
+	u32 word;
+
+	word = res->end - res->start - 1;
+	pcic_writel(word, pcic, SH4_PCILSR0 + no * 4);
+	word = P2SEGADDR(res->start);
+	pcic_writel(word, pcic, SH4_PCILAR0 + no * 4);
+	pcic_writel(word, pcic, SH7751_PCICONF5 + no * 4);
+}
+
+static int sh7751_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res, *w0res;
+	u32 id;
+	u32 reg, word;
+	void __iomem *pcic;
+	void __iomem *bcr;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pcic = (void __iomem *)res->start;
+	if (IS_ERR(pcic))
+		return PTR_ERR(pcic);
+
+	w0res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (IS_ERR(w0res))
+		return PTR_ERR(w0res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	bcr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(bcr))
+		return PTR_ERR(bcr);
+
+	/* check for SH7751/SH7751R hardware */
+	id = pcic_readl(pcic, SH7751_PCICONF0);
+	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
+	    id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
+		dev_warn(&pdev->dev, "PCI: This is not an SH7751(R)\n");
+		return -ENODEV;
+	}
+	dev_info(&pdev->dev, "PCI core found at %pR\n", pcic);
+
+	/* Set the BCR's to enable PCI access */
+	reg = __raw_readl(bcr);
+	reg |= 0x80000;
+	__raw_writel(reg, bcr);
+
+	/* Turn the clocks back on (not done in reset)*/
+	pcic_writel(0, pcic, SH4_PCICLKR);
+	/* Clear Powerdown IRQ's (not done in reset) */
+	word = SH4_PCIPINT_D3 | SH4_PCIPINT_D0;
+	pcic_writel(word, pcic, SH4_PCIPINT);
+
+	/* set the command/status bits to:
+	 * Wait Cycle Control + Parity Enable + Bus Master +
+	 * Mem space enable
+	 */
+	word = SH7751_PCICONF1_WCC | SH7751_PCICONF1_PER |
+	       SH7751_PCICONF1_BUM | SH7751_PCICONF1_MES;
+	pcic_writel(word, pcic, SH7751_PCICONF1);
+
+	/* define this host as the host bridge */
+	word = PCI_BASE_CLASS_BRIDGE << 24;
+	pcic_writel(word, pcic, SH7751_PCICONF2);
+
+	/* Set IO and Mem windows to local address
+	 * Make PCI and local address the same for easy 1 to 1 mapping
+	 */
+	set_pci_window(pcic, 0, w0res);	/* memory */
+
+	/* check BCR for SDRAM in specified area */
+	area_sdram_check(&pdev->dev, pcic, bcr, (w0res->start >> 27) & 0x07);
+
+	/* configure the wait control registers */
+	word = __raw_readl(bcr + SH7751_WCR1);
+	pcic_writel(word, pcic, SH4_PCIWCR1);
+	word = __raw_readl(bcr + SH7751_WCR2);
+	pcic_writel(word, pcic, SH4_PCIWCR2);
+	word = __raw_readl(bcr + SH7751_WCR3);
+	pcic_writel(word, pcic, SH4_PCIWCR3);
+	word = __raw_readl(bcr + SH7751_MCR);
+	pcic_writel(word, pcic, SH4_PCIMCR);
+
+	/* Override register setting */
+	pcic_fixups(pdev->dev.of_node, pcic, bcr);
+
+	/* SH7751 init done, set central function init complete */
+	/* use round robin mode to stop a device starving/overrunning */
+	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
+	pcic_writel(word, pcic, SH4_PCICR);
+
+	return pci_host_common_probe(pdev);
+}
+
+static void __iomem *sh4_pci_map_bus(struct pci_bus *bus,
+				     unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pcic = (void __iomem *)cfg->res.start;
+
+	pcic_writel(CONFIG_CMD(bus, devfn, where), pcic, SH4_PCIPAR);
+	return pcic + SH4_PCIPDR;
+}
+
+static const struct pci_ecam_ops pci_sh7751_bus_ops = {
+	.pci_ops	= {
+		.map_bus = sh4_pci_map_bus,
+		.read    = pci_generic_config_read32,
+		.write   = pci_generic_config_write32,
+	}
+};
+
+static const struct of_device_id sh7751_pci_of_match[] = {
+	{ .compatible = "renesas,pci-sh7751",
+	  .data = &pci_sh7751_bus_ops },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sh7751_pci_of_match);
+
+static struct platform_driver sh7751_pci_driver = {
+	.driver = {
+		.name = "pci-sh7751",
+		.of_match_table = sh7751_pci_of_match,
+	},
+	.probe = sh7751_pci_probe,
+};
+module_platform_driver(sh7751_pci_driver);
+
+MODULE_DESCRIPTION("SH7751 PCI driver");
diff --git a/drivers/pci/controller/pci-sh7751.h b/drivers/pci/controller/pci-sh7751.h
new file mode 100644
index 000000000000..b2d74d57addb
--- /dev/null
+++ b/drivers/pci/controller/pci-sh7751.h
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *	Low-Level PCI Support for SH7751 targets
+ *
+ *  Dustin McIntire (dustin@sensoria.com) (c) 2001
+ *  Paul Mundt (lethal@linux-sh.org) (c) 2003
+ *
+ */
+
+#ifndef _PCI_SH7751_H_
+#define _PCI_SH7751_H_
+
+#define SH4_PCICR		0x100		/* PCI Control Register */
+  #define SH4_PCICR_PREFIX	  0xA5000000	/* CR prefix for write */
+  #define SH4_PCICR_FTO		  0x00000400	/* TRDY/IRDY Enable */
+  #define SH4_PCICR_TRSB	  0x00000200	/* Target Read Single */
+  #define SH4_PCICR_BSWP	  0x00000100	/* Target Byte Swap */
+  #define SH4_PCICR_PLUP	  0x00000080	/* Enable PCI Pullup */
+  #define SH4_PCICR_ARBM	  0x00000040	/* PCI Arbitration Mode */
+  #define SH4_PCICR_MD		  0x00000030	/* MD9 and MD10 status */
+  #define SH4_PCICR_SERR	  0x00000008	/* SERR output assert */
+  #define SH4_PCICR_INTA	  0x00000004	/* INTA output assert */
+  #define SH4_PCICR_PRST	  0x00000002	/* PCI Reset Assert */
+  #define SH4_PCICR_CFIN	  0x00000001	/* Central Fun. Init Done */
+#define SH4_PCILSR0		0x104		/* PCI Local Space Register0 */
+#define SH4_PCILSR1		0x108		/* PCI Local Space Register1 */
+#define SH4_PCILAR0		0x10C		/* PCI Local Addr Register1 */
+#define SH4_PCILAR1		0x110		/* PCI Local Addr Register1 */
+#define SH4_PCIINT		0x114		/* PCI Interrupt Register */
+  #define SH4_PCIINT_MLCK	  0x00008000	/* Master Lock Error */
+  #define SH4_PCIINT_TABT	  0x00004000	/* Target Abort Error */
+  #define SH4_PCIINT_TRET	  0x00000200	/* Target Retry Error */
+  #define SH4_PCIINT_MFDE	  0x00000100	/* Master Func. Disable Error */
+  #define SH4_PCIINT_PRTY	  0x00000080	/* Address Parity Error */
+  #define SH4_PCIINT_SERR	  0x00000040	/* SERR Detection Error */
+  #define SH4_PCIINT_TWDP	  0x00000020	/* Tgt. Write Parity Error */
+  #define SH4_PCIINT_TRDP	  0x00000010	/* Tgt. Read Parity Err Det. */
+  #define SH4_PCIINT_MTABT	  0x00000008	/* Master-Tgt. Abort Error */
+  #define SH4_PCIINT_MMABT	  0x00000004	/* Master-Master Abort Error */
+  #define SH4_PCIINT_MWPD	  0x00000002	/* Master Write PERR Detect */
+  #define SH4_PCIINT_MRPD	  0x00000001	/* Master Read PERR Detect */
+#define SH4_PCIINTM		0x118		/* PCI Interrupt Mask */
+  #define SH4_PCIINTM_TTADIM	  BIT(14)	/* Target-target abort interrupt */
+  #define SH4_PCIINTM_TMTOIM	  BIT(9)	/* Target retry timeout */
+  #define SH4_PCIINTM_MDEIM	  BIT(8)	/* Master function disable error */
+  #define SH4_PCIINTM_APEDIM	  BIT(7)	/* Address parity error detection */
+  #define SH4_PCIINTM_SDIM	  BIT(6)	/* SERR detection */
+  #define SH4_PCIINTM_DPEITWM	  BIT(5)	/* Data parity error for target write */
+  #define SH4_PCIINTM_PEDITRM	  BIT(4)	/* PERR detection for target read */
+  #define SH4_PCIINTM_TADIMM	  BIT(3)	/* Target abort for master */
+  #define SH4_PCIINTM_MADIMM	  BIT(2)	/* Master abort for master */
+  #define SH4_PCIINTM_MWPDIM	  BIT(1)	/* Master write data parity error */
+  #define SH4_PCIINTM_MRDPEIM	  BIT(0)	/* Master read data parity error */
+#define SH4_PCIALR		0x11C		/* Error Address Register */
+#define SH4_PCICLR		0x120		/* Error Command/Data */
+  #define SH4_PCICLR_MPIO	  0x80000000
+  #define SH4_PCICLR_MDMA0	  0x40000000	/* DMA0 Transfer Error */
+  #define SH4_PCICLR_MDMA1	  0x20000000	/* DMA1 Transfer Error */
+  #define SH4_PCICLR_MDMA2	  0x10000000	/* DMA2 Transfer Error */
+  #define SH4_PCICLR_MDMA3	  0x08000000	/* DMA3 Transfer Error */
+  #define SH4_PCICLR_TGT	  0x04000000	/* Target Transfer Error */
+  #define SH4_PCICLR_CMDL	  0x0000000F	/* PCI Command at Error */
+#define SH4_PCIAINT		0x130		/* Arbiter Interrupt Register */
+  #define SH4_PCIAINT_MBKN	  0x00002000	/* Master Broken Interrupt */
+  #define SH4_PCIAINT_TBTO	  0x00001000	/* Target Bus Time Out */
+  #define SH4_PCIAINT_MBTO	  0x00000800	/* Master Bus Time Out */
+  #define SH4_PCIAINT_TABT	  0x00000008	/* Target Abort */
+  #define SH4_PCIAINT_MABT	  0x00000004	/* Master Abort */
+  #define SH4_PCIAINT_RDPE	  0x00000002	/* Read Data Parity Error */
+  #define SH4_PCIAINT_WDPE	  0x00000001	/* Write Data Parity Error */
+#define SH4_PCIAINTM            0x134		/* Arbiter Int. Mask Register */
+#define SH4_PCIBMLR		0x138		/* Error Bus Master Register */
+  #define SH4_PCIBMLR_REQ4	  0x00000010	/* REQ4 bus master at error */
+  #define SH4_PCIBMLR_REQ3	  0x00000008	/* REQ3 bus master at error */
+  #define SH4_PCIBMLR_REQ2	  0x00000004	/* REQ2 bus master at error */
+  #define SH4_PCIBMLR_REQ1	  0x00000002	/* REQ1 bus master at error */
+  #define SH4_PCIBMLR_REQ0	  0x00000001	/* REQ0 bus master at error */
+#define SH4_PCIDMABT		0x140		/* DMA Transfer Arb. Register */
+  #define SH4_PCIDMABT_RRBN	  0x00000001	/* DMA Arbitor Round-Robin */
+#define SH4_PCIDPA0		0x180		/* DMA0 Transfer Addr. */
+#define SH4_PCIDLA0		0x184		/* DMA0 Local Addr. */
+#define SH4_PCIDTC0		0x188		/* DMA0 Transfer Cnt. */
+#define SH4_PCIDCR0		0x18C		/* DMA0 Control Register */
+  #define SH4_PCIDCR_ALGN	  0x00000600	/* DMA Alignment Mode */
+  #define SH4_PCIDCR_MAST	  0x00000100	/* DMA Termination Type */
+  #define SH4_PCIDCR_INTM	  0x00000080	/* DMA Interrupt Done Mask*/
+  #define SH4_PCIDCR_INTS	  0x00000040	/* DMA Interrupt Done Status */
+  #define SH4_PCIDCR_LHLD	  0x00000020	/* Local Address Control */
+  #define SH4_PCIDCR_PHLD	  0x00000010	/* PCI Address Control*/
+  #define SH4_PCIDCR_IOSEL	  0x00000008	/* PCI Address Space Type */
+  #define SH4_PCIDCR_DIR	  0x00000004	/* DMA Transfer Direction */
+  #define SH4_PCIDCR_STOP	  0x00000002	/* Force DMA Stop */
+  #define SH4_PCIDCR_STRT	  0x00000001	/* DMA Start */
+#define SH4_PCIDPA1		0x190		/* DMA1 Transfer Addr. */
+#define SH4_PCIDLA1		0x194		/* DMA1 Local Addr. */
+#define SH4_PCIDTC1		0x198		/* DMA1 Transfer Cnt. */
+#define SH4_PCIDCR1		0x19C		/* DMA1 Control Register */
+#define SH4_PCIDPA2		0x1A0		/* DMA2 Transfer Addr. */
+#define SH4_PCIDLA2		0x1A4		/* DMA2 Local Addr. */
+#define SH4_PCIDTC2		0x1A8		/* DMA2 Transfer Cnt. */
+#define SH4_PCIDCR2		0x1AC		/* DMA2 Control Register */
+#define SH4_PCIDPA3		0x1B0		/* DMA3 Transfer Addr. */
+#define SH4_PCIDLA3		0x1B4		/* DMA3 Local Addr. */
+#define SH4_PCIDTC3		0x1B8		/* DMA3 Transfer Cnt. */
+#define SH4_PCIDCR3		0x1BC		/* DMA3 Control Register */
+#define SH4_PCIPAR		0x1C0		/* PIO Address Register */
+  #define SH4_PCIPAR_CFGEN	  0x80000000	/* Configuration Enable */
+  #define SH4_PCIPAR_BUSNO	  0x00FF0000	/* Config. Bus Number */
+  #define SH4_PCIPAR_DEVNO	  0x0000FF00	/* Config. Device Number */
+  #define SH4_PCIPAR_REGAD	  0x000000FC	/* Register Address Number */
+#define SH4_PCIMBR		0x1C4		/* Memory Base Address */
+  #define SH4_PCIMBR_MASK	  0xFF000000	/* Memory Space Mask */
+  #define SH4_PCIMBR_LOCK	  0x00000001	/* Lock Memory Space */
+#define SH4_PCIIOBR		0x1C8		/* I/O Base Address Register */
+  #define SH4_PCIIOBR_MASK	  0xFFFC0000	/* IO Space Mask */
+  #define SH4_PCIIOBR_LOCK	  0x00000001	/* Lock IO Space */
+#define SH4_PCIPINT		0x1CC		/* Power Mgmnt Int. Register */
+  #define SH4_PCIPINT_D3	  0x00000002	/* D3 Pwr Mgmt. Interrupt */
+  #define SH4_PCIPINT_D0	  0x00000001	/* D0 Pwr Mgmt. Interrupt */
+#define SH4_PCIPINTM		0x1D0		/* Power Mgmnt Mask Register */
+#define SH4_PCICLKR		0x1D4		/* Clock Ctrl. Register */
+  #define SH4_PCICLKR_PCSTP	  0x00000002	/* PCI Clock Stop */
+  #define SH4_PCICLKR_BCSTP	  0x00000001	/* BCLK Clock Stop */
+/* For definitions of BCR, MCR see ... */
+#define SH4_PCIBCR1		0x1E0		/* Memory BCR1 Register */
+  #define SH4_PCIMBR0		SH4_PCIBCR1
+#define SH4_PCIBCR2		0x1E4		/* Memory BCR2 Register */
+  #define SH4_PCIMBMR0		SH4_PCIBCR2
+#define SH4_PCIWCR1		0x1E8		/* Wait Control 1 Register */
+#define SH4_PCIWCR2		0x1EC		/* Wait Control 2 Register */
+#define SH4_PCIWCR3		0x1F0		/* Wait Control 3 Register */
+  #define SH4_PCIMBR2		SH4_PCIWCR3
+#define SH4_PCIMCR		0x1F4		/* Memory Control Register */
+#define SH4_PCIBCR3		0x1f8		/* Memory BCR3 Register */
+#define SH4_PCIPCTR             0x200		/* Port Control Register */
+  #define SH4_PCIPCTR_P2EN	  0x000400000	/* Port 2 Enable */
+  #define SH4_PCIPCTR_P1EN	  0x000200000	/* Port 1 Enable */
+  #define SH4_PCIPCTR_P0EN	  0x000100000	/* Port 0 Enable */
+  #define SH4_PCIPCTR_P2UP	  0x000000020	/* Port2 Pull Up Enable */
+  #define SH4_PCIPCTR_P2IO	  0x000000010	/* Port2 Output Enable */
+  #define SH4_PCIPCTR_P1UP	  0x000000008	/* Port1 Pull Up Enable */
+  #define SH4_PCIPCTR_P1IO	  0x000000004	/* Port1 Output Enable */
+  #define SH4_PCIPCTR_P0UP	  0x000000002	/* Port0 Pull Up Enable */
+  #define SH4_PCIPCTR_P0IO	  0x000000001	/* Port0 Output Enable */
+#define SH4_PCIPDTR		0x204		/* Port Data Register */
+  #define SH4_PCIPDTR_PB5	  0x000000020	/* Port 5 Enable */
+  #define SH4_PCIPDTR_PB4	  0x000000010	/* Port 4 Enable */
+  #define SH4_PCIPDTR_PB3	  0x000000008	/* Port 3 Enable */
+  #define SH4_PCIPDTR_PB2	  0x000000004	/* Port 2 Enable */
+  #define SH4_PCIPDTR_PB1	  0x000000002	/* Port 1 Enable */
+  #define SH4_PCIPDTR_PB0	  0x000000001	/* Port 0 Enable */
+#define SH4_PCIPDR		0x220		/* Port IO Data Register */
+
+/* Platform Specific Values */
+#define SH7751_VENDOR_ID             0x1054
+#define SH7751_DEVICE_ID             0x3505
+#define SH7751R_DEVICE_ID            0x350e
+
+/* SH7751 Specific Values */
+#define SH7751_PCI_CONFIG_BASE	     0xFD000000  /* Config space base addr */
+#define SH7751_PCI_CONFIG_SIZE       0x1000000   /* Config space size */
+#define SH7751_PCI_MEMORY_BASE	     0xFD000000  /* Memory space base addr */
+#define SH7751_PCI_MEM_SIZE          0x01000000  /* Size of Memory window */
+#define SH7751_PCI_IO_BASE           0xFE240000  /* IO space base address */
+#define SH7751_PCI_IO_SIZE           0x40000     /* Size of IO window */
+
+#define SH7751_PCIREG_BASE           0xFE200000  /* PCI regs base address */
+
+#define SH7751_PCICONF0            0x0           /* PCI Config Reg 0 */
+  #define SH7751_PCICONF0_DEVID      0xFFFF0000  /* Device ID */
+  #define SH7751_PCICONF0_VNDID      0x0000FFFF  /* Vendor ID */
+#define SH7751_PCICONF1            0x4           /* PCI Config Reg 1 */
+  #define SH7751_PCICONF1_DPE        0x80000000  /* Data Parity Error */
+  #define SH7751_PCICONF1_SSE        0x40000000  /* System Error Status */
+  #define SH7751_PCICONF1_RMA        0x20000000  /* Master Abort */
+  #define SH7751_PCICONF1_RTA        0x10000000  /* Target Abort Rx Status */
+  #define SH7751_PCICONF1_STA        0x08000000  /* Target Abort Exec Status */
+  #define SH7751_PCICONF1_DEV        0x06000000  /* Timing Status */
+  #define SH7751_PCICONF1_DPD        0x01000000  /* Data Parity Status */
+  #define SH7751_PCICONF1_FBBC       0x00800000  /* Back 2 Back Status */
+  #define SH7751_PCICONF1_UDF        0x00400000  /* User Defined Status */
+  #define SH7751_PCICONF1_66M        0x00200000  /* 66Mhz Operation Status */
+  #define SH7751_PCICONF1_PM         0x00100000  /* Power Management Status */
+  #define SH7751_PCICONF1_PBBE       0x00000200  /* Back 2 Back Control */
+  #define SH7751_PCICONF1_SER        0x00000100  /* SERR Output Control */
+  #define SH7751_PCICONF1_WCC        0x00000080  /* Wait Cycle Control */
+  #define SH7751_PCICONF1_PER        0x00000040  /* Parity Error Response */
+  #define SH7751_PCICONF1_VPS        0x00000020  /* VGA Pallet Snoop */
+  #define SH7751_PCICONF1_MWIE       0x00000010  /* Memory Write+Invalidate */
+  #define SH7751_PCICONF1_SPC        0x00000008  /* Special Cycle Control */
+  #define SH7751_PCICONF1_BUM        0x00000004  /* Bus Master Control */
+  #define SH7751_PCICONF1_MES        0x00000002  /* Memory Space Control */
+  #define SH7751_PCICONF1_IOS        0x00000001  /* I/O Space Control */
+#define SH7751_PCICONF2            0x8           /* PCI Config Reg 2 */
+  #define SH7751_PCICONF2_BCC        0xFF000000  /* Base Class Code */
+  #define SH7751_PCICONF2_SCC        0x00FF0000  /* Sub-Class Code */
+  #define SH7751_PCICONF2_RLPI       0x0000FF00  /* Programming Interface */
+  #define SH7751_PCICONF2_REV        0x000000FF  /* Revision ID */
+#define SH7751_PCICONF3            0xC           /* PCI Config Reg 3 */
+  #define SH7751_PCICONF3_BIST7      0x80000000  /* Bist Supported */
+  #define SH7751_PCICONF3_BIST6      0x40000000  /* Bist Executing */
+  #define SH7751_PCICONF3_BIST3_0    0x0F000000  /* Bist Passed */
+  #define SH7751_PCICONF3_HD7        0x00800000  /* Single Function device */
+  #define SH7751_PCICONF3_HD6_0      0x007F0000  /* Configuration Layout */
+  #define SH7751_PCICONF3_LAT        0x0000FF00  /* Latency Timer */
+  #define SH7751_PCICONF3_CLS        0x000000FF  /* Cache Line Size */
+#define SH7751_PCICONF4            0x10          /* PCI Config Reg 4 */
+  #define SH7751_PCICONF4_BASE       0xFFFFFFFC  /* I/O Space Base Addr */
+  #define SH7751_PCICONF4_ASI        0x00000001  /* Address Space Type */
+#define SH7751_PCICONF5            0x14          /* PCI Config Reg 5 */
+  #define SH7751_PCICONF5_BASE       0xFFFFFFF0  /* Mem Space Base Addr */
+  #define SH7751_PCICONF5_LAP        0x00000008  /* Prefetch Enabled */
+  #define SH7751_PCICONF5_LAT        0x00000006  /* Local Memory type */
+  #define SH7751_PCICONF5_ASI        0x00000001  /* Address Space Type */
+#define SH7751_PCICONF6            0x18          /* PCI Config Reg 6 */
+  #define SH7751_PCICONF6_BASE       0xFFFFFFF0  /* Mem Space Base Addr */
+  #define SH7751_PCICONF6_LAP        0x00000008  /* Prefetch Enabled */
+  #define SH7751_PCICONF6_LAT        0x00000006  /* Local Memory type */
+  #define SH7751_PCICONF6_ASI        0x00000001  /* Address Space Type */
+/* PCICONF7 - PCICONF10 are undefined */
+#define SH7751_PCICONF11           0x2C          /* PCI Config Reg 11 */
+  #define SH7751_PCICONF11_SSID      0xFFFF0000  /* Subsystem ID */
+  #define SH7751_PCICONF11_SVID      0x0000FFFF  /* Subsystem Vendor ID */
+/* PCICONF12 is undefined */
+#define SH7751_PCICONF13           0x34          /* PCI Config Reg 13 */
+  #define SH7751_PCICONF13_CPTR      0x000000FF  /* PM function pointer */
+/* PCICONF14 is undefined */
+#define SH7751_PCICONF15           0x3C          /* PCI Config Reg 15 */
+  #define SH7751_PCICONF15_IPIN      0x000000FF  /* Interrupt Pin */
+#define SH7751_PCICONF16           0x40          /* PCI Config Reg 16 */
+  #define SH7751_PCICONF16_PMES      0xF8000000  /* PME Support */
+  #define SH7751_PCICONF16_D2S       0x04000000  /* D2 Support */
+  #define SH7751_PCICONF16_D1S       0x02000000  /* D1 Support */
+  #define SH7751_PCICONF16_DSI       0x00200000  /* Bit Device Init. */
+  #define SH7751_PCICONF16_PMCK      0x00080000  /* Clock for PME req. */
+  #define SH7751_PCICONF16_VER       0x00070000  /* PM Version */
+  #define SH7751_PCICONF16_NIP       0x0000FF00  /* Next Item Pointer */
+  #define SH7751_PCICONF16_CID       0x000000FF  /* Capability Identifier */
+#define SH7751_PCICONF17           0x44          /* PCI Config Reg 17 */
+  #define SH7751_PCICONF17_DATA      0xFF000000  /* Data field for PM */
+  #define SH7751_PCICONF17_PMES      0x00800000  /* PME Status */
+  #define SH7751_PCICONF17_DSCL      0x00600000  /* Data Scaling Value */
+  #define SH7751_PCICONF17_DSEL      0x001E0000  /* Data Select */
+  #define SH7751_PCICONF17_PMEN      0x00010000  /* PME Enable */
+  #define SH7751_PCICONF17_PWST      0x00000003  /* Power State */
+/* SH7751 Internal PCI Registers */
+
+/* Memory Control Registers */
+#define SH7751_BCR1                0x0000    /* Memory BCR1 Register */
+#define SH7751_BCR2                0x0004    /* Memory BCR2 Register */
+#define SH7751_BCR3                0x0050    /* Memory BCR3 Register */
+#define SH7751_WCR1                0x0008    /* Wait Control 1 Register */
+#define SH7751_WCR2                0x000C    /* Wait Control 2 Register */
+#define SH7751_WCR3                0x0010    /* Wait Control 3 Register */
+#define SH7751_MCR                 0x0014    /* Memory Control Register */
+
+/* General Memory Config Addresses */
+#define SH7751_CS0_BASE_ADDR       0x0
+#define SH7751_MEM_REGION_SIZE     0x04000000
+#define SH7751_CS1_BASE_ADDR       (SH7751_CS0_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS2_BASE_ADDR       (SH7751_CS1_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS3_BASE_ADDR       (SH7751_CS2_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS4_BASE_ADDR       (SH7751_CS3_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS5_BASE_ADDR       (SH7751_CS4_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS6_BASE_ADDR       (SH7751_CS5_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+
+#endif /* _PCI_SH7751_H_ */
-- 
2.39.2

