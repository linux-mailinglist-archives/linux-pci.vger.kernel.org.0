Return-Path: <linux-pci+bounces-34672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A13B34925
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7634F1899B58
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BBF307AFB;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU3VIkwi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D03019D2;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143890; cv=none; b=NU3Bs7KyTX4/fNstDlBamJY2m4hUfvyanR7LtkADd7pvryKWrK5d9IvY6FtJhgmAQ1Ww6wZz3ydswyMduJ7noO/m+U+80FgDcETB2qn4jbMYSpOM9ZfVigfiwvB35fbnrVL+ZBqQSHXxHiwOJJE6GK0gh7RuEcm+UzcV+H4kzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143890; c=relaxed/simple;
	bh=XIKXkwSdpDFgryuO8AscrjzoCScXTyqY2YV5IZIW2eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlNZZilskGW7eS4kWv0ORV4wF2ouIEuWvXhNUIuIr/z6XuOCosvRGu7krrA8uCNGGUfMc+K/hkNUkXZ6W7hX6nqFt9hVyqCdFkCBsZUXMY/es5vIKE9J6lzxyMO0wTftEYFZfiVa+odSg+sMGUskq7XrL/AcJeum5pC5BRv7l4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qU3VIkwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4151AC19421;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=XIKXkwSdpDFgryuO8AscrjzoCScXTyqY2YV5IZIW2eE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qU3VIkwi9ipzyXAef3IHjOfSkA6fgbg36bhmnZ6ctYJqEONhyVMlhjRj1OLRCXmCl
	 We2AO005UwaSCw0ORnwxjnbO8eC5sKEb/l/jW0cDm6fbEz63phFgsNGsAOE78nVNFS
	 vLOGt8CWmYmxw1yqX5deRc4MORmZsVwRKk8Z8Ur33ptY2rsnhswCd2hYkhcaWXGmNA
	 Tec/KlStxskkAA94AYXo0hgSjDeX+zBclWxT2JqqxfvfyQIXB73wlZgcDwdEnLYr8y
	 N+0z7XVD1Nn1dqtESANyeE7fbm0TNwZUXleBhnkoktx5zpp11Hk5uV0SBTrNYx9hKs
	 WTbBRmbqidnGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F01CA0FED;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 23:14:38 +0530
Subject: [PATCH v2 3/8] PCI/ASPM: Transition the device to D0 (if required)
 inside pci_enable_link_state_locked() API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-ath-aspm-fix-v2-3-61b2f2db7d89@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4214;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Qjbd70IC+ShOK3ZDf4DRoBiUH5NS5aHCnprLq7DQ7iM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEPLbdqO2EWRQxfmgtisJzzWpgiy2ZIIPyDr
 wXo38kcIkeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDwAKCRBVnxHm/pHO
 9Y3zB/9zEs5uWjC3Xrp3WhZFy5crlFwe49xFUi+A+EJpbRJDiMhgTxouJpKvRY/cZvY8DxcuyWq
 Q6VKk/Q1UWHC054LHzynKwqasTaviVYQgMqMwjJ4C06i9hMSyr/L2Hywarv9Nni8mhUD372eY4O
 Ry0svyzfWZJplUYBwqnbbhvSYfeX3oN++0ibNInhZ9fFX4dLGMvQUfAj1+EoX7Zk11ND+Z44c7q
 /34v40Br95YeTKp/FOIwVK8dayq7uZiqEKwRc3AcrXGobv4humuJVCA8HaXe79RalBT9kairD6/
 KQbjIRML/SnxYy9jMFN3tTtwmRh5tpXkjm+u8YXE6E7wjWXP
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
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..af705d71f72b2b7c3004cbb69cbd779c637bb22b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1042,11 +1042,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 
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
index b679c7f28f51c13468b60f1e6481a26d5967d4eb..85cfd8cbc6f7ed2730f4f8e5357d9b90d8906ad3 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -768,11 +768,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
index fac46113a90c7fac6c97125e6a7e385045780005..1243715bc054f859af175143a7ffaef0971f097a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1480,13 +1480,20 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
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
@@ -1500,8 +1507,8 @@ EXPORT_SYMBOL(pci_enable_link_state);
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
@@ -1511,6 +1518,13 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
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



