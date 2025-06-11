Return-Path: <linux-pci+bounces-29498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D958AD625C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23DF17F308
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 22:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA61D95B3;
	Wed, 11 Jun 2025 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFheVTst"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40EA59
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680917; cv=none; b=WMcd1An9E1UYOD+K6A1Nl/NWNyhmcKu1tvCvktvCZM9Xzm2naopzZfvvew5yF0pedXpdd0y8Hw/zTvow2+g65UpQl1LFJoPPc3V+WvjvnQ3eDQZ7Cs+6ciOWqt9VgC1n8VAuLKRNlqvPevNo6CAHs5LTBsIXFWfRlmBC1r1Jq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680917; c=relaxed/simple;
	bh=77VjFtSsPxM/vcixdqjcRrT1lZtIhyrYz6LvUXdtAYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/X3ocaLvob+ethp6geoSQ0Pw4XN/ZNhKFRRkjDo+jP0npAgYUavLGIS43+QYXRg3+4IVEkIQqdeJB3oKI7xDirDpAmfL84iOOG4Q5cPNItN6/SB9ioD18xSs/gciGmsbOEPFGklGWnUkGnNSNxBRx4VFhuYN7xdHJGtZszaYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFheVTst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C99EC4CEE3;
	Wed, 11 Jun 2025 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749680915;
	bh=77VjFtSsPxM/vcixdqjcRrT1lZtIhyrYz6LvUXdtAYY=;
	h=From:To:Cc:Subject:Date:From;
	b=RFheVTst1hPRlQQeBrFzPMTdk11PAjoZX42KrTzDktGgoix1EKcXByVa3I2G9837v
	 TcNEIbGGP/HE4ddEvkRpMJK7iIeZrhUsAMKZTU3G/pTwLwigbsHRk+NUfnLTeq0k12
	 ChOQ/dEoKjzDnHr5nwonkMylUDLqguNMiUPIvGo8HZP4hht0lMQV6YmHzyR2O0o/bR
	 mJkxeB28e43uK6CtGPcv8qRnVhvj8o7md90Ipks3MycBJLGMnqurst3QBiZgqHU9NS
	 mCOLe/xCge8FzK8wKydyepv21jinB/s3iXDexwTt5YfygJuDa9NLhurT77m1GjlFO9
	 EmVJulol52RwQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Set up runtime PM on devices that don't support PCI PM
Date: Wed, 11 Jun 2025 17:28:28 -0500
Message-ID: <20250611222832.4067200-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
initializing") intended to put PCI devices into D0, but in doing so
unintentionally changed runtime PM initialization not to occur on
devices that don't support PCI PM.  This caused a regression in vfio-pci
due to an imbalance with it's use.

Adjust the logic in pci_pm_init() so that even if PCI PM isn't supported
runtime PM is still initialized.

Cc: Alex Williamson <alex.williamson@redhat.com>
Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
Reported-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m40d277dcdb9be64a1609a82412d1aa906263e201
Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3dd44d1ad829b..c495c3c692f5f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3221,15 +3221,17 @@ void pci_pm_init(struct pci_dev *dev)
 
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (!pm)
+	if (!pm) {
+		goto poweron;
 		return;
+	}
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
 		pci_err(dev, "unsupported PM cap regs version (%u)\n",
 			pmc & PCI_PM_CAP_VER_MASK);
-		return;
+		goto poweron;
 	}
 
 	dev->pm_cap = pm;
@@ -3274,6 +3276,7 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_STATUS, &status);
 	if (status & PCI_STATUS_IMM_READY)
 		dev->imm_ready = 1;
+poweron:
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
-- 
2.43.0


