Return-Path: <linux-pci+bounces-3396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A68532DE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CDB1F22D12
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CE56B6A;
	Tue, 13 Feb 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lUjzLLll"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549758136
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833994; cv=none; b=sXiJBSTaICCmyQaYmAcR67YxlTe8nWd2JE69ojEtHT5DbuUoFbAoLIHyKKwDReY7fKOEPGa2484nilCI6r9j1eFbRBSHBDOlzeY9X87IfPYi8tqBw0r1G16NI1QKE6AIIEa5z7oBhGQA0e91Mebsb3QJ9Yr5rrA8cHMVPfGpOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833994; c=relaxed/simple;
	bh=uQSuDcenC7QtjyHuVyxBlW7jEkPTOEKNuzZhMEq78rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=m87XxrLB9nB2DtfwmJckzzQoQBd/u36V/b1LcmASFrt7aVCN1ddSvWkpQg3gcf9vduICL/F7hkZdX6IqdaIrTtzt9r8DsCjCvdJP6nX0t6/IS9mlgrirOBobeo+mi460WMK8MWrmbQ+Xp6A7h+4MBjwXFmvzRIxBv+dOI7nQXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lUjzLLll; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240213141951epoutp02e926ce520ce039d799ce20543afe5c1a~zcfd0M7fm1278512785epoutp02F
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 14:19:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240213141951epoutp02e926ce520ce039d799ce20543afe5c1a~zcfd0M7fm1278512785epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707833991;
	bh=6WcEEEJAqHt6H76Re3bajB+WXdTeFoCOJ/3X3ukJOi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUjzLLllEbt5hLzMDqZuhBOhCHDvFZXph+4racqD0KdWgvuHD0RsC2LTBcQndyEFR
	 rw+KBNXnVeylA3IOarUVp2Sslvgj5yjWlOiEvdKyi3quKiUO+wyy3rm4HH7wWSuGIa
	 4m23HstdWC5kgQhdPZifPTALW0iI2d58IXOJH7K0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240213141950epcas5p24bb732a6a445248187071a09f9f76557~zcfdHHhaX1407914079epcas5p21;
	Tue, 13 Feb 2024 14:19:50 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TZ3PJ3zwBz4x9Py; Tue, 13 Feb
	2024 14:19:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F1.A0.08567.48A7BC56; Tue, 13 Feb 2024 23:19:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240213132810epcas5p22316ffa73fd9b86923f3f741c3a9101e~zbyV4N2g70267302673epcas5p2u;
	Tue, 13 Feb 2024 13:28:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240213132810epsmtrp15cf320889fa76294275e2af1a8dc4d1d~zbyV2GciM1855118551epsmtrp1i;
	Tue, 13 Feb 2024 13:28:10 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-cb-65cb7a848369
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DE.94.08817.A6E6BC56; Tue, 13 Feb 2024 22:28:10 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240213132807epsmtip18b778dcc9bea4d489adc8ca6108282d4~zbyTGh4kq1216112161epsmtip1T;
	Tue, 13 Feb 2024 13:28:07 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v5 2/2] PCI: exynos: Adapt to clk_bulk_* APIs
