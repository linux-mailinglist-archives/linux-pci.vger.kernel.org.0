Return-Path: <linux-pci+bounces-27116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCFAA8556
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E413A4284
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 09:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C316F0FE;
	Sun,  4 May 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNi+vpqc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA41862;
	Sun,  4 May 2025 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349581; cv=none; b=EoATXI2m/vTiU5T3eM32SOBd0wV5+1ocBIBpzo3C3HBW4mNDqn7L9tPZ+Mm5a+SxVSt+s2Cn3RzuPfXjCKkTIHk7Y9HM8QEfo2VzK3Uqn2Zf33BhNyjvv2yFLFV+LPktvLwEgtJpgGhj/Y9R/LlXaDlND7ZRcm6CkFFP0mv3lBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349581; c=relaxed/simple;
	bh=akeD7GpCYdsIQj5vN0Xg5EIa/J9Oa1sMvms7Gb2Nz8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGOnTybHV5sSuMlk9SKw3kuzRBbWC+5hH/sVGGuNEcFgmCUUHlMlrFMHr5s/LyD4/A9bqmtZMcRBD+3pw++xWuqtEAVZW+u63OHW45yAS39UMImO173k+WHRbnOe3RWz1u/hGMLFhJU/ydEfTDskNQuhZ0Y93S3CZ1nQrrsMieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNi+vpqc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746349580; x=1777885580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=akeD7GpCYdsIQj5vN0Xg5EIa/J9Oa1sMvms7Gb2Nz8Y=;
  b=LNi+vpqc6F6NMO7oQW7rWFefOyEpL+VdVmqsEJCHSW64JiL00N6/Bka2
   GUPOoZvuLiyE2wKo1AC601g5BVGI5NB+IXrhjftcURc3I1qZf3PGHLGtS
   zwvHvJTJBTxPLDoUAvQSGhd6echUbjLwQqT8y/HAexlbRoRCdFwL4j0P1
   h+EBeLFIxxso2hEA6t8RzBstC44agK1wazze9s1Lzutkijuu+9iDXae7n
   SS4sE9jJD+3BqpwTF1s95FRtNRstDXicoNdNt3nSHHfo7fPQfkxsroHxI
   2UZR4wUVw/d/zAmA6wFCrN7aqTobtnl5WzZp6e0WLAaveQ1yI4jnF4PDL
   A==;
X-CSE-ConnectionGUID: 6EMpRqrQR1a0jJrjtxPJNA==
X-CSE-MsgGUID: FWUtnhKlTjeW1SQcSe8iew==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48064559"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="48064559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 02:06:19 -0700
X-CSE-ConnectionGUID: YNa+jKl8RB+gVLS7AU5v0A==
X-CSE-MsgGUID: C3kZ8idxTQCewhXOcl6u2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="172232060"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa001.jf.intel.com with ESMTP; 04 May 2025 02:06:15 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3] PCI: Prevent power state transition of erroneous device
Date: Sun,  4 May 2025 14:34:44 +0530
Message-Id: <20250504090444.3347952-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If error flags are set on an AER capable device, most likely either the
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

More discussion on [1].
[1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/

 drivers/pci/pci.c      | 12 ++++++++++++
 drivers/pci/pcie/aer.c | 11 +++++++++++
 include/linux/aer.h    |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d7c9f64ea24..25b2df34336c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/aer.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	/*
+	 * If error flags are set on an AER capable device, most likely either
+	 * the device recovery is in progress or has already failed. Neither of
+	 * the cases are well suited for power state transition of the device,
+	 * since this can lead to unpredictable consequences like resume
+	 * failure, or in worst case the device is lost because of it. Leave the
+	 * device in its existing power state to avoid such issues.
+	 */
+	if (pci_aer_in_progress(dev))
+		return -EIO;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..4040770df4f0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
 
+bool pci_aer_in_progress(struct pci_dev *dev)
+{
+	u16 reg16;
+
+	if (!pcie_aer_is_native(dev))
+		return false;
+
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
+	return !!(reg16 & PCI_EXP_AER_FLAGS);
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


