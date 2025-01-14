Return-Path: <linux-pci+bounces-19746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ACDA10D27
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848B43ABA71
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C1D1E764A;
	Tue, 14 Jan 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFUksQhB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197701B2199;
	Tue, 14 Jan 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874594; cv=none; b=sP/86OSrKhPSCdt3d21HHkYbhSZbhDdgvkwApCvlBX1dBEE1OZ8hbp8hnA/fvK94Y1z6Zl1XBTJIDzO5+QEr1w6TELU/MwIonuasciKquVWqMAFzP/jtbLx2y3/QplxCutog8BR8OWGDLDWqDxTET028keflCvjJONpzJDFyPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874594; c=relaxed/simple;
	bh=Si5gr9wFVu6qv0+1aTcBr4Irlnk9SUs4ISTUNHl66N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBve0jRItBB8yQg1AYuXKxF5F5jOaBPJ6h2w7OO/pbgbR6a+vi1JQ46j2ZxVFYx4lUNcs9pbdkbStdWWxh4Gt7dpsiSa6YgMHaBGhn8oPAmfko2AHD+0358Y4rnjWKotYd9/pp2l1X/LQ+wzhPzR9xqpeTNoiIi0gh0R1Yg9oUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFUksQhB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874593; x=1768410593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Si5gr9wFVu6qv0+1aTcBr4Irlnk9SUs4ISTUNHl66N0=;
  b=LFUksQhB9rFYqwN9Oq3g1tV6hCixuY941BkdSlLIQB6go47tfq4j3ZuS
   V7z3acWVdQjhLNoctUGJP+ytnlTEBNa8qb9Ghzrcv/f7V3YCMWVO6+q7T
   bNMmE3iOOOuUydkrPO/RAmhntAcuPlOQLaS3NhickBWMPJde/ZAzklagk
   Zf6UUBOIlpEssr2B9nr06zWRVNYx08GgHfKpw0rbPpfE6cjCsl6DefNYk
   YHxixRANjCyQDMO9GT0Ar4WmeZj3Kj7qrJbb0xkX6ZDGvYlBQOa8UNG3I
   UcVlKQt4k7X1HbTFbLJz3/RJ2MS8+Mdb9uYsIxm5Ibip693K/hVBhyJf+
   w==;
X-CSE-ConnectionGUID: UiVXEZ/DQMaHqMWl6xGB5A==
X-CSE-MsgGUID: QfPEGW9YTkeM8NaQ1uof/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37410116"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="37410116"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:53 -0800
X-CSE-ConnectionGUID: AwHRVaG6TzaMrx83TOw9GQ==
X-CSE-MsgGUID: xGEig7FeTueXuz5Pz115aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104724489"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 7/8] PCI: Add TLP Prefix reading into pcie_read_tlp_log()
Date: Tue, 14 Jan 2025 19:08:39 +0200
Message-Id: <20250114170840.1633-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
References: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcie_read_tlp_log() handles only 4 Header Log DWORDs but TLP Prefix Log
(PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.

Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
TLP Prefix Log. The relevant registers are formatted identically in AER
and DPC Capability, but has these variations:

a) The offsets of TLP Prefix Log registers vary.
b) DPC RP PIO TLP Prefix Log register can be < 4 DWORDs.
c) AER TLP Prefix Log Present (PCIe r6.1 sec 7.8.4.7) can indicate
   Prefix Log is not present.

Therefore callers must pass the offset of the TLP Prefix Log register
and the entire length to pcie_read_tlp_log() to be able to read the
correct number of TLP Prefix DWORDs from the correct offset.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h             |  5 +++-
 drivers/pci/pcie/aer.c        |  5 +++-
 drivers/pci/pcie/dpc.c        | 13 ++++-----
 drivers/pci/pcie/tlp.c        | 52 +++++++++++++++++++++++++++++++----
 include/linux/aer.h           |  1 +
 include/uapi/linux/pci_regs.h | 10 ++++---
 6 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 55fcf3bac4f7..7797b2544d00 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -550,7 +550,9 @@ struct aer_err_info {
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 
-int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_log *log);
+int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
+		      unsigned int tlp_len, struct pcie_tlp_log *log);
+unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc);
 #endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIEPORTBUS
@@ -569,6 +571,7 @@ void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
+unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 80c5ba8d8296..656dbf1ac45b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1248,7 +1248,10 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 
 		if (info->status & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
-			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG, &info->tlp);
+			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
+					  aer + PCI_ERR_PREFIX_LOG,
+					  aer_tlp_log_len(dev, aercc),
+					  &info->tlp);
 		}
 	}
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 0674d8c89bfa..0aa20bc58697 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -190,7 +190,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, dpc_status, first_error;
-	u32 status, mask, sev, syserr, exc, log, prefix;
+	u32 status, mask, sev, syserr, exc, log;
 	struct pcie_tlp_log tlp_log;
 	int i;
 
@@ -217,20 +217,19 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG)
 		goto clear_status;
-	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG, &tlp_log);
+	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
+			  cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
+			  dpc_tlp_log_len(pdev), &tlp_log);
 	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
 		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
+	for (i = 0; i < pdev->dpc_rp_log_size - PCIE_STD_NUM_TLP_HEADERLOG - 1; i++)
+		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, tlp_log.prefix[i]);
 
 	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG + 1)
 		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
 	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
 
