Return-Path: <linux-pci+bounces-27954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA2ABBB29
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68D1188EC87
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA5274FF8;
	Mon, 19 May 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bySbMTmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684B2741DB;
	Mon, 19 May 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650591; cv=none; b=oXD1A3v7zVicgTFsWNyGpZQkLqmOZMQIWP807U7XYE13hc7YnIi5ymFoNnd7V4aTbt34zPM7CgGd2r3vXuPeQ98/DtBDGgaHmYneqY+20WGuZdLzcfVjEgI8VSJvALrwoOw6SRJeY3DOvyHXq+WI7YQzbTUuB5A4R+hSFDERneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650591; c=relaxed/simple;
	bh=u2umoj7tc38h+UCsg2yiDd1w3Fbs+juze6/ne+pL28U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UKaiH2eMste4Mih6wg2jMmuiwJacBvdKIT2A/+gTa5RHBHpTup5QBaj2xEID99Ev22Jz2D01/g3BEE/EtfZDql8qEQSIWpEWayJ0Xx2IROhCflPMCyMFtxeOKV9N6XkUXEyjBJ3OFlWIB2XrW+c9hVBd2neGPFbACtmuGXjfOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bySbMTmF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747650590; x=1779186590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u2umoj7tc38h+UCsg2yiDd1w3Fbs+juze6/ne+pL28U=;
  b=bySbMTmF5PiNYE/roZm6CwJ22mauHqLgg8y+hqKTdDPvmIamRLz9f6am
   8XfyZ9vCo0HXB+fzcPvn9L1KK9xW/nd0m5opn3cPFTbpIgk84q4nxsGtW
   TQZWzTftT4QrbuifonIfDmXuhw8BDfHkFE/hkyG0PEW1gBik82zXnMNng
   QiKZ2lehwcjfBdzuXBOxrn+Kcx/k0s8627P+JpP7rPzGbV40AuKE1NWE0
   5qwtKevki0ryNnjQRDU9nc3tZmMDn1IJVclFZ640P95GwjFCfktykfVmd
   iItJ/qH9KVwWxGqe15jxgx7RCePM7IjxbLbyjZ44BtcIIbhWaBCBQdjDE
   w==;
X-CSE-ConnectionGUID: NGiIwfs2SPO8vzxV0shJxg==
X-CSE-MsgGUID: CYGxl32mQ7GutMqeLLFERQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="74944363"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="74944363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 03:29:49 -0700
X-CSE-ConnectionGUID: s13CgR9JScu065CMVy2GKA==
X-CSE-MsgGUID: IGekov2xQXSfPgh3gq8shw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144202756"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa005.fm.intel.com with ESMTP; 19 May 2025 03:29:45 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com,
	superm1@kernel.org,
	benato.denis96@gmail.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4] PCI: Prevent power state transition of erroneous device
Date: Mon, 19 May 2025 15:58:08 +0530
Message-Id: <20250519102808.4130271-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If error status is set on an AER capable device, most likely either the
device recovery is in progress or has already failed. Neither of the
cases are well suited for power state transition of the device, since
this can lead to unpredictable consequences like resume failure, or in
worst case the device is lost because of it. Leave the device in its
existing power state to avoid such issues.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---

v2: Synchronize AER handling with PCI PM (Rafael)
v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
    Elaborate "why" (Bjorn)
v4: Rely on error status instead of device status
    Condense comment (Lukas)

More discussion on [1].
[1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/

 drivers/pci/pci.c      |  9 +++++++++
 drivers/pci/pcie/aer.c | 13 +++++++++++++
 include/linux/aer.h    |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..a20018692933 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/aer.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -1539,6 +1540,14 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	/*
+	 * If error status is set on an AER capable device, it is not well
+	 * suited for power state transition. Leave it in its existing power
+	 * state to avoid issues like unpredictable resume failure.
+	 */
+	if (pci_aer_in_progress(dev))
+		return -EIO;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..617fbac0d38a 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -237,6 +237,19 @@ int pcie_aer_is_native(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
 
+bool pci_aer_in_progress(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 cor, uncor;
+
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &cor);
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor);
+	return cor || uncor;
+}
+
 static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
 	int rc;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 02940be66324..e6a380bb2e68 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -56,12 +56,14 @@ struct aer_capability_regs {
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+bool pci_aer_in_progress(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.34.1


