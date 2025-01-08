Return-Path: <linux-pci+bounces-19555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2BA062EA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D03188AE9D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95CE202C40;
	Wed,  8 Jan 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJXPZDur"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB120126A;
	Wed,  8 Jan 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355758; cv=none; b=juUB6ztuQscbommAm2aPL/nf5NfbBuTrSYqYQS+4Gouh4dSzhOjp9pHCAj4dl7pvvVi0BeSJCCSiQWBsnHCxB0ZOY/aVBrHJ6Lmj9/g7tY9mlunBHqou0D70FLB4Mukv2WZbJXqOTblS00YTMjxm5bDCyjYkikMza0wH+ys3+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355758; c=relaxed/simple;
	bh=gQRDn48XZZZi2YC9BU7pzwSnigTc4cWCcHbkvMC66iU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfSz918gMcrRvtyOwjhd7+Y4JBckFT+fFC1YvcPdxw9x4Zrf6KbHuuxbIn6R9BmijcFvzLLjFK+70o7mJSeBgMOaqtw3Z9+JJ67jY0LoeYyjqV9vjT3BpPnpm1K9Wx9SWlxE1ZK7iPy1h2n++pMtl02AwlBeKhOvztkiaOCoUgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJXPZDur; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736355757; x=1767891757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQRDn48XZZZi2YC9BU7pzwSnigTc4cWCcHbkvMC66iU=;
  b=QJXPZDurJZt3Oh0RODswfUBE8MfPst1pgxwnB6p1ncwXWAhp4DoU1E+B
   yelBr3yEVm7YWu0pJQytxH4KCiGiTqj3oqbX1nfFuoa4u4Zj4HGUsY3mx
   3umcA1FBBQ0vBKNnOcnriKb+TLa2wCALWLEmuawMtruGQZSMDefetkGiA
   hqL8lpF8F/HXyZlIwobES4YuXjLcCV+JjQAR6Qc178jKBxGZf75ow1cjE
   wOp+o2MYgVPYTLmHgPcA1QMxIbwRda88U8bMMkeNTjL+2GGrMWyhdUVrt
   lCR62t3/k7+sf/d9s8fDHmYNRIbwhPOparlqc54LZHCGChXojbDsm/YCS
   w==;
X-CSE-ConnectionGUID: WTx2N/qCQG2pJwchBbzC7w==
X-CSE-MsgGUID: f03nyMq6RJeqWqk5i73XRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35882112"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="35882112"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:34 -0800
X-CSE-ConnectionGUID: aDSnmSDwRpCSO9lh3+00Cg==
X-CSE-MsgGUID: olYIdhRqR8uE8Z8pgRJ1CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108255865"
Received: from test2-linux-lab.an.altera.com ([10.244.156.200])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 09:02:33 -0800
From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: matthew.gerlach@altera.com,
	"D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>,
	D@web.codeaurora.org, M@web.codeaurora.org,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 5/5] PCI: altera: Add Agilex support
Date: Wed,  8 Jan 2025 10:59:09 -0600
Message-Id: <20250108165909.3344354-6-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
References: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>

Add PCIe root port controller support Agilex family of chips.

Signed-off-by: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
 - Remove accepted patches from patch set.

v2:
 - Match historical style of subject.
 - Remove unrelated changes.
 - Fix indentation.
---
 drivers/pci/controller/pcie-altera.c | 246 ++++++++++++++++++++++++++-
 1 file changed, 237 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index eb55a7f8573a..da4ae21d661d 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -77,9 +77,19 @@
 #define S10_TLP_FMTTYPE_CFGWR0		0x45
 #define S10_TLP_FMTTYPE_CFGWR1		0x44
 
