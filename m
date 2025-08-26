Return-Path: <linux-pci+bounces-34728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A12B357A6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103BC1667A6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BE32FDC53;
	Tue, 26 Aug 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YIdmmi/a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C2E9460;
	Tue, 26 Aug 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198351; cv=none; b=uW/W7UJsDxKZ25nxhMT0ISiMV51sLZ8gGYqwVGRBls1evYbvwl5DfCTpNZdhp+aiU/M14yZxc9RXO4BP+oLrupMxwLLU+Yse1HvK/KaUraq+y/t7e+AL3K022F3F3K0rr8KcSAbHpD3ijws3pDFpxF782yHK3x+Uu5m3MY1QGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198351; c=relaxed/simple;
	bh=W4bCLgoStEFcqnDMx0gbAyzGSOGiqNprQuqoVObHW7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=au1XUhkc7qO+Qma59tnq6CaS9AfkaZCbSV++9AQOexxlmn9QGIHapraeD7afHrvsLQ2r1BUzNpmN1hddo/dIt9SZRNbyvW2VoDuGxiohleQD9rEZE8g7sHd4YlJP2AkyTF5WZQ35Dww2lnsPX09c1NGZSU2nW4cpfnC7SI5oveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YIdmmi/a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8RjuG012068;
	Tue, 26 Aug 2025 08:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jJCOXY
	APV45TvwbHGQuJ+HTAIoe5c7etiYC72/mGAX4=; b=YIdmmi/aEqToZUPC1+CFQ2
	wKY3PK2GpAVLLVKW+VHbxVkjzHB4WhFNrpPopCTjwt2IICGf2SoBaRKu2TSsYhDg
	oYAwu4pB9wG0bLlpmmTmjAgN2ZPB9BbWjtCpZxnR8gNK6wNasw2vVObORJHwSie+
	dO+JKP26eMrT0UDvmT/lKktsIPB0MkjiTmsfYAboEoBPE2KzgX4oEr7rWfm+9E1Y
	1XuKllfnd1enu2eDWUNdNwZfGEgCF5CrIG/PW8lKmtb1Ic6WXkcmZ7PRBWFOfp2N
	zS6Zz6Ebf+XT+I/JIZxAAd906MRHynoepbdsECbeSlfTVQgzhPazJVLAsuWOwNdA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q42hwjdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:52:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q6aamr007459;
	Tue, 26 Aug 2025 08:52:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyua4te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:52:25 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57Q8qOPY9634978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 08:52:24 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C686758061;
	Tue, 26 Aug 2025 08:52:24 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D205658064;
	Tue, 26 Aug 2025 08:52:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 08:52:22 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 26 Aug 2025 10:52:08 +0200
Subject: [PATCH 1/2] PCI/IOV: Add missing PCI rescan-remove locking when
 enabling/disabling SR-IOV
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pci_fix_sriov_disable-v1-1-2d0bc938f2a3@linux.ibm.com>
References: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
In-Reply-To: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4099;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=W4bCLgoStEFcqnDMx0gbAyzGSOGiqNprQuqoVObHW7U=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDLWlh6JtFy57toGnh7502rTvpqVnLyfsW6VduHrNenX3
 sqo8ZxR7ihlYRDjYpAVU2RZ1OXst65giumeoP4OmDmsTCBDGLg4BWAiql2MDPuS6o1eSxSoizGv
 5lv9eY7e9Y5DeTY2G44nsMnwNyl+DGT4p/Aqd9faizOKM/9sy58Wtid7SfBcycXrcs8qHb37TUw
 0jQcA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMCBTYWx0ZWRfX5Dr4XsOoUNyP
 CLGQNXo16BuaO4hsCGUSDOpIpg1upl7A6eAjoCy8Vf1yBPk79cAusmUoYWPoRqktsNUNTkS2VAJ
 +wlnhICC9yAChT53uVHOlfqaCrU7QNtBxvvzSo+R7bzFW/8yX9PtF4trnnfbd7Lng6mg1cwmJ3R
 Rg6hkZOBsOLORbntDJxxZ0pfYZMKEEpjCeIa7j1JLNK5scyYwbx+jFI+6I7VV5mko02l5upjxu+
 49/KUL4LfSmQyJkDINeckn6u1Cp9Myo8tpvEJ2c/hxqHZjKNBRpK8Bz9d4WW/MM/uSG1E7MR+J1
 FEi+BU2MPtiGndNAzXgz4hwA3YjtF4B0BOT7R4kLv0bnoYtJ9bXitp2R3uDmfu2RKMum3QDkKyB
 DQu+n/Rl
