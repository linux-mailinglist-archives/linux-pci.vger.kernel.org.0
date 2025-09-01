Return-Path: <linux-pci+bounces-35242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9FB3DB5C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F9E16D010
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 07:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895E2DE6F1;
	Mon,  1 Sep 2025 07:45:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B8A2DC353
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712734; cv=none; b=iXatzpugp3L5aW5iRb/3p4mN0NPhyQAzTs9zeJf1ZnR4iymqprr3jCdMX/HQu8W+hcPpzRMfExv3WxzlwKfNDG/cMuBs8tUTavIznTzCiPXMShlIjAxQUHMx2r5r5Nkul50EuCmZro9akouW/c9/bf3gPOq7BLcsT5OCJqzxPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712734; c=relaxed/simple;
	bh=cuqPKFliJxTb3U0VJ7xcTa+OjbCJy7Ambg6IME9eOiY=;
	h=Message-Id:From:Date:Subject:To:Cc; b=s5d+S/1kRTBu+SOfofNbeVVbpe523g5R5/ryuI8MIGD1FvwQyQhtnAh57tetppOJ/ega+Vx3F4V+APF8XqW9MYk9GWkGwmQW2OQNRLAorOExeUGGLMl2d6QX+V7kzRofT9vSMP6uJLq9r7S+eSno+nuEHcHRgyw84gldugRnHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 434312C0131F;
	Mon,  1 Sep 2025 09:45:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2E4BD4F1F6C; Mon,  1 Sep 2025 09:45:22 +0200 (CEST)
Message-Id: <5f707caf1260bd8f15012bb032f7da9a9b898aba.1756712066.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 1 Sep 2025 09:44:52 +0200
Subject: [PATCH] PCI/AER: Print TLP Log for errors introduced since PCIe r1.1
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When reporting an error, the AER driver prints the TLP Header / Prefix Log
only for errors enumerated in the AER_LOG_TLP_MASKS macro.

The macro was never amended since its introduction in 2006 with commit
6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver").
At the time, PCIe r1.1 was the latest spec revision.

Amend the macro with errors defined since then to avoid omitting the TLP
Header / Prefix Log for newer errors.

The order of the errors in AER_LOG_TLP_MASKS follows PCIe r1.1 sec 6.2.7
rather than 7.10.2, because only the former documents for which errors a
TLP Header / Prefix is logged.  Retain this order.  The section number is
still 6.2.7 in today's PCIe r7.0.

For Completion Timeouts, the TLP Header / Prefix is only logged if the
Completion Timeout Prefix / Header Log Capable bit is set in the AER
Capabilities and Control register.  Introduce a tlp_header_logged() helper
to check whether the TLP Header / Prefix Log is populated and use it in
the two places which currently match against AER_LOG_TLP_MASKS directly.

For Uncorrectable Internal Errors, logging of the TLP Header / Prefix is
optional per PCIe r7.0 sec 6.2.7.  If needed, drivers could indicate
through a flag whether devices are capable and tlp_header_logged() could
then check that flag.

pcitools introduced macros for newer errors with commit 144b0911cc0b
("ls-ecaps: extend decode support for more fields for AER CE and UE
status"):
  https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/commit/?id=144b0911cc0b

Unfortunately some of those macros are overly long:
  PCI_ERR_UNC_POISONED_TLP_EGRESS
  PCI_ERR_UNC_DMWR_REQ_EGRESS_BLOCKED
  PCI_ERR_UNC_IDE_CHECK
  PCI_ERR_UNC_MISR_IDE_TLP
  PCI_ERR_UNC_PCRC_CHECK
  PCI_ERR_UNC_TLP_XLAT_EGRESS_BLOCKED

This seems unsuitable for <linux/pci_regs.h>, so shorten to:
  PCI_ERR_UNC_POISON_BLK
  PCI_ERR_UNC_DMWR_BLK
  PCI_ERR_UNC_IDE_CHECK
  PCI_ERR_UNC_MISR_IDE
  PCI_ERR_UNC_PCRC_CHECK
  PCI_ERR_UNC_XLAT_BLK

Note that some of the existing macros in <linux/pci_regs.h> do not match
exactly with pcitools (e.g. PCI_ERR_UNC_SDES versus PCI_ERR_UNC_SURPDN),
so it does not seem mandatory for them to be identical.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c        | 30 +++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h |  8 ++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 15ed541..62c74b5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -96,11 +96,21 @@ struct aer_info {
 };
 
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
+					PCI_ERR_UNC_POISON_BLK |	\
 					PCI_ERR_UNC_ECRC|		\
 					PCI_ERR_UNC_UNSUP|		\
 					PCI_ERR_UNC_COMP_ABORT|		\
 					PCI_ERR_UNC_UNX_COMP|		\
-					PCI_ERR_UNC_MALF_TLP)
+					PCI_ERR_UNC_ACSV |		\
+					PCI_ERR_UNC_MCBTLP |		\
+					PCI_ERR_UNC_ATOMEG |		\
+					PCI_ERR_UNC_DMWR_BLK |		\
+					PCI_ERR_UNC_XLAT_BLK |		\
+					PCI_ERR_UNC_TLPPRE |		\
+					PCI_ERR_UNC_MALF_TLP |		\
+					PCI_ERR_UNC_IDE_CHECK |		\
+					PCI_ERR_UNC_MISR_IDE |		\
+					PCI_ERR_UNC_PCRC_CHECK)
 
 #define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
 					PCI_EXP_RTCTL_SENFEE|	\
