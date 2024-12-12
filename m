Return-Path: <linux-pci+bounces-18291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232B9EE8BE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32628282DBD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7A2144A8;
	Thu, 12 Dec 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mSNRTl2R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67696214A86
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013667; cv=none; b=dmPO+PeGbptZfgUpgF45o60LglwxDzA+0K4qk1Q4QGcQK9ug91U7YaIfHzdzKrMnOr0t+TygxBpVxNHx/KjfW3zlOvp6enWOYme9EUfFX2F+ZgzkWU7/JL1t8NssWPVZjpDi3X+jrgrZuNFrCPDdCDtTqjWpB8+YPRFthLps8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013667; c=relaxed/simple;
	bh=ElqTo+vtN/Kww+FtFQ4e47GSLOACoYdCGl7dofgTBlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/w0pqgnr0R5UTcrRFHDnID86WQgzNJzIkzRtqveOgzLKpTDBvQ5QqoLhvsIpLvzTu3+GeMUh2e0UR3LKD4ZHTCZQCoFm7w6xZjSwOK3xH/tSFA7Yb/nAQBNZPwJezqZzsPxrrB/EPFRMTX39MJo6U2uuFvDSZm2kVOzwQ3kfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mSNRTl2R; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCFwcC012411;
	Thu, 12 Dec 2024 14:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=4ptT3
	fwY413GOO95nFZErEdJU5uEZJN+0+MYPylFbp8=; b=mSNRTl2RgyzXEqvPHpQ94
	pIMqgAhHRPL5xt7Wrc4wYICBpz+U+n5TO7vEuWJTfmiDD+ATwRcsHvixO275uJBt
	vLD3SPjZlPniD+TlYdtcAGY2uc9DzTTudJjJtr+Ik7nxJx/c9LyDRqBdDTqg21dx
	5pb2KQCKmxwkiQccjsV/Eint7Qh5eFaV8wLcy/0Km4KMSZKzfuO4TDCu6/gmTmuh
	efq5ylZg8qWKU//wbG8E8Qr1KFbTg5Hg1aQSBR8Iopm7nfMK0cX7DarIEt+HjPfX
	WQozMncktRKchw5F00v61QvbjC7zIhINFD5qSBCleiFiK91wmBkvNfWRdl4g6o41
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy0bc5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 14:27:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDD4bd038147;
	Thu, 12 Dec 2024 14:27:42 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43cctht4wt-3;
	Thu, 12 Dec 2024 14:27:41 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC 2/4] PCI/AER: Add Correctable Errors rate limiting
Date: Thu, 12 Dec 2024 14:27:30 +0000
Message-ID: <ccf094602db886f1c63b9b7e50a39c830b0f18ce.1734005191.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1734005191.git.karolina.stolarek@oracle.com>
References: <cover.1734005191.git.karolina.stolarek@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120104
X-Proofpoint-GUID: mv4bQIA2Z30hX8kpLB0ui-fRl0XN6_kg
X-Proofpoint-ORIG-GUID: mv4bQIA2Z30hX8kpLB0ui-fRl0XN6_kg

In the case of a compromised Link integrity, we may see excessive
logging of Correctable Errors. This kind of errors is handled by
the hardware, so the messages are purely informational. It should
suffice to report the error once in a while, and inform how many
messages were suppressed over that time.

Add a ratelimit_state to control the number of printed Correctable
Errors per Root Port and check it each time a Correctable Error is
to be reported.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pcie/aer.c | 44 ++++++++++++++++++++++++++++--------------
 include/linux/pci.h    |  1 +
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b13690fd172f..5c34cc2b5bf3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -40,6 +40,8 @@
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
 #define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
 
+#define AER_COR_ERR_INTERVAL		(2 * HZ)
+
 struct aer_err_source {
 	u32 status;			/* PCI_ERR_ROOT_STATUS */
 	u32 id;				/* PCI_ERR_ROOT_ERR_SRC */
@@ -375,6 +377,9 @@ void pci_aer_init(struct pci_dev *dev)
 
 	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
 
+	/* Allow Root Port to report a Correctable Error message every 2 seconds */
+	ratelimit_state_init(&dev->cor_rs, AER_COR_ERR_INTERVAL, 1);
+
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
 	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
@@ -766,11 +771,13 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	u32 status, mask;
 	const char *level;
 	struct aer_err_info info;
+	bool no_ratelimit = true;
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 		level = KERN_WARNING;
+		no_ratelimit = __ratelimit(&dev->cor_rs);
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
@@ -787,17 +794,20 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
-	pci_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	__aer_print_error(dev, &info, level);
-	pci_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
-		   aer_error_layer[layer], aer_agent_string[agent]);
+	if (no_ratelimit) {
+		pci_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
+			   status, mask);
+		__aer_print_error(dev, &info, level);
+		pci_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
+			   aer_error_layer[layer], aer_agent_string[agent]);
 
-	if (aer_severity != AER_CORRECTABLE)
-		pci_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
-			   aer->uncor_severity);
+		if (aer_severity != AER_CORRECTABLE)
+			pci_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
+				   aer->uncor_severity);
 
-	if (tlp_header_valid)
-		__print_tlp_header(dev, &aer->header_log);
+		if (tlp_header_valid)
+			__print_tlp_header(dev, &aer->header_log);
+	}
 
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
@@ -1256,13 +1266,14 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 }
 
 static inline void aer_process_err_devices(struct aer_err_info *e_info,
-					   const char *level)
+					   const char *level,
+					   bool no_ratelimit)
 {
 	int i;
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info->dev[i], e_info) && no_ratelimit)
 			aer_print_error(e_info->dev[i], e_info, level);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
@@ -1282,6 +1293,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info e_info;
 	const char *level;
+	bool no_ratelimit = true;
 
 	pci_rootport_aer_stats_incr(pdev, e_src);
 
@@ -1298,10 +1310,14 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info, level);
+
+		no_ratelimit = __ratelimit(&pdev->cor_rs);
+
+		if (no_ratelimit)
+			aer_print_port_info(pdev, &e_info, level);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info, level);
+			aer_process_err_devices(&e_info, level, no_ratelimit);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -1321,7 +1337,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		aer_print_port_info(pdev, &e_info, level);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info, level);
+			aer_process_err_devices(&e_info, level, no_ratelimit);
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..3dfa2aac31b4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -347,6 +347,7 @@ struct pci_dev {
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
+	struct ratelimit_state cor_rs;	/* Correctable Errors Ratelimit */
 #endif
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
-- 
2.43.5


