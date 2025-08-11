Return-Path: <linux-pci+bounces-33826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD42B21C86
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 07:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BF11A27130
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 05:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20B2E5407;
	Tue, 12 Aug 2025 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uSDIDNB4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F92E4260
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974940; cv=none; b=EgNI0dYpMC9uCupw2wDwmnJlCo418EC4d02q7KkG1ezBJAvAAOAm3fGRkWqKXI6EmVoxWphpuzVqLpdUNikfKvu/jO2SyKHMGGVqyxZrLX42ZTQ+EemqCReyZhSQXOKsftmFH8pMdcqCIkgDa0O2EAsA2ZLcm9nSsxF7IHPxm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974940; c=relaxed/simple;
	bh=cUcGjhxxv/8aio0Vmd2xsfcect1TVAHENTE/7DA7vrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=f9FDNzUdH0bxwFPfzSpWl8WVeH4u76zvRPMM1mJqbYQGLHqKi6ZLhrzUuLKwBHaZK8M7yA5L+1VmHt0yJTcknYkgJXbgQ1vA0JWkX9psWWqhLrfljYr0OY1zIqVi6yoKJxShUvvKd5ZaV0p6uapuDTUJxy2YZYmnwX/UeM0WSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uSDIDNB4; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250812050217epoutp024cb931d0965fabce3ec286b4a3500ea1~a7Gg7MzZn1092810928epoutp02n
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2025 05:02:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250812050217epoutp024cb931d0965fabce3ec286b4a3500ea1~a7Gg7MzZn1092810928epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754974937;
	bh=RpVsd6AyneahgdXaOC7X3UcZjG5J5t2hbUCwrp15vCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSDIDNB4s8lEtTuy9LwP2Q1Vk3Rtt1blCEVRKUoRJa+35EqoLrCOmsSbrpVa02cxb
	 7vTPmVGnu2qKFk1ffETqSgLB4zR2xc5U/gzFCwuR+TWJembbjqYoROC5iy8Xee1+eR
	 0EUUlxAlL87PU79KFyeMbKj6FOtKPBcCUKSD2fVk=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250812050216epcas5p21652a6c4ec5401eee3d1115a3d56147a~a7GgKSybv2502425024epcas5p2w;
	Tue, 12 Aug 2025 05:02:16 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c1K9z19SBz3hhTD; Tue, 12 Aug
	2025 05:02:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250811154716epcas5p44980091d5273073b9bf2031572c38376~awQXzzDDb1821518215epcas5p45;
	Mon, 11 Aug 2025 15:47:16 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250811154713epsmtip1541fb87e24feb81701b892c5299371e0~awQVL4KJ72560925609epsmtip1M;
	Mon, 11 Aug 2025 15:47:13 +0000 (GMT)
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
Subject: [PATCH v3 05/12] PCI: exynos: Add resource ops, soc variant and
 device mode
Date: Mon, 11 Aug 2025 21:16:31 +0530
Message-ID: <20250811154638.95732-6-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811154638.95732-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250811154716epcas5p44980091d5273073b9bf2031572c38376
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154716epcas5p44980091d5273073b9bf2031572c38376
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154716epcas5p44980091d5273073b9bf2031572c38376@epcas5p4.samsung.com>

Some resources might differ based on platforms and we need platform
specific functions to initialize or alter them. For better code
re-usability, making a separate res_ops which will hold all such
function pointers or other resource specific data. Include ops like
 - init_regulator (initialize the regulator data)
 - pcie_irq_handler (interrupt handler for PCIe)
 - set_device_mode (set device mode to EP or RC)

Some operations maybe specific to certain SoCs and not applicable
to others. For such use cases, adding an SoC variant data field
which can be used to distinguish between the variants.

Some SoCs may have dual-role PCIe controller which can work as
RC or EP. Add device_mode to store the role and take decisions
accordingly.

Make enable/disable of regulator and initialization of IRQ as
common functions to be used by all Samsung SoCs.

Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 143 +++++++++++++++++++-----
 1 file changed, 116 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c830b20d54f0..ef1f42236575 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -49,10 +49,18 @@
 #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
 #define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
 
+/* to store different SoC variants of Samsung */
+enum samsung_pcie_variants {
+	EXYNOS_5433,
+};
+
 struct samsung_pcie_pdata {
 	struct pci_ops				*pci_ops;
 	const struct dw_pcie_ops		*dwc_ops;
 	const struct dw_pcie_host_ops		*host_ops;
+	const struct samsung_res_ops		*res_ops;
+	unsigned int				soc_variant;
+	enum dw_pcie_device_mode		device_mode;
 };
 
 struct exynos_pcie {
@@ -61,7 +69,14 @@ struct exynos_pcie {
 	const struct samsung_pcie_pdata	*pdata;
 	struct clk_bulk_data		*clks;
 	struct phy			*phy;
-	struct regulator_bulk_data	supplies[2];
+	struct regulator_bulk_data	*supplies;
+	int				supplies_cnt;
+};
+
+struct samsung_res_ops {
+	int (*init_regulator)(struct exynos_pcie *ep);
+	irqreturn_t (*pcie_irq_handler)(int irq, void *arg);
+	void (*set_device_mode)(struct exynos_pcie *ep);
 };
 
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
@@ -74,6 +89,31 @@ static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
 	return readl(base + reg);
 }
 
