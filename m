Return-Path: <linux-pci+bounces-24374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CFA6C032
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 17:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89691897961
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E722D787;
	Fri, 21 Mar 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Zo7IRVu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F422D4D9;
	Fri, 21 Mar 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575119; cv=none; b=R8DxweyZA4DuYpC/iq7C6yePEmbql8IOybd77CP0kARoQvmMpe+TH/Y8iYaK0vTjz49SIRQgfvBciL1tlN2RGJ1J7z4gYfZw7nIqj5364scyzSR6PFfF/oEpHw1MS/QibZQVqYJ237U+OipDs43e432Qr+oEFyxBR6JIRwPpMR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575119; c=relaxed/simple;
	bh=zZ4zGAGKlQgJXOfaMaHkjpRjZM8DnsrpQ9leZKh5gRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHTSXN9gvUYux0St/Ee+vN8EciU3sQdiZnauJLndrsE2N4JEmbDHElfwWX2gUkOQFpUJCsh1grSStozgzHhu0DiwLmUBGoCCjuEUrE0LfBCFGVKCDrEfK3tbX84Ctq9Mstjn8u0zSC8hxDdZnXXQlOFJgLze1J9RLPLA6MpckzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Zo7IRVu6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Estu5
	Bssy54LqLpfEBxpENJ+dUh23iyReSwXS6S41qA=; b=Zo7IRVu6lC8rU3d1kGI3s
	A5BZQWnlWJhnwLYGxWgYaiN6i8wpIbscp2YWQMc5J1lUJS6IfRzrbW8ikz3zkbgY
	Ls02PqkMHpM8cVqUku+OA+nC1+jufj/SQ2CWfBEOnEmax37gqAGuJkyrP7CaBcxz
	hbB5zru3o11cgAx3KhlUNg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wC30e7sld1nnmPrAw--.48109S4;
	Sat, 22 Mar 2025 00:38:06 +0800 (CST)
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
Subject: [v5 2/4] PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
Date: Sat, 22 Mar 2025 00:38:01 +0800
Message-Id: <20250321163803.391056-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321163803.391056-1-18255117159@163.com>
References: <20250321163803.391056-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC30e7sld1nnmPrAw--.48109S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrW8Kr4DZr17uw4DCF48JFb_yoW5AFyrpa
	yrA3WYkFWrtr4Yqw4qvFnIyF15AF9xAFWxAa97GwnavF12krWYg340kaySqF1xArZF9F13
	Kr4xtas5Cw1kJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi8pnLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw8Xo2fdjwDOvQAAsm

Since the PCI core is now exposing generic APIs for the host bridges to
search for the PCIe capabilities, make use of them in the DWC driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v4:
https://lore.kernel.org/linux-pci/20250321101710.371480-3-18255117159@163.com

- The patch subject and commit message were modified.
---
 drivers/pci/controller/dwc/pcie-designware.c | 71 ++------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

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


