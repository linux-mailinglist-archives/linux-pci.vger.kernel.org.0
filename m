Return-Path: <linux-pci+bounces-43150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD10CC550B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE363300819B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4C2D9EC4;
	Tue, 16 Dec 2025 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tsk6C8uI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB22C3255;
	Tue, 16 Dec 2025 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923286; cv=none; b=pAF4HcW8lVqRFdDyY4PeIX6AgMvjGLUa4vwKPbjVmsn1BWCq3RF5CLvwKu5azjhf0rL8PCu9oJda2G5IJDonbVphUT60+WmqTsxy401MzXoYYePrvBB4xi5hn18R99DznFm7Xme9Iq7Q2Z4qSMdcv3bKbQhNAGZVQ0aZZj4hFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923286; c=relaxed/simple;
	bh=7ywVqBQccA460h1DdSFGJku9DTN1iuLiBtjEMP6Jw+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rptVGdvMCXtPAHnXGWzXsOoQ5mBhqVvtcvad0PWSocOiyiePvyXTAqxtMTqIw2hTqCRZ6PKOT5RADL53p8Dt800NfTduPCH1+1e+3srFydNua6O3/T5XMfkP5cggjz2KzP4tUa+Z5cGFsbB/HdrU7yzMYcArfBlNBN3tgTX8J7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tsk6C8uI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGM6fR2007666;
	Tue, 16 Dec 2025 22:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=sZ3Ct+DEdhuisfXKgLki7eA3mrbD
	EYpTQaKpU6dJTHM=; b=Tsk6C8uIrr27LSdxh9/2uHp5z39/ixHNVrxi3mqaKVcE
	jm7ZlFrjp8h3HmdGo9T4aJUZxCCNbqeVrZEeSeSVPYu6aAQK1bU+rsljy4GOjJsM
	gb+dPP+r53qq/t8NH7CJQP0ykFiESQ6zapt5WIk0RkQiwrP3xXLS+hRRiOcCa0dv
	88MINcT7rjsCHxUUSv81v/f7UFPi4ChqlV2Dzw6fXo75foliREuRSEbag4O6AgBA
	xrEgZuaEcogxSy5Nu82rcNYDJM+kYjYGiDOEmMfS0EEjbfWpNIaKgH0tGn0l4hf/
	OdVtGtqFeM5ljQOn2OicE4us6LuvJTezz3DUBFaeXQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq1cvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 22:14:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGM2H8C002856;
	Tue, 16 Dec 2025 22:14:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfn7196-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 22:14:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGMEdlj44695950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 22:14:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1933B5805B;
	Tue, 16 Dec 2025 22:14:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FAB958055;
	Tue, 16 Dec 2025 22:14:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 22:14:36 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v3 0/2] PCI/IOV: Fix deadlock when removing PF with enabled
 SR-IOV
Date: Tue, 16 Dec 2025 23:14:01 +0100
Message-Id: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnZQWkC/23OTQqDMBAF4KtI1o0k0fjTVe9RikSd1KFqSmKDR
 bx7oxQKxeUb5n0zC3FgERw5Rwux4NGhGUNIThFpOjXegWIbMhFMSM5EScMS2KlyFo2vetM8qAK
 dSpnrJGOahN7TgsZ5N6+3kDt0k7Hv/YTn2/SrJexA85wymjNdCNVCKjJ96XF8zTHWQ9yYgWyiF
 z+F86OfvAgKKMmg5lDoMvtX1nX9ALZ50IL8AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=7ywVqBQccA460h1DdSFGJku9DTN1iuLiBtjEMP6Jw+Y=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDIdb546FvnUz8LC/guHSp+UWIfffs7L7149SfIzqJNNL
 LX/fEm3o5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgIk05jEy7Bb5mKceIXFB3vv4
 1qPeJyKvfjg9g9Mi52boyc+mSU+WWTH8U7S4nszElvLp989U+92f00w9mFZOdyyf+1rmM6OM84w
 ZXAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfXzoo3OXfvBlzh
 2MnbwWkMs49ube3BQ8mTJgj2bLoSK55OVGcj62T7Vmwrd/cvYe/yKF1QOkN1RI9l5VtfwwIfoIW
 7hE/WNVkdjnf5BFa7Jm3jFeNBGk3tg7rn6rFGEXU8MLNjxHLw4M6NFnLNgRcM8jGsPCna+SlShX
 luq7kGqD1WutKgNYlbbiqGwmfYQnFNKBJWON56zxXa/TfVr6erI6ujfdIXuQ+AVsBE+QJPKR3/q
 +c6wcNCz3gMc23TvgaLJrqRetSYIQ1DwIWCMv7CTO2gUbfuCSwiMIoR83OS8rDHDZd4+2/lHAtC
 oi7vSPFddjzWPMhgJfozznseRdrRuVo7+ddpjhCyiIWI0K959m638d369NUVKkWkcefAQOJcJiK
 YbC5oXxLVkmDNBFqVe66DQULVyl0Wg==
X-Proofpoint-GUID: -9udkBPMkCMQZavybLW9BE71O3YLuzvJ
X-Proofpoint-ORIG-GUID: -9udkBPMkCMQZavybLW9BE71O3YLuzvJ
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=6941d9d1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=_x1QwDJ1od2C2yyCq6YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001

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
Changes in v3:
- Rebased on v6.19-rc1, also verified issue is still there and the fix
  still works
- Added more of the lockdep splat for better context
- Link to v2: https://lore.kernel.org/r/20251119-revert_sriov_lock-v2-0-ea50eb1e8f96@linux.ibm.com

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
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251029-revert_sriov_lock-aef4557f360f

Best regards,
-- 
Niklas Schnelle


