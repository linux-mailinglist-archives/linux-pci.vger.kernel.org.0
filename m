Return-Path: <linux-pci+bounces-44222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9A7CFFB96
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 20:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751C3315828F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8752346AD6;
	Wed,  7 Jan 2026 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HdptTQ/K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE533AD9E;
	Wed,  7 Jan 2026 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810761; cv=none; b=WRhnrWNQ/SDWOPb+ryZldX8ypX8SKtb4XwG3o3xVKVna42pMa4ojbIdKljyV7MFXjqBsSETzIKrPbqVe9LDaQ0dR+oNEZ5J3aJLn0KjMuBaQarOr+53/r4bOd0K09TCXf0Ij2p8OCMglL7Mw6Ib7Wew0YFYmSltYb75bkO23K28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810761; c=relaxed/simple;
	bh=6RCnhiokNJookgN3UcPpSWu9mh9eHX1YCQCeFzeUuu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+EFXbxoVaMP8/MJmDikMvNVcuFaUvM6SoEv+pC5w06jwuJc1Oe/NfS2tu+oKzcRQTNIrzBclaJEARbUu2nyirjY29w+dbtG5f5TAqFBHnGqY8S+2ATrMqUsaVUu23GmZQxCIng8YqP8CLttwOszihvAxVdiBhegAPjS4oJzuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HdptTQ/K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607IFfC7020194;
	Wed, 7 Jan 2026 18:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6NwcgEJDAIeYiWN+5
	tGTqpTn+ch+Rz9CFp9bdEbWM0Q=; b=HdptTQ/KACzvn3p5rQHumXxt7XMMAaEDm
	9SBbddyFhBx9EGKD+RsrcOiWEY/DHlGKXxtjayTu8CRl38PEqnsvWVK/SMVkI4IH
	EMbCpUCyLHlEc905XoOThuHiVegNIipODaDVJi0N7IaqTmpOCCdzIh8FWHfYI1Z0
	U09sLbbwSjMKXQ22WW2KMwRhDPckC35c7ozU7pAOsLWZWyYt7wU2vmAIbvdA+6kz
	HoCpbHjzpSixx3chZNyMtvpuaPQsFUY8V54P5cJMDH82Ghqe4/MGrN106Tan+92j
	ZzEBnes1EXxMGwX7tBRopxNIsP6zi3l3drVPoOESwXE2eGsacKQIg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtsd2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607H7UWB023487;
	Wed, 7 Jan 2026 18:32:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bg3rmfd7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607IWOQN28312070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 18:32:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D610158055;
	Wed,  7 Jan 2026 18:32:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91C0258065;
	Wed,  7 Jan 2026 18:32:23 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.168])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 18:32:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v7 4/9] PCI: Add additional checks for flr reset
Date: Wed,  7 Jan 2026 10:32:12 -0800
Message-ID: <20260107183217.1365-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107183217.1365-1-alifm@linux.ibm.com>
References: <20260107183217.1365-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695ea6ba cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VVjTqNMZqy_sFl6tnFEA:9
X-Proofpoint-GUID: Br3wxX9gByHOKmbSC0Kr0UzqxDZSZTsU
X-Proofpoint-ORIG-GUID: Br3wxX9gByHOKmbSC0Kr0UzqxDZSZTsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX50CRLU8ytJlZ
 2t5Qw1/EZlMQy4cSbOWG4J+fTr/MpHGqv314iltYo4y+18kUwkd8heIRmrnfU76MMTtndgmLt/B
 +/r4KesS2p377FqhmH4dlpgfkY3A7aiYcvNE22w7C5l4OgyLH2VOdn85auKCrcR0eMAtZ9fj8yd
 F1coNdIiBW675qx68AsS/40hUyLQ6/k1a9jGMqagHyDnHBKi/kLlNZrh0ZhCKcBgz3Lyevb4NHS
 47v3JbVLG1yRJmRfmr0z47zfV5fQzkdN5921orduebG2pJaYWAfqdT0msbRiwHX15ID5ZxcpMK1
 FnKd8jb8g3ewoIoD/nMHxnix+8OEDqyOXZ5YJcaoUDHBlml2GT1aJ/reQqgvBrKgjVPCynefhKK
 81WPxeT5/oJUVcKWCPToSXvrxWfF18LZXikzz1UNUSgyBgcCLDWxe22Nv9VqA5UaBOtRgqVqTVm
 5o9BOuHCKcDDWeUP8EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070145

If a device is in an error state, then any reads of device registers can
return error value. Add addtional checks to validate if a device is in an
error state before doing an flr reset.

Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 74d21c97654d..b687f51ecc81 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4358,12 +4358,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
  */
 int pcie_reset_flr(struct pci_dev *dev, bool probe)
 {
+	u32 reg;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;
 
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
+		pci_warn(dev, "Device unable to do an FLR\n");
+		return -ENOTTY;
+	}
+
 	if (probe)
 		return 0;
 
-- 
2.43.0


