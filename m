Return-Path: <linux-pci+bounces-1989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5451982989C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 12:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21B3B246A6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3F4779E;
	Wed, 10 Jan 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l4uRLInj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C047A45
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240110111729epoutp0206a1c4a0257bcae6d7e20c432c558415~o_Eh_Urpz1768017680epoutp02i
	for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 11:17:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240110111729epoutp0206a1c4a0257bcae6d7e20c432c558415~o_Eh_Urpz1768017680epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704885449;
	bh=M1+QsjggvLUaZn03qUqB6f3xooklVjON6VKY3+lVzh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4uRLInjCgN/P2j6C+SrPdyBo5tEeufB+R+VvMx66aSOyFZNRynDU0/ba1Ns6e40X
	 13ptVW2FgE8586oXgevWybHW2cPa1tk6gNUzECjTB64VpsEkHo2EkvPEaQENh7vaxO
	 5AjnPV1eKRegKt/87ohIGS77tNlCxJht3a/gRGPo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240110111727epcas5p3f546c7ee89bc89d8e29ef87297a0c708~o_Eg1YAYW2559725597epcas5p3v;
	Wed, 10 Jan 2024 11:17:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T94yZ2KzCz4x9Q1; Wed, 10 Jan
	2024 11:17:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.98.10009.6CC7E956; Wed, 10 Jan 2024 20:17:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240110110209epcas5p3130d90db3c4ebd19ff09f2f3c37958f4~o93JTPjUl0210902109epcas5p3l;
	Wed, 10 Jan 2024 11:02:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240110110209epsmtrp18b7fd6b1a016d438edfe0a095a87cd96~o93JSO7lY2403524035epsmtrp1s;
	Wed, 10 Jan 2024 11:02:09 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-cf-659e7cc67be7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6B.90.07368.1397E956; Wed, 10 Jan 2024 20:02:09 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240110110206epsmtip1ce78e7296382e697f5148d5f277c3608~o93GxJZ8w2247222472epsmtip1h;
	Wed, 10 Jan 2024 11:02:06 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3 2/2] PCI: exynos: Adapt to clk_bulk_* APIs
Date: Wed, 10 Jan 2024 16:31:15 +0530
Message-Id: <20240110110115.56270-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240110110115.56270-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmpu6xmnmpBvMv8Vs8mLeNzWJJU4bF
	ii8z2S32vt7KbtHQ85vVYtPja6wWH3vusVpc3jWHzeLsvONsFjPO72OyODR1L6NFy58WFou1
	R+6yW9xt6WS1uHjK1eL/nh3sFv+ubWSx6D1c6yDkcfnaRWaP9zda2T12zrrL7rFgU6nHplWd
	bB53ru1h83hyZTqTx+Yl9R59W1YxenzeJBfAFZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
	ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0kZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
	ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+NQY1jBMcmKffcVGxi7RLsYOTkkBEwkHh1b
	wtLFyMUhJLCbUeLEg6VQzidGiZ3nHzODVAkJfGOU2LhFGaaj9/0DdoiivYwSW/ecYocoamWS
	WHLICcRmE9CSaPzaxQxSJCKwmFHi1o7NrCAOs8AJJomjZ7cxglQJC9hKLOq8CbaCRUBV4tPJ
	h6wgNq+AlcSbu5eYINbJS6zecACshlPAWmL14tlgqyUEtnBI/N5ylB2iyEViy8zJULawxKvj
	W6BsKYmX/W1QdrrEys0zmCHsHIlvm5dALbCXOHBlDtDTHEDXaUqs36UPEZaVmHpqHVgJswCf
	RO/vJ1DlvBI75sHYyhJf/u5hgbAlJeYdu8wKYXtI7Ji1ixUSRH2MEifn7WCawCg3C2HFAkbG
	VYySqQXFuempxaYFRnmp5fBIS87P3cQITrRaXjsYHz74oHeIkYmD8RCjBAezkgivwuc5qUK8
	KYmVValF+fFFpTmpxYcYTYEBOJFZSjQ5H5jq80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhP
	LEnNTk0tSC2C6WPi4JRqYOoIXtK4WCW4Pa66SMfQxjUw94FGoNFZHyWDkmXtgW9C0vSXsggc
	dfmiwmzqN/tRxw/PxItJd4NWdSz8diDOesL2+ak6dqxy4RHPea+ca2LrSBY45Rmi9Yszsczv
	dVVAiZXdgxathzVNKhrfXm9zCBZ+dnhTbFDLXMfH3X499UWCGjP837qsz76vcZDr8C7mrjdn
	vIz+NTE//P2X4/+9A/cmPKy778fEX8NbtXrrqeQkg7871+kG+cxcJbjxdyjDLSnP8LAf//e/
	N/Ltm9dqo82qErNsdQerjPNZtYV7wvu5nT4vuO7TuOlyznSOlXxxhj36Ur76lrpHK1X+Ni51
	UfoZ/lfcYu7ykwuaWG2UWIozEg21mIuKEwHaOnHfPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnK5h5bxUg2VnuC0ezNvGZrGkKcNi
	xZeZ7BZ7X29lt2jo+c1qsenxNVaLjz33WC0u75rDZnF23nE2ixnn9zFZHJq6l9Gi5U8Li8Xa
	I3fZLe62dLJaXDzlavF/zw52i3/XNrJY9B6udRDyuHztIrPH+xut7B47Z91l91iwqdRj06pO
	No871/aweTy5Mp3JY/OSeo++LasYPT5vkgvgiuKySUnNySxLLdK3S+DKONQYVnBMsmLffcUG
	xi7RLkZODgkBE4ne9w/Yuxi5OIQEdjNKPLl0nR0iISnx+eI6JghbWGLlv+dQRc1MEhO7bzKD
	JNgEtCQav3YxgyREBJYzSvw8+ZQJxGEWuMEk0dg4F2yUsICtxKJOiA4WAVWJTycfsoLYvAJW
	Em/uXoJaIS+xesMBsBpOAWuJ1Ytng/UKAdWs2HuYdQIj3wJGhlWMkqkFxbnpucmGBYZ5qeV6
	xYm5xaV56XrJ+bmbGMHRoKWxg/He/H96hxiZOBgPMUpwMCuJ8Cp8npMqxJuSWFmVWpQfX1Sa
	k1p8iFGag0VJnNdwxuwUIYH0xJLU7NTUgtQimCwTB6dUA9OUqhPM95et+m5wYYpsx0atNQJt
	/iv+HWBdf0TjXPe2pzzvJ+Q//Zh+kPe8Ppv36y1lX+Ja7Joizxf4WToW7JmusGZKdcgunc83
	3dPPTd63uOjSFCs/JV+TWztmd/W8D5W9rLwplutlcX6c5wfZFcsevt69RSCZ+aapv+UP2edp
	htrztnYwXE2/Wv+vXny6RIPhyqq5Yqo/U4/WbHhUvnvXFNX1Z+yvT36zqfSnhUUSc/KnM/me
	J5UrQ3ZM8Ou89DN3mejs9K32c5w2zr7f/q/yE/fH+1z7ApbWaaxh+3QvfaK4fMdua31tvdaE
	zw/eBjO+X/T69Tr3tapSOtO4vgZL7D6a2bz9NtPam84MKVHHlViKMxINtZiLihMB0EF5cfUC
	AAA=
