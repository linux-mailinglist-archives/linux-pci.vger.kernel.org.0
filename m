Return-Path: <linux-pci+bounces-25529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7CA81BB7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 05:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E6B1B67F58
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 03:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09CF157E6B;
	Wed,  9 Apr 2025 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="czI78n2P"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA47258A;
	Wed,  9 Apr 2025 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744171079; cv=none; b=PIyrbdRLv9DyGSJcvSLu/ZYdpoOze4Q/iSdRb22tfd1hxPXxODP+YqElklQeLOKe2lh19jRiH5GNC8BS5g6XxrwY2ekjSKotWl/Fq93k5x5ceD3Ok4aTz7rlJrxY92l5Ye2DZAsboXkPyTHWUvdw+CZdAz/I/SL5H+SxYjCnnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744171079; c=relaxed/simple;
	bh=C8VoMDP/9DwEUbnuWChyJAzFBxjjKZGOkfQ/fb1wU68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=spb4V/XG3csNqsqUAmHThMwyOCu437iH2us+H2kNDnQuO3eZHIFyxBs9tl1XJf7AV1jkY8SB2BixADb1oxKs7u8CbPq6N/VEsHJs4qS1K5BGeYHp0dxhdWCiagCVGDiZv4/qxqgFlO/A8e9qZhE7xIo8OdQyrra121cjnQM7QG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=czI78n2P; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KKEef
	WvqrG4PzRUfHiysIFUryV3aK/Eeg4jpW8eL55c=; b=czI78n2P/yvESCIDnKo8I
	FCgXJj2+3LlfT9p1VD/pT+z4i6MeXMTR8OyRV5ra286hV1YuOZtJmaTzKaQpRUJk
	somfp2KLxKAGMGX9LK+8NiexIfh80jVVoFpiNsOir2aHetfBRTXHEAfaXXnroPuG
	hXcYTSIihe+Rx39jgTKSFc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHD3GH7PVnbwQBFQ--.4446S6;
	Wed, 09 Apr 2025 11:42:06 +0800 (CST)
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
Subject: [PATCH v9 4/6] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
Date: Wed,  9 Apr 2025 11:41:54 +0800
Message-Id: <20250409034156.92686-5-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250409034156.92686-1-18255117159@163.com>
References: <20250409034156.92686-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHD3GH7PVnbwQBFQ--.4446S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxury5Cw17JryfCFy7ZrW8JFb_yoW5ZFWDpa
	yrA3ZYkr4rtr4aqa1qvFnIyFy5AF9xAFWxZa97GwnavF12krWjg340kayaqF1IyrZFgF13
	Kr48JF95Cw1ktFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEbAwPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhEqo2f16yc8WQAAsZ

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
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
 drivers/pci/controller/dwc/pcie-designware.c | 72 ++------------------
 1 file changed, 7 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 97d76d3dc066..274f1add95b0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -205,83 +205,25 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
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
+	struct dw_pcie *pci = priv;
 
-	if (cap_id == cap)
-		return cap_ptr;
+	*val = dw_pcie_read_dbi(pci, where, size);
 
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


