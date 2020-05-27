Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB21E426A
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 14:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgE0MgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 08:36:25 -0400
Received: from 8bytes.org ([81.169.241.247]:44942 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgE0MgZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 08:36:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 78345247; Wed, 27 May 2020 14:36:24 +0200 (CEST)
Date:   Wed, 27 May 2020 14:36:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhelgaas@google.com,
        will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org
Subject: Re: [PATCH v2 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200527123622.GI5221@8bytes.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 05:21:59PM +0200, Jean-Philippe Brucker wrote:
> IOMMU drivers currently check themselves if a device is untrusted
> (plugged into an external-facing port) before enabling ATS. Move the
> check to drivers/pci. The only functional change should be to the AMD
> IOMMU driver. With this change all IOMMU drivers block 'Translated' PCIe
> transactions and Translation Requests from untrusted devices.
> 
> Since v1 [1] I added tags, addressed comments on patches 1 and 3, and
> fixed a regression in patch 3.
> 
> [1] https://lore.kernel.org/linux-iommu/20200515104359.1178606-1-jean-philippe@linaro.org/
> 
> Jean-Philippe Brucker (4):
>   PCI/ATS: Only enable ATS for trusted devices
>   iommu/amd: Use pci_ats_supported()
>   iommu/arm-smmu-v3: Use pci_ats_supported()
>   iommu/vt-d: Use pci_ats_supported()
> 
>  include/linux/pci-ats.h     |  3 +++
>  drivers/iommu/amd_iommu.c   | 12 ++++--------
>  drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
>  drivers/iommu/intel-iommu.c |  9 +++------
>  drivers/pci/ats.c           | 18 +++++++++++++++++-
>  5 files changed, 34 insertions(+), 28 deletions(-)

Applied, thanks.
