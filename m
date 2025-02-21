Return-Path: <linux-pci+bounces-22088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C22A407B7
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6716C1781C5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AEB208961;
	Sat, 22 Feb 2025 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s4V3hfOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3320A5DF
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221941; cv=none; b=uGRQ1lnwGV6FF5yOQmh1QUP6z0eS/Ke3hvrwl4dUk6p5LL41aOg2CKysKN/Ge1DQdk+CxY9wqkJOeVq/WMiPHE1Fg2yc7KYp7inHhQF+o+pZPbNhEMu85PNkzWtqdviM7rDkaV8bRefrtf5I5IJhdNZFDRyocp1t+oBcPWxX0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221941; c=relaxed/simple;
	bh=cueEm+OrWqNBIOOcoFP6l+BctEXzgi2OEUN9dowOhZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=FDmjA5Cypp0eDWKRKbUwxsfqiVud2m6/U20xafCY+8wezS3bGvVS1i+5uHy0dJenvkG+i7fKBqT3Kb0IYur26H3k74M24x+N4hD3IueFl/QBJ3B1HiUFxHmnDvjEFDIcp6iX9jT4vpyTPe80LUNuhSSGrChkE8TjMH+D5cbPNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s4V3hfOC; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250222105857epoutp03e16d1a4da3b69c635ea18bd3dd2ad59e~mgqHa6mhv0361603616epoutp03X
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:58:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250222105857epoutp03e16d1a4da3b69c635ea18bd3dd2ad59e~mgqHa6mhv0361603616epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740221937;
	bh=8xaQoVyMvAnEJND9PMyo7aPtb90ClrusWZzGMSDtc3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4V3hfOCov0IeoPlongmyGjHMpDgKgAgG73WigL0HVNVHk9nuUuXpJUtL3ynxio2C
	 nkZ0v7OjjcXcC5XWWYlMqnOGEbc6dis0HYUt99mml8zHrL+A9BZzeBrAtBvXmz+sEE
	 anaj0zpAbTpBy5tNva27y+DkJkC6PNvJcdin7rqQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250222105856epcas5p12ad9cbcbef8a224e9d3a88be15ee847a~mgqGuSki30600806008epcas5p1O;
	Sat, 22 Feb 2025 10:58:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z0PBQ745Wz4x9Pw; Sat, 22 Feb
	2025 10:58:54 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.0B.19933.EEDA9B76; Sat, 22 Feb 2025 19:58:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250221132029epcas5p1e56dd355e7ac912ceb25325595de0d24~mO8ZeZAZz3253332533epcas5p1t;
	Fri, 21 Feb 2025 13:20:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250221132029epsmtrp140aa667a60d9a943a41b0767fed556f4~mO8Zdax1P3135131351epsmtrp1-;
	Fri, 21 Feb 2025 13:20:29 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-97-67b9adee2473
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.59.18729.C9D78B76; Fri, 21 Feb 2025 22:20:29 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250221132026epsmtip28eeedfe94505e67c2d2eb7881fe08e40~mO8WlvRVu0587405874epsmtip2i;
	Fri, 21 Feb 2025 13:20:25 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v7 2/5] PCI: dwc: Add helper to find the Vendor Specific
 Extended Capability (VSEC)
