Return-Path: <linux-pci+bounces-9226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8783916570
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 12:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCE31C21C03
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8601494A8;
	Tue, 25 Jun 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pWPexEsP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727251474D0
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312149; cv=none; b=uEj1rqopEMs++behBYNGRoaUvRSSlTB16U3PdA2PGVCfZUBLx81IIXzC8MChzrDn1L0ze0ma2sQUZsD/h4xaAoHeJfZyWYbEzK2OSPJDncqd7S1TN7PQ/5zhffq49p4lg6LA0GrOLjr81hwl5N1j4KJYv8LRA0GAxFeTK4ErKcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312149; c=relaxed/simple;
	bh=6KrXYEf8wGFjaLshNTiZtHaSZaaNoK9JMgiPMRH30qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=GnY89hAAv0ELvN93VHG7EoGeSweAsYeWsVHCqnArj/rOFwRNKQ/7ujuzFkNRVYjfaoCWFhiPFfZ1zKwoFbhxkL9YqR2qf23y1w5qH4AQ+TZX1mPd3NCMlq0S2dcr1yMoj90uvBYWUi39C40SH3q+dMGl/du9eYxoyken3gUEbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pWPexEsP; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240625104217epoutp02c52af23b9497b59bf509a05ae06a0ce8~cOUeSR_Ps1813418134epoutp02g
	for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2024 10:42:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240625104217epoutp02c52af23b9497b59bf509a05ae06a0ce8~cOUeSR_Ps1813418134epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719312137;
	bh=6yld1bCPr74Qe1sN64WqEsgYrzcBqzUgAazHIDLZ5F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWPexEsPbnCpzj5aMPn2MzuCWkAG4Q9KorExlc/Yx5dZUl4nPpQsl1LadCjcLj0DF
	 VsRUxw7R5kI4YATGo1SyGYXpZAcNrzWrfuhvv0Z82Aa+jC8GOoDo+PI3kQdMCCZGga
	 mgwexzFZTJHCk3jN20rf7V2puSGYJMwnpVkcLZBg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240625104216epcas5p1dda466c739eec497c2087cb659fa9295~cOUd23bbv0880508805epcas5p1L;
	Tue, 25 Jun 2024 10:42:16 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W7hGt49Wdz4x9Q2; Tue, 25 Jun
	2024 10:42:14 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.AB.07307.60F9A766; Tue, 25 Jun 2024 19:42:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240625094438epcas5p2760f4d1537d86541940177543cea5aa8~cNiJW_IqN1995319953epcas5p2L;
	Tue, 25 Jun 2024 09:44:38 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240625094438epsmtrp2fefc84e91c9c0e5e7a9bbba1bf545a49~cNiJWDRb31814418144epsmtrp2t;
	Tue, 25 Jun 2024 09:44:38 +0000 (GMT)
X-AuditID: b6c32a44-18dff70000011c8b-bb-667a9f06762f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.9E.18846.6819A766; Tue, 25 Jun 2024 18:44:38 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240625094436epsmtip18c17029cbd899d460df60f24ed25d3b9~cNiHB-zKt0553505535epsmtip1H;
	Tue, 25 Jun 2024 09:44:36 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	fancer.lancer@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	conor.dooley@microchip.com, pankaj.dubey@samsung.com, gost.dev@samsung.com,
	Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 1/3] PCI: dwc: Add support for vendor specific capability
 search
