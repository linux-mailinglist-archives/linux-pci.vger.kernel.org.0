Return-Path: <linux-pci+bounces-2658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE783FAF3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0431F2379F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD8748790;
	Sun, 28 Jan 2024 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWWsE4pW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117C446DC;
	Sun, 28 Jan 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484738; cv=none; b=gsiZulFQVTP/M/fm1GfqKmt2B7ax71uwYfYZINURu8laMP885KGQeT/aW4fzcNJXO7EK9ZS2MW5x9vg6dyhmKTUli29d0lMPzLjdjToSsbqsPkno5wMp9jDclvaIn/PpPZtcTg7ORNtNIkv2UJaRCkVdqkBdqdRNpPuk5lHplMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484738; c=relaxed/simple;
	bh=rro8bua4GahrpLh+0Y+aOJSQnICNHshw7fWOe3S8s9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWCRBLxp+lFZUXTrLg/v1h8UBuJy1r9nhxPCxWuHlzAI7HnhXwj35YXrtwn2Sk/XUD6cZXWHM4VPqko0Pv6T2TMSe6aAaN+00MwlO9F/LZFwOgjhY3tXJEE/gczsEIrAJAXIRgqtby0R12dou+TL4+t26dHaeSqFbXeCvwWUQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWWsE4pW; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706484736; x=1738020736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rro8bua4GahrpLh+0Y+aOJSQnICNHshw7fWOe3S8s9w=;
  b=AWWsE4pWRIgm56TwixDWvb5csfBr/CCcCJ63zC/UuZcHXLG2VJ52LOd/
   Q289JrlMWG/JycZWOVxlqzm4PbA1p74Od2J0nrG46ZT/wLPUkPekt5A8Y
   PgPzyQAx81SvoheSF0qQdQfWRP0WGx1gGN7zKovamhRN5YQQfvZdZgZ9C
   dcly75jyCEHfanuHNpYHEDn3v2tLxbYQFq9X99W7Bn03h8hTvq5niiKch
   pmno7ntw8wbhgppVNBPD9rQK/2z4VYf13zvj8qmP2SQLv5C3yUYO943y+
   PNC+rz/FYeAAWKDuMo8i8HLYmtXk4iFpylSH+KBqVnzPxfLc5Lj7KYTrv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="467081116"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="467081116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="930913782"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="930913782"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:14 -0800
Received: from debox1-desk4.intel.com (sdutta-mobl2.amr.corp.intel.com [10.209.55.52])
	by linux.intel.com (Postfix) with ESMTP id AAAD0580D78;
	Sun, 28 Jan 2024 15:32:13 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: mika.westerberg@linux.intel.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com,
	rjw@rjwysocki.net
Cc: tasev.stefanoska@skynet.be,
	enriquezmark36@gmail.com,
	kernel@witt.link,
	wse@tuxedocomputers.com,
	vidyas@nvidia.com,
	kai.heng.feng@canonical.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ricky_wu@realtek.com,
	mario.limonciello@amd.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] PCI: Move pci_save/restore_ltr_state() to aspm.c
Date: Sun, 28 Jan 2024 15:32:11 -0800
Message-Id: <20240128233212.1139663-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128233212.1139663-1-david.e.box@linux.intel.com>
References: <20240128233212.1139663-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the LTR Capability is linked with ASPM and only enabled when
CONFIG_PCIEASPM is set, move the save/restore code to aspm.c

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.c       | 40 ----------------------------------------
 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0a8613e77dab..61e56e040510 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1636,46 +1636,6 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
 }
 
-static void pci_save_ltr_state(struct pci_dev *dev)
-{
-	int ltr;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!pci_is_pcie(dev))
-		return;
-
-	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!ltr)
-		return;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
-		return;
-	}
-
-	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
-}
-
-static void pci_restore_ltr_state(struct pci_dev *dev)
-{
-	struct pci_cap_saved_state *save_state;
-	int ltr;
-	u32 *cap;
-
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state || !ltr)
-		return;
-
-	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
-}
-
 /**
  * pci_save_state - save the PCI configuration space of a device before
  *		    suspending
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7b14cdbe2e69..98f54b48f013 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -100,6 +100,8 @@ void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_aspm_get_l1ss(struct pci_dev *pdev);
 void pci_save_aspm_state(struct pci_dev *pdev);
 void pci_restore_aspm_state(struct pci_dev *pdev);
+void pci_save_ltr_state(struct pci_dev *dev);
+void pci_restore_ltr_state(struct pci_dev *dev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3185058e9c41..f7712d8453a4 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -155,6 +155,46 @@ void pci_restore_aspm_state(struct pci_dev *pdev)
 	pcie_capability_set_word(pdev, PCI_EXP_LNKCTL, val);
 }
 
+void pci_save_ltr_state(struct pci_dev *dev)
+{
+	int ltr;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state) {
+		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
+		return;
+	}
+
+	/* Some broken devices only support dword access to LTR */
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
+}
+
+void pci_restore_ltr_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int ltr;
+	u32 *cap;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state || !ltr)
+		return;
+
+	/* Some broken devices only support dword access to LTR */
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
+}
+
 #ifdef CONFIG_PCIEASPM
 
 #ifdef MODULE_PARAM_PREFIX
-- 
2.34.1


