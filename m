Return-Path: <linux-pci+bounces-41611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE2C6E8D0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 710A93875F8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59E35FF4A;
	Wed, 19 Nov 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZoLSlUxs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C0358D27;
	Wed, 19 Nov 2025 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555735; cv=none; b=J20qPrdJV7OBYA5N0WzgJHLlFl1l/kNRbhCMjMwSdtH8YfSg7zsYiWa8rikzys6dOxRdhYNWa8ZPKKEkewv97qan2pCXE613fvDr1UsbPcd91OT7QZF4j4a/OirGy8QGe0YiB4FnOhSwv8dxWpyCgMmvbqCzSvrtEOW2gLztrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555735; c=relaxed/simple;
	bh=58KCtJq+qvjLvdf9zDwI5fCji4Pg7i5br64s8d7KYck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPTMzbN37NCRPnDdC1kVgzZbTAXE90pUpTay9/0oAlamqokcgKKlBG+RW8YM2Ap1cA1CA5nWE2QoRjPMI3FRAeeS2In0Pj2Fp1F8M0Yq6KYXhv64YTInob6DplmdXQ7enpAtF8bH0X6k5wIkWlEwJHmC4gE48IoFlxDjbUHirWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZoLSlUxs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ6vEN4002608;
	Wed, 19 Nov 2025 12:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ELMjDR
	ByMrpCcE1I9dSdlByoPUhtF/K2yEJ5RgAbhN8=; b=ZoLSlUxsSa23qcX+OU7jI1
	MifeKU4a5bw1LH3zV5Bk+3zTfB0wso/oyj73zkz/iqqLNO667P+jAdbIOxioBsdp
	U1Nnuy4PIN71eDSwIRI+lIegTlIT5mGkawBCMTQ2BcSSkBuvwuRlWxQ+row+eTlD
	bJKHUBq/m91XpLyZt+/DCS/HO3Gjz1B0OW1CmNS6ysHoUjLEDPQxU2NXnp5Z36P3
	p9p+rZ2V3jnF8r0C9VKHSF8zuaGYNCdT51LHCJ9YZGmcsYPZ3B6oWPOzn0BQNO6D
	Y+jhC0FtfrQg5XY5QYxnPtk3JlrOcGWcWrRfN1IkzK2rrxLpZZ71udmvxD5uJ2Kg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1gdrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 12:35:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBqBNR022386;
	Wed, 19 Nov 2025 12:35:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un0ky3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 12:35:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJCZ6v231195850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:35:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8081958064;
	Wed, 19 Nov 2025 12:35:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C9AE5805E;
	Wed, 19 Nov 2025 12:35:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 12:35:04 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 19 Nov 2025 13:34:52 +0100
Subject: [PATCH v2 2/2] PCI/IOV: Fix race between SR-IOV enable/disable and
 hotplug
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-revert_sriov_lock-v2-2-ea50eb1e8f96@linux.ibm.com>
References: <20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com>
In-Reply-To: <20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=58KCtJq+qvjLvdf9zDwI5fCji4Pg7i5br64s8d7KYck=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDJldxbr7t8kLSVcKbrjxxlGfseIHSv846bvXp25JWnJf
 q6D1a8COkpZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZhIpgMjw4pMnWfHkuv2TIg7
 cO2G6bT0JS9Tpm4+ksn04wvD/lJn2VWMDHO2W6xedJpdera1+x8t67f8YoE5wpsZXG/+SZjL7CB
 jxgwA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691db97d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3aDRTbdq9RQ_ftGXbWIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YYAOaXpfM-wfGFxb4qa9xv1mX0Kr6TFV
X-Proofpoint-ORIG-GUID: YYAOaXpfM-wfGFxb4qa9xv1mX0Kr6TFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX8ER8YAKVX5c1
 GMhntEG8lmMAKcB7HY3rCCSPCBwKhjfTf7kLNMTRcliYm9E87blSemt35mjuuhy9A4+7LZ//Qtc
 y/tkqfjwrMkf1NO+08TfG8G7HoWJwQc9FFmJZyUc5srojS232gwv9OS5ThfGvlT8134tFq0B+QL
 +AWHl0lgcQdFp2aTgPMlbklKTpEcegM2Fm8KB8q3adeyPc0ubqWs0X60Ns3oEHeFG8RdzgrfcmK
 hg7QDzspde/HugfFoJIiE0mloRyMcCsJ2J1PJeDJ0hSnb8wFx1k8XCQmItVOZ4/E//vs6NnDlEq
 DnZm1esQJJDBsSpoOSpWYiGZOHERwj6l/5qBzcTJTV1mNpR/gks88Q8j2TOdlBiECT2ENJOJgb/
 2Q7Hr6oiZ+AlvfF9Lu4jt1h1xTnAJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV") tried to fix a race between the VF removal
inside sriov_del_vfs() and concurrent hot unplug by taking the PCI
rescan/remove lock in sriov_del_vfs(). Similarly the PCI rescan/remove
lock was also taken in sriov_add_vfs() to protect addition of VFs.

This approach however causes deadlock on trying to remove PFs with
SR-IOV enabled because PFs disable SR-IOV during removal and this
removal happens under the PCI rescan/remove lock. So the original fix
had to be reverted.

Instead of taking the PCI rescan/remove lock in sriov_add_vfs() and
sriov_del_vfs(), fix the race that occurs with SR-IOV enable and disable
vs hotplug higher up in the callchain by taking the lock in
sriov_numvfs_store() before calling into the driver's sriov_configure()
callback.

Cc: stable@vger.kernel.org
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/iov.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ac4375954c9479b5f4a0e666b5215094fdaeefc2..c6dc1b44bf602a0b1785b684f768fcd563f5b2aa 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -495,7 +495,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 	if (num_vfs == 0) {
 		/* disable VFs */
+		pci_lock_rescan_remove();
 		ret = pdev->driver->sriov_configure(pdev, 0);
+		pci_unlock_rescan_remove();
 		goto exit;
 	}
 
@@ -507,7 +509,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 		goto exit;
 	}
 
+	pci_lock_rescan_remove();
 	ret = pdev->driver->sriov_configure(pdev, num_vfs);
+	pci_unlock_rescan_remove();
 	if (ret < 0)
 		goto exit;
 

-- 
2.48.1