@@ -796,6 +806,20 @@ static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
 	}
 }
 
+static bool tlp_header_logged(u32 status, u32 capctl)
+{
+	/* Errors for which a header is always logged (PCIe r7.0 sec 6.2.7) */
+	if (status & AER_LOG_TLP_MASKS)
+		return true;
+
+	/* Completion Timeout header is only logged on capable devices */
+	if (status & PCI_ERR_UNC_COMP_TIME &&
+	    capctl & PCI_ERR_CAP_COMP_TIME_LOG)
+		return true;
+
+	return false;
+}
+
 static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	const char **strings;
@@ -910,7 +934,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		info.level = KERN_ERR;
-		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		tlp_header_valid = tlp_header_logged(status, aer->cap_control);
 	}
 
 	info.status = status;
@@ -1401,7 +1425,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
 		info->first_error = PCI_ERR_CAP_FEP(aercc);
 
-		if (info->status & AER_LOG_TLP_MASKS) {
+		if (tlp_header_logged(info->status, aercc)) {
 			info->tlp_header_valid = 1;
 			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
 					  aer + PCI_ERR_PREFIX_LOG,
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f5b1774..d2e1bbb 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -776,6 +776,13 @@
 #define  PCI_ERR_UNC_MCBTLP	0x00800000	/* MC blocked TLP */
 #define  PCI_ERR_UNC_ATOMEG	0x01000000	/* Atomic egress blocked */
 #define  PCI_ERR_UNC_TLPPRE	0x02000000	/* TLP prefix blocked */
+#define  PCI_ERR_UNC_POISON_BLK	0x04000000	/* Poisoned TLP Egress Blocked */
+#define  PCI_ERR_UNC_DMWR_BLK	0x08000000	/* DMWr Request Egress Blocked */
+#define  PCI_ERR_UNC_IDE_CHECK	0x10000000	/* IDE Check Failed */
+#define  PCI_ERR_UNC_MISR_IDE	0x20000000	/* Misrouted IDE TLP */
+#define  PCI_ERR_UNC_PCRC_CHECK	0x40000000	/* PCRC Check Failed */
+#define  PCI_ERR_UNC_XLAT_BLK	0x80000000	/* TLP Translation Egress Blocked */
+
 #define PCI_ERR_UNCOR_MASK	0x08	/* Uncorrectable Error Mask */
 	/* Same bits as above */
 #define PCI_ERR_UNCOR_SEVER	0x0c	/* Uncorrectable Error Severity */
@@ -798,6 +805,7 @@
 #define  PCI_ERR_CAP_ECRC_CHKC		0x00000080 /* ECRC Check Capable */
 #define  PCI_ERR_CAP_ECRC_CHKE		0x00000100 /* ECRC Check Enable */
 #define  PCI_ERR_CAP_PREFIX_LOG_PRESENT	0x00000800 /* TLP Prefix Log Present */
+#define  PCI_ERR_CAP_COMP_TIME_LOG	0x00001000 /* Completion Timeout Prefix/Header Log Capable */
 #define  PCI_ERR_CAP_TLP_LOG_FLIT	0x00040000 /* TLP was logged in Flit Mode */
 #define  PCI_ERR_CAP_TLP_LOG_SIZE	0x00f80000 /* Logged TLP Size (only in Flit mode) */
 #define PCI_ERR_HEADER_LOG	0x1c	/* Header Log Register (16 bytes) */
-- 
2.50.1


