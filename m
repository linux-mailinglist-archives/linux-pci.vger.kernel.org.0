Return-Path: <linux-pci+bounces-26681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F0A9ACC6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB7442858
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3156202F79;
	Thu, 24 Apr 2025 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZjGp2DO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C580502B1;
	Thu, 24 Apr 2025 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496215; cv=none; b=c5u5ZCCOphz+Cc0VS66jorhV5fhCua4vzKiQ2gTSyzU/6vwmtBvi+8a6iu1LguEL7C3n8DH98WJxl2JDPOV5N3lCjsXmjEaJB/+iKwRWfLQBwA3qQl4MSI4O/fcSlbPfC41o83uBsA9xqlLiKpVwSjCFa8MStt6IahdO0qs6CuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496215; c=relaxed/simple;
	bh=Z8PDMx0Ew/K5wTTQM4IZ5TGCRv0Kr7FOrjwROTttpvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dckqnxt2darp50ZG5rL4oqy9HKTsjfDU0pGs22iB3Ww8D0e6/ytXr3DtBc3Utl1NGrOH0QpAZgSqaKXp+SEXyrAVgxK86W7sLP1YKvCnYmEz9/fJ3snxgJJBDURYLbsk0VtgJjSumdsvjxPNJHaFHvbSQOpFu1BSn1v3iNKQzes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OZjGp2DO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAevx0020647;
	Thu, 24 Apr 2025 12:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Jo6O5+zoHyUB9al+w4/VZLdlMtAo
	GFBgTkHWrLvm7mw=; b=OZjGp2DO2KbrStUfR0J6fH6zyc70MmjIGAU/mDx8g53Q
	MvE9y/apIm2mXevsi45Blk6a/sBn8uPj4pqsz61QKKdFHRQs8SYvVrMOHGjQjXdY
	XGDQtTSppeJgTioR/IjcKmuKz5btxKxoQb4aDRrNHbH+SMzthLLLfwk+SIWAXJtW
	UpstYsBV9th1S8Qvu/2698arGa6hOHi1nu7ci3xdhYpNxMw8U46nmD9tP4xTxUa0
	KdTrpmwoYD7+X6vxLkVTVH7VeMPoTkXi8xDVM5RYC+yuaalflEtMilpjBlHhOzjP
	K9CHsD8pJ45Ga5GH87rCRUqm96IojZJp3ESx666Apg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krsrcf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 12:03:27 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53OBjEKO023410;
	Thu, 24 Apr 2025 12:03:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krsrcev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 12:03:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBQi3c004062;
	Thu, 24 Apr 2025 12:03:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jg003a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 12:03:26 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53OC3Ok823069012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 12:03:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C53B65805C;
	Thu, 24 Apr 2025 12:03:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D598258054;
	Thu, 24 Apr 2025 12:03:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 12:03:21 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 24 Apr 2025 14:02:53 +0200
Subject: [PATCH] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI recovery
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-add_err_uevents-v1-1-3384d6b779c6@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAGwoCmgC/x3MSwqAMAxF0a1Ixhaq+N+KiEjz1EyqpCqCuHeLw
 zO496EAFQTqkocUlwTZfESWJuTWyS8wwtGU27y0RVabiXmE6njigj+CqeaGC64dbOsoVrtilvs
 /9sP7folunTRhAAAA
