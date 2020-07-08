Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9521862F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGHLcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 07:32:53 -0400
Received: from foss.arm.com ([217.140.110.172]:34012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgGHLcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jul 2020 07:32:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8752B31B;
        Wed,  8 Jul 2020 04:32:52 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FD373F68F;
        Wed,  8 Jul 2020 04:32:51 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        jonathan.lemon@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] iommu/intel: Avoid SAC address trick for PCIe devices
Date:   Wed,  8 Jul 2020 12:32:41 +0100
Message-Id: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For devices stuck behind a conventional PCI bus, saving extra cycles at
33MHz is probably fairly significant. However since native PCI Express
is now the norm for high-performance devices, the optimisation to always
prefer 32-bit addresses for the sake of avoiding DAC is starting to look
rather anachronistic. Technically 32-bit addresses do have shorter TLPs
on PCIe, but unless the device is saturating its link bandwidth with
small transfers it seems unlikely that the difference is appreciable.

What definitely is appreciable, however, is that the IOVA allocator
doesn't behave all that well once the 32-bit space starts getting full.
As DMA working sets get bigger, this optimisation increasingly backfires
and adds considerable overhead to the dma_map path for use-cases like
high-bandwidth networking.

As such, let's simply take it out of consideration for PCIe devices.
Technically this might work out suboptimal for a PCIe device stuck
behind a conventional PCI bridge, or for PCI-X devices that also have
native 64-bit addressing, but neither of those are likely to be found
in performance-critical parts of modern systems.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/intel/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9129663a7406..21b11de23a53 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3348,7 +3348,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	/* Ensure we reserve the whole size-aligned region */
 	nrpages = __roundup_pow_of_two(nrpages);
 
-	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32)) {
+	if (!dmar_forcedac && dma_mask > DMA_BIT_MASK(32) &&
+	    dev_is_pci(dev) && !pci_is_pcie(to_pci_dev(dev))) {
 		/*
 		 * First try to allocate an io virtual address in
 		 * DMA_BIT_MASK(32) and if that fails then try allocating
-- 
2.23.0.dirty

