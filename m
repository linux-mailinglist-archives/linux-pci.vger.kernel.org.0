Return-Path: <linux-pci+bounces-2032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC7682A864
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857881C233C1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD6D27D;
	Thu, 11 Jan 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPUiTJxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BFD271
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958396; x=1736494396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bFDkuEpdSE40qU6/BBnY/phecIamne3XJKJCDfySlsA=;
  b=RPUiTJxATNLQLYZE/nNCjIlE1JnI4AB2smUz6vDIP1/o+hze9uw6UEXC
   mqANTEQ0CrbLh4VGUxpy5M93EUS+xegA40BQSX8mMZSiB664EWCJ7RwkO
   fzO6RT01D/oBWk36E1ev5qaB8nXnfB1gVeDxgpULyRWQkiRRuRDy47iZP
   Ft6imLPuOc29WUTX1DwjOOxka22q2Y2N5Dv2YZrSu4GLpmrxmBA36+In/
   V2upgqs0hPEP9ydJ4OrCFibDBmETY4HKr5D4wCG+PV+wvQguba1HN+v83
   hFudBSD9oBYBJT6iMayEj67k1i4N29kUy77ivegaf49qIqpGxf44e/r5A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6126028"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="6126028"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905856002"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905856002"
Received: from shijiel-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.211.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:33:13 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>
Subject: [PATCH 3/4] pci/aer: Fetch information for FTrace
Date: Thu, 11 Jan 2024 15:32:18 +0800
Message-ID: <20240111073227.31488-4-qingshun.wang@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
References: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fetch and store the data of 3 more registers: `Link Status`, `Device
Control 2` and `Advanced Error Capabilities and Control`. This data will
be traced in FTrace in the following patch.

Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
---
 drivers/acpi/apei/ghes.c |  8 +++++++-
 drivers/cxl/core/pci.c   | 11 ++++++++++-
 drivers/pci/pci.h        |  4 ++++
 drivers/pci/pcie/aer.c   | 26 ++++++++++++++++++++------
 include/linux/aer.h      |  6 ++++--
 5 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0e7ae84a5d3f..a15bb93c6904 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -577,7 +577,9 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
 		struct pcie_capability_regs *pcie_caps;
+		u16 device_control_2 = 0;
 		u16 device_status = 0;
+		u16 link_status = 0;
 		unsigned int devfn;
 		int aer_severity;
 		u8 *aer_info;
@@ -602,7 +604,9 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 		if (pcie_err->validation_bits & CPER_PCIE_VALID_CAPABILITY) {
 			pcie_caps = (struct pcie_capability_regs *) &pcie_err->capability;
+			device_control_2 = pcie_caps->device_control_2;
 			device_status = pcie_caps->device_status;
+			link_status = pcie_caps->link_status;
 		}
 
 		aer_recover_queue(pcie_err->device_id.segment,
@@ -610,7 +614,9 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 				  devfn, aer_severity,
 				  (struct aer_capability_regs *)
 				  aer_info,
-				  device_status);
+				  device_status,
+				  link_status,
+				  device_control_2);
 	}
 #endif
 }
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2d099c6463b4..c1ea77057341 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -902,7 +902,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
 	struct cxl_port *port;
+	u16 device_control_2;
 	u16 device_status;
+	u16 link_status;
 	int severity;
 
 	port = cxl_pci_find_port(pdev, &dport);
@@ -917,10 +919,17 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
 		return;
 
+	if (pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &device_control_2))
+		return;
+
 	if (pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &device_status))
 		return;
 
