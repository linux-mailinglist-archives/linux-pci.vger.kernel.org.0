Return-Path: <linux-pci+bounces-27934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DCCABB9D6
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5228E1B66E27
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E81FF610;
	Mon, 19 May 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lBsJoyn8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158D274FCD
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647014; cv=none; b=Cxcn2/btUNbftd5wK97BiPC6VaY82natoUUCCDle25NVUyPfXr4VODPcP9baUG6rak9/kQHgR6V4vsGJJSUJkXBW4wLQdHUVAcuvfcysQ8I3sDmai0/rH96JndcuzkHp04WeMqZ9267k+Seedh5ixtIXztZDjUvzS7i/zRC76UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647014; c=relaxed/simple;
	bh=fByouTismpV6LoWSPRah4Un6a1qHkZ36BKHM45wfpMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=K0W2Yg7nse9A3YeTJrKBp9s1jvcgX/+nG1prS40BZkg8pTJXBQHRUd/hhqomTOIrI3A3ncHFGdMX28tsefXAacPPEXkhkNf1ffUMNh6FRL1mzNdOVYQxbXrysOZSqKiHm6rppc1i0SQ3e+XkG+s5enuGY9GO027LwPpixGL1diQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lBsJoyn8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250519093010epoutp03f29d7132b79d64daf4249ddda71d6460~A47JFXNfK2916329163epoutp03_
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:30:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250519093010epoutp03f29d7132b79d64daf4249ddda71d6460~A47JFXNfK2916329163epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747647010;
	bh=7IiVDKeuT6ksxMCu0KcGg4lZAvWupjIAe2fDKqXfIqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBsJoyn84vC1WWLidbGzombtrLDGYiAQ9ePtySe+o/LVpsDT1+wv9gad3FfALgIxM
	 uyClLmVvJ3hKkirAKG35T9fCggEkQPjFbTG/SgVEvbj4FIcz4qVjCe0mD8ae65Dgh+
	 2wgr6rW/vYeOQI1LZ2bXUPHzZWBwu679xZWjGy5Y=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250519093009epcas5p4a11a3b2bf57a994aa57192c95cb235da~A47IckQK50267802678epcas5p4W;
	Mon, 19 May 2025 09:30:09 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.180]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b1C8J2FDvz6B9mC; Mon, 19 May
	2025 09:30:08 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046~AtgM2q0TF2916729167epcas5p1E;
	Sun, 18 May 2025 19:33:00 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250518193300epsmtrp12c671528e52872ad9869e0ea34bbcc3c~AtgM1qoa-2903229032epsmtrp1B;
	Sun, 18 May 2025 19:33:00 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-fa-682a35eb53ae
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C1.6A.07818.BE53A286; Mon, 19 May 2025 04:33:00 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193257epsmtip16ee2ea24b3efe12f48092e9e99ba7067~AtgJ8nW1U1176111761epsmtip1L;
	Sun, 18 May 2025 19:32:57 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH 09/10] PCI: exynos: Add support for Tesla FSD SoC
Date: Mon, 19 May 2025 01:01:51 +0530
Message-ID: <20250518193152.63476-10-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518193152.63476-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnO4bU60Mg/k7mC0ezNvGZvF30jF2
	iyVNGRZr9p5jsph/5ByrxY1fbawWK77MZLc42vqf2eLlrHtsFg09v1ktNj2+xmpxedccNouz
	846zWUxY9Y3F4uz3BUwWLX9aWCzWHrnLbnG3pZPV4v+eHewWvYdrLXbeOcHsIOrx+9ckRo+d
	s+6yeyzYVOqxaVUnm8eda3vYPJ5cmc7ksXlJvUffllWMHke+Tmfx+LxJLoArissmJTUnsyy1
	SN8ugSvj3sNDTAVfEir2nPrF1MB4yr+LkYNDQsBEYk2zTRcjJ4eQwG5GiUc/OEBsCQFJic8X
	1zFB2MISK/89Z+9i5AKq+cQosX/ySjaQBJuAlkTj1y5mEFtE4ASjRN8tS5AiZoH3TBIzF/wC
	6xYWcJS4tmAOC4jNIqAqsfVVHzPIYl4Ba4n+ByUQN8hL9HdIgFRwAkW3rZ/KBHGPlcTCJzsZ
	QWxeAUGJkzOfgE1hBipv3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5yYbFhjmpZbrFSfmFpfm
	pesl5+duYgTHoZbGDsZ335r0DzEycTAeYpTgYFYS4V21WSNDiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOO9Kw4h0IYH0xJLU7NTUgtQimCwTB6dUA5McQ7nN0zv+CvNbbFtvmGXtZ7tw0UdfY9bT
	Q8cZgrnrLT+eOvMiKrbyWOUU6TJX5i0xG/Tnepq+eeEpL/278PWrrXtWpDXn+n9eOL3/nTdD
	vHzkn5M2vz8dWc82L/bH5re7FV4eS35h/93FYlpcF0/53McbD/THqfWWdj1LFas0LKrlTkvj
	dfgRcav99O1kkzmTG7LfXH4leb3r0/qaJnF3+d6FLN8OxDntteXaK76WsfzmXMeQHAHeD2/K
	WWIu1b56wigsXsas/Nna74G0YBN/wc3NB+/Ou76z7OGNA0eurtFTe6T0eJHXt49/vr3RfRMw
	U4JFPPX5pj1fVj30ktG+lN+ttFj44dJlsx3upsxWYinOSDTUYi4qTgQAF91GEDIDAAA=
