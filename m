Return-Path: <linux-pci+bounces-44982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC19D27CCC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 19:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3910303092C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276E3BF31F;
	Thu, 15 Jan 2026 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hCwLhe3b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72823B8BB3;
	Thu, 15 Jan 2026 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501695; cv=none; b=tLY8bPXANc0DCBNeLgSzu/dOPcFzYFvpuD2HAX0JDk7n+QZBBA+fnZy28ULYMBXDg8ivIZTA00ij0Wuf+eHxNu1WBS8pjfQ+HRr9JXB95H8sOl9h+IOk8+g12yCj82Q5QbXAjViRCWFhpN5bN/XCm4SLMPlbdZuoxtyJSDUwDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501695; c=relaxed/simple;
	bh=TCTXv1ykpEN0n0edey0IXCYVs1bqJBmp4e13kpzOLLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnSyluzPUFdnYmnF2VEkvRz9Lu+ul3LeUCvTRbYz6jsr42XnfgPftBZyW/xNEyUt5i6jWM+dCJ5+59+v5u9xAXqLMeFOXacQIwCSmNHkOwMq1x7kIhb2oR7Ux+QtSbane6R42nBtpnGa/4Vdj3LcUZvdyno1vm3N7uBH6nYYC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hCwLhe3b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60F7X8Om025535;
	Thu, 15 Jan 2026 18:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gwuVqC
	T7iZGkHd7Sv7XmKHKKbbLd6xZCAKVU7ZoQhNY=; b=hCwLhe3bsQ97Yf1D9AqNND
	OJ7dDPBDb9MCzORac+A+lvV9VcbXNHW3a/oV9KM9SIGOAkpMal10+kz0stAIJkUU
	da+WQTQFUGa3lGMztOM/GnCzs3iofGyHLZhJKtOSYFuFCN0KEUQGWCpUQBUJoKJk
	BtUsQzJEBM3idg/ObKEymMOV28mLnADfqjz308RtFBDPENhrN9DyEGwyWb8sX1Yp
	tcWwz6RcU4u2DKUljpcEzHvN1IbzhUmLl+tHjh4fmFGBTTCnvONIxTIBPHRwj7/x
	0csBLGSi6F4oX1egoizzsjklQbgvQOTmoTRUZp8297r6ubTfWyatiukOBZQObZ8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6efp72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 18:28:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60FIDxAv030146;
	Thu, 15 Jan 2026 18:28:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ak1hgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 18:28:03 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60FIS2Rc31392352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:28:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D969A5805D;
	Thu, 15 Jan 2026 18:28:02 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D4458052;
	Thu, 15 Jan 2026 18:28:02 +0000 (GMT)
Received: from [9.61.249.104] (unknown [9.61.249.104])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Jan 2026 18:28:02 +0000 (GMT)
Message-ID: <9a8a8294-cdd7-48b1-ad69-297ad905a1c3@linux.ibm.com>
Date: Thu, 15 Jan 2026 10:28:01 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] Error recovery for vfio-pci devices on s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260107183217.1365-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260107183217.1365-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sXBbkBN-60RKF4QOMwOuBvvfjF7dQaY5
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=696931b4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=V0HI7nMEepYQZMZ9NQAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE0MSBTYWx0ZWRfX4Yo2cP8m2vDU
 Ns3A5FexAVmvZ5TxP/kYmsKraOsMJFObPMgJdWFyo3laFQtZbyX2xhWU9nXH/mR0/J/gEN+c/DO
 m3L5k4f7HlFzVXuAgwDUqEkvLfAGM4nVnE900H6cf1r5TJU0H7RJGsqagdFQ0rbeSXxALguzn24
 RLCGvGJ1yP2SHZ8vwzHqbwokDrZj6IYqJt8bbsx8Ag32YR1CIJaj5BoZT5CIlQ8IQDRiCxr5GNH
 tO0Mx1xp+6McEdtIeQ5bys7qANuz7ZMHb1vihbx7FCyuJ2REdyamztpkCb5FgPxMnEfRnGpvrWm
 nF/b99qoY/Wr357bIbtCYH4INSonm6M5vipvyET812GiSIQU0MPDEe/T8JbwzUNd3QPEowmVbdR
 GeP7ZbOHpcO7A0ELbGl8yxOKQCPGkbFd0+NKryNHn/kt0bhxrDJGi0Q78nB1vvRCdnwTcpHydZf
 3so7mP9oBPMFjewJQ/A==
