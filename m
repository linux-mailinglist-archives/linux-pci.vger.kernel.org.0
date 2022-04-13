Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9C150016D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 23:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiDMV5P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbiDMV5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 17:57:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750126AF6;
        Wed, 13 Apr 2022 14:54:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c15so3823760ljr.9;
        Wed, 13 Apr 2022 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1kMh4YUyjgmaA6xR5EVvkr9mVKwV1Jly9n0RiGjprkA=;
        b=PuZ+u5+UjLU+b2e154C6+uVvtX/M7qfwzVbWB5xDAvwGMLXQ+LTjNeL28573lUsZWa
         cAfL5kf+o07FSjqD4DmBVYCCO0sEbp56B80rKfchc4BLjXdbdF57fWW3mLueWAa4ZyCb
         lzeuanxTyFrl5p/lNPnUd80HtKJ5qU2iXeBXcrLPzVkEklPkWTX9C8srY2FoMkRJSwV6
         8j/F/U40dyH1fkoLpEbxVE4/kLi8DbtRw/6/DTTdGsRAI9Kfvq3pjboq6FbDuK4eZkiY
         tr7+0IYwmmdnLPMJHrRUzBc4+u/hWHV9QY1FXeRinPE5WwX3xr/cVMt42JMJOQ0p010K
         YzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1kMh4YUyjgmaA6xR5EVvkr9mVKwV1Jly9n0RiGjprkA=;
        b=6L1G+72Vfi6AEK0SU5Hc9LMnA+UeXx6VBRiGdu8tuw/NY7NDgSDRn6Tq5ZBKqAFMbd
         llBsGHlabssdPl2I234f2ub6YhyQouLRzqjZfn5IuTcoN+gPXOJXKnUXA6/2qnvGLHEB
         Mq1vseUqhj9uQ21DY9gMDPhkUNdNicmfTXWBrW/a+HT5inZplk7sMNl4AxS0N1o+PylV
         hRpR2jkcs7Q4FV/Rsh7jTy5ISxxK9FKEt+wSpehBS2ijp/ht99JqiHC1U1BM/qhcMa+c
         Am8SHP52rZ2+ko4e9+WQKcO+DYktCelWyhGld8TSXpqQDc/JSq86JDi6YNwNxqncq7r/
         FuvQ==
X-Gm-Message-State: AOAM532gGzkaTzAk4qepiprOFy1E+7JEqtoEPmUdh17BE/vE3iezr8Gr
        4vTRv+fE16xXbve229MoIHA=
X-Google-Smtp-Source: ABdhPJwtCrJTdzUA5xEeahpxhvpvkrdY5xnRyuWZnv1BJAhvTBZC6SvuYWDdMgqex/VtHtIExWHZIQ==
X-Received: by 2002:a2e:a7c1:0:b0:24b:63a5:2fc1 with SMTP id x1-20020a2ea7c1000000b0024b63a52fc1mr10413073ljp.13.1649886888234;
        Wed, 13 Apr 2022 14:54:48 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm17127lfb.302.2022.04.13.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:54:47 -0700 (PDT)
Date:   Thu, 14 Apr 2022 00:54:45 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Shradha Todi <shradha.t@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] PCI: dwc: Set INCREASE_REGION_SIZE flag based on
 limit address
Message-ID: <20220413215445.ndcfv3o5qzdrvgoj@mobilestation>
References: <20220324012524.16784-1-Sergey.Semin@baikalelectronics.ru>
 <20220324012524.16784-6-Sergey.Semin@baikalelectronics.ru>
 <20220324120540.GE2854@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324120540.GE2854@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 05:35:40PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:25:16AM +0300, Serge Semin wrote:
> > It was wrong to use the region size parameter in order to determine
> > whether the INCREASE_REGION_SIZE flag needs to be set for the outbound
> > iATU entry because in general there are cases when combining a region base
> > address and size together produces the out of bounds upper range limit
> > while upper_32_bits(size) still returns zero. So having a region size
> > within the permitted values doesn't mean the region limit address will fit
> > to the corresponding CSR. Here is the way iATU calculates the in- and
> > outbound untranslated regions if the INCREASE_REGION_SIZE flag is cleared
> > [1]:
> > 
> >   Start address:                     End address:
> > 63              31              0   63              31              0
> > +---------------+---------------+   +---------------+---------------+
> > |               |         |  0s |   |               |         |  Fs |
> > +---------------+---------------+   +---------------+---------------+
> >    upper base   |   lower base       !upper! base   | limit address
> >      address          address           address
> > 
> > So the region start address is determined by the iATU lower and upper base
> > address registers, while the region upper boundary is calculated based on
> > the 32-bits limit address register and the upper part of the base address.
> > In accordance with that logic for instance the range
> > 0xf0000000 @ 0x20000000 does have the size smaller than 4GB, but the
> > actual limit address turns to be invalid forming the untranslated address
> > map as [0xf0000000; 0x0000FFFF], which isn't what the original range was.
> 

> I find the example confusing:
> 
> If the start address is 0x0-0xf0000000 and size is 0x20000000. Then the end
> address without the INCREASE_REGION_SIZE is going to be:
> 
> 0x0-0x1000FFFF and this is wrong.
> 
> If the INCREASE_REGION_SIZE is set, then the end address will be:
> 
> 0x1-0x1000FFFF and this is correct.

Not only confusing but indeed being wrong in the end address part.
Thanks for noticing that. I'll fix it in v2.

> 
> > In order to fix that we need to check whether the size being added to the
> > lower part of the base address causes the 4GB range overflow. If it does
> > then we need to set the INCREASE_REGION_SIZE flag thus activating the
> > extended limit address by means of an additional iATU CSR (upper limit
> > address register) [2]:
> > 
> >   Start address:                     End address:
> > 63              31              0   63      x       31              0
> > +---------------+---------------+   +---------------+---------------+
> > |               |         |  0s |   |       |       |         |  Fs |
> > +---------------+---------------+   +---------------+---------------+
> >   upper base   |   lower base         upper | upper | limit address
> >     address          address          base  | limit |
> >                                      address|address|
> > 
> > Otherwise there is enough room in the 32-bits wide limit address register,
> > and the flag can be left unset.
> > 
> > Note the case when the size-based flag setting approach is correct implies
> > requiring to have the size-aligned base addresses only. But that
> > restriction isn't relevant to the PCIe ranges accepted by the kernel.
> > There is also no point in implementing it either seeing the problem can be
> > easily fixed by checking the whole limit address instead of the region
> > size.
> > 
> > [1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> >     v5.40a, March 2019, fig.3-36, p.175
> > [2] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
> >     v5.40a, March 2019, fig.3-37, p.176
> > 
> > Fixes: 5b4cf0f65324 ("PCI: dwc: Add upper limit address for outbound iATU")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 

> With the example fixed,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Ok. Thanks.

-Sergey

> 
> Thanks,
> Mani
> 
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 7dc8c360a0d4..d737af058903 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -287,8 +287,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> >  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> >  				 upper_32_bits(pci_addr));
> >  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> > -	val = upper_32_bits(size - 1) ?
> > -		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> > +	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
> > +		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (pci->version == 0x490A)
> >  		val = dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> > @@ -315,6 +315,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  					u64 pci_addr, u64 size)
> >  {
> >  	u32 retries, val;
> > +	u64 limit_addr;
> >  
> >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> >  		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> > @@ -325,6 +326,8 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  		return;
> >  	}
> >  
> > +	limit_addr = cpu_addr + size - 1;
> > +
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
> >  			   PCIE_ATU_REGION_OUTBOUND | index);
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
> > @@ -332,17 +335,18 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
> >  			   upper_32_bits(cpu_addr));
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
> > -			   lower_32_bits(cpu_addr + size - 1));
> > +			   lower_32_bits(limit_addr));
> >  	if (pci->version >= 0x460A)
> >  		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> > -				   upper_32_bits(cpu_addr + size - 1));
> > +				   upper_32_bits(limit_addr));
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
> >  			   lower_32_bits(pci_addr));
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
> >  			   upper_32_bits(pci_addr));
> >  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> > -	val = ((upper_32_bits(size - 1)) && (pci->version >= 0x460A)) ?
> > -		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> > +	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > +	    pci->version >= 0x460A)
> > +		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (pci->version == 0x490A)
> >  		val = dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> > -- 
> > 2.35.1
> > 