X-CMS-MailID: 20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046@epcas5p1.samsung.com>

Add host and endpoint controller driver support for FSD SoC.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 330 +++++++++++++++++++++++-
 1 file changed, 322 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index b122a2ae8681..97953cc73aa2 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -20,6 +20,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include "pcie-designware.h"
 
@@ -49,17 +51,46 @@
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
+#define FSD_PCIE_CXPL_DEBUG_00_31		0x2C8
+
+/* to store different SoC variants of Samsung */
+enum samsung_pcie_variants {
+	FSD,
+	EXYNOS_5433,
+};
+
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
+	unsigned int				soc_variant;
+	enum dw_pcie_device_mode		device_mode;
 };
 
 struct exynos_pcie {
 	struct dw_pcie			pci;
 	void __iomem			*elbi_base;
 	const struct samsung_pcie_pdata	*pdata;
+	struct regmap			*sysreg;
+	unsigned int			sysreg_offset;
 	struct clk_bulk_data		*clks;
 	struct phy			*phy;
 	struct regulator_bulk_data	*supplies;
@@ -69,6 +100,7 @@ struct exynos_pcie {
 struct samsung_res_ops {
 	int (*init_regulator)(struct exynos_pcie *ep);
 	irqreturn_t (*pcie_irq_handler)(int irq, void *arg);
+	void (*set_device_mode)(struct exynos_pcie *ep);
 };
 
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
@@ -328,11 +360,202 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
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
+
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
+
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
+static int fsd_pcie_link_up(struct dw_pcie *pci)
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
+	case PCI_IRQ_MSIX:
+		dev_err(pci->dev, "EP does not support legacy IRQs\n");
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
@@ -355,6 +578,26 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
@@ -375,13 +618,43 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, ep);
-	ret = samsung_irq_init(ep, pdev);
-	if (ret)
-		goto fail_regulator;
-	ep->pci.pp.ops = pdata->host_ops;
-	ret = dw_pcie_host_init(&ep->pci.pp);
-	if (ret < 0)
+
+	if (pdata->res_ops->set_device_mode)
+		pdata->res_ops->set_device_mode(ep);
+
+	switch (ep->pdata->device_mode) {
+	case DW_PCIE_RC_TYPE:
+		ret = samsung_irq_init(ep, pdev);
+		if (ret)
+			goto fail_regulator;
+
+		ep->pci.pp.ops = pdata->host_ops;
+
+		ret = dw_pcie_host_init(&ep->pci.pp);
+		if (ret < 0)
+			goto fail_phy_init;
+
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
+		break;
+	default:
+		dev_err(dev, "invalid device type\n");
 		goto fail_phy_init;
+	}
 
 	return 0;
 
@@ -397,8 +670,11 @@ static void exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
+	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
+		return;
 	dw_pcie_host_deinit(&ep->pci.pp);
-	exynos_pcie_assert_core_reset(ep);
+	if (ep->pdata->soc_variant == EXYNOS_5433)
+		exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
 	samsung_regulator_disable(ep);
@@ -407,8 +683,16 @@ static void exynos_pcie_remove(struct platform_device *pdev)
 static int exynos_pcie_suspend_noirq(struct device *dev)
 {
 	struct exynos_pcie *ep = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ep->pci;
 
-	exynos_pcie_assert_core_reset(ep);
+	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
+		return 0;
+
+	if (ep->pdata->dwc_ops->stop_link)
+		ep->pdata->dwc_ops->stop_link(pci);
+
+	if (ep->pdata->soc_variant == EXYNOS_5433)
+		exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
 	samsung_regulator_disable(ep);
@@ -423,6 +707,9 @@ static int exynos_pcie_resume_noirq(struct device *dev)
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
 
+	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	ret = samsung_regulator_enable(ep);
 	if (ret)
 		return ret;
@@ -439,11 +726,30 @@ static const struct dev_pm_ops exynos_pcie_pm_ops = {
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
 	.host_ops		= &exynos_pcie_host_ops,
 	.res_ops		= &exynos_res_ops_data,
+	.soc_variant		= EXYNOS_5433,
+	.device_mode		= DW_PCIE_RC_TYPE,
 };
 
 static const struct of_device_id exynos_pcie_of_match[] = {
@@ -451,6 +757,14 @@ static const struct of_device_id exynos_pcie_of_match[] = {
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


