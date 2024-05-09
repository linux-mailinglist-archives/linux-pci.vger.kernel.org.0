Return-Path: <linux-pci+bounces-7293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42158C0F53
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B27F2819CE
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C646615E5C9;
	Thu,  9 May 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gMRcf8q/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF414B947;
	Thu,  9 May 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256454; cv=none; b=QdyJrwGPc7GzRrr9iMxO3AUrRmI9KNB1wUB2laLUbdurDFbEUMeTdM7A/DvGbTSbEdTdFCWVUE9ryW+JCfyBSBDEII1Ko6/aiIjiCFmOCJbGWJwk88MZc3mR3Tm/bpS3nc1f0IwbYyw9DUrxUfP4GqrcfEXWBtvDJ+QYvu2Nghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256454; c=relaxed/simple;
	bh=eaMVtDGxb1o8CWSLtbnC0+Le3XFFE+jxn1ZZYd455to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYD+ZpvKChzbDXeeIo+IXRRNx1caQBJRIh3U4qTieAuDXER/WB9QtGPhPplp1PatfT3F0R7mwgiVcnX717VCoKvTZX5SKdNpNSyBELy31M3LQKUNnn21wD+TH3uPRgGAeaCNXMvfJ4sXAHyBy4tUtFd90RUoNyFKbBoADzK9ZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gMRcf8q/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449BhIfF019918;
	Thu, 9 May 2024 12:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=HqGYE7s9FMlfnszzX/MIWzccuD0nxHtJ+52UxJaWF74=;
 b=gMRcf8q/ULZfN+ZIk13aj8yYfqOzoDQfueDOuMsFOCcGOL6RUeekfdEDAqxrziuckjot
 YtGZCXll+6Hz/XAKSpUmc/3uXycQJul64PGGE5En41B2Qw/K4Cc3BArvlSB9hyzm68ym
 0A1CKveMdFaf/opVmw2nINfC65bYIG8vK0aD9xue4BSjmZNBG/KKmpguBlfrfABc7ORm
 ltrwvA0MMllOF/HK399C20pWe0jEGsNWITIPufECC5YDpBRUFTw9NeE0/hJ5bJGoLWSA
 vFNpSVY6dhvX9P7ubF8VRicp3u9t7Rb1uRjT/Z38KvxP4x/N556It4T7FFyfzoqzlZtX nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0wux01y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 12:07:14 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 449C7Dvc024271;
	Thu, 9 May 2024 12:07:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y0wux01xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 12:07:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 449C0NHb009277;
	Thu, 9 May 2024 12:07:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xyshtapex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 12:07:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 449C77Nt53477804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 May 2024 12:07:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8DB42004E;
	Thu,  9 May 2024 12:07:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA9E520040;
	Thu,  9 May 2024 12:07:03 +0000 (GMT)
Received: from li-a50b8fcc-3415-11b2-a85c-f1daa4f09788.in.ibm.com (unknown [9.109.241.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 May 2024 12:07:03 +0000 (GMT)
From: Krishna Kumar <krishnak@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, brking@linux.vnet.ibm.com,
        gbatra@linux.ibm.com, aneesh.kumar@kernel.org,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        bhelgaas@google.com, oohall@gmail.com, tpearson@raptorengineering.com,
        mahesh.salgaonkar@in.ibm.com, Krishna Kumar <krishnak@linux.ibm.com>
Subject: [PATCH 1/2] pci/hotplug/pnv_php: Fix hotplug driver crash on Powernv
Date: Thu,  9 May 2024 17:35:53 +0530
Message-ID: <20240509120644.653577-2-krishnak@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509120644.653577-1-krishnak@linux.ibm.com>
References: <20240509120644.653577-1-krishnak@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qr1DVfftZoXtEFFL3-cAO9xPYrfWPraD
X-Proofpoint-ORIG-GUID: jFFHmLjPR9VLGRISpH3XcOyzMhhkzOAh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090080

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


Signed-off-by: Krishna Kumar <krishnak@linux.ibm.com>
---

Command used for reproducing the bug:

    echo 0 > /sys/bus/pci/slots/C5/power

where C5 is slot associated with bridge.

Snippet of Crash:

 Kernel attempted to read user page (10) - exploit attempt? (uid: 0)
 BUG: Kernel NULL pointer dereference on read at 0x00000010
 Faulting instruction address: 0xc000000000fad7d4
 Oops: Kernel access of bad area, sig: 11 [#1]
 Hardware name: 5105-22E POWER9 0x4e1203 opal:v7.0-39-g4660e63a PowerNV
 NIP [c000000000fad7d4] mutex_lock+0x34/0x88
 LR [c000000000fad7c8] mutex_lock+0x28/0x88
 Call Trace:
 [c00000017075f940] [c000000000fad7c8] mutex_lock+0x28/0x88 (unreliable)
 [c00000017075f970] [c000000000214464] msi_lock_descs+0x28/0x3c
 [c00000017075f990] [c0000000008e8be8] pci_disable_msi+0x68/0xa8
 [c00000017075f9c0] [c00000000090f0a4] pnv_php_disable_irq+0x2a0/0x2b0
 [c00000017075fab0] [c00000000090f128] pnv_php_free_slot+0x74/0xc4
 [c00000017075fb30] [c000000000912184] pnv_php_disable_slot.part.0+0x1b8/0x24c
 [c00000017075fc00] [c000000000902df0] power_write_file+0xf8/0x18c
 [c00000017075fc80] [c0000000008f84d8] pci_slot_attr_store+0x40/0x5c
 [c00000017075fca0] [c0000000006b4834] sysfs_kf_write+0x64/0x78
 [c00000017075fcc0] [c0000000006b3300] kernfs_fop_write_iter+0x1b8/0x2dc
 [c00000017075fd10] [c0000000005b3eb0] vfs_write+0x224/0x4e8
 [c00000017075fdc0] [c0000000005b44b0] ksys_write+0x88/0x150
 [c00000017075fe10] [c000000000030864] system_call_exception+0x124/0x320
 [c00000017075fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
 --- interrupt: 3000 at 0x7fffb9748774


Root-Cause: Its safe to call pci_disable_msi() if its associated data structre are
not freed (during bailout path). But when the driver code disables the
bridge during hot-unplug operation, its msi data structure becomes NULL
(php_slot->pdev->dev.msi.data:0000000000000000).  This happens before
unregistration and during disable path in function
msi_device_data_release(). In this case, its not safe to explicitly call
pci_disable_msi/msix() due to NULL pointer dereference. But since the
current code does so, the crash is happening at the line
mutex_lock(&dev->msi.data->mutex).


FIX: In the current code, there are two paths to invoke
pci_disable_msi/msix(). In the error/bailout path, first argument of the
check - if(disable_device || irq > 0), i.e. disable_device is true, so
it will always invoke pci_disable_msi/msix(), it will never depend on
second argument. In this path it's fine to call pci_disable_msi/msix().
During the slot releasing/disable/hot-unpug path the disable_device is
false, irq is having old value which is making the overall check true
and causing the crash. Of course, we should not choose the old/stale
value of irq but should choose php_slot->irq for check.  Also, since
php_slot->irq value is always 0 before the check, so it does not matter
if it will not be included into the check.  So, the check can be formed
with only one argument i.e. disable_device.  Based on its value
pci_disable_msi/msix() will be invoked and this is the fix for the
crash. During the bailout path its value will be true and during the
hot-unplug operation on the bridge slot, its value will be false.

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
2.44.0