Date: Fri, 21 Feb 2025 18:45:45 +0530
Message-Id: <20250221131548.59616-3-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250221131548.59616-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xbVRTHc/v62kKAvHSMXWrY4BGj1MAolHrLQImS7WWQjYjRhM2wZ3kW
	1tLWtjglMeNHYYPJDxmMOVk3GJNSOjAtIGWMVSCbAcFNGnQIywaIIkHmVhYXYFraov997jnf
	k+85597Lw/jfcQS8PJWe0apoJcnxZ/cOR70U/ec1uzy28nkccp5a56LG4QjUWpKLbtWaMFTS
	MYsjk+sLLjI3T3FQ0WfrOLLOT+Fosr+Jg8aNtznI2dPJRoYNAxvNGipwdPWnuyy02XsDoJYe
	Fxc1ly4B9M9AHxdVDX+KDDMJaPWZjZMSQl0x1eOUxWgBlP3CLJe6bC2gDCMrOGU1V3ComakB
	DmV/KKUWnI0sytZ6kqruNgPqiXV3RkCWIimXoXMYbTijkqlz8lTyZDItM/vN7ARJrChaJEWv
	kuEqOp9JJlPTM6L35ynd05LhH9HKAncog9bpyL2vJWnVBXomPFet0yeTjCZHqRFrYnR0vq5A
	JY9RMfpEUWxsXIJbeEyRO1v+O65ZJj7+dWgTFIHioErgx4OEGP447sQrgT+PT1wH8M5kB8t7
	eAygpajdl3kK4M8bE9h2yfTNcz7VDQCXztaBrQSfcAFouJ+6xRxCCIvXKj0FwUQZgCOLIVsF
	GNGLQYfJ5EnsIBg4M3edvcVs4kX4zf1RDwcSifDcsy6W120P7Pja4dH7EfugeaLR4wyJBzzo
	MjfhXlEqrKv6G3h5B/zjdjfXywK4VFPuYzlst533jaCET22tPoPXocPZ5DbmubuLgl39e73h
	MNgw2umRYEQQrFpf8MkDYZ9xmyOha3OA7eVQaLw16WuHgqvOasy7oWoAZ+ubsFqw+8L/FpcB
	MINQRqPLlzO6BE2cijnx37XJ1PlW4HnSwoN94OGDRzFDgMUDQwDyMDI4MFrfJ+cH5tCfFDJa
	dba2QMnohkCCe4GfY4KdMrX7T6j02SKxNFYskUjE0niJiNwVWGo3yPmEnNYzCobRMNrtOhbP
	T1DE8l/5wCQ8VLxngXvgr/RdS8vxwn6uZfpe2vTxaqUx0fKWhrZNBQgDghQRLVd/kIycWH6f
	g7uS6mqlgm/bjgz2nDGeFzYKsk5r9Iv9zMtR3dqwI/PjvPIrha7I0/cWhlJGBayytcR9l+Lm
	HJmvYHPHG9q/r886uUEojn3VQpkb09O0VsfERMtgWbc1uGHww/4zj0efvJfWPPbuO4eyyLdL
	VKfCpsfkl5QKaWTLyM21zBLoOFobUruIdh7lX/uSKXxjf1xN09gLlrOOyZrnlZNC2WFDjFl4
	5+Iv811tbZ3k4dvFUWmlKTLxowMV9oyS3yIulstWrfiKoy/LbsuIDo2vu0uydbm0SIhpdfS/
	P6S5kFsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXndu7Y50g4brTBZX2n+zW0w/rGix
	pCnD4tiEFcwWTavvslqs+DKT3WLVwmtsFg09v1ktNj2+xmpxedccNouz846zWVzZuo7FouVP
	C4vF3ZZOVoul1y8yWfzdtpfRYtHWL+wWC5tfMlr837OD3aL3cK1Fyx1Ti/c/N7M5iHksXjGF
	1WPNvDWMHjtn3WX3WLCp1KPlyFtWj02rOtk87lzbw+ax86Glx5Mr05k8Ni+p9+jbsorR4/Mm
	uQCeKC6blNSczLLUIn27BK6Mu20vWAteC1Q8PfSXsYGxka+LkZNDQsBE4tb+aUxdjFwcQgK7
	GSW6ms6zQyQkJT5fXMcEYQtLrPz3nB2i6BOjxJbTr1lBEmwCWhKNX7uYQRIiAp2MEnuPvAOr
	YhY4xywx83MLI0iVsECyRPf0CWA2i4CqxPZ7p1hAbF4BK4lpP9dDrZCXWL3hADOIzSlgLbHq
	3HSwuBBQzZ4t91knMPItYGRYxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHElamjsY
	t6/6oHeIkYmD8RCjBAezkgivbsmOdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNL
	UrNTUwtSi2CyTBycUg1Mqp8bH0k/ZrlvFRWulzuPjelfnltjmPTv/Lyrrt2XbOaWiPP0h9+b
	41fnZMfpvWz6D56EdP/CGUbrPFM+Hn3g9r3woOCSzPWNP6t/9Exw1Pv+rfnNh321vefZRS5K
	zRVbGrVp5VHXT4rKZRnHj79606xzflfD/261h0/kt3Id6pM9+iJ50xeL27HnVjSwpXUpZafJ
	aEq9yNY9UbHReDebVEnFo8N9NS5fxV6/3fl4SbqdoreCUfWc2heB/6M3FE95cjNL7PhCwYjU
	U2euqAgE6d/rZ5Z0M7tZW5nh5nM90/u3buA7Vl37khXV84JUtEJPL92yyTu+o2nZrwkKgZ/e
	HpuZcbTPfdN2qwOnn/QosRRnJBpqMRcVJwIAqOTWsBMDAAA=
X-CMS-MailID: 20250221132029epcas5p1e56dd355e7ac912ceb25325595de0d24
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132029epcas5p1e56dd355e7ac912ceb25325595de0d24
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132029epcas5p1e56dd355e7ac912ceb25325595de0d24@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

dw_pcie_find_vsec_capability() is used by upcoming DWC APIs to find the
VSEC capabilities like PTM, RAS etc.

Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..a7c0671c6715 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/pcie-dwc.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -283,6 +284,45 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
+static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
+					  u16 vsec_id)
+{
+	u16 vsec = 0;
+	u32 header;
+
+	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
+		return 0;
+
+	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
+						       PCI_EXT_CAP_ID_VNDR))) {
+		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
+		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
+			return vsec;
+	}
+
+	return 0;
+}
+
+static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
+					const struct dwc_pcie_vsec_id *vsec_ids)
+{
+	const struct dwc_pcie_vsec_id *vid;
+	u16 vsec;
+	u32 header;
+
+	for (vid = vsec_ids; vid->vendor_id; vid++) {
+		vsec = __dw_pcie_find_vsec_capability(pci, vid->vendor_id,
+						      vid->vsec_id);
+		if (vsec) {
+			header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
+			if (PCI_VNDR_HEADER_REV(header) == vid->vsec_rev)
+				return vsec;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
-- 
2.17.1


