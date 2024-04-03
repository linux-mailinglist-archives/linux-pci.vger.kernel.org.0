Return-Path: <linux-pci+bounces-5614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC8896B6F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 12:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F341C2690F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D313AA2E;
	Wed,  3 Apr 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbPkWaPh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B505136E00;
	Wed,  3 Apr 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138564; cv=none; b=uFv1/bnrSWVZyetuHMSBWD6WwAnjvAy8aYEn0Dm5kva7moJKnm8hAup6qnD+V472bWvrtNfVMDxU0FdupT7FKwoXgbaONMT1l1ku/ysB9PqCO8epxQ73q3qgnl+vMe65gxUhd5PON4iw9bdmjAxTrDP7GIO8q1nk/J3JpAX7GvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138564; c=relaxed/simple;
	bh=VWKB4YBkBGiUFfx/DCMZTK1YmSwqd9/AxvqBDvCXap8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q83+047DEqsGtMKTxMp7OZrQ4ssSvEGe4/cEou3qwESOoQmMASkAFHFIjI3icmjDLdKAF8lSGrCOQznq8xfOOeqjn3tTUuyL3MwORPM63nj9xnvW7SloVyBoNcrihAUKjuj8yM1jH8U86K1hhCiPiABWuni7+yXFY53FfUeRjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbPkWaPh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138561; x=1743674561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWKB4YBkBGiUFfx/DCMZTK1YmSwqd9/AxvqBDvCXap8=;
  b=kbPkWaPh3E7o/EbsVfheDw/z8Kj4HnbznN3bYIAToa9pQfaElKTU6/7g
   DLGMosojHkWU4UTMTxSbO5qLIO4Xg5tPbYjiPo3nCpusUxJCYVu+6osbx
   vjV/ByFEszGSdhN3qPfvQplypgQLPmRYO8AsLsig93kIERyv+qapbD/Eb
   rw158Do9wxXxt9U6G3DfqwW7QilEQrWnInPAQBFYiiZrULsW6vYYWv53Q
   FEaoGhjqGMXc6J7J9PKtJQ8gzY+qPdU4Mvw1tWXeDQKmflQWYAvJFbZXV
   K2QXm4NYmpRgimwjTb9Kz5anvmb/74ATdl9bCqto1prnCoEUuiaBeyQcW
   g==;
X-CSE-ConnectionGUID: wmajNrErRFevkOvITGoBtQ==
X-CSE-MsgGUID: 6YdJA9ZHTzy8wb8zu5SN+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24815785"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24815785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:02:40 -0700
X-CSE-ConnectionGUID: SzmvDS0WSoCvkLwEFGrjQw==
X-CSE-MsgGUID: J622qm1OQHWOdewMfRQApw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23084854"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.24])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:02:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] PCI: Create helper to print TLP Header and Prefix Log
Date: Wed,  3 Apr 2024 13:02:06 +0300
Message-Id: <20240403100206.4403-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403100206.4403-1-ilpo.jarvinen@linux.intel.com>
References: <20240403100206.4403-1-ilpo.jarvinen@linux.intel.com>
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


