Return-Path: <linux-pci+bounces-33832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B60B21C9B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 302357B1400
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47BB2E62BB;
	Tue, 12 Aug 2025 05:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pOZ0NPS6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42052E613C
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974960; cv=none; b=DCADANTCW/DcxDPgpowmHiqhYhUjHhMUEv0lA0hMODZ9Co027yluneOQg5KOd0B/qv7DxR5dh/l4IEGjwzg3V2TwFQi0emACR5xVIePsEeqaF8lBDNSbcNO8OHdvvaXSkHLfmEvjq7xdjMYh5GGt443mpt2XrNRCew+7a8Pq2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974960; c=relaxed/simple;
	bh=BcZ/53a0Mr4/tlPAal01W0B8+jcsnyyWtfj6HFXx8wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=QdfIezfGhE8QDfwyAbJOeAyAAs/w6W0xwLpFxxbeKWI6dR5P4JSNfMJNPbYzN8j0gfb/TekNEL5R5bA5w/t0yUsawC4WfXy74HIdf6JOyOOMuT9cM+CH+ZnVcoKkXhE2xWe/OWwCCewWzQb4QiAp+UVX0ETJ2Oa7nMgbDe8cBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pOZ0NPS6; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250812050237epoutp01685eba98acbd0eeded8fa2241036c6e7~a7GzkJzdU1029910299epoutp01P
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250812050237epoutp01685eba98acbd0eeded8fa2241036c6e7~a7GzkJzdU1029910299epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974957;
	bh=4NS8tYI0r1nmofDk8XefvAQBTXQ4W1F7r+dj3X9Hwwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOZ0NPS6jzgcqLh+23XxNpUSyCpTTIRf9FxHW2Aq11ZZ/VqBxsKx51yVkmikKQmMw
	 0pJK0yArYzpVyNcTpQ/NUmF8o1UPNeJLQimhnzrk8CFSP2x9iDbuDIyEQ7oTyYQOB4
	 YGWvax0cQojlafzwp6AHuNlw9/hKu4kxceD+pC30=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250812050236epcas5p1e74516e0580cf8a08e86cbd79ab2dc45~a7Gy5hUEW1538515385epcas5p1K;
	Tue, 12 Aug 2025 05:02:36 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4c1KBM39mLz6B9m6; Tue, 12 Aug
	2025 05:02:35 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250811154742epcas5p3276c7c053bedc526d9ce370dda83e195~awQv9dmns2815828158epcas5p3S;
	Mon, 11 Aug 2025 15:47:42 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154739epsmtip19674dea8703440bc1f7b4a0340d60e0c~awQtVjeu32101521015epsmtip1X;
	Mon, 11 Aug 2025 15:47:39 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Date: Mon, 11 Aug 2025 21:16:37 +0530
Message-ID: <20250811154638.95732-12-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154742epcas5p3276c7c053bedc526d9ce370dda83e195
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154742epcas5p3276c7c053bedc526d9ce370dda83e195
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154742epcas5p3276c7c053bedc526d9ce370dda83e195@epcas5p3.samsung.com>

Add host and endpoint controller driver support for FSD SoC.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 278 ++++++++++++++++++++++++
 1 file changed, 278 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index ef1f42236575..9aabfecdc147 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -18,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 
@@ -49,15 +51,35 @@
 #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
 #define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
 
+#define FSD_IRQ2_STS				0x008
+#define FSD_IRQ_MSI_ENABLE			BIT(17)
+#define FSD_IRQ2_EN				0x018
+#define FSD_PCIE_APP_LTSSM_ENABLE		0x054
+#define FSD_PCIE_LTSSM_ENABLE			0x1
+#define FSD_PCIE_DEVICE_TYPE			0x080
+#define FSD_DEVICE_TYPE_RC			0x4
+#define FSD_DEVICE_TYPE_EP			0x0
+#define FSD_PCIE_CXPL_DEBUG_00_31		0x2c8
+
 /* to store different SoC variants of Samsung */
 enum samsung_pcie_variants {
+	FSD,
 	EXYNOS_5433,
 };
 
