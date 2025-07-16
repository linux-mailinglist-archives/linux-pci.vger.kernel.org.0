Return-Path: <linux-pci+bounces-32262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34857B07660
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA897BD71C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6DA2F530A;
	Wed, 16 Jul 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2PClDU2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A12F509B;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670585; cv=none; b=I3G2qF6BLdcx08pCb4nFKvD89HTT1BaLPMPQ/uDet0qWAHCzqaK35kAyvk0UmS3j2bWNGWMcsweUUDRZnlcrhUWd67dpXFvbJ7fpHOPjt/m1JiDLio+q/WOtcT4QWer5mgRon7RoCatYjXLwj+5/CgNqsNO2zn7ZMWdnCUajbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670585; c=relaxed/simple;
	bh=U4+/0Kn/irzrlmqtgZxjxMU14G54Aznp8RGU4IoJb5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEBH1SXK4UPwxl9ONhj8bVdKSsbzQ93e8uwRI067F7fSm/F6o9exXESgNzP1iac++XUhKhP6niFSTW4PvMAgKI26DYfr9Q0xVft6FXynM2cmQKfG1k7qp+IyFCz1dpgnWIujQy+rsir7ZBV31pcq0lLgUF6mno0CNYgKiMaqt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2PClDU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B09C4CEF6;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670584;
	bh=U4+/0Kn/irzrlmqtgZxjxMU14G54Aznp8RGU4IoJb5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V2PClDU2jQbChUUrLMEO13Ovau/25TPy5Qs9+Uu24QtGnbF1CfygyYdQ8C/zkQ8zZ
	 42Tmr5MwhKGU6IonKo5wWFIVxzpj1a0d0RS0vd1P/1XB6Pjhfc3wT7kq19PaCaYdxz
	 GrmoyU7aXJqg7RLgX7QXVXIXTqXW89QRZr6UPZ3huq987SrV6umuyn7/4rb7OqW4sO
	 egPGuoMp4lVUGbMCogYVxP6r5vNPg9DvCf4xrtLUrqpffSX3CQUsUutPd8aY5MpyZo
	 LpTNGpYIQuzXCUxKdWQ9IbXm2xRIUeSPFUADypCZA5PQD2CDo6PfKH2jODRs461jog
	 ZQS7kyA7r5UKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C8C83F34;
	Wed, 16 Jul 2025 12:56:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 16 Jul 2025 18:26:21 +0530
Subject: [PATCH 2/6] PCI/ASPM: Transition the device to D0 (if required)
 inside pci_enable_link_state_locked() API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-ath-aspm-fix-v1-2-dd3e62c1b692@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4214;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Hi5J0pIF+iWnkMGXfocryMcFDAOXrwL22J4M8mGbdSU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBod6F2CULXLp8rTJpaJVU7H5c1oqS0BGUk5g7I+
 9t4OEB1veSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaHehdgAKCRBVnxHm/pHO
 9fArB/9FulOSF4tSr+TT1URdaKWzJq1L7LhC7QODyaVsCQBKBBC1uFuFWVGCpMmJpWKVcC1QV7e
 E3MHNYuim9To+6GoJLEp1Xa5gftbc7lcqYJ3SFfDMAM4UsRu4eaegzWr6t3IayzMolyP3mn9woe
 UPzil9ZKDZZHbRZP/XDlj8B22yKN4Qvhldr0cpiziVqDqnb4Yjs6UzN/Oddr+66zOWQLhnmLb01
 RTniSwmV1Cz4hql1VvETn4DVr1SI+QdHJfPEF3rWQXp34o6LpRm5LfRrKrei+ARJHZW2ZqwmFZm
 tqJib9vtul6W0+aSZ8Nu0DRIpe2lx1NHo3FmLmdbe1oGkHuA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Both of the current callers of the pci_enable_link_state_locked() API
transition the device to D0 before calling. This aligns with the PCIe spec
r6.0, sec 5.5.4:

"If setting either or both of the enable bits for PCI-PM L1 PM Substates,
both ports must be configured as described in this section while in D0."

But it looks redundant to let the callers transition the device to D0. So
move the logic inside the API and perform D0 transition only if the PCI-PM
L1 Substates are getting enabled.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c |  5 -----
 drivers/pci/controller/vmd.c           |  5 -----
 drivers/pci/pcie/aspm.c                | 22 ++++++++++++++++++----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f856550bcfa1ce09962ba9c086d117de05..204f87607c0bc1ce31299aa5a5763b564ddeda29 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1018,11 +1018,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
 {
-	/*
-	 * Downstream devices need to be in D0 state before enabling PCI PM
-	 * substates.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	return 0;
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 8df064b62a2ff3e22dd8507a66783ca6c6a8b777..cf11036dd20cbae5d403739b226452ce17c4cb7f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -765,11 +765,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
 out_state_change:
-	/*
-	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
-	 * PCIe r6.0, sec 5.5.4.
-	 */
-	pci_set_power_state_locked(pdev, PCI_D0);
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index ec63880057942cef9ffbf3f67dcd87ee3d2df17d..c56553de953c158cf9e8bf54c6b358a9a81a2691 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1474,13 +1474,20 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * Note that if the BIOS didn't grant ASPM control to the OS, this does
  * nothing because we can't touch the LNKCTL register.
  *
- * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
- * PCIe r6.0, sec 5.5.4.
+ * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
+ * are getting enabled.
  *
  * Return: 0 on success, a negative errno otherwise.
  */
 int pci_enable_link_state(struct pci_dev *pdev, int state)
 {
+	/*
+	 * Ensure the device is in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	if (FIELD_GET(PCIE_LINK_STATE_L1_SS_PCIPM, state))
+		pci_set_power_state(pdev, PCI_D0);
+
 	return __pci_enable_link_state(pdev, state, false);
 }
 EXPORT_SYMBOL(pci_enable_link_state);
@@ -1494,8 +1501,8 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * Note that if the BIOS didn't grant ASPM control to the OS, this does
  * nothing because we can't touch the LNKCTL register.
  *
- * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
- * PCIe r6.0, sec 5.5.4.
+ * Note: The device will be transitioned to D0 state if the PCI-PM L1 Substates
+ * are getting enabled.
  *
  * Context: Caller holds pci_bus_sem read lock.
  *
@@ -1505,6 +1512,13 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 {
 	lockdep_assert_held_read(&pci_bus_sem);
 
+	/*
+	 * Ensure the device is in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	if (FIELD_GET(PCIE_LINK_STATE_L1_SS_PCIPM, state))
+		pci_set_power_state(pdev, PCI_D0);
+
 	return __pci_enable_link_state(pdev, state, true);
 }
 EXPORT_SYMBOL(pci_enable_link_state_locked);

-- 
2.45.2