X-CMS-MailID: 20240110110209epcas5p3130d90db3c4ebd19ff09f2f3c37958f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240110110209epcas5p3130d90db3c4ebd19ff09f2f3c37958f4
References: <20240110110115.56270-1-shradha.t@samsung.com>
	<CGME20240110110209epcas5p3130d90db3c4ebd19ff09f2f3c37958f4@epcas5p3.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

There is no need to hardcode the clock info in the driver as driver can
rely on the devicetree to supply the clocks required for the functioning
of the peripheral. Get rid of the static clock info and obtain the
platform supplied clocks. The total number of clocks supplied is
obtained and enabled using the devm_clk_bulk_get_all_enabled() API.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 55 +++----------------------
 1 file changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index ec5611005566..3c0bc2505602 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -54,43 +54,12 @@
 struct exynos_pcie {
 	struct dw_pcie			pci;
 	void __iomem			*elbi_base;
-	struct clk			*clk;
-	struct clk			*bus_clk;
+	struct clk_bulk_data		*clks;
+	int				clk_cnt;
 	struct phy			*phy;
 	struct regulator_bulk_data	supplies[2];
 };
 
-static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
-{
-	struct device *dev = ep->pci.dev;
-	int ret;
-
-	ret = clk_prepare_enable(ep->clk);
-	if (ret) {
-		dev_err(dev, "cannot enable pcie rc clock");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(ep->bus_clk);
-	if (ret) {
-		dev_err(dev, "cannot enable pcie bus clock");
-		goto err_bus_clk;
-	}
-
-	return 0;
-
-err_bus_clk:
-	clk_disable_unprepare(ep->clk);
-
-	return ret;
-}
-
-static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
-{
-	clk_disable_unprepare(ep->bus_clk);
-	clk_disable_unprepare(ep->clk);
-}
-
 static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
 {
 	writel(val, base + reg);
@@ -332,17 +301,9 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(ep->elbi_base))
 		return PTR_ERR(ep->elbi_base);
 
-	ep->clk = devm_clk_get(dev, "pcie");
-	if (IS_ERR(ep->clk)) {
-		dev_err(dev, "Failed to get pcie rc clock\n");
-		return PTR_ERR(ep->clk);
-	}
-
-	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(ep->bus_clk)) {
-		dev_err(dev, "Failed to get pcie bus clock\n");
-		return PTR_ERR(ep->bus_clk);
-	}
+	ret = devm_clk_bulk_get_all_enabled(dev, &ep->clks, &ep->clk_cnt);
+	if (ret < 0)
+		return ret;
 
 	ep->supplies[0].supply = "vdd18";
 	ep->supplies[1].supply = "vdd10";
@@ -351,10 +312,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = exynos_pcie_init_clk_resources(ep);
-	if (ret)
-		return ret;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
 	if (ret)
 		return ret;
@@ -369,7 +326,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 
 fail_probe:
 	phy_exit(ep->phy);
-	exynos_pcie_deinit_clk_resources(ep);
 	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
 	return ret;
@@ -383,7 +339,6 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 	exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
-	exynos_pcie_deinit_clk_resources(ep);
 	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
 	return 0;
-- 
2.17.1


