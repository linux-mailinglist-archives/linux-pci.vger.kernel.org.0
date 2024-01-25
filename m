Return-Path: <linux-pci+bounces-2536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9423983B9BC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 07:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E3FB24FEC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B96F10A21;
	Thu, 25 Jan 2024 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FhP5Hbzn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22991134C0;
	Thu, 25 Jan 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164155; cv=none; b=rigZq5P+pU8pg3H22Or1153hpfb2Ytota/po54ImSRW7HW61A67zwbPwS9YYafbUrrN2xNrkAwhBaPZU2+pav6+aZOg3oTTall39BNh9h6FIOBTVMU7CjH6KQ9BjBs5De3tRpDfbEnsHlnHZGwASEhhHlLm4dD0Si8yWAS/jElw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164155; c=relaxed/simple;
	bh=g/eRLBA9JTOcnlfR0mRp9q/UKYK4eIgcF5N2CtD/gIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkaKZ3xj34OxrgMsS5RZC6lXTPpNpNfWCbGS/XrVzwjTHXtUyscg2ogZsJ5V73MahkosWrZGDf4HKNYJ1cu0Edbbc7ep7BxgLljhufI31bIU6pYuyndN4kjrIi7x/ikS1/l6UaTvchu2mCTqGZePoyimkww6V+WQYjt5s7XzBF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FhP5Hbzn; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706164153; x=1737700153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/eRLBA9JTOcnlfR0mRp9q/UKYK4eIgcF5N2CtD/gIg=;
  b=FhP5HbznD8ipexCnTwjACtNqpvyFv68LvpMFLwSxxvLZ2a4mQHr92zav
   /107nDKkete+YGIWuFYlAmt53lzbFkwFzD7qvCs94g9WsppuOfx8i+++c
   xdxbG8KKdhMfR4KAx11hSDDmXR6I4qcPUICoPCEWCDfJum/2jEwXNTxAa
   vBey9RTmIDqZxTYT2yyXSUy2+NwCB7GtzdXEBgzlWXN58BFUN/t4pxaxQ
   EOpYpt7wd7O+4yjcQfIwzq2kpc/ijePNyY2DTSeH97uRwnASgPg3n7VcD
   S+9mt/MVC4CFZ5+FatEGsq+ZtveSzWdRUpsZDgXGF2O4rr9+CnDwT0ogQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="433227498"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433227498"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20957073"
Received: from linchen5-mobl.ccr.corp.intel.com (HELO localhost) ([10.254.209.209])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 22:29:04 -0800
From: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
To: linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org
Cc: chao.p.peng@linux.intel.com,
	erwin.tsaur@intel.com,
	feiting.wanyan@intel.com,
	qingshun.wang@intel.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Adam Preble <adam.c.preble@intel.com>,
	Li Yang <leoyang.li@nxp.com>,
	Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	Robert Richter <rrichter@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	"Wang, Qingshun" <qingshun.wang@linux.intel.com>
Subject: [PATCH v2 2/4] PCI/AER: Handle Advisory Non-Fatal properly
Date: Thu, 25 Jan 2024 14:28:00 +0800
Message-ID: <20240125062802.50819-3-qingshun.wang@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240125062802.50819-1-qingshun.wang@linux.intel.com>
References: <20240125062802.50819-1-qingshun.wang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When processing an Advisory Non-Fatal error, ideally both correctable
error status and uncorrectable error status should be cleared. However,
there is no way to fully identify the UE associated with ANFE. Even
worse, a Fatal/Non-Fatal error may set the same UE status bit as ANFE.
Assuming an ANFE is FE/NFE is kind of bad, but assuming a FE/NFE is an
ANFE is usually unacceptable. To avoid clearing UEs that are not ANFE by
accident, the most conservative route is taken here: If any of the
Fatal/Non-Fatal Error Detected bits is set in Device Status, do not
touch UE status, they should be cleared later by the UE handler.
Otherwise, a specific set of UEs that may be raised as ANFE according to
the PCIe specification will be cleared if their corresponding severity
is non-fatal. Additionally, log UEs that will be cleared.

For instance, previously when kernel receives an ANFE with Poisoned TLP
in OS native AER mode, only status of CE will be reported and cleared:

  AER: Corrected error received: 0000:b7:02.0
  PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr

If the kernel receives a Malformed TLP after that, two UE will be
reported, which is unexpected. Malformed TLP Header was lost since
the previous ANF gated the TLP header logs:

  PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00041000/00180020
     [12] TLP                    (First)
     [18] MalfTLP

Now, in the same scenario, both CE status and related UE status will be
reported and cleared after ANFE:

  AER: Corrected error received: 0000:b7:02.0
  PCIe Bus Error: severity=Corrected, type=Transaction Layer, (Receiver ID)
    device [8086:0db0] error status/mask=00002000/00000000
     [13] NonFatalErr
    Uncorrectable errors that may cause Advisory Non-Fatal:
     [18] TLP

Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 6583dcf50977..713cbf625d3f 100644
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
 
@@ -612,6 +618,32 @@ const struct attribute_group aer_stats_attr_group = {
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
+	 * According to PCIe Base Specification Revision 6.1,
+	 * Section 6.2.3.2.4, if an UNCOR error is rasied as
+	 * Advisory Non-Fatal error, it will match the following
+	 * conditions:
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
@@ -678,6 +710,7 @@ static void __aer_print_error(struct pci_dev *dev,
 			      struct aer_err_info *info)
 {
 	unsigned long status;
+	unsigned long anfe_status;
 	const char **strings;
 	const char *level, *errmsg;
 	int i;
@@ -700,6 +733,21 @@ static void __aer_print_error(struct pci_dev *dev,
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
 
@@ -1097,6 +1145,14 @@ static inline void cxl_rch_handle_error(struct pci_dev *dev,
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
@@ -1113,9 +1169,12 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
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