+static int samsung_regulator_enable(struct exynos_pcie *ep)
+{
+	int ret;
+
+	if (ep->supplies_cnt == 0)
+		return 0;
+
+	ret = regulator_bulk_enable(ep->supplies_cnt, ep->supplies);
+
+	return ret;
+}
+
+static void samsung_regulator_disable(struct exynos_pcie *ep)
+{
+	struct device *dev = ep->pci.dev;
+	int ret;
+
+	if (ep->supplies_cnt == 0)
+		return;
+
+	ret = regulator_bulk_disable(ep->supplies_cnt, ep->supplies);
+	if (ret)
+		dev_warn(dev, "failed to disable regulators: %d\n", ret);
+}
+
 static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
 {
 	u32 val;
@@ -244,7 +284,26 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 	.init = exynos_pcie_host_init,
 };
 
-static int exynos_add_pcie_port(struct exynos_pcie *ep,
+static int exynos_init_regulator(struct exynos_pcie *ep)
+{
+	struct device *dev = ep->pci.dev;
+	int ret = 0;
+
+	ep->supplies_cnt = 2;
+
+	ep->supplies = devm_kcalloc(dev, ep->supplies_cnt, sizeof(*ep->supplies), GFP_KERNEL);
+	if (!ep->supplies)
+		return -ENOMEM;
+
+	ep->supplies[0].supply = "vdd18";
+	ep->supplies[1].supply = "vdd10";
+
+	ret = devm_regulator_bulk_get(dev, ep->supplies_cnt, ep->supplies);
+
+	return ret;
+}
+
+static int samsung_irq_init(struct exynos_pcie *ep,
 				       struct platform_device *pdev)
 {
 	struct dw_pcie *pci = &ep->pci;
@@ -256,22 +315,15 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
 	if (pp->irq < 0)
 		return pp->irq;
 
-	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
+	ret = devm_request_irq(dev, pp->irq, ep->pdata->res_ops->pcie_irq_handler,
 			       IRQF_SHARED, "exynos-pcie", ep);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		return ret;
 	}
 
-	pp->ops = &exynos_pcie_host_ops;
 	pp->msi_irq[0] = -ENODEV;
 
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(dev, "failed to initialize host\n");
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -282,6 +334,11 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
 	.start_link = exynos_pcie_start_link,
 };
 
+static const struct samsung_res_ops exynos_res_ops_data = {
+	.init_regulator		= exynos_init_regulator,
+	.pcie_irq_handler	= exynos_pcie_irq_handler,
+};
+
 static int exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -313,28 +370,46 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ep->supplies[0].supply = "vdd18";
-	ep->supplies[1].supply = "vdd10";
-	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ep->supplies),
-				      ep->supplies);
-	if (ret)
-		return ret;
+	if (pdata->res_ops && pdata->res_ops->init_regulator) {
+		ret = ep->pdata->res_ops->init_regulator(ep);
+		if (ret)
+			return ret;
+	}
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	ret = samsung_regulator_enable(ep);
 	if (ret)
 		return ret;
 
 	platform_set_drvdata(pdev, ep);
 
-	ret = exynos_add_pcie_port(ep, pdev);
-	if (ret < 0)
-		goto fail_probe;
+	if (pdata->res_ops && pdata->res_ops->set_device_mode)
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
+	default:
+		dev_err(dev, "invalid device type\n");
+		ret = -EINVAL;
+		goto fail_regulator;
+	}
 
 	return 0;
 
-fail_probe:
+fail_phy_init:
 	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+fail_regulator:
+	samsung_regulator_disable(ep);
 
 	return ret;
 }
@@ -343,21 +418,29 @@ static void exynos_pcie_remove(struct platform_device *pdev)
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
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	samsung_regulator_disable(ep);
 }
 
 static int exynos_pcie_suspend_noirq(struct device *dev)
 {
 	struct exynos_pcie *ep = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &ep->pci;
 
-	exynos_pcie_assert_core_reset(ep);
+	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
+		return 0;
+
+	if (ep->pdata->soc_variant == EXYNOS_5433)
+		exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	samsung_regulator_disable(ep);
 
 	return 0;
 }
@@ -369,7 +452,10 @@ static int exynos_pcie_resume_noirq(struct device *dev)
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
+		return 0;
+
+	ret = samsung_regulator_enable(ep);
 	if (ret)
 		return ret;
 
@@ -389,6 +475,9 @@ static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
 	.dwc_ops		= &exynos_dw_pcie_ops,
 	.pci_ops		= &exynos_pci_ops,
 	.host_ops		= &exynos_pcie_host_ops,
+	.res_ops		= &exynos_res_ops_data,
+	.soc_variant		= EXYNOS_5433,
+	.device_mode		= DW_PCIE_RC_TYPE,
 };
 
 static const struct of_device_id exynos_pcie_of_match[] = {
-- 
2.49.0