+#define AGLX_RP_CFG_ADDR(pcie, reg)	(((pcie)->hip_base) + (reg))
+#define AGLX_RP_SECONDARY(pcie)		\
+	readb(AGLX_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
+
+#define AGLX_BDF_REG			0x00002004
+#define AGLX_ROOT_PORT_IRQ_STATUS	0x14c
+#define AGLX_ROOT_PORT_IRQ_ENABLE	0x150
+#define CFG_AER				BIT(4)
+
 enum altera_pcie_version {
 	ALTERA_PCIE_V1 = 0,
 	ALTERA_PCIE_V2,
+	ALTERA_PCIE_V3,
 };
 
 struct altera_pcie {
@@ -102,6 +112,11 @@ struct altera_pcie_ops {
 			   int size, u32 *value);
 	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 busno,
 			    int where, int size, u32 value);
+	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
+			   unsigned int devfn, int where, int size, u32 *value);
+	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
+			    unsigned int devfn, int where, int size, u32 value);
+	void (*rp_isr)(struct irq_desc *desc);
 };
 
 struct altera_pcie_data {
@@ -112,6 +127,9 @@ struct altera_pcie_data {
 	u32 cfgrd1;
 	u32 cfgwr0;
 	u32 cfgwr1;
+	u32 port_conf_offset;
+	u32 port_irq_status_offset;
+	u32 port_irq_enable_offset;
 };
 
 struct tlp_rp_regpair_t {
@@ -131,6 +149,28 @@ static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
 	return readl_relaxed(pcie->cra_base + reg);
 }
 
+static inline void cra_writew(struct altera_pcie *pcie, const u32 value,
+			      const u32 reg)
+{
+	writew_relaxed(value, pcie->cra_base + reg);
+}
+
+static inline u32 cra_readw(struct altera_pcie *pcie, const u32 reg)
+{
+	return readw_relaxed(pcie->cra_base + reg);
+}
+
+static inline void cra_writeb(struct altera_pcie *pcie, const u32 value,
+			      const u32 reg)
+{
+	writeb_relaxed(value, pcie->cra_base + reg);
+}
+
+static inline u32 cra_readb(struct altera_pcie *pcie, const u32 reg)
+{
+	return readb_relaxed(pcie->cra_base + reg);
+}
+
 static bool altera_pcie_link_up(struct altera_pcie *pcie)
 {
 	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
@@ -145,6 +185,15 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
 	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static bool aglx_altera_pcie_link_up(struct altera_pcie *pcie)
+{
+	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie,
+				   pcie->pcie_data->cap_offset +
+				   PCI_EXP_LNKSTA);
+
+	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
+}
+
 /*
  * Altera PCIe port uses BAR0 of RC's configuration space as the translation
  * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
@@ -425,6 +474,103 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int aglx_rp_read_cfg(struct altera_pcie *pcie, int where,
+			    int size, u32 *value)
+{
+	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
+
+	switch (size) {
+	case 1:
+		*value = readb(addr);
+		break;
+	case 2:
+		*value = readw(addr);
+		break;
+	default:
+		*value = readl(addr);
+		break;
+	}
+
+	/* interrupt pin not programmed in hardware, set to INTA */
+	if (where == PCI_INTERRUPT_PIN && size == 1 && !(*value))
+		*value = 0x01;
+	else if (where == PCI_INTERRUPT_LINE && !(*value & 0xff00))
+		*value |= 0x0100;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
+			     int where, int size, u32 value)
+{
+	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
+
+	switch (size) {
+	case 1:
+		writeb(value, addr);
+		break;
+	case 2:
+		writew(value, addr);
+		break;
+	default:
+		writel(value, addr);
+		break;
+	}
+
+	/*
+	 * Monitor changes to PCI_PRIMARY_BUS register on root port
+	 * and update local copy of root bus number accordingly.
+	 */
+	if (busno == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
+		pcie->root_bus_nr = value & 0xff;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_ep_write_cfg(struct altera_pcie *pcie, u8 busno,
+			     unsigned int devfn, int where, int size, u32 value)
+{
+	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
+	if (busno > AGLX_RP_SECONDARY(pcie))
+		where |= (1 << 12); /* type 1 */
+
+	switch (size) {
+	case 1:
+		cra_writeb(pcie, value, where);
+		break;
+	case 2:
+		cra_writew(pcie, value, where);
+		break;
+	default:
+		cra_writel(pcie, value, where);
+			break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int aglx_ep_read_cfg(struct altera_pcie *pcie, u8 busno,
+			    unsigned int devfn, int where, int size, u32 *value)
+{
+	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
+	if (busno > AGLX_RP_SECONDARY(pcie))
+		where |= (1 << 12); /* type 1 */
+
+	switch (size) {
+	case 1:
+		*value = cra_readb(pcie, where);
+		break;
+	case 2:
+		*value = cra_readw(pcie, where);
+		break;
+	default:
+		*value = cra_readl(pcie, where);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 				 unsigned int devfn, int where, int size,
 				 u32 *value)
@@ -437,6 +583,10 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 		return pcie->pcie_data->ops->rp_read_cfg(pcie, where,
 							 size, value);
 
+	if (pcie->pcie_data->ops->ep_read_cfg)
+		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno, devfn,
+							where, size, value);
+
 	switch (size) {
 	case 1:
 		byte_en = 1 << (where & 3);
@@ -481,6 +631,10 @@ static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
 		return pcie->pcie_data->ops->rp_write_cfg(pcie, busno,
 						     where, size, value);
 
+	if (pcie->pcie_data->ops->ep_write_cfg)
+		return pcie->pcie_data->ops->ep_write_cfg(pcie, busno, devfn,
+						     where, size, value);
+
 	switch (size) {
 	case 1:
 		data32 = (value & 0xff) << shift;
@@ -659,7 +813,30 @@ static void altera_pcie_isr(struct irq_desc *desc)
 				dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n", bit);
 		}
 	}
+	chained_irq_exit(chip, desc);
+}
+
+static void aglx_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct altera_pcie *pcie;
+	struct device *dev;
+	u32 status;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+	pcie = irq_desc_get_handler_data(desc);
+	dev = &pcie->pdev->dev;
 
+	status = readl(pcie->hip_base + pcie->pcie_data->port_conf_offset +
+		       pcie->pcie_data->port_irq_status_offset);
+	if (status & CFG_AER) {
+		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
+		if (ret)
+			dev_err_ratelimited(dev, "unexpected IRQ\n");
+	}
+	writel(CFG_AER, (pcie->hip_base + pcie->pcie_data->port_conf_offset +
+			 pcie->pcie_data->port_irq_status_offset));
 	chained_irq_exit(chip, desc);
 }
 
@@ -694,9 +871,9 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (IS_ERR(pcie->cra_base))
 		return PTR_ERR(pcie->cra_base);
 
-	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
-		pcie->hip_base =
-			devm_platform_ioremap_resource_byname(pdev, "Hip");
+	if (pcie->pcie_data->version == ALTERA_PCIE_V2 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		pcie->hip_base = devm_platform_ioremap_resource_byname(pdev, "Hip");
 		if (IS_ERR(pcie->hip_base))
 			return PTR_ERR(pcie->hip_base);
 	}
@@ -706,7 +883,7 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
+	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -719,6 +896,7 @@ static const struct altera_pcie_ops altera_pcie_ops_1_0 = {
 	.tlp_read_pkt = tlp_read_packet,
 	.tlp_write_pkt = tlp_write_packet,
 	.get_link_status = altera_pcie_link_up,
+	.rp_isr = altera_pcie_isr,
 };
 
 static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
@@ -727,6 +905,16 @@ static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
 	.get_link_status = s10_altera_pcie_link_up,
 	.rp_read_cfg = s10_rp_read_cfg,
 	.rp_write_cfg = s10_rp_write_cfg,
+	.rp_isr = altera_pcie_isr,
+};
+
+static const struct altera_pcie_ops altera_pcie_ops_3_0 = {
+	.rp_read_cfg = aglx_rp_read_cfg,
+	.rp_write_cfg = aglx_rp_write_cfg,
+	.get_link_status = aglx_altera_pcie_link_up,
+	.ep_read_cfg = aglx_ep_read_cfg,
+	.ep_write_cfg = aglx_ep_write_cfg,
+	.rp_isr = aglx_isr,
 };
 
 static const struct altera_pcie_data altera_pcie_1_0_data = {
@@ -749,11 +937,44 @@ static const struct altera_pcie_data altera_pcie_2_0_data = {
 	.cfgwr1 = S10_TLP_FMTTYPE_CFGWR1,
 };
 
+static const struct altera_pcie_data altera_pcie_3_0_f_tile_data = {
+	.ops = &altera_pcie_ops_3_0,
+	.version = ALTERA_PCIE_V3,
+	.cap_offset = 0x70,
+	.port_conf_offset = 0x14000,
+	.port_irq_status_offset = AGLX_ROOT_PORT_IRQ_STATUS,
+	.port_irq_enable_offset = AGLX_ROOT_PORT_IRQ_ENABLE,
+};
+
+static const struct altera_pcie_data altera_pcie_3_0_p_tile_data = {
+	.ops = &altera_pcie_ops_3_0,
+	.version = ALTERA_PCIE_V3,
+	.cap_offset = 0x70,
+	.port_conf_offset = 0x104000,
+	.port_irq_status_offset = AGLX_ROOT_PORT_IRQ_STATUS,
+	.port_irq_enable_offset = AGLX_ROOT_PORT_IRQ_ENABLE,
+};
+
+static const struct altera_pcie_data altera_pcie_3_0_r_tile_data = {
+	.ops = &altera_pcie_ops_3_0,
+	.version = ALTERA_PCIE_V3,
+	.cap_offset = 0x70,
+	.port_conf_offset = 0x1300,
+	.port_irq_status_offset = 0x0,
+	.port_irq_enable_offset = 0x4,
+};
+
 static const struct of_device_id altera_pcie_of_match[] = {
 	{.compatible = "altr,pcie-root-port-1.0",
 	 .data = &altera_pcie_1_0_data },
 	{.compatible = "altr,pcie-root-port-2.0",
 	 .data = &altera_pcie_2_0_data },
+	{.compatible = "altr,pcie-root-port-3.0-f-tile",
+	 .data = &altera_pcie_3_0_f_tile_data },
+	{.compatible = "altr,pcie-root-port-3.0-p-tile",
+	 .data = &altera_pcie_3_0_p_tile_data },
+	{.compatible = "altr,pcie-root-port-3.0-r-tile",
+	 .data = &altera_pcie_3_0_r_tile_data },
 	{},
 };
 
@@ -791,11 +1012,18 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* clear all interrupts */
-	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
-	/* enable all interrupts */
-	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
-	altera_pcie_host_init(pcie);
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
+	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
+		/* clear all interrupts */
+		cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
+		/* enable all interrupts */
+		cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
+		altera_pcie_host_init(pcie);
+	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
+		writel(CFG_AER,
+		       pcie->hip_base + pcie->pcie_data->port_conf_offset +
+		       pcie->pcie_data->port_irq_enable_offset);
+	}
 
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_bus_nr;
-- 
2.34.1