X-Proofpoint-ORIG-GUID: sXBbkBN-60RKF4QOMwOuBvvfjF7dQaY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601150141

Polite ping :)... would appreciate some feedback on this patch series.

Thanks

Farhan


On 1/7/2026 10:32 AM, Farhan Ali wrote:
> Hi,
>
> This Linux kernel patch series introduces support for error recovery for
> passthrough PCI devices on System Z (s390x).
>
> Background
> ----------
> For PCI devices on s390x an operating system receives platform specific
> error events from firmware rather than through AER.Today for
> passthrough/userspace devices, we don't attempt any error recovery and
> ignore any error events for the devices. The passthrough/userspace devices
> are managed by the vfio-pci driver. The driver does register error handling
> callbacks (error_detected), and on an error trigger an eventfd to
> userspace.  But we need a mechanism to notify userspace
> (QEMU/guest/userspace drivers) about the error event.
>
> Proposal
> --------
> We can expose this error information (currently only the PCI Error Code)
> via a device feature. Userspace can then obtain the error information
> via VFIO_DEVICE_FEATURE ioctl and take appropriate actions such as driving
> a device reset.
>
> This is how a typical flow for passthrough devices to a VM would work:
> For passthrough devices to a VM, the driver bound to the device on the host
> is vfio-pci. vfio-pci driver does support the error_detected() callback
> (vfio_pci_core_aer_err_detected()), and on an PCI error s390x recovery
> code on the host will call the vfio-pci error_detected() callback. The
> vfio-pci error_detected() callback will notify userspace/QEMU via an
> eventfd, and return PCI_ERS_RESULT_CAN_RECOVER. At this point the s390x
> error recovery on the host will skip any further action(see patch 6) and
> let userspace drive the error recovery.
>
> Once userspace/QEMU is notified, it then injects this error into the VM
> so device drivers in the VM can take recovery actions. For example for a
> passthrough NVMe device, the VM's OS NVMe driver will access the device.
> At this point the VM's NVMe driver's error_detected() will drive the
> recovery by returning PCI_ERS_RESULT_NEED_RESET, and the s390x error
> recovery in the VM's OS will try to do a reset. Resets are privileged
> operations and so the VM will need intervention from QEMU to perform the
> reset. QEMU will invoke the VFIO_DEVICE_RESET ioctl to now notify the
> host that the VM is requesting a reset of the device. The vfio-pci driver
> on the host will then perform the reset on the device to recover it.
>
>
> Thanks
> Farhan
>
> ChangeLog
> ---------
> v6 series https://lore.kernel.org/all/2c609e61-1861-4bf3-b019-a11c137d26a5@linux.ibm.com/
> v6 -> v7
>      - Rebase on 6.19-rc4
>
>      - Update commit message based on Niklas's suggestion (patch 3).
>
> v5 series https://lore.kernel.org/all/20251113183502.2388-1-alifm@linux.ibm.com/
> v5 -> v6
>     - Rebase on 6.18 + Lukas's PCI: Universal error recoverability of
>     devices series (https://lore.kernel.org/all/cover.1763483367.git.lukas@wunner.de/)
>
>     - Re-work config space accessibility check to pci_dev_save_and_disable() (patch 3).
>     This avoids saving the config space, in the reset path, if the device's config space is
>     corrupted or inaccessible.
>
> v4 series https://lore.kernel.org/all/20250924171628.826-1-alifm@linux.ibm.com/
> v4 -> v5
>      - Rebase on 6.18-rc5
>
>      - Move bug fixes to the beginning of the series (patch 1 and 2). These patches
>      were posted as a separate fixes series
> https://lore.kernel.org/all/a14936ac-47d6-461b-816f-0fd66f869b0f@linux.ibm.com/
>
>      - Add matching pci_put_dev() for pci_get_slot() (patch 6).
>
> v3 series https://lore.kernel.org/all/20250911183307.1910-1-alifm@linux.ibm.com/
> v3 -> v4
>      - Remove warn messages for each PCI capability not restored (patch 1)
>
>      - Check PCI_COMMAND and PCI_STATUS register for error value instead of device id
>      (patch 1)
>
>      - Fix kernel crash in patch 3
>
>      - Added reviewed by tags
>
>      - Address comments from Niklas's (patches 4, 5, 7)
>
>      - Fix compilation error non s390x system (patch 8)
>
>      - Explicitly align struct vfio_device_feature_zpci_err (patch 8)
>
>
> v2 series https://lore.kernel.org/all/20250825171226.1602-1-alifm@linux.ibm.com/
> v2 -> v3
>     - Patch 1 avoids saving any config space state if the device is in error
>     (suggested by Alex)
>
>     - Patch 2 adds additional check only for FLR reset to try other function
>       reset method (suggested by Alex).
>
>     - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
>       functions. Creates a new flag pci_slot to allow per function slot.
>
>     - Patch 4 fixes a bug in s390 for resource to bus address translation.
>
>     - Rebase on 6.17-rc5
>
>
> v1 series https://lore.kernel.org/all/20250813170821.1115-1-alifm@linux.ibm.com/
> v1 - > v2
>     - Patches 1 and 2 adds some additional checks for FLR/PM reset to
>       try other function reset method (suggested by Alex).
>
>     - Patch 3 fixes a bug in s390 for resetting PCI devices with multiple
>       functions.
>
>     - Patch 7 adds a new device feature for zPCI devices for the VFIO_DEVICE_FEATURE
>       ioctl. The ioctl is used by userspace to retriece any PCI error
>       information for the device (suggested by Alex).
>
>     - Patch 8 adds a reset_done() callback for the vfio-pci driver, to
>       restore the state of the device after a reset.
>
>     - Patch 9 removes the pcie check for triggering VFIO_PCI_ERR_IRQ_INDEX.
>
>
> Farhan Ali (9):
>    PCI: Allow per function PCI slots
>    s390/pci: Add architecture specific resource/bus address translation
>    PCI: Avoid saving config space state if inaccessible
>    PCI: Add additional checks for flr reset
>    s390/pci: Update the logic for detecting passthrough device
>    s390/pci: Store PCI error information for passthrough devices
>    vfio-pci/zdev: Add a device feature for error information
>    vfio: Add a reset_done callback for vfio-pci driver
>    vfio: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
>
>   arch/s390/include/asm/pci.h       |  29 ++++++++
>   arch/s390/pci/pci.c               |  75 +++++++++++++++++++++
>   arch/s390/pci/pci_event.c         | 107 +++++++++++++++++-------------
>   drivers/pci/host-bridge.c         |   4 +-
>   drivers/pci/pci.c                 |  19 +++++-
>   drivers/pci/slot.c                |  25 ++++++-
>   drivers/vfio/pci/vfio_pci_core.c  |  20 ++++--
>   drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
>   drivers/vfio/pci/vfio_pci_priv.h  |   9 +++
>   drivers/vfio/pci/vfio_pci_zdev.c  |  45 ++++++++++++-
>   include/linux/pci.h               |   1 +
>   include/uapi/linux/vfio.h         |  16 +++++
>   12 files changed, 292 insertions(+), 61 deletions(-)
>

