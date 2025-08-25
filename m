Return-Path: <linux-pci+bounces-34676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C89B3492B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5683B2A4318
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49173309DC5;
	Mon, 25 Aug 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oskTPZo+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5568308F0E;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143890; cv=none; b=F2bQN6lC4+DLC8l+ToxfGgNjOVr6kcb6ZCfPB+BypR4gi3IzT0KntRCSfpY6m1CqWhiemKz4kS+/pwBxWYnKX31sDJ1IdulYJKjykdk47FgRPwGbEzVRf9uZuBw3pPYYvIfNy0pEqe6DzsPQwsCFkYd8HjzwleiP9xcgh+tNUV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143890; c=relaxed/simple;
	bh=5r5CGSyABcYjNsRbD59pnqOF5sW34Z3EZ4rn8nXrc0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gL+4GaawMn+3N/EDQjRI+QqVmikUUHxrS6K8xcBnKhYy72eRwtX/AlzxeVxywXLvWagrGbAR2dtMDn644bw1Zcc4Gzd41ljqKKgz1GbsvIzEJ+UTq4J+r0oOVFFRVWFkpwdUyZSLBGTGhBKI2369LwaWNhIJy8VII0xJdj+GXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oskTPZo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DC7AC4AF48;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=5r5CGSyABcYjNsRbD59pnqOF5sW34Z3EZ4rn8nXrc0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oskTPZo+0jBNzrlwS7d+fv+SFAZqEBVpXnhKW0MEsDtXy1abOHC/DnfNHJVc+Cbr5
	 ZI3mWKFwx2redjvPNhYAejwdAiqx90Mll6Me3bArP+NhQ65plSDDtgQ77SGy5djLK7
	 xRlFnfJH3AQwKv5y364WGRYmt+ESN2mCoLqYyWApzHW7jF1YIxzO5c5GiY9ddHcIcP
	 KLsNJTPPj3Z/+REQrDzybOPEGwgxOqGQcdIPZRGNEDrUxJAcvRokSON5EcmBGk3Dyv
	 XPETiEQ6OR2fZmZ3Jd3TlHcmvPA7S3Rfc8lIxAyaRgtD2+bTgTYvDdE79xOog0lRed
	 ly90yyROwFP3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F2BCA0FED;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 23:14:41 +0530
Subject: [PATCH v2 6/8] wifi: ath12k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-ath-aspm-fix-v2-6-61b2f2db7d89@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3464;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=YGFWkIzjyhJ7NOe0rjueqTF+ezI7rthYPLb8nbyWY/g=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEPxDoq8Rt3E/gfDSPMFBM6a+hNKg0+2PyCy
 S0mmGxqoDaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDwAKCRBVnxHm/pHO
 9aizB/9QbdeHisz8JMQZeOvxBOeQqcnLLDlPLGiXOCPkjvsCidqfJpKcjMxM/OvG4l0wcTKibU6
 EqsrITqfxgI9G3Gb9W4eJJuDqkzs3AU2QyoupUYB2+pdYlEfH1U+Gb/5JUmZnMb89RDCqJn69qx
 tAL/BS8Ci5vxcBHQBfx3jpl6+iHzRa9Ok7zj1UfaLdBx8VCSVmTZ4n4cFpAtnTz4jQ38A4NzSRD
 hydPz+jv0OHoqIYwj9euNkRc2LD0At/ePKUtZB9JucYAEv2mbmzVzzRkqJrXl9fPldon+TB6bA7
 0MFdxNivxmcOEH6Louvsx58LBStikkIimvSd+Y+fwaTT5u6i
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

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
 drivers/net/wireless/ath/ath12k/pci.c   | 19 +++----------------
 drivers/net/wireless/ath/ath12k/pci.h   |  4 +++-
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index 1ea1af1b8f6c5425c38663977f1d60fe3acb5437..789276e1e9c289de7afdbcaf72be6410b6ea7385 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause-Clear
 config ATH12K
 	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
-	depends on MAC80211 && HAS_DMA && PCI
+	depends on MAC80211 && HAS_DMA && PCI && PCIEASPM
 	select CRYPTO_MICHAEL_MIC
 	select QCOM_QMI_HELPERS
 	select MHI_BUS
diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index c729d5526c753d2b7b7542b6f2a145e71b335a43..29236da231e51ac402e40dd124bb474b3102e6c8 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -917,19 +917,9 @@ static void ath12k_pci_free_region(struct ath12k_pci *ab_pci)
 
 static void ath12k_pci_aspm_disable(struct ath12k_pci *ab_pci)
 {
-	struct ath12k_base *ab = ab_pci->ab;
-
-	pcie_capability_read_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				  &ab_pci->link_ctl);
-
-	ath12k_dbg(ab, ATH12K_DBG_PCI, "pci link_ctl 0x%04x L0s %d L1 %d\n",
-		   ab_pci->link_ctl,
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L0S),
-		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
+	ab_pci->aspm_states = pcie_aspm_enabled(ab_pci->pdev);
 
-	/* disable L0s and L1 */
-	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
+	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_ALL);
 
 	set_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -958,10 +948,7 @@ static void ath12k_pci_aspm_restore(struct ath12k_pci *ab_pci)
 {
 	if (ab_pci->ab->hw_params->supports_aspm &&
 	    test_and_clear_bit(ATH12K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC,
-						   ab_pci->link_ctl &
-						   PCI_EXP_LNKCTL_ASPMC);
+		pci_enable_link_state(ab_pci->pdev, ab_pci->aspm_states);
 }
 
 static void ath12k_pci_cancel_workqueue(struct ath12k_base *ab)
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index d1ec8aad7f6c3b6f5cbdf8ce57a4106733686521..f3e4e59323036e6251d422b7a2d1997811cc3f98 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -114,7 +114,9 @@ struct ath12k_pci {
 
 	/* enum ath12k_pci_flags */
 	unsigned long flags;
-	u16 link_ctl;
+
+	/* Cached PCIe ASPM states */
+	u32 aspm_states;
 	unsigned long irq_flags;
 	const struct ath12k_pci_ops *pci_ops;
 	u32 qmi_instance;

-- 
2.45.2



