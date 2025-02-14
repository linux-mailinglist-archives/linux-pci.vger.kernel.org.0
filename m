Return-Path: <linux-pci+bounces-21444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF7A35BF8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 11:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F82188F24E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DC245AE1;
	Fri, 14 Feb 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O9i03RNN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA415198D
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530636; cv=none; b=ZOfCppCzmM+y+jdRaOiM3o4HUnPHaoPu2nOV4dQchwuG1h5e48JfRJYOZyYWGBefuUOuJWBtm6MAD3s8xCcKBuQMFfJZJUsiF0eucAmfiqDNE7ntHHVrZaJpLCfKnKPzC/kzVqR5/v3jwIrG/c5zM06LjBE5PcIAFj4aQlL3jtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530636; c=relaxed/simple;
	bh=BCvWu21/60Qrer2suhPTEYGrFQGUk1j3Cafga0UkHCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=GjHJ5y4e27ra73vwUNfjQrDbBQWxriah0mw1k2NRZOMMa5hLkJDK60PMMWfzoAZor06yP84Z5VTy/k/cj/d5jljWREir8esWExZbjMZkTMmOyIkroi605d9R2ylrfVOPha/Lkl/NB5dexitKaV7Vuy3/Yq+4FfzKI1u8gk4oHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O9i03RNN; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250214105712epoutp03064b8cf17d7e54fe58268762a38b072b~kDeTimHXl1593415934epoutp03G
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:57:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250214105712epoutp03064b8cf17d7e54fe58268762a38b072b~kDeTimHXl1593415934epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739530632;
	bh=lXUpLOxvexbFrilbcXr3nhUUpuUNXCnBKsDFM90deW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9i03RNNDl6HsIeA9vQV6FgsB8guk7jKxPhkdkkPdOJ+nLhea+JQbJQts2gYOUIB+
	 EKDfdq6RrJ1Ge3fvuqkIcnrjdIgZgv6y0upRCRnI1v/zEJQ5AI38IoXvdpjUU9Tp0Y
	 oe6m87r7Pyhq2wDB5DzjzRqzGs8fnAdKemELPNzg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250214105711epcas5p28a20e7872cb939bc55fc0a75e85d7de4~kDeSfntf10047000470epcas5p2O;
	Fri, 14 Feb 2025 10:57:11 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YvTX52yVCz4x9Q0; Fri, 14 Feb
	2025 10:57:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.2A.19710.5812FA76; Fri, 14 Feb 2025 19:57:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889~kDbK8U-9Q1985819858epcas5p3f;
	Fri, 14 Feb 2025 10:53:37 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250214105337epsmtrp1dba042675fa99af6f533ccd2f6a56e40~kDbK7eXrB1673516735epsmtrp1e;
	Fri, 14 Feb 2025 10:53:37 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-10-67af2185ee2a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.BE.33707.1B02FA76; Fri, 14 Feb 2025 19:53:37 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250214105334epsmtip155c9c1a40d24369126c624930cc9bd8b~kDbIX3LYL1117711177epsmtip1b;
	Fri, 14 Feb 2025 10:53:34 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v6 1/4] PCI: dwc: Add support for vendor specific capability
 search
