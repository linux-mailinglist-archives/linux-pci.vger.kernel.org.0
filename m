Return-Path: <linux-pci+bounces-28871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA5DACCABF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F93E175CED
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B035F23C50F;
	Tue,  3 Jun 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGTKjwPO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5E23D2A9;
	Tue,  3 Jun 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966169; cv=none; b=aqFQXCYJkGr0G7onnoKpNLU86o4eAcSsPhoTlwpeYgXNgxIZczl7SpaW0zMDQKedGBEwV/qn/Zs2NJN0Fm1dfdx0xIZSNsLwlxXlbrCn/JzJO1A5NXDviwpQzpjy6bCGdqKPUz8AzLLiW6XvSdddkM6m8WiKOgItiAtHhBXGll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966169; c=relaxed/simple;
	bh=Y1RORX42Sy4+lziOrtB3W+PirCLsRq62pRiu3jXpg7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MISW7clxmoMRr9AVhyKs+18G6W3Psm9CEHXwiGWBGkt50bauiNejTgqW8FPDLBinmk8POTITrgBazI/Prd++mV1xp9HZRJaKNpHo9avNm7VIxtqTzeIm1Wiw6qniwBEri5+PaLx8SWX72aXA8Ia+n1Fpc4Mv0IxYfbuWyj9YK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGTKjwPO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748966168; x=1780502168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y1RORX42Sy4+lziOrtB3W+PirCLsRq62pRiu3jXpg7s=;
  b=mGTKjwPOaaD/6uaRyY99T14gtSzR5W1DFPDrY1v5VekN7R2QOgYI7LdI
   D7nAyp016mLNXlWmZOsVIy+KgkAn62ajRrebPO+noF87QAX1ZR5V9WsGV
   ez8B1eh1KM5u6titjOLex8QelzJiBUjWF2IzJH9BX/nPPPJ5rt/okrNTr
   3HT2joS9RvzTjPJreOmtIOp+A6qgaJaGOYlPbZb/BbJgzSiWjE76Dj3gw
   xaIqz6EjdkFR8J5bd8XCKTxdzIWK2zJaxYSfY+LscUuXVUtbxfYW5ccQN
   Hl7tj7C47q9Mb3THYry1Xr6feL5LRnxWNhfJOp9VF6CzjgBW0cZUeODGV
   g==;
X-CSE-ConnectionGUID: QZp7JFtvSUW9/Be40F+LJg==
X-CSE-MsgGUID: 4ux/+0ZlQ/2TvO3ZP+kYSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62067004"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="62067004"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 08:56:08 -0700
X-CSE-ConnectionGUID: cNo/tu2QTBebr/73DeO+Dw==
X-CSE-MsgGUID: bBoVVZ7/TPialP0v7Jm/Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="175766116"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 08:56:01 -0700
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
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 3/4 v3] ACPI: extlog: Trace CPER PCI Express Error Section
Date: Tue,  3 Jun 2025 17:54:38 +0200
Message-ID: <20250603155536.577493-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
References: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I/O Machine Check Architecture events may signal failing PCIe components
or links. The AER event contains details on what was happening on the wire
when the error was signaled.

Trace the CPER PCIe Error section (UEFI v2.10, Appendix N.2.7) reported
by the I/O MCA.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/Kconfig       |  1 +
 drivers/acpi/acpi_extlog.c | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c     |  2 +-
 include/linux/aer.h        |  8 ++++++--
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7bc40c2735ac0..2bbd9e4868ad7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -493,6 +493,7 @@ config ACPI_EXTLOG
 	tristate "Extended Error Log support"
 	depends on X86_MCE && X86_LOCAL_APIC && EDAC
 	select UEFI_CPER
+	select ACPI_APEI_PCIEAER
 	help
 	  Certain usages such as Predictive Failure Analysis (PFA) require
 	  more information about the error than what can be described in
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 47d11cb5c9120..b2928ff297eda 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -132,6 +132,34 @@ static int print_extlog_rcd(const char *pfx,
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
+	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID ||
+	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
+		return;
+
+	aer_severity = cper_severity_to_aer(severity);
+	aer = (struct aer_capability_regs *)pcie_err->aer_info;
+	domain = pcie_err->device_id.segment;
+	bus = pcie_err->device_id.bus;
+	devfn = PCI_DEVFN(pcie_err->device_id.device,
+			  pcie_err->device_id.function);
+	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
+	if (!pdev)
+		return;
+
+	pci_print_aer(KERN_DEBUG, pdev, aer_severity, aer);
+	pci_dev_put(pdev);
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -183,6 +211,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
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
index d0ebf7c15afa9..627fcf4346983 100644
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
index 45d0fb2e2e759..6ce433cee4625 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -56,16 +56,20 @@ struct aer_capability_regs {
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
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
-- 
2.49.0


