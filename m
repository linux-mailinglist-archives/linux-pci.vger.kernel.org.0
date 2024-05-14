Return-Path: <linux-pci+bounces-7460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C78C5765
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 15:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28461F2167A
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987211448EA;
	Tue, 14 May 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mZfwvQwv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB71448E4;
	Tue, 14 May 2024 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694805; cv=none; b=uYbSUIYo2aXx5/ukNAX0H7qPbW3eZ8dYw61MkDg1ErlSAYXvS04/lorgcz9L9DUOU0321uAffGXs3Iq48c7cAdBabOdnZHs/bEL6nZQ8a5WMa+kQYUS6wMR0hBkM1U6nQ9byIhJCpNHcDUeqbSluncpZpMMOeIs2kcFNGXgtQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694805; c=relaxed/simple;
	bh=dr9TXOrtnoHYX8KZZqpHd8BZAYxFhyNVAMV1RhuSDXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NFz2fbnsL0YUS7YYWn6QTN/jMQ9mb4kRdsdTkfYRc+DGZL5YO1zPwmBR68SMCgZ/rExC/6ABd8cXn39r2NKuBejeTv/DMNkkCKIIfAXNoDSMFuifCVsGET8Ac/yB1RKFl6DmNNKgrohduGduldUiD14jDLXJ8FBlgfV1zTILZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mZfwvQwv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EDaZ0q005782;
	Tue, 14 May 2024 13:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=QICXyD0cR3LQEfx/tMfWRDGF0Q6fAIZIgFy/7ObjIYc=;
 b=mZfwvQwvDa/i7rBP1NeyFHndVsoaNa2E1BXZNHVqsagidjrvpuhXXMOREsO90LFufoIC
 o+b284A3Yp9vVFhR2ezGH0sbcguPl4bAmgzmj1GXd7XPczoMYhLwuar2C2nCQMOLZB9F
 3hZ9o+eezErrJfRwn9i8sGAL3KgcptODnYeKivlk+F8IavtvjePygMyl0i46Avy7qJMa
 ECSsFv/mjpdnOMmLPug2HiB5dr5Cak5WsJJG3qiFFn1jygbnFgziPvNTsz23x3n2IkF2
 uI77o11V96uk2F7fn6nCVIFkV88BJh2lRxDJd9i3bX/G650nB2fUukSk3t45C8TY46e9 CQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y48dng4x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:53:17 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EBxvws002288;
	Tue, 14 May 2024 13:53:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0p5prr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:53:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EDrBSm46006560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 13:53:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5A292004B;
	Tue, 14 May 2024 13:53:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B55820049;
	Tue, 14 May 2024 13:53:09 +0000 (GMT)
Received: from li-a50b8fcc-3415-11b2-a85c-f1daa4f09788.ibm.com.com (unknown [9.171.90.14])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 13:53:09 +0000 (GMT)
From: Krishna Kumar <krishnak@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mahesh@linux.ibm.com, Krishna Kumar <krishnak@linux.ibm.com>
Subject: [PATCH v2 0/2] PCI hotplug driver fixes
Date: Tue, 14 May 2024 19:22:57 +0530
Message-ID: <20240514135303.176134-1-krishnak@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FYRf0mz2Pwj9CUdx0_2lpbJkEnaXE9zZ
X-Proofpoint-GUID: FYRf0mz2Pwj9CUdx0_2lpbJkEnaXE9zZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_07,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=930 clxscore=1015
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405140098


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
  powerpc: hotplug driver bridge support

 arch/powerpc/include/asm/ppc-pci.h |  4 ++++
 arch/powerpc/kernel/pci-hotplug.c  |  5 ++---
 arch/powerpc/kernel/pci_dn.c       | 32 ++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pnv_php.c      |  3 +--
 4 files changed, 39 insertions(+), 5 deletions(-)

Changelog:
==========
v2: 14 May 2024
  - Used of_property_read_u32() in place of of_get_property() and
    of_read_number(). [patch2]
  - Removed some unnecessary variable and changed the function return
    type from void* to void. [patch2]
  - Removed the export declaration of
    pci_traverse_sibling_nodes_and_scan_slot() as its not needed.
    [patch2]
-- 
2.45.0