X-Proofpoint-ORIG-GUID: 94EpVCclAiGK--i9CkN3xU1dRWwMGuhQ
X-Proofpoint-GUID: 94EpVCclAiGK--i9CkN3xU1dRWwMGuhQ
X-Authority-Analysis: v=2.4 cv=evffzppX c=1 sm=1 tr=0 ts=68ad75ca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=DFEmq__SC7PSPvLm2XgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230010

Before disabling SR-IOV via config space accesses to the parent PF,
sriov_disable() first removes the PCI devices representing the VFs.

Since commit 9d16947b7583 ("PCI: Add global pci_lock_rescan_remove()")
such removal operations are serialized against concurrent remove and
rescan using the pci_rescan_remove_lock. No such locking was ever added
in sriov_disable() however. In particular when commit 18f9e9d150fc
("PCI/IOV: Factor out sriov_add_vfs()") factored out the PCI device
removal into sriov_del_vfs() there was still no locking around the
pci_iov_remove_virtfn() calls.

On s390 the lack of serialization in sriov_disable() may cause double
remove and list corruption with the below (amended) trace being observed:

 PSW:  0704c00180000000 0000000c914e4b38 (klist_put+56)
 GPRS: 000003800313fb48 0000000000000000 0000000100000001 0000000000000001
       00000000f9b520a8 0000000000000000 0000000000002fbd 00000000f4cc9480
       0000000000000001 0000000000000000 0000000000000000 0000000180692828
       00000000818e8000 000003800313fe2c 000003800313fb20 000003800313fad8
 #0 [3800313fb20] device_del at c9158ad5c
 #1 [3800313fb88] pci_remove_bus_device at c915105ba
 #2 [3800313fbd0] pci_iov_remove_virtfn at c9152f198
 #3 [3800313fc28] zpci_iov_remove_virtfn at c90fb67c0
 #4 [3800313fc60] zpci_bus_remove_device at c90fb6104
 #5 [3800313fca0] __zpci_event_availability at c90fb3dca
 #6 [3800313fd08] chsc_process_sei_nt0 at c918fe4a2
 #7 [3800313fd60] crw_collect_info at c91905822
 #8 [3800313fe10] kthread at c90feb390
 #9 [3800313fe68] __ret_from_fork at c90f6aa64
 #10 [3800313fe98] ret_from_fork at c9194f3f2.

This is because in addition to sriov_disable() removing the VFs, the
platform also generates hot-unplug events for the VFs. This being
the reverse operation to the hotplug events generated by sriov_enable()
and handled via pdev->no_vf_scan. And while the event processing takes
pci_rescan_remove_lock and checks whether the struct pci_dev still
exists, the lack of synchronization makes this checking racy.

Other races may also be possible of course though given that this lack
of locking persisted so long obversable races seem very rare. Even on
s390 the list corruption was only observed with certain devices since
the platform events are only triggered by the config accesses that come
after the removal, so as long as the removal finnished synchronously
they would not race. Either way the locking is missing so fix this by
adding it to the sriov_del_vfs() helper.

Just lik PCI rescan-remove locking is also missing in sriov_add_vfs()
including for the error case where pci_stop_ad_remove_bus_device() is
called without the PCI rescan-remove lock being held. Even in the non
error case adding new PCI devices and busses should be serialized via
the PCI rescan-remove lock. Add the necessary locking.

Cc: stable@vger.kernel.org
Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/iov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ac4375954c9479b5f4a0e666b5215094fdaeefc2..77dee43b785838d215b58db2d22088e9346e0583 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -629,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	if (dev->no_vf_scan)
 		return 0;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove();
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 
 	return rc;
 }
@@ -762,8 +765,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
 	struct pci_sriov *iov = dev->sriov;
 	int i;
 
+	pci_lock_rescan_remove();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove();
 }
 
 static void sriov_disable(struct pci_dev *dev)

-- 
2.48.1


