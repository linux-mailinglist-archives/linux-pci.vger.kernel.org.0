Return-Path: <linux-pci+bounces-41609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFACC6E8B8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A263F3A036E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A435BDC1;
	Wed, 19 Nov 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gpjG0Cyn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5032D0ED;
	Wed, 19 Nov 2025 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555734; cv=none; b=GyHexDhucBJaO2DNXeBOWsbPX37AiFvmpIO8ffUx+LvynU7cwY8bK9MU4YWvpdTYAIZ2K1ylQ7jlgICYl8+x0UPhfzc3MfYyS5MKy78QdsVXt6ABtzPFeKhoxijvTNZCPFxbmwXW83lVXpO4jYdePuQdWst3qN2+Or/wLu95GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555734; c=relaxed/simple;
	bh=wNMXseu+Mh4CXbDfHxACCQ1T1j8+3/2EVRgmLLZns1c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hAlIVNSKyObr9buFvoj0SGOAjJsJz1hL8MwY6CcGgp2HTPvxh7VSkWB3+qjX/uZFcfwFuonD5SlfSelc53PBlx0ZRQYM/FbVil63IGsKsozT6wh5Bfyf7UV5ipKvO/gbwdi4jCuOB8BScFmqZY3p3xvdQWR8B6CItsZO2dQ5YKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gpjG0Cyn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8wCKM005971;
	Wed, 19 Nov 2025 12:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=kjV1+s3lsg5fuyqYOMllNghydBN1
	0Wzgk35QPuOOXCw=; b=gpjG0CynWyl8eWUuVyf+qP4TDNJ14D1gvwVgUoQ9avwH
	3c2E8mWuJKz0e1xT+o1c8uEOyjePCaSRS16oWjc+LVFEusvNM61QaqGBADjBUxfg
	NrI8DzUHThJ17a1wsrShoymEYCF9ejywJHlSHx/x24y9+RPSyu6dyGisvS1PtRk+
	CWmPqaH2ipCZtvKE1grinBxYBftQT2FBMOwFgTPVCKzJvxKFvO25DjP4iwirWVTT
	DDquXag+GIBEgoUSaYunkgSMdfBahcak0vsJqKRIULrisWVOGjLADzI5vwh88OnW
	jGQ9yeqV1FtMqCI7eewGz025X9j8uHXZSu90Ue0dWw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsqmjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 12:35:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBY6Pw022347;
	Wed, 19 Nov 2025 12:35:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4un0kxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 12:35:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AJCZ27x31982300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:35:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3CEA58063;
	Wed, 19 Nov 2025 12:35:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBB9758056;
	Wed, 19 Nov 2025 12:34:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Nov 2025 12:34:59 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v2 0/2] PCI/IOV: Fix deadlock when removing PF with enabled
 SR-IOV
Date: Wed, 19 Nov 2025 13:34:50 +0100
Message-Id: <20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGq5HWkC/22NQQ6CMBREr0L+2pK2UFBX3sMQUsuv/AjUtNhgC
 He3Epcu32TmzQoBPWGAc7aCx0iB3JRAHjIwvZ7uyKhLDJJLJbg8sVRCP7fBk4vt4MyDabSlUrU
 tKm4h7Z4eLS2789ok7inMzr/3iyi+6c9W8D+2KBhnNbdHqTssZWUvA02vJafbmBs3QrNt2wfCJ
 tAytgAAAA==
X-Change-ID: 20251029-revert_sriov_lock-aef4557f360f
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=wNMXseu+Mh4CXbDfHxACCQ1T1j8+3/2EVRgmLLZns1c=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDJldxYyP8yz+axUa7Fmn9KWVPO2siaTzT/5PihNOxmYJ
 dCXdlOpo5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgInU9jD8U56Rkv4mT+PqzYN/
 l7eW7wnT5Z26/k+mxp0ia46FM94bKTL84X76Ycv+OwXdLsaZtg85vvestgjLvvOqY94knyc5nh9
 6uAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: piOyP0L7fU4FH4W8BVRvj0DRCuJcvqWJ
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691db978 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=GF2AMZyKLQVskBySm0IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: piOyP0L7fU4FH4W8BVRvj0DRCuJcvqWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX2E3Wauk8bwsF
 l1DIrvCUEpBXvyqbejkUgekV/6yzbe5DmrAgBAw+di+mMtOJmiXeLgdVk9566FEu+NjQiQ5zDqd
 +qc2FDUlBVcp8+mc+GylKFeMSJaKNOLmJLVdhlMk55KGZrQPhZc4p1lEjmYHkaDZBa7itzMH9eR
 m0DJCJ7ollMen2jYmvyUMzLQf5cxLLhaYyXX/RJa6K+O5p88CJ7vDdZdovH9lF2K+jZY+abmfpe
 WLYdgsJRll3G25e2I6w3LOB4iw9uA+UjYElvNO7c/4lVeEggqjEcBYOw3KUCbxUMCX6r9m8zIvh
 SNx5mtlKq0htcT/jC2YLjm0ugLvxTPbVCa56vCM3V5rbDldCP0bs+kctTwuBCd//PhR3T3sTFN5
 R9PPKIMKT+VwDUV4QUeryUmU/5MYmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Hi Bjorn,

Doing additional testing for a distribution backport of commit
05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV") Benjamin found a hang with s390's
recover attribute. Further investigation showed this to be a deadlock by
recursively trying to take pci_rescan_remove lock when removing a PF
with enabled SR-IOV.

The issue can be reproduced on both s390 and x86_64 with:

    $ echo <NUM> > /sys/bus/pci/devices/<pf>/sriov_numvfs
    $ echo 1 > /sys/bus/pci/devices/<pf>/remove

As this seems worse than the original, hard to hit, race fixed by the
cited commit I think we first want to revert the broken fix.

Following that patch 2 attempts to fix the original issue by taking the
PCI rescan/remove lock directly before calling into the driver's
sriov_configure() callback enforcing the rule that this should only
be called with the pci_rescan_remove_lock held.

Thanks,
Niklas

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v2:
- Collected R-b from Benjamin
- Link to v1: https://lore.kernel.org/r/20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com

---
Niklas Schnelle (2):
      Revert "PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV"
      PCI/IOV: Fix race between SR-IOV enable/disable and hotplug

 drivers/pci/iov.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251029-revert_sriov_lock-aef4557f360f

Best regards,
-- 
Niklas Schnelle


