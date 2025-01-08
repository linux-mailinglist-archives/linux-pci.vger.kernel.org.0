Return-Path: <linux-pci+bounces-19542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3F8A05DB6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAA3A72D8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAC1FC7E8;
	Wed,  8 Jan 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FyGcVpSP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895891FCCF3
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344555; cv=none; b=kEAAWVhnefaqBjFoQ7tX7SWM3WIfKg7G6eBiioRix1GS1KE4h1dsiEtgSWyoWUD5Wnzz/7p8u3K3dYZxst/5RvMEOlMW8Na13n7GOPVY6W9biGJVMyPq+nCa2S3Emg+OVSdGuwBX1l1dxlUU5nZbptrT9hhay1zTvySxtz9dwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344555; c=relaxed/simple;
	bh=W11nLV40Kn1EQNnLBgh9ktMxCeHSSl6UnTsg0I/S9ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRt7VSgUQUxn7hRCpr71QTPWHTTLjoR5tsWKOcHJdA6seMpJ9NNysX7VHym8XCyf8HM1pJOuOpUAeDzxx5LixEEtTiTseqUsC0d/OOiOIw1enZF4OhNihLm+kgYNmTONzT+5/Gur2zWjylU//qHRk12p8c4rXtt7b+7qmNbLPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FyGcVpSP; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081txI5015916;
	Wed, 8 Jan 2025 13:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=v9MUb
	RFgwereDNXqkwf5cAJvnQ7xE+qGh37CTc8lQiY=; b=FyGcVpSPe3sijhqMMjwVi
	j4X5cvvFBXfMWOFfMOUxrWMJKbluO4N+0LUYipSQqqaEyptrMzUljG3EGL4hsfjl
	syCP+NMkc2fz6D8oQC08QNRjGNrjGzg/7gox8zvlBLREvAaxfLTz/5vROkk1YnuZ
	ecDrVCbAAh6JOje0aamNYhYlN3jmoRIhSN14crfc8+1CTjufyE5ELSxOneu4tSMh
	yFbwO2yyKYYchNtvT8HfJHVKSsmKZFpwrKR9iNt5G4n38lJ0aVj8pskkMvU37rCZ
	TudpLkAcLx9jXJiuNRmfcDcL0K0YRQ2/Ya7yg1D2BNV7Se6oa3zm9670ytaXjc8x
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb6w70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508C4Y4T027555;
	Wed, 8 Jan 2025 13:55:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea1gb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 508Dtjx2011911;
	Wed, 8 Jan 2025 13:55:50 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43xuea1g3k-4;
	Wed, 08 Jan 2025 13:55:50 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>
Subject: [PATCH RESEND 3/4] PCI/AER: Increase the rate limit interval after threshold
Date: Wed,  8 Jan 2025 13:55:33 +0000
Message-ID: <4bd41a1538e4eb92586ea464a5b221c5f259344f.1736341506.git.karolina.stolarek@oracle.com>
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
X-Proofpoint-GUID: _q_BTNYz6hz1p1I6tar8UwBNDqhCGRPB
X-Proofpoint-ORIG-GUID: _q_BTNYz6hz1p1I6tar8UwBNDqhCGRPB

In extreme circumstances, the default rate limit might not
be enough and a longer timeout is needed. To avoid spamming
the logs, update the interval to 30 seconds for the specific
Root Port after it observes over 1000 Correctable Errors.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pcie/aer.c | 22 +++++++++++++++++++++-
 include/linux/pci.h    |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5c34cc2b5bf3..98bf8bbadc07 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -40,7 +40,9 @@
 #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
 #define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
 
+#define AER_COR_ERR_THRESHOLD		1000
 #define AER_COR_ERR_INTERVAL		(2 * HZ)
+#define AER_COR_ERR_LONG_INTERVAL	(30 * HZ)
 
 struct aer_err_source {
 	u32 status;			/* PCI_ERR_ROOT_STATUS */
@@ -670,6 +672,24 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 	}
 }
 
+static bool report_aer_cor_err(struct pci_dev *pdev)
+{
+	struct ratelimit_state *rs = &pdev->cor_rs;
+	struct aer_stats *aer_stats = pdev->aer_stats;
+	unsigned int total_cor_errs = aer_stats->rootport_total_cor_errs;
+
+	/* A significant number of errors reported, increase the rate limit */
+	if (total_cor_errs > AER_COR_ERR_THRESHOLD && !pdev->cor_err_throttled) {
+		pci_warn(pdev,
+			 "Over %d Correctable Errors reported, increasing the rate limit",
+			 AER_COR_ERR_THRESHOLD);
+		rs->interval = AER_COR_ERR_LONG_INTERVAL;
+		pdev->cor_err_throttled = 1;
+	}
+
+	return __ratelimit(&pdev->cor_rs);
+}
+
 static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
 {
 	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
@@ -1311,7 +1331,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		no_ratelimit = __ratelimit(&pdev->cor_rs);
+		no_ratelimit = report_aer_cor_err(pdev);
 
 		if (no_ratelimit)
 			aer_print_port_info(pdev, &e_info, level);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a736547396ca..6b062b1fcd3c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -348,6 +348,7 @@ struct pci_dev {
 	u16		aer_cap;	/* AER capability offset */
 	struct aer_stats *aer_stats;	/* AER stats for this device */
 	struct ratelimit_state cor_rs;	/* Correctable Errors Ratelimit */
+	unsigned int cor_err_throttled:1;
 #endif
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
-- 
2.43.5


