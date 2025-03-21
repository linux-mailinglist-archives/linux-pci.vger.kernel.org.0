Return-Path: <linux-pci+bounces-24300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E479A6B390
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 05:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1774850FE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 04:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DF1E8837;
	Fri, 21 Mar 2025 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q5kle9s2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69E1E8333;
	Fri, 21 Mar 2025 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529898; cv=none; b=PDaLbI6KhUcTaqODt3B6b/pxQtVgIrobZYCXGP7LLE4gu3rLLbWwtp6GdvowMgRzshj8eFlwXdaKBnGRYd2txXGSf2VOVIou7ulXtEZJCsZcbyKimFXVQz3FDnzziTD9Qi5O/Bzovy+bgd64mvyA5RTtlrw5rBcMQbATLfUdYvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529898; c=relaxed/simple;
	bh=ox5udzqG/KT9+OZArNDmLfoIcNRtLjZn0Kaw0AnGc3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNEibxIrW9D9/6KLqEXPp/5sM3jp09bC3VmndyyS9GQ+TIWeLv3O4ECf1masPIK19aSXqobjhEgdTt2RabFOFQak314Kmqxy6g1rNEiFTFamJAkAfomK6e3UXx0buLYNgBqpRtvoKwmvCoBkcVX9+T+8u5D4g28HAuJvUdRPWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q5kle9s2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=STvJs
	11cV91iEDVl7C6DCjKJOOl/s9f4G1GvVfDsg64=; b=Q5kle9s2WP8ap8s9/f/Zg
	PVx+9lYHniIVlrUKmBpAx5XJSLinFfAMNCm+aSSVien+OlMFob8PDy800eo9+4nw
	7F9lSAhqHrpQ4nUFHMs2Ot5tzF6M5fIApGVJhPoydoY1QD/25v+nVoVL2bGAc0oW
	sKIjlfYrGBEcvJYWXdWgTk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3Hxsw5dxnbYNpAw--.34788S4;
	Fri, 21 Mar 2025 12:04:03 +0800 (CST)
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
Subject: [v3 2/4] PCI: dwc: Replace dw_pcie_find_capability() and dw_pcie_find_ext_capability()
Date: Fri, 21 Mar 2025 12:03:56 +0800
Message-Id: <20250321040358.360755-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321040358.360755-1-18255117159@163.com>
References: <20250321040358.360755-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hxsw5dxnbYNpAw--.34788S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF17JFy3JFWDCrW7ury5CFg_yoW5XFWrpa
	yrAF1FkF4Fyr4Yqw4qvFn0vr13AF9xZFyxJa97G3ZavF1akrW5K340yaySqFn3ArZF9F13
	Kr4Utas5Cw1kJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_SoG_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxUXo2fc32Nz2QAEsH

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


