Return-Path: <linux-pci+bounces-21013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DBAA2D3F1
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 06:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A30188D97C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 05:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF14219F12A;
	Sat,  8 Feb 2025 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+uSmFw6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A819F115;
	Sat,  8 Feb 2025 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738991016; cv=none; b=NZN1WtZThjO5Ezu8jlX4/ossJIpWOP57yPhH3mhx1r4XMui0k6pQMbH+lw5RUSUCwK9+Bi4BHsg3962wVKkHfEpOkqAWxud89RV95SyWUUgHzerQEVrQKzdRBDP10j6uEtAz+NCKtlTczPbxdba1MqY7ctHO0A0FGLLRmsSzK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738991016; c=relaxed/simple;
	bh=5+WepBgrJ9vnrfCD2exNLAnJnxXrfpzwCGQna165RnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBq7OzEVSp0iIWQokvOOhsVmpzSm9eIvTCvst2Hl7Wp5Bj1bNN3gcyHDqs+Ch2wI1FtZJ8UfJUiChMq09uksMxWlXtCV+RdmDrlxVh4GiaHkt8AXf6XAW1YjXu1B2JDRw6eAy1v4T9FvI6otckWNVrDn6LKZX5wpS/eduWGBLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+uSmFw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0757FC4CEDF;
	Sat,  8 Feb 2025 05:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738991016;
	bh=5+WepBgrJ9vnrfCD2exNLAnJnxXrfpzwCGQna165RnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+uSmFw6BCoO6TUsJWXPNKMDzisLafc0mAMpEOtlogyYHLejdtfHxrWEpxJ+0SXDH
	 +x7lPrSY0f3KRSCafBdR/5fTlMaUgxVAtEtyBFXqqVa9bOZTpgrKYdE7UpNvTVWrWX
	 PsrykdDUmNT0IViC8jW0lJUpGAT1XQrzx0sUI//V5IJ4brseCYXrL6Pjnt2FoGmFW7
	 seMY2JQsuTIUxwrponpfwEmw0Cv/staEVMoJ5xBCJUinBc1zfYlScMMjxoiYWOOfMy
	 3i3IQiWE00URacMyzESTNktxwdIfOfEibRyQZeA7RN+/33na5y8jRLhvkwOdEBl7g9
	 jKN02st3JvLKQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] PCI: Avoid pointless capability searches
Date: Fri,  7 Feb 2025 23:03:28 -0600
Message-Id: <20250208050329.1092214-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208050329.1092214-1-helgaas@kernel.org>
References: <20250208050329.1092214-1-helgaas@kernel.org>
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
 drivers/pci/vc.c        | 22 +++++++++++-----------
 3 files changed, 33 insertions(+), 31 deletions(-)

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
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index a4ff7f5f66dd..c39f3be518d4 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -355,20 +355,17 @@ int pci_save_vc_state(struct pci_dev *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int pos, ret;
 		struct pci_cap_saved_state *save_state;
+		int pos, ret;
+
+		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
+		if (!save_state)
+			return -ENOMEM;
 
 		pos = pci_find_ext_capability(dev, vc_caps[i].id);
 		if (!pos)
 			continue;
 
-		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
-		if (!save_state) {
-			pci_err(dev, "%s buffer not found in %s\n",
-				vc_caps[i].name, __func__);
-			return -ENOMEM;
-		}
-
 		ret = pci_vc_do_save_buffer(dev, pos, save_state, true);
 		if (ret) {
 			pci_err(dev, "%s save unsuccessful %s\n",
@@ -392,12 +389,15 @@ void pci_restore_vc_state(struct pci_dev *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
-		int pos;
 		struct pci_cap_saved_state *save_state;
+		int pos;
+
+		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
+		if (!save_state)
+			continue;
 
 		pos = pci_find_ext_capability(dev, vc_caps[i].id);
-		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
-		if (!save_state || !pos)
+		if (!pos)
 			continue;
 
 		pci_vc_do_save_buffer(dev, pos, save_state, false);
-- 
2.34.1