Date: Tue, 25 Jun 2024 15:08:11 +0530
Message-Id: <20240625093813.112555-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240625093813.112555-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmpi7b/Ko0g0kX5CyWNGVYTNm0g91i
	Q8ccVoubB3YyWaz4MpPdoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5LJ6vFoq1f2C3+7wHq6D1c
	a/F172c2Bz6PnbPusnss2FTqsWlVJ5vHnWt72DyeXJnO5HHnx1JGj29nJrJ49G1ZxejxeZNc
	AGdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0OlK
	CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DC
	hOyMOf1PWAve8FVsWfuKqYHxFU8XIweHhICJxPyepC5GTg4hgd2MEo9fKXYxcgHZnxgl/r0/
	xQ7n9K49wwpSBdJw9/4nRojETkaJR/3vmCHaW5kkLu0zA7HZBLQkGr92gcVFBKwlDrdvYQNp
	YBbYxSTR8+QcI0hCWCBIYtHK50wgNouAqsTBeXfYQGxeoIZ7X14wQmyTl1i94QAzyKmcAjYS
	Ey8rgcyREJjIIbF16lcmiBoXiaaGU2wQtrDEq+Nb2CFsKYnP7/ZCxdMlVm6ewQxh50h827wE
	qtde4sCVOSwg85kFNCXW79KHCMtKTD21DqyEWYBPovf3E6hyXokd82BsZYkvf/ewQNiSEvOO
	XYYGkIfEh72v2SAB1M8o8fzaG8YJjHKzEFYsYGRcxSiZWlCcm56abFpgmJdaDo+z5PzcTYzg
	xKnlsoPxxvx/eocYmTgYDzFKcDArifCGllSlCfGmJFZWpRblxxeV5qQWH2I0BYbfRGYp0eR8
	YOrOK4k3NLE0MDEzMzOxNDYzVBLnfd06N0VIID2xJDU7NbUgtQimj4mDU6qBaVqF8qQDQpeX
	zpo4N2P+RcFvc1OZGN7ou5Zwa3WfdrCfm7+VU7YsiW+X8aROkw+Nd5dr252STNhdevetaPT+
	9v63Xy9O0djeybk4KO1Jz6tzsvfMWmxaq019Nt9x3pq6rL6n9lPLxZt3vntO4zoisDFEYWKC
	lqZsdu4SFoPTNTcUgmY4lovN0l7wZnJb2R2x5b+rQ+J2fpbU4D0ozlvREcTv+sL2+Kd5jk8P
	M7jwf1wRaZFlfilM+PM1/wk7xeRn2uworPjCYzTVb8auts4wh+rZXZOXGVk9mN486Yvy/SaH
	dQebGe9e9bukK2MzeeLuHV9Mr73YubH3g/rRN5pVMifuFqw22JPQl1e19WVTiRJLcUaioRZz
	UXEiABUhS+8lBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWy7bCSnG7bxKo0g0+HdC2WNGVYTNm0g91i
	Q8ccVoubB3YyWaz4MpPdoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5LJ6vFoq1f2C3+7wHq6D1c
	a/F172c2Bz6PnbPusnss2FTqsWlVJ5vHnWt72DyeXJnO5HHnx1JGj29nJrJ49G1ZxejxeZNc
	AGcUl01Kak5mWWqRvl0CV8ac/iesBW/4KrasfcXUwPiKp4uRk0NCwETi7v1PjF2MXBxCAtsZ
	JW61n2KDSEhKfL64jgnCFpZY+e85O0RRM5PEkmczmUESbAJaEo1fu8BsEQFbifuPJrOCFDEL
	nGCSuD15AytIQlggQOLLyjZ2EJtFQFXi4Lw7YBt4Bawl7n15wQixQV5i9YYDQIM4ODgFbCQm
	XlYCCQsBldy98pd1AiPfAkaGVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBYa0VtINx2fq/
	eocYmTgYDzFKcDArifCGllSlCfGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5N
	LUgtgskycXBKNTA1XYuKnxew3OtIpNTs/0v2ap37aXpaLmLuT/HT5xtVz1jMuTI1tubr74PP
	lULe/lrkun3H5cO5V3M8t++Qtk653PHy9q7E43PXrb9VUu0RZHf467cXRxpjlW0/va2/G3FQ
	Q3E9R1yS581/rz1mbungNKn0Nqg6cXuVlFuZ40XW/81qyeV+5/ctqys7+fx/WiAbW8/LyHmn
	G54otHkkCiz+8vVPfUh3c7BuaLLlm1UaStIKF9lEEhRdrL8/LZzTKT7xxc3wjwHNb7vzbebH
	HG1f2OY0q+6j34SLnVdmyZ0+JT3f7Zy5EPfXbv5nR9QeX582T8lyu4HM/5V7f3ixMBhyuuz/
	XJyR/Mfg/RmfogMeSizFGYmGWsxFxYkASZ61LNoCAAA=
X-CMS-MailID: 20240625094438epcas5p2760f4d1537d86541940177543cea5aa8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240625094438epcas5p2760f4d1537d86541940177543cea5aa8
References: <20240625093813.112555-1-shradha.t@samsung.com>
	<CGME20240625094438epcas5p2760f4d1537d86541940177543cea5aa8@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add vendor specific extended configuration space capability search API
using struct dw_pcie pointer for DW controllers.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..b74e4a97558e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -275,6 +275,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
 	return 0;
 }
 
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
+					PCI_EXT_CAP_ID_VNDR))) {
+		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
+		if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
+			return vsec;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
+
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
 {
 	return dw_pcie_find_next_ext_capability(pci, 0, cap);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8e5431a207b..77686957a30d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -423,6 +423,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.17.1


