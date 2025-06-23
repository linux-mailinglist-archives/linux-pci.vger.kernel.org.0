Return-Path: <linux-pci+bounces-30352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5FAE38B7
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D71167E65
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221622F16C;
	Mon, 23 Jun 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rnwh6Nhh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFB822E406;
	Mon, 23 Jun 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668121; cv=none; b=D7ll5AtvVB3WLhY9+udBB8Dtylut2KNcFlbkNAzYejuSKINmvXKTd6r/rjWRn/ChGzhefsZVCqcMCt2Vx80Zmz8terdR5wNqTmbo26+czoSqmwc+QyjBlrHGHfwq4QSDYVfodF/VeMjgtgxryGgLsqMFKCg6E7AZLHu6QZzFb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668121; c=relaxed/simple;
	bh=GjU0NEo5GVFERFWe9Jr9MTf1dpYmlEqhadodq5dMl1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1LjhOS0GkWQdRoWsl6Ag0CfJPhOjQlA6lCzC8h6Po2MDEBQJU2fOHv27XgvahTydnSy1xJaT9r2ITywuH3d6eFnM/vXRpeKSMHzq0w2TsoUtGFUlFhqfH6+ocgNze2dN5RGQ0j+m5R6qosyzoqZjnYIPlDazx4VfsYZkbGpW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rnwh6Nhh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MLPxm3011313;
	Mon, 23 Jun 2025 08:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TkKzrt
	wUg2fZOc/yGpYd05A47C3HgikZeiXFYnWNM1o=; b=Rnwh6NhhPvmg5bOH1zfKyW
	Rtn23HlEfKtmw0zApXDadM1TACElKPuLFkD/S/aZnLvfXWGy0FgCeNXsBZLj6jqD
	Z3SqIK3i4SnH8/shzFunbjSxs40UfbVUQCsNmXYECYUHS0WI0/CiR1IZfIrI7CQs
	Ko/Xa28QWFwRws6IcJ3/5xznLKHbUTPHWp8Y+9KLKjCuzuCKS1s6ajYbV2uKg23G
	D4ryj+Uha+mhJuQwniCWzXWXFbsFtzw08OLbbOyOacxy5ZZ9VpI23lJM4fZc9qWO
	4jzxoQbNEetlEb0XlZU7VXbCMp8P/pg3FRI3wRlG+4skmiAWumRB9TwFTO+DyWnQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j0aj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:41:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55N8X9Ds017305;
	Mon, 23 Jun 2025 08:41:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j0ahq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:41:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N83Jfo030546;
	Mon, 23 Jun 2025 08:41:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eynee1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 08:41:51 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55N8fobU25952974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 08:41:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30F4658043;
	Mon, 23 Jun 2025 08:41:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CD5358059;
	Mon, 23 Jun 2025 08:41:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 08:41:47 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Mon, 23 Jun 2025 10:41:33 +0200
Subject: [PATCH v2 2/2] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI
 recovery
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-add_err_uevents-v2-2-a3a2cf8e711d@linux.ibm.com>
References: <20250623-add_err_uevents-v2-0-a3a2cf8e711d@linux.ibm.com>
In-Reply-To: <20250623-add_err_uevents-v2-0-a3a2cf8e711d@linux.ibm.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2985;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=GjU0NEo5GVFERFWe9Jr9MTf1dpYmlEqhadodq5dMl1g=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIihV2ats78/77k71PP2GLxxNvPGn7zKL8WvX5WqEgxu
 yFte4x2RykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABPJt2P4H+HdxXA5T2+HN4No
 6Cf7+ghniY8rtcoe7Zvm56KktoY3muF/1emWhf3vuDwSlk637uiNfPd1o+5WW/f87zps+V0F364
 xAAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA0OCBTYWx0ZWRfX64SdLBpnT7x6 dWDHEqZNqIiduTmxjuAPi9mkd1Gp2aFk8AbH8f9D/XHMxwa0pAyc3RNGBunM94n40cX71Dl97qP n+ul/s97wGaNZBaCb20nYhaANrMTzSW8/WR0jHDyVH9QbEw/J28byCMYo4vbmmnp1FTSqT5UXmS
 5pWbGRUJTj4RTBAPU2HaCTI2RDU9os9FErcCUhFgDAUY+268kRgES1d0h+44N/u+IQr/ePo/Kul cusvVYF3GX8nWeHwwzkEYAoJLWlZhQQszWk13XpuRZYEpEAft663t5FFhxcgucx4gUy5yBfpzhn PVFQtyp6619xegiuV6q7AJ6DaFxRCm8dyz646qum38QDrZcrV9s5QbVvb2u3W5T0BKgWwE+PMxQ
 KN/UwKCncDNIp7S2Y6th3MPMRKrDYDri0VnRaBiWA1DukPVCkci2KSdQyCFeAMvoJ+HVd1lw
X-Proofpoint-GUID: q73tPqesKaxsDlZAmW-T1sTAlfLuG3yw
X-Proofpoint-ORIG-GUID: 3v3CGwqtc-lm4njBAvmcHlflsrG7XDGs
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68591351 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=EcUHtpB8bGtrbQ9pWRIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=822 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230048

Issue uevents during PCI recovery using pci_uevent_ers() as done by EEH
and AER PCIe recovery routines.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 3 +++
 drivers/pci/pci-driver.c  | 2 +-
 include/linux/pci.h       | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 2fbee3887d13aa28e0621aa7b6d673f4517b5461..cdbe603ec2f59d95ff92210742d39d7c20f26186 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -91,6 +91,7 @@ static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev,
 	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
 
 	ers_res = driver->err_handler->error_detected(pdev,  pdev->error_state);
+	pci_uevent_ers(pdev, ers_res);
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


