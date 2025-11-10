Return-Path: <linux-pci+bounces-40790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCEC49941
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F133A78D4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673AE33F370;
	Mon, 10 Nov 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbHnf06D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28F33CE84;
	Mon, 10 Nov 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813790; cv=none; b=REsOe+UlOHOxyqUFLlMGnQ63bWDb2nM2qmk4qT9MSo5GRuuiB0rlm1U8zU2Zqwo/sM9rGTIEhX6+ckwj3K63y7egCM8PxAIrv3GQm6PYTuRQanPb/6kOZCZ9dqTGdaZhVrO2OY3h+Qj22Y2ht+bKDHZAr2F1Qxvq5Wx+MmWijOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813790; c=relaxed/simple;
	bh=+PAn5KKDm+HKMhr0isGB8WG7OccvwXkrZSq0tSNltXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB/UKJSqooSAU5KkjnTdmZHhrAjD61kwVsocICrUK5cIQTdTdB3UTXpWoGQTb2MFSxXXSv6+fnfbNyou4AO2QDdmjGorNhtb0fa0VJRD/chfTD6PA3ngI8xawDDMXZ+Hyr3K6ec5BIa6BJY1SR35PUw+mbWKHnzTYJ/VghEGLro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbHnf06D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BD4C2BCB6;
	Mon, 10 Nov 2025 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762813789;
	bh=+PAn5KKDm+HKMhr0isGB8WG7OccvwXkrZSq0tSNltXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbHnf06DgWCpt3ix50Qh1sy0gaR5wckkgQxhCzMd6X5MdlMwdrONp7pJ1dOIVKddv
	 an9pkrOArjTcMEhCNrVehpAYb0PfEEQyAWO3Weo4ZmvDr45qOfDHfp8YHgMVq/HYni
	 HW/I/iYQbqNBHZ84spFvk7XCc7Xgfz50fp9M7UWf9OrkonzZs4KRuJetzcBMY8WHP0
	 8dBNsTdn+kLOcP2dYv8+z67xQJmVUNRGAyscWpWP4sB9Y4oA8VX8qRRgAvc0F1t3Ox
	 gjpKxshKstOcMbsQwt4I2Cjp6iW3HkuQ4kCYqwfebRcCcLAWLCBfnotL3ZjItnLAk3
	 FTAbN66U/xxmA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>,
	Al <al@datazap.net>,
	Roland <rol7and@gmx.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/4] PCI/ASPM: Add pcie_aspm_remove_cap() to override advertised link states
Date: Mon, 10 Nov 2025 16:22:26 -0600
Message-ID: <20251110222929.2140564-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110222929.2140564-1-helgaas@kernel.org>
References: <20251110222929.2140564-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Add pcie_aspm_remove_cap().  A quirk can use this to prevent use of ASPM
L0s or L1 link states, even if the device advertised support for them.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..36f8c0985430 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -958,6 +958,7 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev);
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
 
 #ifdef CONFIG_PCIEASPM
+void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
@@ -965,6 +966,7 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_configure_ltr(struct pci_dev *pdev);
 void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
 #else
+static inline void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap) { }
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked) { }
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 15d50c089070..bc3cb8bc7018 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1542,6 +1542,19 @@ int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_enable_link_state_locked);
 
+void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap)
+{
+	if (lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
+		pdev->aspm_l0s_support = 0;
+	if (lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
+		pdev->aspm_l1_support = 0;
+
+	pci_info(pdev, "ASPM:%s%s removed from Link Capabilities to avoid device defect\n",
+		 lnkcap & PCI_EXP_LNKCAP_ASPM_L0S ? " L0s" : "",
+		 lnkcap & PCI_EXP_LNKCAP_ASPM_L1 ? " L1" : "");
+
+}
+
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
 {
-- 
2.43.0


