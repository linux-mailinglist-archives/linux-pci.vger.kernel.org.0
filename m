Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7512DD5D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jan 2020 03:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAAC1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 21:27:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:65216 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgAAC1B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Dec 2019 21:27:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2019 18:27:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,381,1571727600"; 
   d="scan'208";a="221068054"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.83])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2019 18:27:00 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 0/5] Clean up VMD DMA Map Ops
Date:   Tue, 31 Dec 2019 13:24:18 -0700
Message-Id: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Inspired by Christoph's last set:
https://lkml.org/lkml/2019/8/28/667

VMD currently works with VT-d enabled by pointing DMA and IOMMU actions at the
VMD endpoint. The problem with this approach is that the VMD endpoint's
device-specific attributes, such as the dma mask, are used instead.

This set cleans up VMD by removing the override that redirects dma map
operations to the VMD endpoint. Instead it introduces a new dma alias mechanism
into the existing dma alias infrastructure.

Patch 1 and 2 are miscellaneous fixes discovered during development.
Patch 1 is ready, but 2 likely doesn't go far enough for proper teardown on
addition failure.

Jon Derrick (5):
  iommu: Remove device link to group on failure
  iommu/vt-d: Unlink device if failed to add to group
  x86/PCI: Expose VMD's device in pci_sysdata
  PCI: vmd: Stop overriding dma_map_ops
  x86/PCI: Remove unused X86_DEV_DMA_OPS

 arch/x86/Kconfig               |   3 -
 arch/x86/include/asm/device.h  |  10 ---
 arch/x86/include/asm/pci.h     |   4 +-
 arch/x86/pci/common.c          |  44 ++----------
 drivers/iommu/intel-iommu.c    |  26 ++++---
 drivers/iommu/iommu.c          |   1 +
 drivers/pci/controller/Kconfig |   1 -
 drivers/pci/controller/vmd.c   | 152 +----------------------------------------
 drivers/pci/pci.c              |   4 +-
 drivers/pci/search.c           |   6 ++
 include/linux/pci.h            |   1 +
 11 files changed, 37 insertions(+), 215 deletions(-)

-- 
1.8.3.1

