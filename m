Return-Path: <linux-pci+bounces-19540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39545A05DA0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DD01881CB0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420A71FC7C6;
	Wed,  8 Jan 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJDBvCZc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675D1FC7EE
	for <linux-pci@vger.kernel.org>; Wed,  8 Jan 2025 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736344553; cv=none; b=jNCD04Q0W7iSTQoRwiggvqPr/dWEK6qQhQERX+jGGG5QQFZWwfICUJ5NfYPl4o0mkMDUW5A4bSIpP58H9XRmhOvPGla5N/SrBBrZb64ZyXnbMdoWjEjEWYJ31RGoRoD3tMW1hYxmV8vQn8NZHQDgGCT7uLeRuwxxCJHGhIwOnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736344553; c=relaxed/simple;
	bh=k4n+IqYftO8PAghaxhchrW/hsN2i7khIUG0tFm7MgwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arIzrWbVfNtUqYjamI6ZyZS6QczGSllUpn4ffWkfUuetEesIzgzwDX2eIH5gTCY7VezVQP0BM2xZ6vqcchjEcSsdhSFktEz2M76ivUXj1Q7qsUBBtCI1t0HpYwV4jWfJfGewTYriOKVrY+zLyezP57/kzvLFBYaWtzFYNbMmWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OJDBvCZc; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081ttqx015396;
	Wed, 8 Jan 2025 13:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=NhJ0nF7+Ycqa0VJ1ye10iytDolCwL
	Ret5L+4VcjuogQ=; b=OJDBvCZcLfH0EbhMK0MibhMdSquGDGJuqRSQsYmZVFnlJ
	zdjYnyzKtOgv3/Jw1WIGaTdELSb05mkivc8CdrrP02+sVHR+mfzJDJQdcFFqgUGW
	e1CQgVoLoI8B2l0xZHxdKsAIhDaH1HJf9ctNldBiV7k2KXJp18+/Db4r+DjuykFE
	1EYThyAGRa4pVLd4QhSqI0a88w9TfsEILMMRdaPnWVMDR893vSBIU45H6rBkZgWi
	vBLoWNCU8R8vnG+Fup5kDWEd3lP1WT5q+Z4/ejKCK4AUonrVHgxqR7r5TH6wfpHK
	YmWBiy98honirOkrAt+eGrjRAmlpNj1gO4vuo/8eA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk074rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508C7Dp2026550;
	Wed, 8 Jan 2025 13:55:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuea1g6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 13:55:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 508Dtjwu011911;
	Wed, 8 Jan 2025 13:55:45 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 43xuea1g3k-1;
	Wed, 08 Jan 2025 13:55:45 +0000
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>
Subject: [PATCH RESEND 0/4] Rate limit reporting of Correctable Errors
Date: Wed,  8 Jan 2025 13:55:30 +0000
Message-ID: <cover.1736341506.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_03,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080115
X-Proofpoint-ORIG-GUID: C6yGB52wiG0ZMTYWtFfukL-CpG1ABiRg
X-Proofpoint-GUID: C6yGB52wiG0ZMTYWtFfukL-CpG1ABiRg

This is a resend of RFC, all patches apply cleanly on the top of
pci-next. I adjusted the series title, there are no functional
changes.

TL;DR
====

We are getting multiple reports about excessive logging of Correctable
Errors with no clear common root cause. As these errors are already
corrected by hardware, it makes sense to limit them. Introduce
a ratelimit state definition to pci_dev to control the number of
messages reported by a Root Port within a specified time interval.
The series adds other improvements in the area, as outlined in the
Proposal section.

Introduction
============

PCIe devices are expected to detect and report errors related to
transactions they participate in. If an error is discovered,
the device creates an Error Message and sends it to the Root Port
which, in turn, generates an interrupt upon receiving it. The
AER driver services such an interrupt by logging the error and
performing recovery work if needed. This means that every time
an error is detected, potentially every transaction, it gets
reported. But not all errors are of the same significance. We can
categorize them into errors from which the hardware can recover
(Correctable), and errors that require software intervention and
impact the functionality of the interface (Uncorrectable). While
informing about the latter is essential, reports of Correctable
Errors are purely informational. Such logs can helpful in monitoring
the stability of the link but if such errors are reported too
frequently, they pollute the logs and overshadow failures that require
our attention.

Background
==========

The excessive logging of AER Correctable Errors has been reported
many times in the past, across different devices, with no obvious
common root cause: [1], [2], [3] and more. There is no easy way to
control the rate of reported errors, so the end users would go for
workarounds, such as disabling AER feature, or creating scripts to
directly disable generating messages for Correctable Errors per
device[4]. In the majority of cases, lowering the rate at which
such errors are reported, should be enough to elevate the symptoms.

Previous Work
=============

The series submitted by Grant Grundler[5] attempted to rate limit
messages by using a ratelimited variant of pci_info wrapper. Although
this change lowers the volume of specific prinkts, the rate limiting
does not work globally, and messages could appear out of sync.
The desired solution is to introduce a manually managed ratelimit_state,
which would be used every time a Correctable Error is signaled.

Proposal
========

To overcome the limitations of per-printk-call state, this series
introduces a ratelimit state definition and uses it to decide if
a registered Correctable Error should be reported. Initially, we
allow to report one error per 2 seconds, and extend that interval
to 30 seconds after reaching the threshold of 1000 Correctable Errors
on a Root Port. The values proposed here are arbitrary and up
for discussion.

If all of this still does not help, we give an option to silence
the messages by exposing a bit in Device Control Register responsible
for Correctable Error Message generation as a sysfs attribute.

