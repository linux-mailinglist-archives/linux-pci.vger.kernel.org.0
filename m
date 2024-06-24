Return-Path: <linux-pci+bounces-9187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859D491495F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 14:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69EE1C22150
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE67D13A884;
	Mon, 24 Jun 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pxBPAbNA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DB13B58A;
	Mon, 24 Jun 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231089; cv=none; b=Gc6xz5nETRajvtJXaRL6OczYs92R0qUdtYANRjelI/X3PVKYciCQqRy13LNeHbYHtEZgLuZzQ1g9OYSzA4rpYBuvImZILxelvPhM/4saLhfGdfYBnlIym2cwmOFsZWmwDN65d3Soh61mEipItlG3bVJZlBxjIgHEg4pj3FEqUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231089; c=relaxed/simple;
	bh=A3pq/fOH2jgeoQLWF5Kg1CaL6ssryxdVFixD2L0iTvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QzCMHN30W5vrF0cZwPTX2odhLr1JMUw9uZx4AQVjvGSbJ4grUX9FQyk5JbV2t1NFvxF1GoLGFcFUkNnRUOT+LEBwP4EWhefFjKqyQPH6euv6Vg2Lip30VXVzIjpzk2CqQZqhogeSfGK12z1yWOl0uR7/iNscsnKUzDPrwDzGe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pxBPAbNA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OBSQ31004059;
	Mon, 24 Jun 2024 12:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=pp1; bh=mv+8hpJmnLrXeJFDl75D5QYiO+
	qeOgS6cd6RcKX27fI=; b=pxBPAbNATypX0ED2MPQ+EZiiCW5XtpzXfJZwufCHrh
	sUYq3DR/6OVNKoDJ5mJ6L5mf8D4J+aDGazVKwsZwLDdjv7HXt5K/b7RmOtAwuXdY
	E4OEm2lRDl8ImRPcdmVFPe1S5XbiakhCWCc3Mgpelx98aP7wlRA3VueAMiadBsqe
	L7ZTE479wUHZ2vHvDRBbV/mQYWcb7lgqRBm9CvydXvkOhQAIyCZ9cF+8ndPXTMCF
	e+cVKDakgoCbLefeAqUaIbpZw/wZd9pSNsPPK3fZ9wkODEC0oZlE7CLZLbfXE1pY
	FR7x7r32JPVdPa5MbCQqiaD0yUWnBU2aclCJ9IrsgGEw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy7y20480-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 12:11:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45OCB8a9020068;
	Mon, 24 Jun 2024 12:11:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy7y2047v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 12:11:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OC6GS7008176;
	Mon, 24 Jun 2024 12:11:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9b0gs87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 12:11:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OCB1Ps44106040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 12:11:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F7F20043;
	Mon, 24 Jun 2024 12:11:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 855D220040;
	Mon, 24 Jun 2024 12:10:58 +0000 (GMT)
Received: from li-a50b8fcc-3415-11b2-a85c-f1daa4f09788.in.ibm.com (unknown [9.109.241.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 12:10:58 +0000 (GMT)
From: Krishna Kumar <krishnak@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, brking@linux.vnet.ibm.com,
        gbatra@linux.ibm.com, aneesh.kumar@kernel.org,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        bhelgaas@google.com, oohall@gmail.com, tpearson@raptorengineering.com,
        mahesh.salgaonkar@in.ibm.com, Krishna Kumar <krishnak@linux.ibm.com>
Subject: [PATCH v3 0/2] PCI hotplug driver fixes
Date: Mon, 24 Jun 2024 17:39:26 +0530
Message-ID: <20240624121052.233232-1-krishnak@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ilaggTJo8czV2_IQm31jJ5YLIzkATmAB
X-Proofpoint-ORIG-GUID: 6CC1qLQr_Tkflwy6jOG_wY3SHcWX4jUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=979 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240095

The fix of Powerpc hotplug driver (drivers/pci/hotplug/pnv_php.c)
addresses below two issues.

1. Kernel Crash during hot unplug of bridge/switch slot.

2. Bridge Support Enablement - Previously, when we do a hot-unplug
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

v3: 24 June 2024
  - Removed the DPC keyword from description in cover letter and
    patch2

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


