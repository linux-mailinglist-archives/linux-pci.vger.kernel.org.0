Return-Path: <linux-pci+bounces-27017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA71AA154C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 19:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401F116A5EC
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 17:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF8253F28;
	Tue, 29 Apr 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTkJol5B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1D2459EA;
	Tue, 29 Apr 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947302; cv=none; b=YpX4eoX4zgYTkGrlj9IRGgoC7d02BWBj4KdpgBbfWfTq1aw2QxTJZOdCvYk3Ynp5sPHawL5ovw4oYbxan5sBAmIDKF+QolxywI8rgDDMFGzlEVaJqIYtr635AImGrPckJOil8aVTLeM31cLhNb/KaAX5dbtHzprLKb7jtkcj6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947302; c=relaxed/simple;
	bh=LHmTP7DiNiCJt6QTpTz14DavcISMhdx93wqkEkSqPf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz4kmhRo03weEUaKJKsYRRpbG20tVsGmEcFciipLicaoACt4ajJ/LvB4q4sFCirdDs6NxOjJLglpW+qsZxWl4WozKGqZ38NU/+AaTdtE+hP2bHBp736COnJ7x8E4z2WIDORNPUm/J8aNdjDAR21KT/V7ZoSv2GXhSoOnnUjUrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTkJol5B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745947301; x=1777483301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHmTP7DiNiCJt6QTpTz14DavcISMhdx93wqkEkSqPf0=;
  b=bTkJol5Bb1z/nSX5bjqYwQSYBe9hEb7T0zviYdocX2pHrhShGqEx44xd
   wwfyB6qQAk4hn5K2sVMOegkvT8iRGOl1SKyLbufL1pAJgw9fprqZLCbch
   V1pTl5gdpJhTjbZ0oap4nbaQIJa8Obk2iWP1AjCUo2UAX7issQhGuNP4w
   zTBepBbEQrJgUV29ycBmmT5TJPn65RfIUKTumv21mO+nZfcFWMoWLa1aK
   yIYBKgI70rr2jCB7Vesp0ZdmPSw2DcJymNSKpNkd3fndoUX/XX91apEe1
   IF6yC6v2HDjVIVgv/E02akPB0KEwvz4X8d8gbUap4Pk4Ta40TTUs4QQqJ
   Q==;
X-CSE-ConnectionGUID: gRcCz7T+SUueAVXwWpSTjQ==
X-CSE-MsgGUID: rA5fx+79SUqnatL+chzh8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="64996968"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="64996968"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:41 -0700
X-CSE-ConnectionGUID: 06FSbi8qTc6/uxnr0ds6vg==
X-CSE-MsgGUID: clIxOUsESMOKDd1ykWNL5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="139073335"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.45])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 10:21:34 -0700
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
Subject: [PATCH 3/4 v2] ACPI: extlog: Trace CPER PCI Express Error Section
Date: Tue, 29 Apr 2025 19:21:08 +0200
Message-ID: <20250429172109.3199192-4-fabio.m.de.francesco@linux.intel.com>
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

I/O Machine Check Arcitecture events may signal failing PCIe components
or links. The AER event contains details on what was happening on the wire
when the error was signaled.

Trace the CPER PCIe Error section (UEFI v2.10, Appendix N.2.7) reported
by the I/O MCA.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c     |  2 +-
 include/linux/aer.h        | 13 +++++++++++--
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index caca6ccd6e99..7d7a813169f1 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -131,6 +131,32 @@ static int print_extlog_rcd(const char *pfx,
 	return 1;
 }
 
+static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
+			      int severity)
+{
+	struct aer_capability_regs *aer;
+	struct pci_dev *pdev;
+	unsigned int devfn;
+	unsigned int bus;
+	int aer_severity;
+	int domain;
+
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		aer_severity = cper_severity_to_aer(severity);
+		aer = (struct aer_capability_regs *)pcie_err->aer_info;
+		domain = pcie_err->device_id.segment;
+		bus = pcie_err->device_id.bus;
+		devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
+		if (!pdev)
+			return;
+		pci_print_aer(KERN_DEBUG, pdev, aer_severity, aer);
+		pci_dev_put(pdev);
+	}
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -182,6 +208,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			if (gdata->error_data_length >= sizeof(*mem))
 				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
 						       (u8)gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+			extlog_print_pcie(pcie_err, gdata->error_severity);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d0ebf7c15afa..627fcf434698 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -801,7 +801,7 @@ void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
-EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
+EXPORT_SYMBOL_GPL(pci_print_aer);
 
 /**
  * add_error_device - list device to be handled
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 45d0fb2e2e75..737db92e6570 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -56,17 +56,26 @@ struct aer_capability_regs {
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline void pci_print_aer(char *level, struct pci_dev *dev,
+				 int aer_severity,
+				 struct aer_capability_regs *aer)
+{ }
 #endif
 
-void pci_print_aer(char *level, struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer);
+#if defined(CONFIG_ACPI_APEI_PCIEAER)
 int cper_severity_to_aer(int cper_severity);
+#else
+static inline int cper_severity_to_aer(int cper_severity) { return 0; }
+#endif
+
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
 #endif //_AER_H_
-- 
2.48.1


