Return-Path: <linux-pci+bounces-29073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904EBACFAFB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 03:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0353B0C85
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 01:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4947D19D071;
	Fri,  6 Jun 2025 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c451iHvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F04199924;
	Fri,  6 Jun 2025 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175072; cv=none; b=tN4r+Xc2pVj6dvL6c2eEEkBXBHtoo+pjiQncBIgcKBB1twQyh4AEy6MHzwF1+HljYl9odukCGPVy0nOAKROj/15VYUhnjR4X+bUCV4tVSlNVvTunpaEGwd7uo6kbWYm9qwNRuaFonmDL4O2r+VjwMAqcrRVE4sc3QsTlLjd/IyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175072; c=relaxed/simple;
	bh=9A2cIopavtwlQ+4n7uHt1ROc1cBNKluPvLq6PQi2TmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FGkrQb/mSnlwo29k5L6Sza26xIKw+uPkLi9T7iIwRZX+2jJT5RD/cwr0JGp4xbd41I87Tm1pNWci1za2xKkneGA9a/wMfsYBgZY9fFywEHLz/IdOctHUOKTcC2M+xkZg/DRJXtBAUY9hw7plF8/Y35IkSGqf9fpmUKxu4tsB7z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c451iHvU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a1e514c0427911f0b33aeb1e7f16c2b6-20250606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zvqyrk8kJ2uCb2GN+GGEe5HFwqiqtZruRDoufvNL+rA=;
	b=c451iHvUFND2MP+owIGUkc9BGH0qXO8kJu99ot/PPbkgqA+FocHFZNG5Dxh8X9vEM8JoRmQ9h8WeJaS+NL+cwwNn6TY96nAmiF2hctt3Fa1dpMIrHj70PvZ6O6Viwmmz3oBxlV4LysFBiBTFyYwstXhwO8OQ0M5HY+G+rtsI1VE=;
X-CID-CACHE: Type:Local,Time:202506060957+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ecb30f98-578c-4d17-9181-4e5146851721,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:1731edf1-fe3f-487e-8db5-d099c876a5c3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: a1e514c0427911f0b33aeb1e7f16c2b6-20250606
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1513382290; Fri, 06 Jun 2025 09:57:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 6 Jun 2025 09:57:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 6 Jun 2025 09:57:40 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: <patches@lists.linux.dev>, <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ajay Agarwal
	<ajayagarwal@google.com>, Daniel Stodden <daniel.stodden@gmail.com>, Macpaul
 Lin <macpaul.lin@mediatek.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Deren Wu <Deren.Wu@mediatek.com>, Ramax
 Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, MediaTek
 Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
Subject: [PATCH 6.11 1/1] PCI/ASPM: Disable L1 before disabling L1 PM Substates
Date: Fri, 6 Jun 2025 09:57:38 +0800
Message-ID: <20250606015738.2724220-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ajay Agarwal <ajayagarwal@google.com>

[ Upstream commit 7447990137bf06b2aeecad9c6081e01a9f47f2aa ]

PCIe r6.2, sec 5.5.4, requires that:

  If setting either or both of the enable bits for ASPM L1 PM Substates,
  both ports must be configured as described in this section while ASPM L1
  is disabled.

Previously, pcie_config_aspm_l1ss() assumed that "setting enable bits"
meant "setting them to 1", and it configured L1SS as follows:

  - Clear L1SS enable bits
  - Disable L1
  - Configure L1SS enable bits as required
  - Enable L1 if required

With this sequence, when disabling L1SS on an ARM A-core with a Synopsys
DesignWare PCIe core, the CPU occasionally hangs when reading
PCI_L1SS_CTL1, leading to a reboot when the CPU watchdog expires.

Move the L1 disable to the caller (pcie_config_aspm_link(), where L1 was
already enabled) so L1 is always disabled while updating the L1SS bits:

  - Disable L1
  - Clear L1SS enable bits
  - Configure L1SS enable bits as required
  - Enable L1 if required

Change pcie_aspm_cap_init() similarly.

