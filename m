Return-Path: <linux-pci+bounces-26400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CEBA96D87
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7133B188A123
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB01E283CBD;
	Tue, 22 Apr 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qrsh4W6+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A3284682;
	Tue, 22 Apr 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330101; cv=none; b=o8dB2JLm5o8mkKNmYFPSgNEFJs1xKmFA/2dpqQcLYUPBNTuZWoHWOII9yC8tAv6plxfOHx0+pmV0pHO/fmxIESmGeRjkvtyF+nT3T3mZm2vzHQ7pzuILMsbWoFKJSZh2FgIG/x4sgy8gjOy9Mj0Z8dNEr9hic4/S6tTOqzmEmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330101; c=relaxed/simple;
	bh=TWyVYWRdbaf00eKHwQrQSn9Z3lMxEd5ED3jW6Avvoy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K4BhedNqF+pXXmYEL51jF/mheCrQjXoKTYcqfwpd7adt6G7KAJw1GUIcEtjvixIJuJG10GDL1Mf/CaHbfLGSKYczYQcBsSKgoB+mEMn10ECQlNHNaVTcdnvKnLVbBjgvD/nJVu7ymkXy3phRUMblyOIcmeVfbn3RunNROsdFtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qrsh4W6+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745330101; x=1776866101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TWyVYWRdbaf00eKHwQrQSn9Z3lMxEd5ED3jW6Avvoy4=;
  b=Qrsh4W6+BtqoThwTZ0Jc3aVuTf8qD5MJyU0nT3vsDJByBoHTtcZMKv7a
   FUOkEbcpsYDPWpiw+KbrZPQGIZ6FE/ZIKC/CzMxaD6Coe5x6Pgmg6Wl5v
   Peyg3NLkf4XOGTP2XktUVT2EVMD6LxHXZ6J5aZLhgwgi/ockR3XBLFek5
   bCnEMxMfDyM6RhtXTqbn2oh5u2P2qD9Am57zswaGurNWU+PYUwzJwC6Jn
   ZdGDMLXPG/xesOF3mkJgQX01DptTgqUSBmSDe9/qnGwTnGmvDroqj5FJo
   yo9KlqEfI8ADFhNbokxvHZeIsw0lbqbEUq962/LgFvZghpZnN0gcLyE//
   g==;
X-CSE-ConnectionGUID: gzjyOahrRZWGq3r56yZEgw==
X-CSE-MsgGUID: A3+e24KIT0uXj+wnY8Xexg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="50550440"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="50550440"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 06:55:00 -0700
X-CSE-ConnectionGUID: izvj1jXUQEmb6J2HK9B5+A==
X-CSE-MsgGUID: 6Cx/xDUgTaSAiL7Ccp8hHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="136812225"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa005.fm.intel.com with ESMTP; 22 Apr 2025 06:54:56 -0700
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
Subject: [PATCH v2] PCI/PM: Avoid suspending the device with errors
Date: Tue, 22 Apr 2025 19:23:41 +0530
Message-Id: <20250422135341.2780925-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error is triggered before or during system suspend, any bus level
power state transition will result in unpredictable behaviour by the
device with failed recovery. Avoid suspending such a device and leave
it in its existing power state.

This only covers the devices that rely on PCI core PM for their power
state transition.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---

v2: Synchronize AER handling with PCI PM (Rafael)

More discussion on [1].
[1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/

 drivers/pci/pci-driver.c |  3 ++-
 drivers/pci/pcie/aer.c   | 11 +++++++++++
 include/linux/aer.h      |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f57ea36d125d..289a1fa7cb2d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		}
 	}
 
-	if (!pci_dev->state_saved) {
+	/* Avoid suspending the device with errors */
+	if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
 		pci_save_state(pci_dev);
 
 		/*
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..b70f5011d4f5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -233,6 +233,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
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
index 947b63091902..68ae5378256e 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -48,12 +48,14 @@ struct aer_capability_regs {
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


