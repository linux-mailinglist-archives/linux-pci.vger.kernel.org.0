Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE44E62EA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 13:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349930AbiCXMHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 08:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbiCXMHT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 08:07:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43380A27DE
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:05:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso9334995pjb.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6h7CwtYkuGaBIiakLMcx17LwD9HW+bhJ7Z/TPtaFZEg=;
        b=Xr/jGdl8vIEMyPgBQoHQISi3UAs2vFv/riosiE3clB+o7HBOCxjXiHGwbI3DFuASX3
         9M489VYxtQDbNydfJd72Oh+EGnCNjBTPSCnDB/lXySopx79YhNAcPXyWZXZKywhqyuBc
         cM0/ty7/9UE/0sxwNF3H71bdI5niZS2//Mt0W77hFdZDLCDkQgqOj5PR3vOE6Pk5pl8+
         AmAX984csxKDLlm+8U/K9uLrv6KWpNoHCS8PShsFWppgXWwOKbA0pH/92hKTpPRT0Bl/
         rJSikow7UZOvcaqhO+U840XCyx8pWNWXlTUbYymj/A2X1fKAP0s/XhHUdLZTzo3iVN2W
         FgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6h7CwtYkuGaBIiakLMcx17LwD9HW+bhJ7Z/TPtaFZEg=;
        b=0ZlIwWJo1FlyZL8PUIiocm/yx2I05VlKfnfQNOh6YULjqWgwVOayPdj2NxDtmyJKbg
         3+1rfnZztRl3S8zGs850ZQzEnRy7ldRcfd4GwNo8RXBSVjyZu+SJQdqIg7fm361mrOjT
         cnD64FKkn4rdawmhsupmIVzRAdrH62im6D1YBL7OynK1SWzV/+WdCzWQFxfzcLgq9GLJ
         7hPF768q0FhuMtr4NumJIrLT1CyzPyLe4yiYgmgECJhMJsdwoKFVubriboTIMMPkMiwr
         KjRqyxv0psWMUp2H8oCcApc8Le/tZKxS76UYJ/s4JsALJeeQYX6zjHLpOBTkTSn3D9I6
         eREQ==
X-Gm-Message-State: AOAM530Sr4TmEEPk/XGmShb39CKiYEcqmFogHD1RJz01V1UPIT9gK3hP
        i+0bLprEOsA4HT78hV99Rgc+
X-Google-Smtp-Source: ABdhPJxxPOJPPfaDs9fDX35Y45pvWrbujW2mQUBs+m2Oh1EYK5x4FGRk7yXsGi1eCblfAq4yOSZtyA==
X-Received: by 2002:a17:902:9894:b0:153:4d7a:a8ec with SMTP id s20-20020a170902989400b001534d7aa8ecmr5502416plp.27.1648123546630;
        Thu, 24 Mar 2022 05:05:46 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id q20-20020a056a00151400b004fa99ba6654sm3278447pfu.115.2022.03.24.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:05:46 -0700 (PDT)
Date:   Thu, 24 Mar 2022 17:35:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Shradha Todi <shradha.t@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] PCI: dwc: Set INCREASE_REGION_SIZE flag based on
 limit address
Message-ID: <20220324120540.GE2854@thinkpad>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324012524.16784-6-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:25:16AM +0300, Serge Semin wrote:
> It was wrong to use the region size parameter in order to determine
> whether the INCREASE_REGION_SIZE flag needs to be set for the outbound
> iATU entry because in general there are cases when combining a region base
> address and size together produces the out of bounds upper range limit
> while upper_32_bits(size) still returns zero. So having a region size
> within the permitted values doesn't mean the region limit address will fit
> to the corresponding CSR. Here is the way iATU calculates the in- and
> outbound untranslated regions if the INCREASE_REGION_SIZE flag is cleared
> [1]:
> 
>   Start address:                     End address:
> 63              31              0   63              31              0
> +---------------+---------------+   +---------------+---------------+
> |               |         |  0s |   |               |         |  Fs |
> +---------------+---------------+   +---------------+---------------+
>    upper base   |   lower base       !upper! base   | limit address
>      address          address           address
> 
> So the region start address is determined by the iATU lower and upper base
> address registers, while the region upper boundary is calculated based on
> the 32-bits limit address register and the upper part of the base address.
> In accordance with that logic for instance the range
> 0xf0000000 @ 0x20000000 does have the size smaller than 4GB, but the
> actual limit address turns to be invalid forming the untranslated address
> map as [0xf0000000; 0x0000FFFF], which isn't what the original range was.

