Return-Path: <linux-pci+bounces-6338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6738A7C30
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 08:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B08B21264
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 06:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD9257870;
	Wed, 17 Apr 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IM/IPFjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E075F87A;
	Wed, 17 Apr 2024 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334615; cv=none; b=l3zse1GhDj3PJj4b4/RU7xg6XAXNZQWzN3meF2xWWatYDcid5aMNNrqUL3PnwKN/gvt+E5DeJBAs1yAXBIR2J/476/RiRmbuVEcUjsCi+AIHeTv7H7mI8DQyM8GV7CfXsmf2dJh/2jLr7+MvK8ZVGJk110pUF0tbvbBRGc1zzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334615; c=relaxed/simple;
	bh=BqoM4zaVZfGiETADZW0gzYBEuZf8Ez/YCjsv5m5EXAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VcxVU7zu3J+1qMZFbJJqnZpCjTNmeT0cLhibT4Xr+aqD8Lfs04ApIkKUz1uASJL8+xQtbKN0GqIejNfvpcSj3XHBDFElHpwuvFokqunaFvLGCzWRiHCsF74CIUA8WAs/AQY40P8xsQApumO/ijO5+wJKXDQHYp7t4AynuqGC3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IM/IPFjM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713334614; x=1744870614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqoM4zaVZfGiETADZW0gzYBEuZf8Ez/YCjsv5m5EXAc=;
  b=IM/IPFjMTbFAIE0/uAu/SVgE+CbgNb4iLPeEctidvIJuutHUGEKd0tjy
   GLUuokJV4Hy0kQgKytkrjuU8YGWzt8InthuhBIJnfMDJw8+z7oKlgE3TR
   +06KrOaDqOnK8/lAe+11NIswI9uNzYN4/6rj7t58MO2jvvvJQ8ExzoAXr
   ntxAfMhnkhlkGDfyscr9yKofc94ML6tsyA0FdEmWD80Gw5/OwO0gNz9O4
   Q6WyL/ZREIg//OvDzx8qrnkDKQbpA1JuHNkPZ0r42z9XLh+q3FwS1ooFo
   xL9UjOk8w14ugJdLwfyA9qxoeKod34LiHqVUx7JbFAkBNWnBRNe/XO0P5
   w==;
X-CSE-ConnectionGUID: uRdvOT9qQhyDWuNUOCw3Cg==
X-CSE-MsgGUID: yVjbTI6PTCS+2nh4OQ4ozw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="11750796"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="11750796"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:16:53 -0700
X-CSE-ConnectionGUID: EBgVsiYaQGe/LmO1T0R3Dw==
X-CSE-MsgGUID: Th4pgpKbT1ecuQYWXiSYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="23109033"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 23:16:44 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	bhelgaas@google.com,
	helgaas@kernel.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linmiaohe@huawei.com,
	shiju.jose@huawei.com,
	adam.c.preble@intel.com,
	leoyang.li@nxp.com,
	lukas@wunner.de,
	Smita.KoralahalliChannabasappa@amd.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	erwin.tsaur@intel.com,
	sathyanarayanan.kuppuswamy@intel.com,
	dan.j.williams@intel.com,
	feiting.wanyan@intel.com,
	yudong.wang@intel.com,
	chao.p.peng@intel.com,
	qingshun.wang@linux.intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 1/3] PCI/AER: Store UNCOR_STATUS bits that might be ANFE in aer_err_info
Date: Wed, 17 Apr 2024 14:14:05 +0800
Message-Id: <20240417061407.1491361-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417061407.1491361-1-zhenzhong.duan@intel.com>
References: <20240417061407.1491361-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases the detector of a Non-Fatal Error(NFE) is not the most
appropriate agent to determine the type of the error. For example,
when software performs a configuration read from a non-existent
device or Function, completer will send an ERR_NONFATAL Message.
On some platforms, ERR_NONFATAL results in a System Error, which
breaks normal software probing.

