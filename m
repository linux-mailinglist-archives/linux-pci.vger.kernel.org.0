Return-Path: <linux-pci+bounces-2520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A3B83A87E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 12:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A0728E61C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191E5B5A9;
	Wed, 24 Jan 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tK3dv63o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B294F895
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096880; cv=none; b=EnjpjWCG+w/MzpDpBStQCbj/tewuST9nW4kva8bkdgY1ggbdI0ak36ZFaFiUvGKjckljNemfTzyoYLfrifcniVaqLf3IFI6CdI7hlyTFR5qIw/JWqnsXIZoUxo6UGO1zpazp6LCt4wXtuiIuqIf6lquyjMugbJ3c0ikmMtKSTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096880; c=relaxed/simple;
	bh=gUSgPK1+Sh+Sx7A+VBZ2ulyzjMHmMtQ17bcSns+ZM3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=VmY5EqV8y5GXK6NeNpS0fqTaKyjhzQXzI9naNVR67ZBoAXuIMzUw2gDtCp0bnnNrJGKSlVwAjJMPmSx+m4CdOAyxKdTRrMpjSGg0ZaVO95zcztKAC26Jkjx9z0dH2NJ3bXgtYSD1p6+a4MTzuaW+92WLG+CTx88zo88SjIOfBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tK3dv63o; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240124114756epoutp011a8a95c9fb86b70263a3df46a522e18d~tRhHvA8uc0150001500epoutp01c
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 11:47:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240124114756epoutp011a8a95c9fb86b70263a3df46a522e18d~tRhHvA8uc0150001500epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706096876;
	bh=VNUEKU7RSaqG5fQSbJf8AaAXKVuI3S4f1gEJAJ/lrrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tK3dv63oJhFdagt9RVUIkHp5wESYPoLMXJP5ICwNdLMtz2yJtW8Q3jbM1e4bZujNK
	 Hf4NP3cHxEph/G4bT9DqyGc3uSjm/77AJVMLZZKjFeeXXOI5/wv5vVFbxfVnJSqU2N
	 gntOVjHPnBFs1z3N1nKCmxc4cweXeaGJsUuoETt4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240124114755epcas5p337f69ee587ad9bfb267308e78a6bd381~tRhGemGBz1012010120epcas5p3A;
	Wed, 24 Jan 2024 11:47:55 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TKhzF5GdRz4x9Pv; Wed, 24 Jan
	2024 11:47:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	57.D5.19369.9E8F0B56; Wed, 24 Jan 2024 20:47:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240124103858epcas5p3d96cdbe8a6c8f31ccc934025411a09b8~tQk6Fbkk91951219512epcas5p3a;
	Wed, 24 Jan 2024 10:38:58 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240124103858epsmtrp2e9fd111d7ac47462bb6598e75a94efe9~tQk6Ei0OY2380723807epsmtrp2W;
	Wed, 24 Jan 2024 10:38:58 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-1c-65b0f8e942eb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.3E.07368.2C8E0B56; Wed, 24 Jan 2024 19:38:58 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240124103856epsmtip275efcd054daeee22b3bed82e32cb3581~tQk3mXvg50212502125epsmtip2r;
	Wed, 24 Jan 2024 10:38:56 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v4 2/2] PCI: exynos: Adapt to clk_bulk_* APIs
