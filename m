Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 338B71554A
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2019 23:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEFVML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 May 2019 17:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfEFVML (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 17:12:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5A9206BF;
        Mon,  6 May 2019 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557177129;
        bh=H60Z5JzAVob3LUpzvsBUSRMR0trBUI8gbEMi3qxwp30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+otEGFalj9eUa8HjkWOq3eWomRR0iv//fLaRm9B3yuPSfOBCIZvDJKe0Fq8mIlDK
         c07TwmQDq5yc63UxbnrMEy0nGxTs/9VZOCUoEk7CUeMS5LlepJ5a1GrjR2nxDYHN9X
         jAi8+NP3yU9tXbm+wfK6Muzjk5drQDrBn7+4gdB4=
Date:   Mon, 6 May 2019 16:12:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] PCI: iproc: Add sorted dma ranges resource
 entries to host bridge
Message-ID: <20190506211208.GA156478@google.com>
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com>
 <1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556892334-16270-4-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 03, 2019 at 07:35:34PM +0530, Srinath Mannam wrote:
> The IPROC host controller allows only a subset of physical address space
> as target of inbound PCI memory transactions addresses.
> 
> PCIe devices memory transactions targeting memory regions that
> are not allowed for inbound transactions in the host controller
> are rejected by the host controller and cannot reach the upstream
> buses.
> 
> Firmware device tree description defines the DMA ranges that are
> addressable by devices DMA transactions; parse the device tree
> dma-ranges property and add its ranges to the PCI host bridge dma_ranges
> list; the iova_reserve_pci_windows() call in the driver will reserve the
> IOVA address ranges that are not addressable (ie memory holes in the
> dma-ranges set) so that they are not allocated to PCI devices for DMA
> transfers.
> 
> All allowed address ranges are listed in dma-ranges DT parameter.
> 
> Example:
> 
> dma-ranges = < \
>   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
>   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
>   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> 
> In the above example of dma-ranges, memory address from
> 
> 0x0 - 0x80000000,
> 0x100000000 - 0x800000000,
> 0x1000000000 - 0x8000000000 and
> 0x10000000000 - 0xffffffffffffffff.
> 
> are not allowed to be used as inbound addresses.
> 
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> [lorenzo.pieralisi@arm.com: updated commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..94ba5c0 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
>  	return ret;
>  }
>  
> +static int
> +iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
> +			 struct of_pci_range *range)

Just FYI, I cherry-picked these commits from Lorenzo's branch to fix
the formatting of this prototype to match the rest of the file, e.g.:

>  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> ...
>  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
