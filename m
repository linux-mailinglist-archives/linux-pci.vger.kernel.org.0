Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE15D52A913
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiEQRVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 13:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351408AbiEQRU5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 13:20:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C6B48B
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 10:20:51 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i1so17935166plg.7
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qqJFZR8hTHMEpR03D7fICklADGJ1sACe7dmVDrtTPPA=;
        b=ysKA7bOi5+9RdlYYFAsM9Hnm1Y0faip7O/uZx4Jtrfz0r6k4k9vYUggKvc5yQ1exMX
         0Pwj7rSiWyjhXnLuAa1fGnu86owf5xZB9vxKXt7HfttlGj2yZzMka+qecyCOX9uSp5cY
         UqTpAmywLrPUduIU5lo9vkJltg04KLwc8vGzsN4HDy2Jnt5RmvGUqK7ghg+RU4exZ6vV
         utDNHvGDt6AEwWhhCSMvNpL88PIS7CnKCStA4CTurHtGE66zyvTeVATQ/VFDPEqYO0Ey
         7jxg4aj0txKQirK+i5UXExqVypOCrnjFbiHxI/V18PcD3EcvzB9R2TEgawxCCzAaKEnG
         43qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qqJFZR8hTHMEpR03D7fICklADGJ1sACe7dmVDrtTPPA=;
        b=z0ARqmsLBv8biZdCkOv7SjvZ2waMXSvuVDrDjt3FyXW8cJjp0LFqB4NVH2toDwL7Sy
         JNQLIsISDBMkhrebvcPKP8U53et7w3eSGHcMFFaQUDhzVTa6glkYuXb/2blGlbGH5mMo
         7yc79Vb7WnoDesXR+2Q0nxDlHZLrPzXmk1++ImybZ9FAgbb1WmcnQbzr3LL/1uw/7luz
         990eNAwsqL5P9qdAiVEw/wlY22bhHJ5K6hH02xaOUmVDl63tTBp0XX0pRu9+wujTFxO9
         HYMJzvAkiu7/k1oq4pp3+EawOGhwcZammim43Pn5VTB1OuuwKtRWv4rXV+OOeC8ql2mX
         dP5Q==
X-Gm-Message-State: AOAM533Hn1/GR4ftOFgDoQ1w94nsAHCcF5pV+UVOEWvACIfmnZzGjCtu
        jChXT3i8TLyW8GRnfS1kQWwZ
X-Google-Smtp-Source: ABdhPJyhG3jIHWQ/4DWEUJffCPPujUE5uN8SWJy3rwsGgWf/e3ngmDrUje9ryR1pgmwqMjvcBEexhg==
X-Received: by 2002:a17:90a:8b91:b0:1be:db25:eecd with SMTP id z17-20020a17090a8b9100b001bedb25eecdmr25779420pjn.10.1652808051232;
        Tue, 17 May 2022 10:20:51 -0700 (PDT)
Received: from thinkpad ([117.207.31.8])
        by smtp.gmail.com with ESMTPSA id i7-20020a63cd07000000b003c14af5063esm8882115pgg.86.2022.05.17.10.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:20:50 -0700 (PDT)
Date:   Tue, 17 May 2022 22:50:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/17] PCI: dwc: Introduce dma-ranges property support
 for RC-host
Message-ID: <20220517172042.GC4528@thinkpad>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-16-Sergey.Semin@baikalelectronics.ru>
 <20220512135708.GC35848@thinkpad>
 <20220512194135.ku73pae2xdvyocx7@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512194135.ku73pae2xdvyocx7@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 10:41:35PM +0300, Serge Semin wrote:
