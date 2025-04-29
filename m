Return-Path: <linux-pci+bounces-27018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3C7AA1556
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 19:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4FB16F5B3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404B254AE1;
	Tue, 29 Apr 2025 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6DrCkAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D5254868;
	Tue, 29 Apr 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947308; cv=none; b=CGy0bJn1o+Q4qmeC6ZdACf4Fz1z4yQXTO03JffArE/7nnUiSjcoX6EhQsjRCxvpTzoaToIi/blHSs67xu90I91096/dBnfOi2pCs//ZwriQ7GirdOE5rX+2FErwZCEbEiDTZQkBnq3hNG3X6mmrkNkD45rmCJJ2qqJJp3qEcX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947308; c=relaxed/simple;
	bh=6NBgym4/EikYuDm0nWfg1osxoAlXmaBFRDdG5Co6GDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9oUqUvfYwxhWkARlbp75KMIy+UdA+3US94n3o7HhS0fbLhqG6Vrqb9Sa+5651bKrE6/4zMCwmH0Ff0WcYGZOabE2vYMWVeq823jA3FV7ubwiveF+EVKffzqDZ7vXW4FaAfB5TkfP9QmVScYIF72HtfkjsBblHBFXkECdBX4pOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6DrCkAI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745947307; x=1777483307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6NBgym4/EikYuDm0nWfg1osxoAlXmaBFRDdG5Co6GDM=;
  b=X6DrCkAI6FRs80hJngKR+j/ENZns/hr6/P7KQj0Pf6Onf56gKXC/slqf
   9FpGFONuz2Wg2l4ItVOkYBbW1R+bD3h2Dop4aFhoMCDF8mkX+DQr4aCQd
   TjOk0fCADTRZ9VAKvYO1Ql2mh5esg1mlQcYN/dkhH/EbH/zEdU7V0cJLu
   LabHCDXtKo4lMJzsmAhJW+IykznxKJEFMtNUrFanJKYlCYHp0vanjbbCs
   W1Xtk6JaJOaU5+yDmrEBwmyKW8FZ57iOgbGBBvf2MUIBz59H2I4wdKcPs
   GEHjZRh620Zxo//yPwIUVimRN1v8m1xYRnQEOh/x/dafd7PDJoY7YR8SH
   w==;
X-CSE-ConnectionGUID: w/Nk0KgpQ7+k7mvos6rDUQ==
X-CSE-MsgGUID: SEWzg9z6QW6e0C8qye9jcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="64996984"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="64996984"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:46 -0700
X-CSE-ConnectionGUID: RUWqMx43T460pY1p/OsbGQ==
X-CSE-MsgGUID: XEHwzn+VQVSbGGyfW1jiqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="139073357"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.45])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:41 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 4/4 v2] ACPI: extlog: Trace CPER CXL Protocol Errors
Date: Tue, 29 Apr 2025 19:21:09 +0200
Message-ID: <20250429172109.3199192-5-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429172109.3199192-1-fabio.m.de.francesco@linux.intel.com>
References: <20250429172109.3199192-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Firmware First is enabled, BIOS handles errors first and then it
makes them available to the kernel via the Common Platform Error Record
(CPER) sections (UEFI 2.10 Appendix N). Linux parses the CPER sections
via one of two similar paths, either ELOG or GHES.

Currently, ELOG and GHES show some inconsistencies in how they report to
userspace via trace events.

Therfore make the two mentioned paths act similarly by tracing the CPER
CXL Protocol Error Section (UEFI v2.10, Appendix N.2.13) signaled by the
I/O Machine Check Architecture and reported by BIOS in FW-First.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/ras.c     |  6 ++++
 include/cxl/event.h        |  2 ++
 3 files changed, 68 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 7d7a813169f1..8f2ff3505d47 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -12,6 +12,7 @@
 #include <linux/ratelimit.h>
 #include <linux/edac.h>
 #include <linux/ras.h>
+#include <cxl/event.h>
 #include <acpi/ghes.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
@@ -157,6 +158,60 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	}
 }
 
+static void
+extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				int severity)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cxl_cper_prot_err_work_data wd;
+	u8 *dvsec_start, *cap_start;
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_AGENT_ADDRESS)) {
+		pr_err_ratelimited("CXL CPER invalid agent type\n");
+		return;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_ERROR_LOG)) {
+		pr_err_ratelimited("CXL CPER invalid protocol error log\n");
+		return;
+	}
+
+	if (prot_err->err_len != sizeof(struct cxl_ras_capability_regs)) {
+		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
+				   prot_err->err_len);
+		return;
+	}
+
+	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
+		pr_warn(FW_WARN "CXL CPER no device serial number\n");
+
+	switch (prot_err->agent_type) {
+	case RCD:
+	case DEVICE:
+	case LD:
+	case FMLD:
+	case RP:
+	case DSP:
+	case USP:
+		memcpy(&wd.prot_err, prot_err, sizeof(wd.prot_err));
+
+		dvsec_start = (u8 *)(prot_err + 1);
+		cap_start = dvsec_start + prot_err->dvsec_len;
+
+		memcpy(&wd.ras_cap, cap_start, sizeof(wd.ras_cap));
+		wd.severity = cper_severity_to_aer(severity);
+		break;
+	default:
+		pr_err_ratelimited("CXL CPER invalid agent type: %d\n",
+				   prot_err->agent_type);
+		return;
+	}
+
+	cxl_cper_ras_handle_prot_err(&wd);
+
+#endif
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -208,6 +263,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+
+			extlog_cxl_cper_handle_prot_err(prot_err, gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
@@ -375,3 +434,4 @@ module_exit(extlog_exit);
 MODULE_AUTHOR("Chen, Gong <gong.chen@intel.com>");
 MODULE_DESCRIPTION("Extended MCA Error Log Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 485a831695c7..56db290c88d3 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -98,6 +98,12 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		cxl_cper_trace_uncorr_prot_err(pdev, data->ras_cap);
 }
 
+void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd)
+{
+	cxl_cper_handle_prot_err(wd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cper_ras_handle_prot_err, "CXL");
+
 static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 {
 	struct cxl_cper_prot_err_work_data wd;
diff --git a/include/cxl/event.h b/include/cxl/event.h
index f9ae1796da85..aef906e26033 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -285,4 +285,6 @@ static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data
 }
 #endif
 
+void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
+
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.48.1


