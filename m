Return-Path: <linux-pci+bounces-41610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B707C6E8C2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECBB5386E57
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19A35F8DD;
	Wed, 19 Nov 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ol9E32N7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265B35B142;
	Wed, 19 Nov 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555734; cv=none; b=SxbFouQaq1CXqFD6DHIEyb0bMin98gVP8eH1aD+AvUoSQNarble1idIoOy9bOEzMNyt3DScvUU/LaboTfCUh0QyoEIYZyNZP3SEZW2fHwpn5qrX+swS3p7PR5Ox12DU3C49fJKbVeAPwroetQLz9/LgmUd2ZhULvHB5CWqbDtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555734; c=relaxed/simple;
	bh=zPmYDRa/t1t/Cd1VkzkdvB09eMFc+bCZUlN0iMz/Q8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+tdU0oIOkCL/BSBcP3cj83mOQ3srWpX6tCTOTAIk3PLu/DII3VzX64Jar0fBQ5e6HXy5kTV9gXOYmuTLmG0SMI17p9gcRaFmAoPj87bAcqUyCC8O0ztPE6xLC8Y/3mKyVBOv62VaJ9SZ8G9F8yw8Gt97omOyzm1HjEk8haRcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ol9E32N7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8fgmM011149;
	Wed, 19 Nov 2025 12:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ivf03u
	eOCRjxpnQdDbyEoE7Bb0ySj4tLmcWnqmz0rvg=; b=ol9E32N70/dL6Qbw/39QY7
	MP85B6PVvEuqF238t+2uUPPhCBDO7B+fN/orV9zNcCFAESh4/P9n6sMuoXazlQHP
	CDb1Fkl50Cxukg2XcY6lw7cPlEld/+1ZpYC1u2sR4SuEgTLs0MfJWO0ojcb0zMAp
	S4VCAzkLeEXFJyXryjDaABYIWhGA78THvijkylufvIBrMfg3Wi7GXi9TkRayoV+6
	xyh0w8U4vBQldHTYgsQGejnprEs4jQ8/oCuYQ7AbdEWaHtk+kfHuGxlmzaFaiIva
	OkvP7rCt69c0c70JCn1zLejJBWTvzv/U1eAQHxfkNpt0M76gfpJ7+QfoWjD7eOiw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1gdrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 12:35:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBUmPV030805;
	Wed, 19 Nov 2025 12:35:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47y0qfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 12:35:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJCZ4N529885074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:35:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 409325806A;
	Wed, 19 Nov 2025 12:35:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B3A45805A;
	Wed, 19 Nov 2025 12:35:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 12:35:02 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 19 Nov 2025 13:34:51 +0100
Subject: [PATCH v2 1/2] Revert "PCI/IOV: Add PCI rescan-remove locking when
 enabling/disabling SR-IOV"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-revert_sriov_lock-v2-1-ea50eb1e8f96@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=zPmYDRa/t1t/Cd1VkzkdvB09eMFc+bCZUlN0iMz/Q8k=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDJldxZV3a25GcZ72+HT9pyYdAsZ7b0eawqP67LImmiz7
 xGK3aXWUcrCIMbFICumyLKoy9lvXcEU0z1B/R0wc1iZQIYwcHEKwETicxkZpk7dKuwQvuTRkv0i
 MTGZVqYb6sx45Dk6M/yWqE1bcenubkaGwyWms09vELKqPi311+aF2+xFktKVi5bctV4xzfajrt0
 TLgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691db97b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NwnTm4zaWNGWObc0R5cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q060AGkkmm7SUjvEdxoxvwyPEQ13rWsQ
X-Proofpoint-ORIG-GUID: Q060AGkkmm7SUjvEdxoxvwyPEQ13rWsQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXzoRULHPGzHxK
 qr5vbZhTUFXFImJVmZqtwFaKf+5a1og2Pfac8Rkla7BM9EGQWrfDhdqM3Pqhouq2eklhIOtiSTZ
 8wQwoHIQTgSFcoXNkVLisb39YCDa93d1lLolTRLYoEUnqd4MvT1M8sy+K1mL3ybelRHBWfwZVnF
 OccRlZO+hWo+CiiroaR6KClqLsL1ZCcv0TNR/aRFLVBr9spaaWxw57YLOrNWtTrWenCWefMoWg+
 U/kvn3Om5jxhGkjSwE+aZt/Ik7LaDcJNY98t9dclkQ81aBWgjPbYabUnJrp16QqlnBb03MjJwVA
 UhICZhLWhCFDVR7XqJ//eS5jD5Cw9z/nylZnuWY7abbdckV6DqRXk5EKWPmrad+bK9zYpjuwuGn
 f7W+QxLarDjHC5rKiLrkGimEINodkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

This reverts commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") which causes a deadlock by
recursively taking pci_rescan_remove_lock when sriov_del_vfs() is called
as part of pci_stop_and_remove_bus_device(). For example with the
following sequence of commands:

$ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
$ echo 1 > /sys/bus/pci/devices/<pf>/remove

A trimmed trace of the deadlock on a mlx5 device is as below:

 mutex_lock_nested+0x3c/0x50
 sriov_disable+0x34/0x140
 mlx5_sriov_disable+0x50/0x80 [mlx5_core]
 remove_one+0x5e/0xf0 [mlx5_core]
 pci_device_remove+0x3c/0xa0
 device_release_driver_internal+0x18e/0x280
 pci_stop_bus_device+0x82/0xa0
 pci_stop_and_remove_bus_device_locked+0x5e/0x80
 remove_store+0x72/0x90

This is not a complete fix as it restores the issue the cited commit
tried to solve.

Cc: stable@vger.kernel.org
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/iov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 77dee43b785838d215b58db2d22088e9346e0583..ac4375954c9479b5f4a0e666b5215094fdaeefc2 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -629,18 +629,15 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
-	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
-	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
-	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -765,10 +762,8 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
-	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
-	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)

-- 
2.48.1


