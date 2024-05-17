Return-Path: <linux-pci+bounces-7603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591D48C8531
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E4E1F22DDC
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C843BB35;
	Fri, 17 May 2024 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EpUjn6aT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADC3A29B;
	Fri, 17 May 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943937; cv=none; b=AlOmLfWPp5KMZtCpuq7jKkRd74YODWPKyG9fyAJlEmd4En3kxKwLG00ymBC6XaEu/fsbiWT+FGp8Wrt/IonC/1tdZYL8K9qNy3U/lZuShsTFzDZQOrpFMPT/rknSukLlHN55WcSEaKHSGnejiP7dBgRPvEac1SRofAtYZzvKBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943937; c=relaxed/simple;
	bh=l/b5uRl1w4aq8dg1Bjd+a2zsBk2VzUmDnJ/RG2Shg4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=A4fuN9StGhi4MriFoknpLCnvCZMM/KPbR3KS/zwdhA6cL/GyeSD6NnUooWzM1d+oLQsiQNHJHp5tABizewR7jd5HuC6ID+Ho1STR8Jh3RCnrgik4WvDs5iZ5MDazQ8AEFPrUVlfNCbvD/nyNu03S0TnqRfh0KrVk94ch4oP4vtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EpUjn6aT; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240517110523epoutp04c5398c9a92662527821ca3f3b94ed183~QQehLi_Pr2008820088epoutp04M;
	Fri, 17 May 2024 11:05:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240517110523epoutp04c5398c9a92662527821ca3f3b94ed183~QQehLi_Pr2008820088epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715943924;
	bh=Z5ixtix+12SNi+QxywR39pa4D0RbumIkM+g1RAEo26A=;
	h=From:To:Cc:Subject:Date:References:From;
	b=EpUjn6aTxuYkG1ZSOv4ICKzjVbwJk89N4xISSxZ72nZSImR+0cJ335P6PQPzj0rE8
	 K5f4oHD9ce1fJMT8JVmc6YgKE/fLswwvMu8iJnyLAr3pAp4CZ56w023TUZLPoQvPmt
	 qboc3zdMpWAhYJG9WfM0ZLkvW40R8z+DTtThfpQU=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240517110523epcas5p4ed3ab835000826eb70d2d9d763ebb73d~QQegu7aE62482324823epcas5p4b;
	Fri, 17 May 2024 11:05:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.ED.09665.3F937466; Fri, 17 May 2024 20:05:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240517105941epcas5p3e8dbb97f19c9553bf9942ad146124806~QQZh7C_DL2521025210epcas5p3P;
	Fri, 17 May 2024 10:59:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240517105941epsmtrp222e8d36ae9712dfa01713dea2d23b7b7~QQZh5YXjZ1844818448epsmtrp2C;
	Fri, 17 May 2024 10:59:41 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-ed-664739f3e0f7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.2A.09238.C9837466; Fri, 17 May 2024 19:59:40 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240517105932epsmtip23019217befbc8650ced6fe964f5f50c2~QQZZ_UtiA1509015090epsmtip2m;
	Fri, 17 May 2024 10:59:32 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: bhelgaas@google.com, vigneshr@ti.com, s-vadapalli@ti.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, yue.wang@Amlogic.com,
	neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, thomas.petazzoni@bootlin.com,
	shawn.guo@linaro.org, lchuanhua@maxlinear.com, srikanth.thokala@intel.com,
	songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
	manivannan.sadhasivam@linaro.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	pali@kernel.org, toan@os.amperecomputing.com, daire.mcnamara@microchip.com,
	conor.dooley@microchip.com, marek.vasut+renesas@gmail.com,
	shawn.lin@rock-chips.com, heiko@sntech.de, nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev, kishon@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, rafael@kernel.org, lenb@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, r.thapliyal@samsung.com, Onkarnath
	<onkarnath.1@samsung.com>, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] PCI : Refactoring error log prints for better
 readability
Date: Fri, 17 May 2024 16:29:23 +0530
Message-Id: <20240517105923.2406246-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPb2399ZKWQdsHGGOrE4dZDyM1RwzA9sk46rZIgYX42NbMwo4
	edRW3JBNEdq6EkRUyqOF8pwiMggdbLS0gQHy2EAG0goMFUqRASKsMMV2hgFXMv/7nO/vd77f
	3+8kh4W5pJAerOOxp4TiWEE0j2DjPzd7b/Gd2xkSEZBcxkKlyVEoU1tHooaZCQZqHzhPoOb+
	ZIAWLVNM9MjSgqGKXjmBbkhHMCRVFePo2YUaBrolW8RQUpqDiRZyBgDSjUwTqFC9DmlHzUx0
	uaGLRHf0eQRSl17CUZemjUCKeRWBpP9KcZTe+COJmgvkOLonVTDRyI08HLUWd+Co5PpmNKMb
	BOhO0buoLG2Wie4O/gVQoeF3AlXfP4Hy55UYWjQsjWpQNmJorLIUQ0PWqqUp7f0YUuocJHqm
	1+BI8egxifoGK3G02DVLom5ZDoZ+rd/2fgDVUnETUDP9MpLSVCRSOtU9kirUxlNjGVdJajS/
	mqRKDBMMSluuIKjCKiuTGjIbCMral82gipKUGJVR3AgoTUco9VPpuf0eh9m7woXRx08Lxf6B
	X7Cj7NkBolIp/o3dNkomgYwCLBWsZUEuH1401ZKpgM1y4dYDmNc/zqAPNgB/aGkF9OEJgBPt
	crB6Rd06TtAFI4Aysx1fLrhw5wGcbQlZZoLrA3OGGles3LjXSKjK0a8EYtxOBpxr2b3Mrtz9
	UJZjXnHFuZug/U/TSg+HGwh11gImneYFc3ufkrT+KuzIteK0jxdMqVVjywGQW8uGM+O5LzYK
	huo+3Qt2hZNtNSTNHnDusZGgOQ5K1aqlHtYSfwtNY5toOQhae4qYyzLG9YZVen9a3gCVv1Uy
	6FhneNFhZdA6B9ZpVnlp/EwlTrMnfODIJ2h3Cj4oOE0/zzF4LdPBzABeqpeWUb20jOr/4EKA
	lYP1QpEkJlIo2S7aFiv82k8iiJHEx0b6fRkXowUr/8RnXx2wDM/6NQEGCzQByMJ4bhy3iN0R
	LpxwQcIZoTjuc3F8tFDSBDxZOM+dMyXLD3fhRgpOCU8IhSKheLXKYK31SGJkKF65bLGpEkci
	N2tqdUF7N7LecUq4lG2RGw+2H/Osh91nm77L4h0cXZO+xSmY77WPH4pvPar/yCk205n4bJd/
	3SdHWje8rt/JyH1rzzmJIasmPeXJQmjqFDn5C//jtIHZSt/3pnfUDptE3RekZbeNZxXe8soQ
	tjzLkhgUfKgk2Jnf+5CXVf7GmUOiTpn7/T01KcbO3oGaHluY2VQ+/32DpcKxvtXsG3xY+kHP
	8+Kh4bA3xzgaZ3Vc/MKBpzcTHnoQ1QlH1mi/uht/e3H7gTDXq0cl04KTH7rbz18JN105+fet
	ybe94z6d2dEW2GVoUNiuownJH689B3mD/6zjSzdiNuPeAh4uiRJs9cHEEsF/Lrlt+ZYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02ScUwTdxTH97u73h1U3FmaeGIWshLREGB0I8vb5hjELR5L3DTLjBnJtKMH
	NAI2LSCKCx0UFWe0BtDSFqhQRaTg6NDYUkOhwGCTdAPGAIEMKSKiYohx2jIYhSzxv+97n/fN
	9/vHo3GRVRBGK7JzeFW2LFNCBhO33JLwGBPsTos77YgBS1EGlNtuU9C+MIdB7+gPJLhHihCs
	3J8XwOP7XThYB06S0KCdwkFrqCXg1alWDLpLVnDQnPUL4KV+FIF96gkJZqMQbNPDArjQ3k/B
	oMNEgtFynoD+6l9IKH1uIEG7pCXgnKuJAnfNSQImtKUCmGowEdBT20dAXX0kLNjHEAxejoZr
	Z58J4K+xhwjMzt9IaJk8DFXPK3BYca5WdVa4cJhptuAw7r2x2tI3gkOF3U/BK0c1AaWPn1Iw
	NNZMwEr/Mwo8JXocOtreS4zjuqyNiFsYKaG4amsBZzdMUJzZlsvN6MoobrqqheLqnHMYZ7te
	SnLmG14BNz7sJDnv0CWMu6ypwDldrQtx1X37uJ8thXvDvgneKeczFXm86p2EQ8EZvktxSouW
	yPctTlMapKvBz6AgmmXiWWPPLHkGBdMipg2xyzYtWgdb2cVBE7WuQ9mG5dk1LWIWEeu4mxjQ
	JBPF6sddWMAsZoYp9u4pAxEYcGYYYx/5rggCV6HMF+zDieI1N8FsY333/lyLDmESWLu3RrCe
	EM5WDvxDre83sX2VXiKg8dV98U0jrkMbDa8hw2vIjLDraAuvVGelZ6VKldJs/misWpalzs1O
	j009kmVDaw8VteM2mqxZju1EGI06EUvjEnGIOG1XmihELjt2nFcdOajKzeTVnWgrTUg2h0j1
	RrmISZfl8Id5Xsmr/qcYHRSmwaI1+4zn/y54cWI6qGaDuG1vT5VxTDT6VUGlrjsumJ7vfbMj
	qbjD7Aahz3HhO9tmgTXZLL5365oNkiJjXl4ltiSbrloHmuPL2rf3hr/76Fz8phzNJ/I54bG2
	+qHj6qRhx4ec5nflUurbL5YqnNqqsqijh+zC079OHfAkf7si3KNoUISm/RhZLvwjrwG70/PT
	RfcBf1BEwoMdSsXFFjq9elfEwe1hX3taP/U3FrreiIje/eXkTJO2cWjS85bhqWSeC31f330n
	ZXZD7/L+2r6dcs+D9P3xRYX1n4tSpJqIj70jG/8Vf9+Vf+LmR9vyU5grraLEBXfKYnydqfwD
	V/NnKn/ekyYJoc6QSaNwlVr2HxtQIOm/AwAA
