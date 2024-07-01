Return-Path: <linux-pci+bounces-9500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EF491D951
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 09:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08369280D5A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242351C42;
	Mon,  1 Jul 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJ7ndNP7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B8C144;
	Mon,  1 Jul 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819957; cv=none; b=gFVeXt5fj+VNQSGHmCuC3kiNyZP2Tp6D7vL/wHuhTIQNdkTtC5u7qVnCYRKCDc6QGQcAMoK9YWXI9zq+w4Psc8QGkdW7KIc+HymZQ1SmU3xzDqDJRgmJnaxKrOJJMq+H2u+YiMCNVaTEMUHu3db7rymoOBWuiVDhwfbKazONI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819957; c=relaxed/simple;
	bh=vPTsv8ofI0ASjYrL5Bma0fvUMguTIxyhAPuWLCCXAZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRw/VIOTxAsS79i3H9ESvA15qLUTeohnMk9EjBadU09ax5IGpA6MlBQ7UiW18kXs3C79bdgqWPJZGtyWqJWVQtNOLTEsW0xpma+mSXlIwpFHoVb9r/KNUUi+rrByhiPObLmvCy/jvkE8J0UXlvg+ZlzHmFHNkjWl60Mdq0Q1RFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJ7ndNP7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617RVCS007801;
	Mon, 1 Jul 2024 07:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=vr36RTPMd+l2r
	vsV09/fWal/8g1VW55S4F7ZA5tLN7o=; b=qJ7ndNP7Q6NNwx4CwB4WYuafWjLUq
	+NiIZ6+kMrPnZtfOkf3l36tNcc9TQruCTG3pzaQ09wfPk0HcKQiL6gRmLLJ6XT0l
	IyKIPWRmHD3Ztv/sJYn4GyuDLx884sZo30j58Vs3hDq4PwVZ4qk/tzi9mSCWKr8U
	lLPFh0fLOrYjD5RvbFQYqRfYZ23pczApuJ143J6ugxf1C8j/ZxjRC/JKnc6+do/c
	7EF03E3msLq8nbZ+4KcRrDVMP/9HSmWh6dm31FR8UCwTDT4cnAno0vuxcNFtfAV5
	LaGYvI3qe/SNkOLzAwtR6syKOxUl1FwQZHC6gbf+zynNpyMsA+LhlNDSg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403q6xg696-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 07:45:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4617jeEJ004599;
	Mon, 1 Jul 2024 07:45:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403q6xg691-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 07:45:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4614KuxR026402;
	Mon, 1 Jul 2024 07:45:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpp2e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 07:45:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4617jXFI46596356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 07:45:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A78DF2004B;
	Mon,  1 Jul 2024 07:45:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADFF620043;
	Mon,  1 Jul 2024 07:45:30 +0000 (GMT)
Received: from li-a50b8fcc-3415-11b2-a85c-f1daa4f09788.in.ibm.com (unknown [9.109.241.85])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 07:45:30 +0000 (GMT)
From: Krishna Kumar <krishnak@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, brking@linux.vnet.ibm.com,
        gbatra@linux.ibm.com, aneesh.kumar@kernel.org,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        bhelgaas@google.com, oohall@gmail.com, tpearson@raptorengineering.com,
        Krishna Kumar <krishnak@linux.ibm.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: [PATCH v4 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Mon,  1 Jul 2024 13:15:06 +0530
Message-ID: <20240701074513.94873-2-krishnak@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240701074513.94873-1-krishnak@linux.ibm.com>
References: <20240701074513.94873-1-krishnak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: raTzRDTpLJeztayOy8gFYZPQg3z4xxPN
X-Proofpoint-ORIG-GUID: Ryt38Hj4_BWikOZMG9sQIvtMBr3a6gyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_06,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010056

Description of the problem: The hotplug driver for powerpc
(pci/hotplug/pnv_php.c) gives kernel crash when we try to
hot-unplug/disable the PCIe switch/bridge from the PHB.

Root Cause of Crash: The crash is due to the reason that, though the msi
data structure has been released during disable/hot-unplug path and it
has been assigned with NULL, still during unregistration the code was
again trying to explicitly disable the MSI which causes the NULL pointer
dereference and kernel crash.

The patch fixes the check during unregistration path to prevent invoking
pci_disable_msi/msix() since its data structure is already freed.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gaurav Batra <gbatra@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Shawn Anastasio <sanastasio@raptorengineering.com>
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


