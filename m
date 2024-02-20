Return-Path: <linux-pci+bounces-3757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266185BA51
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971411C22318
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24665BDF;
	Tue, 20 Feb 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NoJ16kJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64269664B9
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428100; cv=none; b=c2Lq3lXvb/AndPPMEflzVnWKs3miXNZTEc0ImBcQdUwUvay9LK+k0NU1z2a1At6dfS7heJA0VbebPedZKNFPrsspLEZXbrIIIhJ7RD4lw+ikDADBGa32ph3IdMp/jrdrfH/qgzYPJ8giOL8HfJB9IGKPv3QeTvOunabhL9GEH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428100; c=relaxed/simple;
	bh=uQSuDcenC7QtjyHuVyxBlW7jEkPTOEKNuzZhMEq78rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=idxsbU174m8tnFIg8XMmHkwrd6/M/Qr2CE3Q5noh47YbN+B2NyKDXuRMxXhfZWy8LBPkMEDWau5d6aCCQzVUBFYl4huUFdqFVaIxjzjqVvFnhbJ087swhocCmIY1WvOyCZgh43MNA4LnDgYTdTaoJ8EMgjSbul+Fc7wbre0a41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NoJ16kJ/; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240220112131epoutp01dd5574ff08a3b4b9afe18073b00161fa~1jkwVMvUC2828328283epoutp01c
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 11:21:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240220112131epoutp01dd5574ff08a3b4b9afe18073b00161fa~1jkwVMvUC2828328283epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708428091;
	bh=6WcEEEJAqHt6H76Re3bajB+WXdTeFoCOJ/3X3ukJOi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoJ16kJ/2Wf/u+qfLviKZqe/TdbFGWbloZIcnE4klF/gPOylGnrlg+w8EPmhEG6/3
	 cTlsCKwMzJ9PQpaXhnJXG9ztyPz7yqNsnqPnlkD776m/lePf/dvDJ1rr1LX7Fk34Cw
	 U+p72gFgvDqp9HGtRyJVKNKAYTTMqUpBubiwH0tk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240220112130epcas5p1c696cdb51441ce6690ccd0ce05ae5dd0~1jkv0vIQq2879428794epcas5p1s;
	Tue, 20 Feb 2024 11:21:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TfH6J5jF4z4x9Pt; Tue, 20 Feb
	2024 11:21:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.F3.09672.83B84D56; Tue, 20 Feb 2024 20:21:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240220084125epcas5p28c6d886685006800fc26c11918d5d1dd~1hY_Xg-4K1825418254epcas5p20;
	Tue, 20 Feb 2024 08:41:25 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240220084125epsmtrp1969a5c0f2d6b128c58305a9f6452d154~1hY_WkhMu0876808768epsmtrp1c;
	Tue, 20 Feb 2024 08:41:25 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-fe-65d48b381b9a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.C7.08817.5B564D56; Tue, 20 Feb 2024 17:41:25 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240220084122epsmtip15bf359fa9d7cb4279eec9634a592a933~1hY7vkWrA2980029800epsmtip19;
	Tue, 20 Feb 2024 08:41:22 +0000 (GMT)
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
Subject: [PATCH v6 2/2] PCI: exynos: Adapt to clk_bulk_* APIs
Date: Tue, 20 Feb 2024 14:10:46 +0530
Message-Id: <20240220084046.23786-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240220084046.23786-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUxTVxjeubftLSDmho/sWAKSK2YDB7YK9aAyNXNwF1lGZrZs+wHc0ZuW
	UG5rW4YzqHwjCAwIIjKobKtk8jVpwSFfw0qEwHAj1AIbMARD5lgYXwM3JqylsP17zvs8z/vk
	fc8rxN2aBSJhPKdjNRyjpATOvLsP/F8NRFctrHig6wCa0t8VIEO6Ao1138PQ1ys3CNQ510Kg
	1Px1PjLOWPloMX+Sj4bbKgVoUN8rQOU/dGHIfK0ToMx/MnmooWeCQBOZuXw01P8m+rJlhUCb
	Ha0E2rA28VDBg4snPehh6xBO/zGaRdD3KiYIutqYRBtrcwX0uLVDQD+1XMdok+EyXdhcC+hl
	o0+U80cJxxUsI2M1viwXp5LFc/Iw6szZmDdiQqRiSaAkFB2hfDkmkQ2jTkdGBYbHK22zUb6f
	MMokWymK0Wqpg68f16iSdKyvQqXVhVGsWqZUB6uDtEyiNomTB3Gs7qhELD4UYhPGJihKy1YJ
	dYno/OD8piAVWD3zgJMQksFwUz/NywPOQjeyHcDNdgtmJ9zIJQDHBwIcxCqAT17c5u04+grm
	gUPUCWBltrtDlIXBovblLUJABsC0P/NwO+FBfgXgT60mvv2Bk39jsCvNuJXhTobBxYJ2wo55
	5H5oMudsRbiSR+H9H+sIR9xeWHen29ZJKHQij8HHNfH2PpDsE8KloVHMXofkaTh55bxD7g5/
	623etorgs8+yt7Ec3jaV4w6shKsmA+bAJ2C3pZJnb4OT/vCbtoOOsje81t+4JcHJ3bBg/em2
	3BW26nfwPrjyomN7KXug/uEw34Fp+G32DOZYSiGAyzcbsSLgU/F/RDUAtWAPq9YmylltiPow
	xyb/92lxqkQj2DrfgDOtYHpqIcgMMCEwAyjEKQ9XXrKFdXOVMZ9eYDWqGE2SktWaQYhtfcW4
	yDNOZbt/ThcjCQ4VB0ul0uDQw1IJ9bLrXFaVzI2UMzo2gWXVrGbHhwmdRKlYW1nEr48+n11a
	6jbcqE/I0ZlGqlpkordgbl3FsZGpI7pD+VGd84w40YuwFK0PFFH1PQcGv9eeuETMPg+JGRrb
	PzJ7Ls0/4701n56L+7jXcudPqcMvtLTGpecZXHaNNJaUPKci12bmijMiX/nLJXZDNFhWslHs
	svDhz3JkvlVzyW/wCd5354NfSpmo5KVzp1Lun37MBo13+ZWvYZNh61zEcM3Vh1/ELvTcbGjb
	ndH//q5ZPRdg2NvkIpgOX/A+m0JPvWNQpLQ/ip6JriqMPvmuR46XOeLWaNnas14xWGyUDkut
	9XVE6pX6y5uN34lxv4aPS5sYL89VakzyUvXv6Q3eI29TPK2CkQTgGi3zLzlS0stHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnO7W1CupBuuOiVg8mLeNzWJJU4bF
	zQM7mSxWfJnJbrH39VZ2i4ae36wWmx5fY7X42HOP1eLyrjlsFmfnHWezmHF+H5PFoal7GS1a
	/rSwWKw9cpfd4m5LJ6vFxVOuFou2fmG3+L9nB7vFv2sbWSx6D9c6iHhcvnaR2eP9jVZ2j52z
	7rJ7LNhU6rFpVSebx51re9g8nlyZzuSxeUm9R9+WVYwenzfJBXBFcdmkpOZklqUW6dslcGVM
	mfaNvWCSVMXZd//ZGhiviXYxcnJICJhInOh9xwhiCwnsZpR4fFoEIi4p8fniOiYIW1hi5b/n
	7F2MXEA1zUwS6/bsYAZJsAloSTR+7WIGSYgILGeU+HnyKVgHs0APs8SB1hAQW1jAVuJj7252
	EJtFQFVi86F2FhCbV8BK4uCF1ewQG+QlVm84ADSIg4NTwFri6rJMiIOsJP4/3MU8gZFvASPD
	KkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4PjQ0trBuGfVB71DjEwcjIcYJTiYlUR4
	3ZsupArxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXA1NFv
	tvDENo2ZO6sZ5K9P9507q6d41+E0K75L7XkvCrVrhfl5hGZOFDYOz1HevrsgLFRDZeW6G74X
	pyxrviG9iH1l1BKLtcunJHTkvjrr9l3VVyzGOSBkV0fPgs4HIfGNs96/WCPrLclrocP8qXMn
	l5Z3c2eV7DXJ5emWQWrmf2VZI5+17JKrXbUmUmIO1z4pgVLWDVIHHHZuXLdyg+sM3YYX/y5u
	kl64f/+211P6LC4E/MtY9a8pj8G6xynpR/TbvWK2/MYp78+tjFa4Nami+LXxV1ctZr4t6z13
	HwnccenPr8Vic36pMmyLOHdshvCCB5XcG3bMCD0hslv9od25rhb788p2PN1fVhpXdZslKbEU
	ZyQaajEXFScCAHzCl+P+AgAA
X-CMS-MailID: 20240220084125epcas5p28c6d886685006800fc26c11918d5d1dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220084125epcas5p28c6d886685006800fc26c11918d5d1dd
References: <20240220084046.23786-1-shradha.t@samsung.com>
	<CGME20240220084125epcas5p28c6d886685006800fc26c11918d5d1dd@epcas5p2.samsung.com>
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