Link: https://lore.kernel.org/r/20241007032917.872262-1-ajayagarwal@google.com
Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
[bhelgaas: comments, commit log, compute L1SS setting before config access]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/pci/pcie/aspm.c | 92 ++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..e943691bc931 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -805,6 +805,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
+	/* Disable L0s/L1 before updating L1SS config */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+					   child_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL,
+					   parent_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+	}
+
 	/*
 	 * Setup L0s state
 	 *
@@ -829,6 +838,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	aspm_l1ss_init(link);
 
+	/* Restore L0s/L1 if they were enabled */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
+		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
+	}
+
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
@@ -845,25 +861,28 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
-/* Configure the ASPM L1 substates */
+/* Configure the ASPM L1 substates. Caller must disable L1 first. */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
-	u32 val, enable_req;
+	u32 val;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 
-	enable_req = (link->aspm_enabled ^ state) & state;
+	val = 0;
+	if (state & PCIE_LINK_STATE_L1_1)
+		val |= PCI_L1SS_CTL1_ASPM_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		val |= PCI_L1SS_CTL1_ASPM_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
 
 	/*
-	 * Here are the rules specified in the PCIe spec for enabling L1SS:
-	 * - When enabling L1.x, enable bit at parent first, then at child
-	 * - When disabling L1.x, disable bit at child first, then at parent
-	 * - When enabling ASPM L1.x, need to disable L1
-	 *   (at child followed by parent).
-	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
+	 * PCIe r6.2, sec 5.5.4, rules for enabling L1 PM Substates:
+	 * - Clear L1.x enable bits at child first, then at parent
+	 * - Set L1.x enable bits at parent first, then at child
+	 * - ASPM/PCIPM L1.2 must be disabled while programming timing
 	 *   parameters
-	 *
-	 * To keep it simple, disable all L1SS bits first, and later enable
-	 * what is needed.
 	 */
 
 	/* Disable all L1 substates */
@@ -871,26 +890,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				       PCI_L1SS_CTL1_L1SS_MASK, 0);
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_L1SS_MASK, 0);
-	/*
-	 * If needed, disable L1, and it gets enabled later
-	 * in pcie_config_aspm_link().
-	 */
-	if (enable_req & (PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)) {
-		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-	}
-
-	val = 0;
-	if (state & PCIE_LINK_STATE_L1_1)
-		val |= PCI_L1SS_CTL1_ASPM_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		val |= PCI_L1SS_CTL1_ASPM_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
 
 	/* Enable what we need to enable */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
@@ -937,21 +936,30 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
 	}
 
+	/*
+	 * Per PCIe r6.2, sec 5.5.4, setting either or both of the enable
+	 * bits for ASPM L1 PM Substates must be done while ASPM L1 is
+	 * disabled. Disable L1 here and apply new configuration after L1SS
+	 * configuration has been completed.
+	 *
+	 * Per sec 7.5.3.7, when disabling ASPM L1, software must disable
+	 * it in the Downstream component prior to disabling it in the
+	 * Upstream component, and ASPM L1 must be enabled in the Upstream
+	 * component prior to enabling it in the Downstream component.
+	 *
+	 * Sec 7.5.3.7 also recommends programming the same ASPM Control
+	 * value for all functions of a multi-function device.
+	 */
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pcie_config_aspm_dev(child, 0);
+	pcie_config_aspm_dev(parent, 0);
+
 	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
 		pcie_config_aspm_l1ss(link, state);
 
-	/*
-	 * Spec 2.0 suggests all functions should be configured the
-	 * same setting for ASPM. Enabling ASPM L1 should be done in
-	 * upstream component first and then downstream, and vice
-	 * versa for disabling ASPM L1. Spec doesn't mention L0S.
-	 */
-	if (state & PCIE_LINK_STATE_L1)
-		pcie_config_aspm_dev(parent, upstream);
+	pcie_config_aspm_dev(parent, upstream);
 	list_for_each_entry(child, &linkbus->devices, bus_list)
 		pcie_config_aspm_dev(child, dwstream);
-	if (!(state & PCIE_LINK_STATE_L1))
-		pcie_config_aspm_dev(parent, upstream);
 
 	link->aspm_enabled = state;
 
-- 
2.45.2


