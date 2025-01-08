Return-Path: <linux-pci+bounces-19539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217ABA05DA7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DCD161CA3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E181F8F0A;
	Wed,  8 Jan 2025 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TApuNS1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F61FC7E8
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344552; cv=none; b=ADROYGO6XDLz1rjRxAIKbKzKwYNcSLvmQIllNCQWdE0ZW9ne9YPSFAwEdVv3HFYfKaxejue3hcTkHQLcXvQC+SeY73IsgvToom8de4HCrrU0bisi5qHF6yOEiP/gz10v78SNPjeGiePLVqaYnqDa22xJO++COF8ISUDoCRVXARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344552; c=relaxed/simple;
	bh=cE+CkEfdYfYmu0Pe/5GPYizeJq6asGOES1Wjx2/ScKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKh0e3Z/f4DKJGy6Cl6peul4+AECAI6ZXdl5KefOzt9nszqeRlxKdmOkG2TcEF+LrDqMMygcapiSVKahtfrB58MIWAcU3kYVJBm37QpTLBob8lb3rQm1BjWRSP2j3XmCI7yIhbEo/398fWIsNjlUiIoQEwPIcSQe+oqm8yzu7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TApuNS1c; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081u3u8015483;
	Wed, 8 Jan 2025 13:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=E1N2H
	JvPbEq4aJi2zzN6ZikHJ+Zv4mP4gsJPpOeMWK4=; b=TApuNS1cDsguqynT0JTDd
	RGGhSdyujm2ds4w6ug6fBvtag7q8Hz5SjZB6PRUqhI4fa0yOuC/RfdEiwU6sYAF2
	YgS4Rk8bkw6wXIQgXcL3vBxLvaTrcuJuXs37keNdkuZZqdOA81XOWepTCx4POJfI
	J/GIhxT1hdBhM8P4GCbtxPeT5TBCwBH8laQbsBfWpefNERRcUz9b6651X3y22L/t
	9zb4KAp9aKoqd0hbsI++U+LVaT28+3/nF2/3lbz4OdlafXrHKfPZQ55gGRCRPZDW
	vbcj/O39qo7flxl6FSMbl+SV/yTKMk1DCvdsWrPYjxo0y5RKgpvQ4XZs/bAR5NO/
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk074rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508C7Dp6026550;
	Wed, 8 Jan 2025 13:55:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea1g91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 508Dtjww011911;
	Wed, 8 Jan 2025 13:55:47 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43xuea1g3k-2;
	Wed, 08 Jan 2025 13:55:47 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>
Subject: [PATCH RESEND 1/4] PCI/AER: Use the same log level for all messages
Date: Wed,  8 Jan 2025 13:55:31 +0000
Message-ID: <edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com>
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
X-Proofpoint-ORIG-GUID: rZuyMjH47WkltiRYA2zTpXJ_BD8liqEz
X-Proofpoint-GUID: rZuyMjH47WkltiRYA2zTpXJ_BD8liqEz

When reporting an AER error, we check its type multiple times
to determine the log level for each message. Do this check only
in the top-level function and propagate the result down the call
chain. Make aer_print_port_info output to match the level of the
reported error.

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/aer.c | 64 ++++++++++++++++++++++--------------------
 drivers/pci/pcie/dpc.c |  2 +-
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2e40fc63ba31..139ea4f01448 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -546,7 +546,7 @@ struct aer_err_info {
 };
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
 #endif	/* CONFIG_PCIEAER */
 
 #ifdef CONFIG_PCIEPORTBUS
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 80c5ba8d8296..b13690fd172f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -672,20 +672,18 @@ static void __print_tlp_header(struct pci_dev *dev, struct pcie_tlp_log *t)
 }
 
 static void __aer_print_error(struct pci_dev *dev,
-			      struct aer_err_info *info)
+			      struct aer_err_info *info,
+			      const char *level)
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
+	const char *errmsg;
 	int i;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == AER_CORRECTABLE)
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
-	} else {
+	else
 		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
-	}
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
@@ -698,11 +696,11 @@ static void __aer_print_error(struct pci_dev *dev,
 	pci_dev_aer_stats_incr(dev, info);
 }
 
-void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
+void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
+		     const char *level)
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
-	const char *level;
 
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
@@ -713,8 +711,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
-
 	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
@@ -722,7 +718,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		   dev->vendor, dev->device, info->status, info->mask);
 
-	__aer_print_error(dev, info);
+	__aer_print_error(dev, info, level);
 
 	if (info->tlp_header_valid)
 		__print_tlp_header(dev, &info->tlp);
@@ -735,16 +731,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 			info->severity, info->tlp_header_valid, &info->tlp);
 }
 
-static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
+static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
+				const char *level)
 {
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
-		 info->multi_error_valid ? "Multiple " : "",
-		 aer_error_severity_string[info->severity],
-		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
-		 PCI_FUNC(devfn));
+	pci_printk(level, dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
+		   info->multi_error_valid ? "Multiple " : "",
+		   aer_error_severity_string[info->severity],
+		   pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
+		   PCI_FUNC(devfn));
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -767,15 +764,18 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 {
 	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
+	const char *level;
 	struct aer_err_info info;
 
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
+		level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		level = KERN_ERR;
 	}
 
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
@@ -787,14 +787,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	info.mask = mask;
 	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
 
-	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
-	__aer_print_error(dev, &info);
-	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
-		aer_error_layer[layer], aer_agent_string[agent]);
+	pci_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	__aer_print_error(dev, &info, level);
+	pci_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
+		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
-		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
-			aer->uncor_severity);
+		pci_printk(level, dev, "aer_uncor_severity: 0x%08x\n",
+			   aer->uncor_severity);
 
 	if (tlp_header_valid)
 		__print_tlp_header(dev, &aer->header_log);
@@ -1255,14 +1255,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	return 1;
 }
 
-static inline void aer_process_err_devices(struct aer_err_info *e_info)
+static inline void aer_process_err_devices(struct aer_err_info *e_info,
+					   const char *level)
 {
 	int i;
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
-			aer_print_error(e_info->dev[i], e_info);
+			aer_print_error(e_info->dev[i], e_info, level);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info->dev[i], e_info))
@@ -1280,6 +1281,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 {
 	struct pci_dev *pdev = rpc->rpd;
 	struct aer_err_info e_info;
+	const char *level;
 
 	pci_rootport_aer_stats_incr(pdev, e_src);
 
@@ -1290,19 +1292,21 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
 		e_info.id = ERR_COR_ID(e_src->id);
 		e_info.severity = AER_CORRECTABLE;
+		level = KERN_WARNING;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
 			e_info.multi_error_valid = 1;
 		else
 			e_info.multi_error_valid = 0;
-		aer_print_port_info(pdev, &e_info);
+		aer_print_port_info(pdev, &e_info, level);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, level);
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
 		e_info.id = ERR_UNCOR_ID(e_src->id);
+		level = KERN_ERR;
 
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
 			e_info.severity = AER_FATAL;
@@ -1314,10 +1318,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 		else
 			e_info.multi_error_valid = 0;
 
-		aer_print_port_info(pdev, &e_info);
+		aer_print_port_info(pdev, &e_info, level);
 
 		if (find_source_device(pdev, &e_info))
-			aer_process_err_devices(&e_info);
+			aer_process_err_devices(&e_info, level);
 	}
 }
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b6ef7efa3c1..9e48d571d9e7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -291,7 +291,7 @@ void dpc_process_error(struct pci_dev *pdev)
 	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
-		aer_print_error(pdev, &info);
+		aer_print_error(pdev, &info, KERN_ERR);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
-- 
2.43.5


