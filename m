Return-Path: <linux-pci+bounces-29876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2AADB548
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B37171F75
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD622127C;
	Mon, 16 Jun 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N2uGulhZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8911F0995;
	Mon, 16 Jun 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087538; cv=none; b=DJQhn06rDs393eEl3TjyzqzLzc6yeeai7AFGhtUgyvMwMeDgYFMueVTsq/g44wchGdbCsdB/nFeKhcE0laukmynq5Em5PqwKwoJriUoTc2EY/I7vwOc0yaGlj5W0Cu1wqnGv5J6Lsw9m9ABhruF11ZnvVEpHCXDvXYaoD7ElWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087538; c=relaxed/simple;
	bh=dqCC8ak/91Dzr4+3kecF6KVGO0oq/uGowumULvxPFCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIlkVHXIlJ65FZc0eLHwhDj3KaWgBMhNO8oG1Lz9idXCfvCwRjyIkpQAHMhSIWKNUV2dczqRS39L9tJ2BML5QZyPMPHYXPONTCVjBX1RQBSLDp0l/uJK4IoiJxn/g5/8nM6gm3ATrxXM93WyHgdobwfwT1fQU6FOWMeGuP/n2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N2uGulhZ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yh
	CLHY+Yn5QZ5riQsIqS3LeSsfbH4BcVgHt29CWBC98=; b=N2uGulhZDW3wO2TBkk
	O8pJE5fVzrKggDDY/cSjM2i4EQ7/wLW8nEPrillstJMX22Shyljl3MB+G3kfT8o1
	2sOdTzImUgNoGw7xFSisfo+J0sfvJS8D13EWuvOMWMdQjzA87T86ZxKqfrJ1t1IR
	sBBMhoEdh6JaX7gyqapnwFQ5g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnr6ZcN1Bo7z_bIw--.19402S2;
	Mon, 16 Jun 2025 23:25:17 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: endpoint: Use common PCI host bridge APIs for finding the capabilities
Date: Mon, 16 Jun 2025 23:25:15 +0800
Message-Id: <20250616152515.966480-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr6ZcN1Bo7z_bIw--.19402S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5Ww4Utw4DWFyfGw1DAwb_yoW5JFyDpa
	yrZry5Cr4UKF1Yq3ZxAFZxZr98ZFn8AFWUZ39xG3WSvr17Zry3W34IkFW5Kry7KF4jgrWf
	KrsFyFWrWr1fGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pELvKUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwRuo2hQL1TsVQAAsw

Use the PCI core is now exposing generic macros for the host bridges to
search for the PCIe capabilities, make use of them in the DWC EP driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
- Submissions based on the following patches:
https://patchwork.kernel.org/project/linux-pci/patch/20250607161405.808585-1-18255117159@163.com/

Recently, I checked the code and found that there are still some areas that can be further optimized.
The above series of patches has been around for a long time, so I'm sending this one out for review
as a separate patch.
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 39 +++++++------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ae54a94809b..9f1880cc1925 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -69,37 +69,26 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
 
-static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
-				     u8 cap_ptr, u8 cap)
+static int dw_pcie_ep_read_cfg(void *priv, u8 func_no, int where, int size, u32 *val)
 {
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
+	struct dw_pcie_ep *ep = priv;
+
+	if (size == 4)
+		*val = dw_pcie_ep_readl_dbi(ep, func_no, where);
+	else if (size == 2)
+		*val = dw_pcie_ep_readw_dbi(ep, func_no, where);
+	else if (size == 1)
+		*val = dw_pcie_ep_readb_dbi(ep, func_no, where);
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	next_cap_ptr = (reg & 0xff00) >> 8;
-	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 {
-	u8 next_cap_ptr;
-	u16 reg;
-
-	reg = dw_pcie_ep_readw_dbi(ep, func_no, PCI_CAPABILITY_LIST);
-	next_cap_ptr = (reg & 0x00ff);
-
-	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
+	return PCI_FIND_NEXT_CAP_TTL(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
+				     cap, ep, func_no);
 }
 
 /**

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1