X-CMS-MailID: 20240517105941epcas5p3e8dbb97f19c9553bf9942ad146124806
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240517105941epcas5p3e8dbb97f19c9553bf9942ad146124806
References: <CGME20240517105941epcas5p3e8dbb97f19c9553bf9942ad146124806@epcas5p3.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

As %pe is already introduced, it's better to use it in place of (%ld) or (%d) for
printing error in logs. It will enhance readability of logs.

Error print style is more consistent now.

Co-developed-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
---
Suggested by Bjorn Helgaas in below discussion
https://patchwork.kernel.org/comment/25712288/

 drivers/pci/bus.c                             |   2 +-
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-meson.c        |  16 +--
 drivers/pci/controller/dwc/pcie-armada8k.c    |   4 +-
 drivers/pci/controller/dwc/pcie-histb.c       |   6 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  10 +-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c       |   6 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  18 +--
 drivers/pci/controller/dwc/pcie-qcom.c        |  18 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    | 132 +++++++++---------
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
 drivers/pci/controller/pci-aardvark.c         |   6 +-
 drivers/pci/controller/pci-ftpci100.c         |   2 +-
 drivers/pci/controller/pci-tegra.c            |  86 ++++++------
 drivers/pci/controller/pci-xgene.c            |   4 +-
 drivers/pci/controller/pcie-microchip-host.c  |   2 +-
 drivers/pci/controller/pcie-rcar-host.c       |  14 +-
 drivers/pci/controller/pcie-rockchip.c        |  34 ++---
 drivers/pci/controller/vmd.c                  |   2 +-
 drivers/pci/doe.c                             |   4 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |   8 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   4 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   2 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |  12 +-
 drivers/pci/endpoint/pci-epf-core.c           |  16 +--
 drivers/pci/hotplug/acpiphp_core.c            |   2 +-
 drivers/pci/hotplug/pciehp_core.c             |   8 +-
 drivers/pci/hotplug/shpchp_core.c             |   4 +-
 drivers/pci/of.c                              |   6 +-
 drivers/pci/pci-driver.c                      |   4 +-
 drivers/pci/pcie/dpc.c                        |   4 +-
 drivers/pci/quirks.c                          |   2 +-
 drivers/pci/setup-bus.c                       |   2 +-
 drivers/pci/slot.c                            |   4 +-
 drivers/pci/vgaarb.c                          |   2 +-
 37 files changed, 227 insertions(+), 227 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 826b5016a101..dbc16cf5a246 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -351,7 +351,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	dev->match_driver = !dn || of_device_is_available(dn);
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER)
-		pci_warn(dev, "device attach failed (%d)\n", retval);
+		pci_warn(dev, "device attach failed: %pe\n", ERR_PTR(retval));
 
 	pci_dev_assign_added(dev, true);
 }
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d2d17d37d3e0..79b6cc7f0287 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -801,7 +801,7 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
 	if (IS_ERR(reset)) {
 		ret = PTR_ERR(reset);
-		dev_err(&pdev->dev, "gpio request failed, ret %d\n", ret);
+		dev_err(&pdev->dev, "gpio request failed: %pe\n", ERR_PTR(ret));
 		goto err_gpio;
 	}
 
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 6477c83262c2..c449d7af9d5b 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -183,7 +183,7 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
 	if (rate) {
 		ret = clk_set_rate(clk, rate);
 		if (ret) {
-			dev_err(dev, "set clk rate failed, ret = %d\n", ret);
+			dev_err(dev, "set clk rate failed: %pe\n", ERR_PTR(ret));
 			return ERR_PTR(ret);
 		}
 	}
@@ -416,7 +416,7 @@ static int meson_pcie_probe(struct platform_device *pdev)
 
 	mp->phy = devm_phy_get(dev, "pcie");
 	if (IS_ERR(mp->phy)) {
-		dev_err(dev, "get phy failed, %ld\n", PTR_ERR(mp->phy));
+		dev_err(dev, "get phy failed: %pe\n", mp->phy);
 		return PTR_ERR(mp->phy);
 	}
 
