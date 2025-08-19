Return-Path: <linux-pci+bounces-34310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA48B2C7F7
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 17:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C4E17DB02
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF964285058;
	Tue, 19 Aug 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S6N69x24"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C296283FE5;
	Tue, 19 Aug 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615603; cv=none; b=bTJvVKDX8lo6OEoi49tSuQa4Yrj1n0Wx3NFKwlAzuTyi+wngaXl9R02t639AqL2e9w/YV/HsF2b5gVnhVtjzhVM93zt6V4plcS52yOiDJ30WZRUiSmWzVN2Iv/nLo9G4XnT5rearRPRDSP8ZO7QrADXK41G+8AK1XQlzp9LNQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615603; c=relaxed/simple;
	bh=Yilw6ElsTDFQFS4yTwUVO0/7TFBEDVN4P9FjnT8mZzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VCxRjps0CPcDWWY7/raDZOhFxWqG8jFI13h9j74NgXYsb/XaYW5R+zXMc9UhaKkeTJi1C8GvkoET3iHmmwkN/8rRvdF7sN99ldWAn+Uhbvg5cW0uG4C4AfViaWlruF+igioINPD2D14jjhE9QS6myFZKT+xHcJzp7uu6sQSe9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S6N69x24; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gg
	anK5XliHOL41hQafEOQM8fWffCn/9NgkkF0q9Hvcc=; b=S6N69x24wdJFm26087
	aJ5Vb7hF7UILjl9b634kjHPAInPIl09wsmIHnPqCYHrO8bnyPx2M4R6+ZiIXZjSS
	vF74REBj/weynrm/wvKC3dmvVd45TVUwk0LBeNKi9jt88Z/eCask6wlhpNrfcDC9
	OiTfwCKcwZKiBO2jLscCnQcao=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD31+UVkaRoey7yCw--.24652S2;
	Tue, 19 Aug 2025 22:58:30 +0800 (CST)
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
Subject: [PATCH v2] PCI: endpoint: Implement capability search using PCI core APIs
Date: Tue, 19 Aug 2025 22:58:28 +0800
Message-Id: <20250819145828.438541-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31+UVkaRoey7yCw--.24652S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4ftw1fZw48uw45ArW5ZFb_yoW5urWrpa
	yrXFyakr4UtF1Yq3ZIvan8Ary5XFn8AFy5C39xG3WSvF17ZrWUW348CFW5try7Kr4jgryr
	Kr42qFZ5Wr13Ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAR67UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgGuo2ikjXoP8wABsw

The PCI core now provides generic PCI_FIND_NEXT_CAP() macros to search
for PCI capabilities, using config accessors we supply.

Use them in the DWC EP driver to implement dw_pcie_ep_find_capability()
instead of duplicating the algorithm.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes for v2:
https://patchwork.kernel.org/project/linux-pci/patch/20250616152515.966480-1-18255117159@163.com/
- Rebase to v6.17-rc1.

- Based on the following branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 31 ++-----------------
 drivers/pci/controller/dwc/pcie-designware.h  | 21 +++++++++++++
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ae54a94809b..7f2112c2fb21 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -69,37 +69,10 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
 
-static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
-				     u8 cap_ptr, u8 cap)
-{
-	u8 cap_id, next_cap_ptr;
-	u16 reg;
-
-	if (!cap_ptr)
-		return 0;
-
-	reg = dw_pcie_ep_readw_dbi(ep, func_no, cap_ptr);
-	cap_id = (reg & 0x00ff);
-
-	if (cap_id > PCI_CAP_ID_MAX)
-		return 0;
-
-	if (cap_id == cap)
-		return cap_ptr;
-
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
-}
-
 static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 {
-	u8 next_cap_ptr;
-	u16 reg;
-
-	reg = dw_pcie_ep_readw_dbi(ep, func_no, PCI_CAPABILITY_LIST);
-	next_cap_ptr = (reg & 0x00ff);
-
-	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
+	return PCI_FIND_NEXT_CAP(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
+				 cap, ep, func_no);
 }
 
 /**
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b5e7e18138a6..a44f2113925d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -695,6 +695,27 @@ static inline u8 dw_pcie_ep_readb_dbi(struct dw_pcie_ep *ep, u8 func_no,
 	return dw_pcie_ep_read_dbi(ep, func_no, reg, 0x1);
 }
 
+static inline int dw_pcie_ep_read_cfg_byte(struct dw_pcie_ep *ep, u8 func_no,
+					   int where, u8 *val)
+{
+	*val = dw_pcie_ep_readb_dbi(ep, func_no, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int dw_pcie_ep_read_cfg_word(struct dw_pcie_ep *ep, u8 func_no,
+					   int where, u16 *val)
+{
+	*val = dw_pcie_ep_readw_dbi(ep, func_no, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int dw_pcie_ep_read_cfg_dword(struct dw_pcie_ep *ep, u8 func_no,
+					    int where, u32 *val)
+{
+	*val = dw_pcie_ep_readl_dbi(ep, func_no, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static inline unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
 						      u8 func_no)
 {

base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.25.1


