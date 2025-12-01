Return-Path: <linux-pci+bounces-42424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2397C9952D
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 23:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BDFE3466AC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0547C29BDA9;
	Mon,  1 Dec 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i9/tO1YR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3150E296BAB;
	Mon,  1 Dec 2025 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626921; cv=none; b=KQNh2puFC0bjeHD1LB2pbBJQYFnf2FPYga+x+AMz54o2kZ5ScLNk9w4/MlmbPiEWhfHD2f338X3263KH85xFK8zkyUXLLooJQ8grXoAzQZTO95PHFLR14mHVjhA/zyVN1c5tLRpl3T0S3ZE7w9JylDpYsWT8KQoEt7As+S3qAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626921; c=relaxed/simple;
	bh=N2y0RbaxEYXxat1cUzPU+W13xkfMheEUmR7XA/kfbBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHwQAV/5FiZuWXNd2B9c2851lnB1SmocahN98+ZSVNBiXBkIHAPQbCWyjTR4SaDZE1vMugILEpvdLSrGe4kKH1o13Ry7i66XbSFJgsq4qEbiWkM2g3tgKTKJ3axhCixLh22QJCxgmJhyNo1HzCeUbG6M22jlBkzMSeSIINeCT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i9/tO1YR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1EsjqA019784;
	Mon, 1 Dec 2025 22:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IRt4lKhfNqfWjHA56
	anJ4y+xBtlFYzTL73eGDhJeSKQ=; b=i9/tO1YR0sAhiJvAP5+O4zsRjYKmPHA4U
	IcRVoYsYMSdJ/r7DrPgSUEk1bOwkDclCRtFhIO2qYv1k86woM+YujwkQ1Alnu7bu
	33AUefSQqXl+OYwiv2t9n2QvilvbDQxymkw3kv3ApW9+vJsXwcG9iR2/Fe3q6mXX
	JTLlhniQimKOrcvvchx8bURTdXMXlTxG5vA3+ldJ95bQsJF2T0I4/THYwUbtcOU6
	LeFE47OXOr/TzsMO5bB2nBUuss37Oq/qOP9sOC1A6TCXMxfltakoKIcilYPsp5NN
	KwtIYJMANp/OHi2RUsjnngSR1MKzqDzFwDkFpZ1sKQLg+dyzHdVoA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg1s8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1IPoes019042;
	Mon, 1 Dec 2025 22:08:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhxs0av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1M8U9W31261336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 22:08:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7813D5803F;
	Mon,  1 Dec 2025 22:08:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87F4D58056;
	Mon,  1 Dec 2025 22:08:29 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.160])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 22:08:29 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v6 5/9] s390/pci: Update the logic for detecting passthrough device
Date: Mon,  1 Dec 2025 14:08:19 -0800
Message-ID: <20251201220823.3350-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201220823.3350-1-alifm@linux.ibm.com>
References: <20251201220823.3350-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PPkPvu0pPqbGXykL8vbj7TWyhqAC_wI0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX8d3Bl5jDnxTc
 fcUSSp+ntLCA+55XMt4xuLDr60kVI2QDTdnkc6Hwqgjkf6J7XW2PTCZkokPImMmuiezV873r/Wa
 tBPsiwnLlIYkSs6YmtdsVb5glGVU/vOKyJt5thWlv01loZQN9LSi4TcoEVCyFoz5I2c1+56YcDk
 2cCTVWREsB2vCZHwkJZDllj3gaYmS9Y/84cYZuOknylWvyRMSNlBuMNrrdcWP84P8bHJAqO0cnl
 3OPUaWVa7t9VG7UMmP9724Cnr2qnGG+SEhZffLICrW/+HFFwJKPZYlIDAIgHtM7lR7+a7dvoamD
 wiwuFYfozgaAGIYoXLq1glBC7rC/CPCgN4PlLh8utyoYLzBq/wyHvkVQeWEqeVPXDGKd+DBN6Io
 NamLtc6VKCG44NpDo5l90vwLN8PQBQ==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692e11e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=MtaQWmmsotiDqj5H3ecA:9
X-Proofpoint-GUID: PPkPvu0pPqbGXykL8vbj7TWyhqAC_wI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

We can now have userspace drivers (vfio-pci based) on s390x. The userspace
drivers will not have any KVM fd and so no kzdev associated with them. So
we need to update the logic for detecting passthrough devices to not depend
on struct kvm_zdev.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      |  1 +
 arch/s390/pci/pci_event.c        | 14 ++++----------
 drivers/vfio/pci/vfio_pci_zdev.c |  9 ++++++++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index a32f465ecf73..52afd2ddc0c8 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -169,6 +169,7 @@ struct zpci_dev {
 
 	char res_name[16];
 	bool mio_capable;
+	bool mediated_recovery;
 	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
 
 	u64		start_dma;	/* Start of available DMA addresses */
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 27db1e72c623..c2deba16e4ea 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -61,16 +61,10 @@ static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
 	}
 }
 
-static bool is_passed_through(struct pci_dev *pdev)
+static bool needs_mediated_recovery(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
-	bool ret;
-
-	mutex_lock(&zdev->kzdev_lock);
-	ret = !!zdev->kzdev;
-	mutex_unlock(&zdev->kzdev_lock);
-
-	return ret;
+	return zdev->mediated_recovery;
 }
 
 static bool is_driver_supported(struct pci_driver *driver)
@@ -195,7 +189,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	}
 	pdev->error_state = pci_channel_io_frozen;
 
-	if (is_passed_through(pdev)) {
+	if (needs_mediated_recovery(pdev)) {
 		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
 			pci_name(pdev));
 		status_str = "failed (pass-through)";
@@ -280,7 +274,7 @@ static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
 	 * we will inject the error event and let the guest recover the device
 	 * itself.
 	 */
-	if (is_passed_through(pdev))
+	if (needs_mediated_recovery(pdev))
 		goto out;
 	driver = to_pci_driver(pdev->dev.driver);
 	if (driver && driver->err_handler && driver->err_handler->error_detected)
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 0990fdb146b7..a7bc23ce8483 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -148,6 +148,8 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 	if (!zdev)
 		return -ENODEV;
 
+	zdev->mediated_recovery = true;
+
 	if (!vdev->vdev.kvm)
 		return 0;
 
@@ -161,7 +163,12 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
 
-	if (!zdev || !vdev->vdev.kvm)
+	if (!zdev)
+		return;
+
+	zdev->mediated_recovery = false;
+
+	if (!vdev->vdev.kvm)
 		return;
 
 	if (zpci_kvm_hook.kvm_unregister)
-- 
2.43.0


