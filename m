Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB43B16F6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 03:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfIMBOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 21:14:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:29376 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMBOn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Sep 2019 21:14:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 18:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="197403690"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 18:14:42 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        hpa@zytor.com, alex.williamson@redhat.com, jgg@mellanox.com
Cc:     ashok.raj@intel.com, megha.dey@intel.com, jacob.jun.pan@intel.com,
        Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 0/7] Add support for a new IMS interrupt mechanism
Date:   Thu, 12 Sep 2019 18:32:01 -0700
Message-Id: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, MSI (Message signaled interrupts) and MSI-X are the de facto
standard for device interrupt mechanism. MSI-X supports up to 2048
interrupts per device while MSI supports 32, which seems more than enough
for current devices. However, the introduction of SIOV (Scalable IO
virtualization) shifts the creation of assignable virtual devices from
hardware to a more software assisted approach. This flexible composition
of direct assignable devices, a.k.a. assignable device interfaces (ADIs)
unchains hardware from costly PCI standard. Under SIOV, device resource
can now be mapped directly to a guest or other user space drivers for
near native DMA performance. To complete functionality of ADIs, a matching
interrupt resource must also be introduced which will be scalable.

Interrupt message storage (IMS) is conceived  as a scalable albeit device
specific interrupt mechanism to meet such a demand. With IMS, there is
theoretically no upper bound on the number of interrupts which a device
can support. The size and location of IMS is device-specific; some devices
may implement IMS as on-device storage which are memory-mapped, others may
opt to implement IMS in system memory. IMS stores each interrupt message as
a DWORD size data payload and a 64-bit address(same as MSI-X). Access to
the IMS is through the host driver due to the non-architectural nature of
device IMS unlike the architectural MSI-X table which are accessed through
PCI drivers.

In this patchset, we introduce generic IMS APIs that fits the Linux IRQ
subsystem, supports IMS IRQ chip and domains that can be used by drivers
which are capable of generating IMS interrupts.

The IMS has been introduced as part of Intel's Scalable I/O virtualization
specification:
https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification

This patchset is based on Linux 5.3-rc8.

Currently there is no device out in the market which supports SIOV (Hence no
device supports IMS).

This series is a basic patchset to get the ball rolling and receive some
inital comments. As per my discussion with Marc Zyngier and Thomas Gleixner
at the Linux Plumbers, I need to do the following:
1. Since a device can support MSI-X and IMS simultaneously, ensure proper
   locking mechanism for the 'msi_list' in the device structure.
2. Introduce dynamic allocation of IMS vectors perhaps by using a group ID
3. IMS support of a device needs to be discoverable. A bit in the vendor
   specific capability in the PCI config is to be added rather than getting
   this information from each device driver.

Jason Gunthorpe of Mellanox technologies is looking to do something similar
on ARM platforms and was wondering why IMS is x86 sepcific. Perhaps we can
use this thread to discuss further on this. 

Megha Dey (7):
  genirq/msi: Differentiate between various MSI based interrupts
  drivers/base: Introduce callbacks for IMS interrupt domain
  x86/ims: Add support for a new IMS irq domain
  irq_remapping: New interfaces to support IMS irqdomain
  x86/ims: Introduce x86_ims_ops
  ims-msi: Add APIs to allocate/free IMS interrupts
  ims: Add the set_desc callback

 arch/mips/pci/msi-xlp.c              |   2 +-
 arch/s390/pci/pci_irq.c              |   2 +-
 arch/x86/include/asm/irq_remapping.h |  13 ++
 arch/x86/include/asm/msi.h           |   4 +
 arch/x86/include/asm/pci.h           |   4 +
 arch/x86/include/asm/x86_init.h      |  10 +
 arch/x86/kernel/apic/Makefile        |   1 +
 arch/x86/kernel/apic/ims.c           | 118 ++++++++++++
 arch/x86/kernel/apic/msi.c           |   6 +-
 arch/x86/kernel/x86_init.c           |  23 +++
 arch/x86/pci/xen.c                   |   2 +-
 drivers/base/Kconfig                 |   7 +
 drivers/base/Makefile                |   1 +
 drivers/base/ims-msi.c               | 353 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel_irq_remapping.c  |  30 +++
 drivers/iommu/irq_remapping.c        |   9 +
 drivers/iommu/irq_remapping.h        |   3 +
 drivers/pci/msi.c                    |  19 +-
 drivers/vfio/mdev/mdev_core.c        |   6 +
 drivers/vfio/mdev/mdev_private.h     |   1 -
 include/linux/intel-iommu.h          |   1 +
 include/linux/mdev.h                 |   2 +
 include/linux/msi.h                  |  55 +++++-
 kernel/irq/msi.c                     |   2 +-
 24 files changed, 655 insertions(+), 19 deletions(-)
 create mode 100644 arch/x86/kernel/apic/ims.c
 create mode 100644 drivers/base/ims-msi.c

-- 
2.7.4

