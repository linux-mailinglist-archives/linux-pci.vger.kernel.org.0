Return-Path: <linux-pci+bounces-27930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2EFABB9C6
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE221B65292
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255F272E70;
	Mon, 19 May 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SFkk6CRB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8041272E64
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646993; cv=none; b=TzCf1/uAsyWbGlBEPRj/WfFzYg+c+vphbqtg/QfMR5rkkum74UsnoPYLzNx2vaKpf2K/Lzw7v1XwgSxtistA/WONVipa9caXzKEvPCVXBHdxw3gOqutmvHNNNgwO6cfYajkoRpGrHXt59eKkzY2f2y5tU2KVKq7DmyDEdIE57CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646993; c=relaxed/simple;
	bh=/AdAR2zmfTxgJjuDSRgj9DfQJQZviQObHKCQL1nS6B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kunjaqO0mU+C+qNNE0TmzZ5x4VYFVEK97uO4Rgc2OL6ZmNHeVAmZ1SwZC8DGRpCL4kD0bUtgN5pwZpzJXCj7Hdfs9Alk7e3ZGJHpV4n4wJT1TnaTtSqNpWUv7AgNeTqJCeZ+pntWK/qsr68RXv845JHNFsLPXT99h4YiPc0x+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SFkk6CRB; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250519092950epoutp034d4bdfbcfc21ce132d4cecaaa28aa47b~A462XXeJZ2901129011epoutp039
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 09:29:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250519092950epoutp034d4bdfbcfc21ce132d4cecaaa28aa47b~A462XXeJZ2901129011epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747646990;
	bh=IJpZcpD1d5dpWvWjfti1Y5L7PqYI+cpCLRPKeNXMOWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFkk6CRBp7p0yVMucy4fphibWMqhDAvbodTQ+hRY9efZHnzZ0ve/han+HudxaayJy
	 WbiIo6ZiGcqq2hWD8gYTLmh4NI2UOfLF6ptAMQtsUwPvmqxlML4A4X4P4T9Z/Z9Ei9
	 1/KoWLmXhWwWPBH7H7sHRz+X6Yzrg2Of+1px5kJw=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250519092949epcas5p18bac5ac8e7f810361dce5a8f3353c3c3~A461pcyDX1901519015epcas5p1G;
	Mon, 19 May 2025 09:29:49 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.176]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b1C7w29tNz3hhT8; Mon, 19 May
	2025 09:29:48 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250518193244epcas5p3cacfbdc3b0e5c32f7a4dd97062a931a4~Atf967Alz0813608136epcas5p3B;
	Sun, 18 May 2025 19:32:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250518193244epsmtrp2c4b02c7e6addaa1a33067c36d4e15b0b~Atf91HOJX0348003480epsmtrp2d;
	Sun, 18 May 2025 19:32:44 +0000 (GMT)
X-AuditID: b6c32a28-460ee70000001e8a-e7-682a35dcde5e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.5A.07818.CD53A286; Mon, 19 May 2025 04:32:44 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250518193241epsmtip151108dc988d8d842e0cc851cf61400db~Atf68npNX1247812478epsmtip1F;
	Sun, 18 May 2025 19:32:40 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
	vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de,
	m.szyprowski@samsung.com, jh80.chung@samsung.com, Shradha Todi
	<shradha.t@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH 05/10] PCI: exynos: Add structure to hold resource
 operations
