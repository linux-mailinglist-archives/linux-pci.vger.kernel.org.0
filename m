Return-Path: <linux-pci+bounces-38802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BDBF3187
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 21:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D342C1882596
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EA52D6400;
	Mon, 20 Oct 2025 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P3lBLcZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941792D0283;
	Mon, 20 Oct 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986934; cv=none; b=H8ZwfgTCpC4xmb5uCPJj2sAIcLvrEkZW+HQ/8QC2u2T36v8K4EGxgwTfp3K744CJqzQSWBAlzoTUo42hXECYVBdrKdpOqcZbiOErHz7mxq5L2weVpYUKzhYBWWoUQfFRklW1nmSUOs6RiY3tTrmevcqD14ivK9kpopXkUD8ivqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986934; c=relaxed/simple;
	bh=R51+k1f9n0udGWUacA5No4LOqnlElXDvkTC1tLyWQig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYKm9tIaCDw9otBvRt+J8+kMABmBxFcXxt7BxJrcg603TeaU6LkIiJXU3y1zw7/z7Yt4YBjZuuvCVUAHo++HC9AHDVq23jt53vlrOyDqmj2djMy3QihaGuqGibjPhSCmUdkbpaRadb9MiaSksGlfbFdxI5JjSA9FbJE0mYpI1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P3lBLcZ5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KGdV3j031143;
	Mon, 20 Oct 2025 19:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ckYCcYUoR54i2hjdQUGpiX7BxN9zc96YciU/oD62Z
	Fo=; b=P3lBLcZ5+xWV+vN+7PGJMlVQKvf/4v9ZNASmhORW2ft8on0NUng9K3hCZ
	Z3Leb1vK3LHF/XQpJgKR/PY4yl5lnpyJt8W9YCyi3Y+LDA0eXjnUHvu6HO24Ax/6
	uT6hhSygyXJLPh+a9AmMG9NyDk1Ci3ijCpIKPKbjvVBRIoRS+39LNQjlCHZoqHhW
	6eYyJNnx2TkOHOwElYqlqbZzlWPGbSut9IAqhKX7r27rios73mqKZT4AY9QOEKr0
	ErSJzKx7+ndp0wRsm1kNe/72liD/McAuglaLGB1phr77tVqLqJDhLI7fc/hF0+gX
	zKTGlCaz+7ET+DSu7JE/v4bNcqgDQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vj1h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 19:02:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KHtDeM017052;
	Mon, 20 Oct 2025 19:02:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxq9ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 19:02:05 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KJ24KB10552306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 19:02:04 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85ABA58056;
	Mon, 20 Oct 2025 19:02:04 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1ED358061;
	Mon, 20 Oct 2025 19:02:03 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.240.93])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 19:02:03 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v1 0/3] PCI fixes for s390
Date: Mon, 20 Oct 2025 12:01:57 -0700
Message-ID: <20251020190200.1365-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q8d2aaeJzV3fLx6WgYQ_yM6T4NEgKGlu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/PkTidP9cR3u
 lpT0bCGOnXS4AqaWAzMY4ZPf+hNj3fUdMGYmOAemS/LntuwL7xDjtM56iJrLC/PUhB8FgVHz2RF
 KFhcw30qcwebdOb6lECKbxv/M1YuW55bljRfbm93Dc7MY0LTY1FkayU3RHRys56vBRa3pXWpjZv
 /BsP2EqoWSS9FNXg2dmVvwZeLx2Hjg8pH1xT9NZODiLIV9QaLHYmSNrVRgOKzMj1AfwtWfXpFvY
 4mt5tU7NpQTO6mAE7UD4NQ94yOIsdwaiSPTV2WPfA6AHcpi95bhWtAmTJDs08xKn1fUhn4BHmJz
 ujcTG2h2kPNTfcaG11Pstxzrw//mr3O9t5ViSf0sJ9xFuW5QWXsOWbqpBm+1lOQHJs3LPJQ3TtT
 IdA+pdJNRH7mWb9M8Ao4QG77P1IxZg==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f6872e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0C_zUa3iG0cStZzqMdQA:9 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: q8d2aaeJzV3fLx6WgYQ_yM6T4NEgKGlu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hi,

I came across some issues in PCI code for s390 while working on VFIO error
recovery for s390 PCI devices [1]. These patches can be indepedently applied and
has no depedency on error recovery patch series. We would like to get these
patches merged as they do fix some existing issues.

[1] https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/


Thanks
Farhan

Farhan Ali (3):
  PCI: Allow per function PCI slots
  s390/pci: Add architecture specific resource/bus address translation
  s390/pci: Restore IRQ unconditionally for the zPCI device

 arch/s390/include/asm/pci.h        |  1 -
 arch/s390/pci/pci.c                | 74 ++++++++++++++++++++++++++++++
 arch/s390/pci/pci_irq.c            |  9 +---
 drivers/pci/host-bridge.c          |  4 +-
 drivers/pci/hotplug/s390_pci_hpc.c | 10 +++-
 drivers/pci/pci.c                  |  5 +-
 drivers/pci/slot.c                 | 14 ++++--
 include/linux/pci.h                |  1 +
 8 files changed, 100 insertions(+), 18 deletions(-)

-- 
2.43.0


