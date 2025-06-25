Return-Path: <linux-pci+bounces-30675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B137AE9430
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 04:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A0116EAA4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095A221555;
	Thu, 26 Jun 2025 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A9lB/oBD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABC21D00E
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905455; cv=none; b=FDbu5cieK4Q594DnWzvNPBi3pTYm4nmnwq5UbvPwsj6Z2IEpGKt3ZWpdhdimfRqw+9ZT7kAryUBtvPSW3Mosc3hsiPiDZHRZWmdmXlDxAnZ275xnX/zCQ7DMXd8S0aRXlLSwLKaa/t9G6wBehVB8ghp5P+9FZzusVMW/lbDWGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905455; c=relaxed/simple;
	bh=WSPPML++0eSSbjEMvDjG3YKUv1CCcpHHMn+xrzrL/Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uz2L1zzlABMPTpFIO2iEMbsown+c26zlh2GTapUfSDZkqL/KjEUH1CFEsRyCm7CS6/lGPVbbYURGwR3lPeGN5UQTNTuGPkI/bgN9cjyChPDnInTRzobL4daYIAJfhtKbttRYPTgN3pYq2XJoppf115UzgVxcWMxTHZ+O5SaLOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A9lB/oBD; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250626023732epoutp02516b433d6c76fadfad5ce5196247ab6a~MdztiGqzG2445824458epoutp02I
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 02:37:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250626023732epoutp02516b433d6c76fadfad5ce5196247ab6a~MdztiGqzG2445824458epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750905452;
	bh=l9qGtfCAfqVE0WOKa7kAuDvMc4B1ZagJkSejcEl/C5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9lB/oBD6QzzQ0gHMWOcUsIEz70ZdG5AZW4BOL+fqHo6oFfidH6U6zMVOtvOKqzZ4
	 cUVjYiyu/np18lwn7Ej0N7d4EO6KPe7j/Ukk4IoS35VUaLwBS/A1Shfo7xAvuOIzl+
	 EPsA/mFZVkAW50ZxD7Phv17zmEQz15yToZ6a5v7k=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250626023731epcas5p2090032a1aeead99bcf840008f9ccbc08~MdzszrYwu2492224922epcas5p2A;
	Thu, 26 Jun 2025 02:37:31 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.183]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bSNBd2NPVz6B9m5; Thu, 26 Jun
	2025 02:37:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250625165310epcas5p309194787ad2c6ac45da32240a8c86c28~MV1gUhs2x0056800568epcas5p3Q;
	Wed, 25 Jun 2025 16:53:10 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250625165308epsmtip20f234903c48f742692610415b04810e6~MV1dlnG6T1741117411epsmtip2V;
	Wed, 25 Jun 2025 16:53:07 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-fsd@tesla.com
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2 05/10] PCI: exynos: Add structure to hold resource
 operations
Date: Wed, 25 Jun 2025 22:22:24 +0530
Message-ID: <20250625165229.3458-6-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625165229.3458-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625165310epcas5p309194787ad2c6ac45da32240a8c86c28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250625165310epcas5p309194787ad2c6ac45da32240a8c86c28
References: <20250625165229.3458-1-shradha.t@samsung.com>
	<CGME20250625165310epcas5p309194787ad2c6ac45da32240a8c86c28@epcas5p3.samsung.com>

Some resources might differ based on platforms and we need platform
specific functions to initialize or alter them. For better code
re-usability, making a separate res_ops which will hold all such
function pointers or other resource specific data. Also move common
operations for host init into the probe sequence.

Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 103 ++++++++++++++++++------
 1 file changed, 78 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c830b20d54f0..dff23cf648f5 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -53,6 +53,7 @@ struct samsung_pcie_pdata {
 	struct pci_ops				*pci_ops;
 	const struct dw_pcie_ops		*dwc_ops;
 	const struct dw_pcie_host_ops		*host_ops;
+	const struct samsung_res_ops		*res_ops;
 };
 
 struct exynos_pcie {
@@ -61,7 +62,13 @@ struct exynos_pcie {
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
 };
 
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
@@ -74,6 +81,31 @@ static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
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
@@ -244,7 +276,26 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
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
@@ -256,22 +307,15 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
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
 
@@ -282,6 +326,11 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
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
@@ -313,28 +362,31 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
-
-	ret = exynos_add_pcie_port(ep, pdev);
+	ret = samsung_irq_init(ep, pdev);
+	if (ret)
+		goto fail_regulator;
+	ep->pci.pp.ops = pdata->host_ops;
+	ret = dw_pcie_host_init(&ep->pci.pp);
 	if (ret < 0)
-		goto fail_probe;
+		goto fail_phy_init;
 
 	return 0;
 
-fail_probe:
+fail_phy_init:
 	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+fail_regulator:
+	samsung_regulator_disable(ep);
 
 	return ret;
 }
@@ -347,7 +399,7 @@ static void exynos_pcie_remove(struct platform_device *pdev)
 	exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	samsung_regulator_disable(ep);
 }
 
 static int exynos_pcie_suspend_noirq(struct device *dev)
@@ -357,7 +409,7 @@ static int exynos_pcie_suspend_noirq(struct device *dev)
 	exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	samsung_regulator_disable(ep);
 
 	return 0;
 }
@@ -369,7 +421,7 @@ static int exynos_pcie_resume_noirq(struct device *dev)
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	ret = samsung_regulator_enable(ep);
 	if (ret)
 		return ret;
 
@@ -389,6 +441,7 @@ static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
 	.dwc_ops		= &exynos_dw_pcie_ops,
 	.pci_ops		= &exynos_pci_ops,
 	.host_ops		= &exynos_pcie_host_ops,
+	.res_ops		= &exynos_res_ops_data,
 };
 
 static const struct of_device_id exynos_pcie_of_match[] = {
-- 
2.49.0


