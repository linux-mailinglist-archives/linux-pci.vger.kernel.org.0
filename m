Return-Path: <linux-pci+bounces-42418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D355C994E5
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 23:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1073A4A80
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 22:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727D6283FD9;
	Mon,  1 Dec 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X+3rZY6r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B579A2522B6;
	Mon,  1 Dec 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626916; cv=none; b=DkmeDH/Wff4Reju77wg9lGN5aJotnXwhUjxLQe3v9sOrKK2xTrwpswAdbS5l59DCaO/Slergz7EXLLnGydAnZ1DwDJaxACYx6FNX6WxhsRk2VvRoQLuqO3jWDgusdXcFOcNTgcJBOTE/tak+Qtvk5rSZjcp2Z/eP1e3ll6I9PxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626916; c=relaxed/simple;
	bh=tb6J3tGf6rrsKG+p/YwHLpGk6g6eWTYDsCM2M9uj7Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lj4xpbmcRC3O9OjNSkKopfz3WNDaQc1LQoYOe5NN7j5bN6OO7iHyCa+mwVAKQpJcaTnK4OPJb2cdbO/CsoUPyOrD64Nqt3J8eAvBBnzaH3eeuPHaF66X5wftUkeS7GAs4199BuEm5KOaPE/+lRTPplNX0uFjICmkLJtyVNt7rfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X+3rZY6r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1HB5qp018671;
	Mon, 1 Dec 2025 22:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IRINHZIxl5daeoM8Sv1Ii4EZWtSyWPpdd+emN+/Qw
	7Y=; b=X+3rZY6rxwZ5VrEQ2VarMkLVD3UbnQ1tAKy0Z3m3wjQ1AhwfIWP5tpQjG
	4lVoGBsK/j03l3fgUGQnD3i9u+JCJBNp+pfDMXeQKpqjfaAP4XJGKJ6RIzDbW/rk
	nDJzP+JlpskvhsGN0Ijtt6tCnTukO+aNrTE5H5e35auysBkaCM+jFvIzBZ6ddAbC
	Yz3nPS/ZlxPYbdO7m3YrkPltZ9yXtnemIgmhU3Xoxs4/R4OGpK4lG2aPbH0LIevK
	h+KLiz3+lRrIWB/qVFyx5+djaueiz/UemY5wdrLxbwLVUJeeDI+dQdiXSgiQ0VOC
	uROdX+aJ8PTyy3ip5q43oRCRxlv8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg1s8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1M1Z09024111;
	Mon, 1 Dec 2025 22:08:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5s93bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 22:08:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1M8AQJ31654642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 22:08:10 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E19F58056;
	Mon,  1 Dec 2025 22:08:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3345803F;
	Mon,  1 Dec 2025 22:08:23 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.160])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 22:08:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v6 0/9] Error recovery for vfio-pci devices on s390x
Date: Mon,  1 Dec 2025 14:08:14 -0800
Message-ID: <20251201220823.3350-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ElSPdOsgyPp-4IwxPTTKyzT2ZQQaeZiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX0wFNnhhLnKlo
 K6rM9S1eK3n9kIRSoZE9UyCsOy12vrE+Xr+KDnl7akckoGJ+XoYZzD6RdA+x3y2pUeZjbnpIA6K
 xsOktxxBwWicBOLqF5evtzc5GFkW0PfErKdd4gRcexHHvhiEibSyU1UV6UT0neGYLva9okjImX6
 72t0M/Sq5LgVRs4N77kZEfQabhA61GseHEPk4TSeF07Lk3TM94RtP+gSdqJSZ9Q+mhnLbUu1dmm
 FhvC48U71R+0zTqP1hX4yxPha2Rlo+/HhUkv57WBIdNMv9y7s/IUmOwaYIqFmjIDmoQRKBxp5oy
 897x05OzeDDYi8W7yyBEsq9/IGCCsQ40tXVXOn/9r0tXvNWkoXO6Lq0VX3GNYorsZqMbiuP1ebc
 vsiZ+CTk5RCz+LNjrnDkaaDe5Bkw2g==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692e11dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Qtm5l5LcizsofoGoYxAA:9
X-Proofpoint-GUID: ElSPdOsgyPp-4IwxPTTKyzT2ZQQaeZiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

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
 include/uapi/linux/vfio.h         |  15 +++++
 12 files changed, 291 insertions(+), 61 deletions(-)

-- 
2.43.0


