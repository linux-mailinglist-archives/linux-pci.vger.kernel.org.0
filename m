Return-Path: <linux-pci+bounces-39792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB70FC1F875
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8234A4EA58C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4333FE00;
	Thu, 30 Oct 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y8YHD7lI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3243557FD;
	Thu, 30 Oct 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819980; cv=none; b=dwl02D1m6u/wClGfr6nrcyIVWdD3tw/wQ4jmYfDVPi/yx9W45NeGq95FLBPNdOK6PlpX08dddKFI2ennEgaUUawSggZotRtBQzS9gAka1PO52GFCADPLdzhRGlUjfs0OZ/uT2EYA4368RVqfn6RsWQuPG725L0JlP3fTlk9BPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819980; c=relaxed/simple;
	bh=hOOf6cXgc5T9zpXJADydtn2FEPtwwciHF8qIdnrdK18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZmPxG20Hd21Y2cKFKD+jl4KPGKEvH1ZzL8cVkFs66u2wpXNVaqRV4WYdFozEQZVkUiCriAHyWcuky3aKFdUGmu91bnWgFdIbpj8YiN7niAa9tlV1KyCNhUXu6yk/u2A35TlqpIjA5+Yi//kh3BRigGMXFk/iW2Wjumfwcq0vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y8YHD7lI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TNGUk3025645;
	Thu, 30 Oct 2025 10:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JuKh8j
	hDl3jT3OEfhMEsr6AL7VMBfb5O0Vu7kn8sbMw=; b=Y8YHD7lIjRfZqcL8qVJez6
	hgWgLZRQWKtc1SH8ftyQFtYQxx7wMYEQ99bScwcygn3caa5Yvu+lNu1N4L5uVdCz
	RFvq9qqXnHeubqkKPqGlxFfQHe9XSdoOx0qamiGY4ZOQ/joX41SSlsqjntFSZO3q
	DBqoUdMx92cO9c/yRyXqMa6TfHb43RzAWj+sJDtWWrrActft9h0RfADzKhyUMrvd
	ukig1S57WvkYyInRbI7li8c4n5PPwBPOcVzqLn3/rduhZS9S4ILOkeU4AM7OYEmb
	gJvksSPMYcjEdz/b3Yv9M7IrruTz7dubMI1pG6m6r0H02krVy+KviKlyvOKPKopQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acqryn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 10:26:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U9AEdD018758;
	Thu, 30 Oct 2025 10:26:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwg52f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 10:26:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UAQE1314680606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 10:26:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01D3D5805C;
	Thu, 30 Oct 2025 10:26:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D355805B;
	Thu, 30 Oct 2025 10:26:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 10:26:11 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Thu, 30 Oct 2025 11:26:01 +0100
Subject: [PATCH 1/2] Revert "PCI/IOV: Add PCI rescan-remove locking when
 enabling/disabling SR-IOV"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-revert_sriov_lock-v1-1-70f82ade426f@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=hOOf6cXgc5T9zpXJADydtn2FEPtwwciHF8qIdnrdK18=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKZbe1TNZm+zLxo/9/qj5KusXSm/6EbIVNYJITdfTW3v
 3h590hqRykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABNRjWdkeJ9V8+v7ab2Xx2cc
 rm/IeTCtwyqwTXU624GutTUGtZfVZzEyTJ7ZPf9JXvtC7fx1/KeSJ2oGB1W/5pCfGLzr3/VlJz4
 pMQIA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=69033d48 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=NwnTm4zaWNGWObc0R5cA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: S43Tko-NybwzGGxP7clNNIOqttcBsBjS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX5DsuGeTAq+5Q
 7gulDgXtynEKNgAcXogSlf9JNLVsHb5wWDMNBeuiIcJ8xJTbFG1Q0KRICnz1iHam6nRtL+VptfY
 3rn8z7G5BLkNtOpNIpb8xz4ih1U7AV2bQiHQr1xkSe89pcb/vmET6D+1FWYpr7cCpr2M5xoVQe3
 PfmuGIFV6tAJGbygKgShkIfwMAYcTOb9Kh5rrwll0yG+CPiZFH2i5BlCFOPX4+5Jqhy7Gk+U63f
 XUCCqcvXxcDTH4eky6BaBxagxtD0RqhNyQ0fKFMWu0tKv7d2X7+2tfVcVZR4vMdFHoEyz3jq3Ac
 c1DePguxeejLk1FPgoPYEpUfPURVv+vLz7wcMITABjYYHzgaPaMHG1zStkfaFEAoKXxdMULSLs6
 Iq2fuLli0yIxQ1loVfqUIiCsUREvEg==
X-Proofpoint-GUID: S43Tko-NybwzGGxP7clNNIOqttcBsBjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

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


