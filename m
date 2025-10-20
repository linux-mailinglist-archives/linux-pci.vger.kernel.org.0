Return-Path: <linux-pci+bounces-38811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88612BF3DBD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D861D4F6411
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B42EF677;
	Mon, 20 Oct 2025 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLuBXQuV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0453EA8D;
	Mon, 20 Oct 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998347; cv=none; b=J1kFOwv3giABhd5+8QcWQ9GMjfqM+1S8kuImqhPVivvXweoOOMGQVst7cwJG7cFDblU4lBFrASxPsJ8+Nlk0hOFWXMpKipq0UQFJCWDsLz26Zt6k5b1PWu0AbmkP6Uk7ii041HxMvd95FYcVNPn0g3/A3lJmJOaeedORhgCfg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998347; c=relaxed/simple;
	bh=IsXcIouzgz4wUiJybXRjXsiqCJLbVl38YFCNfwbmYSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATvfFaHVyas2HPHMN7fmZj9T972t2m0cQgRLq85GMa1DNmEYW+uoJE5KioafknUO2HpAD84XG2fZjaLBdpfAV3UoC0aqcdd3Oy4GMH4BBewuSZQMYe39wnnm9z9O3kv+o5c6Qy2l7iLhWAzmRDFIFHlRHnj00POM6JhTMVAcLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLuBXQuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B2C4CEFB;
	Mon, 20 Oct 2025 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760998346;
	bh=IsXcIouzgz4wUiJybXRjXsiqCJLbVl38YFCNfwbmYSM=;
	h=From:To:Cc:Subject:Date:From;
	b=OLuBXQuVqv4Q0CXR+aktQPwREcoe2KINO0W8J0kcZNxkVCZJcmxzyldbLpRxSu2lP
	 d7OOp5Ip0LhslgUowkD75NEoCs2wNdw0D9BILt1gBcAf521rfa0c9THM1HQdGRMWwL
	 sPnIxL7tEkG0Oe+c+YXxRpXukATfmUiuhgXwGTEH/JwCz1FSPmduHbAKAyLlQ7Iei4
	 JMF8kvw+UqV59guyzNh1c5Wnk7Ye0Dvg2SlMhu8FDFlVhqrtJ5jywhp3KENAMd1b/P
	 nLv7EuDpDsukTjCN5nZ4d/EDd5L2MSRq7PyyWN9kpKR+szTx5olR66ALO0PwvuHg/L
	 LulWGiaKz6eqA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	linux-rockchip@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Date: Mon, 20 Oct 2025 17:12:07 -0500
Message-ID: <20251020221217.1164153-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
platforms") enabled Clock Power Management and L1 Substates, but that
caused regressions because these features depend on CLKREQ#, and not all
devices and form factors support it.

Enable only ASPM L0s and L1, and only when both ends of the link advertise
support for them.

Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
Reported-by: FUKAUMI Naoki <naoki@radxa.com>
Link: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
---

Mani, not sure what you think we should do here.  Here's a stab at it as a
strawman and in case anybody can test it.

Not sure about the message log message.  Maybe OK for testing, but might be
overly verbose ultimately.

---
 drivers/pci/pcie/aspm.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7cc8281e7011..dbc74cc85bcb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -243,8 +243,7 @@ struct pcie_link_state {
 	/* Clock PM state */
 	u32 clkpm_capable:1;		/* Clock PM capable? */
 	u32 clkpm_enabled:1;		/* Current Clock PM state */
-	u32 clkpm_default:1;		/* Default Clock PM state by BIOS or
-					   override */
+	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
 	u32 clkpm_disable:1;		/* Clock PM disabled */
 };
 
@@ -376,18 +375,6 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
 	pcie_set_clkpm_nocheck(link, enable);
 }
 
-static void pcie_clkpm_override_default_link_state(struct pcie_link_state *link,
-						   int enabled)
-{
-	struct pci_dev *pdev = link->downstream;
-
-	/* For devicetree platforms, enable ClockPM by default */
-	if (of_have_populated_dt() && !enabled) {
-		link->clkpm_default = 1;
-		pci_info(pdev, "ASPM: DT platform, enabling ClockPM\n");
-	}
-}
-
 static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	int capable = 1, enabled = 1;
@@ -410,7 +397,6 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 	link->clkpm_enabled = enabled;
 	link->clkpm_default = enabled;
-	pcie_clkpm_override_default_link_state(link, enabled);
 	link->clkpm_capable = capable;
 	link->clkpm_disable = blacklist ? 1 : 0;
 }
@@ -811,19 +797,17 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 	struct pci_dev *pdev = link->downstream;
 	u32 override;
 
-	/* For devicetree platforms, enable all ASPM states by default */
+	/* For devicetree platforms, enable L0s and L1 by default */
 	if (of_have_populated_dt()) {
-		link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
+		if (link->aspm_support & PCIE_LINK_STATE_L0S)
+			link->aspm_default |= PCIE_LINK_STATE_L0S;
+		if (link->aspm_support & PCIE_LINK_STATE_L1)
+			link->aspm_default |= PCIE_LINK_STATE_L1;
 		override = link->aspm_default & ~link->aspm_enabled;
 		if (override)
-			pci_info(pdev, "ASPM: DT platform, enabling%s%s%s%s%s%s%s\n",
-				 FLAG(override, L0S_UP, " L0s-up"),
-				 FLAG(override, L0S_DW, " L0s-dw"),
-				 FLAG(override, L1, " L1"),
-				 FLAG(override, L1_1, " ASPM-L1.1"),
-				 FLAG(override, L1_2, " ASPM-L1.2"),
-				 FLAG(override, L1_1_PCIPM, " PCI-PM-L1.1"),
-				 FLAG(override, L1_2_PCIPM, " PCI-PM-L1.2"));
+			pci_info(pdev, "ASPM: DT platform, enabling%s%s\n",
+				 FLAG(override, L0S, " L0s"),
+				 FLAG(override, L1, " L1"));
 	}
 }
 
-- 
2.43.0


