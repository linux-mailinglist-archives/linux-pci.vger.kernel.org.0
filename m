Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6626E1361CF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgAIUdm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 15:33:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:37112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgAIUdm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 15:33:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 12:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396206706"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.226])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 12:33:41 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 0/5] Clean up VMD DMA Map Ops
Date:   Thu,  9 Jan 2020 07:30:51 -0700
Message-Id: <1578580256-3483-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v1 Set: https://lore.kernel.org/linux-iommu/20200107134125.GD30750@8bytes.org/T/#t

This revision introduces a new weak function to reference the dma alias, as
well as using the struct device rather than the pci_dev. By using the weak
function in this manner, we remove the need to add a pointer in struct device
or pci_dev. Weak functions are generally frowned upon when it's a single
architecture implementation, so I am open to alternatives.

v1 Blurb:
VMD currently works with VT-d enabled by pointing DMA and IOMMU actions at the
VMD endpoint. The problem with this approach is that the VMD endpoint's
device-specific attributes, such as the dma mask, are used instead.

This set cleans up VMD by removing the override that redirects dma map
operations to the VMD endpoint. Instead it introduces a new dma alias mechanism
into the existing dma alias infrastructure.

Changes from v1:
Removed 1/5 & 2/5 misc fix patches that were merged
Uses Christoph's staging/cleanup patches
Introduce weak function rather than including pointer in struct device or pci_dev.

Based on Joerg's next:
https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/

Christoph Hellwig (2):
  x86/pci: Add a to_pci_sysdata helper
  x86/pci: Replace the vmd_domain field with a vmd_dev pointer

Jon Derrick (3):
  PCI: Introduce direct dma alias
  PCI: vmd: Stop overriding dma_map_ops
  x86/pci: Remove X86_DEV_DMA_OPS

 arch/x86/Kconfig               |   3 -
 arch/x86/include/asm/device.h  |  10 ---
 arch/x86/include/asm/pci.h     |  31 ++++-----
 arch/x86/pci/common.c          |  45 ++----------
 drivers/iommu/intel-iommu.c    |  17 +++--
 drivers/pci/controller/Kconfig |   1 -
 drivers/pci/controller/vmd.c   | 152 +----------------------------------------
 drivers/pci/pci.c              |  17 ++++-
 drivers/pci/search.c           |   9 +++
 include/linux/pci.h            |   1 +
 10 files changed, 60 insertions(+), 226 deletions(-)

-- 
1.8.3.1

