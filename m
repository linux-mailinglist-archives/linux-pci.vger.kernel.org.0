Return-Path: <linux-pci+bounces-6185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B101A8A2FA0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E16284023
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 13:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643AF83CDB;
	Fri, 12 Apr 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxCRcSmE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C8824BC;
	Fri, 12 Apr 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929030; cv=none; b=IPICDX2dbwAg+xlfAowDy/6tlP6X5ijy6lUfbWerkE54y+ZHVppMabn5oecEPdpyPct+T0QrUpuIZRi8n8tBMGFqB76Q3iUNBORXuA12x0jCimOOsmUVtQoEQ+sWxFmi2uxj5faOaBhMi9rg7j1nxvjHXrZJFF6lE3O7BfCBKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929030; c=relaxed/simple;
	bh=VWKB4YBkBGiUFfx/DCMZTK1YmSwqd9/AxvqBDvCXap8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDTtHgjKOhbDUOjXb4dM+4EXY25qWpKEKgom0hvzBbXqiSUJ5/ubvrp3YOUB7ggHlunmeYl1uqwFJmbJXiyuikjaDg41gQ32425lbE/NHuT2P1bV6Ed2Ch6j+UjC0Zz/7Z5CBDUG1yqAOSevVTp8nkeCXIerUpAi/cqfyN3DiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxCRcSmE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712929028; x=1744465028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWKB4YBkBGiUFfx/DCMZTK1YmSwqd9/AxvqBDvCXap8=;
  b=OxCRcSmEgY1e0yJV1nt8hXTnKNMhJU6MBzPCIsLTvwVZHpGji0eRxhjw
   1tP4p6dtf0DqLHlZVfQkSahlxjOOAYKCbMoJ2K9RoLW/Dz3ToNX04+EAz
   8zZCzG/b1je3Ht1tSU4PZY+f4jdo2axVPkskkLr6QblF5/yDeYtDfXsxp
   bICdgCalSJ3t4lb7t7Cl4QEN+Ropvx9/KFhJ3gTjPsQOUdylapj491NbL
   J0QN4Ly8F/RDGmiS9kv/B2Q4dLs4SYPYafTQJoc3JYgMhizMDdVGK5Tkx
   GJSpB9XpesfquRkyPJsfmTEfz9xhCS0uNViKvrMLOZW8fpkH++12E3KFr
   Q==;
X-CSE-ConnectionGUID: synnqT46T9m/8N0CNGnG+g==
X-CSE-MsgGUID: UlRCxipcRzKKsNjSTX2Miw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25897900"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25897900"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:37:08 -0700
X-CSE-ConnectionGUID: B2Dqbe6xRFywg7xQBz1M/g==
X-CSE-MsgGUID: aZvyjeKHQ/mN71oHXEf4VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21211657"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:37:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/2] PCI: Create helper to print TLP Header and Prefix Log
Date: Fri, 12 Apr 2024 16:36:35 +0300
Message-Id: <20240412133635.3831-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412133635.3831-1-ilpo.jarvinen@linux.intel.com>
References: <20240412133635.3831-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add pcie_print_tlp_log() helper to print TLP Header and Prefix Log.
Print End-End Prefixes only if they are non-zero.

Consolidate the few places which currently print TLP using custom
formatting.

The first attempt used pr_cont() instead of building a string first but
it turns out pr_cont() is not compatible with pci_err() but prints on a
separate line. When I asked about this, Andy Shevchenko suggested
pr_cont() should not be used in the first place (to eventually get rid
of it) so pr_cont() is now replaced with building the string first.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c      | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c | 10 ++--------
 drivers/pci/pcie/dpc.c |  5 +----
 include/linux/aer.h    |  2 ++
 4 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af230e6e5557..54d4872d14b8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/dmi.h>
@@ -1116,6 +1117,37 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 }
 EXPORT_SYMBOL_GPL(pcie_read_tlp_log);
 
+/**
+ * pcie_print_tlp_log - Print TLP Header / Prefix Log contents
+ * @dev:	PCIe device
+ * @tlp_log:	TLP Log structure
+ * @pfx:	Internal string prefix (for indentation)
+ *
+ * Prints TLP Header and Prefix Log information held by @tlp_log.
+ */
+void pcie_print_tlp_log(const struct pci_dev *dev,
+			const struct pcie_tlp_log *tlp_log, const char *pfx)
+{
+	char buf[(10 + 1) * (4 + ARRAY_SIZE(tlp_log->prefix)) + 14 + 1];
+	unsigned int i;
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "%#010x %#010x %#010x %#010x",
+			tlp_log->dw[0], tlp_log->dw[1], tlp_log->dw[2],
+			tlp_log->dw[3]);
+
+	if (tlp_log->prefix[0])
+		len += scnprintf(buf + len, sizeof(buf) - len, " E-E Prefixes:");
+	for (i = 0; i < ARRAY_SIZE(tlp_log->prefix); i++) {
+		if (!tlp_log->prefix[i])
+			break;
+		len += scnprintf(buf + len, sizeof(buf) - len,
+				 " %#010x", tlp_log->prefix[i]);
+	}
+
+	pci_err(dev, "%sTLP Header: %s\n", pfx, buf);
+}
+
 /**
  * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ecc1dea5a208..efb9e728fe94 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -664,12 +664,6 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
-static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
-{
-	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
-		t->dw[0], t->dw[1], t->dw[2], t->dw[3]);
-}
-
 static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
@@ -724,7 +718,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	__aer_print_error(dev, info);
 
 	if (info->tlp_header_valid)
-		__print_tlp_header(dev, &info->tlp);
+		pcie_print_tlp_log(dev, &info->tlp, "  ");
 
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
@@ -796,7 +790,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 			aer->uncor_severity);
 
 	if (tlp_header_valid)
-		__print_tlp_header(dev, &aer->header_log);
+		pcie_print_tlp_log(dev, &aer->header_log, "  ");
 
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 80b1456f95fe..3f8e3b6c7948 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -229,10 +229,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
 			  cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
 			  dpc_tlp_log_len(pdev), &tlp_log);
-	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
-		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
-	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++)
-		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, tlp_log.prefix[i]);
+	pcie_print_tlp_log(pdev, &tlp_log, "");
 
 	if (pdev->dpc_rp_log_size < 5)
 		goto clear_status;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 2484056feb8d..1e8c61deca65 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -41,6 +41,8 @@ struct aer_capability_regs {
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, struct pcie_tlp_log *log);
 unsigned int aer_tlp_log_len(struct pci_dev *dev);
+void pcie_print_tlp_log(const struct pci_dev *dev,
+			const struct pcie_tlp_log *tlp_log, const char *pfx);
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
-- 
2.39.2


