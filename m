Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E192647AEE9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Dec 2021 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhLTPGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 10:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbhLTPEN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 10:04:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA422C09B10C;
        Mon, 20 Dec 2021 06:52:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AC6611AA;
        Mon, 20 Dec 2021 14:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4CDC36AE9;
        Mon, 20 Dec 2021 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640011958;
        bh=gA6Tmf3gYkSo1NYpxJrrOTgo0X4aW2joiL/R1r0N65U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMp4AVpDEkxf9o6YnMyycvVzgLZC+fna7sIhNC5krYeILujfqmm0Hgapu8sbB7B9f
         2U5jtQNNSk4n2lZ9xK12VRqOQmNoljZQAuqys7ivuOak1iBAlu0Dyv/bexgOtRrRij
         x70xh3+6VBkRyQF5URySDc89Jt17wvcu8haiuaUKAuA+6tIBwKSJNfUfcxWR80+mb8
         8Q14CdCs4DjOG8PG4xIL2Ub9r8WO4+DWutwCfK3TJJuWYCsRDJJJEQg+e1fRODjq3n
         FXPI7ZCksjgr64tXBIBbM2tV7/Xwen6Hec1+OetsS2JegQiLtlXYK7TgMw12tlNSql
         8XdDdBUIHutsw==
Received: by pali.im (Postfix)
        id 7BE8687B; Mon, 20 Dec 2021 15:52:35 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Add defines for normal and subtractive PCI bridges
Date:   Mon, 20 Dec 2021 15:51:40 +0100
Message-Id: <20211220145140.31898-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211210145352.16323-1-pali@kernel.org>
References: <20211210145352.16323-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add following two new PCI class codes defines into pci_ids.h include file:

  PCI_CLASS_BRIDGE_PCI_NORMAL
  PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE

And use these defines in all kernel code for describing PCI class codes for
normal and subtractive PCI bridges.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v2:
- rebased on on top of pci/next branch
- dropped pcie-iproc.c change for 0x43c register for now
  (layout of this register is unknown and later I should get more
   information from Broadcom about it)
---
 .../mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  2 --
 arch/mips/pci/fixup-sb1250.c                     |  2 +-
 arch/mips/pci/pci-bcm63xx.c                      |  2 +-
 arch/powerpc/platforms/powernv/pci.c             |  2 +-
 arch/powerpc/sysdev/fsl_pci.c                    |  2 +-
 arch/sh/drivers/pci/pcie-sh7786.c                |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c        |  8 ++++----
 drivers/pci/controller/dwc/pci-meson.c           | 16 ++++++++--------
 drivers/pci/controller/dwc/pcie-qcom.c           |  2 +-
 .../pci/controller/mobiveil/pcie-mobiveil-host.c |  2 +-
 drivers/pci/controller/pci-aardvark.c            |  2 +-
 drivers/pci/controller/pci-loongson.c            |  2 +-
 drivers/pci/controller/pci-tegra.c               |  2 +-
 drivers/pci/controller/pcie-iproc-bcma.c         |  2 +-
 drivers/pci/controller/pcie-iproc.c              |  2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c      |  2 +-
 drivers/pci/controller/pcie-rcar-host.c          |  2 +-
 drivers/pci/controller/pcie-rockchip-host.c      |  2 +-
 drivers/pci/controller/pcie-rockchip.h           |  1 -
 drivers/pci/hotplug/shpchp_core.c                |  2 +-
 drivers/pci/pci-bridge-emul.c                    |  4 ++--
 drivers/pci/pcie/portdrv_pci.c                   |  4 ++--
 include/linux/pci_ids.h                          |  2 ++
 23 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 9ceb5e72889f..d3f397dcab6e 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1380,8 +1380,6 @@
 
 #define PCIE_IDVAL3_REG			0x43c
 #define IDVAL3_CLASS_CODE_MASK		0xffffff
-#define IDVAL3_SUBCLASS_SHIFT		8
-#define IDVAL3_CLASS_SHIFT		16
 
 #define PCIE_DLSTATUS_REG		0x1048
 #define DLSTATUS_PHYLINKUP		(1 << 13)
diff --git a/arch/mips/pci/fixup-sb1250.c b/arch/mips/pci/fixup-sb1250.c
index 40efc990cdce..3f914c33b7de 100644
--- a/arch/mips/pci/fixup-sb1250.c
+++ b/arch/mips/pci/fixup-sb1250.c
@@ -75,7 +75,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_PCI,
  */
 static void quirk_sb1250_ht(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_HT,
 			quirk_sb1250_ht);
diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index 5548365605c0..ac83243772d2 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -186,7 +186,7 @@ static int __init bcm63xx_register_pcie(void)
 	/* setup class code as bridge */
 	val = bcm_pcie_readl(PCIE_IDVAL3_REG);
 	val &= ~IDVAL3_CLASS_CODE_MASK;
-	val |= (PCI_CLASS_BRIDGE_PCI << IDVAL3_SUBCLASS_SHIFT);
+	val |= PCI_CLASS_BRIDGE_PCI_NORMAL;
 	bcm_pcie_writel(val, PCIE_IDVAL3_REG);
 
 	/* disable bar1 size */
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 9a8391b983d1..f7054879ecd4 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -815,7 +815,7 @@ void pnv_pci_shutdown(void)
 /* Fixup wrong class code in p7ioc and p8 root complex */
 static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index b8f76f3fd994..8ef2a7525e2c 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -55,7 +55,7 @@ static void quirk_fsl_pcie_early(struct pci_dev *dev)
 	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
 		return;
 
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 	fsl_pcie_bus_fixup = 1;
 	return;
 }
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 4d499476c33a..b0c2a5238d04 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -314,7 +314,7 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	 * class to match. Hardware takes care of propagating the IDSETR
 	 * settings, so there is no need to bother with a quirk.
 	 */
-	pci_write_reg(chan, PCI_CLASS_BRIDGE_PCI << 16, SH4A_PCIEIDSETR1);
+	pci_write_reg(chan, PCI_CLASS_BRIDGE_PCI_NORMAL << 8, SH4A_PCIEIDSETR1);
 
 	/* Initialize default capabilities. */
 	data = pci_read_reg(chan, SH4A_PCIEEXPCAP0);
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index a055ea84b149..4a5ace74287d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -531,13 +531,13 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	struct pci_dev *bridge;
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2E),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2L),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2G),
-		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ 0, },
 	};
 
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 686ded034f22..f44bf347904a 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -313,14 +313,14 @@ static int meson_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn,
 	 * cannot program the PCI_CLASS_DEVICE register, so we must fabricate
 	 * the return value in the config accessors.
 	 */