Advisory Non-Fatal Error(ANFE) is a special case that can be used
in above scenario. It is predominantly determined by the role of the
detecting agent (Requester, Completer, or Receiver) and the specific
error. In such cases, an agent with AER signals the NFE (if enabled)
by sending an ERR_COR Message as an advisory to software, instead of
sending ERR_NONFATAL.

When processing an ANFE, ideally both correctable error(CE) status and
uncorrectable error(UE) status should be cleared. However, there is no
way to fully identify the UE associated with ANFE. Even worse, a Fatal
Error(FE) or Non-Fatal Error(NFE) may set the same UE status bit as
ANFE. Treating an ANFE as NFE will reproduce above mentioned issue,
i.e., breaking softwore probing; treating NFE as ANFE will make us
ignoring some UEs which need active recover operation. To avoid clearing
UEs that are not ANFE by accident, the most conservative route is taken
here: If any of the FE/NFE Detected bits is set in Device Status, do not
touch UE status, they should be cleared later by the UE handler. Otherwise,
a specific set of UEs that may be raised as ANFE according to the PCIe
specification will be cleared if their corresponding severity is Non-Fatal.

To achieve above purpose, store UNCOR_STATUS bits that might be ANFE
in aer_err_info.anfe_status. So that those bits could be printed and
processed later.

Tested-by: Yudong Wang <yudong.wang@intel.com>
Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..3f9eb807f9fd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -412,6 +412,7 @@ struct aer_err_info {
 
 	unsigned int status;		/* COR/UNCOR Error Status */
 	unsigned int mask;		/* COR/UNCOR Error Mask */
+	unsigned int anfe_status;	/* UNCOR Error Status for ANFE */
 	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac6293c24976..27364ab4b148 100644
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
 
@@ -1196,6 +1202,41 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif
 
+static void anfe_get_uc_status(struct pci_dev *dev, struct aer_err_info *info)
+{
+	u32 uncor_mask, uncor_status;
+	u16 device_status;
+	int aer = dev->aer_cap;
+
+	if (pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &device_status))
+		return;
+	/*
+	 * Take the most conservative route here. If there are
+	 * Non-Fatal/Fatal errors detected, do not assume any
+	 * bit in uncor_status is set by ANFE.
+	 */
+	if (device_status & (PCI_EXP_DEVSTA_NFED | PCI_EXP_DEVSTA_FED))
+		return;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor_status);
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &uncor_mask);
+	/*
+	 * According to PCIe Base Specification Revision 6.1,
+	 * Section 6.2.3.2.4, if an UNCOR error is raised as
+	 * Advisory Non-Fatal error, it will match the following
+	 * conditions:
+	 *	a. The severity of the error is Non-Fatal.
+	 *	b. The error is one of the following:
+	 *		1. Poisoned TLP           (Section 6.2.3.2.4.3)
+	 *		2. Completion Timeout     (Section 6.2.3.2.4.4)
+	 *		3. Completer Abort        (Section 6.2.3.2.4.1)
+	 *		4. Unexpected Completion  (Section 6.2.3.2.4.5)
+	 *		5. Unsupported Request    (Section 6.2.3.2.4.1)
+	 */
+	info->anfe_status = uncor_status & ~uncor_mask & ~info->severity &
+			    AER_ERR_ANFE_UNC_MASK;
+}
+
 /**
  * aer_get_device_error_info - read error status from dev and store it to info
  * @dev: pointer to the device expected to have a error record
@@ -1213,6 +1254,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 
 	/* Must reset in this function */
 	info->status = 0;
+	info->anfe_status = 0;
 	info->tlp_header_valid = 0;
 
 	/* The device might not support AER */
@@ -1226,6 +1268,9 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
+
+		if (info->status & PCI_ERR_COR_ADV_NFAT)
+			anfe_get_uc_status(dev, info);
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.34.1


