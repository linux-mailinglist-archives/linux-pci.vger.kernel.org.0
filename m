Return-Path: <linux-pci+bounces-18292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DD59EE8C0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 15:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA99282D80
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14692153DF;
	Thu, 12 Dec 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bv4zNVdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB32153C3
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013667; cv=none; b=kEO5olgMCeH7KTf4N1qrGGVF9kh64LQ1n5L9dezANq+aYPwmChnHQTdrvPpnbimhEii1732wR6f94b9Bt7JMXGbbMDsajxU0GRILf469D0KvRPB5A9oz0utDN+k0NcpzJZ8PxFPwXdPGd+QbJpRZGBNqAlGMt0VCFHm4AcAl/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013667; c=relaxed/simple;
	bh=ymt+tVJmIsLHhymI8bHnpOC+4RHXX48X2vjqcKWdDR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy18w/N+Xfxb1Lo86vvSEH28BuQTX1s/Zpj46N57ySqKnmNuyvREfBxYDKsI3XFqo3cvbsmVJgoX14+mF6/7CHnqX7H9NGMVEzv10VYBtJem94ix5RfP3wQ6HXJ8HAhW0RyhOtmpNZDcjefadDEU17oRyDXlMIHpx/8CksvM8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bv4zNVdi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBBdnq025508;
	Thu, 12 Dec 2024 14:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=fhnAt
	vw2i/OBGU+6vL2zbrx871RCJ1tVK9V72P9UK7E=; b=Bv4zNVdirWclLU7V8c/DI
	XEqDbXTYLymQgT65J5bl8rhJaez+x4U0O0cCahY6/F6l+vGeTzOAiucCfT2ENCwJ
	pcmGjlCtNxPBMAuSgaBOjOY3d0HVoQh1MnmQmy5R/E6qoKlR0wQKQhgLQmU+Y1CP
	mOYQQSqX7umGhTCFdaqUuywPgyJHVmP6gLZ/LoS/5im9S23W7HL9ONGU7vHhct1W
	UyIEOBjWFa+v7Y+44kmJq8BTTJzgLu6ts/vwmqDqeV5jS3GUX7nc4sXG3k//8n+A
	Ry+CRv8KvqO0mpnwcMig5IU+a45x/R85MMYmYV3BpzO8UFytvN0KuewaMVpolQYA
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s8b7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 14:27:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDD4be038147;
	Thu, 12 Dec 2024 14:27:43 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 43cctht4wt-4;
	Thu, 12 Dec 2024 14:27:43 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC 3/4] PCI/AER: Increase the rate limit interval after threshold
Date: Thu, 12 Dec 2024 14:27:31 +0000
Message-ID: <8e44f971e4e2abf89f610688a396485d8999c569.1734005191.git.karolina.stolarek@oracle.com>
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
X-Proofpoint-ORIG-GUID: DynWjBimJAIQ5BWTcq-0sQn_9Tufk5LM
X-Proofpoint-GUID: DynWjBimJAIQ5BWTcq-0sQn_9Tufk5LM

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
index 3dfa2aac31b4..b01bfb339e4e 100644
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


