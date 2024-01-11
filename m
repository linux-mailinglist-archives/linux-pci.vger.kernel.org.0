Return-Path: <linux-pci+bounces-2031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E282A862
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6A01F236BC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051D1D27D;
	Thu, 11 Jan 2024 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4xbJEsv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD99D271
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704958385; x=1736494385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6a7LKb5QccWMOWs5LoVpMfaIp9ZTysxI+Wa69SW7kE=;
  b=A4xbJEsvLoK6+Qs2W1PJ+EGiSBbKuIwkJov3y7IUhaRplTvwmgsZMNTP
   iFNPaBNDzS8v9Sfw83r3vUOyRIj+Pez5dX6XJXZbs3vgc3q+mu+5Crrdo
   SRwXahF/D+VBHLAw6+fk4R7nimUB8/OPbFydsCJJOxQuf6hrWPsdFo170
   uDIR7YCx/8hw15okxABQoj1YL77E44spG4a+ifslV31iCzGdnaNJ8wga1
   nnEg3yvvlalqPwQIf7fA427cbgW5w06vl1HztO66z3vDfi6b09bm4qAHQ
   oTLVMveBW4KXfFcMh/lhayiEjW3Mtc6hZR80AlxdmPnEmgf9BYr/iFBoQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="6126005"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="6126005"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905855976"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905855976"
Received: from shijiel-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.211.188])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:33:02 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	chao.p.peng@intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>
Subject: [PATCH 2/4] pci/aer: Handle Advisory Non-Fatal properly
Date: Thu, 11 Jan 2024 15:32:17 +0800
Message-ID: <20240111073227.31488-3-qingshun.wang@linux.intel.com>
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

If we are processing an Advisory Non-Fatal Error, first check the Device
Status. If any of Fatal/Non-Fatal Error Detected bits is set, leave it
to uncorrectable error handler to clear the UE status bit, which should
be executed right after the CE handler in this case.

Otherwise, filter out uncorrectable errors that is not possible to
trigger an Advisory Non-Fatal Error, then clear all the rest status bits.

Reviewed-by: "Tsaur, Erwin" <erwin.tsaur@intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9311323a2391..86e7cfd71f23 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -107,6 +107,12 @@ struct aer_stats {
 					PCI_ERR_ROOT_MULTI_COR_RCV |	\
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
+#define AER_ERR_ANFE_UNC_MASK		(PCI_ERR_UNC_POISON_TLP |	\
+					PCI_ERR_UNC_COMP_TIME |		\
+					PCI_ERR_UNC_COMP_ABORT |	\
+					PCI_ERR_UNC_UNX_COMP |		\
+					PCI_ERR_UNC_UNSUP)
+
 static int pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
@@ -612,6 +618,29 @@ const struct attribute_group aer_stats_attr_group = {
 	.is_visible = aer_stats_attrs_are_visible,
 };
 
+static int anfe_get_related_err(struct aer_err_info *info)
+{
+	/*
+	 * Take the most conservative route here. If there are
+	 * Non-Fatal/Fatal errors detected, do not assume any
+	 * bit in uncor_status is set by ANFE.
+	 */
+	if (info->device_status & (PCI_EXP_DEVSTA_NFED | PCI_EXP_DEVSTA_FED))
+		return 0;
+	/*
+	 * An UNCOR error may cause Advisory Non-Fatal error if:
+	 *	a. The severity of the error is Non-Fatal.
+	 *	b. The error is one of the following:
+	 *		1. Poisoned TLP
+	 *		2. Completion Timeout
+	 *		3. Completer Abort
+	 *		4. Unexpected Completion
+	 *		5. Unsupported Request
+	 */
+	return info->uncor_status & ~info->uncor_mask
+		& AER_ERR_ANFE_UNC_MASK & ~info->severity;
+}
+
 static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 				   struct aer_err_info *info)
 {
@@ -678,6 +707,7 @@ static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
 	unsigned long status;
+	unsigned long anfe_status;
 	const char **strings;
 	const char *level, *errmsg;
 	int i;
@@ -700,6 +730,21 @@ static void __aer_print_error(struct pci_dev *dev,
 		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
+
+	if (info->severity == AER_CORRECTABLE && (status & PCI_ERR_COR_ADV_NFAT)) {
+		anfe_status = anfe_get_related_err(info);
+		if (anfe_status) {
+			pci_printk(level, dev, "Uncorrectable errors that may cause Advisory Non-Fatal:");
+			for_each_set_bit(i, &anfe_status, 32) {
+				errmsg = aer_uncorrectable_error_string[i];
+				if (!errmsg)
+					errmsg = "Unknown Error Bit";
+
+				pci_printk(level, dev, "   [%2d] %-22s\n", i, errmsg);
+			}
+		}
+	}
+
 	pci_dev_aer_stats_incr(dev, info);
 }
 
@@ -1092,6 +1137,14 @@ static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
 
+static void handle_advisory_nonfatal(struct pci_dev *dev, struct aer_err_info *info)
+{
+	int aer = dev->aer_cap;
+
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
+			       anfe_get_related_err(info));
+}
+
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
@@ -1108,9 +1161,12 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		if (aer)
+		if (aer) {
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 					info->cor_status);
+			if (info->cor_status & PCI_ERR_COR_ADV_NFAT)
+				handle_advisory_nonfatal(dev, info);
+		}
 		if (pcie_aer_is_native(dev)) {
 			struct pci_driver *pdrv = dev->driver;
 
-- 
2.42.0


