Return-Path: <linux-pci+bounces-2030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE682A861
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A255B20FA1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F1CD27D;
	Thu, 11 Jan 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNA5Occb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D52D271
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958374; x=1736494374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=px+YmM7db+0whU6yrIVWVlXts5+CVSHJVQOH1bviGhc=;
  b=KNA5Occb7wRTMhXuyKss4n0SdN5YhA/X5xpF8ElcSesPIyDwz55K42Pc
   vc20cd78v1WeLkauHTSdkxQQsO3ES4igdgNii17bN1e8SOFkgMPeMzLs8
   LDSfBUKyzoKb9wKCd04Hp0usXSpez+KFdv3OLQoIcjEZXGMMvYtjeRP+X
   kYcjSMhKWoYzCAedu+0zu4K4UjCKsmKv+WV7qMW7QztsLTAOekXmIfrEN
   Pj1MNjj/gUrNFg3GmxCw8QgDd9UwHJqv/lL+z8P+H/2umfKVT/Ks8JTx2
   jNmvqk7/6nkAYzqMuGY9LN8LsJVYtSeM8AHEVsheUXnJ9g7fxRPoxu1bp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="463055533"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="463055533"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="30906888"
Received: from shijiel-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.211.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:32:51 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>,
	"Andy Shevchenko" <andriy.shevchenko@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/4] pci/aer: Store more information in aer_err_info
Date: Thu, 11 Jan 2024 15:32:16 +0800
Message-ID: <20240111073227.31488-2-qingshun.wang@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
References: <20240111073227.31488-1-qingshun.wang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Store status and mask of both correctable and uncorrectable errors in
aer_err_info. Severity of uncorrectable errors and the values of Device
Status register is also recorded in order to filter out errors that
cannot cause Advisory Non-Fatal error.

Refactor rest of the code to use cor/uncor_status and cor/uncor_mask
fields instead of status and mask fields.

Reviewed-by: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Reviewed-by: "Luck, Tony" <tony.luck@intel.com>
Reviewed-by: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
---
 drivers/acpi/apei/ghes.c | 10 ++++-
 drivers/cxl/core/pci.c   |  6 ++-
 drivers/pci/pci.h        |  8 +++-
 drivers/pci/pcie/aer.c   | 93 ++++++++++++++++++++++++++--------------
 include/linux/aer.h      |  4 +-
 include/linux/pci.h      | 27 ++++++++++++
 6 files changed, 111 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 63ad0541db38..0e7ae84a5d3f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -576,6 +576,8 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		struct pcie_capability_regs *pcie_caps;
+		u16 device_status = 0;
 		unsigned int devfn;
 		int aer_severity;
 		u8 *aer_info;
@@ -598,11 +600,17 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 			return;
 		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
 
+		if (pcie_err->validation_bits & CPER_PCIE_VALID_CAPABILITY) {
+			pcie_caps = (struct pcie_capability_regs *) &pcie_err->capability;
+			device_status = pcie_caps->device_status;
+		}
+
 		aer_recover_queue(pcie_err->device_id.segment,
 				  pcie_err->device_id.bus,
 				  devfn, aer_severity,
 				  (struct aer_capability_regs *)
-				  aer_info);
+				  aer_info,
+				  device_status);
 	}
 #endif
 }
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 37e1652afbc7..2d099c6463b4 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -902,6 +902,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
 	struct cxl_port *port;
+	u16 device_status;
 	int severity;
 
 	port = cxl_pci_find_port(pdev, &dport);
@@ -916,7 +917,10 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
 		return;
 
