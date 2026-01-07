Return-Path: <linux-pci+bounces-44217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D031CFFBC9
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A181430AFCEC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 18:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BC342C99;
	Wed,  7 Jan 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjHikpuw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A743A0B03;
	Wed,  7 Jan 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810754; cv=none; b=eE2YP40GP5X8rRK7bag+VsueASaBcFEuNEOIJM5RuVZgIaciiMXvrKCuOP6lneZpcECCSOzB9bIpaY4sfeFGCr0H7SFd3mbbMGcdMaNsStJK4GfW7Vn8/CEZUKdnQyGZbV2sJoD01AfimL/uih35dsjl+T7jt3gOBy8L/O3/t7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810754; c=relaxed/simple;
	bh=pqhrzV5OTxnDf5yIj1ghKhVGcyUIx8S6bY/siOB9AsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7BMNZTWFqKiVoWWhSJQDJrUBuZxNE5rGYR/O5bFZOISW20JWus0nOolatv7DRWyE63lQlLpeIYGpdxnEeXXGTzcPCWS9cX9Cb/cgBcAGQrSoBHHwtgjMAdK3Wnil+mTD8oCVPbejH9i+jSOpDT01eyWO6eEF70MUytbR5F2SF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjHikpuw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607IC9Ld001239;
	Wed, 7 Jan 2026 18:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OJkygs5Ki+AIArT6I1T7mtVFExXt7ATkZCfeaDwtC
	Yw=; b=IjHikpuwZaqFznA/8hRmmq5XsIEXLYxVkxByQuvvxsK4QR45PgVIREhpj
	OWzHH0XuxlmptnMiDVyERASioZ44RixehL+PAdp3FcDiACVq3USlP8Wma3v4mYve
	GcbGLCO3rCboQEhnoBXupQAW2wM/dsOJ9INvoMu0gR+WiSjYbDN6HfAwsD+pHaW5
	Og1UwbU8WhodmpWIEsao0O6eAs5NfiPLHl7AFOMzNfy5z3go3tyc81BkLFy0ClAL
	9NxXMJx3eABmxbxFeHLnVgrdNoC8l8Rv3T1F2pVvvLgesMRmQjp9WQKl+hGZMn5I
	LMkf9RgKoDHJXVKxqpTWoQkDgqTZg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshf1g89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607IVkdU019161;
	Wed, 7 Jan 2026 18:32:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51aeyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 18:32:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 607IW18S22610444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 18:32:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7140258055;
	Wed,  7 Jan 2026 18:32:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46B655804B;
	Wed,  7 Jan 2026 18:32:18 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.168])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Jan 2026 18:32:18 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v7 0/9] Error recovery for vfio-pci devices on s390x
Date: Wed,  7 Jan 2026 10:32:08 -0800
Message-ID: <20260107183217.1365-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX/2+HtXtn40y7
 kgArbtvNCPHacLAw0zfm6HaS+3NWnBAWHKF/MzgujYbI66rVHjcc4l1N5Iq1GFFR51HWjlu4nOe
 GPAieUUZceGC4YPt2sl7jiiosxNd5G+MyQxL/ohg99JCrnqj4U/JYmmO6gd0FXOZDyq41jR1tQ2
 3k6K8wvtXD67welhIP8Uzd4892d+seklHgJdFOVgoUT2vU1+pjafB1asLNkvFUvnk/jBUJ4lcjq
 vkkZ5RPONlfRI7znqlYT3KxJQTYtD3kfbE+/ZSgjM4UaIeElM5OwIp6eao3juuldCks2EAQBgKp
 ewSgCF3smLGCqymyHiQ9byo0BTjYuB+mBfhaJqptVr9brb8H7RgcXLiUi+7A6qJAcBmUbMayIj8
 feYFhVih8edja+0qLmHfXZY4XEIjNDz+l6sdtCP5K2IeyWBdSzdlpcuwsFcwmkFFaXu1AEzYUUx
 4wJX8DDdSDQhyTefnJA==
X-Proofpoint-GUID: hMOZQuOebgsPa4jPg5h9UAWZNj3a1IFP
X-Proofpoint-ORIG-GUID: hMOZQuOebgsPa4jPg5h9UAWZNj3a1IFP
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695ea6b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qtm5l5LcizsofoGoYxAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070145

Hi,

This Linux kernel patch series introduces support for error recovery for
passthrough PCI devices on System Z (s390x). 

Background
----------
For PCI devices on s390x an operating system receives platform specific
error events from firmware rather than through AER.Today for
passthrough/userspace devices, we don't attempt any error recovery and
ignore any error events for the devices. The passthrough/userspace devices
are managed by the vfio-pci driver. The driver does register error handling
callbacks (error_detected), and on an error trigger an eventfd to
userspace.  But we need a mechanism to notify userspace
(QEMU/guest/userspace drivers) about the error event. 

Proposal
--------
We can expose this error information (currently only the PCI Error Code)
via a device feature. Userspace can then obtain the error information 
via VFIO_DEVICE_FEATURE ioctl and take appropriate actions such as driving 
a device reset.

