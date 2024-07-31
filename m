Return-Path: <linux-pci+bounces-11061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA0D94324B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7B91F26B1F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764151BD515;
	Wed, 31 Jul 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/kE8apB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB71BD005;
	Wed, 31 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436898; cv=none; b=BIxlCTvLZ31UDCu+d7rVmRfN5j5WCVrPRaID1Z+2ToZHWwgpEGjKk1zN6xqszRUABF+y9YmewJkEn1gvVeDrW61BdB7ylg0+SoS9pSVh5mZq2WQocIToW40x9u7aoqnN7V6gf+cGUmPsnOwKwsjsf48EUpgWgMwT8nT6S0d+5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436898; c=relaxed/simple;
	bh=FD0sZ/EyT2hPX4MJniyXIh25UK2j5Trd/6szApou4lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbpwoqCbr7u4nACgA0nP6mVC7OYCcRgU9N9U+4K0SXnsELO2QT0+zQLPavMoHpMYkQX52rkJ4US6qPgcoVckvBhkI4JDgZ6n52Cc5DwwtaKsEz5/0xxRjhCJH49fdK3en62ytDO1idkH4MD6Dg3bNnEt8t2hs3/xQePFai3AGqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/kE8apB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436896; x=1753972896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FD0sZ/EyT2hPX4MJniyXIh25UK2j5Trd/6szApou4lA=;
  b=C/kE8apB0xx26WSBIJpSmRZxMomSy8rkATlVh7u0EXycz4agfUn8pIfp
   WE5fz8kJGT4SzK4NJVQw4wmiKOklThOWjxbVvlknK9KoWPPEU3gz1NsCx
   4KivZ3p5LqJT3X0Qdy1++YxAX6WG8J7SFAIv4G2ZEbAvFisutSleQh0q0
   zL4ExbnuZm7XkkAmKGDWP46UsRIXSJ/9CsJ4NCz9dLYgT+uSs0Geg11ix
   0B3zRPfS7V6TMiAJOnPGdBKYNQt3ZBj5E+B2Wm3Jqrgc550Awa771hvKP
   PFLRMSTSUP/JGiOp97tkQsGQjh7+2h7piHVzXuctNPaZU5AEQ0v3tRhSL
   g==;
X-CSE-ConnectionGUID: RrQ4DX7nSUO0M7Q6HgNsvA==
X-CSE-MsgGUID: BsfEnHmnTzapY2pGaoISSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20479842"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20479842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:41:29 -0700
X-CSE-ConnectionGUID: r9Jc5AG4QOyHUf3lUBr46A==
X-CSE-MsgGUID: 9DortEr4QRWp13+UZvwW1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="55295560"
Received: from test2-linux-lab.an.intel.com ([10.122.105.166])
  by orviesa007.jf.intel.com with ESMTP; 31 Jul 2024 07:41:28 -0700
From: matthew.gerlach@linux.intel.com
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	joyce.ooi@intel.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>,
	D@web.codeaurora.org, M@web.codeaurora.org,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 7/7] pci: controller: pcie-altera: Add support for Agilex
Date: Wed, 31 Jul 2024 09:39:46 -0500
Message-Id: <20240731143946.3478057-8-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
References: <20240731143946.3478057-1-matthew.gerlach@linux.intel.com>
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
 drivers/pci/controller/pcie-altera.c | 260 +++++++++++++++++++++++++--
 1 file changed, 244 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index ef73baefaeb9..0426a367e842 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -60,7 +60,7 @@
 		(((cfg) << 24) |	\
 		  TLP_PAYLOAD_SIZE)
 #define TLP_CFG_DW1(pcie, tag, be)	\
-	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
+	(((TLP_REQ_ID((pcie)->root_bus_nr,  RP_DEVFN)) << 16) | ((tag) << 8) | (be))
 #define TLP_CFG_DW2(bus, devfn, offset)	\
 				(((bus) << 24) | ((devfn) << 16) | (offset))
 #define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
@@ -78,9 +78,20 @@
 #define S10_TLP_FMTTYPE_CFGWR0		0x45
 #define S10_TLP_FMTTYPE_CFGWR1		0x44
 