-	pci_print_aer(pdev, severity, &aer_regs);
+	if (pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &device_status))
+		return;
+
+	pci_print_aer(pdev, severity, &aer_regs, device_status);
 
 	if (severity == AER_CORRECTABLE)
 		cxl_handle_rdport_cor_ras(cxlds, dport);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..1e28adfafc06 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -405,8 +405,12 @@ struct aer_err_info {
 	unsigned int __pad2:2;
 	unsigned int tlp_header_valid:1;
 
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
+	u32 cor_mask;		/* COR Error Mask */
+	u32 cor_status;		/* COR Error Status */
+	u32 uncor_mask;		/* UNCOR Error Mask */
+	u32 uncor_status;	/* UNCOR Error Status */
+	u32 uncor_severity;	/* UNCOR Error Severity */
+	u16 device_status;
 	struct aer_header_log_regs tlp;	/* TLP Header */
 };
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 42a3bd35a3e1..9311323a2391 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -615,7 +615,7 @@ const struct attribute_group aer_stats_attr_group = {
 static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 				   struct aer_err_info *info)
 {
-	unsigned long status = info->status & ~info->mask;
+	unsigned long status;
 	int i, max = -1;
 	u64 *counter = NULL;
 	struct aer_stats *aer_stats = pdev->aer_stats;
@@ -625,16 +625,19 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 
 	switch (info->severity) {
 	case AER_CORRECTABLE:
+		status = info->cor_status & ~info->cor_mask;
 		aer_stats->dev_total_cor_errs++;
 		counter = &aer_stats->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
 		break;
 	case AER_NONFATAL:
+		status = info->uncor_status & ~info->uncor_mask;
 		aer_stats->dev_total_nonfatal_errs++;
 		counter = &aer_stats->dev_nonfatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
 	case AER_FATAL:
+		status = info->uncor_status & ~info->uncor_mask;
 		aer_stats->dev_total_fatal_errs++;
 		counter = &aer_stats->dev_fatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
@@ -674,15 +677,17 @@ static void __print_tlp_header(struct pci_dev *dev,
 static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
+	unsigned long status;
 	const char **strings;
-	unsigned long status = info->status & ~info->mask;
 	const char *level, *errmsg;
 	int i;
 
 	if (info->severity == AER_CORRECTABLE) {
+		status = info->cor_status & ~info->cor_mask;
 		strings = aer_correctable_error_string;
 		level = KERN_WARNING;
 	} else {
+		status = info->uncor_status & ~info->uncor_mask;
 		strings = aer_uncorrectable_error_string;
 		level = KERN_ERR;
 	}
@@ -700,18 +705,27 @@ static void __aer_print_error(struct pci_dev *dev,
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	u32 status, mask;
 	int layer, agent;
 	int id = pci_dev_id(dev);
 	const char *level;
 
-	if (!info->status) {
+	if (info->severity == AER_CORRECTABLE) {
+		status = info->cor_status;
+		mask = info->cor_mask;
+	} else {
+		status = info->uncor_status;
+		mask = info->uncor_mask;
+	}
+
+	if (!status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
-	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
-	agent = AER_GET_AGENT(info->severity, info->status);
+	layer = AER_GET_LAYER_ERROR(info->severity, status);
+	agent = AER_GET_AGENT(info->severity, status);
 
 	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
 
@@ -720,7 +734,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		   dev->vendor, dev->device, info->status, info->mask);
+		   dev->vendor, dev->device, status, mask);
 
 	__aer_print_error(dev, info);
 
@@ -731,7 +745,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	if (info->id && info->error_dev_num > 1 && info->id == id)
 		pci_err(dev, "  Error of this Agent is reported first\n");
 
-	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
+	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
@@ -763,7 +777,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer)
+		   struct aer_capability_regs *aer, u16 device_status)
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
@@ -783,8 +797,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 
 	memset(&info, 0, sizeof(info));
 	info.severity = aer_severity;
-	info.status = status;
-	info.mask = mask;
+	info.cor_status = aer->cor_status;
+	info.cor_mask = aer->cor_mask;
+	info.uncor_status = aer->uncor_status;
+	info.uncor_severity = aer->uncor_severity;
+	info.uncor_mask = aer->uncor_mask;
+	info.device_status = device_status;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
 	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
@@ -991,9 +1009,9 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 static bool is_internal_error(struct aer_err_info *info)
 {
 	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
+		return info->cor_status & PCI_ERR_COR_INTERNAL;
 
-	return info->status & PCI_ERR_UNC_INTN;
+	return info->uncor_status & PCI_ERR_UNC_INTN;
 }
 
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
@@ -1092,7 +1110,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		 */
 		if (aer)
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
-					info->status);
+					info->cor_status);
 		if (pcie_aer_is_native(dev)) {
 			struct pci_driver *pdrv = dev->driver;
 
@@ -1123,6 +1141,7 @@ struct aer_recover_entry {
 	u8	devfn;
 	u16	domain;
 	int	severity;
+	u16	device_status;
 	struct aer_capability_regs *regs;
 };
 
@@ -1143,7 +1162,7 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		pci_print_aer(pdev, entry.severity, entry.regs, entry.device_status);
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
 		 * ghes_estatus_pool to protect it from overwriting when multiple sections
@@ -1172,7 +1191,7 @@ static DEFINE_SPINLOCK(aer_recover_ring_lock);
 static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
 
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-		       int severity, struct aer_capability_regs *aer_regs)
+		       int severity, struct aer_capability_regs *aer_regs, u16 device_status)
 {
 	struct aer_recover_entry entry = {
 		.bus		= bus,
@@ -1180,6 +1199,7 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		.domain		= domain,
 		.severity	= severity,
 		.regs		= aer_regs,
+		.device_status	= device_status,
 	};
 
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
@@ -1208,38 +1228,49 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	int temp;
 
 	/* Must reset in this function */
-	info->status = 0;
+	info->cor_status = 0;
+	info->uncor_status = 0;
+	info->uncor_severity = 0;
 	info->tlp_header_valid = 0;
 
 	/* The device might not support AER */
 	if (!aer)
 		return 0;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == AER_CORRECTABLE ||
+	    info->severity == AER_NONFATAL ||
+	    type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_RC_EC ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM) {
+		/* Link is healthy for IO reads */
 		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
-			&info->status);
+			&info->cor_status);
 		pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK,