The series introduces changes as follows:

  1) Use the same log level across printks when reporting an AER Error

  2) Add a ratelimit_state definition to pci_dev struct to maintain
     the ratelimit state between interrupts. Check it to decide if
     a Correctable Error can be reported

  3) Extend the interval between reported Correctable Errors after
     reaching a threshold. Make this decision based on the value of
     aer_rootport_total_err_cor counter. Add a flag to pci_dev to signal
     this event to avoid continuous updates of the ratelimit interval

  4) Add cor_errs_reporting_enable sysfs attribute to read and write
     the bit controlling the generation of Correctable Error messages
     by the device.

Patches 1-3 depend one on another, patch 4 is a standalone change.

This solution requires modification to pci_dev struct, which can be
deemed invasive. Still, this is the only place capable of maintaining
a stateful ratelimit. The other structure used by aer_isr_one_error,
a function that processes the signaled error, is populated and reused
on each serviced interrupt. An alternative solution would be to have
one global rate limit state in the aforementioned function, but this
definition could be easily abused by one noisy device. It would hit
limit in no time, leaving Correctable Errors, even coming from other
Root Ports, unreported.

Having said that, I am more than happy to discuss other ways of
getting Correctable errors under control.

Results
=======

The patches were tested with aer-inject tool as well as with actual
hardware, Samsung PM1733 NVMe. The disk would generate high volumes of
Correctable Error messages, sometimes as soon as an IRQ was allocated
for it:

[   20.662657] pcieport 0000:00:01.3: AER: Multiple Corrected error
message received from 0000:03:00.0
[   20.677779] pci 0000:03:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, (Receiver ID)
[   20.693003] pci 0000:03:00.0:   device [144d:a824] error
status/mask=00000001/00000000
[   20.706861] pci 0000:03:00.0:    [ 0] RxErr
[   20.718171] pcieport 0000:00:01.3: AER: Multiple Corrected error
message received from 0000:03:00.0
[   20.733303] pci 0000:03:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, (Receiver ID)
[   20.748545] pci 0000:03:00.0:   device [144d:a824] error
status/mask=00000001/00000000
[   20.762421] pci 0000:03:00.0:    [ 0] RxErr
[   20.773733] pcieport 0000:00:01.3: AER: Multiple Corrected error
message received from 0000:03:00.0
[   20.788874] pci 0000:03:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, (Receiver ID)
[   20.804130] pci 0000:03:00.0:   device [144d:a824] error
status/mask=00000001/00000000
[   20.818026] pci 0000:03:00.0:    [ 0] RxErr
[   20.829359] pcieport 0000:00:01.3: AER: Corrected error message
received from 0000:03:00.0
[   20.843615] pci 0000:03:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, (Receiver ID)
[   20.858868] pci 0000:03:00.0:   device [144d:a824] error
status/mask=00000001/00000000
[   20.872752] pci 0000:03:00.0:    [ 0] RxErr

With the basic rate limiting, the dmesg is still populated at the
high rate:

[  248.871792] pcieport 0000:00:01.3: Correctable error message received
from 0000:03:00.0
[  248.871805] nvme 0000:03:00.0: PCIe Bus Error: severity=Correctable,
type=Physical Layer, (Receiver ID)
[  248.871808] nvme 0000:03:00.0:   device [144d:a824] error
status/mask=00000001/00000000
[  248.871811] nvme 0000:03:00.0:    [ 0] RxErr                  (First)
[  251.037039] report_aer_cor_err: 7 callbacks suppressed
[  251.037048] pcieport 0000:00:01.3: Correctable error message received
from 0000:03:00.0
[  251.037061] nvme 0000:03:00.0: PCIe Bus Error: severity=Correctable,
type=Physical Layer, (Receiver ID)
[  251.037064] nvme 0000:03:00.0:   device [144d:a824] error
status/mask=00000001/00000000
[  251.037067] nvme 0000:03:00.0:    [ 0] RxErr                  (First)
[  253.272609] report_aer_cor_err: 5 callbacks suppressed

After the threshold of Correctable Errors is reached, the rate limit
interval is updated:

[  342.528507] pcieport 0000:00:01.3: AER: Over 1000 Correctable Errors
reported, increasing the rate limit
[  371.958275] report_aer_cor_err: 94 callbacks suppressed
[  371.958284] pcieport 0000:00:01.3: Correctable error message received
from 0000:03:00.0
[  371.958297] nvme 0000:03:00.0: PCIe Bus Error: severity=Correctable,
type=Physical Layer, (Receiver ID)
[  371.958300] nvme 0000:03:00.0:   device [144d:a824] error
status/mask=00000001/00000000
[  371.958302] nvme 0000:03:00.0:    [ 0] RxErr                  (First)
[  402.018141] report_aer_cor_err: 89 callbacks suppressed

----------------------
[1] - https://bugzilla.kernel.org/show_bug.cgi?id=215027
[2] - https://bugzilla.kernel.org/show_bug.cgi?id=201517
[3] - https://bugzilla.kernel.org/show_bug.cgi?id=196183
[4] - https://gist.github.com/flisboac/5a0711201311b63d23b292110bb383cd
[5] -
https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/

Karolina Stolarek (4):
  PCI/AER: Use the same log level for all messages
  PCI/AER: Add Correctable Errors rate limiting
  PCI/AER: Increase the rate limit interval after threshold
  PCI: Add 'cor_err_reporting_enable' attribute

 Documentation/ABI/testing/sysfs-bus-pci |   7 ++
 drivers/pci/pci-sysfs.c                 |  42 +++++++++
 drivers/pci/pci.h                       |   2 +-
 drivers/pci/pcie/aer.c                  | 108 ++++++++++++++++--------
 drivers/pci/pcie/dpc.c                  |   2 +-
 include/linux/pci.h                     |   2 +
 6 files changed, 127 insertions(+), 36 deletions(-)

-- 
2.43.5


