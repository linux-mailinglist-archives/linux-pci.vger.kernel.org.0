Return-Path: <linux-pci+bounces-33172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3706DB15F3A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6864516D70F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F9296161;
	Wed, 30 Jul 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k95QOUG6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368D296153;
	Wed, 30 Jul 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874487; cv=none; b=GxVAjLKeTc4mztrFD+NYK132fn6yS39puRey7XEizZOPUnWX2IzYmN7JFU/ADNBs1hxHppsoRM/P0X1KZib5PszxBo28j4FxkBWryZVoBcOHzwcmxcsHVx4aggiyaFtI6Mb5wtra/nJu3mwp5ufeF6T9LIt2B6BvETaKVoVCvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874487; c=relaxed/simple;
	bh=LKKJcy/2hef69n9Rp5tkx6ZhzjudRLsgjMq/3PE+z+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NiAL0amUc1Aw9l/G8SRlum7rBBnV3iR/V7LxESvx1r4r1cYGbss/vk+DzPWNDhfamrxEeUFnzK3PyfZgRTY1vj6qcKqfUuOWzkgMWrvyReHR94n1E9+kfxFz8IPquuBbJecLcXaCzX8OagJhYXCDsgJTVJkG4Sp5ZOUEKOTZNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k95QOUG6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U2121g008892;
	Wed, 30 Jul 2025 11:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=zGyVCLo/c4+g606PQEsrYKo36Hed
	4SSlTlxJcjpyEs4=; b=k95QOUG6FOwefTIeVQF9Cg3iA5HfvXHQJwxgtvq0ZPa6
	52c8uSZJ+zmvV17jCeglFGcI4Vtzgr1Qz7qA5m7pb9yl46ZUOdEMpGhzFvsMO/r4
	SegjkeKvYitu8NRai1ogi+0aKBS17M/l+lQHqezX7KHPqIRmP8yvVlQMsbtaNfZQ
	/6ugfvfNPz80QYkI87nhDvRfE3JEcfkFIrN9OyJmHd0B2pKbNMFVk1mmg+fUMyIx
	xaxI3MDxurfYnnhtc3d9WNpPqLHaFCDWefR1gcVR16sdWcv0iUKaYAqB+36UXq/4
	4w5jPTvDAWvWAlFvpMy0ewER2ddNC2nyINPL9i09Cw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcg4b1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:21:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56UBD0Yg007753;
	Wed, 30 Jul 2025 11:21:12 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qcg4b1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:21:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6wfXF006242;
	Wed, 30 Jul 2025 11:21:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm6xup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 11:21:11 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56UBLAsf64684484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 11:21:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 808E15805E;
	Wed, 30 Jul 2025 11:21:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A601B5805A;
	Wed, 30 Jul 2025 11:21:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 11:21:07 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 0/2] PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI
 recovery
Date: Wed, 30 Jul 2025 13:20:56 +0200
Message-Id: <20250730-add_err_uevents-v3-0-540b158c070f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgAimgC/2XN3wqCMBTH8VeRXTfZvzbtqveIkLkdc5AzNh2G+
 O6pBEFefn9wPmdGEYKDiC7ZjAIkF13v1+CnDJlW+wdgZ9dGjLAzEVRhbW0FIVQjJPBDxLIprLD
 KACkNWq9eARo37eLtvnbr4tCH9/4g0W39WkwcrEQxxZwXwspaqdLI69P5ccpd3eWm79DmJfYzJ
 ONHg2GCNdfMNAUoSu2/sSzLBzzpMWH2AAAA
X-Change-ID: 20250417-add_err_uevents-6f8d4d7ce09c
To: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=LKKJcy/2hef69n9Rp5tkx6ZhzjudRLsgjMq/3PE+z+k=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDK6GJQup1fM0mW78OK321NReY+LwdIX4s+sKdl0qjpBK
 4nnIOuWjlIWBjEuBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACbCeZLhv5vG6ZhQO3nhy1wH
 UgOOTpis6PGnc92GJedWKfGc1G0JSWb4K35D+tDu1ifFnx/Ozbjh9a7mhdj6asebZil8a5brKz+
 bzA8A
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4MCBTYWx0ZWRfX2B9KUFOq5LmH
 cx8hlPbpk/wqd7aPSd+5f/IXfSaUqmPqHPd3CqoRdJVXlxLcYhvWvCG3bg1X/+HvQwseLOgIp1y
 NHxI81Dut8Yc6Itjbou6CTb7CVtWfcIMV3kk/deM/4MCXvQbmoE7KGlc4pqBBRqFEbFarTDq77S
 KPx1oOZdMU+K826OUbjcN688fxfgiLt2DFJqXVcJjyXO4BA8BPQzTe7tIrA2qfj10cB1WgxS8jd
 73NOYibL042DRE6xQeWdfnE6S3+QZZ6fAAFXF2Cmqog0OOMxd9c2OiTiiyyJgWmGWx0a9bJMs7G
 auJJLKu5Ijs8+LvZSKF/6kM6wjxvWxc+84lWKm5fbzPuh4L7Z4uMMrJUFwUjJiACaISGQWZXUi+
 DtZvwVBwS2rWQfWN0+4dnj5/ce7phy00Wjdd4RGVlpbiayT8xO/qdfhOJ3X0IBslAmwfMOMP
X-Proofpoint-ORIG-GUID: xP2wpEiVdMJ1eZC-yeArKxLmKjieCNx0
X-Authority-Analysis: v=2.4 cv=Lp2Symdc c=1 sm=1 tr=0 ts=688a0029 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=akVQnn9Ajh7wPi5GvloA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5AdcwjzqJX054G3mVfGJ0QoV_2XBbYze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300080

Hi Bjorn, Lukas, Mahesh,

This series adds issuing of uevents during PCI recovery on s390. In
developing this I noticed that pci_uevent_ers() ignores
PCI_ERS_RESULT_NEED_RESET. I think this will result in AER not generating a uevent
at the beginning of recovery if drivers request a reset via the voting
on error_detected() returns. This is fixed in the first patch and relied
upon by the s390 recovery code as it also uses the result of
error_detected() though with one device/driver at a time.

Thanks,
Niklas

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Changes in v3:
- Reworded cover letter
- Rebase on v6.16
- Link to v2: https://lore.kernel.org/r/20250623-add_err_uevents-v2-0-a3a2cf8e711d@linux.ibm.com

Changes in v2:
- Add a patch fixing pci_uevent_ers() mistakenly ignoring PCI_ERS_RESULT_NEED_RESET
- Use the result of error_detected() for initial pci_uevent_ers()
- Drop fixes tag in s390 patch
- Rebase and re-test on current master
- Link to v1: https://lore.kernel.org/r/20250424-add_err_uevents-v1-1-3384d6b779c6@linux.ibm.com

---
Niklas Schnelle (2):
      PCI/AER: Fix missing uevent on recovery when a reset is requested
      PCI/ERR: s390/pci: Use pci_uevent_ers() in PCI recovery

 arch/s390/pci/pci_event.c | 3 +++
 drivers/pci/pci-driver.c  | 3 ++-
 include/linux/pci.h       | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250417-add_err_uevents-6f8d4d7ce09c

Best regards,
-- 
Niklas Schnelle


