Return-Path: <linux-pci+bounces-39793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83EC1F89F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9774E18899EE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D427354AD5;
	Thu, 30 Oct 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N/X0/4uB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB013559D6;
	Thu, 30 Oct 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819983; cv=none; b=rLZIawXntH+oRjWBEorgIa7meo6mhFXeNOzL+E6Us5KMb+v0BtZyGb6eoLkuv0pje/9qW8VPZRhZKIMj6TQW3gYnDkomvpllLS/+HGxisTKdxlgcX7U53R18W7JMkdziDCd/iqif2wK0bPMfBGtsiaqNtI5hmNkkKFl/Pd/+Cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819983; c=relaxed/simple;
	bh=lbYSck5feS6luX5oZ+P/wQz/apqe3kVu3JeIJbJAoho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRop83aO6nbPOleNqyTzoSaT/g5z7l430eaUTvwF8EKCw6QnMPhgK9WQ0A6RzlyukTn2yZjUS+46wuujPDLx1dq17kr4WgWBWB5zg2H/x7lXaelem+U1uVGNsHl69e9TfM0RcB/e5Gm/9XUJC1j2UQNiNxWGLeFz0Q6AaEANlTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N/X0/4uB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TKoDZK008744;
	Thu, 30 Oct 2025 10:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7AexNm
	X2b7l4O63cFOSJuz3GMoAMoLTt5TZxmLKKAwo=; b=N/X0/4uBPXkqjeKSP5ixCj
	IpcWMWvsycgBpxpKqbQIeK61jGG6JJ4ChBeg/LjzBzFA0mKPkejADL9E4BsDcch3
	gAZLFL25Q016U91N5OC5waus7IOtkXiWqPufQlYuc6pegK1U21HJEZ/xP/HSwj/A
	re9DmQmHyxFcQ+rw8zqwXOkwl6cYhxg+sZp0M7Mc4oi4aNvJZgL/ZuwP1+9n6TPf
	UVEsJKIc+kCXEjfIFeOm/cmu6OQ94+7X6ezjQE/JNq/n/MWdBa433cmS5d+4OkJJ
	/G4ah9ovNHwCtRS476pgy8O5DYlFkddeMG2yuvlwEgc5enIIn3BddF0QQ/mWeVdA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34afft0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 10:26:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U9e7mP030759;
	Thu, 30 Oct 2025 10:26:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwr66w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 10:26:18 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UAQGI824707718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 10:26:17 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE68858059;
	Thu, 30 Oct 2025 10:26:16 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49E4B58058;
	Thu, 30 Oct 2025 10:26:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 10:26:14 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 30 Oct 2025 11:26:02 +0100
Subject: [PATCH 2/2] PCI/IOV: Fix race between SR-IOV enable/disable and
 hotplug
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-revert_sriov_lock-v1-2-70f82ade426f@linux.ibm.com>
References: <20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com>
In-Reply-To: <20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=lbYSck5feS6luX5oZ+P/wQz/apqe3kVu3JeIJbJAoho=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKZbR2UdKbxhPVcnPno/+O0mQu/SJSV89c93sGy1EVwL
 VvXwj+7O0pZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZgI+x2G/7U/Qz7oHVM6F1ob
 w/6ExWWtD4MIR0LH9jduws/d8p1lLzH8d5L8L+B+aLbBr6qzlqmTA89wXHY2S0pj2DhJQXSro2o
 PHwA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jmvck38pZcckWjGLfjIlRhVb2z26ent2
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=69033d4b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3aDRTbdq9RQ_ftGXbWIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX5OzXWMKvndWt
 ot922/90WSyzv5EhnwM82c3VhN00Q6O7ZMtcBGSgso/vB9r1nHL6MnaWkDgIhRPYPwuwp2aQOGU
 ddToQT1UbtZGoS+eZhcEA9uiSHOBsBake3CUA1O3Jp+lZt2Q6kORYBWD/o8YVNSpdc1DkgEamAV
 24/cbtEPDetFcAoAzWnYfVUgyzcnTNROFHbmeD2sTETAAokeCZfu+sS9Hai/YyKGLtL7o2dqMKB
 J2VQhguDOCHd+5IRcZjgDcRwSbA328DVrvyEA5UFZS6zJ3afm7u7hpq0ti59QRO13hgWpiQAKYM
 W3/87UvJHTUqJNFBssxPG8diGXcPrs9k5VH1X8IJjIKOS3QvsY/0mrLk2rpUOa9uT8DO9Q1phPJ
 UQo9FeSQ/A/TlFA/uqC351ZF6fhEew==
X-Proofpoint-ORIG-GUID: Jmvck38pZcckWjGLfjIlRhVb2z26ent2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

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


