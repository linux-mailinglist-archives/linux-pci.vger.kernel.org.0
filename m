Return-Path: <linux-pci+bounces-44732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B544BD1DF4B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 11:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9674A308C8E6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD5355024;
	Wed, 14 Jan 2026 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1dcJPuz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836A318EE4;
	Wed, 14 Jan 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385789; cv=none; b=spuGYDyY0Hy1EMOpzNClYYaYYioWDUYKgnANr0YltMr7JHCKayM0JG7DRAsbdfgnRNdSPghTCes7Jhg42vMi2zXwGlNRG6f0dZfGfx29nDp1/bJz7LmW3gTfmnnHv2H9gLSzgg6a8WbtjUKQr8q820C0m844xvgpXBQ0/HLrelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385789; c=relaxed/simple;
	bh=YiVlGQCr+FTIJ4B2/AoJNeziKA/MhUEzfyR0foaLu2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ+EmadTqleQIAXSIHd9LvJfAffuZ5I8TI7tw8PAkQIxGub71kz31s3pjxlPZYZVkKMLl+8OTJHpuZKqZqWOkTqt9TPP6PC0jAGVIPpP1+JMzYzrYWhld942+WDinWw7B99J4Pz0QN+AsGW4YtVGGAv3eq07MPS8ayq6aIfEpvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1dcJPuz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385788; x=1799921788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YiVlGQCr+FTIJ4B2/AoJNeziKA/MhUEzfyR0foaLu2g=;
  b=I1dcJPuz2nYoNPnUjjbunl0lpVOeCWszrEtND11i/0/66Rvj9vi9jg5z
   axN+IOMi9hjIS1eYbYwspIcP1Bz9pt9CsVvcPoAgB7wAgnhED71dIIfef
   RTnafNGOkDKGDPrnpMZFvqb8zDHEdEALcvOf2KumHDJmo+3OXqKNwewsV
   HpO54hoaWHOe+ZwPF04iPFjF0zQHDrQRutRJxqVoIIj2pSCpOoFt081Z5
   eEOC2KISldjxNuugJxmxqLoPgWvbgIqJgcybpxuOcsU3vuwaMrHOlQfEZ
   DvcRoCBVKt3z9xkTtQGVWUQDaXAhsCHoGtksp0MbKReAjR9QCN8vc6cIA
   g==;
X-CSE-ConnectionGUID: 5gERZoZ8TCqpUooTsb59Bw==
X-CSE-MsgGUID: yM7n2W+DQGydcuidfHgZyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69765868"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69765868"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:16:25 -0800
X-CSE-ConnectionGUID: rE2LwQp9T36u45hrhdgfxg==
X-CSE-MsgGUID: dKpe5iEjRW2dDBf+x62EXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208792833"
Received: from unknown (HELO fdefranc-mobl3.igk.intel.com) ([10.237.142.167])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:16:20 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Rafael J Wysocki <rafael@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 5/5 v9] ACPI: extlog: Trace CPER CXL Protocol Error Section
Date: Wed, 14 Jan 2026 11:14:25 +0100
Message-ID: <20260114101543.85926-6-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114101543.85926-1-fabio.m.de.francesco@linux.intel.com>
References: <20260114101543.85926-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Firmware First is enabled, BIOS handles errors first and then it
makes them available to the kernel via the Common Platform Error Record
(CPER) sections (UEFI 2.11 Appendix N.2.13). Linux parses the CPER
sections via one of two similar paths, either ELOG or GHES. The errors
managed by ELOG are signaled to the BIOS by the I/O Machine Check
Architecture (I/O MCA).

Currently, ELOG and GHES show some inconsistencies in how they report to
userspace via trace events.

Therefore, make the two mentioned paths act similarly by tracing the CPER
CXL Protocol Error Section.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/Kconfig       |  2 ++
 drivers/acpi/acpi_extlog.c | 24 ++++++++++++++++++++++++
 drivers/cxl/core/ras.c     |  3 ++-
 include/cxl/event.h        |  2 ++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ca00a5dbcf750..df0ff0764d0d5 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -494,6 +494,8 @@ config ACPI_EXTLOG
 	tristate "Extended Error Log support"
 	depends on X86_MCE && X86_LOCAL_APIC && EDAC
 	select UEFI_CPER
+	select ACPI_APEI
+	select ACPI_APEI_GHES
 	help
 	  Certain usages such as Predictive Failure Analysis (PFA) require
 	  more information about the error than what can be described in
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 88a2237772c26..7ad3b36013cc6 100644
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
@@ -162,6 +163,23 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 #endif
 }
 
+static void
+extlog_cxl_cper_handle_prot_err(struct cxl_cper_sec_prot_err *prot_err,
+				int severity)
+{
+#ifdef ACPI_APEI_PCIEAER
+	struct cxl_cper_prot_err_work_data wd;
+
+	if (cxl_cper_sec_prot_err_valid(prot_err))
+		return;
+
+	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
+		return;
+
+	cxl_cper_handle_prot_err(&wd);
+#endif
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -213,6 +231,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
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
index 2731ba3a07993..a90480d07c878 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -63,7 +63,7 @@ static int match_memdev_by_parent(struct device *dev, const void *uport)
 	return 0;
 }
 
-static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
+void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
 				       data->prot_err.agent_addr.function);
@@ -104,6 +104,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 	else
 		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
 }
+EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
 
 static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 {
diff --git a/include/cxl/event.h b/include/cxl/event.h
index 94081aec597ae..ff97fea718d2c 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -340,4 +340,6 @@ cxl_cper_setup_prot_err_work_data(struct cxl_cper_prot_err_work_data *wd,
 }
 #endif
 
+void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *wd);
+
 #endif /* _LINUX_CXL_EVENT_H */
-- 
2.52.0


