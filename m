Return-Path: <linux-pci+bounces-38479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7EBE8F16
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A673B299B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09135393DCD;
	Fri, 17 Oct 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vqu9k8Zj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525C3570C4;
	Fri, 17 Oct 2025 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708146; cv=none; b=FMxLlpO8IVbZ0+czEpDeXS7bEcokfeaQEmxo3Z9a/e9hM7h3g/khmeTp7RfQJFaPSk/Ip8UnU+7FMkvtgKmuEekDhn2aGeRLKavA8t9IVVOnlbiULghyuCa9OyLOlzVmKcoS48yEGvZ9pTsyOcZqY4vdYI7hRhW185rb0oBotcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708146; c=relaxed/simple;
	bh=7OqV225NxO84Qa7aP4Wuqs5k83WRf2r6PR4RfPnLQec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMKe7r5OENLB+F5XYL/ttt57mPbwKPyzmGiRmipOVns7DbAs9kL9tsvEH8m4tZRpLtdAojrnpV1SyDTnh7a5Rtg7Luvg8twXKW7F4HMyqcrgG+lM2ixrQ2L+apYMTnTu2t9M+VPRoDYsvlLc3R5FBh2l0PjqlYdq7wnJLAawifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vqu9k8Zj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760708145; x=1792244145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7OqV225NxO84Qa7aP4Wuqs5k83WRf2r6PR4RfPnLQec=;
  b=Vqu9k8ZjNfX8tfCRQlWJSjdWVufYo6h7y4VRhypUOYqd4ZWhCok9/chZ
   ERH9+oi8NfKw7/t0am1nt8ZQN87AyF2db+u41iEDMsXqZmmUPhPYQfe3i
   0d0a1gIA/xNzDRyT/XSFdoz+8focli6Pl+1nmJE5KRaV3nW6d/b07X9Xd
   m5tY4gnR3fZ4ieYq93TOS+dXhY/HWmwdse4+x4MtBeorJamZQqXc8tQm0
   TayJTxp4eq3tS5Op/09g5lPSevxYM4PeUscS/DHTNYnKvTt2YksU1QgOy
   T+eK6443aeUhWdh9cdteoOKDzTt6v7wpvY2eukOEinqkvmm4TvXLSJlWe
   g==;
X-CSE-ConnectionGUID: DHs8lmXJS0mWHehIpGjwCA==
X-CSE-MsgGUID: pBYT0zdYTS2gKB8+VCQx3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63065104"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63065104"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:35:42 -0700
X-CSE-ConnectionGUID: n9d0JGLIRPKcLQivpZhn5Q==
X-CSE-MsgGUID: 3oDAhQ/SQSSub8SOjYUUpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="181925296"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.215])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:35:28 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
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
	Sunil V L <sunilvl@ventanamicro.com>,
	Xiaofei Tan <tanxiaofei@huawei.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Xin Li <xin@zytor.com>,
	Will Deacon <will@kernel.org>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	Gavin Shan <gshan@redhat.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Li Ming <ming.li@zohomail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Jon Pan-Doh <pandoh@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Shiju Jose <shiju.jose@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 6/6 v5] ACPI: extlog: Trace CPER CXL Protocol Error Section
Date: Fri, 17 Oct 2025 15:30:51 +0200
Message-ID: <20251017133357.1150982-7-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133357.1150982-1-fabio.m.de.francesco@linux.intel.com>
References: <20251017133357.1150982-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Firmware First is enabled, BIOS handles errors first and then it makes
them available to the kernel via the Common Platform Error Record (CPER)
sections (UEFI 2.10 Appendix N). Linux parses the CPER sections via one of
two similar paths, either ELOG or GHES. The errors managed by ELOG are
signaled to the BIOS by the I/O Machine Check Architecture (I/O MCA).

Currently, ELOG and GHES show some inconsistencies in how they report to
userspace via trace events.

Therefore, make the two mentioned paths act similarly by tracing the CPER
CXL Protocol Error Section (UEFI v2.10, Appendix N.2.13).

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 22 ++++++++++++++++++++++
 drivers/cxl/core/ras.c     |  6 ++++++
 include/cxl/event.h        |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index cefe8d2d8affc..91dfb6300ecdf 100644
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
@@ -160,6 +161,21 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	pci_dev_put(pdev);
 }
 
+static void
+extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				int severity)
+{
+	struct cxl_cper_prot_err_work_data wd;
+
+	if (cxl_cper_sec_prot_err_valid(prot_err))
+		return;
+
+	if (cxl_cper_sec_prot_err_copy_to_wd(&wd, prot_err, severity))
+		return;
+
+	cxl_cper_ras_handle_prot_err(&wd);
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -211,6 +227,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			struct cxl_cper_sec_prot_err *prot_err =
+				acpi_hest_get_payload(gdata);
+
+			extlog_cxl_cper_handle_prot_err(prot_err,
+							gdata->error_severity);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 2731ba3a07993..3f527b0c6509c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -105,6 +105,12 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
 }
 
+void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd)
+{
+	cxl_cper_handle_prot_err(wd);
+}
+EXPORT_SYMBOL_GPL(cxl_cper_ras_handle_prot_err);
+
 static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 {
 	struct cxl_cper_prot_err_work_data wd;
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 5f06cea5d6005..b762506d229aa 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -340,4 +340,6 @@ cxl_cper_sec_prot_err_copy_to_wd(struct cxl_cper_prot_err_work_data *wd,
 }
 #endif
 
+void cxl_cper_ras_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
+
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.51.0


