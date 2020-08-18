Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1424875B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 16:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHROZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 10:25:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbgHROZH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:07 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 2DA3684C42A72950CADE;
        Tue, 18 Aug 2020 15:25:05 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 15:25:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <martin@geanix.com>,
        Ingo Molnar <mingo@redhat.com>, <linux-ia64@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 0/6]  ACPI: Only create NUMA nodes from entries in SRAT or SRAT emulation.
Date:   Tue, 18 Aug 2020 22:24:24 +0800
Message-ID: <20200818142430.1156547-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a trivial rebase and resend of V2 now the merge window has closed.

Here, I will use the term Proximity Domains for the ACPI description and
NUMA Nodes for the in kernel representation.

ACPI 6.3 included a clarification that only Static Resource Allocation
Structures in SRAT may define the existence of proximity domains
(sec 5.2.16). This clarification closed a possible interpretation that
other parts of ACPI (e.g. DSDT _PXM, NFIT etc) could define new proximity
domains that were not also mentioned in SRAT structures.

In practice the kernel has never allowed this alternative interpretation as
such nodes are only partially initialized. This is architecture specific
but to take an example, on x86 alloc_node_data has not been called.
Any use of them for node specific allocation, will result in a crash as the
infrastructure to fallback to a node with memory is not setup.

We ran into a problem when enabling _PXM handling for PCI devices and found
there were boards out there advertising devices in proximity domains that
didn't exist [2].

The fix suggested in this series is to replace instances that should not
'create' new nodes with pxm_to_node.  This function needs a some additional
hardening against invalid inputs to make sure it is safe for use in these
new callers.

Patch 1 Hardens pxm_to_node() against numa_off, and pxm entry being too large.

Patch 2-4 change the various callers not related to SRAT entries so that they
set this parameter to false, so do not attempt to initialize a new NUMA node
if the relevant one does not already exist.

Patch 5 is a function rename to reflect change in functionality of
acpi_map_pxm_to_online_node() as it no longer creates a new map, but just does a
lookup of existing maps.

Patch 6 covers the one place we do not allow the full flexibility defined
in the ACPI spec.  For SRAT GIC Interrupt Translation Service (ITS) Affinity
Structures, on ARM64, the driver currently makes an additional pass of SRAT
later in the boot than the one used to identify NUMA domains.
Note, this currently means that an ITS placed in a proximity domain that is
not defined by another SRAT structure will result in the a crash.

To avoid this crash with minimal changes we do not create new NUMA nodes based
on this particular entry type.  Any current platform trying to do this will not
boot, so this is an improvement, if perhaps not a perfect solution.

[1] Note in ACPI Specification 6.3 5.2.16 System Resource Affinity Table (SRAT)
[2] https://patchwork.kernel.org/patch/10597777/

Thanks to Bjorn Helgaas for review of v1 and Barry Song for internal reviews that
lead to a slightly different approach for this v2.

Changes since v2.
* Trivial rebase to v5.9-rc1
* Collect up tags.

Changes since v1.
* Use pxm_to_node for what was previously the path using acpi_map_pxm_to_node
  with create==false. (Barry)
* Broke patch up into an initial noop stage followed by patches (Bjorn)
  to update each type of case in which partial creation of NUMA nodes is prevented.
* Added patch 5 to rename function to reflect change of functionality.
* Updated descriptions (now mostly in individual patches) inline with Bjorn's comments.

Jonathan Cameron (6):
  ACPI: Add out of bounds and numa_off protections to pxm_to_node
  ACPI: Do not create new NUMA domains from ACPI static tables that are
    not SRAT
  ACPI: Remove side effect of partly creating a node in
    acpi_map_pxm_to_online_node
  ACPI: Rename acpi_map_pxm_to_online_node to pxm_to_online_node
  ACPI: Remove side effect of partly creating a node in acpi_get_node
  irq-chip/gic-v3-its: Fix crash if ITS is in a proximity domain without
    processor or memory

 drivers/acpi/arm64/iort.c        |  2 +-
 drivers/acpi/nfit/core.c         |  6 ++----
 drivers/acpi/numa/hmat.c         |  4 ++--
 drivers/acpi/numa/srat.c         |  4 ++--
 drivers/iommu/intel/dmar.c       |  2 +-
 drivers/irqchip/irq-gic-v3-its.c |  7 ++++++-
 include/linux/acpi.h             | 15 +++++++--------
 7 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.19.1

