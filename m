Return-Path: <linux-pci+bounces-42427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BC7C9954E
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 23:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39878346907
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 22:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4472BE03C;
	Mon,  1 Dec 2025 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a9EekduS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B9A29BDB4;
	Mon,  1 Dec 2025 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626923; cv=none; b=nakcokQIoWlAPR1uFn3QA7KfIkGxe57miwUx+vq/tI4WrBYSIyWcEDtNrYwgmPmvzg0uDNKAMdQMm2LxhR/BTQMwVOf1TCoIR2GPg+yUn1p5cfoUqqKtpx+PG3eL2ZNLIzAM4fvW1U8Ny0V35br4u/bo1TQDJ+AFlpCkEQSpIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626923; c=relaxed/simple;
	bh=ytFXbNEKbWNWIa4e99DqMpdEgtgPube/J3VaS5HzAEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnS8W4pblcatthZnsO9+RPD2uK7NaInDQV2psiowDNt4rsIQJjCRKLpY9xfihpF2ydUTMBmpY5MvOtBbZWkD4V1rbX8NmpT7HLe7mu1aeBAWg1gD9HOBKO3XJtlcLWD+rH4AprJDL7FpadalpPmv+dBBmjxw/kWESCHNWPUIdL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a9EekduS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1JOIIG002616;
	Mon, 1 Dec 2025 22:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wJWMYHMfvbzU5BQsW
	YZErSvZaRLa/7xMVP6aVFziDXk=; b=a9EekduSFS3bIRhHhdzJjj73T15uiYbg1
	DTmJb53sh87T9lVjPp5CPTDpmtATvvEZ4Hpul790PAxJuFNJkP3IwUe0r9TMUBRf
	LusTNYQjyO1DWsOGCIJhD0wu+NJKLytaHR2zj9BAsSbFcPLfqD4R9Hx7sh+h5fwQ
	g74fCbZiAJ/9euArhkL8Ga//MutbIbeWDlfQnQBonDEEBSbgrzymRr18KyNyob53
	1piFoQpF1xXoOENxCdeYP5cvQVx3J3aPOZmf3HRlpo3VC82CI2n55TALWF3ba4pq
	Ey02J44sD8wkaNEHdQaAYR48acqcXgqjLdI16ucFZemWRvqyUAxBQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh6sps5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1JQkO8010240;
	Mon, 1 Dec 2025 22:08:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnk0u7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:35 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1M8XtJ4260618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 22:08:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 947585803F;
	Mon,  1 Dec 2025 22:08:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACB0358056;
	Mon,  1 Dec 2025 22:08:32 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.160])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 22:08:32 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v6 8/9] vfio: Add a reset_done callback for vfio-pci driver
Date: Mon,  1 Dec 2025 14:08:22 -0800
Message-ID: <20251201220823.3350-9-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=692e11e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9
X-Proofpoint-GUID: IpES5t8GQJHiKqRbYH9cOU6SrHH0qDVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfXx3cmw99g6zIa
 FLrBE1d+CgOHU5FxXaaXB1jOXeWkKRjilU8LPGR6SvpoHP6FM7X7uJcnjFLo4LMO7+s8tVBGdQb
 SnF38SWR5IMzOzXC7Y/jFBzhSR59hwBkALF6uf04i3FIDHsASdj6nAyuNYiEjZo9mtIZZQutii8
 0beoIq6rTUatuqdGRg90RqheCYEYmwThZ6olbabmwhc3MJtIXvpepEmHNqhCX46oBye3CJQMQQ9
 2JV3jkS/r1kdIqmFkfLI4PB03OPf4gzONgN4MyesS4UBIXQvD1EaPmY381W7ddLt9dQnwQeVH5I
 1ttghOJMJlYShGWfRjQAH64P901t0kOXOsdHyI/Rh7aWA4UzE3qkc4CoTIaIdRk2mURfpSkVlFG
 X5Z84bQQYWaTFGC4TiWvsZ54oKP18Q==
X-Proofpoint-ORIG-GUID: IpES5t8GQJHiKqRbYH9cOU6SrHH0qDVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 378adb3226db..f2fcb81b3e69 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2241,6 +2241,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (!vdev->pci_saved_state)
+		return;
+
+	pci_load_saved_state(pdev, vdev->pci_saved_state);
+	pci_restore_state(pdev);
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2305,6 +2316,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0


