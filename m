Return-Path: <linux-pci+bounces-20186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A21A17DA2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 13:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E321918853FB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7441F2380;
	Tue, 21 Jan 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QEeCrMxM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAB1F190E
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461699; cv=none; b=RBrjLJdKlO4kgcTlZ4DlIwdpzxmw9p2HVmDJD+pIKYH+cKkk16LI2d4FJAInE2pVGWIf2eL8pk/ms5qZB+p4zN7f7qTQyR5loTprm+gLOFHYywK0vA51OFrKSQ1Zo45rMpZIr79NLqVeZXcNZtSpJPQqIOPXewi1Nc5JTVvul78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461699; c=relaxed/simple;
	bh=BCvWu21/60Qrer2suhPTEYGrFQGUk1j3Cafga0UkHCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=YSE4id/2t3G9bRGWyx0MYoy3VKm4jKvLqXnfOQw9cnvr9eivzCF9SyGvU1nPlp7dJhfnTqhbBR9aJz82AgaMeGUHUlATQ93VM0O5Ez+8WleGmcALJy2PIq7Q0UE6HYn8HpQA5pcQrIhM+3B3mR4zoyn9kyt47GSlRfu7Xa+MnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QEeCrMxM; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250121121455epoutp01b25c80e0b1ce82e456348208053d6105~ctDTdMwhd0885408854epoutp01P
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 12:14:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250121121455epoutp01b25c80e0b1ce82e456348208053d6105~ctDTdMwhd0885408854epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737461695;
	bh=lXUpLOxvexbFrilbcXr3nhUUpuUNXCnBKsDFM90deW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEeCrMxMKsXuQtp1u4Z5cUmNgVcMwlUb4W8lkebkhjvTovR9jlatVPQPbOjQ3d044
	 l+6gsuW6tQVqnDdpH0ZU/SEO583li9VoIp0xD/yVUbEcA48p/ePgZtQ+HSKcyYpF+H
	 7NRQDTi5q3ifXYuSJg8DO8M79NFQrVCBMlPf7Tp0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250121121454epcas5p19c8ef8716cdd312c6d142d89be4ccf35~ctDSqTmTV1628416284epcas5p1E;
	Tue, 21 Jan 2025 12:14:54 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YcmNr4Bnmz4x9Py; Tue, 21 Jan
	2025 12:14:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.8A.19933.CBF8F876; Tue, 21 Jan 2025 21:14:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115200epcas5p130ba67bfd97abfba09e4542256eb254f~csvTJ3TBc1774517745epcas5p1b;
	Tue, 21 Jan 2025 11:52:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250121115200epsmtrp1c07474e3dde731a74fa54f6ec0d3b047~csvTJAwml0954909549epsmtrp1Y;
	Tue, 21 Jan 2025 11:52:00 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-c2-678f8fbcc51f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C8.02.18729.06A8F876; Tue, 21 Jan 2025 20:52:00 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
	[107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250121115158epsmtip1edd573775756f6017ec5061441ed5181~csvRC05Qd1750517505epsmtip1u;
	Tue, 21 Jan 2025 11:51:58 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v5 1/4] PCI: dwc: Add support for vendor specific capability
 search
