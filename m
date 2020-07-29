Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9C2324F2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 20:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2S45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 14:56:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37431 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgG2S45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 14:56:57 -0400
Received: by mail-io1-f67.google.com with SMTP id w12so12050716iom.4;
        Wed, 29 Jul 2020 11:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wWYpUB0B5F9DakDE/d7Jt/iFxH1JFsvV3Y7Iu2yZvWw=;
        b=ot8aRS0MpEOywUs0MODSEAVSQPP8yeUijxbRMDFNASNKi7kwfL5AS/9+g7tKLhIIvV
         l1YijZ4Ynd5HXInsB0oCM8PHX11GsWWovYigcF6KyXBvBv37FwBg9s6WBgqIaHSPAsZ4
         AX0ARKGlJ/w3qH0mFwX0Nygr2dN/vVtH4iAYCHbN0Mclgi7hp2odtWhyVsrdl4wRJUsL
         tg5jb0sqb7obIarT6/lrysXk93F2UIjXb0S/KIQHbi1viZSjtmE7Tgzayq8jeVeAQ3qR
         hhX90Kne2Xo/znfvgF3Nf2n52mU/cEC6a1VplnYTumtJ+7tNQIhbOmtXPg3czawNRbTe
         myqg==
X-Gm-Message-State: AOAM531OKFD9yrHBcl0pKCkt+3cRZQvq2IZ2lGSZSXN8KiSTsQtyeqtf
        8oUMZQFKPfdPysOTFj0GNQ==
X-Google-Smtp-Source: ABdhPJy+3LMGUtVhao+r3gcbViMO39JZQ6pzxxMomQHJNwDvtPPaHxlrii3qwNXAfdIXjxfkmPp9Gw==
X-Received: by 2002:a6b:b211:: with SMTP id b17mr17640659iof.29.1596049016119;
        Wed, 29 Jul 2020 11:56:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u6sm1576835ilk.13.2020.07.29.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 11:56:55 -0700 (PDT)
Received: (nullmailer pid 593935 invoked by uid 1000);
        Wed, 29 Jul 2020 18:56:54 -0000
Date:   Wed, 29 Jul 2020 12:56:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        amurray@thegoodpenguin.co.uk, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 1/2] PCI: dwc: Add support to handle prefetchable memory
 separately
Message-ID: <20200729185654.GA585891@bogus>
References: <20200602100940.10575-1-vidyas@nvidia.com>
 <20200602100940.10575-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602100940.10575-2-vidyas@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 02, 2020 at 03:39:39PM +0530, Vidya Sagar wrote:
> Add required structure members to struct pcie_port to handle prefetchable
> memory aperture separately from non-prefetchable memory aperture so that
> any dependency on the order of their appearance in the 'ranges' property
> of the respective PCIe device tree node can be removed.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
>  2 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 42fbfe2a1b8f..6f06d6bd9f00 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -363,13 +363,23 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			pp->io_base = pci_pio_to_address(pp->io->start);
>  			break;
>  		case IORESOURCE_MEM:
> -			pp->mem = win->res;
> -			pp->mem->name = "MEM";
> -			mem_size = resource_size(pp->mem);
> -			if (upper_32_bits(mem_size))
> -				dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
> -			pp->mem_size = mem_size;
> -			pp->mem_bus_addr = pp->mem->start - win->offset;
> +			if (win->res->flags & IORESOURCE_PREFETCH) {
> +				pp->prefetch = win->res;
> +				pp->prefetch->name = "PREFETCH";
> +				pp->prefetch_base = pp->prefetch->start;
> +				pp->prefetch_size = resource_size(pp->prefetch);
> +				pp->perfetch_bus_addr = pp->prefetch->start -
> +							win->offset;
> +			} else {
> +				pp->mem = win->res;
> +				pp->mem->name = "MEM";
> +				pp->mem_base = pp->mem->start;
> +				mem_size = resource_size(pp->mem);
> +				if (upper_32_bits(mem_size))
> +					dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
> +				pp->mem_size = mem_size;
> +				pp->mem_bus_addr = pp->mem->start - win->offset;
> +			}
>  			break;
>  		case 0:
>  			pp->cfg = win->res;
> @@ -394,8 +404,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> -	pp->mem_base = pp->mem->start;
> -
>  	if (!pp->va_cfg0_base) {
>  		pp->va_cfg0_base = devm_pci_remap_cfgspace(dev,
>  					pp->cfg0_base, pp->cfg0_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 656e00f8fbeb..c87c1b2a1177 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -186,9 +186,13 @@ struct pcie_port {
>  	u64			mem_base;
>  	phys_addr_t		mem_bus_addr;
>  	u32			mem_size;
> +	u64			prefetch_base;
> +	phys_addr_t		perfetch_bus_addr;
> +	u64			prefetch_size;

There's no reason to store these for all eternity as they are used in 
one place and already stored as resources in bridge->windows.

I have a patch series removing most of this that I will post in a few 
days. There's a WIP branch, pci-dw-config-access, in my kernel.org 
tree. Mostly you just need the bridge ptr which is isn't currently 
saved in pcie_port.

Rob
