Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEAF21B84A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 16:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgGJOUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgGJOUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 10:20:40 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E951CC08C5CE;
        Fri, 10 Jul 2020 07:20:39 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 990CB20C; Fri, 10 Jul 2020 16:20:38 +0200 (CEST)
Date:   Fri, 10 Jul 2020 16:20:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        jonathan.lemon@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] iommu/intel: Avoid SAC address trick for PCIe devices
Message-ID: <20200710142037.GM27672@8bytes.org>
References: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e583fc6dd1fb4ffc90310ff4372ee776f9cc7a3c.1594207679.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 12:32:41PM +0100, Robin Murphy wrote:
> For devices stuck behind a conventional PCI bus, saving extra cycles at
> 33MHz is probably fairly significant. However since native PCI Express
> is now the norm for high-performance devices, the optimisation to always
> prefer 32-bit addresses for the sake of avoiding DAC is starting to look
> rather anachronistic. Technically 32-bit addresses do have shorter TLPs
> on PCIe, but unless the device is saturating its link bandwidth with
> small transfers it seems unlikely that the difference is appreciable.
> 
> What definitely is appreciable, however, is that the IOVA allocator
> doesn't behave all that well once the 32-bit space starts getting full.
> As DMA working sets get bigger, this optimisation increasingly backfires
> and adds considerable overhead to the dma_map path for use-cases like
> high-bandwidth networking.
> 
> As such, let's simply take it out of consideration for PCIe devices.
> Technically this might work out suboptimal for a PCIe device stuck
> behind a conventional PCI bridge, or for PCI-X devices that also have
> native 64-bit addressing, but neither of those are likely to be found
> in performance-critical parts of modern systems.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/intel/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied both, thanks.