+#define AGLX_RP_CFG_ADDR(pcie, reg)	\
+	(((pcie)->hip_base) + (reg))
+#define AGLX_RP_SECONDARY(pcie)		\
+	readb(AGLX_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
+
+#define AGLX_BDF_REG 0x00002004
+#define AGLX_ROOT_PORT_IRQ_STATUS 0x14c
+#define AGLX_ROOT_PORT_IRQ_ENABLE 0x150
+#define CFG_AER                   BIT(4)
+
 enum altera_pcie_version {
 	ALTERA_PCIE_V1 = 0,
 	ALTERA_PCIE_V2,
+	ALTERA_PCIE_V3,
 };
 
 struct altera_pcie {
@@ -103,6 +114,11 @@ struct altera_pcie_ops {
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
@@ -113,6 +129,9 @@ struct altera_pcie_data {
 	u32 cfgrd1;
 	u32 cfgwr0;
 	u32 cfgwr1;
+	u32 port_conf_offset;
+	u32 port_irq_status_offset;
+	u32 port_irq_enable_offset;
 };
 
 struct tlp_rp_regpair_t {
@@ -132,6 +151,28 @@ static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
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
@@ -146,6 +187,15 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
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
@@ -158,8 +208,7 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
 static bool altera_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
 				    int offset)
 {
-	if (pci_is_root_bus(bus) && (devfn == 0) &&
-	    (offset == PCI_BASE_ADDRESS_0))
+	if (pci_is_root_bus(bus) && devfn == 0 && offset == PCI_BASE_ADDRESS_0)
 		return true;
 
 	return false;
@@ -373,7 +422,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	 * Monitor changes to PCI_PRIMARY_BUS register on root port
 	 * and update local copy of root bus number accordingly.
 	 */
-	if ((bus == pcie->root_bus_nr) && (where == PCI_PRIMARY_BUS))
+	if (bus == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
 		pcie->root_bus_nr = (u8)(value);
 
 	return PCIBIOS_SUCCESSFUL;
@@ -426,6 +475,103 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
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
@@ -438,6 +584,10 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
 		return pcie->pcie_data->ops->rp_read_cfg(pcie, where,
 							 size, value);
 
+	if (pcie->pcie_data->ops->ep_read_cfg)
+		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno, devfn,
+							where, size, value);
+
 	switch (size) {
 	case 1:
 		byte_en = 1 << (where & 3);
@@ -482,6 +632,10 @@ static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
 		return pcie->pcie_data->ops->rp_write_cfg(pcie, busno,
 						     where, size, value);
 
+	if (pcie->pcie_data->ops->ep_write_cfg)
+		return pcie->pcie_data->ops->ep_write_cfg(pcie, busno, devfn,
+						     where, size, value);
+
 	switch (size) {
 	case 1:
 		data32 = (value & 0xff) << shift;
@@ -577,7 +731,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
 			dev_err(dev, "link retrain timeout\n");
 			break;
 		}
-		udelay(100);
+		usleep_range(50, 150);
 	}
 
 	/* Wait for link is up */
@@ -590,7 +744,7 @@ static void altera_wait_link_retrain(struct altera_pcie *pcie)
 			dev_err(dev, "link up timeout\n");
 			break;
 		}
-		udelay(100);
+		usleep_range(50, 150);
 	}
 }
 
@@ -660,7 +814,30 @@ static void altera_pcie_isr(struct irq_desc *desc)
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
+			dev_err_ratelimited(dev, "unexpected IRQ,\n");
+	}
+	writel(CFG_AER, (pcie->hip_base + pcie->pcie_data->port_conf_offset +
+			 pcie->pcie_data->port_irq_status_offset));
 	chained_irq_exit(chip, desc);
 }
 
@@ -671,7 +848,7 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 
 	/* Setup INTx */
 	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-					&intx_domain_ops, pcie);
+						 &intx_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
@@ -695,9 +872,9 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
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
@@ -707,7 +884,7 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	if (pcie->irq < 0)
 		return pcie->irq;
 
-	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
+	irq_set_chained_handler_and_data(pcie->irq, pcie->pcie_data->ops->rp_isr, pcie);
 	return 0;
 }
 
@@ -720,6 +897,7 @@ static const struct altera_pcie_ops altera_pcie_ops_1_0 = {
 	.tlp_read_pkt = tlp_read_packet,
 	.tlp_write_pkt = tlp_write_packet,
 	.get_link_status = altera_pcie_link_up,
+	.rp_isr = altera_pcie_isr,
 };
 
 static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
@@ -728,6 +906,16 @@ static const struct altera_pcie_ops altera_pcie_ops_2_0 = {
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
@@ -750,11 +938,44 @@ static const struct altera_pcie_data altera_pcie_2_0_data = {
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
 
@@ -792,11 +1013,18 @@ static int altera_pcie_probe(struct platform_device *pdev)
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


