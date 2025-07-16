Return-Path: <linux-pci+bounces-32266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2BB07668
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B104A55C8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944912F5336;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IITQe2BA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B52F5301;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670585; cv=none; b=N9+gZcWGQ/afaqtH2RqgNETbpx1pmHgOjebm8o/MlTxHFD1iPfYvh3VC2AcbROm3nu6H7qStKxCyCbFL2zcne+NpVTYrx6kPvn+pmKjdAY8WK05S25Z6jvL8CojxEkZcGw08OvZOK6kzv3I1gQOxYaFOBzusc5fnaYj1i833eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670585; c=relaxed/simple;
	bh=N7blyqfQuKX3ng2cz062bliqBtPysSE2ISnQjV9aR9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sc3qTGYOKnlXO2U0mJSsSimxQ6Mgwc+NDa8ZG2KAbVgRVj9Jl/wwEl4bUNg17t4sGMzirSzzDnbyPEisZoU5j5ouetPn4DpU7jIvP5yNOX/G1DFxacXaTNSu8XZzdUsMvtT0cW7naJFMqTIJPDD7EIcgGQ8B9gjMR7G+LAZN82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IITQe2BA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB6A9C116B1;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670585;
	bh=N7blyqfQuKX3ng2cz062bliqBtPysSE2ISnQjV9aR9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IITQe2BAL2dS1TnBFMJM6SZDIBfJHfyZCSXbLAD86InIqnrYN5urpZHbI8dS0Mjae
	 G3JFESY/3ep/kaQvE+BZrv8YLgTcKhin3zXT9C0xR8p1s2gqc6DQJYG7kPeq2rwloP
	 VaEf24sKxypHJ9Js5pFw0BNSrLHMgv81plA5wV/dYuPxvx7M4O/w6M+0CDqJPvlMu9
	 555QxOCbU/xMVayngrDdJs1+cGYmQXoYqHYLQpF7mRlxB8fX0YCwhlO9Zz9Bg9MkaU
	 ASipx0soW7lzwJYwhsK+gtnLaFcQ6RYPze0LWAH6CV6s4rXjKb/HHaeFm0jPtdzTdd
	 40vDKQfAGhYhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE1C83F34;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 16 Jul 2025 18:26:24 +0530
Subject: [PATCH 5/6] wifi: ath11k: Use pci_{enable/disable}_link_state()
 APIs to enable/disable ASPM states
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-ath-aspm-fix-v1-5-dd3e62c1b692@oss.qualcomm.com>
References: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
In-Reply-To: <20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ath12k@lists.infradead.org, ath11k@lists.infradead.org, 
 ath10k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>, 
 ilpo.jarvinen@linux.intel.com, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=kXpW2mQuCN8+CNqdT+kLur7VSEl5MgZkBtsfbPtL7RY=;
 b=owEBbAGT/pANAwAKAVWfEeb+kc71AcsmYgBod6F22QPsndaD+8odr4XoI0/ocyp1ircoReHgt
 YGA0cbP6aCJATIEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHehdgAKCRBVnxHm/pHO
 9Sb9B/i3iAtipHaPFAxLp2zZTxGLgKyKliJu5K7gSsTqxmv7SltOMJyZmnTaGZYLk6v3zQnRcg6
 sw2o2uIH9fSmM8+4XO79TkWTmnh6trf1HQAgJs02XVm8x90kChSY3mH+1mglMtfm1Z5wZsMFXMD
 6d2HdNNBDBi7DvWJnPlv3kjjhOQa6eBwGh9J0tCBghOy2ZOsg27sEwItnHNfsCEpPNpi4zMluiq
 3zhfrwOB3g3t8SfYyX+0Zs1X2Rv2MVfl8EahkwZra0x7yV32Ina7XpSomJ1UGz46Atp4b61+BFT
 FRYW9/TtiB1XC9iicOaEtvo4z7d87s1a+ypf/M1h6fxvkfE=
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
 drivers/net/wireless/ath/ath11k/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 78444f8ea15356f1f4c90a496efd52780499bfb2..cec399765e04104ddcfcee5003c209e14c7d4ca0 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -19,6 +19,8 @@
 #include "pcic.h"
 #include "qmi.h"
 
+#include "../ath.h"
+
 #define ATH11K_PCI_BAR_NUM		0
 #define ATH11K_PCI_DMA_MASK		36
 #define ATH11K_PCI_COHERENT_DMA_MASK	32
@@ -597,8 +599,7 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
 
 	/* disable L0s and L1 */
-	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   PCI_EXP_LNKCTL_ASPMC);
+	pci_disable_link_state(ab_pci->pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1);
 
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -606,10 +607,7 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC,
-						   ab_pci->link_ctl &
-						   PCI_EXP_LNKCTL_ASPMC);
+		pci_enable_link_state(ab_pci->pdev, ath_pci_aspm_state(ab_pci->link_ctl));
 }
 
 #ifdef CONFIG_DEV_COREDUMP

-- 
2.45.2



