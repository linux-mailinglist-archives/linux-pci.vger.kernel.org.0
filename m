Return-Path: <linux-pci+bounces-39066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4FBBFE4C7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946654EA3B7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6EC30215E;
	Wed, 22 Oct 2025 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ba2F055n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D342798FA;
	Wed, 22 Oct 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761168261; cv=none; b=hJ9wi2ss+Opg8xoTUoYeSzHghYwCwJkbAvwEvTCUTOPmlyif/tolJuzK0hycVeqZvrd5xi/w9pP/GBF0M48w0Hg51gB8ieJ6MPWUDD/O5LM+bR6F14XuPe8B/N1iACkb92PrNrSdHSo4d274vqGIj0KlcqwnT3cmoH+9sqJvG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761168261; c=relaxed/simple;
	bh=qyPf09fhZWcJlfCtfYI2qgcjO6bXA6/CTHKtOtxzEhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxMe8p0tM31nBeVJnm+o/coohBIK7jB2rNeJ7Q5uDEDAUZWUgS3apWUc3nikTPlqGsC7lbsAJ5dTmY7ys75+BohQ03oA/WoFF9sqIHGFnOW+odP8RbThzExtjoOKgD09o7HFPAVDGoa20ShmWsvSo1x6et1BgEYEqEW112YtSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ba2F055n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MJ6Ptq008824;
	Wed, 22 Oct 2025 21:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i/FVZ9iKYRMDvqB8LQtagIr0Cd15WqnkFBbWgHJJd
	Jo=; b=Ba2F055nrQRX7yZ+6JAqBEupSaZZKIuvhsXQ3zY/Sb4osKbPXbxgTVTd6
	ObqppeQwYDDto8RXmVOyYSZiczR3VO5VgIlaCSq8GpQhpJsKprfBe+bUp8mslpBK
	w0M4kC1exoVIvXm4t3OBXduJEFcuIbLMnJ5yEAbDxwU6uBAJutPKJMR8CWPZi4ro
	yFRZFPfkZ2tNCBlGyG+t0kysKjSW4GKRQned2Nu1pgMwHLD/jMyvwN64UJ4EKPos
	9eM/FyOt7Cby2Wt84kT6NHPSLDDYf+97J3gYMiMig/aWYKJRjMZC/BKhFrYBZOt/
	g464Q/BDZ8Jw0yasDnTaZRWSApgMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cdq69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 21:24:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MK9Umo014676;
	Wed, 22 Oct 2025 21:24:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7satee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 21:24:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MLOEqO29426354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 21:24:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC9715805C;
	Wed, 22 Oct 2025 21:24:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAE335805A;
	Wed, 22 Oct 2025 21:24:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 21:24:12 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: helgaas@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, bblock@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH v2 0/2] PCI fixes for s390
Date: Wed, 22 Oct 2025 14:24:09 -0700
Message-ID: <20251022212411.1989-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9eTrJa3sJLmOBSfpzXdfWtwMpQHqYva_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyokGn8KHlvPm
 NPSSb14SaSnneP3yIjhbz8+wUhEZzB50l0MTGBoWdOjn6WXQHyl78+GJ7dHqTqZWlvbfwoGkgc+
 3O5PwJIy9+oS8SaLS/Rf/ChQl17WE1dG9v9k2WV7HNir3pwwUcQX6G8Olxh85JzDNaWJ2SnH9Pa
 XmDTB6OMcBx2AQN053rNu3vwesGiCZ04pHD7gW/zWaUKONnSw0cJe2A+Cbdj+GUsbYJeGCQ4VZf
 HuMOBPvtM9mnyHvTYn/7FMR1t74J6ShfBMRTb0mmjCnEkSmUCBVZMmN+sIAPCgRbtPKDvjGiNUP
 LmS7YfxPBLaubuskbcg3zETxtlCRh0IQq0pDrczg24wLw1ZBLMyvFE26gaOIXwtLsUAeCP4C0Kg
 bTTEGMB4FLfjgg9hoGPxC0shmnQu6Q==
X-Proofpoint-GUID: 9eTrJa3sJLmOBSfpzXdfWtwMpQHqYva_
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f94b80 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=XBVAZEMcYQg2izrzrm0A:9 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hi,

I came across some issues in PCI code for s390 while working on VFIO error
recovery for s390 PCI devices [1]. These patches can be indepedently applied and
has no depedency on error recovery patch series. We would like to get these
patches merged as they do fix some existing issues.

[1] https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/

ChangeLog
---------
v1 -> v2
   - Re-work patch 1 on setting per_func_slot flag. The flag is set if platform
   enables per function pci slots (currently only enabled for s390).
   - Drop R-b tags for patch 1.

Thanks
Farhan


Farhan Ali (2):
  PCI: Allow per function PCI slots
  s390/pci: Add architecture specific resource/bus address translation

 arch/s390/pci/pci.c       | 74 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/host-bridge.c |  4 +--
 drivers/pci/pci.c         |  5 +--
 drivers/pci/slot.c        | 25 +++++++++++--
 include/linux/pci.h       |  1 +
 5 files changed, 102 insertions(+), 7 deletions(-)

-- 
2.43.0


