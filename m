Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EC55D621
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbiF1Ggr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbiF1Gge (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:36:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F207A12632
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:36:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so11141323pfb.4
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jELs+00IN2XRLAhHEpv/uDcKD8BHgm3LO8TAQxr7/S8=;
        b=gZhInxTYLITVwSA+pCUS67K7KcAlTRUX/PLOhLoFasARmxRHZXkk8HjdXfLHMn4uwv
         5oOVdI1Ezh1NuLncOJIOYXrYFbnJs6RTu8a1G0+Ss0xUa4W+7NpVf5XsUCZv8LjWoFhp
         s4l0ixN2amckn054xI+giDCzWvPheAtAjUdK4HmHgz7OQbGsFEi1j+a6qVXuXspGJUxh
         foRRewHnpEcez9mTk739dtr5xWZvqymVEC8BALmoWnJWlCHlcmzQoV0ZwckL6SdoUkja
         kVxXSSE4BMCebSIBZUUrJjqbErztCpKudFyjNFAYd7jDhBBZnotscFPfdn9rdg3HgRD9
         mg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jELs+00IN2XRLAhHEpv/uDcKD8BHgm3LO8TAQxr7/S8=;
        b=yMsfuinmgqrlxcpvckjrCxwSUQAoZCyNz7uDQ999lW8NM1VY882L+4yjhAVTgDMxuW
         Zwqy4q68TyHCPp9ZdgJjPlvQ/2I10wsgxNyrECcxACyPrUXVlneYstwPw5MasJfnPpDS
         Y0TM4iifKOg/TsDXCG0ZJ7AnKtbURDFlFbt4ao2P5PwpZ+Q+I+slXNuwn7zQtW98jJml
         O0lXfKyyySqW8y7677e59T/lAS4Y0CovY3ANznevva+6uLEkn/1qjF5o/sa8T0zKtLA0
         ytFED2fZ+ph/fyUBB/P8wyS5D3ZPoAPMIpge77w9MeyI2zRXd/D8wANcjXR/5IhnWKR0
         +vrg==
X-Gm-Message-State: AJIora98KdyFbJE813paFgAb9c96+dFieHgUu9rDkgPe40RAWBDgrofY
        BJwVs/Z4RgHTPOdKRT10azM/
X-Google-Smtp-Source: AGRyM1uz7w+7zzu++7h9WJlZurJnOJ6dc32whckhoJEnkuJib5IJC6PCPJFrAbsAr5JZvxtAbcN2Jw==
X-Received: by 2002:a63:88c3:0:b0:40d:5f26:bfa8 with SMTP id l186-20020a6388c3000000b0040d5f26bfa8mr16248894pgd.608.1656398160347;
        Mon, 27 Jun 2022 23:36:00 -0700 (PDT)
Received: from thinkpad ([27.111.75.159])
        by smtp.gmail.com with ESMTPSA id i7-20020aa796e7000000b0051bb61c0eacsm8499208pfq.20.2022.06.27.23.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:35:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:05:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 05/18] PCI: dwc: Deallocate EPC memory on EP
 init error
Message-ID: <20220628063554.GB23601@thinkpad>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
 <20220624143428.8334-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624143428.8334-6-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 24, 2022 at 05:34:15PM +0300, Serge Semin wrote:
> If the dw_pcie_ep_init() method fails to perform any action after the EPC
> memory is initialized and the MSI memory region is allocated, the later
> parts won't be undone thus causing the memory leak.  Let's fix that by
> introducing the cleanup-on-error path in the dw_pcie_ep_init() method,
> which will be taken should any consequent erroneous situation happens.
> 
> Fixes: 2fd0c9d966cc ("PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changelog v2:
> - This is a new patch create as a result of the discussion in:
>   Link: https://lore.kernel.org/linux-pci/20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0eda8236c125..13c2e73f0eaf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -780,8 +780,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
>  					     epc->mem->window.page_size);
>  	if (!ep->msi_mem) {
> +		ret = -ENOMEM;
>  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> -		return -ENOMEM;
> +		goto err_exit_epc_mem;
>  	}
>  
>  	if (ep->ops->get_features) {
> @@ -790,6 +791,19 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  			return 0;
>  	}
>  
> -	return dw_pcie_ep_init_complete(ep);
> +	ret = dw_pcie_ep_init_complete(ep);
> +	if (ret)
> +		goto err_free_epc_mem;
> +
> +	return 0;
> +
> +err_free_epc_mem:
> +	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> +			      epc->mem->window.page_size);
> +
> +err_exit_epc_mem:
> +	pci_epc_mem_exit(epc);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