Date: Tue, 13 Feb 2024 18:57:51 +0530
Message-Id: <20240213132751.46813-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213132751.46813-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xbVRTHc99rX1si+uhg3tXYdWUyh4G1UuotgpiMmbdoGBlqzIzBF3gC
	oX2tfa0OFiPIDwcBNsgGdRswkUWKwqBshUFBwhBYzfid8iOCkiGRNZmRITOAYGmL/ve55/s9
	99xz7r1CXNxBSISZrIkxsrRWTgTw7HePhkcU5PzEKMYmpOjXWjuBGr7IQLN9dzDUuPaVAPW4
	bwtQbukmH9keuPjoz9IFPprsukag+7VDBLKM9mKo/3IPQAVbBTzUPDAvQPMFxXw07jyB6m+v
	CdCOo1OAtl1tPFR297PXg6lJ1zhO/TFTKKDuXJkXUNdtZsrWVExQP7scBLU0VY1R7Q2fU+W3
	mgD12CZNCjiTFZvB0GmMUcawqfq0TDY9Tv5mcsrxlGi1Qhmh1KBX5DKW1jFx8oS3kiLeyNR6
	epPLPqG1Zk8oieY4+bHXYo16s4mRZeg5U5ycMaRpDSpDJEfrODObHskyphilQvFytMf4YVbG
	pap1gaFScvb+ox0iF7hCSoBICEkVnP16gygBAUIx2Q1g1WQ1tiuIyVUAl4pzfMI6gMUlw7y9
	jP7HDr5P6AGwb3AJ+BaFGOwenCJ2XQQZDvP+KsF3hWDyGwDnOtu9KTi5gcHePJu3yD4yDnZt
	LQp2mUe+ADcsC/guB5IxsK2xFffVOwi/a+3zsoh8FfZ1LHo3guSwEE6ub/pNCXCkeQ3z8T74
	cOiWwMcSuHKhyM/p0Npu8fu1cL29we+Ph31T1zzNCT2nOwpvdh3zhZ+Hl50tXgtOPg3LNpf8
	9kDYWbvHoXDtH4d/Lgdg7eAk38cUtK+183xjKQewt7qTfxFIr/xf4joATeAAY+B06UxqtEHJ
	Mp/+d2+pep0NeF9weEInmKnbjuwHmBD0AyjE5cGBE5ZhRhyYRmfnMEZ9itGsZbh+EO0ZYAUu
	CUnVe74Aa0pRqjQKlVqtVmmi1Er5s4Huwpo0MZlOm5gshjEwxr08TCiS5GK5h+2uE8lFORfG
	sZ0fH7FWdc9vK6q68zIuPrN55R3u5AoWF4FdHbVK3UFsfOzYDxW/jOw/+/6saX+jLvLJ6YrG
	RslA/miO2TYx5/zSuVWWeGSLL8ojB3hzdum0hr50qM2lmSZCT1OVN+oWiuujpGOjNdbEoqiP
	wyIO2jWnyuuT8xWrQW+PWF2VO2HSLOvVmRBH1g1bd/VTw0PukPNBzpcSnzt07u+mb+d4juCL
	2WqRrepmSWGwEoZ9NC2JkYS2dLx7ZMKyM32mafnwe6dA5PGVtsLlTS5zla550WkMmx8xff+A
	eZK//MFDIxmvOzmcfe532b2We89styyW8kStuFvO4zJoZThu5Oh/AW8I3+xKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnG5W3ulUg+/LeSwezNvGZrGkKcPi
	5oGdTBYrvsxkt9j7eiu7RUPPb1aLTY+vsVp87LnHanF51xw2i7PzjrNZzDi/j8ni0NS9jBYt
	f1pYLNYeuctucbelk9Xi4ilXi0Vbv7Bb/N+zg93i37WNLBa9h2sdRDwuX7vI7PH+Riu7x85Z
	d9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAriiuGxSUnMyy1KL9O0SuDKm
	TPvGXjBJquLsu/9sDYzXRLsYOTkkBEwkDn3ew9rFyMUhJLCbUeLk/ImsEAlJic8X1zFB2MIS
	K/89Z4coamaSuND6kgUkwSagJdH4tYsZJCEisJxR4ufJp2AdzAI9zBIHWkNAbGEBW4ldfx6y
	g9gsAqoSv2bcYwaxeQWsJDau2MAMsUFeYvWGA2A2p4C1xIHtD8GuEAKq2dO+lmkCI98CRoZV
	jJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBMaKltYNxz6oPeocYmTgYDzFKcDArifBe
	mnEiVYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQamVam5
	qcfyolSvOiqmLTvzajeraPeV/ayMW1pWaXja/6w8Z65bkeS1vnK2VG3Sw2VBS2WX7T/qk2Mb
	6WY8Yf2fo61rmref/2J24+uOEuutKYs6f5dJ/Oncn1t2mevx0eBmGXH5GMXsxOVXHM696jM/
	81NoiWhZnY+3QaTLxM+N09snnHf2Z7mUGbQzvPVK/q8rN3mMNOVPNhbmFr2PzPp1+2yEwhXd
	ijTbG6nrPesZ66duKa/T7JDyLJeaGvquff4T8/qc1RoiX+52T9ZqPbWn4L/P5u9/3ViqneZU
	Sbrf8Jlet+DcIs8L7RtDt1xc/ze6uF06/c6sExNPNzQ9XHflp/cVobrpUWbfbLq9Lh5SYinO
	SDTUYi4qTgQAhx5/0gADAAA=
X-CMS-MailID: 20240213132810epcas5p22316ffa73fd9b86923f3f741c3a9101e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213132810epcas5p22316ffa73fd9b86923f3f741c3a9101e
References: <20240213132751.46813-1-shradha.t@samsung.com>
	<CGME20240213132810epcas5p22316ffa73fd9b86923f3f741c3a9101e@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

There is no need to hardcode the clock info in the driver as driver can
rely on the devicetree to supply the clocks required for the functioning
of the peripheral. Get rid of the static clock info and obtain the
platform supplied clocks. All the clocks supplied is obtained and enabled
using the devm_clk_bulk_get_all_enable() API.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pci-exynos.c | 54 ++-----------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index ec5611005566..3234eb5be1fb 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -54,43 +54,11 @@
 struct exynos_pcie {
 	struct dw_pcie			pci;
 	void __iomem			*elbi_base;
-	struct clk			*clk;
-	struct clk			*bus_clk;
+	struct clk_bulk_data		*clks;
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
@@ -332,17 +300,9 @@ static int exynos_pcie_probe(struct platform_device *pdev)
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
+	ret = devm_clk_bulk_get_all_enable(dev, &ep->clks);
+	if (ret < 0)
+		return ret;
 
 	ep->supplies[0].supply = "vdd18";
 	ep->supplies[1].supply = "vdd10";
@@ -351,10 +311,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = exynos_pcie_init_clk_resources(ep);
-	if (ret)
-		return ret;
-
 	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
 	if (ret)
 		return ret;
@@ -369,7 +325,6 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 
 fail_probe:
 	phy_exit(ep->phy);
-	exynos_pcie_deinit_clk_resources(ep);
 	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
 	return ret;
@@ -383,7 +338,6 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 	exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
-	exynos_pcie_deinit_clk_resources(ep);
 	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
 
 	return 0;
-- 
2.17.1


