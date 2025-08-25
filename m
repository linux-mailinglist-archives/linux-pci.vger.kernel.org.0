Return-Path: <linux-pci+bounces-34675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C53B34933
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 19:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716A9188AB69
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903E309DC4;
	Mon, 25 Aug 2025 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWvuaw4f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599C308F0F;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143890; cv=none; b=mGGDRyw4gPE7VoKJJ4u+hhCLY9WQlYpSuLX8ErsDC0NBgHl3589fg8erDzVkQfj+faG+9GD4Qnt6NTOes04w4mUiwoF33tUSyhY7242wss0thd+5CRuapEbvSVRqcYAn0Tk/aIX8Mm6vFEXjbselwEV6nRorl7fhMuNKiDaY9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143890; c=relaxed/simple;
	bh=W2VzOd4LaPPqd03f5mZn4e//pyUDYNDJInaL1ivlSb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlP7sVFdxpGX3cGaXMNJcrjZvrtJzvSu6GK0+IyeEVGC2t1kCBzvWT3TgjT6tjVeAXH2P2LtyTRC8u1KzIfKxxqv5x0rcngSTSdBlWC5L35JC1HSdfIC5n0i2FNW1CzoDsG8cwTU6x0C/8r3pk6WS8Rx71tyhYwoqMS7Yt/S3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWvuaw4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65332C4AF1A;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143890;
	bh=W2VzOd4LaPPqd03f5mZn4e//pyUDYNDJInaL1ivlSb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oWvuaw4fY34Fat0zJPLQ7kPHaaOYJgM4O8T3jfYUYUnWgXkCt+zUcyNKGLHfpQFvF
	 YG7iJRa9WRiOm+gC/vpjA0ViELfa9lWuTluGvQYfYB1g0K68p123JM1MFeBXBYmwJl
	 4cNpEoj0cG0s33COjUZYyctZDye1Q5MymUpE2D+sKkqMKUydBDDoia906G98jJ2aVk
	 RDfleTU7oQE30h0Yzyx6/htVdwrJQU+R+6ddbutX2+7fSa+nk2vc9Ef6Bh2F3yjU3R
	 xCgXZO+sgy/aBi5MDYA5K6o54uQSQuL4/Rg6jGM3If8WfhStHwU99+j5w2XAhvaS4f
	 gw0l+uOKDpXqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F7CA0FE7;
	Mon, 25 Aug 2025 17:44:50 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 25 Aug 2025 23:14:40 +0530
Subject: [PATCH v2 5/8] PCI/ASPM: Return enabled ASPM states from
 pcie_aspm_enabled() API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-ath-aspm-fix-v2-5-61b2f2db7d89@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=jMfN6qwvopwk5oh/k0Cf9IL8m25slb1JveeGwVNhrME=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBorKEPiwhWp+/PSd/iBSrmb3dl5Tv2stjEC5I9s
 hxFRCLyDCmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKyhDwAKCRBVnxHm/pHO
 9U8+B/0c1VbCfjh2R58dS1EgS8LhCsvsrwAoexW6nBilgkDlYrlhBMoBaLI9cifrzAIzOEwcpwp
 NcFXH/cJcNB4HE8+VOkeAosGiDRPAmkzhw0lCs0Zlke9MbptGXuiPFDUt3GmgUZFkni+1PmQiZ6
 t6ufSeZOuHr+lb4VOpYPvZuElkBpX9XkBPc2DkTZqNa2qxW6FlpPDQju2PvMuVCv7T7pt2oMDuZ
 cZ90VmyDcXelHokd348TRdPfCo7jMmed/A1/r531KO5UTv8PLsuSq9Qvt5HkrI2hNPVe0r0BCKj
 ycJ81OSii5p8Cs+xcBp48q2Q8kYaaB30f/wEOr4w8XM10UxL
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

pcie_aspm_enabled() returns 'pcie_link_state::aspm_enabled' parameter which
contains the enabled states. But the API currently returns the 'bool' type
which is used by the callers to decide if ASPM is enabled or not.

To allow the future callers to also make use of the enabled ASPM states,
return the actual type of 'pcie_link_state::aspm_enabled' parameter, 'u32'.

Existing callers can still treat the return value as a 'bool' as the C11
standard guarantees the behavior (this API relied on the same behavior
before as well).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 6 ++++--
 include/linux/pci.h     | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3c8101023e80d3c0550136f729782c0e0a3e28cf..fed44b7cb46e9f34c9ef6d5fa6a7b009976cbfdc 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1582,15 +1582,17 @@ module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
 	NULL, 0644);
 
 /**
- * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
+ * pcie_aspm_enabled - Get the enabled PCIe ASPM states for a device.
  * @pdev: Target device.
  *
  * Relies on the upstream bridge's link_state being valid.  The link_state
  * is deallocated only when the last child of the bridge (i.e., @pdev or a
  * sibling) is removed, and the caller should be holding a reference to
  * @pdev, so this should be safe.
+ *
+ * Return: Enabled PCIe ASPM states. 0 if ASPM is disabled.
  */
-bool pcie_aspm_enabled(struct pci_dev *pdev)
+u32 pcie_aspm_enabled(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860dbe50ee6c207cd57e54f51a11079..6f3c5d6a9a959abefbb69e1165aec704da507313 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1851,7 +1851,7 @@ int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
-bool pcie_aspm_enabled(struct pci_dev *pdev);
+u32 pcie_aspm_enabled(struct pci_dev *pdev);
 #else
 static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
@@ -1863,7 +1863,7 @@ static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
-static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
+static inline u32 pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_HOTPLUG_PCI

-- 
2.45.2