This is how a typical flow for passthrough devices to a VM would work:
For passthrough devices to a VM, the driver bound to the device on the host 
is vfio-pci. vfio-pci driver does support the error_detected() callback 
(vfio_pci_core_aer_err_detected()), and on an PCI error s390x recovery 
code on the host will call the vfio-pci error_detected() callback. The 
vfio-pci error_detected() callback will notify userspace/QEMU via an 
eventfd, and return PCI_ERS_RESULT_CAN_RECOVER. At this point the s390x 
error recovery on the host will skip any further action(see patch 6) and 
let userspace drive the error recovery.

Once userspace/QEMU is notified, it then injects this error into the VM 
so device drivers in the VM can take recovery actions. For example for a 
passthrough NVMe device, the VM's OS NVMe driver will access the device. 
At this point the VM's NVMe driver's error_detected() will drive the 
recovery by returning PCI_ERS_RESULT_NEED_RESET, and the s390x error 
recovery in the VM's OS will try to do a reset. Resets are privileged 
operations and so the VM will need intervention from QEMU to perform the 
reset. QEMU will invoke the VFIO_DEVICE_RESET ioctl to now notify the 
host that the VM is requesting a reset of the device. The vfio-pci driver 
on the host will then perform the reset on the device to recover it.


Thanks
Farhan

ChangeLog
---------
v6 series https://lore.kernel.org/all/2c609e61-1861-4bf3-b019-a11c137d26a5@linux.ibm.com/
v6 -> v7
    - Rebase on 6.19-rc4

    - Update commit message based on Niklas's suggestion (patch 3).

v5 series https://lore.kernel.org/all/20251113183502.2388-1-alifm@linux.ibm.com/
v5 -> v6
   - Rebase on 6.18 + Lukas's PCI: Universal error recoverability of
   devices series (https://lore.kernel.org/all/cover.1763483367.git.lukas@wunner.de/)

   - Re-work config space accessibility check to pci_dev_save_and_disable() (patch 3).
   This avoids saving the config space, in the reset path, if the device's config space is
   corrupted or inaccessible.

v4 series https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/
v4 -> v5
    - Rebase on 6.18-rc5

    - Move bug fixes to the beginning of the series (patch 1 and 2). These patches
    were posted as a separate fixes series 
https://lore.kernel.org/all/a14936ac-47d6-461b-816f-0fd66f869b0f@linux.ibm.com/

    - Add matching pci_put_dev() for pci_get_slot() (patch 6).

v3 series https://lore.kernel.org/all/20250911183307.1910-1-alifm@linux.ibm.com/
v3 -> v4
    - Remove warn messages for each PCI capability not restored (patch 1)

    - Check PCI_COMMAND and PCI_STATUS register for error value instead of device id 
    (patch 1)

    - Fix kernel crash in patch 3

    - Added reviewed by tags

    - Address comments from Niklas's (patches 4, 5, 7)

    - Fix compilation error non s390x system (patch 8)

    - Explicitly align struct vfio_device_feature_zpci_err (patch 8)


v2 series https://lore.kernel.org/all/20250825171226.1602-1-alifm@linux.ibm.com/
v2 -> v3
   - Patch 1 avoids saving any config space state if the device is in error
   (suggested by Alex)

   - Patch 2 adds additional check only for FLR reset to try other function 
     reset method (suggested by Alex).

   - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
     functions. Creates a new flag pci_slot to allow per function slot.

   - Patch 4 fixes a bug in s390 for resource to bus address translation.

   - Rebase on 6.17-rc5


v1 series https://lore.kernel.org/all/20250813170821.1115-1-alifm@linux.ibm.com/
v1 - > v2
   - Patches 1 and 2 adds some additional checks for FLR/PM reset to 
     try other function reset method (suggested by Alex).

   - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
     functions.

   - Patch 7 adds a new device feature for zPCI devices for the VFIO_DEVICE_FEATURE 
     ioctl. The ioctl is used by userspace to retriece any PCI error
     information for the device (suggested by Alex).

   - Patch 8 adds a reset_done() callback for the vfio-pci driver, to
     restore the state of the device after a reset.

   - Patch 9 removes the pcie check for triggering VFIO_PCI_ERR_IRQ_INDEX.


Farhan Ali (9):
  PCI: Allow per function PCI slots
  s390/pci: Add architecture specific resource/bus address translation
  PCI: Avoid saving config space state if inaccessible
  PCI: Add additional checks for flr reset
  s390/pci: Update the logic for detecting passthrough device
  s390/pci: Store PCI error information for passthrough devices
  vfio-pci/zdev: Add a device feature for error information
  vfio: Add a reset_done callback for vfio-pci driver
  vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

 arch/s390/include/asm/pci.h       |  29 ++++++++
 arch/s390/pci/pci.c               |  75 +++++++++++++++++++++
 arch/s390/pci/pci_event.c         | 107 +++++++++++++++++-------------
 drivers/pci/host-bridge.c         |   4 +-
 drivers/pci/pci.c                 |  19 +++++-
 drivers/pci/slot.c                |  25 ++++++-
 drivers/vfio/pci/vfio_pci_core.c  |  20 ++++--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 +++
 drivers/vfio/pci/vfio_pci_zdev.c  |  45 ++++++++++++-
 include/linux/pci.h               |   1 +
 include/uapi/linux/vfio.h         |  16 +++++
 12 files changed, 292 insertions(+), 61 deletions(-)

-- 
2.43.0


