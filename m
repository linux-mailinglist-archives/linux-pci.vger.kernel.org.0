Return-Path: <linux-pci+bounces-25160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D7CA78EAD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9515D163459
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C94238D54;
	Wed,  2 Apr 2025 12:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IP2AtXi+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E7469D;
	Wed,  2 Apr 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597497; cv=none; b=S0XmH0nGp5Og93802Df/tL7LGb/detfaHLWno4uJ1lrHfR0esdf6NDh+AIAHsNUpqBxVv8yNjkKiy18SSFhoFz2/szBV9nMPPkJHFYqu6Dklpm2MzvdJlS5X2UZqdak4WTQbyVi2VLLWgXuDSspcf+/IoTLDxxfsfd/N8VQLELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597497; c=relaxed/simple;
	bh=rqBovMVHDqLoSdwsgOwFJTg6qxDbvL2LauSNY66ZxX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogD//eRagNyfhg2jfohxwtcm3UnzfpvdNSunMTbFYj4wPdc7/XSqBYECArxxS3W+P4SDKBMzCx+yeHkSYj20CTTOMO3t9Vp/v9f8E0ZSqsgKkG4OiN6PC4uv9k4EsefpihbBpN/HJXfE08NZsXMmIodbhfUGwVg9T0uQsSe2TuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IP2AtXi+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iprjK
	QascAma72b8ssTYfHVklAFJft/JzeNryBFLrLc=; b=IP2AtXi+ruDFBP/1N4g7T
	oMu9i3Medo0Yn/4XLc6yCfnQt8+aRLxctce+5x6sMr0rDX0Dn7kzD9OohMcReS+6
	ER3cFsV4SgQcuIrIWAQ1FqeMHemVnCztFvNEGO67anMZf/uqGyLA7At3QntRo+Rj
	ZaZ1kTNIiLit+N172USnAY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXrkiUL+1nL3+IAA--.22499S5;
	Wed, 02 Apr 2025 20:37:48 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v8 3/5] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
Date: Wed,  2 Apr 2025 20:37:34 +0800
Message-Id: <20250402123736.55995-4-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402123736.55995-1-18255117159@163.com>
References: <20250402123736.55995-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXrkiUL+1nL3+IAA--.22499S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryrKFW8KrWDCry8Jw1DJrb_yoW5Aw18pa
	yrAa4Fkr4rtr4Yqw4qv3ZIyF13AF9xAa47Aa97Gw1SvF12krW3K340kayaqF1IkrZF9F13
	Kr4UtFyrCw1kJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYApwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxYjo2ftKgmL8QACsc

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v7:
https://lore.kernel.org/linux-pci/20250402042020.48681-4-18255117159@163.com/

- Resolve compilation errors.
---
 drivers/pci/controller/dwc/pcie-designware.c | 72 ++------------------
 1 file changed, 7 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..af6a4930f6a9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -203,83 +203,25 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
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
-
-	reg = dw_pcie_readw_dbi(pci, cap_ptr);
-	cap_id = (reg & 0x00ff);
-
-	if (cap_id > PCI_CAP_ID_MAX)
-		return 0;
+	struct dw_pcie *pcie = priv;
 
-	if (cap_id == cap)
-		return cap_ptr;
+	*val = dw_pcie_read_dbi(pcie, where, size);
 
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
 
-- 
2.25.1