+/* Values to be written to SYSREG to view DBI space as CDM/DBI2/IATU/DMA */
+enum fsd_pcie_addr_type {
+	ADDR_TYPE_DBI = 0x0,
+	ADDR_TYPE_DBI2 = 0x12,
+	ADDR_TYPE_ATU = 0x36,
+	ADDR_TYPE_DMA = 0x3f,
+};
+
 struct samsung_pcie_pdata {
 	struct pci_ops				*pci_ops;
 	const struct dw_pcie_ops		*dwc_ops;
 	const struct dw_pcie_host_ops		*host_ops;
+	const struct dw_pcie_ep_ops		*ep_ops;
 	const struct samsung_res_ops		*res_ops;
 	unsigned int				soc_variant;
 	enum dw_pcie_device_mode		device_mode;
@@ -67,6 +89,8 @@ struct exynos_pcie {
 	struct dw_pcie			pci;
 	void __iomem			*elbi_base;
 	const struct samsung_pcie_pdata	*pdata;
+	struct regmap			*sysreg;
+	unsigned int			sysreg_offset;
 	struct clk_bulk_data		*clks;
 	struct phy			*phy;
 	struct regulator_bulk_data	*supplies;
@@ -334,11 +358,201 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
 	.start_link = exynos_pcie_start_link,
 };
 
+static void fsd_pcie_stop_link(struct dw_pcie *pci)
+{
+	u32 val;
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+
+	val = readl(ep->elbi_base + FSD_PCIE_APP_LTSSM_ENABLE);
+	val &= ~FSD_PCIE_LTSSM_ENABLE;
+	writel(val, ep->elbi_base + FSD_PCIE_APP_LTSSM_ENABLE);
+}
+
+static int fsd_pcie_start_link(struct dw_pcie *pci)
+{
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+	struct dw_pcie_ep *dw_ep = &pci->ep;
+
+	if (dw_pcie_link_up(pci))
+		return 0;
+
+	writel(FSD_PCIE_LTSSM_ENABLE, ep->elbi_base + FSD_PCIE_APP_LTSSM_ENABLE);
+
+	/* no need to wait for link in case of host as core files take care */
+	if (ep->pdata->device_mode == DW_PCIE_RC_TYPE)
+		return 0;
+
+	/* check if the link is up or not in case of EP */
+	if (!dw_pcie_wait_for_link(pci)) {
+		dw_pcie_ep_linkup(dw_ep);
+		return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static irqreturn_t fsd_pcie_irq_handler(int irq, void *arg)
+{
+	u32 val;
+	struct exynos_pcie *ep = arg;
+	struct dw_pcie *pci = &ep->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+
+	val = readl(ep->elbi_base + FSD_IRQ2_STS);
+	if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {
+		val &= FSD_IRQ_MSI_ENABLE;
+		writel(val, ep->elbi_base + FSD_IRQ2_STS);
+		dw_handle_msi_irq(pp);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void fsd_pcie_msi_init(struct exynos_pcie *ep)
+{
+	int val;
+
+	val = readl(ep->elbi_base + FSD_IRQ2_EN);
+	val |= FSD_IRQ_MSI_ENABLE;
+	writel(val, ep->elbi_base + FSD_IRQ2_EN);
+}
+
+static void __iomem *fsd_atu_setting(struct dw_pcie *pci, void __iomem *base)
+{
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+
+	if (base >= pci->atu_base) {
+		regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_ATU);
+		return (base - DEFAULT_DBI_ATU_OFFSET);
+	} else if (base == pci->dbi_base) {
+		regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_DBI);
+	} else if (base == pci->dbi_base2) {
+		regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_DBI2);
+	}
+
+	return base;
+}
+
+static u32 fsd_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size)
+{
+	void __iomem *addr;
+	u32 val;
+
+	addr = fsd_atu_setting(pci, base);
+	dw_pcie_read(addr + reg, size, &val);
+
+	return val;
+}
+
+static void fsd_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size, u32 val)
+{
+	void __iomem *addr;
+
+	addr = fsd_atu_setting(pci, base);
+	dw_pcie_write(addr + reg, size, val);
+}
+
+static void fsd_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,
+				u32 reg, size_t size, u32 val)
+{
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+
+	fsd_atu_setting(pci, base);
+	dw_pcie_write(pci->dbi_base + reg, size, val);
+	regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_DBI);
+}
+
+static bool fsd_pcie_link_up(struct dw_pcie *pci)
+{
+	u32 val;
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+
+	val = readl(ep->elbi_base + FSD_PCIE_CXPL_DEBUG_00_31);
+	val &= PORT_LOGIC_LTSSM_STATE_MASK;
+
+	return (val == PORT_LOGIC_LTSSM_STATE_L0);
+}
+
+static int fsd_pcie_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct exynos_pcie *ep = to_exynos_pcie(pci);
+
+	phy_init(ep->phy);
+	fsd_pcie_msi_init(ep);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops fsd_pcie_host_ops = {
+	.init = fsd_pcie_host_init,
+};
+
+static int fsd_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				 unsigned int type, u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_IRQ_INTX:
+		return dw_pcie_ep_raise_intx_irq(ep, func_no);
+	case PCI_IRQ_MSIX:
+		dev_err(pci->dev, "EP does not support MSI-X\n");
+		return -EINVAL;
+	case PCI_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+	}
+
+	return 0;
+}
+
+static const struct pci_epc_features fsd_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features *fsd_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &fsd_pcie_epc_features;
+}
+
+static const struct dw_pcie_ep_ops fsd_ep_ops = {
+	.raise_irq	= fsd_pcie_raise_irq,
+	.get_features	= fsd_pcie_get_features,
+};
+
+static void fsd_set_device_mode(struct exynos_pcie *ep)
+{
+	if (ep->pdata->device_mode == DW_PCIE_RC_TYPE)
+		writel(FSD_DEVICE_TYPE_RC, ep->elbi_base + FSD_PCIE_DEVICE_TYPE);
+	else
+		writel(FSD_DEVICE_TYPE_EP, ep->elbi_base + FSD_PCIE_DEVICE_TYPE);
+}
+
+static const struct dw_pcie_ops fsd_dw_pcie_ops = {
+	.read_dbi	= fsd_pcie_read_dbi,
+	.write_dbi	= fsd_pcie_write_dbi,
+	.write_dbi2	= fsd_pcie_write_dbi2,
+	.start_link	= fsd_pcie_start_link,
+	.stop_link	= fsd_pcie_stop_link,
+	.link_up	= fsd_pcie_link_up,
+};
+
 static const struct samsung_res_ops exynos_res_ops_data = {
 	.init_regulator		= exynos_init_regulator,
 	.pcie_irq_handler	= exynos_pcie_irq_handler,
 };
 
