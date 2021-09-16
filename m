Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CFE40D64F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhIPJfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 05:35:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235542AbhIPJfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 05:35:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18G9GfDV006316;
        Thu, 16 Sep 2021 05:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=r9OG6TSx7GqHi2jrRlhAwzVd7/0hn51XFl8RIG36ITo=;
 b=Ro5EGIhIOjhdYpE0sbVP/1i9Ok+zkbME2sEQsfsnLuTaf5Q6hMFmoEw6W18GoKC14/no
 BigbapGIoueCdBNqGtnWs0nNXUIuC8hu2R9HnPa/V/JfbMRLx0FZrGcm54RGSf96jtWn
 BhQ6NdRdztA4lfoulAxyxFjdqJeg3l++8r+AnqvC28bkrK/KZTRC3d9gS0iXfSClQC7J
 G0MZ2wyjsUmsDQhQGUkr1CaXa5CNYh2fY+nJay5ZRpykBbM6gdspXAUZOXQnwPMGz/e6
 fwfx2ozsJEXdaCk3pKFGBCIkUhNQGiS+1sPtQd0y/THKUWs0dqgEFeI/RDa/eN+L0V8R 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b3xguxtqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:44 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18G97NJZ024372;
        Thu, 16 Sep 2021 05:33:43 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b3xguxtq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 05:33:43 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18G9Wttd012324;
        Thu, 16 Sep 2021 09:33:41 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3b0m3a05s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 09:33:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18G9XbkV57540946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 09:33:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D69B42056;
        Thu, 16 Sep 2021 09:33:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 027D04204C;
        Thu, 16 Sep 2021 09:33:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Sep 2021 09:33:36 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 0/4] s390/pci: automatic error recovery
Date:   Thu, 16 Sep 2021 11:33:32 +0200
Message-Id: <20210916093336.2895602-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a7llqadT7YQjRrQz2mjySxZ3-yR-t2il
X-Proofpoint-ORIG-GUID: oEwaT8bDkHdyLlRCVyS9IOeYGRwKqmg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=806
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160019
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series implements automatic error recovery for PCI devices on s390
following the scheme outlined at Documentation/PCI/pci-error-recovery.rst
it applies on top of currenct v5.15-rc1.

The patches are almost completely s390 specific except for one patch
exporting existing functionality for use by arch/s390/pci/ code. Nevertheless
I would appreciate any feedback. This is down from two common code changes in
the first version of this series.

The outline of the patches is as follows:

Patch 1 and 2 add s390 specific code implementing a reset mechanism that
takes the PCI function out of the platform specific error state.

Patch 3 "PCI: Export pci_dev_lock()" is basically an extension to commit
e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()") which
already exported pci_dev_trylock(). In the final patch we make use of
pci_dev_lock() to wait for any other exclusive uses of the pdev to be finished
before starting recovery.

Finally Patch 4 implements the recovery flow as part of the existing s390
specific PCI availability and error event mechanism. Previously the error event
handler only set pdev->error_state and required manual intervention to make the
device usable again. Now we handle the case where firmware has already reset
a PCI function after an error was encountered informing the OS that it should
be ready to be used again. In that case if the driver supports error recovery
we use it to transparently reset the device or simply take it out of the error
state and then if possible let the driver resume operations.

Note that the same event is also issued by the hypervisor if the function was
previously taken into a service mode for example for firmware upgrade via the
hypervisor and is now ready to be used again.

Changes since v1:
- Dropped the patch moving pci_dev_is_added(), we can rely on pdev->driver
  being unset for a device that has already been removed or not yet
  initialized. While I believe pci_dev_is_added() would still be a cleaner
  check we need to check for a bound driver anyway and that is sufficient.
- Adapted the hotplug_slot_ops::reset_slot() signature to current upstream
  taking a bool instead of an int
- Added a missing parameter documentation and reworded some comments
- Reworded some debug/info messages

Thanks,
Niklas Schnelle

Niklas Schnelle (4):
  s390/pci: refresh function handle in iomap
  s390/pci: implement reset_slot for hotplug slot
  PCI: Export pci_dev_lock()
  s390/pci: implement minimal PCI error recovery

 arch/s390/include/asm/pci.h        |   6 +-
 arch/s390/pci/pci.c                | 143 +++++++++++++++++++++-
 arch/s390/pci/pci_event.c          | 188 ++++++++++++++++++++++++++++-
 arch/s390/pci/pci_insn.c           |   4 +-
 arch/s390/pci/pci_irq.c            |   9 ++
 drivers/pci/hotplug/s390_pci_hpc.c |  24 ++++
 drivers/pci/pci.c                  |   3 +-
 include/linux/pci.h                |   1 +
 8 files changed, 366 insertions(+), 12 deletions(-)

-- 
2.25.1

