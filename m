Return-Path: <linux-pci+bounces-23918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661BA64946
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484BA3B6371
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF352231CB1;
	Mon, 17 Mar 2025 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N6owchmk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05C231C8D
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206502; cv=none; b=SMzeLJLkTZyxGAQWJmrO1wx7SIZr+Qvg5MZjbi7ddbB9iyagc+5xWjdZRP+PjZK1cB7XACO4ixOz39Be2Swe6YqBkSSxgGiSsU+BoX/m1zPuemhGMUtjmeoLAWGzKj03bqVKaYUbApD4qUjgnReH8LYFH0jQpb9CrBJV4oACSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206502; c=relaxed/simple;
	bh=MOP138j4bFS1WxmcUlVaunu4BZ7lyzdoILRQKZRfSlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOVDmFgululdKWYR0RHXhd7/KDrDV1qfN+D/xq9ts4FKKQeQgBV2IAjHE+62hFqK8D0YDYK6a0AywSjN7dfFt2ohf6otAJEaT8MjmEzWrYOoP6PovXd/ZPwj4cQPiD2wNa2ZhzhP/x58YHkdo+fn1uRo7HwRu0gObeQG5125cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N6owchmk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7Qmsk026960;
	Mon, 17 Mar 2025 10:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=S1wakVtrKF6e4ftm4aWbALS13AgaG
	oNOBJWMaKm5aXg=; b=N6owchmkD2PGnnSAe7dChXooylkI5uC3fQTL3biFEpUcK
	os2HrLPJK1o3ihriKljGRwJ+oGno66t5s/CkdKOUZ3wXIMlUcjSCjAKPUxVYp7gu
	UFcBJ81Qni8o8t1fciFleTltvnW1lsZOukLLS4iigGoSlF3apzg1ezJ3h9It0d2T
	elcobBCBtDl9p5LOanRlnjV1w0M+R0Lf1GjMPstHTCrsxt3I/XyIxlBhgRVUtlk8
	p2Oh9Vb3L7ATglg5PtudUcJVkR0zGjrQlpasPYz+goWnz5V3ZEMIIEo/DGv1IJOI
	HvSnwW1kgBtCviUOkncgIS4T/G9CjNQ3YLNR2N8bw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8ac13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 10:14:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9YaKq018534;
	Mon, 17 Mar 2025 10:14:55 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45dxdhfn75-1;
	Mon, 17 Mar 2025 10:14:55 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jon Pan-Doh <pandoh@google.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: [PATCH] PCI/AER: Consolidate CXL and native AER reporting paths
Date: Mon, 17 Mar 2025 10:14:46 +0000
Message-ID: <8bcb8c9a7b38ce3bdaca5a64fe76f08b0b337511.1742202797.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=929 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503170075
X-Proofpoint-ORIG-GUID: VbTEQGmRrlrhi9b5jhjLjPdEDFOMVbGo
X-Proofpoint-GUID: VbTEQGmRrlrhi9b5jhjLjPdEDFOMVbGo

Make CXL devices use aer_print_error() when reporting AER errors.
Add a helper function to populate aer_err_info struct before logging
an error. Move struct aer_err_info definition to the aer.h header
to make it visible to CXL.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
The patch was tested on the top of Terry Bowman's series[1], with
a setup as outlined in the cover letter, and rebased on the top
of pci-next, with no functional changes.

[1] -
https://lore.kernel.org/linux-pci/20250211192444.2292833-1-terry.bowman@amd.com

 drivers/cxl/core/pci.c |  5 +++-
 drivers/pci/pci.h      | 23 ----------------
 drivers/pci/pcie/aer.c | 60 ++++++++++++++++++------------------------
 include/linux/aer.h    | 25 ++++++++++++++++--
 4 files changed, 52 insertions(+), 61 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 013b869b66cb..217f13c30bde 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -871,6 +871,7 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
+	struct aer_err_info info;
 	struct cxl_dport *dport;
 	int severity;
 
@@ -885,7 +886,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
 		return;
 