I find the example confusing:

If the start address is 0x0-0xf0000000 and size is 0x20000000. Then the end
address without the INCREASE_REGION_SIZE is going to be:

0x0-0x1000FFFF and this is wrong.

If the INCREASE_REGION_SIZE is set, then the end address will be:

0x1-0x1000FFFF and this is correct.

> In order to fix that we need to check whether the size being added to the
> lower part of the base address causes the 4GB range overflow. If it does
> then we need to set the INCREASE_REGION_SIZE flag thus activating the
> extended limit address by means of an additional iATU CSR (upper limit
> address register) [2]:
> 
>   Start address:                     End address:
> 63              31              0   63      x       31              0
> +---------------+---------------+   +---------------+---------------+
> |               |         |  0s |   |       |       |         |  Fs |
> +---------------+---------------+   +---------------+---------------+
>   upper base   |   lower base         upper | upper | limit address
>     address          address          base  | limit |
>                                      address|address|
> 
> Otherwise there is enough room in the 32-bits wide limit address register,
> and the flag can be left unset.
> 
> Note the case when the size-based flag setting approach is correct implies
> requiring to have the size-aligned base addresses only. But that
> restriction isn't relevant to the PCIe ranges accepted by the kernel.
> There is also no point in implementing it either seeing the problem can be
> easily fixed by checking the whole limit address instead of the region
> size.
> 
> [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     v5.40a, March 2019, fig.3-36, p.175
> [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
>     v5.40a, March 2019, fig.3-37, p.176
> 
> Fixes: 5b4cf0f65324 ("PCI: dwc: Add upper limit address for outbound iATU")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

With the example fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 7dc8c360a0d4..d737af058903 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -287,8 +287,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>  				 upper_32_bits(pci_addr));
>  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> -	val = upper_32_bits(size - 1) ?
> -		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> +	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
> +		val |= PCIE_ATU_INCREASE_REGION_SIZE;
>  	if (pci->version == 0x490A)
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> @@ -315,6 +315,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  					u64 pci_addr, u64 size)
>  {
>  	u32 retries, val;
> +	u64 limit_addr;
>  
>  	if (pci->ops && pci->ops->cpu_addr_fixup)
>  		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> @@ -325,6 +326,8 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  		return;
>  	}
>  
> +	limit_addr = cpu_addr + size - 1;
> +
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
>  			   PCIE_ATU_REGION_OUTBOUND | index);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
> @@ -332,17 +335,18 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
>  			   upper_32_bits(cpu_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
> -			   lower_32_bits(cpu_addr + size - 1));
> +			   lower_32_bits(limit_addr));
>  	if (pci->version >= 0x460A)
>  		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> -				   upper_32_bits(cpu_addr + size - 1));
> +				   upper_32_bits(limit_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
>  			   lower_32_bits(pci_addr));
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>  			   upper_32_bits(pci_addr));
>  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> -	val = ((upper_32_bits(size - 1)) && (pci->version >= 0x460A)) ?
> -		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> +	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> +	    pci->version >= 0x460A)
> +		val |= PCIE_ATU_INCREASE_REGION_SIZE;
>  	if (pci->version == 0x490A)
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> -- 
> 2.35.1
> 
