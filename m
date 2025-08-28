Return-Path: <linux-pci+bounces-35024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB54B39F93
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3C77B6DB2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CB23E356;
	Thu, 28 Aug 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hqa9/Mk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4F22A4DB;
	Thu, 28 Aug 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389660; cv=none; b=TyzZ2d+0fhwqavonX4PQqkhAInxHYMegfJPRUh5aGIlhrfMAPA8xjen6tjaXkNPoGZT7uZUVCyqCdV4SZqLgUapboUxNDh4O8hfMJ3XBDtjEGvgVYmZbA5Z0PwCKUgG36QVVUSgetge0ooJLkAyHVn+in6inTd+i9F6OlJokvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389660; c=relaxed/simple;
	bh=uKX3u+7TAuRUgEMD94/9A98zZk0ula4Uf+ogFZSQO+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SzBnJwDUgVejr8YVRj77ILE7zhDdztPMbxcqYzE0WtSPPBVOT8y9NZ2zP73iFVIIw8AEXidGjiPTrrlHfT77lAXZYJk8BaTO+FqWlm7BTLpJkN2VRo9Uim1fcOGOP8Gc0xbzH6KtWXCbUwN3L8vQ9qtmF5kZJIykKv/kfS7o3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hqa9/Mk0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=St
	4Y96243DO+FdBkAHidwX6lVuq6DmFHeHuVh5cyFz4=; b=hqa9/Mk0kVSxF+Iqf6
	jU1kBpG9Ip97CKYJ8580ZDDHeNvL1POj5+X3bzZ2LPX9g/Q1mKf223rV4Hk+MqZZ
	1SdRSluVoOE/DrBMnxwJQBjFmxUcZqACS2igBN/ucGo/P/eeP+EN2VgNSUilCzq6
	8I4uJmtAH3mnSLesN1orQNaFM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXJYwNYbBoRejWEw--.829S2;
	Thu, 28 Aug 2025 22:00:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 08/13] PCI: dw-rockchip: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:46 +0800
Message-Id: <20250828135951.758100-9-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXJYwNYbBoRejWEw--.829S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rGr4Dtr1DJF1ruw18Grg_yoW8Cr1Dpa
	9xAa4ayF4fJw4rua1DAa97ZFy5ta9xAFW7Jr9xGw1SqFy2k34DJ3WYkFy3tF1xGr42vF1Y
	93yUt34UAF43AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKhFxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxa3o2iwWlmlJwAAsA

Rockchip PCIe driver implements L0s capability enablement through
explicit register read-modify-write. The current approach reads the
LNKCAP register, modifies the ASPM_L0S bit, then writes back the
value with DBI write protection handling.

Refactor ASPM capability configuration using
dw_pcie_*_dword(). The helper combines bit manipulation with
DBI protection in a single call, replacing three-step manual operations.
This simplifies the capability setup flow and reduces code complexity.

Adopting the standard helper improves maintainability by eliminating
local variables and explicit bitwise operations. The change also ensures
consistent handling of DBI write protection across capability modification
functions.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index b5f5eee5a50e..5ae923907531 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -196,15 +196,14 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 {
-	u32 cap, lnkcap;
+	u32 cap;
 
 	/* Enable L0S capability for all SoCs */
 	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	if (cap) {
-		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
-		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
 		dw_pcie_dbi_ro_wr_en(pci);
-		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+		dw_pcie_set_dword(pci, cap + PCI_EXP_LNKCAP,
+				  PCI_EXP_LNKCAP_ASPM_L0S);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 }
-- 
2.49.0