-	pci_print_aer(pdev, severity, &aer_regs);
+	memset(&info, 0, sizeof(info));
+	populate_aer_err_info(&info, severity, &aer_regs);
+	aer_print_error(pdev, &info);
 
 	if (severity == AER_CORRECTABLE)
 		cxl_handle_rdport_cor_ras(cxlds, dport);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9e0378fa30ac..b799c2ff7b85 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -561,30 +561,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
 #ifdef CONFIG_PCIEAER
 #include <linux/aer.h>
 
-#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
-
-struct aer_err_info {
-	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
-	int error_dev_num;
-
-	unsigned int id:16;
-
-	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
-	unsigned int __pad1:5;
-	unsigned int multi_error_valid:1;
-
-	unsigned int first_error:5;
-	unsigned int __pad2:2;
-	unsigned int tlp_header_valid:1;
-
-	unsigned int status;		/* COR/UNCOR Error Status */
-	unsigned int mask;		/* COR/UNCOR Error Mask */
-	struct pcie_tlp_log tlp;	/* TLP Header */
-};
-
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
-
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
 		      struct pcie_tlp_log *log);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..411450ff981e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -760,47 +760,33 @@ int cper_severity_to_aer(int cper_severity)
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer)
+void populate_aer_err_info(struct aer_err_info *info, int aer_severity,
+			   struct aer_capability_regs *regs)
 {
-	int layer, agent, tlp_header_valid = 0;
-	u32 status, mask;
-	struct aer_err_info info;
+	int tlp_header_valid;
+
+	info->severity = aer_severity;
+	info->first_error = PCI_ERR_CAP_FEP(regs->cap_control);
 
 	if (aer_severity == AER_CORRECTABLE) {
-		status = aer->cor_status;
-		mask = aer->cor_mask;
+		info->id = regs->cor_err_source;
+		info->status = regs->cor_status;
+		info->mask = regs->cor_mask;
 	} else {
-		status = aer->uncor_status;
-		mask = aer->uncor_mask;
-		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		info->id = regs->uncor_err_source;
+		info->status = regs->uncor_status;
+		info->mask = regs->uncor_mask;
+		tlp_header_valid = info->status & AER_LOG_TLP_MASKS;
+
+		if (tlp_header_valid) {
+			info->tlp_header_valid = tlp_header_valid;
+			info->tlp = regs->header_log;
+		}
 	}
+}
+EXPORT_SYMBOL_NS_GPL(populate_aer_err_info, "CXL");
 
-	layer = AER_GET_LAYER_ERROR(aer_severity, status);
-	agent = AER_GET_AGENT(aer_severity, status);
-
-	memset(&info, 0, sizeof(info));
-	info.severity = aer_severity;
-	info.status = status;
-	info.mask = mask;
-	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
-
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
-
-	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
-
-	if (tlp_header_valid)
-		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
 
-	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
-			aer_severity, tlp_header_valid, &aer->header_log);
-}
-EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
 
 /**
  * add_error_device - list device to be handled
@@ -1136,6 +1122,7 @@ static void aer_recover_work_func(struct work_struct *work)
 {
 	struct aer_recover_entry entry;
 	struct pci_dev *pdev;
+	struct aer_err_info info;
 
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
@@ -1146,7 +1133,10 @@ static void aer_recover_work_func(struct work_struct *work)
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
 			continue;
 		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+
+		memset(&info, 0, sizeof(info));
+		populate_aer_err_info(&info, entry.severity, entry.regs);
+		aer_print_error(pdev, &info);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 02940be66324..ab408ec18e85 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -53,6 +53,26 @@ struct aer_capability_regs {
 	u16 uncor_err_source;
 };
 
+#define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
+struct aer_err_info {
+	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
+	int error_dev_num;
+
+	unsigned int id:16;
+
+	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
+	unsigned int __pad1:5;
+	unsigned int multi_error_valid:1;
+
+	unsigned int first_error:5;
+	unsigned int __pad2:2;
+	unsigned int tlp_header_valid:1;
+
+	unsigned int status;		/* COR/UNCOR Error Status */
+	unsigned int mask;		/* COR/UNCOR Error Mask */
+	struct pcie_tlp_log tlp;	/* TLP Header */
+};
+
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
@@ -64,8 +84,9 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		    struct aer_capability_regs *aer);
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+void populate_aer_err_info(struct aer_err_info *info, int aer_severity,
+			   struct aer_capability_regs *regs);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);
-- 
2.43.5


