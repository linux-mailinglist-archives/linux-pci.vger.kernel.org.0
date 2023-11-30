Return-Path: <linux-pci+bounces-285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C42BA7FF0C0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B3A1C20C3D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84368482CD;
	Thu, 30 Nov 2023 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GC9o/zEq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42110F4
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 05:51:52 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231130135150epoutp04ff0b42cde7e45a38203ea79899c52566~cauml_dwq3057730577epoutp04O
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 13:51:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231130135150epoutp04ff0b42cde7e45a38203ea79899c52566~cauml_dwq3057730577epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701352311;
	bh=aP3ywc1rVK9Ng/6mlWNX7XCg5UIfUgmB09BoZ6JOK7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GC9o/zEqCXght619eFKKoeXO5ZOiy74xsL8yY1yd4ZptGs8hP+lQw1dYwuJObTefX
	 LKjEaqBIHuIXfD8XuKXa0IL66/MBrjOsmgiLAgJHgG/0biybTk9nmb/pMtyxQQafFL
	 apIotmD5r9TQeHamce+OQRM3R3EsmJ+xEeLoVQPM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231130135150epcas5p14470ec61f9e8ab83449f30823863d641~caulsLVX51942519425epcas5p1E;
	Thu, 30 Nov 2023 13:51:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SgyKc2F5Vz4x9Pr; Thu, 30 Nov
	2023 13:51:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.F6.10009.47398656; Thu, 30 Nov 2023 22:51:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231130115103epcas5p19a56bf80e3c7cb062dba9e60d7363039~cZFJKsTQa3047730477epcas5p1t;
	Thu, 30 Nov 2023 11:51:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231130115103epsmtrp280fad264f85e09862a67fa59f2715f6b~cZFJJ17vo1512515125epsmtrp2s;
	Thu, 30 Nov 2023 11:51:03 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-40-656893742661
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	79.A6.08755.72778656; Thu, 30 Nov 2023 20:51:03 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231130115101epsmtip1a2fd41eec6508250484bdcbf17ed971a~cZFHOOs4e1251512515epsmtip1U;
	Thu, 30 Nov 2023 11:51:01 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, josh@joshtriplett.org,
	lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, pankaj.dubey@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v2 1/3] PCI: dwc: Add support for vendor specific capability
 search
