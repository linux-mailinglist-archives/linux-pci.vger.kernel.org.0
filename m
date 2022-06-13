Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2554A219
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiFMW3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiFMW3z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 18:29:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FD0AE43;
        Mon, 13 Jun 2022 15:29:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79A24B8162C;
        Mon, 13 Jun 2022 22:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7552C34114;
        Mon, 13 Jun 2022 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655159391;
        bh=vNu4jrWVxZwp0+Gkz6btuS5pvBFArogcCzsu/d9oYGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RqBRVsOzRzVWYuuQIJx8V/K1bL34Ulr0ylKGt7fmXwNmEuJ3GkdK6+WxTiMroq4/I
         5pIGu0A29EUkVavGR9YkIzwi4Rp0ExEWmfayEiA9D/Br0xsoSRehMw1WgSJYMjqQGY
         BBcxdE11eHGnnFzR6zPT8CF3ZGWPEI87jnLRWWMzV8t86qpHptL16ze48pVyXyFM+P
         /ZrUelWBM3Dni7FNXRcf7KVJEGNyu2KJbc5nnoXfhzDNy/SkQaV3JW4rgiJoT20MPK
         p44648XwqBoz3hvNhU7KCZF40D8R9JV3qUhestme+uPJcBJKUWF6hIh9AJC8FKMLoQ
         iAbr/9IVS1HuA==
Date:   Mon, 13 Jun 2022 17:29:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] PCI: dwc: Fix MSI msi_msg dma mapping
Message-ID: <20220613222948.GA721845@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525223316.388490-1-willmcvicker@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 25, 2022 at 10:33:16PM +0000, Will McVicker wrote:
> As of commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in
> suspend/resume"), the PCIe designware host driver has been using the
> driver data allocation for the msi_msg dma mapping which can result in
> a DMA_MAPPING_ERROR due to the DMA overflow check in
> dma_direct_map_page() when the address is greater than 32-bits (reported
> in [1]). The commit was trying to address a memory leak on
> suspend/resume by moving the MSI mapping to dw_pcie_host_init(), but
> subsequently dropped the page allocation thinking it wasn't needed.
> 
> To fix the DMA mapping issue as well as make msi_msg DMA'able, let's
> switch back to allocating a 32-bit page for the msi_msg. To avoid the
> suspend/resume leak, we can allocate the page in dw_pcie_host_init()
> since that function shouldn't be called during suspend/resume.
> 
> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> 
> Signed-off-by: Will McVicker <willmcvicker@google.com>

Applied to pci/ctrl/dwc for v5.20, thanks!

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f32d964..3655c6f88bf1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -267,8 +267,9 @@ static void dw_pcie_free_msi(struct pcie_port *pp)
>  		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  		struct device *dev = pci->dev;
>  
> -		dma_unmap_single_attrs(dev, pp->msi_data, sizeof(pp->msi_msg),
> -				       DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
> +		if (pp->msi_page)
> +			__free_page(pp->msi_page);
>  	}
>  }
>  
> @@ -392,12 +393,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret)
>  				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>  
> -			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
> -						      sizeof(pp->msi_msg),
> -						      DMA_FROM_DEVICE,
> -						      DMA_ATTR_SKIP_CPU_SYNC);
> +			pp->msi_page = alloc_page(GFP_DMA32);
> +			pp->msi_data = dma_map_page(pci->dev, pp->msi_page, 0, PAGE_SIZE,
> +						    DMA_FROM_DEVICE);
>  			if (dma_mapping_error(pci->dev, pp->msi_data)) {
>  				dev_err(pci->dev, "Failed to map MSI data\n");
> +				__free_page(pp->msi_page);
> +				pp->msi_page = NULL;
>  				pp->msi_data = 0;
>  				goto err_free_msi;
>  			}
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7d6e9b7576be..b5f528536358 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -190,8 +190,8 @@ struct pcie_port {
>  	int			msi_irq;
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
> -	u16			msi_msg;
>  	dma_addr_t		msi_data;
> +	struct page		*msi_page;
>  	struct irq_chip		*msi_irq_chip;
>  	u32			num_vectors;
>  	u32			irq_mask[MAX_MSI_CTRLS];
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 