Date: Wed, 24 Jan 2024 16:08:38 +0530
Message-Id: <20240124103838.32478-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124103838.32478-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSf0xbVRTO7Y/3CkvJs3R4aeLEtxkFAvQhrZcJSByal4DIpgsZOtlL+9IS
	ymttCxPNYmUUhUCzMedggYZIN5A5ZAU2QECEKopsg/Ej6AZ2g5lsJAMsQ7NZsbRF//vOd75z
	vnPuPSK+pBOTiQo4M2vkGB2JhQouj0RHx937q4OV19ZGI7f9MoYcZVrUul6Po4HlbhxZqh8L
	kXNxVojWqheEaKqvAUNX7aMYqrs+yEPDpwcAKv+7XIAuuuZxNF9eKUSTY6+iL7rXcbTZ34Oj
	f2YvCVDNyLH0cHpqdpJPr8xZcbr37DxONzmLaWdbJUbfmu3H6KXpMzy60/ERbetqA7THuSsn
	NK8wRcsyatYYxXIqvbqA06SSmW/m78tXKOVUHJWMXiSjOKaITSUzsnLiXivQ+dYio0oYXbGP
	ymFMJjIhLcWoLzazUVq9yZxKsga1zpBkiDcxRaZiThPPsea9lFyeqPAJjxRqr1ivCA1nIt//
	ybWJWcBdaRUIEUEiCS5bJ4VVIFQkIfoBtFTP4IHgDwA/Xf0ZCwQbAP7mquFvlzRYWoOJAQCn
	PukTBAIrD7Z0tfhVGBEDP35Yxd9KSIlmAH/t6fS78IklHnTMeQVbqnAiFS4vVuBbWEA8C+vt
	LmwLi4m9cPT8Ci/g9zS80DHk7xpCvAQ91wb93pAYEsHK3gVBQJQB1xrdWACHw/ujXXgAy6Dn
	wUCQ18AvO+uCS+jgRqcjaPAyHJpu8PUR+aaLhl/3JQTop+DpsXa/hE+EwZrHS0G5GPbYt/Fu
	uO7tD44QCe0/TAkDmIYVG/f9thLCBmD71ZgTYNfZ/x2aAGgDMtZgKtKwKoWBiuPYo/99nEpf
	5AT+643J6QEXOrzxw4AnAsMAivikVDwX2c5KxGqm9APWqM83FutY0zBQ+B7wJF+2U6X3nT9n
	zqeSkuVJSqUyKfkFJUU+KV62NqolhIYxs4Usa2CN23U8UYjMwjsxVfTEO7ltLZ5waoH2DGRf
	qrJkZpeZp6sSbIN5herPZ93HZFnpG9IfqbCj76LY7mzFwW/HDP2vRO1fM7jcm5uP3HWxitam
	MtVz3/1pXclQSWe8E/Xf6J/pjp7I0qxJv08WNdu4zZGa8dTaHQm73afiJQ8jfu/FG0sdNyPE
	i4m5X73XdJiqWB2H5xzGu/sr7Exedq4i8+Dx5/e1cecj5HbSg5K9rkeSUs0BodH74duuN7S/
	NISVfGbLvXHRVNkNZl6PTbl3pzbl8J5raXjPQheVfmj9dtqB9ZvXJTcybKsT3mXnyZL6O3ua
	p8+VV0rGH8TsOC6OvLVTeeR24qEZ3PYWKTBpGSqGbzQx/wLnoUQZRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvO6hFxtSDRra9S0ezNvGZrGkKcNi
	xZeZ7BZ7X29lt2jo+c1qsenxNVaLjz33WC0u75rDZnF23nE2ixnn9zFZHJq6l9Gi5U8Li8Xa
	I3fZLe62dLJaXDzlarFo6xd2i/97drBb/Lu2kcWi93Ctg7DH5WsXmT3e32hl99g56y67x4JN
	pR6bVnWyedy5tofN48mV6Uwem5fUe/RtWcXo8XmTXABXFJdNSmpOZllqkb5dAlfG9tbtrAXT
	JStOHvnP1sD4VKSLkZNDQsBEYk7DCrYuRi4OIYHdjBLP119ggUhISny+uI4JwhaWWPnvOTtE
	UTOTRMvc1WwgCTYBLYnGr13MIAkRgeWMEj9PPmUCcZgFvjBJTHq4C6xdWMBW4vXjNnYQm0VA
	VWLmvCNg3bwCVhLHl72HWiEvsXrDAWYQm1PAWuLzuX1gNUJANR9ndDFPYORbwMiwilEytaA4
	Nz032bDAMC+1XK84Mbe4NC9dLzk/dxMjODa0NHYw3pv/T+8QIxMH4yFGCQ5mJRHeG5LrUoV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzGs6YnSIkkJ5YkpqdmlqQWgSTZeLglGpgWnb4duyNfm2X
	0uapQkuj/jF4qEta7rj4S/rNpYcXlGs1gj/lXnLSXT237xU/N5enfOz/Hw1sR9a81OAsWlEo
	wMBx6YvZYYlLTjxW1l2zL2d9MMyV/1rb/HHFenb/4K5ylbIdd3ZGSt0I/CLWvIRVVtR9kpj+
	fE6/BXcnSk/cPfVG1XK2/e2LlCdtvbnx+aRD6afvfru7VvKiyJ+Zx9h270jLZyk5csh6kWqu
	0bFzN057FWye9Gn+0R+89wVPKhxc89zaVcGYh+XcocN6SpdfKAccCjKer3GzYHvnKemShowb
	kepsU9V7TbyKlx75Wli44qG1+PGOvV7zr/802fRVx7CoN5fn4uUfGq5cWl2705VYijMSDbWY
	i4oTAfzz9zX8AgAA
X-CMS-MailID: 20240124103858epcas5p3d96cdbe8a6c8f31ccc934025411a09b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124103858epcas5p3d96cdbe8a6c8f31ccc934025411a09b8
References: <20240124103838.32478-1-shradha.t@samsung.com>
	<CGME20240124103858epcas5p3d96cdbe8a6c8f31ccc934025411a09b8@epcas5p3.samsung.com>
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