-			&info->mask);
-		if (!(info->status & ~info->mask))
-			return 0;
-	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
-		   type == PCI_EXP_TYPE_RC_EC ||
-		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-		   info->severity == AER_NONFATAL) {
-
-		/* Link is still healthy for IO reads */
+			&info->cor_mask);
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
-			&info->status);
+			&info->uncor_status);
+		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER,
+			&info->uncor_severity);
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
-			&info->mask);
-		if (!(info->status & ~info->mask))
+			&info->uncor_mask);
+		pcie_capability_read_word(dev, PCI_EXP_DEVSTA,
+			&info->device_status);
+	} else {
+		return 1;
+	}
+
+	if (info->severity == AER_CORRECTABLE) {
+		if (!(info->cor_status & ~info->cor_mask))
+			return 0;
+	} else {
+		if (!(info->uncor_status & ~info->uncor_mask))
 			return 0;
 
 		/* Get First Error Pointer */
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &temp);
 		info->first_error = PCI_ERR_CAP_FEP(temp);
 
-		if (info->status & AER_LOG_TLP_MASKS) {
+		if (info->uncor_status & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
 			pci_read_config_dword(dev,
 				aer + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index f6ea2f57d808..8332731b7212 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -52,9 +52,9 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer);
+		    struct aer_capability_regs *aer, u16 device_status);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-		       int severity, struct aer_capability_regs *aer_regs);
+		       int severity, struct aer_capability_regs *aer_regs, u16 device_status);
 #endif //_AER_H_
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dea043bc1e38..0a4f679bca90 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -318,6 +318,33 @@ struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
 
+struct pcie_capability_regs {
+	u8 pcie_cap_id;
+	u8 next_cap_ptr;
+	u16 pcie_caps;
+	u32 device_caps;
+	u16 device_control;
+	u16 device_status;
+	u32 link_caps;
+	u16 link_control;
+	u16 link_status;
+	u32 slot_caps;
+	u16 slot_control;
+	u16 slot_status;
+	u16 root_control;
+	u16 root_caps;
+	u32 root_status;
+	u32 device_caps_2;
+	u16 device_control_2;
+	u16 device_status_2;
+	u32 link_caps_2;
+	u16 link_control_2;
+	u16 link_status_2;
+	u32 slot_caps_2;
+	u16 slot_control_2;
+	u16 slot_status_2;
+};
+
 /* The pci_dev structure describes PCI devices */
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
-- 
2.42.0