-	if (where == PCI_CLASS_REVISION && size == 4)
-		*val = (PCI_CLASS_BRIDGE_PCI << 16) | (*val & 0xffff);
-	else if (where == PCI_CLASS_DEVICE && size == 2)
-		*val = PCI_CLASS_BRIDGE_PCI;
-	else if (where == PCI_CLASS_DEVICE && size == 1)
-		*val = PCI_CLASS_BRIDGE_PCI & 0xff;
-	else if (where == PCI_CLASS_DEVICE + 1 && size == 1)
-		*val = (PCI_CLASS_BRIDGE_PCI >> 8) & 0xff;
+	if ((where & ~3) == PCI_CLASS_REVISION) {
+		if (size <= 2)
+			*val = (*val & ((1 << (size * 8)) - 1)) << (8 * (where & 3));
+		*val &= ~0xffffff00;
+		*val |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
+		if (size <= 2)
+			*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
+	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c19cd506ed3f..a47f1c0434c2 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1634,7 +1634,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 
 static void qcom_fixup_class(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index f3547aa60140..31a7bdebe540 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -295,7 +295,7 @@ int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 	/* fixup for PCIe class register */
 	value = mobiveil_csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
 	value &= 0xff;
-	value |= (PCI_CLASS_BRIDGE_PCI << 16);
+	value |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
 	mobiveil_csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
 
 	return 0;
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index ec0df426863d..7d98b4170a8e 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -530,7 +530,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	 */
 	reg = advk_readl(pcie, PCIE_CORE_DEV_REV_REG);
 	reg &= ~0xffffff00;
-	reg |= (PCI_CLASS_BRIDGE_PCI << 8) << 8;
+	reg |= PCI_CLASS_BRIDGE_PCI_NORMAL << 8;
 	advk_writel(pcie, reg, PCIE_CORE_DEV_REV_REG);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering */
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 48169b1e3817..50a8e1d6f70a 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -35,7 +35,7 @@ struct loongson_pci {
 /* Fixup wrong class code in PCIe bridges */
 static void bridge_class_quirk(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_0, bridge_class_quirk);
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index cb0aa65d6934..0457ec02ab70 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -726,7 +726,7 @@ static void tegra_pcie_port_free(struct tegra_pcie_port *port)
 /* Tegra PCIE root complex wrongly reports device class */
 static void tegra_pcie_fixup_class(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index f918c713afb0..8eb17817e5cd 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -18,7 +18,7 @@
 /* NS: CLASS field is R/O, and set to wrong 0x200 value */
 static void bcma_pcie2_fixup_class(struct pci_dev *dev)
 {
-	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
+	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8011, bcma_pcie2_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x8012, bcma_pcie2_fixup_class);
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index b3e75bc61ff1..3df4ab209253 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1581,7 +1581,7 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
 	 * code that the bridge is not an Ethernet device.
 	 */
 	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
+		pdev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 
 	/*
 	 * MPSS is not being set properly (as it is currently 0).  This is
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 21207df680cc..b9cf90e0359c 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -292,7 +292,7 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	/* Set class code */
 	val = readl_relaxed(port->base + PCIE_PCI_IDS_1);
 	val &= ~GENMASK(31, 8);
-	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
+	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI_NORMAL);
 	writel_relaxed(val, port->base + PCIE_PCI_IDS_1);
 
 	/* Mask all INTx interrupts */
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 38b6e02edfa9..dfca59c4ae34 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -370,7 +370,7 @@ static int rcar_pcie_hw_init(struct rcar_pcie *pcie)
 	 * class to match. Hardware takes care of propagating the IDSETR
 	 * settings, so there is no need to bother with a quirk.
 	 */
-	rcar_pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
+	rcar_pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI_NORMAL << 8, IDSETR1);
 
 	/*
 	 * Setup Secondary Bus Number & Subordinate Bus Number, even though
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 45a28880f322..7f56f99b4116 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -370,7 +370,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, ROCKCHIP_VENDOR_ID,
 			    PCIE_CORE_CONFIG_VENDOR);
 	rockchip_pcie_write(rockchip,
-			    PCI_CLASS_BRIDGE_PCI << PCIE_RC_CONFIG_SCC_SHIFT,
+			    PCI_CLASS_BRIDGE_PCI_NORMAL << 8,
 			    PCIE_RC_CONFIG_RID_CCR);
 
 	/* Clear THP cap's next cap pointer to remove L1 substate cap */
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 1650a5087450..32c3a859c26b 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -134,7 +134,6 @@
 #define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define   PCIE_RC_CONFIG_SCC_SHIFT		16
 #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
 #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
 #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 81a918d47895..53692b048301 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -312,7 +312,7 @@ static void shpc_remove(struct pci_dev *dev)
 }
 
 static const struct pci_device_id shpcd_pci_tbl[] = {
-	{PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0)},
+	{PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_NORMAL, ~0)},
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(pci, shpcd_pci_tbl);
diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index c994ebec2360..cf9d90ec2968 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -329,9 +329,9 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 
 	/*
 	 * class_revision: Class is high 24 bits and revision is low 8 bit of this member,
-	 * while class for PCI Bridge Normal Decode has the 24-bit value: PCI_CLASS_BRIDGE_PCI << 8
+	 * while class for PCI Bridge Normal Decode has the 24-bit value: PCI_CLASS_BRIDGE_PCI_NORMAL
 	 */
-	bridge->conf.class_revision |= cpu_to_le32((PCI_CLASS_BRIDGE_PCI << 8) << 8);
+	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI_NORMAL << 8);
 	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
 	bridge->conf.cache_line_size = 0x10;
 	bridge->conf.status = cpu_to_le16(PCI_STATUS_CAP_LIST);
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 35eca6277a96..4b8801656ffb 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -178,9 +178,9 @@ static pci_ers_result_t pcie_portdrv_mmio_enabled(struct pci_dev *dev)
  */
 static const struct pci_device_id port_pci_ids[] = {
 	/* handle any PCI-Express port */
-	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0) },
+	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_NORMAL, ~0) },
 	/* subtractive decode PCI-to-PCI bridge, class type is 060401h */
-	{ PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x01), ~0) },
+	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE, ~0) },
 	/* handle any Root Complex Event Collector */
 	{ PCI_DEVICE_CLASS(((PCI_CLASS_SYSTEM_RCEC << 8) | 0x00), ~0) },
 	{ },
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0d26ab7eb7dc..ba24ca7cc631 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -60,6 +60,8 @@
 #define PCI_CLASS_BRIDGE_EISA		0x0602
 #define PCI_CLASS_BRIDGE_MC		0x0603
 #define PCI_CLASS_BRIDGE_PCI		0x0604
+#define PCI_CLASS_BRIDGE_PCI_NORMAL		0x060400
+#define PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE	0x060401
 #define PCI_CLASS_BRIDGE_PCMCIA		0x0605
 #define PCI_CLASS_BRIDGE_NUBUS		0x0606
 #define PCI_CLASS_BRIDGE_CARDBUS	0x0607
-- 
2.20.1

