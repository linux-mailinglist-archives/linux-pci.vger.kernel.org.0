Return-Path: <linux-pci+bounces-27739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608BFAB70F6
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C7B1B612F6
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD09228033E;
	Wed, 14 May 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MqIEaGez"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384E27FD46;
	Wed, 14 May 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239238; cv=none; b=IyyG3xCe/prA25FvmYxJD2eYK66PXLKTEn6vHFE/ua5v8NNfCqt8+J+MLAwmY2icLAmVMRlIqZTqvSXeI7vA+fivCU92RjVe8V659GyelFzp1B1WOw0t54yuotwhxgrmzblFu7n8J2CS0SC2SkelaiPmx86n3PquPMVVtpr1Z2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239238; c=relaxed/simple;
	bh=12yeiJL2v0gApG43aRFyNQV7+DVt0HzEwyTJ4Fy99SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQ4NRzgi/W62kUybx0Ibx0LLVWXaL9zASPlZl3QmykXSqvIpqA4/KMoRrSygiUvVMo/rylziBd7M/e4KotmdqixOuEkNC3g/c7otHVK51fMr5MrRwdRABmCLWyo+gT9j2g4dJ6oczSwmg2m9T2i6GOaHy4BhsSOWBZou74JL5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MqIEaGez; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=H/
	RFGx5fGQp5jiVVaRwwNi7aJIeC2+jGNkFXsI55y0c=; b=MqIEaGezzL30BquPUY
	UmIA6JHWxibQuF5tVITiu2gMgo6aDcB7dudJL+vX3q5x+1UPCiOU8tga+2avB4vR
	f71Gz4DRstRQTa5330t9tWyPmwj6jKOdSe9UwsvIfQw5Rv261p4fMc2ZaikgaX4J
	MSceP0IVc1FX/zJvZXsVTAOJk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3VU0LwSRo5cN_BQ--.35962S6;
	Thu, 15 May 2025 00:13:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v12 4/6] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
Date: Thu, 15 May 2025 00:12:56 +0800
Message-Id: <20250514161258.93844-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250514161258.93844-1-18255117159@163.com>
References: <20250514161258.93844-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3VU0LwSRo5cN_BQ--.35962S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrCr4UAFyxJFW8Zw4fKrg_yoWrAF1Dpa
	yrAwn0yrW5Ar1aq3WDZFnIvF15AF9xAFyxJa97G3ZavFy2krWjq340krWaqr1SkrZrKFy5
	Kr48JFWrAw1DtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pK-e5dUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOg9No2gkwQMCawABs9

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v11:
- Resolve compilation errors. s/dw_pcie_read_dbi/dw_pcie_read*_dbi

Changes since v10:
- None

Changes since v9:
- Resolved [v9 4/6] compilation error.
  The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses 
  dw_pcie_find_next_ext_capability.

Changes since v8:
- None

Changes since v7:
- Resolve compilation errors.

Changes since v6:
https://lore.kernel.org/linux-pci/20250323164852.430546-3-18255117159@163.com/

- The patch commit message were modified.

Changes since v5:
https://lore.kernel.org/linux-pci/20250321163803.391056-3-18255117159@163.com/

- Kconfig add "select PCI_HOST_HELPERS"
---
 drivers/pci/controller/dwc/pcie-designware.c | 81 ++++----------------
 1 file changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 97d76d3dc066..7939411a24eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -205,83 +205,30 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
 		pci->type = ver;
 }
 
-/*
- * These interfaces resemble the pci_find_*capability() interfaces, but these
- * are for configuring host controllers, which are bridges *to* PCI devices but
- * are not PCI devices themselves.
- */
-static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-				  u8 cap)
+static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
 {
-	u8 cap_id, next_cap_ptr;
-	u16 reg;
-
-	if (!cap_ptr)
-		return 0;
+	struct dw_pcie *pci = priv;
 
-	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	cap_id = (reg & 0x00ff);
-
-	if (cap_id > PCI_CAP_ID_MAX)
-		return 0;
-
-	if (cap_id == cap)
-		return cap_ptr;
+	if (size == 4)
+		*val = dw_pcie_readl_dbi(pci, where);
+	else if (size == 2)
+		*val = dw_pcie_readw_dbi(pci, where);
+	else if (size == 1)
+		*val = dw_pcie_readb_dbi(pci, where);
 
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+	return PCIBIOS_SUCCESSFUL;
 }
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
 {
-	u8 next_cap_ptr;
-	u16 reg;
-
-	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
-	next_cap_ptr = (reg & 0x00ff);
-
-	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+	return PCI_FIND_NEXT_CAP_TTL(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
+				     pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
 
-static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
-					    u8 cap)
-{
-	u32 header;
-	int ttl;
-	int pos = PCI_CFG_SPACE_SIZE;
-
-	/* minimum 8 bytes per capability */
-	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
-
-	if (start)
-		pos = start;
-
-	header = dw_pcie_readl_dbi(pci, pos);
-	/*
-	 * If we have no capabilities, this is indicated by cap ID,
-	 * cap version and next pointer all being 0.
-	 */
-	if (header == 0)
-		return 0;
-
-	while (ttl-- > 0) {
-		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (pos < PCI_CFG_SPACE_SIZE)
-			break;
-
-		header = dw_pcie_readl_dbi(pci, pos);
-	}
-
-	return 0;
-}
-
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
 {
-	return dw_pcie_find_next_ext_capability(pci, 0, cap);
+	return PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, 0, cap, pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
@@ -294,8 +241,8 @@ static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
 	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
 		return 0;
 
-	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
-						       PCI_EXT_CAP_ID_VNDR))) {
+	while ((vsec = PCI_FIND_NEXT_EXT_CAPABILITY(
+			dw_pcie_read_cfg, vsec, PCI_EXT_CAP_ID_VNDR, pci))) {
 		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
 		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
 			return vsec;
-- 
2.25.1


