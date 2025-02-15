Return-Path: <linux-pci+bounces-21534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ACEA36944
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 01:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADD118952BD
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 00:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A9567D;
	Sat, 15 Feb 2025 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En8CkHFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EE4C92;
	Sat, 15 Feb 2025 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577788; cv=none; b=GuKx3AZXYXz1DXaL5jORIiL1dIoSmVx8vr21JVaBAmYNPTFNrlhFqmYcp1hRA4Y7dENTwfiD2R4DbhWRP2RLPn1dsMudZzaUYsiFT6Dbz3bsMT/1qQQw88qrbtaRXEcVIYzdJWmhIY8nq/IfJd2hRyCly9k8UmpnWplPfFvWm2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577788; c=relaxed/simple;
	bh=JIoKUIuy1b9eKZinQ1TLFl2oNjJg3VjzFrFTHpXj+AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5X4h/VVVFd/AEmPdrnbZJpTm6xYU/NxhUpwHKBX/sn1vxt+iAsFLBDrOSD2o5+FzSNKSDAoGKyuxTFHIO8+Ho3HbLjuf9KIzRfq8c/QhHtyMBj1Ie1Ux66j+nlViDMp9OXsjEePNfJTo7AUkmMT7Vir+/TnONFRw/AJzUwkXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En8CkHFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C18C4CEE6;
	Sat, 15 Feb 2025 00:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739577788;
	bh=JIoKUIuy1b9eKZinQ1TLFl2oNjJg3VjzFrFTHpXj+AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=En8CkHFwLyWFxCGpUuw40oavsHIn+F+OAzqsWeP/gyfaBPTF6Cift9f5+1sl1DcDi
	 oc94Vv1WAqZpyz7Vb1n5VDVc15usF8HnLW9hwSTwpDo3bSoV+MXzaKPKzlO1ojbuSo
	 YuJGSuoemD/GY3IeJS+NG5NsFMsQPAOXM2ZMCgrbLP+hJfbd7TUAnmSailV4BqWvTP
	 bXcG21F6kKKfd56LJBbyOCrZFCKmHW9x++SQlA997l2Qgxx7q8DGNH3XfnxWBWJoED
	 PgMuTV7/WvBj30miblF5Sp0fAyt3GqJDEBa1o9+x11q/YNPBMZBkxlgr9X6dZh6Q5d
	 +iilWQrbDAWBQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] PCI: Avoid pointless capability searches
Date: Fri, 14 Feb 2025 18:03:00 -0600
Message-Id: <20250215000301.175097-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250215000301.175097-1-helgaas@kernel.org>
References: <20250215000301.175097-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Many of the save/restore functions in the pci_save_state() and
pci_restore_state() paths depend on both a PCI capability of the device and
a pci_cap_saved_state structure to hold the configuration data, and they
skip the operation if either is missing.

Look for the pci_cap_saved_state first so if we don't have one, we can skip
searching for the device capability, which requires several slow config
space accesses.

Remove some error messages if the pci_cap_saved_state is not found so we
don't complain about having no saved state for a capability the device
doesn't have.  We have already warned in pci_allocate_cap_save_buffers() if
the capability is present but we were unable to allocate a buffer.

Other than the message change, no functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c       | 27 ++++++++++++++-------------
 drivers/pci/pcie/aspm.c | 15 ++++++++-------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..503376bf7e75 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1686,10 +1686,8 @@ static int pci_save_pcie_state(struct pci_dev *dev)
 		return 0;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
-	if (!save_state) {
-		pci_err(dev, "buffer not found in %s\n", __func__);
+	if (!save_state)
 		return -ENOMEM;
-	}
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
@@ -1742,19 +1740,17 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 
 static int pci_save_pcix_state(struct pci_dev *dev)
 {
-	int pos;
 	struct pci_cap_saved_state *save_state;
+	u8 pos;
+
+	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
+	if (!save_state)
+		return -ENOMEM;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (!pos)
 		return 0;
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
-	if (!save_state) {
-		pci_err(dev, "buffer not found in %s\n", __func__);
-		return -ENOMEM;
-	}
-
 	pci_read_config_word(dev, pos + PCI_X_CMD,
 			     (u16 *)save_state->cap.data);
 
@@ -1763,14 +1759,19 @@ static int pci_save_pcix_state(struct pci_dev *dev)
 
 static void pci_restore_pcix_state(struct pci_dev *dev)
 {
-	int i = 0, pos;
 	struct pci_cap_saved_state *save_state;
+	u8 pos;
+	int i = 0;
 	u16 *cap;
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
-	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (!save_state || !pos)
+	if (!save_state)
 		return;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!pos)
+		return;
+
 	cap = (u16 *)&save_state->cap.data[0];
 
 	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e0bc90597dca..007e4a082e6f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -35,16 +35,14 @@ void pci_save_ltr_state(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state)
+		return;
+
 	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
 	if (!ltr)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
-		return;
-	}
-
 	/* Some broken devices only support dword access to LTR */
 	cap = &save_state->cap.data[0];
 	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
@@ -57,8 +55,11 @@ void pci_restore_ltr_state(struct pci_dev *dev)
 	u32 *cap;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state)
+		return;
+
 	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state || !ltr)
+	if (!ltr)
 		return;
 
 	/* Some broken devices only support dword access to LTR */
-- 
2.34.1