+static const struct samsung_res_ops fsd_res_ops_data = {
+	.pcie_irq_handler	= fsd_pcie_irq_handler,
+	.set_device_mode	= fsd_set_device_mode,
+};
+
 static int exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -361,6 +575,26 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(ep->phy))
 		return PTR_ERR(ep->phy);
 
+	if (ep->pdata->soc_variant == FSD) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+		if (ret)
+			return ret;
+
+		ep->sysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
+				"samsung,syscon-pcie");
+		if (IS_ERR(ep->sysreg)) {
+			dev_err(dev, "sysreg regmap lookup failed.\n");
+			return PTR_ERR(ep->sysreg);
+		}
+
+		ret = of_property_read_u32_index(dev->of_node, "samsung,syscon-pcie", 1,
+						 &ep->sysreg_offset);
+		if (ret) {
+			dev_err(dev, "couldn't get the register offset for syscon!\n");
+			return ret;
+		}
+	}
+
 	/* External Local Bus interface (ELBI) registers */
 	ep->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
 	if (IS_ERR(ep->elbi_base))
@@ -397,6 +631,22 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto fail_phy_init;
 
+		break;
+	case DW_PCIE_EP_TYPE:
+		phy_init(ep->phy);
+
+		ep->pci.ep.ops = pdata->ep_ops;
+
+		ret = dw_pcie_ep_init(&ep->pci.ep);
+		if (ret < 0)
+			goto fail_phy_init;
+
+		ret = dw_pcie_ep_init_registers(&ep->pci.ep);
+		if (ret)
+			goto fail_phy_init;
+
+		pci_epc_init_notify(ep->pci.ep.epc);
+
 		break;
 	default:
 		dev_err(dev, "invalid device type\n");
@@ -436,6 +686,9 @@ static int exynos_pcie_suspend_noirq(struct device *dev)
 	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
 		return 0;
 
+	if (ep->pdata->dwc_ops->stop_link)
+		ep->pdata->dwc_ops->stop_link(pci);
+
 	if (ep->pdata->soc_variant == EXYNOS_5433)
 		exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
@@ -471,6 +724,23 @@ static const struct dev_pm_ops exynos_pcie_pm_ops = {
 				  exynos_pcie_resume_noirq)
 };
 
+
+static const struct samsung_pcie_pdata fsd_hw3_pcie_rc_pdata = {
+	.dwc_ops		= &fsd_dw_pcie_ops,
+	.host_ops		= &fsd_pcie_host_ops,
+	.res_ops		= &fsd_res_ops_data,
+	.soc_variant		= FSD,
+	.device_mode		= DW_PCIE_RC_TYPE,
+};
+
+static const struct samsung_pcie_pdata fsd_hw3_pcie_ep_pdata = {
+	.dwc_ops		= &fsd_dw_pcie_ops,
+	.ep_ops			= &fsd_ep_ops,
+	.res_ops		= &fsd_res_ops_data,
+	.soc_variant		= FSD,
+	.device_mode		= DW_PCIE_EP_TYPE,
+};
+
 static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
 	.dwc_ops		= &exynos_dw_pcie_ops,
 	.pci_ops		= &exynos_pci_ops,
@@ -485,6 +755,14 @@ static const struct of_device_id exynos_pcie_of_match[] = {
 		.compatible = "samsung,exynos5433-pcie",
 		.data = (void *) &exynos_5433_pcie_rc_pdata,
 	},
+	{
+		.compatible = "tesla,fsd-pcie",
+		.data = (void *) &fsd_hw3_pcie_rc_pdata,
+	},
+	{
+		.compatible = "tesla,fsd-pcie-ep",
+		.data = (void *) &fsd_hw3_pcie_ep_pdata,
+	},
 	{ },
 };
 
-- 
2.49.0


