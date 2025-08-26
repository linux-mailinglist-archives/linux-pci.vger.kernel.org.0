Return-Path: <linux-pci+bounces-34727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E6B357A4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659017A2276
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE42FCC1D;
	Tue, 26 Aug 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MVo52kT+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58D2227E82;
	Tue, 26 Aug 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198350; cv=none; b=eSCsjOMXhrvXldi8YC1KUbWVh5PF8yNj3qhigG+ExIJp8tlvKcP8CqhHvdEVaoG1wueLt0U4MW+KM19bEPZBs4U0KaFPJiYrztTgy/IPvc6JId/JFX0YFt+yl8avFY8vteABH0zmsM913tExiKrRjZe6POaeUSaciWYGk9hDu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198350; c=relaxed/simple;
	bh=kKwIM0qfuSXaYJeNJEitvocvG1MqQLEWfj+7+8qhWQI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XM0uAQKyQ3gmAZXImuC8BFXH/52I2JS4X18b5CFeD/TdqEptuIKRDQNwUAJbEjbrX/LLEBHNJwknlJOBfWW6IxiKlgWlTEiMHl5qi/nFKBFy0FY/ya+CnSwb51kuQqxi0zuHoM3/DdtQFFZU1tFUSEXkhpWApgv/JZFKzDzI5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MVo52kT+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q6Y19x030401;
	Tue, 26 Aug 2025 08:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=pxNEr13XPjiihixnw8UbtwCNl4xC
	vAKmEXomvXdX9Do=; b=MVo52kT+z0Kcp70TJKFhEtjGi1ZFLmYs0vIsJovINLMC
	EZtK3M0MmWM9EhERVCGBpJPKg2pO7EsLJuHdBqoiosyVipfKyJgoIwlrK4/RhRFo
	UF+2cotV5gWwhKOXA2DXLgPCh0yBakoz7UwoZGe0ndcyqVp2Xs+cjqtdh/DMn2tm
	HyeQ+3gsElGpMknQAwH+eQrvGplFnS/7Iq7av97rwtsXo/64gIvRwgNGkNXW3+/O
	Teoo2eMDQUv5ik4cBXOZoRtRIMmXtjjaqWoN0xvMkdzUqK8zmGB1slA0m6+ShP1j
	+Mp15gWGi3a+vXxXFDMLByyqy40ZYKiFk+OGYscZcQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48s7rvrjvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:52:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q67ViV007813;
	Tue, 26 Aug 2025 08:52:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyua4td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:52:24 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57Q8qMcn21824058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 08:52:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A5758060;
	Tue, 26 Aug 2025 08:52:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A31A75803F;
	Tue, 26 Aug 2025 08:52:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Aug 2025 08:52:20 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/2] PCI/IOV: Add missing PCI rescan-remove locking when
 enabling/disabling SR-IOV
Date: Tue, 26 Aug 2025 10:52:07 +0200
Message-Id: <20250826-pci_fix_sriov_disable-v1-0-2d0bc938f2a3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALd1rWgC/3XNUQuCMBDA8a8Se26ynS1mT32PCNHtzAN1stUwx
 O/eFIIIfPwfd7+bWUBPGNjlMDOPkQK5IYU8Hphpq+GBnGxqBgKU0CD5aKhsaCqDJxdLS6GqO+R
 KQQOF0QDWsnQ7ekxLm3u7p24pPJ1/b2+iXKdfEXbEKLngCmtjhCgqrfNrR8NryqjuM+N6tqoRf
 iW1J0GSGp3L5mylATz9S8uyfADJxFtjCAEAAA==
X-Change-ID: 20250821-pci_fix_sriov_disable-552f29c822dd
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=kKwIM0qfuSXaYJeNJEitvocvG1MqQLEWfj+7+8qhWQI=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDLWlh52fML8XSr7mInHGfcN2lHLvzHf2NX029X0LZP9C
 9ZVNWxJHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEwkdjHD//o/2pP5XnHt02l6
 3yRXfJuLV1c1qOB9gv0LvsuvPSU6/RgZZq1KXnOE0Wd/IcdHD/utiTevpsv5bDT8r+5XteRQU8x
 /PgA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eIxz7gnMLmLd5iM6FZTVBH9KEiiKK4jM
X-Authority-Analysis: v=2.4 cv=fbCty1QF c=1 sm=1 tr=0 ts=68ad75c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=QI5NUAGLTwmoeOVYmH0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eIxz7gnMLmLd5iM6FZTVBH9KEiiKK4jM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA1NSBTYWx0ZWRfX+opY8QYHmyNf
 NZjrebg7/yjMpYoyG8zLnub4J+iMDJ42l86A84AvsJGyie2xigUhPMvVIZ5Tpip8N8e9vjFQgA4
 QK6wj1xFjkqkHpxDaOR+zxcxBsN6tqzCyZxPEVKlFZCGzHyeb2urTCGVFWgnj7g+bvwNe+QZggV
 yIR1fNYBX0gS5B2KcvkQ0moJKI80uP8s4/dsbF5+WWR9LstpoCrrOIT3NMOTsWrq7VMNY3GiJpL
 fbfAooREfYqJMDkTvVTxoWNICLZQF4LuhDLnpSzGS7fLlwp0NQ6sJR0o8HbNPADIE0Cy+TD9Kgk
 610enlzoZZqw6B/eMpr8jdYRuME/rXWn9EpsMirZdcFf7OY1qbtvu7YrD62EfHNAfhL0Dd8JLI1
 axIOFtJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260055

Hi Bjorn, Hi Lukas,

This series fixes missing PCI rescan-remove locking in sriov_disable()
and sriov_enable() the former of which was observed to cause a double
remove / list corruption on s390. The first patch is the fix itself and
gives more details while the second patch is an optional proposal to add
a lockdep assertion to pci_stop_and_remove_bus_device() to catch missing
rescan-remove locking more easily in the future. If applied without the
first patch disabling SR-IOV via "echo 0 > /sys/bus/pci/devices/<dev>
/sriov_numvfs" triggers the lockdep assertion. I haven't found an easy
way to trigger the assertion in the sriov_enable() case but I checked
callers.

Also since the sriov_add_vfs() path is not excercised on s390 due to
pdev->no_vf_scan I did some basic testing on an x86 test system with an
SR-IOV capable ConnectX-6 DX NIC.

Thanks,
Niklas

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Niklas Schnelle (2):
      PCI/IOV: Add missing PCI rescan-remove locking when enabling/disabling SR-IOV
      PCI: Add lockdep assertion in pci_stop_and_remove_bus_device()

 drivers/pci/iov.c    | 5 +++++
 drivers/pci/pci.h    | 2 ++
 drivers/pci/probe.c  | 2 +-
 drivers/pci/remove.c | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250821-pci_fix_sriov_disable-552f29c822dd

Best regards,
-- 
Niklas Schnelle


