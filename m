Return-Path: <linux-pci+bounces-29414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECAAD5171
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4628C3A438C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF322620D2;
	Wed, 11 Jun 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lyltZpWw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC15282FA
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637208; cv=none; b=TEBE6nLS8fZWP+KJu/v7H6IaXArEZTwF8Dj1yDX/mUOEVypi5AwVS+FjVp7864CVS203lYR3euqg7uvJAYzlFkfHL7psnz6iPyNX0UU2GI/kVvqJEH5rk7yL65IiLVA7z140hq0R/neRnrUedhtr2ZhsCgkYrYEO4Tx24b+5oGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637208; c=relaxed/simple;
	bh=OBR9KbUQhCInu5VqSHbM9ZKj5vELiNdLmaCyADUlZfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dwBj0sI7d+bVUt714dFhxiJAEd8ONwjAHu7vPFIy9NOPhcS3feHHrWU/0VnqBon2Z7qkW3WPLnJ1NreIOcBTaoJuM0IUMj5AG6c1dGjvJY3o5encW5+lh16T5kkkSjVTWC3pk0J9dUOWc8stGoP693oGIOBLU50L/PGdHorYfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lyltZpWw; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown [123.112.65.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A8FB13FF71;
	Wed, 11 Jun 2025 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1749636889;
	bh=JmUcqxCFm+hpf3JzQy1Rf1CurmZTKEqtPHw8Xq/px2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=lyltZpWwgzdOApQGlpmcG7holpGVgQPM3F2ynYC2IA7QDUaCZYkHVUMDHg4PzXwps
	 W0t0XPlaViH2pHZTWRdcriKDWJXpOdgNRm7h3pCeo/Torp/8Lsy3r6CyHv7Gexz7id
	 qmoynliv7jFkIcqb3XnJQ4MAilK2UEaFQnAFGFePZbVu9GoPjLpU3SgCvMg840gtdt
	 ojnIQgi6xwNn3ztsdw7lencZiqtQ6AzShw0lw2ANNMEfxO1UUMV++7OVxxfmKqeXWZ
	 o2C12g9VQQGVpvVOiLaJLtIRS7FJqJnbiq+Szjz6jNrWPAJ8AZ+myWECtZ8MBTKUP3
	 GioYK1OU4O6oA==
From: Hui Wang <hui.wang@canonical.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: raphael.norwitz@nutanix.com,
	alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com,
	ilpo.jarvinen@linux.intel.com,
	hui.wang@canonical.com
Subject: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Date: Wed, 11 Jun 2025 18:14:42 +0800
Message-Id: <20250611101442.387378-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
Configuration RRS"), this Intel nvme [8086:0a54] works well. Since
that patch is merged to the kernel, this nvme stops working.

Through debugging, we found that commit introduces the RRS polling in
the pci_dev_wait(), for this nvme, when polling the PCI_VENDOR_ID, it
will return ~0 if the config access is not ready yet, but the polling
expects a return value of 0x0001 or a valid vendor_id, so the RRS
polling doesn't work for this nvme.

Here we add a pci quirk to disable the RRS polling for the device.

Fixes: d591f6804e7e ("PCI: Wait for device readiness with Configuration RRS")
Link: https://bugs.launchpad.net/bugs/2111521
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/pci/probe.c  |  3 ++-
 drivers/pci/quirks.c | 18 ++++++++++++++++++
 include/linux/pci.h  |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..848fa0e6cf60 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1270,7 +1270,8 @@ static void pci_enable_rrs_sv(struct pci_dev *pdev)
 	if (root_cap & PCI_EXP_RTCAP_RRS_SV) {
 		pcie_capability_set_word(pdev, PCI_EXP_RTCTL,
 					 PCI_EXP_RTCTL_RRS_SVE);
-		pdev->config_rrs_sv = 1;
+		if (!(pdev->dev_flags & PCI_DEV_FLAGS_NO_RRS_SV))
+			pdev->config_rrs_sv = 1;
 	}
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index cf483d82572c..519e48ff6448 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6336,3 +6336,21 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+/*
+ * Although the root port device claims to support RRS, some devices don't work
+ * with RRS polling, when reading the Vendor ID, they just return ~0 if config
+ * access is not ready, this will break the pci_dev_wait(). Here disable the RRS
+ * forcibly for this type of device.
+ */
+static void quirk_no_rrs_sv(struct pci_dev *dev)
+{
+	struct pci_dev *root;
+
+	root = pcie_find_root_port(dev);
+	if (root) {
+		root->dev_flags |= PCI_DEV_FLAGS_NO_RRS_SV;
+		root->config_rrs_sv = 0;
+	}
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0a54, quirk_no_rrs_sv);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..f4dd9ada12e4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -247,6 +247,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
 	/* Device requires write to PCI_MSIX_ENTRY_DATA before any MSIX reads */
 	PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST = (__force pci_dev_flags_t) (1 << 13),
+	/* Do not use Configuration Request Retry Status polling in pci_dev_wait() */
+	PCI_DEV_FLAGS_NO_RRS_SV = (__force pci_dev_flags_t) (1 << 14),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.34.1


