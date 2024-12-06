Return-Path: <linux-pci+bounces-17832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B099E6903
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E642D281031
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D61DDA3A;
	Fri,  6 Dec 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MS9kBJbb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C11E1C2B
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474070; cv=none; b=a7s+GdfGCTSEB6g7/KQk3cmeZKq3QdnL906uno02KsWou2FnwuoE3FOE+gDsE2Qu0SedSScrpeH6iJRispCSmSrg25v3iAR7w2u9F7K8gGGYmEbUlD2J8iYXLquwI+mJH5E+lx4wNJj97CrWm0Zv5bxI1vBTh6ARtvOhsZg67ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474070; c=relaxed/simple;
	bh=EhEGYhxLSlKYz9DoJ7L+0wZRwDTYKR4K1VwaUOKojWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=KY7TV/JV9qarEnUgR+4iAXmEqZMDiLc9yFnN13Nbmg4WO1LYqhCpAfhUqBPzOhly8cR0I8n73+NeW+iel2xVNdyX+3oixbKCC8ezYM2RQ5SEM2d2dOktB9qyK5oWB7qoYx5tMHeAUqQpJL9b+pSY7i+tZvb1NR1rj4jOZbNksoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MS9kBJbb; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241206083418epoutp036648d68e03015e9b6584c8337d2c4f21~OiXjStk3A2315423154epoutp03_
	for <linux-pci@vger.kernel.org>; Fri,  6 Dec 2024 08:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241206083418epoutp036648d68e03015e9b6584c8337d2c4f21~OiXjStk3A2315423154epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733474058;
	bh=8zKrIcn8Ku+bx3UX7Tz/EWhEyXC2fgMinelJIKpRG+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MS9kBJbb30je8zmlMenh8NCmBwo9aBA6Wtuzd5yD3IXUjmiSe3XyEJjrWLyHsaxqw
	 9PSTnL/gFjkcD3hja7ddjupd7M2Ah0WAukeNwGyEkJRZD8ooueJ8beWG6zI6F3+RGp
	 snvz448ucqiY8Oh1i5R9e/ZENEV8YHW6Cte/CtsM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241206083417epcas5p39c67cf3f045df165f9a8451468eb57a8~OiXip7BHT2819428194epcas5p3G;
	Fri,  6 Dec 2024 08:34:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y4PgX1Sjzz4x9Q3; Fri,  6 Dec
	2024 08:34:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.D7.19956.807B2576; Fri,  6 Dec 2024 17:34:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241206074234epcas5p3bc1151ad713c702c34581b484e21292d~OhqYKverE2415924159epcas5p3V;
	Fri,  6 Dec 2024 07:42:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241206074234epsmtrp13fdff976ad6ec0a303a823bae8334a40~OhqYJ18dA1431314313epsmtrp1Q;
	Fri,  6 Dec 2024 07:42:34 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-b2-6752b708311a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.0E.18949.AEAA2576; Fri,  6 Dec 2024 16:42:34 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241206074231epsmtip1b892024f40d449e2eed582a8b6e08aa3~OhqVaDbkx1378213782epsmtip1C;
	Fri,  6 Dec 2024 07:42:31 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability
 search