Date: Thu, 30 Nov 2023 17:20:42 +0530
Message-Id: <20231130115044.53512-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130115044.53512-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmpm7J5IxUg6Ob+CyWNGVY7LrbwW4x
	a9tcRosVX2ayW/xfkG/R0POb1eLyrjlsFmfnHWezaPnTwmLRcrSdxeJuSyerxaKtX4DK9uxg
	t+g9XOvA57Fz1l12jwWbSj1uvbb12LSqk83jzrU9bB5Prkxn8tj4bgeTR9+WVYweW/Z/ZvT4
	vEkugCsq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
	6HolhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGR
	KVBhQnbGtSkTmAve8FVcX3GDrYHxFU8XIweHhICJxJ/X8V2MXBxCArsZJXY938IO4XxilPiz
	fyMThPMNyPn3kLWLkROs49rCHawQib2MEmc+fIJqaWWSeDBjFjNIFZuAlkTj1y5mkISIQBeT
	xKMVJ9lBEswCyRLz+u8wgdjCAqESbQuugNksAqoSi7ofgNm8AlYSK/f9hlonL7F6wwGwoZwC
	1hLPVl1hBBkqITCVQ2Jl8102iCIXicfPW1kgbGGJV8e3sEPYUhKf3+2FqkmXWLl5BjOEnSPx
	bfMSJgjbXuLAlTksoNBgFtCUWL9LHyIsKzH11DomiJv5JHp/P4Eq55XYMQ/GVpb48ncP1FpJ
	iXnHLkPd7CHx5dIzaNj1MUocen+XeQKj3CyEFQsYGVcxSqYWFOempxabFhjlpZbDoy05P3cT
	IziJanntYHz44IPeIUYmDsZDjBIczEoivNefpqcK8aYkVlalFuXHF5XmpBYfYjQFBuBEZinR
	5HxgGs8riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoEpzslu02rV
	KYacJz+8m8o+u/bqvYy8NKu3C7clM2zZeXzntheNF332cy5/5H7xjRL3KdOy9XMOnqyMbKjs
	37LKdo7cBRYV28mSep3OxlenFH+J/H81deJTQZfauxNZNdWUl+X/evGpT72ba1t1ubll2NEr
	1+R1PkRKPQ0JuiDXlyMvyDNn36o3h5yXCBo1FXz/dinsYNNDrUkObGZfLYX2ly6ZX3mZ+9HU
	G497HLx2WIRlXFVZ993hHpuY2RPO7acFOJ5yXqr2XMy9b5/M3hvf58QJ35j0UvzD4pkfGNZN
	1dLeeMNAxbl2OrfUwTy2O6teqLNYcdvcvOOe+EWbx1NsomZF5+Sz4ZlrkjXWm6TqKrEUZyQa
	ajEXFScCAPOmaHMrBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSnK56eUaqwdb1uhZLmjIsdt3tYLeY
	tW0uo8WKLzPZLf4vyLdo6PnNanF51xw2i7PzjrNZtPxpYbFoOdrOYnG3pZPVYtHWL0Ble3aw
	W/QernXg89g56y67x4JNpR63Xtt6bFrVyeZx59oeNo8nV6YzeWx8t4PJo2/LKkaPLfs/M3p8
	3iQXwBXFZZOSmpNZllqkb5fAlXFtygTmgjd8FddX3GBrYHzF08XIySEhYCJxbeEOVhBbSGA3
	o0TjczaIuKTE54vrmCBsYYmV/56zdzFyAdU0M0kcPXeTBSTBJqAl0fi1ixkkISIwg0mipfs+
	WIJZIFXi9uE5YJOEBYIldnddZASxWQRUJRZ1PwCbyitgJbFy329WiA3yEqs3HGAGsTkFrCWe
	rbrCCHGRlcSiXz+YJzDyLWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERzkWpo7
	GLev+qB3iJGJg/EQowQHs5II7/Wn6alCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQn
	lqRmp6YWpBbBZJk4OKUamExu5+59F6d83XNBwTe5zscvH19unht7P+eof5Y6Q/CyNNWN2gFR
	da9+8O6r+yx5+1WWO0f8A2XFo12VZkIn4jfWfA+c9ajdPYX3I1slv4//G+t4s0MHvp63MLDa
	8tbJYqtf+rc/Wh+PZ3x7t+tNi+P0jvO7lzdNDlR9VMyu6cfoaXY1O6rlNrvFKZ255gcFHt2t
	dzkn+VjjZfyu/1OvP9odvel6DAPDs4Rlyn0JPyXEE6dmv5ge0R2rKKr4LeHUabOlB12m9R+O
	9TxXt23O1dTS4AyfL9yFm83NhOTWcm1MV2AX2nq7Opdvq99V3/5Es92rJd+x7c9uuv1E3/5s
	eYRbbcSrmK61TqqV1y9nKrEUZyQaajEXFScCAEY3aIzhAgAA
X-CMS-MailID: 20231130115103epcas5p19a56bf80e3c7cb062dba9e60d7363039
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231130115103epcas5p19a56bf80e3c7cb062dba9e60d7363039
References: <20231130115044.53512-1-shradha.t@samsung.com>
	<CGME20231130115103epcas5p19a56bf80e3c7cb062dba9e60d7363039@epcas5p1.samsung.com>
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
index 1c1c7348972b..064b4951afd8 100644
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
index ef0b2efa9f93..b7ea1db14f6a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -419,6 +419,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
-- 
2.17.1


