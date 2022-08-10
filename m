Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5358F3CE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 23:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiHJV1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 17:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJV1U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 17:27:20 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E1A252B8;
        Wed, 10 Aug 2022 14:27:20 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id h138so13228952iof.12;
        Wed, 10 Aug 2022 14:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=y+69QJnuc+3EME9VXlV7VP2G/fIZkhFMddsu1TYmaZg=;
        b=Ei7NHHljioTVAjiMCCW6V7m/MAxCWoBeffvUdmQLe0RmrRMnpP9iqlt7S0OLxmjssZ
         G0v+F+G8Eh+PLvQAy1nIOYcAziXFLTv2jpYwU1tQQqLjiigyvorP4SUqkUgkm0J5y/je
         eYXKGf2fsuvbT72gc7fnWfgJkzQDy+SZmq87LLPAIgyKmlknjCmCBUvt5JUj6130gJac
         2+cmW+v6+YodvKU9hy7XaSpXujY7B2aGM8VzhPjc0DJCgg+UuJPhaxeSdpIkTMcnIQ3Y
         8mTMwtj31vu/XMvEccTAu+m/7hbxaPRvqFqiVLHX47kRvs/9yanjlDxO3ej51JwhJVnj
         ccZw==
X-Gm-Message-State: ACgBeo3DKJu7hB+xKD5NWmEXt4afcHE84uW/Mq0TDbigNMI5LuR8WDCe
        RyzdPhbY1/Rqt6p+5Np8UQ==
X-Google-Smtp-Source: AA6agR40YwGaxaCyrLt+Oz0JOEYo/CzvUwtUDFilFjoawJQK2ji5nDwikoJh0YEBLBYTeq9CXug0EA==
X-Received: by 2002:a02:c787:0:b0:342:7c31:5469 with SMTP id n7-20020a02c787000000b003427c315469mr14213786jao.270.1660166839287;
        Wed, 10 Aug 2022 14:27:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a18-20020a027a12000000b0032e3b0933c6sm7877355jac.162.2022.08.10.14.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 14:27:18 -0700 (PDT)
Received: (nullmailer pid 579718 invoked by uid 1000);
        Wed, 10 Aug 2022 21:27:16 -0000
Date:   Wed, 10 Aug 2022 15:27:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: drop dependency on ZONE_DMA32
Message-ID: <20220810212716.GA557589-robh@kernel.org>
References: <20220810183536.1630940-1-willmcvicker@google.com>
 <20220810183536.1630940-2-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810183536.1630940-2-willmcvicker@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 10, 2022 at 06:35:34PM +0000, Will McVicker wrote:
> Re-work the msi_msg DMA allocation logic to use dma_alloc_coherent()
> which uses the coherent DMA mask to try and return an allocation within
> the DMA mask limits. This allows kernel configurations that disable
> ZONE_DMA32 to continue supporting a 32-bit DMA mask. Without this patch,
> the PCIe host device will fail to probe when ZONE_DMA32 is disabled.
> 
> Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
> Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 23 ++++++++-----------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7746f94a715f..8f2222f51671 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -272,9 +272,9 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  		struct device *dev = pci->dev;
>  
> -		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
> -		if (pp->msi_page)
> -			__free_page(pp->msi_page);
> +		dma_free_coherent(dev, PAGE_SIZE, pp->msi_page, pp->msi_data);
> +		pp->msi_data = 0;
> +		pp->msi_page = NULL;
>  	}
>  }
>  
> @@ -375,22 +375,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  						    dw_chained_msi_isr, pp);
>  	}
>  
> -	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>  
> -	pp->msi_page = alloc_page(GFP_DMA32);
> -	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
> -				    PAGE_SIZE, DMA_FROM_DEVICE);
> -	ret = dma_mapping_error(dev, pp->msi_data);
> -	if (ret) {
> -		dev_err(pci->dev, "Failed to map MSI data\n");
> -		__free_page(pp->msi_page);
> -		pp->msi_page = NULL;
> +	pp->msi_page = dma_alloc_coherent(dev, PAGE_SIZE, &pp->msi_data,
> +					  GFP_KERNEL);

You can use the managed version, dmam_alloc_coherent(), and avoid the 
freeing yourself. Also with that, I think you don't need 'msi_page'?

Also, no need to alloc a whole page. A u32 or u64? should be fine. The 
write never makes it to memory, so doesn't really matter.

> +	if (!pp->msi_page) {
> +		dev_err(dev, "Failed to alloc and map MSI data\n");
>  		pp->msi_data = 0;
>  		dw_pcie_free_msi(pp);
> -
> -		return ret;
> +		return -ENOMEM;
>  	}
>  
>  	return 0;
> -- 
> 2.37.1.559.g78731f0fdb-goog
> 
