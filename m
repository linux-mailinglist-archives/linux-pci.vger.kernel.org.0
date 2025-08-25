Return-Path: <linux-pci+bounces-34678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C325FB3492E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865932A3F91
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C35309DDF;
	Mon, 25 Aug 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7jH5bVR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E083F3090D2;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143891; cv=none; b=RA0+RqdL/vuT3+1L3Ve5YhX3+Lrf20JiUtpIzLavVsYKDm4bGov+CfQckV0W2qsy30qC3HkEHyOa1/Yq1viAEMrR9CPj53CEDfLxB3j0ayumuyfq9v6Nv0SsinXUm8LQGhZxxR9HXEHs8G/Xo6nfXz3xVOIAUnhC08KldIES6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143891; c=relaxed/simple;
	bh=Wx6W28IBSOPVhur4cAm2KHQeeo345xNGoIygZEGlbK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdm79++Zs+FwyaUWGz8DwHzxkgxJ1xa3ZyrOmwX7Id7w/5/sq5jPkYo8XuXxp/L5tV3aUz9nv+Ye655oA4RQfEcGgZYoXDe4rrEedse/oCG73LAtxIui3fh3XRPdTOubc+k/KNhWJ6TM8nVsizVu/nLcj+OWuSwz0fBU8FNPqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7jH5bVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C3CFC2BCB3;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=Wx6W28IBSOPVhur4cAm2KHQeeo345xNGoIygZEGlbK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d7jH5bVREQJNjPJlorubTT9aOqlxybbHLTU7gQ4Mi2P4aDwkI5MCCetjwC4wbnHXZ
	 2MJJW1p5PuV6msGH07n34d7IubdR5gu7y8l3p3LlbmoJsw7iY8FpBOF8Gdn6GEqcbW
	 ogGQsHmWxAUrTcw9nsOXcTyJTYPIrpKK5NQzZv6UqjK5/VDToSkoCcPKlEBRCSleYc
	 zognQ8HDpyI4CSwkWwuyR3Jzbnk3h4I+vbMH9ZzCJUHIDApmBCD3HoLMOyquOKynLG
	 GyDhausLLXhR3x3IqKnvWuixY34KyqQAJfjKMGSrwFmX63FvR8/bDVk+xBGvGN7/ww
	 thRLl+kP/qIcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E43CA0EED;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 23:14:42 +0530
Subject: [PATCH v2 7/8] wifi: ath11k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-ath-aspm-fix-v2-7-61b2f2db7d89@oss.qualcomm.com>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
In-Reply-To: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=K8FTwvItCiUnOOZrxrN2h/nq2BvbT+Wy0KtDYhVyhrY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEPYMGTaSp8NMZfMxZegLgw/ywSID5AZ1Ba+
 gsX7ZfIHlSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDwAKCRBVnxHm/pHO
 9UQuB/9rHiAkPXNCloNwt2ZMvvMg2V+yPJgaGgkUtvckx77vEpqrmTqabjua6TM5frI4eUkTZT4
 mjQ6L+/s1x51XvU3xRwVXz7LpJzD+6ZPzllkd6bSKTWzHYs2ud/muci1b7D189UPBPHOubDyMJR
 qRGH7dS6UY9wsodC+1pYXlVtRazVcWN7v8VA6dFzjUTeETBEeuFHdLgTDaP6p8DbuT1Vo1ROaHp
 nyBCSyoBDKmotIFDmIhAF+2sIazt4Yb+uQs1g8dpBC5nccYDDPmBEI04zyo+qUYHByPpzRzNll2
 bePWYZk7FWt403okq5s9prQ8oPpKOoWSFwSiW+XwYorkfvs6
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

It is not recommended to enable/disable the ASPM states on the back of the
PCI core directly using the LNKCTL register. It will break the PCI core's
knowledge about the device ASPM states. So use the APIs exposed by the PCI
core to enable/disable ASPM states.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath11k/pci.c   | 19 +++----------------
 drivers/net/wireless/ath/ath11k/pci.h   |  3 ++-
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 659ef134ef168f5e5ad9a532ccd485d20d8701d5..9e19823fbd1a8d48517dcf1c2e644686f7e0ff57 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -20,7 +20,7 @@ config ATH11K_AHB
 
 config ATH11K_PCI
 	tristate "Atheros ath11k PCI support"
-	depends on ATH11K && PCI
+	depends on ATH11K && PCI && PCIEASPM
 	select MHI_BUS
 	select QRTR
 	select QRTR_MHI
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d8655badd96d0f4b6946f8af927d878aaa3147ad..94bf5973d146754173d076eebd36580b820dc894 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -586,19 +586,9 @@ static void ath11k_pci_free_region(struct ath11k_pci *ab_pci)
 
 static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 {
-	struct ath11k_base *ab = ab_pci->ab;
-
-	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				  &ab_pci->link_ctl);
-
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "link_ctl 0x%04x L0s %d L1 %d\n",
-		   ab_pci->link_ctl,
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
+	ab_pci->aspm_states = pcie_aspm_enabled(ab_pci->pdev);
 
-	/* disable L0s and L1 */
-	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
+	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_ALL);
 
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -606,10 +596,7 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC,
-						   ab_pci->link_ctl &
-						   PCI_EXP_LNKCTL_ASPMC);
+		pci_enable_link_state(ab_pci->pdev, ab_pci->aspm_states);
 }
 
 #ifdef CONFIG_DEV_COREDUMP
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index c33c7865145cc666394135e7fd8e10dd4462e5df..fe58ce814aeff1d71b5d6e44ccfd9d5b3cd9d48d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -72,7 +72,8 @@ struct ath11k_pci {
 
 	/* enum ath11k_pci_flags */
 	unsigned long flags;
-	u16 link_ctl;
+	/* Cached PCIe ASPM states */
+	u32 aspm_states;
 	u64 dma_mask;
 };
 

-- 
2.45.2



