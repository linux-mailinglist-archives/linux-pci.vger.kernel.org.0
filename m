Return-Path: <linux-pci+bounces-15854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02B9BA1D3
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 18:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2A71F21722
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB881AA7B9;
	Sat,  2 Nov 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgAnS49F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFD1AA792
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730569545; cv=none; b=HCizXj/DudAZjgxAdQZ3JDIxvJof3KBy2vAWmPrRiAEWzdr9W4hD+3hSJ+zZY5fneL+K1n/mLod1bYCcZGQ1dn2WL/fBDf99ua6U2em0zJWGobZXxhMAlMxJWCOXTd/+388EBsKxL4zNJeRA7grUw/+oIG58aL0kwE8H+LvWEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730569545; c=relaxed/simple;
	bh=1uRu1HPKI8VthNN5aHsglPIPdw8sSb1JtlWHA8ji/6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KU/lw2dk9wQSrdZSaIboI5Olk6MNqteUdCsvJOlXuxh7SBwPN3oHgazG+xbPdN26wW/u0FPV/SL7PgXxx1iwF8bl6AUBxG44dOQ/7qBY0e0JowlH5iyJIGFx1OV9wSwKB/SmNMU8xOeG+p9zgngn+5ZyjOeWVipdGyOBf3GnCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgAnS49F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130A2C4CEC3;
	Sat,  2 Nov 2024 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730569545;
	bh=1uRu1HPKI8VthNN5aHsglPIPdw8sSb1JtlWHA8ji/6A=;
	h=From:To:Cc:Subject:Date:From;
	b=dgAnS49Fy0OfsofTYY5ssKkR8NJXo7+b/BTYPX2sQ36nG5+/cpHmraQoGySf6HBvx
	 RGPD5diBfphvl0OKuRc+FkUAgm3VnfOeBzCPlbFxH3Sm2HE4KiPXQR9EQP4svj7Kmq
	 xSeM+Ve8gy1jwCpQ2nhFKPQg6kqA3tOKFchBqkOwaD9YFwCjiEDKEWDpPZ7R5y6ime
	 oem/PgJMP6nV47wkxcdz64edXzf5XNcFvG/XRX/nA+YpczKB2+oxgpRseFjoh52dCK
	 MwVCC6rDW/56RJ1Ae9l2TDiGFOZOdU482Q8iAOm2TDl1xXpOgX5MHRC34Mqz/HdN9c
	 IgAoDqx16dQfg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Fix typos
Date: Sat,  2 Nov 2024 12:45:37 -0500
Message-Id: <20241102174537.1362183-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos and whitespace errors.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pcie-rcar-host.c |  4 ++--
 drivers/pci/pcie/aer.c                  | 15 +++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 3dd653f3d784..7c92eada04af 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -796,8 +796,8 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host *host)
 	rcar_pci_write_reg(pcie, 0, PCIEMSIIER);
 
 	/*
-	 * Setup MSI data target using RC base address address, which
-	 * is guaranteed to be in the low 32bit range on any R-Car HW.
+	 * Setup MSI data target using RC base address, which is guaranteed
+	 * to be in the low 32bit range on any R-Car HW.
 	 */
 	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE, PCIEMSIALR);
 	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 13b8586924ea..80c5ba8d8296 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -180,7 +180,8 @@ static int disable_ecrc_checking(struct pci_dev *dev)
 }
 
 /**
- * pcie_set_ecrc_checking - set/unset PCIe ECRC checking for a device based on global policy
+ * pcie_set_ecrc_checking - set/unset PCIe ECRC checking for a device based
+ * on global policy
  * @dev: the PCI device
  */
 void pcie_set_ecrc_checking(struct pci_dev *dev)
@@ -1148,14 +1149,16 @@ static void aer_recover_work_func(struct work_struct *work)
 			continue;
 		}
 		pci_print_aer(pdev, entry.severity, entry.regs);
+
 		/*
-		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
-		 * ghes_estatus_pool to protect it from overwriting when multiple sections
-		 * are present in the error status. Thus free the same after processing
-		 * the data.
+		 * Memory for aer_capability_regs(entry.regs) is being
+		 * allocated from the ghes_estatus_pool to protect it from
+		 * overwriting when multiple sections are present in the
+		 * error status. Thus free the same after processing the
+		 * data.
 		 */
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
-					      sizeof(struct aer_capability_regs));
+					    sizeof(struct aer_capability_regs));
 
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
-- 
2.34.1