Date: Fri, 14 Feb 2025 16:20:04 +0530
Message-Id: <20250214105007.97582-2-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250214105007.97582-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmpm6r4vp0g7XvhC2utP9mt5h+WNFi
	SVOGxbEJK5gtmlbfZbW4eWAnk8WKLzPZLVYtvMZm0dDzm9Xi8q45bBZn5x1ns2j508Jicbel
	k9Xi77a9jBaLtn5ht3jwoNKic84RZov/e3awW/QernUQ9li8Ygqrx85Zd9k9Fmwq9Wg58pbV
	Y9OqTjaPO9f2sHk8uTKdyWPinjqPvi2rGD0+b5IL4IrKtslITUxJLVJIzUvOT8nMS7dV8g6O
	d443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB+kpJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9c
	YquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ0xs2U/a8Ft/opLb96wNDAe5+1i5OSQ
	EDCRWD3rDiuILSSwm1Fi1eayLkYuIPsTo8SpGT+Z4Zx1xx4zwnRcfvaADSKxk1Hi1cMuVgjn
	C6PEtr0tbCBVbAJaEo1fu5hBbBEBa4nD7VvA4swCi5gl5nYngtjCAqES2xd1s4PYLAKqEsve
	fAeq5+DgFbCSWPpaF2KZvMTqDQfAxnACjXl7/gvYLgmBPRwSr5a8Z4EocpF4e3k9K4QtLPHq
	+BZ2CFtK4mV/G5SdLrFy8wxmCDtH4tvmJUwQtr3EgStzWED2MgtoSqzfpQ8RlpWYemodE8TJ
	fBK9v59AlfNK7JgHYytLfPm7B+oESYl5xy5DneAh8XrSB3ZImPQxSqyeOYN1AqPcLIQVCxgZ
	VzFKphYU56anJpsWGOallsMjLTk/dxMjOOFquexgvDH/n94hRiYOxkOMEhzMSiK8EtPWpAvx
	piRWVqUW5ccXleakFh9iNAWG30RmKdHkfGDKzyuJNzSxNDAxMzMzsTQ2M1QS523e2ZIuJJCe
	WJKanZpakFoE08fEwSnVwDT5m9QC1qqbd7KXq2zpDTqpWGt446Hmya4M886FnxgvmD0ylOKU
	SclQ3qZasz7j2gUPoY9rslziLsjJ/7pcf/+N1oS3fN/u3Oytlv3JGPuy7NK3t9avbSx3Pml7
	8SzsipTLPx7Zc7H7qvwMpqzTFAzzeFXiqh36KqHlknLl0woz3+Mh9ZXSnS1nflkb5BZ8ZE9Z
	w8s+aQV7J8fq2lOlTFKe7HP8VkT8EH170CrgcsMbKRkvFulVbIuyg/VXRHjJKQpeW3JA/Ou9
	uPKlCXrXj35TkL13bKmkXFp52PbFsd69OauZNd87f7lwe7Ffnd/d+FXnSvg9hVN/TWb+dX33
	ns1LljskCM2ZHz5R5c4PAyWW4oxEQy3mouJEAMp+LVlBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnO5GhfXpBudu8ltcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgt+g9XOsg7LF4xRRWj52z7rJ7LNhU6tFy5C2r
	x6ZVnWwed67tYfN4cmU6k8fEPXUefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlTGzZT9rwW3+
	iktv3rA0MB7n7WLk5JAQMJG4/OwBWxcjF4eQwHZGiYln/7JBJCQlPl9cxwRhC0us/PecHaLo
	E6PEsxsPwIrYBLQkGr92MYPYIgK2EvcfTWYFKWIW2MEs8XfeVnaQhLBAsMTNLXvBGlgEVCWW
	vfkO1MDBwStgJbH0tS7EAnmJ1RsOgM3hFLCWeHv+CyuILQRU8mPNDcYJjHwLGBlWMYqmFhTn
	pucmFxjqFSfmFpfmpesl5+duYgRHg1bQDsZl6//qHWJk4mA8xCjBwawkwisxbU26EG9KYmVV
	alF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA9OWnCPlTIxHZwQmn441
	eSDR8eHBjP83Nj/a3xq6aZ5d3uGZ3Rdk225ozthQtPzUxyuWPBKnOe3nVR2fcmyr5flNt/Zd
	KpMz7mV/aByssimCnVlfnOFUS6XzsvOBp3PvH/P2W/l3hZRbZuaztRu2ym6akpmwUDH1j38U
	693dy+4Y8aa51zEoGG0W5TDRzhfPXnu0jzel7JTtzGKla+V2b1l2sN22qLuwOVj8jubZH5cC
	z3sX//4yu8YkSfr5Y3fZPoXzolk66SL7D9w1SPzl+muvqs82p9uma0U0n0vJlvz6kPniReF2
	t/xf36yM1urbr7xXlvzvqLMuy624c7wrbK9MElWYZpstIBncdEJEx0CJpTgj0VCLuag4EQDc
	ETUr9QIAAA==
X-CMS-MailID: 20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889
References: <20250214105007.97582-1-shradha.t@samsung.com>
	<CGME20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889@epcas5p3.samsung.com>
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


