Return-Path: <linux-pci+bounces-32293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFADB07ACE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1397E167E47
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B062F5C33;
	Wed, 16 Jul 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eoKMaiHn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B62F5466;
	Wed, 16 Jul 2025 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682358; cv=none; b=W2fC3HtAw/M0QrtVJ2xP8ZDmOuqELym7ThsdlxZW8Sovnt+TqV+I2EV1bFmBoMCZgXOIu5NRfhh6l30BRa0mJUbOhQB7TYJ9uMQGnGKm0WttfsX/iLF4kh5HiN16ZX+H+zGWeIvAm8YS+tXwVEgWSdzP21OMDTQXRDw4wzgWLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682358; c=relaxed/simple;
	bh=5QRhjTY61OamMuKmyL25IGxdeBzFuqBgtEG2oUdBnEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHXX9T3vakrjG/sgEhCwWO6g179r3PVghl9IW/Tel6C+HIfa/VdXDK1886AzFuzD2HQNcAlWGy7aYOuI7jktP1SgYDgo61tHRuMNHItlQr/Xk7aoOq5r+Rjge7sK3koyqkCbR+Pad6tzG2oJMs9DwMifSD5ti6WCgK/Pa5/u0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eoKMaiHn; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=t7
	nhK9QibaYlqN4aFk40gKliWnYXZDrUuUsAUWHP5PM=; b=eoKMaiHnFmjpqXdyNx
	phuJNs93GBgimMXcWWqm3EmCg8e8UztD1AsL3EtQezEtKen71gkGyBFbji7rvGLP
	/eq1lxBZ0z57Vv23/ppFEvRM27svIsZJKxnwfO5xiYfQbXsNVj2If+ENDnZHZaGv
	r9T9xt5s7mXLcSQkrWfdJsD+U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnMkhWz3doF6jWAw--.24466S7;
	Thu, 17 Jul 2025 00:12:12 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v14 5/7] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
Date: Thu, 17 Jul 2025 00:12:01 +0800
Message-Id: <20250716161203.83823-6-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716161203.83823-1-18255117159@163.com>
References: <20250716161203.83823-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnMkhWz3doF6jWAw--.24466S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrCr4UAF1ruw1kCw1DAwb_yoWrZFWUp3
	yrAwn0yF4UAr1aqw1DZFnIv3W3AF9xAF1xAa97Gwnavry2kryUJ340krWagrnakrZFgFya
	gr4kJFyrArnxtFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEwvtiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwKMo2h3yadzGQAAst

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes since v13:
- Use simplified macro definitions: PCI_FIND_NEXT_CAP(), PCI_FIND_NEXT_EXT_CAP().

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
index 4d794964fa0f..b503cb4bcb28 100644
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
+	return PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
+				 pci);
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
+	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
@@ -302,8 +251,8 @@ static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
 	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
 		return 0;
 
-	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
-						       PCI_EXT_CAP_ID_VNDR))) {
+	while ((vsec = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, vsec,
+					     PCI_EXT_CAP_ID_VNDR, pci))) {
 		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
 		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
 			return vsec;
-- 
2.25.1


