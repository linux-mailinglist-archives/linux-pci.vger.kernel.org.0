Return-Path: <linux-pci+bounces-24467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28159A6D012
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 17:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D55A3B1797
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0201519BA;
	Sun, 23 Mar 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F0bpFi23"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24D14A095;
	Sun, 23 Mar 2025 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742748622; cv=none; b=d481ZO76c9Rn9cHNtOSu9QefHBp+0HvnYA/9GBDdMilw/rxn4V4Vk994mZVRnr/lAvsnwELEd+XBx9iragC5e0/m9gKPexWmgz5S3riosaC52ab1q02h94QSlWkJoFLeUkYQwbozItOvi+NDznlrI17s3J1ASAHbYW7UOsKfpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742748622; c=relaxed/simple;
	bh=BtpuPY7JCH5W7VeokWi2CwBGEQ9np3s8ATJZlM16fwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6+bHQQWikDmUCBEpuFYZ8Ws8zWcVWKYf3QdKXOHOrkzvMhliuatf3l6W3WD/R/cixLXhXwvXJpveDwwwrks/mEohVjKP3JnE9enfTUuy70R/sZtqrLiW3RkTVAJvdX2tNJXT522xqPkMDhG7Ah1Kpd8N/CH2aRe4upkrGAjmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F0bpFi23; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Yuf7a
	9gDP6xV/lu/meDBbizvdOMyNvgih8oGcQ+6UA4=; b=F0bpFi23PsAPS0hU+wHRa
	AkllcPjwEAM/CW05LKCx790wBFNvkAvPkqYwD2nKG7zgWNi27irO+UhItXm/CGnr
	a2ZZAchZMRBqDRO4DDwJJBhqrsgyQpeBf9I+niqZvD58YfC3mvJUkxSpmeTJgj+4
	Z+u/yhuKpKD4PvkcPkcBy8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXX3qlO+Bnk_g8AA--.12082S4;
	Mon, 24 Mar 2025 00:49:43 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v6 2/5] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
Date: Mon, 24 Mar 2025 00:48:49 +0800
Message-Id: <20250323164852.430546-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250323164852.430546-1-18255117159@163.com>
References: <20250323164852.430546-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXX3qlO+Bnk_g8AA--.12082S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF45JrWfKr4UKw45JrWDArb_yoW5uw4kpa
	yrJ3WakF1rtF4Yqw4DA3WFkF15AF9xAFW7Aa97GwnavF17CrWUu340yaySqF1fArZFgF13
	Kr48ta4rCr18JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi038nUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxkZo2fgMcLw5QAAsZ

Since the PCI core is now exposing generic APIs for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v5:
https://lore.kernel.org/linux-pci/20250321163803.391056-3-18255117159@163.com/

- Kconfig add "select PCI_HOST_HELPERS"
---
 drivers/pci/controller/dwc/Kconfig           |  1 +
 drivers/pci/controller/dwc/pcie-designware.c | 71 ++------------------
 2 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..c71b3ad44f3e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -5,6 +5,7 @@ menu "DesignWare-based PCIe controllers"
 
 config PCIE_DW
 	bool
+	select PCI_HOST_HELPERS
 
 config PCIE_DW_HOST
 	bool
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..0329f233cf11 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -203,83 +203,22 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
 		pci->type = ver;
 }
 
-/*
- * These interfaces resemble the pci_find_*capability() interfaces, but these
- * are for configuring host controllers, which are bridges *to* PCI devices but
- * are not PCI devices themselves.
- */
-static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
-				  u8 cap)
+static u32 dwc_pcie_read_cfg(void *priv, int where, int size)
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
+	struct dw_pcie *pci = priv;
 
-	if (cap_id == cap)
-		return cap_ptr;
-
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
+	return dw_pcie_read_dbi(pci, where, size);
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
+	return pci_host_bridge_find_capability(pci, dwc_pcie_read_cfg, cap);
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
+	return pci_host_bridge_find_ext_capability(pci, dwc_pcie_read_cfg, cap);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
-- 
2.25.1


