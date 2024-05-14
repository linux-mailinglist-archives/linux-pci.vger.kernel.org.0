Return-Path: <linux-pci+bounces-7453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04268C532A
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C7285561
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACFD13B7A1;
	Tue, 14 May 2024 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ec8zSI2S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56213B284;
	Tue, 14 May 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686332; cv=none; b=L+HvScVAZcCzGA+rbW6ZI7Sqj9iAf0ZtS0hVdXfzA2jm4MCoW0MOEiVXxvlq6zat6J4hqpoh64YS0xDmpmdeRZ7dnReEaX4P7FeQg/foa9wWSYyqrMDHHYzB5782txuO9gYNbZUZGEY5scoY/jTZxhsxWv27XER4yX1gwo1x/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686332; c=relaxed/simple;
	bh=ffzh8ktARfQxlg+EHK6GIqcNAVgzEbJqc4SjsjEWR6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWngkiBceB84jRxx6SrengVq6H/e0GEWknVciJRgPtuusC17KIZ8HAfXeQnkefUOhxRFGwgPY2FvJAnpyiQ8SOCO7rVJRQTHikMF1VKVPAU/Wd0onNwUuKyK6gDi5CC0SB8XlL6fc7RzXHVxom/UBODSJp30JJL/gQplV1nTqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ec8zSI2S; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715686331; x=1747222331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ffzh8ktARfQxlg+EHK6GIqcNAVgzEbJqc4SjsjEWR6I=;
  b=ec8zSI2SJBiliQcAbcm8XleGsUy/VOhKWMUAvu6k5OKfzMO4pQgkEe1x
   ll1qh4vtVt9lyYZrD54vn9FOCHUDyTWIl++gnNzt8txCjL8TuLyiuORuH
   OE8D8dTYrtdHETxr7TH8VI26j5nS7D0s69Pn3LwnNjDKbv/n5hcRGe0DR
   kU7fmVg+O2GoCUw9cTJiISZo6wMBCt1RS/rvgms0r3YVqIwklgbdJzb9z
   GJ88nSnTCvv5hBuCb9yXDoaTXoN/RHxZLa/Ao5kq8tmrgB773xU37i0yt
   IWelxdVq9/WGY7AA8OSpSVFOqd5/F5bCeDccbWNMaKAuzGFVNrWiMVKWq
   w==;
X-CSE-ConnectionGUID: Lj0x92wLQvWfmetZNzbkTQ==
X-CSE-MsgGUID: CNxiQduRRo6d4vyBNvKUpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11828397"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11828397"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:32:10 -0700
X-CSE-ConnectionGUID: 7CSVwOv/Rte4ss6sxd2F/A==
X-CSE-MsgGUID: kASYYa9MRGafmLSNqZpLug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35546245"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.94])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:32:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 7/7] PCI: Create helper to print TLP Header and Prefix Log
Date: Tue, 14 May 2024 14:31:09 +0300
Message-Id: <20240514113109.6690-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
References: <20240514113109.6690-1-ilpo.jarvinen@linux.intel.com>
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
it turns out pr_cont() is not compatible with pci_err() and prints on a
separate line. When I asked about this, Andy Shevchenko suggested
pr_cont() should not be used in the first place (to eventually get rid
of it) so pr_cont() is now replaced with building the string first.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 10 ++--------
 drivers/pci/pcie/dpc.c |  5 +----
 drivers/pci/pcie/tlp.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7afdd71f9026..45083e62892c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -423,6 +423,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, struct pcie_tlp_log *log);
 unsigned int aer_tlp_log_len(struct pci_dev *dev);
+void pcie_print_tlp_log(const struct pci_dev *dev,
+			const struct pcie_tlp_log *log, const char *pfx);
 #endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIEPORTBUS
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
index 5056cc6961ec..598f74384471 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -220,10 +220,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
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
diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index def9dd7b73e8..097ac8514e96 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/aer.h>
+#include <linux/array_size.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 
@@ -76,3 +77,33 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 
 	return 0;
 }
+
+/**
+ * pcie_print_tlp_log - Print TLP Header / Prefix Log contents
+ * @dev: PCIe device
+ * @log: TLP Log structure
+ * @pfx: String prefix (for print out indentation)
+ *
+ * Prints TLP Header and Prefix Log information held by @log.
+ */
+void pcie_print_tlp_log(const struct pci_dev *dev,
+			const struct pcie_tlp_log *log, const char *pfx)
+{
+	char buf[(10 + 1) * (4 + ARRAY_SIZE(log->prefix)) + 14 + 1];
+	unsigned int i;
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "%#010x %#010x %#010x %#010x",
+			log->dw[0], log->dw[1], log->dw[2], log->dw[3]);
+
+	if (log->prefix[0])
+		len += scnprintf(buf + len, sizeof(buf) - len, " E-E Prefixes:");
+	for (i = 0; i < ARRAY_SIZE(log->prefix); i++) {
+		if (!log->prefix[i])
+			break;
+		len += scnprintf(buf + len, sizeof(buf) - len,
+				 " %#010x", log->prefix[i]);
+	}
+
+	pci_err(dev, "%sTLP Header: %s\n", pfx, buf);
+}
-- 
2.39.2


