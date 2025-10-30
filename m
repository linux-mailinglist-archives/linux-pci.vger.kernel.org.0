Return-Path: <linux-pci+bounces-39791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB470C1F882
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92F11883EDF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881353557E7;
	Thu, 30 Oct 2025 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S96Q/dHW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD2354AFE;
	Thu, 30 Oct 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819978; cv=none; b=A+GKMqqWE/c3jYoc16KoQfIX2IGOuvzXjQYovq3IAGI7GAK2ZxmtcHLW9gS0/QCZtT+vPg+rHZ/WIXFZx393G5eIKBfvJIEJecc2IuOafOZkuNIu+5++6iSqQN1PnD8hSBN+JI5LgVxBZQpJdirWAddcu54GKvRX4jpP2LO3JNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819978; c=relaxed/simple;
	bh=nnEcLxc7WS5uDrksL0CuxOnMtBJh5tKq7tMmpq2/ypU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TU1iUpXgjA/PdsTJLQBApWtDBP5Kt5WC8fp7bQjpBAo4x7E0sun652WkOvT1heck4A2HsBi+SWhhwnKE5KEaBrUn54SbRPKl9dvVspEGfWM4xAGyKZQukdBLdc3GNvXT3OeoFU+oTWr1oj623gPiFNcdvG/STRnqtl/IKSB87pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S96Q/dHW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TNbMn7014529;
	Thu, 30 Oct 2025 10:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=boZs1U2tmQJIVKzW90ZOwHQtX6Uw
	hQnDTbJ0UzA57Bg=; b=S96Q/dHWrE9ukREvrPzBUTIT6+EoiNad7sfczMBycx7d
	5FcAW0H1/F8l9BDhZUXapMBMLad+rHTDqqxub3QsNttovMVxDakE0V5rLRR2F1JV
	AliJSpwJmULXcvalrKAmfnVcIwHzjgk/KcfplXtjI6991YszbOMAkIrI8bZyYiGp
	73YQAq+yTsYaQIhxELgnXWWo+0gIrDqDMyHpRYckofnPKHfglbEP12d6sjhrxhx+
	vA6LaqgaRwTDId0y3a/7CdDhPBNK8wRXudFCnJPzlZxleBkNI1JvFavuGpI8vjzw
	cKxJKppGvSxM/g4IrL35i9j+Mb1O8kvC//6SlcNMng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agqkj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 10:26:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U9aihp027443;
	Thu, 30 Oct 2025 10:26:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33w2r5ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 10:26:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59UAQBEZ23855678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 10:26:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41D8D58058;
	Thu, 30 Oct 2025 10:26:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91315805C;
	Thu, 30 Oct 2025 10:26:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 10:26:08 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/2] PCI/IOV: Fix deadlock when removing PF with enabled
 SR-IOV
Date: Thu, 30 Oct 2025 11:26:00 +0100
Message-Id: <20251030-revert_sriov_lock-v1-0-70f82ade426f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADg9A2kC/x2MQQqAIBAAvxJ7TjDLor4SEVJrLYXGGhKEf086D
 szMCwGZMMBQvMAYKZB3GaqygGU3bkNBa2ZQUulKql5kCfmeA5OP8+mXQxi0jdadrVtpIXcXo6X
 nf45TSh+gJzu3YwAAAA==
X-Change-ID: 20251029-revert_sriov_lock-aef4557f360f
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=nnEcLxc7WS5uDrksL0CuxOnMtBJh5tKq7tMmpq2/ypU=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKZbe3W96c3v5ao3tjwNTH2yH5HmevMnEpr1ms9O9zRZ
 XnI2oylo5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgInUlzAy3JoiIZRv9VTrxfN1
 51c2Sz3aF/IxYcOSe4GpdR1S12oaghn+J7JP3mdnv33/2XVbfho/P2vV+e1Pn6xaqUCgd6xq2Us
 PdgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=69033d45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=AR3_QPHPkBXiQznOqwYA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Kkeh_2jcdeKHNxGQ4hpTLihXGNOVkVpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX/8bmoSFD1x6I
 4wka/AjssCYzl/dGpyszR5/G7STWqPP3THPIQPoq77GezMh2PHo2K4O36xo9s4VD6s8Th++FJk3
 +cTZ/4Ffi3Mbc8Gl8gqyLMhq7dILKeHlKKmV3B7xZWkMNc753FsmqrNP+94ltI5/ayKxTPwNrOe
 QIyhy3WbaxQQ5plKc83cU54HX7x+fklU2YSmLsT7tTYcydtQ7b0FGe4782pGOhvIIVY6D7LwHhZ
 OCmbbEBY0Go414dkMU5aq3mys4mwdtkEB/gFp3NFEUhy/G2+t073W3vytOAEYbWLBxv/kq+dubM
 6UhheFFzc2qXZx+00qD6O3c1mL2K6Yk3HLlifcIweA1OOOsSZ3hL35CeeDd0sAkKU7ZbEC3LFC5
 r8yPEQk+d/eDx3e1odIEtuJY5SXj2g==
X-Proofpoint-GUID: Kkeh_2jcdeKHNxGQ4hpTLihXGNOVkVpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

Hi Bjorn, Hi Lukas,

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
sriov_configure() callback establishing the rule that this should only
be called with the pci_rescan_remove_lock held.

Thanks,
Niklas

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
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


