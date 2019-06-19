Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA494C32D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSVlg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:41:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:28113 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfFSVlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:41:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="170683440"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2019 14:41:35 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com, Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 0/6] Introduce dynamic allocation/freeing of MSI-X vectors
Date:   Wed, 19 Jun 2019 15:03:38 -0700
Message-Id: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, MSI-X vector enabling and allocation for a PCIe device is
static i.e. a device driver gets only one chance to enable a specific
number of MSI-X vectors, usually during device probe. Also, in many
cases, drivers usually reserve more than required number of vectors
anticipating their use, which unnecessarily blocks resources that
could have been made available to other devices. Lastly, there is no
way for drivers to reserve more vectors, if the MSI-x has already been
enabled for that device.
 
Hence, a dynamic MSI-X kernel infrastructure can benefit drivers by
deferring MSI-X allocation to post probe phase, where actual demand
information is available.
 
This patchset enables the dynamic allocation/de-allocation of MSI-X
vectors by introducing 2 new APIs:
pci_alloc_irq_vectors_dyn() and pci_free_irq_vectors_grp():

We have had requests from some of the NIC/RDMA users who have lots of
interrupt resources and would like to allocate them on demand,
instead of using an all or none approach.

The APIs are fairly well tested (multiple allocations/deallocations),
but we have no early adopters yet. Hence, sending this series as an
RFC for review and comments.

The patches are based out of Linux 5.2-rc5.

Megha Dey (6):
  PCI/MSI: New structures/macros for dynamic MSI-X allocation
  PCI/MSI: Dynamic allocation of MSI-X vectors by group
  x86: Introduce the dynamic teardown function
  PCI/MSI: Introduce new structure to manage MSI-x entries
  PCI/MSI: Free MSI-X resources by group
  Documentation: PCI/MSI: Document dynamic MSI-X infrastructure

 Documentation/PCI/MSI-HOWTO.txt |  38 +++++
 arch/x86/include/asm/x86_init.h |   1 +
 arch/x86/kernel/x86_init.c      |   6 +
 drivers/pci/msi.c               | 363 +++++++++++++++++++++++++++++++++++++---
 drivers/pci/probe.c             |   9 +
 include/linux/device.h          |   3 +
 include/linux/msi.h             |  13 ++
 include/linux/pci.h             |  61 +++++++
 kernel/irq/msi.c                |  34 +++-
 9 files changed, 497 insertions(+), 31 deletions(-)

-- 
2.7.4

