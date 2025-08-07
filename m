Return-Path: <linux-pci+bounces-33556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F76B1D97F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B733D176215
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1E22638BC;
	Thu,  7 Aug 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DzAWEm8p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164B262FE6;
	Thu,  7 Aug 2025 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574965; cv=none; b=tsrVs9mfSjr1zIbmJ8E9jFv1SmAiW+hMPTrdNGZjovia/zbVmMYciWWgDQnBoIZGbfAcrVqNTEw7qDO4pgiPSDcYW6ntqzDlFYG470LQMKL0SjbmXBj9K4hiwwNR6EzvEh5zvGOigIJfMM/lBHt32DGpxM4QkS+RSoxKeAGGKSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574965; c=relaxed/simple;
	bh=052dvgQxomwEVj6h89TauZrrC59BaSmnJfbTE7aDz2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfXIduLAZtZg5irJmpDq/Swr46OdZ4C8/P2PeXfvuTH9h/cFZOcKiKIUDRyLaSjNO+PcN7C/uCnXXFvGJzPu1cEuYufJWJf1lrMnslINBO8IDcR8z3JTxju7p5DKwu/BrfaKUWZLNH1GH8N7mYqY4farLtX17XdWSzkkXkPY/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DzAWEm8p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5776W1CQ017986;
	Thu, 7 Aug 2025 13:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dnzNl6
	nzTzRC5x2v/gK2+9RF29p0evKhXuLll1Ad/j8=; b=DzAWEm8pVcOc8PZtNDL102
	TsfJldKBQdW4W9Wa83M7pMWWUALGCkCgKO0JmvRU4WTZFnmh8RMJJN+xjdNi3REs
	Fts0Eg+V2T8U6D1gKGiUY+fZ9RQ7FBxwmo5jsgcg6NCGIH3fC0zs95IqALSu2uxT
	rhFXGzmfgl4Z8xZDfnHlUzXgXlGFdr1Zsrq2MmyF8lHDUeN6h+yGdCWfWIf82rou
	sbnikQCUoy7riCh6LSr61VYsG8Ws2F/nCE8iPl5FWaLconab9jZHFC/hXVo6sh/h
	s7Ugjyh1TVYwWDOsBRx21nasTX3SsmZpOba/5wwN1CcLB3DQNEBs2jeuh+1B3a5g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63ac32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577DsbFP010838;
	Thu, 7 Aug 2025 13:55:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63ac2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 577DZbdw001602;
	Thu, 7 Aug 2025 13:55:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr0vmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:55:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577DtpOw31916682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 13:55:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FAAA58052;
	Thu,  7 Aug 2025 13:55:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 847E65805A;
	Thu,  7 Aug 2025 13:55:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 13:55:48 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 07 Aug 2025 15:55:39 +0200
Subject: [PATCH v5 2/3] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI
 recovery
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-add_err_uevents-v5-2-adf85b0620b0@linux.ibm.com>
References: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
In-Reply-To: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=052dvgQxomwEVj6h89TauZrrC59BaSmnJfbTE7aDz2E=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKmbIhVbLRuv3BuT0vgX/7Ib1/8eFmXfd96e3nt6gmfv
 vu8ell9uaOUhUGMi0FWTJFlUZez37qCKaZ7gvo7YOawMoEMYeDiFICJLFNm+Kf7y+Xm/Z9tHxYe
 3eLmudf/t9v7tpNRWVdjH21763tyiu8shn8qLydvm+N7zCBk2sFc1st35s+98F2xcJ7fpFM8U7Y
 Y3HjEBQA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExMiBTYWx0ZWRfX3BnmexlpZn4U
 NXjEZRDwQkgq1QhDl/PQ4qehI2GvxSJZZZRe1xOxq1gQEoMsRMBkyXfC2bN0np3WMeWah4Isk3V
 Og3QOdU6tFDqFmlVsO1HpBFGOVaRUlu1dgax9h4YO33wssSIEti7KrmXKHeiKMrUVdE/UOfi9qQ
 RGY72VSG5+CkiKHGQ1qR0yxO0K+GaJYFOrUvKew8uG7wwa+akxIQPHASmF43DvmLBZcqcu8v4GW
 BKmyafA5/HqgBPM0XM0O4EFUSPO8VzSD6XgvE24oapgCOTvYiV4lsna09qRRUpfrYLYrsgbVW3r
 ydasgJVT8ygeut+5ySAy+pYeX/awUUtoFLbQiCQ6FFgizL44Kp4MMfFDKomu/8Hobep/g/zTvK2
 cplFeWKJAOM8wHO3pAty7UuIE+Ah4eMDe9kL25wsPNezK2tdxCSci6AXeZMTfUoibUkVFSxh
X-Proofpoint-GUID: nHya5UDH_yIJ-SbsMQKXdVfnF2JR6az_
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=6894b06a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=EcUHtpB8bGtrbQ9pWRIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aH0YwnQ8fdHLWD9sv5Vb-CVXmSlBKpSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=880 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070112

Issue uevents during PCI recovery using pci_uevent_ers() as done by EEH
and AER PCIe recovery routines.

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 3 +++
 drivers/pci/pci-driver.c  | 2 +-
 include/linux/pci.h       | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index d930416d4c903f709764b75fe45fb66e529fcc5b..b95376041501f479eee20705d45fb8c68553da71 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -88,6 +88,7 @@ static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
 
 	ers_res = driver->err_handler->error_detected(pdev,  pdev->error_state);
+	pci_uevent_ers(pdev, ers_res);
 	if (ers_result_indicates_abort(ers_res))
 		pr_info("%s: Automatic recovery failed after initial reporting\n", pci_name(pdev));
 	else if (ers_res == PCI_ERS_RESULT_NEED_RESET)
@@ -244,6 +245,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		ers_res = PCI_ERS_RESULT_RECOVERED;
 
 	if (ers_res != PCI_ERS_RESULT_RECOVERED) {
+		pci_uevent_ers(pdev, PCI_ERS_RESULT_DISCONNECT);
 		pr_err("%s: Automatic recovery failed; operator intervention is required\n",
 		       pci_name(pdev));
 		status_str = "failed (driver can't recover)";
@@ -253,6 +255,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	pr_info("%s: The device is ready to resume operations\n", pci_name(pdev));
 	if (driver->err_handler->resume)
 		driver->err_handler->resume(pdev);
+	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
 	pci_dev_unlock(pdev);
 	zpci_report_status(zdev, "recovery", status_str);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 94ba6938b7c6271b557cc7f17ffb89631d83827e..2f3037050fd011108ef93e39d2d78a5c7e22fd05 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1578,7 +1578,7 @@ static int pci_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH) || defined(CONFIG_S390)
 /**
  * pci_uevent_ers - emit a uevent during recovery path of PCI device
  * @pdev: PCI device undergoing error recovery
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..bcc412a21d93a6dcc566f011258ed39d80d896c2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2737,7 +2737,7 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 	return false;
 }
 
-#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH) || defined(CONFIG_S390)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 

-- 
2.48.1


