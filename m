Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E029276463
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIWXSu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 19:18:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34489 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWXSu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2020 19:18:50 -0400
Received: by mail-io1-f67.google.com with SMTP id m17so1372209ioo.1;
        Wed, 23 Sep 2020 16:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHsD3SLJmcx9KOWGYcQYUc0v4uSy8LxJrJDo7E9k6nU=;
        b=FO+S6HHGww9f9jIL0cCqGDH/mMKnml3C4A+uwsp7xHjxc1esYqcJWwU6qEQngWaFUk
         6XLZi/8yoChngG8akxn0MRFngZ76TMkPC3VWrB5EcDInn15y9vh3rePeEh5gGp8qUVBu
         t0RY9vOC4AvaekAPy3J5Ut0z0N4Y4os8L3dbPbPBdn8Ms59FanEwFFY0lxuY4dEMcJaD
         47QjuGagYU/zQD21uQ0mhsr5SciXWfc76XG8Kfg+NdfUFsyGuGFwNxQIyux6N9H+Nvc0
         5jN+T5Pv+y3CAYa3MZhkwmyFEp0LkSb92ngDQsVbdusm0l98EdsxQcMEnAsIkGg3jq2X
         DQyg==
X-Gm-Message-State: AOAM531CQbJqZ+no5OuKXws73LuxTP2w9Ckfvaw2Lqyn3oqtEVSTEUMi
        9r4GcnrwZNbR7Ohm1mxcrw==
X-Google-Smtp-Source: ABdhPJxSJk9gVxVd4DzgOoBg2o/2cl0dNWV5EfDhP0rogbALgaKqDWWJZiSGxIx7hwclwNEtFTtnNg==
X-Received: by 2002:a05:6638:1448:: with SMTP id l8mr1411528jad.83.1600903128864;
        Wed, 23 Sep 2020 16:18:48 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z10sm621736ioi.13.2020.09.23.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:18:48 -0700 (PDT)
Received: (nullmailer pid 1517051 invoked by uid 1000);
        Wed, 23 Sep 2020 23:18:46 -0000
Date:   Wed, 23 Sep 2020 17:18:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@axis.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20200923231846.GA1499246@bogus>
References: <20171219232940.659-1-niklas.cassel@axis.com>
 <20171219232940.659-2-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219232940.659-2-niklas.cassel@axis.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 20, 2017 at 12:29:22AM +0100, Niklas Cassel wrote:
> Use the DMA-API to get the MSI address. This address will be written to
> our PCI config space and to the register which determines which AXI
> address the DWC IP will spoof for incoming MSI irqs.
> 
> Since it is a PCIe endpoint device, rather than the CPU, that is supposed
> to write to the MSI address, the proper way to get the MSI address is by
> using the DMA API, not by using virt_to_phys().
> 
> Using virt_to_phys() might work on some systems, but using the DMA API
> should work on all systems.
> 
> This is essentially the same thing as allocating a buffer in a driver
> to which the endpoint will write to. To do this, we use the DMA API.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c | 15 ++++++++++++---
>  drivers/pci/dwc/pcie-designware.h      |  3 ++-
>  2 files changed, 14 insertions(+), 4 deletions(-)

Resurrecting an old thread...

Did this fix any actual problem for you? I'm asking because this 
introduces a bug that an unmap is never done in the error path and 
there's an issue with suspend/resume[1].

I'd like to simplify all this. The whole thing including the existing 
alloc_page() seems pointless. AIUI, the DWC MSI controller just needs a 
single address which is never forwarded out of the RC. So we could use 
any address that an EP would never write to. Some drivers just take the 
address of a field in their driver data. Perhaps even just the DBI base 
would work or the address of PCIE_MSI_ADDR_LO. 

Rob

[1] https://lore.kernel.org/r/20200923142607.10c89bd2@xhacker.debian


> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 81e2157a7cfb..bf558df5b7b3 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -83,10 +83,19 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  
>  void dw_pcie_msi_init(struct pcie_port *pp)
>  {
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct page *page;
>  	u64 msi_target;
>  
> -	pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
> -	msi_target = virt_to_phys((void *)pp->msi_data);
> +	page = alloc_page(GFP_KERNEL);
> +	pp->msi_data = dma_map_page(dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(dev, pp->msi_data)) {
> +		dev_err(dev, "failed to map MSI data\n");
> +		__free_page(page);
> +		return;
> +	}
> +	msi_target = (u64)pp->msi_data;
>  
>  	/* program the msi_data */
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> @@ -187,7 +196,7 @@ static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
>  	if (pp->ops->get_msi_addr)
>  		msi_target = pp->ops->get_msi_addr(pp);
>  	else
> -		msi_target = virt_to_phys((void *)pp->msi_data);
> +		msi_target = (u64)pp->msi_data;
>  
>  	msg.address_lo = (u32)(msi_target & 0xffffffff);
>  	msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
> diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
> index e5d9d77b778e..ecdede68522a 100644
> --- a/drivers/pci/dwc/pcie-designware.h
> +++ b/drivers/pci/dwc/pcie-designware.h
> @@ -14,6 +14,7 @@
>  #ifndef _PCIE_DESIGNWARE_H
>  #define _PCIE_DESIGNWARE_H
>  
> +#include <linux/dma-mapping.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> @@ -168,7 +169,7 @@ struct pcie_port {
>  	const struct dw_pcie_host_ops *ops;
>  	int			msi_irq;
>  	struct irq_domain	*irq_domain;
> -	unsigned long		msi_data;
> +	dma_addr_t		msi_data;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
>  
> -- 
> 2.14.2