Date: Mon, 19 May 2025 01:01:47 +0530
Message-ID: <20250518193152.63476-6-shradha.t@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518193152.63476-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02ReUiTYRjAe7/b0ehrWb1aaA2UtdJaF28WS6HiC7qMoJLE5vzYJF1jUzvW
	scyOTTNJw1xhJnatzJzTPIpqLktISyob04U1OyQ00tJqXW4S9N8Pfr/nef54GFx0iQhlUjUZ
	vE6jSBNTAqKuWRwW1b1Iqp43YiVRT2kdhX6daqFRRbYaXb/TjqHzznYSuX4cJdGVLyU0enDk
	D476LK8oZMzzkcjm7STRs8ZzFGorfUihAuswgdpGyjCU8zOHQJVOD408OSYSldd+odGf2/U0
	OtG8HzV0P8Jjp3C+H6cA12Dx0FyZLZOzWU0U1915m+J6nxdjXE3FQS7fbgWc82sxwQ3ZwjYI
	EgTLUvi01CxeN1e+XaAuv+OjtS7Z7su2LtIIPkjMIIiB7EI48L2YMgMBI2KbAGwsqiLHRAgc
	6riBjfEkePX3e3osGgTQ9eZjIKJYKTz01Yz7OZh9BGC+e4k/wlkLDkuG8wi/mMSuhbWfWwJM
	sBGww9M8OsAwQjYG5lbE+BGy4fDkcegvgtilsK7qdOCuaLS40NsA/CxkJ8LWkt7AFnw0P1x7
	Fi8ArOU/ZflPlQHMCkJ4rT5dla6UaWUafle0XpGuz9SoopU7020g8EqppB4MDGfPdQCMAQ4A
	GVwcLLTWSNQiYYpiz15etzNJl5nG6x1gGkOIpwqvyraoRKxKkcHv4Hktr/tnMSYo1IjJ4kjP
	eWL27HuvBd5x7hcGKn89wM4lHNBlnKDXea9FxB2TS2ZJNkzo+iSfti/lbt/q5LiSwrYR9fTO
	oW+GkM17kxIPmRJDNj3pf5uqPPMudCSae7zcVSCvthc5l2ZXd7xMjFmstGti4sMMrTPBTxO5
	cfCkd8KH7wvcubmOCGuEys3q7Wvqtimj4lsju+zTMaOZekoNSkB/7T3K+hG/2fvpVtac/KjN
	A+Wx40u1fRcrM1c0u8462yfv8qx0rHrp1Rw8XdmpayrEzL68hQmRLRdDL8yP3Wog+pMf3K/J
	SGs3VDWYyMLB/eLSaipLPss9oym8R2oIDzaJPD0+t7FITOjVCpkU1+kVfwFuNVp5OQMAAA==
X-CMS-MailID: 20250518193244epcas5p3cacfbdc3b0e5c32f7a4dd97062a931a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193244epcas5p3cacfbdc3b0e5c32f7a4dd97062a931a4
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193244epcas5p3cacfbdc3b0e5c32f7a4dd97062a931a4@epcas5p3.samsung.com>

Some resources might differ based on platforms and we need platform
specific functions to initialize or alter them. For better code
re-usability, making a separate res_ops which will hold all such
function pointers or other resource specific data. Also move common
operations for host init into the probe sequence.

Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 105 ++++++++++++++++++------
 1 file changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 540612e76f4b..b122a2ae8681 100644
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
@@ -74,6 +81,36 @@ static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
 	return readl(base + reg);
 }
 
+static int samsung_regulator_enable(struct exynos_pcie *ep)
+{
+	struct device *dev = ep->pci.dev;
+	int ret;
+
+	if (ep->supplies_cnt == 0)
+		return 0;
+
+	ret = devm_regulator_bulk_get(dev, ep->supplies_cnt, ep->supplies);
+	if (ret)
+		return ret;
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
@@ -244,7 +281,23 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 	.init = exynos_pcie_host_init,
 };
 
-static int exynos_add_pcie_port(struct exynos_pcie *ep,
+static int exynos_init_regulator(struct exynos_pcie *ep)
+{
+	struct device *dev = ep->pci.dev;
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
+	return 0;
+}
+
+static int samsung_irq_init(struct exynos_pcie *ep,
 				       struct platform_device *pdev)
 {
 	struct dw_pcie *pci = &ep->pci;
@@ -256,22 +309,15 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
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
 
@@ -282,6 +328,11 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
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
@@ -313,28 +364,31 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
@@ -347,7 +401,7 @@ static void exynos_pcie_remove(struct platform_device *pdev)
 	exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	samsung_regulator_disable(ep);
 }
 
 static int exynos_pcie_suspend_noirq(struct device *dev)
@@ -357,7 +411,7 @@ static int exynos_pcie_suspend_noirq(struct device *dev)
 	exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
-	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	samsung_regulator_disable(ep);
 
 	return 0;
 }
@@ -369,7 +423,7 @@ static int exynos_pcie_resume_noirq(struct device *dev)
 	struct dw_pcie_rp *pp = &pci->pp;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
+	ret = samsung_regulator_enable(ep);
 	if (ret)
 		return ret;
 
@@ -389,6 +443,7 @@ static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
 	.dwc_ops		= &exynos_dw_pcie_ops,
 	.pci_ops		= &exynos_pci_ops,
 	.host_ops		= &exynos_pcie_host_ops,
+	.res_ops		= &exynos_res_ops_data,
 };
 
 static const struct of_device_id exynos_pcie_of_match[] = {
-- 
2.49.0


