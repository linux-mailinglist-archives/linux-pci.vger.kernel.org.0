Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662A9148FDE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 22:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbgAXVCr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 16:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387394AbgAXVCq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jan 2020 16:02:46 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF73F2071E;
        Fri, 24 Jan 2020 21:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579899766;
        bh=ovQ19TCQxYzE5zJTHWmIFSrtTys+P8rRme6GoRfbE6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ge5ByDnuVUhZhhVLf/Y9cQ56BMpHR0ft8p5VVlxFRnCG/Zl7GxrIVVsfGrS+xDxj9
         BvoYVmvnr55ylYhWTRfTvxylxqvKFlTxkLEZ492P67HtCb2FmT2Glo9qd1AoLMbuhl
         YyAjvH18xThF2uWV1LjH5+/itQAzl+BoeVE0e01M=
Date:   Fri, 24 Jan 2020 15:02:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 0/7] Clean up VMD DMA Map Ops
Message-ID: <20200124210244.GA54951@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579613871-301529-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 21, 2020 at 06:37:44AM -0700, Jon Derrick wrote:
> v4 Set: https://lore.kernel.org/linux-pci/20200120110220.GB17267@e121166-lin.cambridge.arm.com/T/#t
> v3 Set: https://lore.kernel.org/linux-iommu/20200113181742.GA27623@e121166-lin.cambridge.arm.com/T/#t
> v2 Set: https://lore.kernel.org/linux-iommu/1578580256-3483-1-git-send-email-jonathan.derrick@intel.com/T/#t
> v1 Set: https://lore.kernel.org/linux-iommu/20200107134125.GD30750@8bytes.org/T/#t
> 
> VMD currently works with VT-d enabled by pointing DMA and IOMMU actions at the
> VMD endpoint. The problem with this approach is that the VMD endpoint's
> device-specific attributes, such as the DMA Mask Bits, are used instead of the
> child device's attributes.
> 
> This set cleans up VMD by removing the override that redirects DMA map
> operations to the VMD endpoint. Instead it introduces a new DMA alias mechanism
> into the existing DMA alias infrastructure. This new DMA alias mechanism allows
> an architecture-specific pci_real_dma_dev() function to provide a pointer from
> a pci_dev to its PCI DMA device, where by default it returns the original
> pci_dev.
> 
> In addition, this set removes the sanity check that was added to prevent
> assigning VMD child devices. By using the DMA alias mechanism, all child
> devices are assigned the same IOMMU group as the VMD endpoint. This removes the
> need for restricting VMD child devices from assignment, as the whole group
> would have to be assigned, requiring unbinding the VMD driver and removing the
> child device domain.
> 
> v1 added a pointer in struct pci_dev that pointed to the DMA alias' struct
> pci_dev and did the necessary DMA alias and IOMMU modifications.
> 
> v2 introduced a new weak function to reference the 'Direct DMA Alias', and
> removed the need to add a pointer in struct device or pci_dev. Weak functions
> are generally frowned upon when it's a single architecture implementation, so I
> am open to alternatives.
> 
> v3 referenced the pci_dev rather than the struct device for the PCI
> 'Direct DMA Alias' (pci_direct_dma_alias()). This revision also allowed
> pci_for_each_dma_alias() to call any DMA aliases for the Direct DMA alias
> device, though I don't expect the VMD endpoint to need intra-bus DMA aliases.
> 
> v4 changes the 'Direct DMA Alias' to instead refer to the 'Real DMA Dev', which
> either returns the PCI device itself or the PCI DMA device.
> 
> v5 Fixes a bad call argument to pci_real_dma_dev that would have broken
> bisection. This revision also changes one of the calls to a one-liner, and
> assembles the same on my system.
> 
> 
> Changes from v4:
> Fix pci_real_dma_dev() call in 4/7.
> Change other pci_real_dma_dev() call in 4/7 to one-liner.
> 
> Changes from v3:
> Uses pci_real_dma_dev() instead of pci_direct_dma_alias()
> Split IOMMU enabling, IOMMU VMD sanity check and VMD dma_map_ops cleanup into three patches
> 
> Changes from v2:
> Uses struct pci_dev for PCI Device 'Direct DMA aliasing' (pci_direct_dma_alias)
> Allows pci_for_each_dma_alias to iterate over the alias mask of the 'Direct DMA alias'
> 
> Changes from v1:
> Removed 1/5 & 2/5 misc fix patches that were merged
> Uses Christoph's staging/cleanup patches
> Introduce weak function rather than including pointer in struct device or pci_dev.
> 
> Based on Bjorn's next:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=next
> 
> Christoph Hellwig (2):
>   x86/PCI: Add a to_pci_sysdata helper
>   x86/PCI: Remove X86_DEV_DMA_OPS
> 
> Jon Derrick (5):
>   x86/PCI: Expose VMD's PCI Device in pci_sysdata
>   PCI: Introduce pci_real_dma_dev()
>   iommu/vt-d: Use pci_real_dma_dev() for mapping
>   iommu/vt-d: Remove VMD child device sanity check
>   PCI: vmd: Stop overriding dma_map_ops
> 
>  arch/x86/Kconfig               |   3 -
>  arch/x86/include/asm/device.h  |  10 ---
>  arch/x86/include/asm/pci.h     |  31 ++++-----
>  arch/x86/pci/common.c          |  48 +++----------
>  drivers/iommu/intel-iommu.c    |  11 ++-
>  drivers/pci/controller/Kconfig |   1 -
>  drivers/pci/controller/vmd.c   | 152 +----------------------------------------
>  drivers/pci/pci.c              |  19 +++++-
>  drivers/pci/search.c           |   6 ++
>  include/linux/pci.h            |   1 +
>  10 files changed, 54 insertions(+), 228 deletions(-)

Applied with acks/reviewed-by from Lu, Keith, and Lorenzo to
pci/host-vmd for v5.6, thanks!