X-Change-ID: 20250417-add_err_uevents-6f8d4d7ce09c
To: Lukas Wunner <lukas@wunner.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3671;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=Z8PDMx0Ew/K5wTTQM4IZ5TGCRv0Kr7FOrjwROTttpvo=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDK4NJolZZy1/CUrT0fynJpS3KievWzSi19MMlpLf+w6w
 HqnyeF2RykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABPRncvw32tv+q1bludjVgWF
 Wu856lxS5brr2cKAusVXn30w7dh25Q7D/2K/R3+kYh9PPtyq+Mbo0l3pxtVz2+qM3y5YJ//m5I6
 gdH4A
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3OCBTYWx0ZWRfXw+cxXmiBnkNg zhI6A4mFpotyYFSoHGmj2+Lf/XK4WZ8UQniLocLHF8Sd1RNIKeu2yd57C6ja5LvAcpdO+nWTyV/ 6Mh2MDQvJShrXuk3SHwBdpuiSpu1eEqgxF2pDaw+G7kuIarj+on/IbRBnOUOeocYQuFRvjnLcVY
 KGQfe7Dba4t0ZbKcuQ1c2MMohbYuIFuDa1ij3jBZX/093ND0uPdFyHGYvM2hc1pi8dy9hOs6dmP HHgSVJMIcNrCu3ePZ5u4H49Yj6kmYHjH94jD07DUmhvLSY+7bD30zW0V5+Nj2R9m2PZz8+JjYjD onLK/BO85iKLXoIB935Fa2/wil4yDaexWEQD16CGC8Ve65MR/fW8/0pNZZWtimbB/Er4clov3w0
 SgYyTfUmdZXCM9Vc7lo3v9atg7CyQTziJSQX8zoTFT12s98Mx+B8N+84r9Xjlti6epL0FVBS
X-Proofpoint-GUID: dbnkhbxciHtsYIoLs2zglo8X1y3N0u68
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=680a288f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8LeQyvkg2U568Q-kuFUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8f8lk5dYEoCD4mpqY5A3O5mU-rl7utfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240078

Issue uevents during PCI recovery using pci_uevent_ers() as done by EEH
and AER PCIe recovery routines.

Cc: stable@vger.kernel.org
Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Question: pci_uevent_ers() ignores PCI_ERS_RESULT_NEED_RESET which also
means that unless we use PCI_ERS_RESULT_NONE instead of the return of
error_detected() like EEH also does. there is no event for beginning
recovery. This is also true for AER and seems odd, is this intentional?

Npte: The fixes tag / Cc stable is maybe a bit borderline but I think
having the events on EEH and AER but not on s390 warrants it. Thoughts?
---
 arch/s390/pci/pci_event.c | 3 +++
 drivers/pci/pci-driver.c  | 2 +-
 include/linux/pci.h       | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 7bd7721c1239a20e13cd3c618cce6679f36b0d06..37609bc2b514c00b5b91d6edd2ec366d59ae9f49 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -91,6 +91,7 @@ static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
 
 	ers_res = driver->err_handler->error_detected(pdev,  pdev->error_state);
+	pci_uevent_ers(pdev, PCI_ERS_RESULT_NONE);
 	if (ers_result_indicates_abort(ers_res))
 		pr_info("%s: Automatic recovery failed after initial reporting\n", pci_name(pdev));
 	else if (ers_res == PCI_ERS_RESULT_NEED_RESET)
@@ -226,6 +227,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		ers_res = zpci_event_do_reset(pdev, driver);
 
 	if (ers_res != PCI_ERS_RESULT_RECOVERED) {
+		pci_uevent_ers(pdev, PCI_ERS_RESULT_DISCONNECT);
 		pr_err("%s: Automatic recovery failed; operator intervention is required\n",
 		       pci_name(pdev));
 		status_str = "failed (driver can't recover)";
@@ -235,6 +237,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	pr_info("%s: The device is ready to resume operations\n", pci_name(pdev));
 	if (driver->err_handler->resume)
 		driver->err_handler->resume(pdev);
+	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
 	pci_dev_unlock(pdev);
 	zpci_report_status(zdev, "recovery", status_str);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index c8bd71a739f724e09b4dd773fb0cf74bddda1728..5cc031fae9a0210d66959ce6082539e52cdd81b4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1584,7 +1584,7 @@ static int pci_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH) || defined(CONFIG_S390)
 /**
  * pci_uevent_ers - emit a uevent during recovery path of PCI device
  * @pdev: PCI device undergoing error recovery
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96713054388bdc82f439e51023c1bf..71628a9c61bd7bc90fdbd9bc6ab68603ac8800dd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2688,7 +2688,7 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 	return false;
 }
 
-#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH)
+#if defined(CONFIG_PCIEPORTBUS) || defined(CONFIG_EEH) || defined(CONFIG_S390)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 

---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250417-add_err_uevents-6f8d4d7ce09c

Best regards,
-- 
Niklas Schnelle