Date: Tue, 21 Jan 2025 16:44:18 +0530
Message-Id: <20250121111421.35437-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250121111421.35437-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmuu6e/v50g1cPZCymH1a0WNKUYdG0
	+i6rxc0DO5ksVnyZyW6xauE1NouGnt+sFpd3zWGzODvvOJtFy58WFou7LZ2sFou2fmG3ePCg
	0qJzzhFmi/97drBb9B6udRDw2DnrLrvHgk2lHi1H3rJ6bFrVyeZx59oeNo8nV6YzeUzcU+fR
	t2UVo8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
	AbpumTlAHygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJL
	rAwNDIxMgQoTsjNmtuxnLbjNX3HpzRuWBsbjvF2MnBwSAiYSx7bOYupi5OIQEtjNKPFj5Rl2
	COcTo8Shv5PYIJxvjBLP9y9lgWl5fvU+VGIvo8SRrvvMIAkhgWYmiRUNOSA2m4CWROPXLrC4
	iIC1xOH2LWANzAJPmSRaj/9kA0kIC4RK7FtzkwnEZhFQldh3spUdxOYVsJK4Mb2TDWKbvMTq
	DQfABnECDXpz5A4ryCAJgbkcEst3LGeCKHKRONa1Geo8YYlXx7ewQ9hSEi/726DsdImVm2cw
	Q9g5Et82L4HqtZc4cGUOUC8H0HWaEut36UOEZSWmnloHVsIswCfR+/sJVDmvxI55MLayxJe/
	e6DWSkrMO3aZFcL2kPjydgU0hPoYJS4dec46gVFuFsKKBYyMqxglUwuKc9NTi00LjPJSy+HR
	lpyfu4kRnEy1vHYwPnzwQe8QIxMH4yFGCQ5mJRFe0Q896UK8KYmVValF+fFFpTmpxYcYTYEB
	OJFZSjQ5H5jO80riDU0sDUzMzMxMLI3NDJXEeZt3tqQLCaQnlqRmp6YWpBbB9DFxcEo1MEm9
	23vRc/rH/G+L59S4ewpf7J/lNZ/Hy3fp2ms2MUwWK1vXcTvtatGctkpp9VcZXh7FIwU/tEJt
	PG9lrfiu/l+Ja+PZT+93fm7tfPi3cFfxgRkpOkw1zPbiXfoHD5pP92b6Pckv2b5h0qVU71X8
	LXNWb8pdb9EpsyxC+MjEPSlzn1vKuvwM/3aMaWpseM++BYEsX57viWNbV9+mM5/l4JqzC80j
	p6nGzwo/sprXYG7pplXqC6NdZwS/anp3dvnSWWmGddaOG5lqbdhF3Ly/75Sd2PSLPZFZeb9s
	ga6/ux53W35VyhfPM5yVWc8dbV5JRR5/7L3hXky3guumpDuXWu+H63JKzin5qCrx3ortlBJL
	cUaioRZzUXEiAJPYb0svBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnG5CV3+6waq7qhbTDytaLGnKsGha
	fZfV4uaBnUwWK77MZLdYtfAam0VDz29Wi8u75rBZnJ13nM2i5U8Li8Xdlk5Wi0Vbv7BbPHhQ
	adE55wizxf89O9gteg/XOgh47Jx1l91jwaZSj5Yjb1k9Nq3qZPO4c20Pm8eTK9OZPCbuqfPo
	27KK0ePzJrkAzigum5TUnMyy1CJ9uwSujJkt+1kLbvNXXHrzhqWB8ThvFyMnh4SAicTzq/fZ
	QGwhgd2MEke+FUPEJSU+X1zHBGELS6z895y9i5ELqKaRSeLHh7PsIAk2AS2Jxq9dzCC2iICt
	xP1Hk1lBipgFvjJJfPx0AywhLBAsseHSSbBJLAKqEvtOtoI18wpYSdyY3skGsUFeYvWGA2D1
	nALWEm+O3GGFuMhKYvb2U6wTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQI
	DnYtzR2M21d90DvEyMTBeIhRgoNZSYRX9ENPuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9
	KUIC6YklqdmpqQWpRTBZJg5OqQYmF5aT7/4EXPuYI3k+aU7RRYWqQPcTR2c6XGovuMm0PD7E
	tzvU++DJzefMD6+Kz/jje/6zlMD6g9u3/3inve6nrL7/VIcL0jn7roUwJUxg6PaSV3RWOfdh
	7jU2t7+TFnYpblje2Ln725Mk+dlxxUeeRE34J7fq47sEIb0dWmvOPTvOwyCz5les4JxbFhUf
	sjlXb7toZDRHf3v1liurU4qXfa2+IKt7+H6sh8+n1zcsyizL5OqSGOompClta9YVenHSqV56
	wj+BV+p3nbrOlLu0CXA8qN8YkHPh7cya0CWJsZ3bjhWJtEppeZf5BqyYtyDw4i5W5yedu4Xj
	HU7t0d/1IfjMv95mA6Xc5iNXtrguUmIpzkg01GIuKk4EACZCcn7lAgAA
X-CMS-MailID: 20250121115200epcas5p130ba67bfd97abfba09e4542256eb254f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250121115200epcas5p130ba67bfd97abfba09e4542256eb254f
References: <20250121111421.35437-1-shradha.t@samsung.com>
	<CGME20250121115200epcas5p130ba67bfd97abfba09e4542256eb254f@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add vendor specific extended configuration space capability search API
using struct dw_pcie pointer for DW controllers.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 19 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..3588197ba2d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -277,6 +277,25 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
 	return 0;
 }
 
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id, u16 vsec_cap)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
+		return 0;
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
index 347ab74ac35a..02e94bd9b042 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -476,6 +476,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id, u16 vsec_cap);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.17.1


