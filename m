Return-Path: <linux-pci+bounces-7292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB58C0F45
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 14:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81461F216BD
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6614AD2E;
	Thu,  9 May 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AB4+tWfl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB314BF92;
	Thu,  9 May 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256449; cv=none; b=cwHzmoR8NHihal9kgyoqsTgwcd+RIWNo4vP3jcNN0FjJ+4LtygfbRqj7y7kLi8SJnaBpJqdKZbUnVy2gfbsxX9LXeN1Q8Je/flmWTQaxpsVeQuXYvnm6QpL+4HP4lA7eFiPtET+ELuRds9VPigS2tDvGrPu/eZidrmKaS8i1F6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256449; c=relaxed/simple;
	bh=b3Lw6QyOOe/F0A2wbbC5aMnHbGBJhpHoP64jYjfjjKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fKrwhfOG01DriXHhOOFUJGxMzMFRHI3Ddmu8LRb8bkm0tiCXQmDwX3frvdMWDipbKYCHcDhZ8MahVaINpL0pXW+ZW9HyZAVOllIgx3BRCewj5BNIWp1HByVSK6oUKSfOh2Drjy92tiZnkwGXM6rvMZGlOkhL3bq5gcQ71zYeJpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AB4+tWfl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449AwH8o010769;
	Thu, 9 May 2024 12:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=wB/RWoAJV2Kfx9dgeYhfSibcvHgEFIlPM4CBDF2TtHk=;
 b=AB4+tWfl8spiWQqwneYWVcKOFIuDl7ua2n1SJa74QISK6sCl52gpfiL0C75UqSxDdxyt
 Xjea4wpL11Tnh8N+nChF0DlaR2xoQ4bHbFo+aFas64Knuv30aG6Xe0yxFOTZUcngZlVp
 1psr2jPtxGTN/QUwsELFfBfCKqxuSZ040fI722yz8KgN+/HSf4qwpWs55vLyaC765JBi
 68+nrfGF2D8emaHwK6OuQ0rwZCLYH09MRsdcPGpGxxBMA5RHV/xh4CGCHx6ClQQ5ss1/
 lgDmshvKYr+XqVJ9uXVYwosupxw+dcla/FFUs7Vd1FFTsQODipPPTyWl2WNiIqI4zgyI Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0w6rg4ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 12:07:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 449C76je020859;
	Thu, 9 May 2024 12:07:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0w6rg4u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 12:07:06 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 449Bn23i009823;
	Thu, 9 May 2024 12:07:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xyshutpgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 12:07:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 449C70Ih57016742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 12:07:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 054E620043;
	Thu,  9 May 2024 12:07:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1198120040;
	Thu,  9 May 2024 12:06:57 +0000 (GMT)
Received: from li-a50b8fcc-3415-11b2-a85c-f1daa4f09788.in.ibm.com (unknown [9.109.241.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 May 2024 12:06:56 +0000 (GMT)
From: Krishna Kumar <krishnak@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, brking@linux.vnet.ibm.com,
        gbatra@linux.ibm.com, aneesh.kumar@kernel.org,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        bhelgaas@google.com, oohall@gmail.com, tpearson@raptorengineering.com,
        mahesh.salgaonkar@in.ibm.com, Krishna Kumar <krishnak@linux.ibm.com>
Subject: [PATCH 0/2] PCI hotplug driver fixes
Date: Thu,  9 May 2024 17:35:52 +0530
Message-ID: <20240509120644.653577-1-krishnak@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EONjMsdldPhPf2sVN8g05O0_NZS1G4S_
X-Proofpoint-GUID: MhXk9jPgL08IGT3MtvuJymytL3kTsmxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxlogscore=673 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405090080

The fix of Powerpc hotplug driver (drivers/pci/hotplug/pnv_php.c)
addresses below two issues.

1. Kernel Crash during hot unplug of bridge/switch slot.

2. DPC-Support Enablement - Previously, when we do a hot-unplug
operation on a bridge slot, all the ports and devices behind the
bridge-ports would be hot-unplugged/offline, but when we do a hot-plug
operation on the same bridge slot, all the ports and devices behind the
bridge would not get hot-plugged/online. In this case, Only the first
port of the bridge gets enabled and the remaining port/devices remain
unplugged/offline.  After the fix, The hot-unplug and hot-plug
operations on the slot associated with the bridge started behaving
correctly and became in sync. Now, after the hot plug operation on the
same slot, all the bridge ports and devices behind the bridge become
hot-plugged/online/restored in the same manner as it was before the
hot-unplug operation.



Krishna Kumar (2):
  pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
  arch/powerpc: hotplug driver bridge support

 arch/powerpc/include/asm/ppc-pci.h |  4 +++
 arch/powerpc/kernel/pci-hotplug.c  |  5 ++--
 arch/powerpc/kernel/pci_dn.c       | 42 ++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pnv_php.c      |  3 +--
 4 files changed, 49 insertions(+), 5 deletions(-)

-- 
2.44.0


