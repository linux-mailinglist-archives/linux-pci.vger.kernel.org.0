Return-Path: <linux-pci+bounces-9188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B665914961
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5E0281870
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC2513B5B6;
	Mon, 24 Jun 2024 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o4dx6mLT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC1613B59C;
	Mon, 24 Jun 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231104; cv=none; b=lMrRZ8q31lfeH4Xp1GF21TQiZxz+N4i4oLXEoPEXKvhho5QGLXRZemc8IradRSClB1bUWNsGC3+IrzMOAWnN60JzrduWhjlru5jsgldP48ZKvOO/93ZwPfIrRJ5F52gt8crAkhwzwhCEs+6vPrX2gd0EXaqxkiE9krhC2ZwzEK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231104; c=relaxed/simple;
	bh=68MMfbliHOINcXLS3klMYRbUqs9OVDRgf1tO4WQOYdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGGx5A85EymYC3JwX7/5Jx956qkAJZK3xKCJrw9OLEdhhOFu+5xnXN6vZTNb00Bf+hGsLLMsAtUfDJbcEOsyCxLCSn4ZgevtelKkzbaLGp8ti2LDaRNFiw6xd+st5RXnFyFrqkb/dqp3jmGGA39A0bTamD0F0wgkgKIP+xfongk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o4dx6mLT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OBwdoR017982;
	Mon, 24 Jun 2024 12:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=Rm2IdZnmNlvTC
	86yy6NrikawKbdJJ5Bxiyr3XAFxv+Y=; b=o4dx6mLTFKwSC+mp9gAPFoav/CeR/
	HLx0JZbz0C1Lz/Zbi8VkywLoTp+3h8ob7mvWMQtsk2IMOJ6YFG6Zy12ZGfnAAKh1
	Fe+QPNeCEtgY9FPZwZzEC/7E+472LdZNq44GrxT5Qz14+WAw/kHn+IkD7Q70NW4C
	WBVeNoWd7w4UzNLx49YNeE0R9GmUP5XfGZhJspyrEC6AlnQV/jGSycOADyogBRNe
	Z9Mh3wHFVyO986kHUMjBb1JuGd3Y7Kx8t6Y3cb5VgcGkeuFv9M7ANK1gYQfeTcFf
	bhHQdWINVNNPf8IaZ+PJjNCi0MWaQFjmLqLgXsiTs/B8eOpP86EnbTnwA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy8d2018t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 12:11:17 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45OCBH9g006215;
	Mon, 24 Jun 2024 12:11:17 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yy8d2018m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 12:11:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OB1qvg000388;
	Mon, 24 Jun 2024 12:11:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn306y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 12:11:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OCBAXv48693742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 12:11:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 764752004E;
	Mon, 24 Jun 2024 12:11:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C88D20078;
	Mon, 24 Jun 2024 12:11:07 +0000 (GMT)
Received: from li-a50b8fcc-3415-11b2-a85c-f1daa4f09788.in.ibm.com (unknown [9.109.241.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 12:11:06 +0000 (GMT)
From: Krishna Kumar <krishnak@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, brking@linux.vnet.ibm.com,
        gbatra@linux.ibm.com, aneesh.kumar@kernel.org,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        bhelgaas@google.com, oohall@gmail.com, tpearson@raptorengineering.com,
        mahesh.salgaonkar@in.ibm.com, Krishna Kumar <krishnak@linux.ibm.com>
Subject: [PATCH v3 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Mon, 24 Jun 2024 17:39:27 +0530
Message-ID: <20240624121052.233232-2-krishnak@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624121052.233232-1-krishnak@linux.ibm.com>
References: <20240624121052.233232-1-krishnak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gkqnnZec3KeIDRM5l1D6wd-vDtHbCopU
X-Proofpoint-GUID: imHiSgtyDh5KH-62lGUyuF49KlyoROWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240095

Description of the problem: The hotplug driver for powerpc
(pci/hotplug/pnv_php.c) gives kernel crash when we try to
hot-unplug/disable the PCIe switch/bridge from the PHB.

Root Cause of Crash: The crash is due to the reason that, though the msi
data structure has been released during disable/hot-unplug path and it
has been assigned with NULL, still during unregistartion the code was
again trying to explicitly disable the msi which causes the Null pointer
dereference and kernel crash.

Proposed Fix : The fix is to correct the check during unregistration path
so that the code should not  try to invoke pci_disable_msi/msix() if its
data structure is already freed.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gaurav Batra <gbatra@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>

Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 694349be9d0a..573a41869c15 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -40,7 +40,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -59,7 +58,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
-- 
2.45.0