> On Thu, May 12, 2022 at 07:27:08PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, May 04, 2022 at 12:46:36AM +0300, Serge Semin wrote:
> > > In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> > > property has the same format as the "ranges" property. The only difference
> > > is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> > > memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> > > property. Even though the DW PCIe controllers are normally equipped with
> > > internal Address Translation Unit which inbound and outbound tables can be
> > > used to implement both properties semantics, it was surprise for me to
> > > discover that the host-related part of the DW PCIe driver currently
> > > supports the "ranges" property only while the "dma-ranges" windows are
> > > just ignored. Having the "dma-ranges" supported in the driver would be
> > > very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> > > mapping and require customized the PCIe memory layout. So let's fix that
> > > by introducing the "dma-ranges" property support.
> > > 
> > > First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
> > > dw_pcie_prog_ep_inbound_atu() and create a new version of the
> > > dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for RC
> > > and EP controllers respectively in the same way as it has been developed
> > > for the outbound ATU setup methods.
> > > 
> > > Secondly aside with the memory window index and type the new
> > > dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
> > > and size as its arguments. These parameters define the PCIe and CPU memory
> > > ranges which will be used to setup the respective inbound ATU mapping. The
> > > passed parameters need to be verified against the ATU ranges constraints
> > > in the same way as it is done for the outbound ranges.
> > > 
> > > Finally the DMA-ranges detected for the PCIe controller need to be
> > > converted into the inbound ATU entries during the host controller
> > > initialization procedure. It will be done in the framework of the
> > > dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
> > > need to disable all the inbound ATU entries in order to prevent unexpected
> > > PCIe TLPs translations defined by some third party software like
> > > bootloader.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
> > >  .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.c  | 57 ++++++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
> > >  4 files changed, 90 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index c62640201246..9b0540cfa9e8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -167,8 +167,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
> > > -				       cpu_addr, bar);
> > > +	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> > > +					  cpu_addr, bar);
> > >  	if (ret < 0) {
> > >  		dev_err(pci->dev, "Failed to program IB window\n");
> > >  		return ret;
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 7caca6c575a5..9cb406f5c185 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -612,12 +612,15 @@ static int dw_pcie_iatu_setup(struct pcie_port *pp)
> > >  	}
> > >  
> > >  	/*
> > > -	 * Ensure all outbound windows are disabled before proceeding with
> > > -	 * the MEM/IO ranges setups.
> > > +	 * Ensure all out/inbound windows are disabled before proceeding with
> > > +	 * the MEM/IO (dma-)ranges setups.
> > >  	 */
> > >  	for (i = 0; i < pci->num_ob_windows; i++)
> > >  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
> > >  
> > > +	for (i = 0; i < pci->num_ib_windows; i++)
> > > +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
> > > +
> > >  	i = 0;
> > >  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> > >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > > @@ -654,9 +657,32 @@ static int dw_pcie_iatu_setup(struct pcie_port *pp)
> > >  	}
> > >  
> > >  	if (pci->num_ob_windows <= i)
> > > -		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> > > +		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> > >  			 pci->num_ob_windows);
> > >  
> > > +	i = 0;
> > > +	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> > > +		if (resource_type(entry->res) != IORESOURCE_MEM)
> > > +			continue;
> > > +
> > > +		if (pci->num_ib_windows <= i)
> > > +			break;
> > > +
> > > +		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
> > > +					       entry->res->start,
> > > +					       entry->res->start - entry->offset,
> > > +					       resource_size(entry->res));
> > > +		if (ret) {
> > > +			dev_err(pci->dev, "Failed to set DMA range %pr\n",
> > > +				entry->res);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	if (pci->num_ib_windows <= i)
> > > +		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> > > +			 pci->num_ib_windows);
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 747e252c09e6..33718ed6c511 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -397,8 +397,61 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
> > >  	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
> > >  }
> > >  
> > > -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > -			     int type, u64 cpu_addr, u8 bar)
> > > +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > +			     u64 cpu_addr, u64 pci_addr, u64 size)
> > > +{
> > > +	u64 limit_addr = pci_addr + size - 1;
> > > +	u32 retries, val;
> > > +
> > > +	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
> > > +	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > > +	    !IS_ALIGNED(pci_addr, pci->region_align) ||
> > > +	    !IS_ALIGNED(size, pci->region_align) ||
> > 
> 
> > Why do you want the size to be aligned? What if I want to transfer a small size
> > buffer?
> > 
> > Same question applies to outbound programming as well.
> 
> You can't program a region with the unaligned size by the DW PCIe CSRs
> design. The limit address lower bits are read-only and fixed with
> one's in accordance with the IP-core synthesize parameter
> CX_ATU_MIN_REGION_SIZE. So the mapping is always performed in the
> CX_ATU_MIN_REGION_SIZE chunks.
> 
> IATU_LIMIT_ADDR_OFF_{IN,OUT}BOUND.LIMIT_ADDR_HW = 
> {(CX_ATU_MIN_REGION_SIZE == 65536) ? "0xffff" :
>  (CX_ATU_MIN_REGION_SIZE == 32768) ? "0x7fff" :
>  (CX_ATU_MIN_REGION_SIZE == 16384) ? "0x3fff" :
>  (CX_ATU_MIN_REGION_SIZE == 8192)  ? "0x1fff" :
>  (CX_ATU_MIN_REGION_SIZE == 4096)  ? "0xfff" : "0xffff"}
> 

Right. Even though the minimum size that could be mapped is 4k, I could still
use that 4k size for mapping small buffers also. So you should not be erroring
out here if the size is not aligned. I know that it is a waste of memory but
that doesn't mean that it won't work.

Thanks,
Mani

> -Sergey
> 
> > 
> > Thanks,
> > Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