-	for (i = 0; i < pdev->dpc_rp_log_size - PCIE_STD_NUM_TLP_HEADERLOG - 1; i++) {
-		pci_read_config_dword(pdev,
-			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
-		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
-	}
  clear_status:
 	pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status);
 }
diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index d7ad99f466b9..2f029deebc33 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -11,26 +11,68 @@
 
 #include "../pci.h"
 
+/**
+ * aer_tlp_log_len - Calculates AER Capability TLP Header/Prefix Log length
+ * @dev: PCIe device
+ * @aercc: AER Capabilities and Control register value
+ *
+ * Return: TLP Header/Prefix Log length
+ */
+unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)
+{
+	return PCIE_STD_NUM_TLP_HEADERLOG +
+	       (aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
+	       dev->eetlp_prefix_max : 0;
+}
+
+#ifdef CONFIG_PCIE_DPC
+/**
+ * dpc_tlp_log_len - Calculates DPC RP PIO TLP Header/Prefix Log length
+ * @dev: PCIe device
+ *
+ * Return: TLP Header/Prefix Log length
+ */
+unsigned int dpc_tlp_log_len(struct pci_dev *dev)
+{
+	/* Remove ImpSpec Log register from the count */
+	if (dev->dpc_rp_log_size >= PCIE_STD_NUM_TLP_HEADERLOG + 1)
+		return dev->dpc_rp_log_size - 1;
+
+	return dev->dpc_rp_log_size;
+}
+#endif
+
 /**
  * pcie_read_tlp_log - read TLP Header Log
  * @dev: PCIe device
  * @where: PCI Config offset of TLP Header Log
+ * @where2: PCI Config offset of TLP Prefix Log
+ * @tlp_len: TLP Log length (Header Log + TLP Prefix Log in DWORDs)
  * @log: TLP Log structure to fill
  *
  * Fill @log from TLP Header Log registers, e.g., AER or DPC.
  *
  * Return: 0 on success and filled TLP Log structure, <0 on error.
  */
-int pcie_read_tlp_log(struct pci_dev *dev, int where,
-		      struct pcie_tlp_log *log)
+int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
+		      unsigned int tlp_len, struct pcie_tlp_log *log)
 {
 	unsigned int i;
-	int ret;
+	int off, ret;
+	u32 *to;
 
 	memset(log, 0, sizeof(*log));
 
-	for (i = 0; i < PCIE_STD_NUM_TLP_HEADERLOG; i++) {
-		ret = pci_read_config_dword(dev, where + i * 4, &log->dw[i]);
+	for (i = 0; i < tlp_len; i++) {
+		if (i < PCIE_STD_NUM_TLP_HEADERLOG) {
+			off = where + i * 4;
+			to = &log->dw[i];
+		} else {
+			off = where2 + (i - PCIE_STD_NUM_TLP_HEADERLOG) * 4;
+			to = &log->prefix[i - PCIE_STD_NUM_TLP_HEADERLOG];
+		}
+
+		ret = pci_read_config_dword(dev, off, to);
 		if (ret)
 			return pcibios_err_to_errno(ret);
 	}
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4ef6515c3205..947b63091902 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -27,6 +27,7 @@ struct pci_dev;
 
 struct pcie_tlp_log {
 	u32 dw[PCIE_STD_NUM_TLP_HEADERLOG];
+	u32 prefix[PCIE_STD_MAX_TLP_PREFIXLOG];
 };
 
 struct aer_capability_regs {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14a6306c4ce1..82866ac0bda7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -790,10 +790,11 @@
 	/* Same bits as above */
 #define PCI_ERR_CAP		0x18	/* Advanced Error Capabilities & Ctrl*/
 #define  PCI_ERR_CAP_FEP(x)	((x) & 0x1f)	/* First Error Pointer */
-#define  PCI_ERR_CAP_ECRC_GENC	0x00000020	/* ECRC Generation Capable */
-#define  PCI_ERR_CAP_ECRC_GENE	0x00000040	/* ECRC Generation Enable */
-#define  PCI_ERR_CAP_ECRC_CHKC	0x00000080	/* ECRC Check Capable */
-#define  PCI_ERR_CAP_ECRC_CHKE	0x00000100	/* ECRC Check Enable */
+#define  PCI_ERR_CAP_ECRC_GENC		0x00000020 /* ECRC Generation Capable */
+#define  PCI_ERR_CAP_ECRC_GENE		0x00000040 /* ECRC Generation Enable */
+#define  PCI_ERR_CAP_ECRC_CHKC		0x00000080 /* ECRC Check Capable */
+#define  PCI_ERR_CAP_ECRC_CHKE		0x00000100 /* ECRC Check Enable */
+#define  PCI_ERR_CAP_PREFIX_LOG_PRESENT	0x00000800 /* TLP Prefix Log Present */
 #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
 #define PCI_ERR_ROOT_COMMAND	0x2c	/* Root Error Command */
 #define  PCI_ERR_ROOT_CMD_COR_EN	0x00000001 /* Correctable Err Reporting Enable */
@@ -809,6 +810,7 @@
 #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
 #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
+#define PCI_ERR_PREFIX_LOG	0x38	/* TLP Prefix LOG Register (up to 16 bytes) */
 
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
-- 
2.39.5


