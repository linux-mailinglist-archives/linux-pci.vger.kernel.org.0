Return-Path: <linux-pci+bounces-39186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB5C02DAB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D50FF4EDE50
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19D34C134;
	Thu, 23 Oct 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5Z6NbT6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D534B1AE;
	Thu, 23 Oct 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242821; cv=none; b=GGNKHZpx7ZUzxxus8cd9h9G9sRPX3NEObjYN5oDSOteq14Nfk9Wm4zBQ5NtIGLHYW88EUaHcTexzc1cTomWg3czpu4QL5gdJlMlMGa57MSuP8cpK2FKLknQ2OgS7tTKoENrcNRkpamCNXFJHC+SBneTuR6/8SyjBDoo7uEIcduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242821; c=relaxed/simple;
	bh=b5POU65SI9uBItwU3VrQQapA5Fe5zoNWbwcZVbOTXlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBP4w9F5FgQ/zsjcJwrl2GSA4/WSC9VQUtvYaS5J9wVgPFwT//K5tE9q3p9nwno9apQyg0g++965dlYbH4+4l7rifeY7Dg7tbRbgKDK3Jpp9JqfUf1nb8iWHH4OHnBC/UEeATRDoFuiX29TrTQ6R16oeGjn8VXdV4NxEC63XNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5Z6NbT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A93C4CEE7;
	Thu, 23 Oct 2025 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761242820;
	bh=b5POU65SI9uBItwU3VrQQapA5Fe5zoNWbwcZVbOTXlo=;
	h=From:To:Cc:Subject:Date:From;
	b=V5Z6NbT6+ZsvBawxRtQxU7LhzI9ILCHAXbufohmEyU04NEMevBNBjSTSRUOGz0Q6M
	 p/J8OXFmnNBJwV8Z7CvorFLum3GOtQkbxP5iqmU671wwUKwqgVNcwVxXHQ/0ddSG4/
	 WnyzlBLS4VlcV8QXxN57mSobGCvmXQUwTGjRneEg77O9umCvyPvHMWxlpsskxpr05i
	 A7EwOXDh3hCDu9JbL1yuX8Zlf41V1lduTmNA4AFpT5PMbdfqRgb0/x7IebHpC7K8Vc
	 xzrTrxOAdhXbQg4kmhjO0yEukjIjPBOAvhN0Q9GtFiCHbacF6o9UEmjW0D+0iLFXg7
	 W7Yne6d0AMhiA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Date: Thu, 23 Oct 2025 13:06:26 -0500
Message-ID: <20251023180645.1304701-1-helgaas@kernel.org>
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
platforms") enabled Clock Power Management and L1 PM Substates, but those
features depend on CLKREQ# and possibly other device-specific
configuration.  We don't know whether CLKREQ# is supported, so we shouldn't
blindly enable Clock PM and L1 PM Substates.

Enable only ASPM L0s and L1, and only when both ends of the link advertise
support for them.

Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
Reported-by: FUKAUMI Naoki <naoki@radxa.com>
Closes: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
Reported-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20251015101304.3ec03e6b@bootlin.com/
Reported-by: Diederik de Haas <diederik@cknow-tech.com>
Link: https://lore.kernel.org/r/DDJXHRIRGTW9.GYC2ULZ5WQAL@cknow-tech.com/
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: FUKAUMI Naoki <naoki@radxa.com>
---
I intend this for v6.18-rc3.

I think it will fix the issues reported by Diederik and FUKAUMI Naoki (both
on Rockchip).  I hope it will fix Christian's report on powerpc, but don't
have confirmation.  I think the performance regression Herve reported is
related, but this patch doesn't seem to fix it.

FUKAUMI Naoki's successful testing report:
https://lore.kernel.org/r/4B275FBD7B747BE6+a3e5b367-9710-4b67-9d66-3ea34fc30866@radxa.com/
---
 drivers/pci/pcie/aspm.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7cc8281e7011..79b965158473 100644
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
+			pci_info(pdev, "ASPM: default states%s%s\n",
+				 FLAG(override, L0S, " L0s"),
+				 FLAG(override, L1, " L1"));
 	}
 }
 
-- 
2.43.0


