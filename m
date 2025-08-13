Return-Path: <linux-pci+bounces-33947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA195B24C72
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D19173B8A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823B2F49EF;
	Wed, 13 Aug 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fvUVJlQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4169194C96;
	Wed, 13 Aug 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096371; cv=none; b=Ns4oMa3D3gxVgOjtDE5pZdqVIMpEetSKnoiY/6DMrKlKVmkqCrQCEWBw7znMxK97b3L93VAuH7KCbuVIRpaIDy6J+wxLYHImZYATPBpQ8rFm1duxTaqdJvr1Hm0/ugTIOnVNZy8vEEMSm90U1lHPXBJIQCgVcEGAV9yDMBclaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096371; c=relaxed/simple;
	bh=Zuk70YaR6eO6mQ4DX+4R2evtpSrgg5AHtJF3k7jF6+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X6cHPwPFlwsGRvZoZqibQL2B+icxuF35IdMTGApthauJZNVe/S9WP4ndWXGevXy1zMX/pbXrhPxK+9OyXRoFPKKrgEFbwd6/QeeDxri+dwlQ7m0yzIoZSpsAYJZKUVCHcJGzDaSikiCH+p7Gp9/z6Nx/bHB7B1+ubgSBDYkXqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fvUVJlQS; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ez
	w+x6CPBZoj0Ns1BR+CJgZEtXO9GLRlu49I9UBWAjo=; b=fvUVJlQSa0Xz/B41nu
	peYEg5upAy/RF/pG9jgReYRCiZQwxHHACqGqBlWvvwesBjt6RQ0mXhSBXscpMxML
	VpGxcs036P6n6u4rUwt6bq5kcYNYG66Hg8QrrKFmz/HUK7q2mhCINNYSSSuG7oG3
	KLYdKJbUKY+S+0ThQeLig5GKM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHYosMpZxo4mzXAw--.28032S6;
	Wed, 13 Aug 2025 22:45:36 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	schnelle@linux.ibm.com,
	gbayer@linux.ibm.com,
	lukas@wunner.de,
	arnd@kernel.org,
	geert@linux-m68k.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v15 4/6] PCI: dwc: Use PCI core APIs to find capabilities
Date: Wed, 13 Aug 2025 22:45:27 +0800
Message-Id: <20250813144529.303548-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813144529.303548-1-18255117159@163.com>
References: <20250813144529.303548-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHYosMpZxo4mzXAw--.28032S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyUtF4xur13ZF4fKF1rJFb_yoWrCFyfpa
	y5JFyFyFWrAr4Yq3ZFv3Z8ZF13AF9xZFy7Ca97G3ZavFy2krWjg340krW3tr1xKrW2gry3
	Kr4xtFyrCFnxJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pil4EiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgmoo2icmifhagAAs6

The PCI core now provides generic PCI_FIND_NEXT_CAP() and
PCI_FIND_NEXT_EXT_CAP() macros to search for PCI capabilities, using a
config accessor we supply; use them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 77 ++------------------
 drivers/pci/controller/dwc/pcie-designware.h | 21 ++++++
 2 files changed, 26 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..5fe0744d4235 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -213,83 +213,16 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
 		pci->type = ver;
 }
 
-/*
- * These interfaces resemble the pci_find_*capability() interfaces, but these
- * are for configuring host controllers, which are bridges *to* PCI devices but
- * are not PCI devices themselves.
- */
-static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-				  u8 cap)
-{
-	u8 cap_id, next_cap_ptr;
-	u16 reg;
-
-	if (!cap_ptr)
-		return 0;
-
-	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	cap_id = (reg & 0x00ff);
-
-	if (cap_id > PCI_CAP_ID_MAX)
-		return 0;
-
-	if (cap_id == cap)
-		return cap_ptr;
-
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
-}
-
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
 
@@ -302,8 +235,8 @@ static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
 	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
 		return 0;
 
-	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
-						       PCI_EXT_CAP_ID_VNDR))) {
+	while ((vsec = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, vsec,
+					     PCI_EXT_CAP_ID_VNDR, pci))) {
 		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
 		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
 			return vsec;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..b5e7e18138a6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -609,6 +609,27 @@ static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
 	dw_pcie_write_dbi2(pci, reg, 0x4, val);
 }
 
+static inline int dw_pcie_read_cfg_byte(struct dw_pcie *pci, int where,
+					u8 *val)
+{
+	*val = dw_pcie_readb_dbi(pci, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int dw_pcie_read_cfg_word(struct dw_pcie *pci, int where,
+					u16 *val)
+{
+	*val = dw_pcie_readw_dbi(pci, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int dw_pcie_read_cfg_dword(struct dw_pcie *pci, int where,
+					 u32 *val)
+{
+	*val = dw_pcie_readl_dbi(pci, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static inline unsigned int dw_pcie_ep_get_dbi_offset(struct dw_pcie_ep *ep,
 						     u8 func_no)
 {
-- 
2.25.1


