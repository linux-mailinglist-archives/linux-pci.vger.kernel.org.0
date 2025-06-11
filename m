Return-Path: <linux-pci+bounces-29473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891BAD5C3C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEC9173546
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2321CA12;
	Wed, 11 Jun 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GoxKTaUy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8820F078;
	Wed, 11 Jun 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659535; cv=none; b=Nv6oDSCqT4LQDCOnqy3JrbDlb7O3ZJf2tvKURCjyZJIhnxge1brcVJRCvbPhwdJKmDKroz9IHDEOvzMItgEEnvjT6RwzaIKMEoXtVBpevgBaWuMvuXi+XIkXkkVmMNepbn0F/iglE6mzzbCHOdxcR7PNMpalPbgGcPgwG0TYCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659535; c=relaxed/simple;
	bh=uHw15SEfgJhjk0plrbNOxwEmIEjDnYKRuTeithPcYq8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iv6eu635zCPT6CwLyocLWjYjw2oqv0pm40tX2sW579jOYSK5C1hXmtUBlLjHcjlwBm60PTLYCNN8kTOcQvwRVXFpi5yB+BmvoEvWIR2aV9CV2RfpehNa2CERmtdo1UyzeTchXk1fHRLgo+3UNCalL3CwnhfS+s4peZJupvEIzdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GoxKTaUy; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lz
	037P2kaVzqsQ34A3LWfibKKWlS33MGjH64LQLCkDA=; b=GoxKTaUyI0TGDHRVjK
	FO5MnXiZN9U+cfNONyFVWapz6R2YTiLPpMe99tlriVS5PDO25mB4XKivEJ+0ilox
	VB8tfhQVN5IaSg/wtyF5z8nipX46i2t1yH7u6aWRQBIkjqAR8Ddp1s94YPFERIqB
	DpM8SBX3vWGxIrSNjiHxUc8dc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCnJjB8r0lofqUXHg--.21328S2;
	Thu, 12 Jun 2025 00:31:57 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 08/13] PCI: dwc: Refactor rockchip to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:31:54 +0800
Message-Id: <20250611163154.860976-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnJjB8r0lofqUXHg--.21328S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rGr4Dtr1DJF1ruw18Grg_yoW8CrW5p3
	y3Aa4akF4rJw4rua1kAa97ZF13ta9xAFW7JFZ3Gw1SqFy2k34DKF1YkFyaqF1xGr42vF1a
	93yUt3yUZa13AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEnmiiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw1po2hJpj-hUQABsV

Rockchip PCIe driver implements L0s capability enablement through
explicit register read-modify-write. The current approach reads the
LNKCAP register, modifies the ASPM_L0S bit, then writes back the
value with DBI write protection handling.

Refactor ASPM capability configuration using
dw_pcie_clear_and_set_dword(). The helper combines bit manipulation with
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
index 93171a392879..e6bd9c54b164 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -194,15 +194,14 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 
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
+		dw_pcie_clear_and_set_dword(pci, cap + PCI_EXP_LNKCAP,
+					    0, PCI_EXP_LNKCAP_ASPM_L0S);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 }
-- 
2.25.1


