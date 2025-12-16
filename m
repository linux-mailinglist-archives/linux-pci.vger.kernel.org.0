Return-Path: <linux-pci+bounces-43152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D8CC5526
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 23:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D213064AD6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DFB33F375;
	Tue, 16 Dec 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jVDPbnZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769512D9EC4;
	Tue, 16 Dec 2025 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923294; cv=none; b=mIosuopV+Me4oRM17LQ8sE6SgWXZhC2NdG7ht886MtgEXE+Nfyyaroq6hKB4TKCDBhL0mcrBQows1wiuCwhy77xWwLQGweQmPoZbknr3+LNvgAnzxEJrq7nO5bRZxAc7Us/OCLw3Vk33XwVBlDfPQ65UItr4py4tlJCA+aCQUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923294; c=relaxed/simple;
	bh=XRM9ebZLofnlNG7c8Qp3cDo1buNW9ZaVDmkglZ3CIUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANdO7uCkMeoAMaMMwfaDabjSvzcZ7QeLEc5QPLfoorPYu0SdasHsY6UzedanDwvieyj9L7RvNLyfvDLOOgzVDCnWPmtHVZjPuZka0qvUTPoIV0NK3CrKrvVOpuKyqxMTWxN/5zuFL58pM2b2JLJNmthUctxUmi5tIsbJLK6SZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jVDPbnZZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGHKXsN006963;
	Tue, 16 Dec 2025 22:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0eulbv
	FY83Zr1QcyvkDK42S4t0eIAzUZ9Xf6vuTTqSk=; b=jVDPbnZZB3lLyoTOLiiNyg
	DhDy4lgSV/aRkscEfhJqSm/U8QSLTkaxI24aqgOR7WLJzDpvHsPJElOnD/KovwQE
	q5r3VZPoHcfvG0wNH7NqlAi+y/q8Yl0qI381qartoipiYLkjImW6Cm7ribX8nUos
	qIMXJWbgMDTvKikGKxgY+fdhwT/gQtlLkWYgfkVwXldJytd/QhHaIjFBx17Ok9Vk
	b9SSYRWzIzb0I34VlU2xnTqUKgJcFCeR+VkKm6mEm4Bd1bxveHK0Yjg23OABmg3w
	AD32DYjpmr3Rfp5UWoX5D3R6K7zeWe7VfqT33qsyWuW6zqnHXSXRQe0+gsQI9aZA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm14tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 22:14:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGJXUUX014332;
	Tue, 16 Dec 2025 22:14:46 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1mpjxqu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 22:14:46 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGMESAs19792632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 22:14:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B74BF58063;
	Tue, 16 Dec 2025 22:14:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38F965805B;
	Tue, 16 Dec 2025 22:14:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 22:14:42 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 16 Dec 2025 23:14:03 +0100
Subject: [PATCH v3 2/2] PCI/IOV: Fix race between SR-IOV enable/disable and
 hotplug
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
In-Reply-To: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=XRM9ebZLofnlNG7c8Qp3cDo1buNW9ZaVDmkglZ3CIUg=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIdb55+eulJQJv5waoNG+aZXDmYWP2lw+Cwl+rxJ1lBf
 ZGOqkWpHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAExE5h4jw8l2Oe7bH+9d3MyV
 dOHiliVfSl+GPOVedTnmlr3vrC2x9aUM/9RDRV+fqXeV6Pstf/O+/irxjIrN/9J8w2rsPqxa5nJ
 2BjMA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xh1XA-mgLopcmNAa-5qHiLW-L6jnDsJX
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=6941d9d7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3aDRTbdq9RQ_ftGXbWIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xh1XA-mgLopcmNAa-5qHiLW-L6jnDsJX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX3Z7bSmvaE6k6
 XSC6AEVDFEy5mgOFAHL/U+LGw689YW7mxcb29mo2tKs61BoQeTmzGNsFeL0zdZtSXVhnzjDOypi
 zIsr8V32OMWdeRx9Dj/dRfoD9MtxL8M/6GxIP16JopqoIrMXEaxsAC6ruhtO44652LOJeU8aNZv
 O9gehDs7VwexZzn4ol1ZdRTNUqiU6kp6CxbLTQghNWr3DPYvmodyNEdQ8MUDr2cmHsBB/EAZFX5
 6aBGpJ9fP1Xkbno8bVg7iPo1+0aomPeUZxVnGuMKlNXmZontl91vu6BpJgHNKPI8kLMoQeu77hU
 yAip0vWmLKTvLkLYur4LlXWAyXrMO9TdfamxWpnNwjn4H97hqwHFU8w3WV263R7x0EhyeoLJ+bu
 Rz+kYi3ldyxtJE1bvBQI3L5LftcHSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009

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
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/iov.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 7de5b18647beb69127ba11234fb9f1dec9b50540..4a659c34935e116dd6d0b4ce42ed12a1ba9418d1 100644
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
2.51.0


