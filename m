Return-Path: <linux-pci+bounces-2657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DD83FAF2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 00:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758AF1C22312
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910F45BE8;
	Sun, 28 Jan 2024 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDgcT85+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87758446C7;
	Sun, 28 Jan 2024 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484738; cv=none; b=ak7U3V7+jvTL1QItB8JoptN7NzgEK86fMPPZovZUVNME3G0MMD5gSuAjycuhI2272QEEQkTIDICH7L4B06wyE32mUdLMFE2HaFsFKnvgus9gQJRvtrq/QUZZFmQCesodMwedhWwKi9/73qt1Hi+HxRYeXKH7VpwTwjahJCwZhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484738; c=relaxed/simple;
	bh=A9rffJbajff9awr7vGDw2RsxSnFOjMip9EPd4+FSp9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ug0hs+I0S5XcsUUmBeQw4fwzPlicBX546OOdJRNm8NFLNAQijFVLGnmlnhth4ImZGfqW52u5wOe9082+LxRdHi3tyxDcuCZiuFi0Qf4gsMqojf9RWKMHlZlKbfye5oSSYR3Z3V0zfapExLYy8RCFnubrJEYm0qrMgrcT8hfeQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDgcT85+; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706484736; x=1738020736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A9rffJbajff9awr7vGDw2RsxSnFOjMip9EPd4+FSp9U=;
  b=nDgcT85+pYgo8Vcfs4KuceeVSCrN1r0FKk/ii+QDhI7H9lIyLfUR/NHM
   tIs4gM6YApshqUZ/N7BahCsd+cp8emRbpGk9WQBWVCMruxnBTHbpkAgDu
   OCtnr+4x/kLU+rj1KR45Z2P4EhstuxOUDJOgrgplsi48RwRbeSBibeYGp
   7hsI2cBKgpB8SyaQhV8qVu2uw0L7+ptFNl8LpVkVnQVQckQSnmLGSot1l
   F+4irKAYg/KquirDBghimzuNNuzQgvdtBJyQVLXnyltvVs2rrraFsqw+U
   UZ2xOqy6hHC2G6zNl79UZSaSvqFPAYFTA1vWGDFL6rEIM523UTkWNAkT1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406535989"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406535989"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="857921255"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="857921255"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 15:32:13 -0800
Received: from debox1-desk4.intel.com (sdutta-mobl2.amr.corp.intel.com [10.209.55.52])
	by linux.intel.com (Postfix) with ESMTP id E6860580DD4;
	Sun, 28 Jan 2024 15:32:12 -0800 (PST)
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
Subject: [PATCH 2/5] PCI: Create function to save L1SS offset
Date: Sun, 28 Jan 2024 15:32:09 -0800
Message-Id: <20240128233212.1139663-3-david.e.box@linux.intel.com>
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

The offset for the L1 Substate Capability register is not saved in pci_dev
until pci_configure_ltr() which only builds with CONFIG_PCIEASPM. Instead,
create a separate function to retrieve the offset so that it is always
available. This offset will be used to save and restore the L1SS registers
even when PCIEASPM=n.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.h       | 1 +
 drivers/pci/pcie/aspm.c | 9 ++++++---
 drivers/pci/probe.c     | 1 +
 include/linux/pci.h     | 4 ++--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6771862de921..b48e8e4f360f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -97,6 +97,7 @@ void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
+void pci_aspm_get_l1ss(struct pci_dev *pdev);
 int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 6d077e237a65..93718b733af3 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -24,6 +24,12 @@
 
 #include "../pci.h"
 
+void pci_aspm_get_l1ss(struct pci_dev *pdev)
+{
+	/* Read L1 PM substate capabilities */
+	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+}
+
 #ifdef CONFIG_PCIEASPM
 
 #ifdef MODULE_PARAM_PREFIX
@@ -970,9 +976,6 @@ void pci_configure_ltr(struct pci_dev *pdev)
 	if (!pci_is_pcie(pdev))
 		return;
 
-	/* Read L1 PM substate capabilities */
-	pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-
 	pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b8c2c9cc9dd..e39ad912ce8c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2208,6 +2208,7 @@ static void pci_configure_device(struct pci_dev *dev)
 	pci_configure_mps(dev);
 	pci_configure_extended_tags(dev, NULL);
 	pci_configure_relaxed_ordering(dev);
+	pci_aspm_get_l1ss(dev);
 	pci_configure_ltr(dev);
 	pci_configure_eetlp_prefix(dev);
 	pci_configure_serr(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dea043bc1e38..dfc4b525c7a1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -390,9 +390,9 @@ struct pci_dev {
 	unsigned int	d3hot_delay;	/* D3hot->D0 transition time in ms */
 	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
 
-#ifdef CONFIG_PCIEASPM
-	struct pcie_link_state	*link_state;	/* ASPM link state */
 	u16		l1ss;		/* L1SS Capability pointer */
+#ifdef CONFIG_PCIEASPM
+	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
 #endif
-- 
2.34.1


