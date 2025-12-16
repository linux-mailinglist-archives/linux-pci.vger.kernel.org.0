Return-Path: <linux-pci+bounces-43151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FFCC550E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 23:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E346930214FD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8833E342;
	Tue, 16 Dec 2025 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iHywd0Cd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7333E364;
	Tue, 16 Dec 2025 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923289; cv=none; b=IMOk1p6NNXjSdK+taAv5zqx31zNyzQSFXtlWJQ+66LPR/sJ+B9+vkk+U7YONKLVxb36TOmtokGcji2ZODeXG1AdjZPcLCfHTsTXiJCe27ubM73NAJBD7+hIuFqyxDf+U7deh0SYeJWZbgOnvrUpvcpVdRR7ZYAfsRagNjkSiGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923289; c=relaxed/simple;
	bh=BfVB8qQ4Pp2AbjiAs8CQ+VkauKYUiS8A65/9CFiF4sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVrf1zhCUTiO/qVklkC6fXtrA2FQQVGJ1ZdwlCPfe0LXhjbUDBPK+nf2HAXqPpZn8N8T8nP5Fd9PFfmv1gszqdIknMFnE3IoJIhpveT6fS2gTo4UzNDBmB7xy9suGoEkhhid4p9x3G2d2slIZM4fq9fFAhK/4Oa7O4HE7mJAt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iHywd0Cd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGGplHW023977;
	Tue, 16 Dec 2025 22:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JpeyWh
	0NZPNPGw9nkU3iVNJPHIWQYNRHjSXS4c4gkT0=; b=iHywd0CdEkLCDQWyGDl2Hq
	D+UKGovOE4F8jYlw5votY1WioAZxv/VuILAXK72hyB/Gjbs1Byi2W4FzvCmjOv36
	moXgwzQxmkbX7FbTLM3l7lK1WXZSVIG63v3/Yb88/5ab6+xSMZz0RXb4rvNOnTMc
	SFNuusLUPcJJbf6LD0kkfybkWTP98mA7Z9IBk2kKD6+HUFmWOSOCIbFci2MaqBfv
	MoaHoY6CzqgI6lveLeO0WP+WkJzXujwdyf7x7OKqQfVzqqj722tm7Nm3/Gfo4r46
	4PALn2mP4XCbeTUNDX6U3tNVJhKVyBghEjhvIZteSC1Y+HGEr6QlzbROa0cQupCg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm14tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 22:14:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGKkPYD026808;
	Tue, 16 Dec 2025 22:14:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsfajt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 22:14:43 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGMEgd563439318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 22:14:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F7E5804B;
	Tue, 16 Dec 2025 22:14:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6483158059;
	Tue, 16 Dec 2025 22:14:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 22:14:39 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 16 Dec 2025 23:14:02 +0100
Subject: [PATCH v3 1/2] Revert "PCI/IOV: Add PCI rescan-remove locking when
 enabling/disabling SR-IOV"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-revert_sriov_lock-v3-1-dac4925a7621@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3346;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=BfVB8qQ4Pp2AbjiAs8CQ+VkauKYUiS8A65/9CFiF4sg=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIdb55Wndfn+Ojt1la5Nw7LZq1nTlepjPA5yC9wyMVd4
 85Gs3jljlIWBjEuBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACbCsIWR4e3t4sU+q2ZuO2n0
 gtnApOfHwzk6sd8eqvMFT/xsUtNpupDhD+9h44d92q4zVIMmcLo4fNjymlM81lhvbb3aZP3z25r
 6mQE=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _03pvSMQucGG4dZFNq_3Ezd0n_pahW-G
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=6941d9d4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=rH0laySEOpfJekSq1n4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _03pvSMQucGG4dZFNq_3Ezd0n_pahW-G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX7Tf57Y0ob6ID
 7Nos86ocyYaOl7/TBlwBptTQ0JbNNwJpUoiyvw8B4u19Euo5Q5lLxDoQGTp8NkSCbbfe50lk60H
 urxZ2fFFPBk/hubsgP0TY2T2mZFwOYjADf2pG8AgJKZMjfJDfbSkGH4eMbIhhAUOv+BqCFOxEbD
 G32aS5JHfaeABCD+ksl6sSB9eeJo2JGr8ycT9xFQKyM5rCeSTSG/jcPlVmmelS8CoHCjGOdS6D0
 2PHAYmxZS41Z6776UAQo/RmvEOF85IiWbLYH6mOLKypm7Qy+/iK6s/x537BHc2kHfpLVgUBxzJ+
 TYXseECuF4noBr4RLZ0L1A3A+ZyxIFDCyolOB3FnRdHCwamOICrgaaPgaIBEhCDRRuJm44oarYI
 BEcQ7wNGl5OhQxWDEx70st8NR9VFPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009

This reverts commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") which causes a deadlock by
recursively taking pci_rescan_remove_lock when sriov_del_vfs() is called
as part of pci_stop_and_remove_bus_device(). For example with the
following sequence of commands:

$ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
$ echo 1 > /sys/bus/pci/devices/<pf>/remove

A trimmed trace of the deadlock on a mlx5 device is as below:

    zsh/5715 is trying to acquire lock:
    000002597926ef50 (pci_rescan_remove_lock){+.+.}-{3:3}, at: sriov_disable+0x34/0x140

    but task is already holding lock:
    000002597926ef50 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pci_stop_and_remove_bus_device_locked+0x24/0x80
    ...
    Call Trace:
     [<00000259778c4f90>] dump_stack_lvl+0xc0/0x110
     [<00000259779c844e>] print_deadlock_bug+0x31e/0x330
     [<00000259779c1908>] __lock_acquire+0x16c8/0x32f0
     [<00000259779bffac>] lock_acquire+0x14c/0x350
     [<00000259789643a6>] __mutex_lock_common+0xe6/0x1520
     [<000002597896413c>] mutex_lock_nested+0x3c/0x50
     [<00000259784a07e4>] sriov_disable+0x34/0x140
     [<00000258f7d6dd80>] mlx5_sriov_disable+0x50/0x80 [mlx5_core]
     [<00000258f7d5745e>] remove_one+0x5e/0xf0 [mlx5_core]
     [<00000259784857fc>] pci_device_remove+0x3c/0xa0
     [<000002597851012e>] device_release_driver_internal+0x18e/0x280
     [<000002597847ae22>] pci_stop_bus_device+0x82/0xa0
     [<000002597847afce>] pci_stop_and_remove_bus_device_locked+0x5e/0x80
     [<00000259784972c2>] remove_store+0x72/0x90
     [<0000025977e6661a>] kernfs_fop_write_iter+0x15a/0x200
     [<0000025977d7241c>] vfs_write+0x24c/0x300
     [<0000025977d72696>] ksys_write+0x86/0x110
     [<000002597895b61c>] __do_syscall+0x14c/0x400
     [<000002597896e0ee>] system_call+0x6e/0x90

This alone is not a complete fix as it restores the issue the cited
commit tried to solve. A new fix will be provided as a follow on.

Cc: stable@vger.kernel.org
Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Acked-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/iov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 00784a60ba80bb55ff2790d8f87e15a90c652a24..7de5b18647beb69127ba11234fb9f1dec9b50540 100644
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
2.51.0