Date: Fri,  6 Dec 2024 13:14:55 +0530
Message-Id: <20241206074456.17401-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241206074456.17401-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmli7H9qB0gzXn2S2mH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjP2bljJWvCKr+L4wn3sDYwveLoYOTkkBEwkJq+exNTFyMUhJLCbUeLUs4ds
	EM4nRomFF2dAOd8YJc59W8cI07LlRzs7RGIvo8Sxkwehqr4wSvy8s5ENpIpNQEui8WsXM4gt
	ImAtcbh9C1gRs8BTJonW4z/BioQFQiWub9jPBGKzCKhK9L2ezgJi8wpYSZxraIRaJy+xesMB
	oEEcHJxAg6b+CgCZIyGwkEPizZQ2dogaF4lL0w5D2cISr45vgbKlJF72w9SkS6zcPIMZws6R
	+LZ5CROEbS9x4MocFpD5zAKaEut36UOEZSWmnloHVsIswCfR+/sJVDmvxI55MLayxJe/e1gg
	bEmJeccus0LYHhJtZ3rBXhQS6GOUeLHYeQKj3CyEDQsYGVcxSqYWFOempxabFhjnpZbDYy05
	P3cTIziVannvYHz04IPeIUYmDsZDjBIczEoivJVhgelCvCmJlVWpRfnxRaU5qcWHGE2BwTeR
	WUo0OR+YzPNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamA6lHCM
	6/v19B2ZDp6njV+ENuqllqQ7Ld5cfXTx3z6RFQuurVlbuULI+KBLaLw2j4HSj7UmvN/e781W
	2v2Q/dEnb5ejQSW3DzT2F5ixvo8+Ov1ggkxmaswdGz9FCfPuPVtdrB7dmpGfFnLzBveTgMhv
	O1R2VSWXFnx6lCS5jSUzTW9TgcDfoDD7Wubnz1jq9Oum7zRmnjnde1VkCkd3+iaHS86GfJyX
	4+5OqTdy0BfxaeDa/fLyqouneh5cCPE4FlrrzRzGqutYMfMVY/KsRqFra20FHZtnrJqmIbtv
	nr2nBO/XIJvKTIYzq+JF1itxrL394CSjyfQuPo8IC/eM1QLW4QcZX98Nt1/z2P6NvxJLcUai
	oRZzUXEiAKcbqJMuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO6rVUHpBscXcFtMP6xosaQpw6Jp
	9V1Wi5sHdjJZrPgyk91i1cJrbBYNPb9ZLS7vmsNmcXbecTaLlj8tLBZ3WzpZLRZt/cJu8eBB
	pUXnnCPMFv/37GC36D1c6yDgsXPWXXaPBZtKPVqOvGX12LSqk83jzrU9bB5Prkxn8pi4p86j
	b8sqRo/Pm+QCOKO4bFJSczLLUov07RK4MvZuWMla8Iqv4vjCfewNjC94uhg5OSQETCS2/Ghn
	72Lk4hAS2M0o8ebnfFaIhKTE54vrmCBsYYmV/56zg9hCAp8YJR4fFAex2QS0JBq/djGD2CIC
	thL3H01mBRnELPCVSeLjpxtgCWGBYInFdxrBBrEIqEr0vZ7OAmLzClhJnGtoZIRYIC+xesMB
	oHoODk4Ba4mpvwIgdllJrG/5zzaBkW8BI8MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
	TYzgUNfS2sG4Z9UHvUOMTByMhxglOJiVRHgrwwLThXhTEiurUovy44tKc1KLDzFKc7AoifN+
	e92bIiSQnliSmp2aWpBaBJNl4uCUamDatpZPpFVRYGehzlKfTI8FK7f/mzl3+tHGoPsr6+4n
	//nkfnP+sQDB3S4WK8+Ifi2IaVLYsMGtRPV/eH6pyKLsV2dPzti9cNbVt3dWP3i5WFWUK8jB
	1Nplw/UnXU/Tz18Snu9gkDBXeeH1vDUusj8OMgfOPqNxWSu1sku6M7zW49dER9eWZTxrfR2L
	xIPaDs66Fy1zvYZtzl7FvQJb/JJtOOcs/GyxdLnE5481cz/+sdPifBttqtYwb5v85c2dVYGr
	D0ZnTbWr9188Vadq6TLr+Me+rL3zDlbyyzifu9UVX3Ly14ftret5w/S4Zp1Wvqe+YO2CBYKd
	ns/NWH6Er/hdom9yvc1g7SrtFcv1LfuvKLEUZyQaajEXFScCALe/QZzkAgAA
X-CMS-MailID: 20241206074234epcas5p3bc1151ad713c702c34581b484e21292d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206074234epcas5p3bc1151ad713c702c34581b484e21292d
References: <20241206074456.17401-1-shradha.t@samsung.com>
	<CGME20241206074234epcas5p3bc1151ad713c702c34581b484e21292d@epcas5p3.samsung.com>
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
index 6d6cbc8b5b2c..41230c5e4a53 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -277,6 +277,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
 	return 0;
 }
 
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
+					PCI_EXT_CAP_ID_VNDR)) {
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
index 347ab74ac35a..98a057820bc7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -476,6 +476,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.17.1