-	pci_print_aer(pdev, severity, &aer_regs, device_status);
+	if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs, device_status,
+		      link_status, device_control_2);
 
 	if (severity == AER_CORRECTABLE)
 		cxl_handle_rdport_cor_ras(cxlds, dport);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1e28adfafc06..333f2194a360 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -410,7 +410,11 @@ struct aer_err_info {
 	u32 uncor_mask;		/* UNCOR Error Mask */
 	u32 uncor_status;	/* UNCOR Error Status */
 	u32 uncor_severity;	/* UNCOR Error Severity */
+
+	u16 link_status;
+	u32 aer_cap_ctrl;	/* AER Capabilities and Control */
 	u16 device_status;
+	u16 device_control_2;
 	struct aer_header_log_regs tlp;	/* TLP Header */
 };
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 86e7cfd71f23..b5d4ea8e5f8d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -822,7 +822,8 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer, u16 device_status)
+		   struct aer_capability_regs *aer, u16 device_status,
+		   u16 link_status, u16 device_control_2)
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
@@ -847,7 +848,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.uncor_status = aer->uncor_status;
 	info.uncor_severity = aer->uncor_severity;
 	info.uncor_mask = aer->uncor_mask;
+	info.link_status = link_status;
+	info.aer_cap_ctrl = aer->cap_control;
 	info.device_status = device_status;
+	info.device_control_2 = device_control_2;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
@@ -1197,7 +1201,9 @@ struct aer_recover_entry {
 	u8	devfn;
 	u16	domain;
 	int	severity;
+	u16	link_status;
 	u16	device_status;
+	u16	device_control_2;
 	struct aer_capability_regs *regs;
 };
 
@@ -1218,7 +1224,8 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		pci_print_aer(pdev, entry.severity, entry.regs, entry.device_status);
+		pci_print_aer(pdev, entry.severity, entry.regs, entry.device_status,
+			      entry.link_status, entry.device_control_2);
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
 		 * ghes_estatus_pool to protect it from overwriting when multiple sections
@@ -1247,7 +1254,8 @@ static DEFINE_SPINLOCK(aer_recover_ring_lock);
 static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
 
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-		       int severity, struct aer_capability_regs *aer_regs, u16 device_status)
+		       int severity, struct aer_capability_regs *aer_regs, u16 device_status,
+		       u16 link_status, u16 device_control_2)
 {
 	struct aer_recover_entry entry = {
 		.bus		= bus,
@@ -1255,7 +1263,9 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		.domain		= domain,
 		.severity	= severity,
 		.regs		= aer_regs,
+		.link_status	= link_status,
 		.device_status	= device_status,
+		.device_control_2 = device_control_2,
 	};
 
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
@@ -1281,7 +1291,6 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int type = pci_pcie_type(dev);
 	int aer = dev->aer_cap;
-	int temp;
 
 	/* Must reset in this function */
 	info->cor_status = 0;
@@ -1309,8 +1318,14 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			&info->uncor_severity);
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
 			&info->uncor_mask);
+		pci_read_config_dword(dev, aer + PCI_ERR_CAP,
+			&info->aer_cap_ctrl);
+		pcie_capability_read_word(dev, PCI_EXP_LNKSTA,
+			&info->link_status);
 		pcie_capability_read_word(dev, PCI_EXP_DEVSTA,
 			&info->device_status);
+		pcie_capability_read_word(dev, PCI_EXP_DEVCTL2,
+			&info->device_control_2);
 	} else {
 		return 1;
 	}
@@ -1323,8 +1338,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			return 0;
 
 		/* Get First Error Pointer */
-		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &temp);
-		info->first_error = PCI_ERR_CAP_FEP(temp);
+		info->first_error = PCI_ERR_CAP_FEP(info->aer_cap_ctrl);
 
 		if (info->uncor_status & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8332731b7212..333b72c19c60 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -52,9 +52,11 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer, u16 device_status);
+		    struct aer_capability_regs *aer, u16 device_status,
+		    u16 link_status, u16 device_control_2);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-		       int severity, struct aer_capability_regs *aer_regs, u16 device_status);
+		       int severity, struct aer_capability_regs *aer_regs, u16 device_status,
+		       u16 link_status, u16 device_control_2);
 #endif //_AER_H_
 
-- 
2.42.0


