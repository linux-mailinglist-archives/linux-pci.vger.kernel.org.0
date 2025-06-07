Return-Path: <linux-pci+bounces-29145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61705AD0E6F
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067D1188BB14
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB11E260A;
	Sat,  7 Jun 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZdkQgcQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA31990A7;
	Sat,  7 Jun 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312872; cv=none; b=nGsaSOY6VDkMpvm0QjY4wE/owbhYqaBCC4rEWIQLQngE+CNjXdwHvFS5lB7m7a6pcQODJCPpqo7+eZKA8C45NkqD9y38MDHovKh55GJhd1g2ooZeJVjcD2XeoVdni3YyMF9jaICkwzfHMplWJ45Km0ZQ7sw6kxEdIjkLlbwiXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312872; c=relaxed/simple;
	bh=6fRifHZLf/pmCinDNYb9CR5+VoDtFCB9XJuIUXRiOtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbZ01yKrFoKiKc/oCM78RyBEpeaWhb5JHMlft17YERkwM+iJQ1kFIolEVFARCPd2MBgsKf1HVqz95UrOogmlENVttPnFl0Pl5vhaBN7qkrAbRVmoaYv58xwN5H7vJY+fI/h0yviMhiKjrBkS+552WdQnDmUAHZ6OeB6yEmW1Tc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZdkQgcQn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9G
	GE7b2vGuMct/epCgwaYzcvlP0vZDAnLAVxXVCEibk=; b=ZdkQgcQnsqvziPG3mX
	IUxBEOcqGjbLglC386Qbh6ZwKJtvOH2UrcqeGh7uh0db3dQKUxtIU8mYkcuOld3f
	OXoUMzxHdGB8p4XOHzYZq9SuH6tWWQcEGSdPg9/OOv4LI+Iuu3NBlfWSrabv6FbO
	SEO4rvZRBne8/ZcJTa4uRwm5A=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHuXJPZURoL9paGw--.4161S6;
	Sun, 08 Jun 2025 00:14:10 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v13 4/6] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
Date: Sun,  8 Jun 2025 00:14:03 +0800
Message-Id: <20250607161405.808585-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607161405.808585-1-18255117159@163.com>
References: <20250607161405.808585-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHuXJPZURoL9paGw--.4161S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrCr4UAF1ruw1kCw1DAwb_yoWrCF48pa
	yrAwn0yF45Ar1aqw1DZFnIvF13AF9xAF1xJa97GwnavFy2krWjq340krWaqrnakrZFgFy5
	KrWUJFWrAr1DtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pN0PTQUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxdlo2hEY-4hJgAAso

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v12:
- Modify the function's return value and format issues.

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
 drivers/pci/controller/dwc/pcie-designware.c | 83 ++++----------------
 1 file changed, 16 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 4d794964fa0f..fe3afb0d125c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -213,83 +213,32 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
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
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
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
 
@@ -302,8 +251,8 @@ static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
 	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
 		return 0;
 
-	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
-						       PCI_EXT_CAP_ID_VNDR))) {
+	while ((vsec = PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, vsec,
+						    PCI_EXT_CAP_ID_VNDR, pci))) {
 		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
 		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
 			return vsec;
-- 
2.25.1


