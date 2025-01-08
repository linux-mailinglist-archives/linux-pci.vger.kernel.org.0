Return-Path: <linux-pci+bounces-19541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB1A05DA1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412BC1881BBA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84FA1FCCFD;
	Wed,  8 Jan 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmUiAObs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79551514F8
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344553; cv=none; b=OORj/R+TsW4h1Uhq6MddX99d1RLoEOQ+g+IhQr/0CdvR2/1Lv1xwci3LCSgVvsuYX14unRyYxco6UycrgJw2kewjwp675U6DXngambG5jTTtEls4MyVCII1yCYU/QlAODzxqH0iQpo+s++pzQDjudMXoKXeb6rI2C5Xvmlg9o8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344553; c=relaxed/simple;
	bh=9kjuJgk4rVDlymzgvixJEjN6Q+mObq39a48HzT43Tjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkwlaNY5uFGfXUnGEKt+PEaxebbyAH9tzSXqNlsUI8JGjjcpnAXci5qgCxxpIfsnz5XQTYPGs477MU8CIKPZwNQHvZpsSWI1Vx4T+TSzQBj9Q/q/bGF7+Z7IW4wwvagmEePItzxtFvnUS2Q+o0Jw59I2//AWdJG1dE27ZgNXYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cmUiAObs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081u044006353;
	Wed, 8 Jan 2025 13:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=mHs68
	lMPfo22TH+pEO3TqM0G2pXZ/6+Jm2v47ltVHGk=; b=cmUiAObsbpxBBDdtqokoM
	W5otH5TGckd2T0zfYbEbw+hdDZYdMY8uAYCOeZTl3My98DeiTrI7zsCwlBA+Rpvc
	BSdgzxAF8kGs8nBawYQr/qdQab/dI5xXyyw9H2uXHDU5KzRQqeprlAaHUp17CByt
	/i3shm3Kx72O676moRUFcErN9vfC8nhmIX58wpGF2UN0r1mBhH3z6CPYc9w2VP3c
	MrzSrMEyDiaJ82chf0XzMuXB7iYtRoGyq1p2198+y3bjWq/P0HlS/DoKqbidbnAJ
	CwhOG5KH1kAseqX8wvZ0s2SFrpvJn19yLxw/wxTNNrmvuQCA2RKVOJOSallDDXW1
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhspnf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508CiWJY026396;
	Wed, 8 Jan 2025 13:55:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea1ga0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 508Dtjx0011911;
	Wed, 8 Jan 2025 13:55:48 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43xuea1g3k-3;
	Wed, 08 Jan 2025 13:55:48 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>
Subject: [PATCH RESEND 2/4] PCI/AER: Add Correctable Errors rate limiting
Date: Wed,  8 Jan 2025 13:55:32 +0000
Message-ID: <68ef082c855b4e1d094dcfc9a861f43488b64922.1736341506.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736341506.git.karolina.stolarek@oracle.com>
References: <cover.1736341506.git.karolina.stolarek@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_03,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080115
X-Proofpoint-GUID: rfEiCrvnEFDe72j7Q9Cs8T_VHdsS9Qax
X-Proofpoint-ORIG-GUID: rfEiCrvnEFDe72j7Q9Cs8T_VHdsS9Qax

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
index b5eb8bda655d..a736547396ca 100644
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


