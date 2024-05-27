Return-Path: <linux-pci+bounces-7857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9B8D05AD
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A19B2DF70
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8F17B508;
	Mon, 27 May 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpmKBUOR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCC17BB0A;
	Mon, 27 May 2024 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821063; cv=none; b=qBKJOW4JysZN3YSteQZ7MPztKly3wzL6EVfTR6mUsVV4WFJuTkgB+H1wP6NBNimP/2q7qrBYKHj9K4+oLZEi2YoGPRLGxT2he/PlsBM47/5Inrt0Edo0m/DxL1xALrgnU3x8Pmc+L0zFocNto02yoGrtwa4uW8u8LxtCoW+53+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821063; c=relaxed/simple;
	bh=IXQy/KWuSXcucpOdFBz5dgMWJsMiQUwKZC+1vOSlerM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQol1s9+U1d4tySCb7p1IkxVz0TLwJZAKomqGdD097N/Nscw8Lqa/Lvs8sKXgV1gUek7BCjTgmodueqYCQp5P7x+mf9XnFZIgC+E8P6IEv3wwIkFer5swKrUiKI2BMjlcUOlroM+MNyn/SceUEisOWBVfsh0M7mm6JQkRbTxJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpmKBUOR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716821062; x=1748357062;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=IXQy/KWuSXcucpOdFBz5dgMWJsMiQUwKZC+1vOSlerM=;
  b=IpmKBUOR44jZBSZF+upHdf6C3a5SoFnUx0FHEBMOmVi4MFgh6ryedYe7
   CFMtibam7rKVZoM4y+xVBGQmAix8kuyt4qjPdKvrCC8WybqetxpODDSXG
   tTVz47gMkSQhKbhATVrLNELQ5xGP734OgeBMFC28fexgPOVibfSE7mE++
   /wLnQrCiBqbOgW33G6GLxsf6iYRrzF+CGRDwYFggIrk9kGfv1o1e1WxrD
   Kq0HLWAh1ZDMTofwuO64rtClBdKT2AtK+IpK291T4F7hzlllJGfnV+PT9
   8pO/0fY7rfDWDPqG5RnRNCY8GlP6A64q6LMoJCPDCWheLu/X+hyHNg4GX
   Q==;
X-CSE-ConnectionGUID: UFHMTjbLR1OOH/NWUUFwXw==
X-CSE-MsgGUID: VvXJXk6sSp+Zdy9hf4Dtjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13269766"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="13269766"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:44:22 -0700
X-CSE-ConnectionGUID: GtWvV7ORS/qh9CPqqni7Jg==
X-CSE-MsgGUID: s5kI9NZRS9OyA+a/ogKfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35279810"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.214])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:44:18 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 2/2] ACPI: extlog: Trace CPER PCI Express Error Section
Date: Mon, 27 May 2024 16:43:41 +0200
Message-ID: <20240527144356.246220-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
References: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd(). Instead,
the similar ghes_do_proc() (GHES) prints to kernel log and calls
pci_print_aer() to report via the ftrace infrastructure.

Add support to report the CPER PCIe Error section also via the ftrace
infrastructure by calling pci_print_aer() to make ELOG act consistently
with GHES.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 30 ++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c     |  2 +-
 include/linux/aer.h        | 13 +++++++++++--
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e025ae390737..007ce96f8672 100644
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
+		pci_print_aer(pdev, aer_severity, aer);
+		pci_dev_put(pdev);
+	}
+}
+
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -179,6 +205,10 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
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
index ac6293c24976..794aa15527ba 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -801,7 +801,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
-EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
+EXPORT_SYMBOL_GPL(pci_print_aer);
 
 /**
  * add_error_device - list device to be handled
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4b97f38f3fcf..fbc82206045c 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -42,17 +42,26 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline void pci_print_aer(struct pci_dev *dev, int aer_severity,
+				 struct aer_capability_regs *aer)
+{ }
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer);
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
2.45.1


