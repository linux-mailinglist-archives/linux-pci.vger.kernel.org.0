Return-Path: <linux-pci+bounces-24323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E997A6B8A5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 11:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2101889669
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6A1EEA42;
	Fri, 21 Mar 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lHH9tqsU"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1131D9A50;
	Fri, 21 Mar 2025 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552305; cv=none; b=e5qsBVU54D1WUU+7qx4ek3g/Hd2SlOJK0WSnFlNGC9/vWhGQRN++Xgvf2DIpLcpw6LBZ8JGiN3Ih3Wcvv6IBD356J+68DPBKAP6zljP87YGePX4ohWQvJaGfyU1YST3SbH11Al3W390rVmULWOT2p/Id9Bz1nXPX23II/s5oO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552305; c=relaxed/simple;
	bh=ox5udzqG/KT9+OZArNDmLfoIcNRtLjZn0Kaw0AnGc3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WNlWgc58TVIPNEf1pleOITxn4njHRkJbOwiXohPLLyzXPqLRfbQgxuB02c+eORh0vSv7W0kiUza9WqfHWAoFgRQgiD1Vag5YtQM795XRMo4bivPPDEjTceZVZcDoOkacchdMCR15ndQ6Zwd6S4c5fH/5D2WSyP5o1I4bHw6C8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lHH9tqsU; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=STvJs
	11cV91iEDVl7C6DCjKJOOl/s9f4G1GvVfDsg64=; b=lHH9tqsUchayuuuWIN9CU
	fS6F1X9QSQ+VhnQ0RkTFOrmCwS+x6FzYrWRkhNi053OOu+X1dCkExpIix4C4jAj/
	pk4YbWoi1+3V9pbns6pqpfixMpQ4J+ZOOawXh4UCF2BTUJcTQ9aDQoEVohj+4hIH
	T5fC5+BzhTYdoOhw/6n468=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnKl+oPN1n7W5_AA--.28658S4;
	Fri, 21 Mar 2025 18:17:14 +0800 (CST)
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
Subject: [v4 2/4] PCI: dwc: Replace dw_pcie_find_capability() and dw_pcie_find_ext_capability()
Date: Fri, 21 Mar 2025 18:17:08 +0800
Message-Id: <20250321101710.371480-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321101710.371480-1-18255117159@163.com>
References: <20250321101710.371480-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgCnKl+oPN1n7W5_AA--.28658S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF17JFy3JFWDCrW7ury5CFg_yoW5XFWrpa
	yrAF1FkF4Fyr4Yqw4qvFn0vr13AF9xZFyxJa97G3ZavF1akrW5K340yaySqFn3ArZF9F13
	Kr4Utas5Cw1kJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_wID_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgIXo2fdNOjr+AAAs5

Replace duplicate logic code. Use a common interface and provide callback
functions.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 71 ++------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..2ebebedbf18d 100644
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
+	return pci_generic_find_capability(pci, dwc_pcie_read_cfg, cap);
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
+	return pci_generic_find_ext_capability(pci, dwc_pcie_read_cfg, cap);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
-- 
2.25.1