@@ -428,31 +428,31 @@ static int meson_pcie_probe(struct platform_device *pdev)
 
 	ret = meson_pcie_get_resets(mp);
 	if (ret) {
-		dev_err(dev, "get reset resource failed, %d\n", ret);
+		dev_err(dev, "get reset resource failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = meson_pcie_get_mems(pdev, mp);
 	if (ret) {
-		dev_err(dev, "get memory resource failed, %d\n", ret);
+		dev_err(dev, "get memory resource failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = meson_pcie_power_on(mp);
 	if (ret) {
-		dev_err(dev, "phy power on failed, %d\n", ret);
+		dev_err(dev, "phy power on failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = meson_pcie_reset(mp);
 	if (ret) {
-		dev_err(dev, "reset failed, %d\n", ret);
+		dev_err(dev, "reset failed: %pe\n", ERR_PTR(ret));
 		goto err_phy;
 	}
 
 	ret = meson_pcie_probe_clocks(mp);
 	if (ret) {
-		dev_err(dev, "init clock resources failed, %d\n", ret);
+		dev_err(dev, "init clock resources failed: %pe\n", ERR_PTR(ret));
 		goto err_phy;
 	}
 
@@ -460,7 +460,7 @@ static int meson_pcie_probe(struct platform_device *pdev)
 
 	ret = dw_pcie_host_init(&pci->pp);
 	if (ret < 0) {
-		dev_err(dev, "Add PCIe port failed, %d\n", ret);
+		dev_err(dev, "Add PCIe port failed: %pe\n", ERR_PTR(ret));
 		goto err_phy;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b5c599ccaacf..581ed3e44d3b 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -134,7 +134,7 @@ static int armada8k_pcie_setup_phys(struct armada8k_pcie *pcie)
 
 	ret = armada8k_pcie_enable_phys(pcie);
 	if (ret)
-		dev_err(dev, "Failed to initialize PHY(s) (%d)\n", ret);
+		dev_err(dev, "Failed to initialize PHY(s): %pe\n", ERR_PTR(ret));
 
 	return ret;
 }
@@ -251,7 +251,7 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-		dev_err(dev, "failed to initialize host: %d\n", ret);
+		dev_err(dev, "failed to initialize host: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 7a11c618b9d9..4dde61f79024 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -230,7 +230,7 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
 	if (hipcie->vpcie) {
 		ret = regulator_enable(hipcie->vpcie);
 		if (ret) {
-			dev_err(dev, "failed to enable regulator: %d\n", ret);
+			dev_err(dev, "failed to enable regulator: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -337,14 +337,14 @@ static int histb_pcie_probe(struct platform_device *pdev)
 						     GPIOD_OUT_HIGH);
 	ret = PTR_ERR_OR_ZERO(hipcie->reset_gpio);
 	if (ret) {
-		dev_err(dev, "unable to request reset gpio: %d\n", ret);
+		dev_err(dev, "unable to request reset gpio: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = gpiod_set_consumer_name(hipcie->reset_gpio,
 				      "PCIe device power control");
 	if (ret) {
-		dev_err(dev, "unable to set reset gpio name: %d\n", ret);
+		dev_err(dev, "unable to set reset gpio name: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index acbe4f6d3291..3a94feed4fbf 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -155,7 +155,7 @@ static int intel_pcie_ep_rst_init(struct intel_pcie *pcie)
 	if (IS_ERR(pcie->reset_gpio)) {
 		ret = PTR_ERR(pcie->reset_gpio);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to request PCIe GPIO: %d\n", ret);
+			dev_err(dev, "Failed to request PCIe GPIO: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -214,7 +214,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	if (IS_ERR(pcie->core_clk)) {
 		ret = PTR_ERR(pcie->core_clk);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get clks: %d\n", ret);
+			dev_err(dev, "Failed to get clks: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -222,7 +222,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	if (IS_ERR(pcie->core_rst)) {
 		ret = PTR_ERR(pcie->core_rst);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get resets: %d\n", ret);
+			dev_err(dev, "Failed to get resets: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -239,7 +239,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	if (IS_ERR(pcie->phy)) {
 		ret = PTR_ERR(pcie->phy);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Couldn't get pcie-phy: %d\n", ret);
+			dev_err(dev, "Couldn't get pcie-phy: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -295,7 +295,7 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
 
 	ret = clk_prepare_enable(pcie->core_clk);
 	if (ret) {
-		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
+		dev_err(pcie->pci.dev, "Core clock enable failed: %pe\n", ERR_PTR(ret));
 		goto clk_err;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 98bbc83182b4..6b406d2e6e5d 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -377,7 +377,7 @@ static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		keembay_ep_reset_assert(pcie);
-		dev_err(dev, "Failed to initialize host: %d\n", ret);
+		dev_err(dev, "Failed to initialize host: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5523f302102..cb0ab71b2fc7 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -421,7 +421,7 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 
 			ret = of_pci_get_devfn(child);
 			if (ret < 0) {
-				dev_err(dev, "failed to parse devfn: %d\n", ret);
+				dev_err(dev, "failed to parse devfn: %pe\n", ERR_PTR(ret));
 				goto put_node;
 			}
 
@@ -555,8 +555,8 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
 	for (i = 0; i < kirin_pcie->num_slots; i++) {
 		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
 		if (ret) {
-			dev_err(pci->dev, "PERST# %s error: %d\n",
-				kirin_pcie->reset_names[i], ret);
+			dev_err(pci->dev, "PERST# %s error: %pe\n",
+				kirin_pcie->reset_names[i], ERR_PTR(ret));
 		}
 	}
 	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2fb8c15e7a91..be31a60bc693 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -296,8 +296,8 @@ static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
 
 	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret)
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %pe\n",
+			ERR_PTR(ret));
 }
 
 static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
@@ -334,8 +334,8 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	 */
 	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %pe\n",
+			ERR_PTR(ret));
 		goto err_phy_off;
 	}
 
@@ -368,7 +368,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 
 	ret = qcom_pcie_enable_resources(pcie_ep);
 	if (ret) {
-		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		dev_err(dev, "Failed to enable resources: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -465,7 +465,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 
 	ret = dw_pcie_ep_init_registers(&pcie_ep->pci.ep);
 	if (ret) {
-		dev_err(dev, "Failed to complete initialization: %d\n", ret);
+		dev_err(dev, "Failed to complete initialization: %pe\n", ERR_PTR(ret));
 		goto err_disable_resources;
 	}
 
@@ -591,7 +591,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 
 	ret = qcom_pcie_ep_get_io_resources(pdev, pcie_ep);
 	if (ret) {
-		dev_err(dev, "Failed to get io resources %d\n", ret);
+		dev_err(dev, "Failed to get io resources: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -824,13 +824,13 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 
 	ret = qcom_pcie_enable_resources(pcie_ep);
 	if (ret) {
-		dev_err(dev, "Failed to enable resources: %d\n", ret);
+		dev_err(dev, "Failed to enable resources: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
 	if (ret) {
-		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
+		dev_err(dev, "Failed to initialize endpoint: %pe\n", ERR_PTR(ret));
 		goto err_disable_resources;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..9aa78672f64d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -931,7 +931,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	ret = reset_control_assert(res->rst);
 	if (ret) {
-		dev_err(dev, "reset assert failed (%d)\n", ret);
+		dev_err(dev, "reset assert failed: %pe\n", ERR_PTR(ret));
 		goto err_disable_clocks;
 	}
 
@@ -939,7 +939,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	ret = reset_control_deassert(res->rst);
 	if (ret) {
-		dev_err(dev, "reset deassert failed (%d)\n", ret);
+		dev_err(dev, "reset deassert failed: %pe\n", ERR_PTR(ret));
 		goto err_disable_clocks;
 	}
 
@@ -1135,7 +1135,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 
 	ret = reset_control_assert(res->rst);
 	if (ret) {
-		dev_err(dev, "reset assert failed (%d)\n", ret);
+		dev_err(dev, "reset assert failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1147,7 +1147,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
 
 	ret = reset_control_deassert(res->rst);
 	if (ret) {
-		dev_err(dev, "reset deassert failed (%d)\n", ret);
+		dev_err(dev, "reset deassert failed: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1418,8 +1418,8 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 
@@ -1448,8 +1448,8 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 
 	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %pe\n",
+			ERR_PTR(ret));
 	}
 }
 
@@ -1610,7 +1610,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(dev, "Failed to set interconnect bandwidth: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93f5433c5c55..3c93bb11e068 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1114,38 +1114,38 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 
 	ret = of_property_read_u32(np, "nvidia,aspm-cmrt-us", &pcie->aspm_cmrt);
 	if (ret < 0) {
-		dev_info(pcie->dev, "Failed to read ASPM T_cmrt: %d\n", ret);
+		dev_info(pcie->dev, "Failed to read ASPM T_cmrt: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = of_property_read_u32(np, "nvidia,aspm-pwr-on-t-us",
 				   &pcie->aspm_pwr_on_t);
 	if (ret < 0)
-		dev_info(pcie->dev, "Failed to read ASPM Power On time: %d\n",
-			 ret);
+		dev_info(pcie->dev, "Failed to read ASPM Power On time: %pe\n",
+			 ERR_PTR(ret));
 
 	ret = of_property_read_u32(np, "nvidia,aspm-l0s-entrance-latency-us",
 				   &pcie->aspm_l0s_enter_lat);
 	if (ret < 0)
 		dev_info(pcie->dev,
-			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
+			 "Failed to read ASPM L0s Entrance latency: %pe\n", ERR_PTR(ret));
 
 	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
+		dev_err(pcie->dev, "Failed to read num-lanes: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = of_property_read_u32_index(np, "nvidia,bpmp", 1, &pcie->cid);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to read Controller-ID: %d\n", ret);
+		dev_err(pcie->dev, "Failed to read Controller-ID: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = of_property_count_strings(np, "phy-names");
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to find PHY entries: %d\n",
-			ret);
+		dev_err(pcie->dev, "Failed to find PHY entries: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 	pcie->phy_count = ret;
@@ -1186,8 +1186,8 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 			level = KERN_DEBUG;
 
 		dev_printk(level, pcie->dev,
-			   dev_fmt("Failed to get PERST GPIO: %d\n"),
-			   err);
+			   dev_fmt("Failed to get PERST GPIO: %pe\n"),
+			   ERR_PTR(err));
 		return err;
 	}
 
@@ -1202,8 +1202,8 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 			level = KERN_DEBUG;
 
 		dev_printk(level, pcie->dev,
-			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
-			   err);
+			   dev_fmt("Failed to get REFCLK select GPIOs: %pe\n"),
+			   ERR_PTR(err));
 		pcie->pex_refclk_sel_gpiod = NULL;
 	}
 
@@ -1336,7 +1336,7 @@ static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
 		ret = regulator_enable(pcie->slot_ctl_3v3);
 		if (ret < 0) {
 			dev_err(pcie->dev,
-				"Failed to enable 3.3V slot supply: %d\n", ret);
+				"Failed to enable 3.3V slot supply: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -1345,7 +1345,7 @@ static int tegra_pcie_enable_slot_regulators(struct tegra_pcie_dw *pcie)
 		ret = regulator_enable(pcie->slot_ctl_12v);
 		if (ret < 0) {
 			dev_err(pcie->dev,
-				"Failed to enable 12V slot supply: %d\n", ret);
+				"Failed to enable 12V slot supply: %pe\n", ERR_PTR(ret));
 			goto fail_12v_enable;
 		}
 	}
@@ -1383,14 +1383,14 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
 	if (ret) {
 		dev_err(pcie->dev,
-			"Failed to enable controller %u: %d\n", pcie->cid, ret);
+			"Failed to enable controller %u: %pe\n", pcie->cid, ERR_PTR(ret));
 		return ret;
 	}
 
 	if (pcie->enable_ext_refclk) {
 		ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
 		if (ret) {
-			dev_err(pcie->dev, "Failed to init UPHY: %d\n", ret);
+			dev_err(pcie->dev, "Failed to init UPHY: %pe\n", ERR_PTR(ret));
 			goto fail_pll_init;
 		}
 	}
@@ -1401,20 +1401,20 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 
 	ret = regulator_enable(pcie->pex_ctl_supply);
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
+		dev_err(pcie->dev, "Failed to enable regulator: %pe\n", ERR_PTR(ret));
 		goto fail_reg_en;
 	}
 
 	ret = clk_prepare_enable(pcie->core_clk);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to enable core clock: %d\n", ret);
+		dev_err(pcie->dev, "Failed to enable core clock: %pe\n", ERR_PTR(ret));
 		goto fail_core_clk;
 	}
 
 	ret = reset_control_deassert(pcie->core_apb_rst);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to deassert core APB reset: %d\n",
-			ret);
+		dev_err(pcie->dev, "Failed to deassert core APB reset: %pe\n",
+			ERR_PTR(ret));
 		goto fail_core_apb_rst;
 	}
 
@@ -1431,7 +1431,7 @@ static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
 
 	ret = tegra_pcie_enable_phy(pcie);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to enable PHY: %d\n", ret);
+		dev_err(pcie->dev, "Failed to enable PHY: %pe\n", ERR_PTR(ret));
 		goto fail_phy;
 	}
 
@@ -1503,32 +1503,32 @@ static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
 
 	ret = reset_control_assert(pcie->core_rst);
 	if (ret)
-		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n", ret);
+		dev_err(pcie->dev, "Failed to assert \"core\" reset: %pe\n", ERR_PTR(ret));
 
 	tegra_pcie_disable_phy(pcie);
 
 	ret = reset_control_assert(pcie->core_apb_rst);
 	if (ret)
-		dev_err(pcie->dev, "Failed to assert APB reset: %d\n", ret);
+		dev_err(pcie->dev, "Failed to assert APB reset: %pe\n", ERR_PTR(ret));
 
 	clk_disable_unprepare(pcie->core_clk);
 
 	ret = regulator_disable(pcie->pex_ctl_supply);
 	if (ret)
-		dev_err(pcie->dev, "Failed to disable regulator: %d\n", ret);
+		dev_err(pcie->dev, "Failed to disable regulator: %pe\n", ERR_PTR(ret));
 
 	tegra_pcie_disable_slot_regulators(pcie);
 
 	if (pcie->enable_ext_refclk) {
 		ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
 		if (ret)
-			dev_err(pcie->dev, "Failed to deinit UPHY: %d\n", ret);
+			dev_err(pcie->dev, "Failed to deinit UPHY: %pe\n", ERR_PTR(ret));
 	}
 
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 	if (ret)
-		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
-			pcie->cid, ret);
+		dev_err(pcie->dev, "Failed to disable controller %d: %pe\n",
+			pcie->cid, ERR_PTR(ret));
 }
 
 static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
@@ -1545,7 +1545,7 @@ static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 
 	ret = dw_pcie_host_init(pp);
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to add PCIe port: %d\n", ret);
+		dev_err(pcie->dev, "Failed to add PCIe port: %pe\n", ERR_PTR(ret));
 		goto fail_host_init;
 	}
 
@@ -1652,20 +1652,20 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
-			ret);
+		dev_err(dev, "Failed to get runtime sync for PCIe dev: %pe\n",
+			ERR_PTR(ret));
 		goto fail_pm_get_sync;
 	}
 
 	ret = pinctrl_pm_select_default_state(dev);
 	if (ret < 0) {
-		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
+		dev_err(dev, "Failed to configure sideband pins: %pe\n", ERR_PTR(ret));
 		goto fail_pm_get_sync;
 	}
 
 	ret = tegra_pcie_init_controller(pcie);
 	if (ret < 0) {
-		dev_err(dev, "Failed to initialize controller: %d\n", ret);
+		dev_err(dev, "Failed to initialize controller: %pe\n", ERR_PTR(ret));
 		goto fail_pm_get_sync;
 	}
 
@@ -1713,7 +1713,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 				 LTSSM_STATE_PRE_DETECT,
 				 1, LTSSM_TIMEOUT);
 	if (ret)
-		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
+		dev_err(pcie->dev, "Failed to go Detect state: %pe\n", ERR_PTR(ret));
 
 	dw_pcie_ep_cleanup(&pcie->pci.ep);
 
@@ -1730,13 +1730,13 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 	if (pcie->enable_ext_refclk) {
 		ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
 		if (ret)
-			dev_err(pcie->dev, "Failed to turn off UPHY: %d\n",
-				ret);
+			dev_err(pcie->dev, "Failed to turn off UPHY: %pe\n",
+				ERR_PTR(ret));
 	}
 
 	ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
 	if (ret)
-		dev_err(pcie->dev, "Failed to turn off UPHY: %d\n", ret);
+		dev_err(pcie->dev, "Failed to turn off UPHY: %pe\n", ERR_PTR(ret));
 
 	pcie->ep_state = EP_STATE_DISABLED;
 	dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
@@ -1756,42 +1756,42 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
-			ret);
+		dev_err(dev, "Failed to get runtime sync for PCIe dev: %pe\n",
+			ERR_PTR(ret));
 		return;
 	}
 
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to enable controller %u: %d\n",
-			pcie->cid, ret);
+		dev_err(pcie->dev, "Failed to enable controller %u: %pe\n",
+			pcie->cid, ERR_PTR(ret));
 		goto fail_set_ctrl_state;
 	}
 
 	if (pcie->enable_ext_refclk) {
 		ret = tegra_pcie_bpmp_set_pll_state(pcie, true);
 		if (ret) {
-			dev_err(dev, "Failed to init UPHY for PCIe EP: %d\n",
-				ret);
+			dev_err(dev, "Failed to init UPHY for PCIe EP: %pe\n",
+				ERR_PTR(ret));
 			goto fail_pll_init;
 		}
 	}
 
 	ret = clk_prepare_enable(pcie->core_clk);
 	if (ret) {
-		dev_err(dev, "Failed to enable core clock: %d\n", ret);
+		dev_err(dev, "Failed to enable core clock: %pe\n", ERR_PTR(ret));
 		goto fail_core_clk_enable;
 	}
 
 	ret = reset_control_deassert(pcie->core_apb_rst);
 	if (ret) {
-		dev_err(dev, "Failed to deassert core APB reset: %d\n", ret);
+		dev_err(dev, "Failed to deassert core APB reset: %pe\n", ERR_PTR(ret));
 		goto fail_core_apb_rst;
 	}
 
 	ret = tegra_pcie_enable_phy(pcie);
 	if (ret) {
-		dev_err(dev, "Failed to enable PHY: %d\n", ret);
+		dev_err(dev, "Failed to enable PHY: %pe\n", ERR_PTR(ret));
 		goto fail_phy;
 	}
 
@@ -1899,7 +1899,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	ret = dw_pcie_ep_init_registers(ep);
 	if (ret) {
-		dev_err(dev, "Failed to complete initialization: %d\n", ret);
+		dev_err(dev, "Failed to complete initialization: %pe\n", ERR_PTR(ret));
 		goto fail_init_complete;
 	}
 
@@ -2044,14 +2044,14 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 
 	ret = gpiod_set_debounce(pcie->pex_rst_gpiod, PERST_DEBOUNCE_TIME);
 	if (ret < 0) {
-		dev_err(dev, "Failed to set PERST GPIO debounce time: %d\n",
-			ret);
+		dev_err(dev, "Failed to set PERST GPIO debounce time: %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = gpiod_to_irq(pcie->pex_rst_gpiod);
 	if (ret < 0) {
-		dev_err(dev, "Failed to get IRQ for PERST GPIO: %d\n", ret);
+		dev_err(dev, "Failed to get IRQ for PERST GPIO: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 	pcie->pex_rst_irq = (unsigned int)ret;
@@ -2073,7 +2073,7 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					name, (void *)pcie);
 	if (ret < 0) {
-		dev_err(dev, "Failed to request IRQ for PERST: %d\n", ret);
+		dev_err(dev, "Failed to request IRQ for PERST: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -2081,8 +2081,8 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
-		dev_err(dev, "Failed to initialize DWC Endpoint subsystem: %d\n",
-			ret);
+		dev_err(dev, "Failed to initialize DWC Endpoint subsystem: %pe\n",
+			ERR_PTR(ret));
 		pm_runtime_disable(dev);
 		return ret;
 	}
@@ -2152,15 +2152,15 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->pex_ctl_supply)) {
 		ret = PTR_ERR(pcie->pex_ctl_supply);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get regulator: %ld\n",
-				PTR_ERR(pcie->pex_ctl_supply));
+			dev_err(dev, "Failed to get regulator: %pe\n",
+				pcie->pex_ctl_supply);
 		return ret;
 	}
 
 	pcie->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(pcie->core_clk)) {
-		dev_err(dev, "Failed to get core clock: %ld\n",
-			PTR_ERR(pcie->core_clk));
+		dev_err(dev, "Failed to get core clock: %pe\n",
+			pcie->core_clk);
 		return PTR_ERR(pcie->core_clk);
 	}
 
@@ -2177,8 +2177,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	pcie->core_apb_rst = devm_reset_control_get(dev, "apb");
 	if (IS_ERR(pcie->core_apb_rst)) {
-		dev_err(dev, "Failed to get APB reset: %ld\n",
-			PTR_ERR(pcie->core_apb_rst));
+		dev_err(dev, "Failed to get APB reset: %pe\n",
+			pcie->core_apb_rst);
 		return PTR_ERR(pcie->core_apb_rst);
 	}
 
@@ -2197,7 +2197,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		if (IS_ERR(phys[i])) {
 			ret = PTR_ERR(phys[i]);
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get PHY: %d\n", ret);
+				dev_err(dev, "Failed to get PHY: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -2219,8 +2219,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	pcie->core_rst = devm_reset_control_get(dev, "core");
 	if (IS_ERR(pcie->core_rst)) {
-		dev_err(dev, "Failed to get core reset: %ld\n",
-			PTR_ERR(pcie->core_rst));
+		dev_err(dev, "Failed to get core reset: %pe\n",
+			pcie->core_rst);
 		return PTR_ERR(pcie->core_rst);
 	}
 
@@ -2247,8 +2247,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
 				       IRQF_SHARED, "tegra-pcie-intr", pcie);
 		if (ret) {
-			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
-				ret);
+			dev_err(dev, "Failed to request IRQ %d: %pe\n", pp->irq,
+				ERR_PTR(ret));
 			goto fail;
 		}
 
@@ -2266,8 +2266,8 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 						IRQF_SHARED | IRQF_ONESHOT,
 						"tegra-pcie-ep-intr", pcie);
 		if (ret) {
-			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
-				ret);
+			dev_err(dev, "Failed to request IRQ %d: %pe\n", pp->irq,
+				ERR_PTR(ret));
 			goto fail;
 		}
 
@@ -2364,7 +2364,7 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 
 	ret = tegra_pcie_dw_host_init(&pcie->pci.pp);
 	if (ret < 0) {
-		dev_err(dev, "Failed to init host: %d\n", ret);
+		dev_err(dev, "Failed to init host: %pe\n", ERR_PTR(ret));
 		goto fail_host_init;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index a2b844268e28..9a3d5445f181 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -388,7 +388,7 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
 	if (IS_ERR(priv->phy)) {
 		ret = PTR_ERR(priv->phy);
-		dev_err(dev, "Failed to get phy (%d)\n", ret);
+		dev_err(dev, "Failed to get phy: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 71ecd7ddcc8a..f34e0e163642 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1743,14 +1743,14 @@ static int advk_pcie_setup_phy(struct advk_pcie *pcie)
 
 	/* Old bindings miss the PHY handle */
 	if (IS_ERR(pcie->phy)) {
-		dev_warn(dev, "PHY unavailable (%ld)\n", PTR_ERR(pcie->phy));
+		dev_warn(dev, "PHY unavailable: %pe\n", pcie->phy);
 		pcie->phy = NULL;
 		return 0;
 	}
 
 	ret = advk_pcie_enable_phy(pcie);
 	if (ret)
-		dev_err(dev, "Failed to initialize PHY (%d)\n", ret);
+		dev_err(dev, "Failed to initialize PHY: %pe\n", ERR_PTR(ret));
 
 	return ret;
 }
@@ -1863,7 +1863,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get reset-gpio: %i\n", ret);
+			dev_err(dev, "Failed to get reset-gpio: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index ffdeed25e961..b5127dbdd313 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -502,7 +502,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 
 	ret = pci_scan_root_bus_bridge(host);
 	if (ret) {
-		dev_err(dev, "failed to scan host: %d\n", ret);
+		dev_err(dev, "failed to scan host: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 	p->bus = host->bus;
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 038d974a318e..ead171db29b7 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -946,7 +946,7 @@ static int tegra_pcie_phy_enable(struct tegra_pcie *pcie)
 	/* wait for the PLL to lock */
 	err = tegra_pcie_pll_wait(pcie, 500);
 	if (err < 0) {
-		dev_err(dev, "PLL failed to lock: %d\n", err);
+		dev_err(dev, "PLL failed to lock: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -997,7 +997,7 @@ static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
 	for (i = 0; i < port->lanes; i++) {
 		err = phy_power_on(port->phys[i]);
 		if (err < 0) {
-			dev_err(dev, "failed to power on PHY#%u: %d\n", i, err);
+			dev_err(dev, "failed to power on PHY#%u: %pe\n", i, ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1014,8 +1014,8 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
 	for (i = 0; i < port->lanes; i++) {
 		err = phy_power_off(port->phys[i]);
 		if (err < 0) {
-			dev_err(dev, "failed to power off PHY#%u: %d\n", i,
-				err);
+			dev_err(dev, "failed to power off PHY#%u: %pe\n", i,
+				ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1036,7 +1036,7 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 			err = tegra_pcie_phy_enable(pcie);
 
 		if (err < 0)
-			dev_err(dev, "failed to power on PHY: %d\n", err);
+			dev_err(dev, "failed to power on PHY: %pe\n", ERR_PTR(err));
 
 		return err;
 	}
@@ -1045,8 +1045,8 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
 		err = tegra_pcie_port_phy_power_on(port);
 		if (err < 0) {
 			dev_err(dev,
-				"failed to power on PCIe port %u PHY: %d\n",
-				port->index, err);
+				"failed to power on PCIe port %u PHY: %pe\n",
+				port->index, ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1067,7 +1067,7 @@ static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 			err = tegra_pcie_phy_disable(pcie);
 
 		if (err < 0)
-			dev_err(dev, "failed to power off PHY: %d\n", err);
+			dev_err(dev, "failed to power off PHY: %pe\n", ERR_PTR(err));
 
 		return err;
 	}
@@ -1076,8 +1076,8 @@ static int tegra_pcie_phy_power_off(struct tegra_pcie *pcie)
 		err = tegra_pcie_port_phy_power_off(port);
 		if (err < 0) {
 			dev_err(dev,
-				"failed to power off PCIe port %u PHY: %d\n",
-				port->index, err);
+				"failed to power off PCIe port %u PHY: %pe\n",
+				port->index, ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1167,7 +1167,7 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 
 	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
-		dev_warn(dev, "failed to disable regulators: %d\n", err);
+		dev_warn(dev, "failed to disable regulators: %pe\n", ERR_PTR(err));
 }
 
 static int tegra_pcie_power_on(struct tegra_pcie *pcie)
@@ -1186,38 +1186,38 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 	/* enable regulators */
 	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
 	if (err < 0)
-		dev_err(dev, "failed to enable regulators: %d\n", err);
+		dev_err(dev, "failed to enable regulators: %pe\n", ERR_PTR(err));
 
 	if (!dev->pm_domain) {
 		err = tegra_powergate_power_on(TEGRA_POWERGATE_PCIE);
 		if (err) {
-			dev_err(dev, "failed to power ungate: %d\n", err);
+			dev_err(dev, "failed to power ungate: %pe\n", ERR_PTR(err));
 			goto regulator_disable;
 		}
 		err = tegra_powergate_remove_clamping(TEGRA_POWERGATE_PCIE);
 		if (err) {
-			dev_err(dev, "failed to remove clamp: %d\n", err);
+			dev_err(dev, "failed to remove clamp: %pe\n", ERR_PTR(err));
 			goto powergate;
 		}
 	}
 
 	err = clk_prepare_enable(pcie->afi_clk);
 	if (err < 0) {
-		dev_err(dev, "failed to enable AFI clock: %d\n", err);
+		dev_err(dev, "failed to enable AFI clock: %pe\n", ERR_PTR(err));
 		goto powergate;
 	}
 
 	if (soc->has_cml_clk) {
 		err = clk_prepare_enable(pcie->cml_clk);
 		if (err < 0) {
-			dev_err(dev, "failed to enable CML clock: %d\n", err);
+			dev_err(dev, "failed to enable CML clock: %pe\n", ERR_PTR(err));
 			goto disable_afi_clk;
 		}
 	}
 
 	err = clk_prepare_enable(pcie->pll_e);
 	if (err < 0) {
-		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
+		dev_err(dev, "failed to enable PLLE clock: %pe\n", ERR_PTR(err));
 		goto disable_cml_clk;
 	}
 
@@ -1303,13 +1303,13 @@ static int tegra_pcie_phys_get_legacy(struct tegra_pcie *pcie)
 	pcie->phy = devm_phy_optional_get(dev, "pcie");
 	if (IS_ERR(pcie->phy)) {
 		err = PTR_ERR(pcie->phy);
-		dev_err(dev, "failed to get PHY: %d\n", err);
+		dev_err(dev, "failed to get PHY: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = phy_init(pcie->phy);
 	if (err < 0) {
-		dev_err(dev, "failed to initialize PHY: %d\n", err);
+		dev_err(dev, "failed to initialize PHY: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
@@ -1350,15 +1350,15 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
 	for (i = 0; i < port->lanes; i++) {
 		phy = devm_of_phy_optional_get_index(dev, port->np, "pcie", i);
 		if (IS_ERR(phy)) {
-			dev_err(dev, "failed to get PHY#%u: %ld\n", i,
-				PTR_ERR(phy));
+			dev_err(dev, "failed to get PHY#%u: %pe\n", i,
+				phy);
 			return PTR_ERR(phy);
 		}
 
 		err = phy_init(phy);
 		if (err < 0) {
-			dev_err(dev, "failed to initialize PHY#%u: %d\n", i,
-				err);
+			dev_err(dev, "failed to initialize PHY#%u: %pe\n", i,
+				ERR_PTR(err));
 			return err;
 		}
 
@@ -1396,7 +1396,7 @@ static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
 	if (pcie->legacy_phy) {
 		err = phy_exit(pcie->phy);
 		if (err < 0)
-			dev_err(dev, "failed to teardown PHY: %d\n", err);
+			dev_err(dev, "failed to teardown PHY: %pe\n", ERR_PTR(err));
 		return;
 	}
 
@@ -1404,8 +1404,8 @@ static void tegra_pcie_phys_put(struct tegra_pcie *pcie)
 		for (i = 0; i < port->lanes; i++) {
 			err = phy_exit(port->phys[i]);
 			if (err < 0)
-				dev_err(dev, "failed to teardown PHY#%u: %d\n",
-					i, err);
+				dev_err(dev, "failed to teardown PHY#%u: %pe\n",
+					i, ERR_PTR(err));
 		}
 	}
 }
@@ -1420,20 +1420,20 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 
 	err = tegra_pcie_clocks_get(pcie);
 	if (err) {
-		dev_err(dev, "failed to get clocks: %d\n", err);
+		dev_err(dev, "failed to get clocks: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = tegra_pcie_resets_get(pcie);
 	if (err) {
-		dev_err(dev, "failed to get resets: %d\n", err);
+		dev_err(dev, "failed to get resets: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	if (soc->program_uphy) {
 		err = tegra_pcie_phys_get(pcie);
 		if (err < 0) {
-			dev_err(dev, "failed to get PHYs: %d\n", err);
+			dev_err(dev, "failed to get PHYs: %pe\n", ERR_PTR(err));
 			return err;
 		}
 	}
@@ -1477,7 +1477,7 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 
 	err = request_irq(pcie->irq, tegra_pcie_isr, IRQF_SHARED, "PCIE", pcie);
 	if (err) {
-		dev_err(dev, "failed to register IRQ: %d\n", err);
+		dev_err(dev, "failed to register IRQ: %pe\n", ERR_PTR(err));
 		goto phys_put;
 	}
 
@@ -2127,7 +2127,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
-			dev_err(dev, "failed to parse address: %d\n", err);
+			dev_err(dev, "failed to parse address: %pe\n", ERR_PTR(err));
 			goto err_node_put;
 		}
 
@@ -2143,8 +2143,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 		err = of_property_read_u32(port, "nvidia,num-lanes", &value);
 		if (err < 0) {
-			dev_err(dev, "failed to parse # of lanes: %d\n",
-				err);
+			dev_err(dev, "failed to parse # of lanes: %pe\n",
+				ERR_PTR(err));
 			goto err_node_put;
 		}
 
@@ -2172,7 +2172,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 
 		err = of_address_to_resource(port, 0, &rp->regs);
 		if (err < 0) {
-			dev_err(dev, "failed to parse address: %d\n", err);
+			dev_err(dev, "failed to parse address: %pe\n", ERR_PTR(err));
 			goto err_node_put;
 		}
 
@@ -2640,20 +2640,20 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	err = tegra_pcie_get_resources(pcie);
 	if (err < 0) {
-		dev_err(dev, "failed to request resources: %d\n", err);
+		dev_err(dev, "failed to request resources: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = tegra_pcie_msi_setup(pcie);
 	if (err < 0) {
-		dev_err(dev, "failed to enable MSI support: %d\n", err);
+		dev_err(dev, "failed to enable MSI support: %pe\n", ERR_PTR(err));
 		goto put_resources;
 	}
 
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
-		dev_err(dev, "fail to enable pcie controller: %d\n", err);
+		dev_err(dev, "fail to enable pcie controller: %pe\n", ERR_PTR(err));
 		goto pm_runtime_put;
 	}
 
@@ -2662,7 +2662,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 
 	err = pci_host_probe(host);
 	if (err < 0) {
-		dev_err(dev, "failed to register host: %d\n", err);
+		dev_err(dev, "failed to register host: %pe\n", ERR_PTR(err));
 		goto pm_runtime_put;
 	}
 
@@ -2723,7 +2723,7 @@ static int tegra_pcie_pm_suspend(struct device *dev)
 	if (pcie->soc->program_uphy) {
 		err = tegra_pcie_phy_power_off(pcie);
 		if (err < 0)
-			dev_err(dev, "failed to power off PHY(s): %d\n", err);
+			dev_err(dev, "failed to power off PHY(s): %pe\n", ERR_PTR(err));
 	}
 
 	reset_control_assert(pcie->pex_rst);
@@ -2745,13 +2745,13 @@ static int tegra_pcie_pm_resume(struct device *dev)
 
 	err = tegra_pcie_power_on(pcie);
 	if (err) {
-		dev_err(dev, "tegra pcie power on fail: %d\n", err);
+		dev_err(dev, "tegra pcie power on fail: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = pinctrl_pm_select_default_state(dev);
 	if (err < 0) {
-		dev_err(dev, "failed to disable PCIe IO DPD: %d\n", err);
+		dev_err(dev, "failed to disable PCIe IO DPD: %pe\n", ERR_PTR(err));
 		goto poweroff;
 	}
 
@@ -2763,7 +2763,7 @@ static int tegra_pcie_pm_resume(struct device *dev)
 
 	err = clk_prepare_enable(pcie->pex_clk);
 	if (err) {
-		dev_err(dev, "failed to enable PEX clock: %d\n", err);
+		dev_err(dev, "failed to enable PEX clock: %pe\n", ERR_PTR(err));
 		goto pex_dpd_enable;
 	}
 
@@ -2772,7 +2772,7 @@ static int tegra_pcie_pm_resume(struct device *dev)
 	if (pcie->soc->program_uphy) {
 		err = tegra_pcie_phy_power_on(pcie);
 		if (err < 0) {
-			dev_err(dev, "failed to power on PHY(s): %d\n", err);
+			dev_err(dev, "failed to power on PHY(s): %pe\n", ERR_PTR(err));
 			goto disable_pex_clk;
 		}
 	}
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 8e457fa450a2..9cdc0b24e00d 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -206,8 +206,8 @@ static int xgene_get_csr_resource(struct acpi_device *adev,
 				     acpi_dev_filter_resource_type_cb,
 				     (void *) flags);
 	if (ret < 0) {
-		dev_err(dev, "failed to parse _CRS method, error code %d\n",
-			ret);
+		dev_err(dev, "failed to parse _CRS method, error code %pe\n",
+			ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 137fb8570ba2..9670a31a02c8 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -1175,7 +1175,7 @@ static int mc_host_probe(struct platform_device *pdev)
 
 	ret = mc_pcie_init_clks(dev);
 	if (ret) {
-		dev_err(dev, "failed to get clock resources, error %d\n", ret);
+		dev_err(dev, "failed to get clock resources, error: %pe\n", ERR_PTR(ret));
 		return -ENODEV;
 	}
 
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 996077ab7cfd..3dfe6729e3ed 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -78,7 +78,7 @@ static int rcar_pcie_wakeup(struct device *pcie_dev, void __iomem *pcie_base)
 		writel(L1IATN, pcie_base + PMCTLR);
 		ret = readl_poll_timeout_atomic(pcie_base + PMSR, val,
 						val & L1FAEG, 10, 1000);
-		WARN(ret, "Timeout waiting for L1 link state, ret=%d\n", ret);
+		WARN(ret, "Timeout waiting for L1 link state, ret=%pe\n", ERR_PTR(ret));
 		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
 	}
 
@@ -782,7 +782,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       rcar_msi_bottom_chip.name, host);
 	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
+		dev_err(dev, "failed to request IRQ: %pe\n", ERR_PTR(err));
 		goto err;
 	}
 
@@ -790,7 +790,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       rcar_msi_bottom_chip.name, host);
 	if (err < 0) {
-		dev_err(dev, "failed to request IRQ: %d\n", err);
+		dev_err(dev, "failed to request IRQ: %pe\n", ERR_PTR(err));
 		goto err;
 	}
 
@@ -996,13 +996,13 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	err = rcar_pcie_get_resources(host);
 	if (err < 0) {
-		dev_err(dev, "failed to request resources: %d\n", err);
+		dev_err(dev, "failed to request resources: %pe\n", ERR_PTR(err));
 		goto err_pm_put;
 	}
 
 	err = clk_prepare_enable(host->bus_clk);
 	if (err) {
-		dev_err(dev, "failed to enable bus clock: %d\n", err);
+		dev_err(dev, "failed to enable bus clock: %pe\n", ERR_PTR(err));
 		goto err_unmap_msi_irqs;
 	}
 
@@ -1031,8 +1031,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		err = rcar_pcie_enable_msi(host);
 		if (err < 0) {
 			dev_err(dev,
-				"failed to enable MSI support: %d\n",
-				err);
+				"failed to enable MSI support: %pe\n",
+				ERR_PTR(err));
 			goto err_phy_shutdown;
 		}
 	}
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 0ef2e622d36e..10bd6aec67bd 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -169,51 +169,51 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	err = reset_control_assert(rockchip->aclk_rst);
 	if (err) {
-		dev_err(dev, "assert aclk_rst err %d\n", err);
+		dev_err(dev, "assert aclk_rst err: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = reset_control_assert(rockchip->pclk_rst);
 	if (err) {
-		dev_err(dev, "assert pclk_rst err %d\n", err);
+		dev_err(dev, "assert pclk_rst err: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = reset_control_assert(rockchip->pm_rst);
 	if (err) {
-		dev_err(dev, "assert pm_rst err %d\n", err);
+		dev_err(dev, "assert pm_rst err: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	for (i = 0; i < MAX_LANE_NUM; i++) {
 		err = phy_init(rockchip->phys[i]);
 		if (err) {
-			dev_err(dev, "init phy%d err %d\n", i, err);
+			dev_err(dev, "init phy%d err: %pe\n", i, ERR_PTR(err));
 			goto err_exit_phy;
 		}
 	}
 
 	err = reset_control_assert(rockchip->core_rst);
 	if (err) {
-		dev_err(dev, "assert core_rst err %d\n", err);
+		dev_err(dev, "assert core_rst err: %pe\n", ERR_PTR(err));
 		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_rst);
 	if (err) {
-		dev_err(dev, "assert mgmt_rst err %d\n", err);
+		dev_err(dev, "assert mgmt_rst err: %pe\n", ERR_PTR(err));
 		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_sticky_rst);
 	if (err) {
-		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
+		dev_err(dev, "assert mgmt_sticky_rst err: %pe\n", ERR_PTR(err));
 		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->pipe_rst);
 	if (err) {
-		dev_err(dev, "assert pipe_rst err %d\n", err);
+		dev_err(dev, "assert pipe_rst err: %pe\n", ERR_PTR(err));
 		goto err_exit_phy;
 	}
 
@@ -221,19 +221,19 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	err = reset_control_deassert(rockchip->pm_rst);
 	if (err) {
-		dev_err(dev, "deassert pm_rst err %d\n", err);
+		dev_err(dev, "deassert pm_rst err: %pe\n", ERR_PTR(err));
 		goto err_exit_phy;
 	}
 
 	err = reset_control_deassert(rockchip->aclk_rst);
 	if (err) {
-		dev_err(dev, "deassert aclk_rst err %d\n", err);
+		dev_err(dev, "deassert aclk_rst err: %pe\n", ERR_PTR(err));
 		goto err_exit_phy;
 	}
 
 	err = reset_control_deassert(rockchip->pclk_rst);
 	if (err) {
-		dev_err(dev, "deassert pclk_rst err %d\n", err);
+		dev_err(dev, "deassert pclk_rst err: %pe\n", ERR_PTR(err));
 		goto err_exit_phy;
 	}
 
@@ -257,7 +257,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	for (i = 0; i < MAX_LANE_NUM; i++) {
 		err = phy_power_on(rockchip->phys[i]);
 		if (err) {
-			dev_err(dev, "power on phy%d err %d\n", i, err);
+			dev_err(dev, "power on phy%d err: %pe\n", i, ERR_PTR(err));
 			goto err_power_off_phy;
 		}
 	}
@@ -268,7 +268,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 				 RK_PHY_PLL_LOCK_SLEEP_US,
 				 RK_PHY_PLL_LOCK_TIMEOUT_US);
 	if (err) {
-		dev_err(dev, "PHY PLLs could not lock, %d\n", err);
+		dev_err(dev, "PHY PLLs could not lock: %pe\n", ERR_PTR(err));
 		goto err_power_off_phy;
 	}
 
@@ -278,25 +278,25 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	 */
 	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
 	if (err) {
-		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
+		dev_err(dev, "deassert mgmt_sticky_rst err: %pe\n", ERR_PTR(err));
 		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->core_rst);
 	if (err) {
-		dev_err(dev, "deassert core_rst err %d\n", err);
+		dev_err(dev, "deassert core_rst err: %pe\n", ERR_PTR(err));
 		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->mgmt_rst);
 	if (err) {
-		dev_err(dev, "deassert mgmt_rst err %d\n", err);
+		dev_err(dev, "deassert mgmt_rst err: %pe\n", ERR_PTR(err));
 		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->pipe_rst);
 	if (err) {
-		dev_err(dev, "deassert pipe_rst err %d\n", err);
+		dev_err(dev, "deassert pipe_rst err: %pe\n", ERR_PTR(err));
 		goto err_power_off_phy;
 	}
 
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..7bc123865b1f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -943,7 +943,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 					       struct pci_dev, bus_list);
 			ret = pci_reset_bus(dev);
 			if (ret)
-				pci_warn(dev, "can't reset device: %d\n", ret);
+				pci_warn(dev, "can't reset device: %pe\n", ERR_PTR(ret));
 
 			break;
 		}
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 652d63df9d22..8019a7140028 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -512,8 +512,8 @@ static struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev,
 	 */
 	rc = pci_doe_cache_protocols(doe_mb);
 	if (rc) {
-		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
-			doe_mb->cap_offset, rc);
+		pci_err(pdev, "[%x] failed to cache protocols : %pe\n",
+			doe_mb->cap_offset, ERR_PTR(rc));
 		goto err_cancel;
 	}
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 2c54d80107cf..78d64eecfa04 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -738,14 +738,14 @@ static int pci_epf_mhi_core_init(struct pci_epf *epf)
 	ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
 			      order_base_2(info->msi_count));
 	if (ret) {
-		dev_err(dev, "Failed to set MSI configuration: %d\n", ret);
+		dev_err(dev, "Failed to set MSI configuration: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
 	ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no,
 				   epf->header);
 	if (ret) {
-		dev_err(dev, "Failed to set Configuration header: %d\n", ret);
+		dev_err(dev, "Failed to set Configuration header: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
@@ -768,7 +768,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	if (info->flags & MHI_EPF_USE_DMA) {
 		ret = pci_epf_mhi_dma_init(epf_mhi);
 		if (ret) {
-			dev_err(dev, "Failed to initialize DMA: %d\n", ret);
+			dev_err(dev, "Failed to initialize DMA: %pe\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -794,7 +794,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	/* Register the MHI EP controller */
 	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
 	if (ret) {
-		dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
+		dev_err(dev, "Failed to register MHI EP controller: %pe\n", ERR_PTR(ret));
 		if (info->flags & MHI_EPF_USE_DMA)
 			pci_epf_mhi_dma_deinit(epf_mhi);
 		return ret;
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d21..d807b0329805 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -2129,7 +2129,7 @@ static int __init epf_ntb_init(void)
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
-		pr_err("Failed to register pci epf ntb driver --> %d\n", ret);
+		pr_err("Failed to register pci epf ntb driver: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 977fb79c1567..15e745dcdc40 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -167,7 +167,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 
 	ret = dma_submit_error(epf_test->transfer_cookie);
 	if (ret) {
-		dev_err(dev, "Failed to do DMA tx_submit %d\n", ret);
+		dev_err(dev, "Failed to do DMA tx_submit: %pe\n", ERR_PTR(ret));
 		goto terminate;
 	}
 
@@ -949,7 +949,7 @@ static int __init pci_epf_test_init(void)
 	ret = pci_epf_register_driver(&test_driver);
 	if (ret) {
 		destroy_workqueue(kpcitest_workqueue);
-		pr_err("Failed to register pci epf test driver --> %d\n", ret);
+		pr_err("Failed to register pci epf test driver: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8e779eecd62d..de52f0613078 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1430,7 +1430,7 @@ static int __init epf_ntb_init(void)
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
-		pr_err("Failed to register pci epf ntb driver --> %d\n", ret);
+		pr_err("Failed to register pci epf ntb driver: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 3b21e28f9b59..a44437aaa4bc 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -727,8 +727,8 @@ static int __init pci_ep_cfs_init(void)
 
 	ret = configfs_register_subsystem(&pci_ep_cfs_subsys);
 	if (ret) {
-		pr_err("Error %d while registering subsystem %s\n",
-		       ret, root->cg_item.ci_namebuf);
+		pr_err("Error while registering subsystem %s: %pe\n",
+		       root->cg_item.ci_namebuf, ERR_PTR(ret));
 		goto err;
 	}
 
@@ -736,8 +736,8 @@ static int __init pci_ep_cfs_init(void)
 							  &pci_functions_type);
 	if (IS_ERR(functions_group)) {
 		ret = PTR_ERR(functions_group);
-		pr_err("Error %d while registering functions group\n",
-		       ret);
+		pr_err("Error while registering functions group: %pe\n",
+		       ERR_PTR(ret));
 		goto err_functions_group;
 	}
 
@@ -746,8 +746,8 @@ static int __init pci_ep_cfs_init(void)
 						&pci_controllers_type);
 	if (IS_ERR(controllers_group)) {
 		ret = PTR_ERR(controllers_group);
-		pr_err("Error %d while registering controllers group\n",
-		       ret);
+		pr_err("Error while registering controllers group: %pe\n",
+		       ERR_PTR(ret));
 		goto err_controllers_group;
 	}
 
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 323f2a60ab16..08146b5c5d01 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -77,8 +77,8 @@ int pci_epf_bind(struct pci_epf *epf)
 		vfunc_no = epf_vf->vfunc_no;
 
 		if (vfunc_no < 1) {
-			dev_err(dev, "Invalid virtual function number\n");
 			ret = -EINVAL;
+			dev_err(dev, "Invalid virtual function number: %pe\n", ERR_PTR(ret));
 			goto ret;
 		}
 
@@ -86,15 +86,15 @@ int pci_epf_bind(struct pci_epf *epf)
 		func_no = epf->func_no;
 		if (!IS_ERR_OR_NULL(epc)) {
 			if (!epc->max_vfs) {
-				dev_err(dev, "No support for virt function\n");
 				ret = -EINVAL;
+				dev_err(dev, "No support for virt function: %pe\n", ERR_PTR(ret));
 				goto ret;
 			}
 
 			if (vfunc_no > epc->max_vfs[func_no]) {
-				dev_err(dev, "PF%d: Exceeds max vfunc number\n",
-					func_no);
 				ret = -EINVAL;
+				dev_err(dev, "PF%d: Exceeds max vfunc number: %pe\n",
+					func_no, ERR_PTR(ret));
 				goto ret;
 			}
 		}
@@ -103,15 +103,15 @@ int pci_epf_bind(struct pci_epf *epf)
 		func_no = epf->sec_epc_func_no;
 		if (!IS_ERR_OR_NULL(epc)) {
 			if (!epc->max_vfs) {
-				dev_err(dev, "No support for virt function\n");
 				ret = -EINVAL;
+				dev_err(dev, "No support for virt function: %pe\n", ERR_PTR(ret));
 				goto ret;
 			}
 
 			if (vfunc_no > epc->max_vfs[func_no]) {
-				dev_err(dev, "PF%d: Exceeds max vfunc number\n",
-					func_no);
 				ret = -EINVAL;
+				dev_err(dev, "PF%d: Exceeds max vfunc number: %pe\n",
+					func_no, ERR_PTR(ret));
 				goto ret;
 			}
 		}
@@ -535,7 +535,7 @@ static int __init pci_epf_init(void)
 
 	ret = bus_register(&pci_epf_bus_type);
 	if (ret) {
-		pr_err("failed to register pci epf bus --> %d\n", ret);
+		pr_err("failed to register pci epf bus: %pe\n", ERR_PTR(ret));
 		return ret;
 	}
 
diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index 9dad14e80bcf..0f5523666e85 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -277,7 +277,7 @@ int acpiphp_register_hotplug_slot(struct acpiphp_slot *acpiphp_slot,
 	if (retval == -EBUSY)
 		goto error_slot;
 	if (retval) {
-		pr_err("pci_hp_register failed with error %d\n", retval);
+		pr_err("pci_hp_register failed with error: %pe\n", ERR_PTR(retval));
 		goto error_slot;
 	}
 
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ddd55ad97a58..c1ccff9c282e 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -81,7 +81,7 @@ static int init_slot(struct controller *ctrl)
 	retval = pci_hp_initialize(&ctrl->hotplug_slot,
 				   ctrl->pcie->port->subordinate, 0, name);
 	if (retval) {
-		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
+		ctrl_err(ctrl, "pci_hp_initialize failed with error: %pe\n", ERR_PTR(retval));
 		kfree(ops);
 	}
 	return retval;
@@ -210,21 +210,21 @@ static int pciehp_probe(struct pcie_device *dev)
 		if (rc == -EBUSY)
 			ctrl_warn(ctrl, "Slot already registered by another hotplug driver\n");
 		else
-			ctrl_err(ctrl, "Slot initialization failed (%d)\n", rc);
+			ctrl_err(ctrl, "Slot initialization failed: %pe\n", ERR_PTR(rc));
 		goto err_out_release_ctlr;
 	}
 
 	/* Enable events after we have setup the data structures */
 	rc = pcie_init_notification(ctrl);
 	if (rc) {
-		ctrl_err(ctrl, "Notification initialization failed (%d)\n", rc);
+		ctrl_err(ctrl, "Notification initialization failed: %d\n", rc);
 		goto err_out_free_ctrl_slot;
 	}
 
 	/* Publish to user space */
 	rc = pci_hp_add(&ctrl->hotplug_slot);
 	if (rc) {
-		ctrl_err(ctrl, "Publication to user space failed (%d)\n", rc);
+		ctrl_err(ctrl, "Publication to user space failed: %pe\n", ERR_PTR(rc));
 		goto err_out_shutdown_notification;
 	}
 
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 56c7795ed890..b4e3cef70bf6 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -104,8 +104,8 @@ static int init_slots(struct controller *ctrl)
 		retval = pci_hp_register(hotplug_slot,
 				ctrl->pci_dev->subordinate, slot->device, name);
 		if (retval) {
-			ctrl_err(ctrl, "pci_hp_register failed with error %d\n",
-				 retval);
+			ctrl_err(ctrl, "pci_hp_register failed with error: %pe\n",
+				 ERR_PTR(retval));
 			goto error_slotwq;
 		}
 
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..2163ee1eda46 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -518,7 +518,7 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 		pr_warn_once("%s: possibly some PCI slots don't have level triggered interrupts capability\n",
 			__func__);
 	} else {
-		dev_err(&pdev->dev, "%s: failed with rc=%d\n", __func__, rc);
+		dev_err(&pdev->dev, "%s: failed with rc=%pe\n", __func__, ERR_PTR(rc));
 	}
 	return rc;
 }
@@ -573,8 +573,8 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 		case IORESOURCE_IO:
 			err = devm_pci_remap_iospace(dev, res, iobase);
 			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
+				dev_warn(dev, "failed to map resource %pR with error: %pe\n",
+					 res, ERR_PTR(err));
 				resource_list_destroy_entry(win);
 			}
 			break;
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17f..bbe409ce5d97 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1313,8 +1313,8 @@ static int pci_pm_runtime_suspend(struct device *dev)
 				pm->runtime_suspend, error);
 			return error;
 		} else if (error) {
-			pci_err(pci_dev, "can't suspend (%ps returned %d)\n",
-				pm->runtime_suspend, error);
+			pci_err(pci_dev, "can't suspend: %ps returned %pe)\n",
+				pm->runtime_suspend, ERR_PTR(error));
 			return error;
 		}
 	}
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a668820696dc..789c44d33b1b 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -427,8 +427,8 @@ static int dpc_probe(struct pcie_device *dev)
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
 	if (status) {
-		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
-			 status);
+		pci_warn(pdev, "request IRQ%d failed: %pe\n", dev->irq,
+			 ERR_PTR(status));
 		return status;
 	}
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 568410e64ce6..cd856a42801e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6019,7 +6019,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 		pci_info(pdev, FW_BUG "GPU left initialized by EFI, resetting\n");
 		ret = pci_reset_bus(pdev);
 		if (ret < 0)
-			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
+			pci_err(pdev, "Failed to reset GPU: %pe\n", ERR_PTR(ret));
 	}
 
 	iounmap(map);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 909e6a7c3cc3..75fdfdbadeef 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2221,7 +2221,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 enable_all:
 	retval = pci_reenable_device(bridge);
 	if (retval)
-		pci_err(bridge, "Error reenabling bridge (%d)\n", retval);
+		pci_err(bridge, "Error reenabling bridge: %pe\n", ERR_PTR(retval));
 	pci_set_master(bridge);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 0f87cade10f7..638b5130215d 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -343,8 +343,8 @@ void pci_hp_create_module_link(struct pci_slot *pci_slot)
 		return;
 	ret = sysfs_create_link(&pci_slot->kobj, kobj, "module");
 	if (ret)
-		dev_err(&pci_slot->bus->dev, "Error creating sysfs link (%d)\n",
-			ret);
+		dev_err(&pci_slot->bus->dev, "Error creating sysfs link: %pe\n",
+			ERR_PTR(ret));
 	kobject_put(kobj);
 }
 EXPORT_SYMBOL_GPL(pci_hp_create_module_link);
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..4e3daf243cb5 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1542,7 +1542,7 @@ static int __init vga_arb_device_init(void)
 
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
-		pr_err("error %d registering device\n", rc);
+		pr_err("error registering device: %pe\n", ERR_PTR(rc));
 
 	bus_register_notifier(&pci_bus_type, &pci_notifier);
 
-- 
2.25.1


