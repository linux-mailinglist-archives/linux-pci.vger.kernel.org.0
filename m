Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC16629BCB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKOORO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 09:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiKOORM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 09:17:12 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B2CB67;
        Tue, 15 Nov 2022 06:17:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id be13so24646564lfb.4;
        Tue, 15 Nov 2022 06:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9SZd94cc4jAU5nKFMuQAX9kpDyN+EGTvSB22sxY8zVE=;
        b=hoNnxpLl1Oeqc77U//5IcwxCaNFiwGDLftpLSfOG6tzudY9nMvR6Vkaf5DRz2xOd7P
         G7T1Q9FvxaAtRbvH3CH+ksz0EtKOyibvkmv4B+MG1sG8vwiGv4ROgMBJMWCI5p7JkgST
         OnA07t+OZd+cV/YKa1yjKFLuJmzc+Q1w7G+FuMDIcuKHOjnwj1ZkBIgjhN+17Dhabsfv
         PJtnKA/fimaNzv8NcOVuV5s0ZMWKXGe9AUZ4ZipEqNstObwRhgxlZ+PNZSGBhynqqr/C
         XJryOMLFynpxD5EJjPSRI96XTXtXs7BYw7tTn1DcJykYeldo6DuyiiTu8mqvICoc9hkz
         drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SZd94cc4jAU5nKFMuQAX9kpDyN+EGTvSB22sxY8zVE=;
        b=Q/AZpKi5cC4SpilvRopm0lslyYc4zMqzJVFi94bNKDcVb+xdj8/jD5qEWIPlNMmpLk
         rdY4KbCNKVcnsvOlyrpX1ffHh376QZE8agBC5d5JveCkkfzjkQqNxKHdJk61ggJZAIQy
         djS3WR0w+ZXMvvj+brTo/CPPJXc3WAZJtAYCEp14xlbcy38Pg32CxnMigEWAVlSxDEK0
         t5/opLdnp+Gf151iGE8fsIHevrk3d1bUBQi5lh6/1YCxJG7q151bi6U4YF8DbHAyHsTS
         /gKbxu4m1TiK77O0buIkTEarxPtDldOL1jvFQpIjy/UW+yNrEM4T+F99WJ6mhce3/GYL
         ZkGA==
X-Gm-Message-State: ANoB5pmmJVXMM8WU9V++M/DbTAGYX+YOFhFSlStnLvSfrVA6JSjgl5Nu
        oGW0Art7sKCWD6rROAHfvPU=
X-Google-Smtp-Source: AA0mqf5cI+urj0QqhFloBoCc9h2J2BjQOPh9go2lLUuu4dEmytcDozkscFVYVpkZSLxLctEEHCZqDQ==
X-Received: by 2002:a05:6512:3fa6:b0:4af:d23c:f6f5 with SMTP id x38-20020a0565123fa600b004afd23cf6f5mr6188626lfa.298.1668521829208;
        Tue, 15 Nov 2022 06:17:09 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512020a00b004a45f2e49b1sm2209691lfo.273.2022.11.15.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 06:17:08 -0800 (PST)
Date:   Tue, 15 Nov 2022 17:17:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, caihuoqing <caihuoqing@baidu.com>,
        Vinod Koul <vkoul@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 15/20] PCI: dwc: Introduce dma-ranges property support
 for RC-host
Message-ID: <20221115141706.sxvfj67ymci2rakn@mobilestation>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-16-Sergey.Semin@baikalelectronics.ru>
 <20221114063915.GC3869@thinkpad>
 <20221114083227.j4ynx6wjwfwseqqy@mobilestation>
 <20221114175721.GA5305@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114175721.GA5305@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 11:27:21PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 14, 2022 at 11:32:27AM +0300, Serge Semin wrote:
> > On Mon, Nov 14, 2022 at 12:09:15PM +0530, Manivannan Sadhasivam wrote:
> > > On Sun, Nov 13, 2022 at 10:12:56PM +0300, Serge Semin wrote:
> > > > In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> > > > property has the same format as the "ranges" property. The only difference
> > > > is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> > > > memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> > > > property. Even though the DW PCIe controllers are normally equipped with
> > > > the internal Address Translation Unit which inbound and outbound tables
> > > > can be used to implement both properties semantics, it was surprising for
> > > > me to discover that the host-related part of the DW PCIe driver currently
> > > > supports the "ranges" property only while the "dma-ranges" windows are
> > > > just ignored. Having the "dma-ranges" supported in the driver would be
> > > > very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> > > > mapping and require a customized PCIe memory layout. So let's fix that by
> > > > introducing the "dma-ranges" property support.
> > > > 
> > > > First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
> > > > dw_pcie_prog_ep_inbound_atu() and create a new version of the
> > > > dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for the
> > > > RC and EP controllers respectively in the same way as it has been
> > > > developed for the outbound ATU setup methods.
> > > > 
> > > 
> > 
> > > I think you should split the function renaming part into a separate patch.
> > 
> > Don't see this necessary especially at the current stage of the
> > patchset. Without this modification the renaming isn't required. So
> > should a revert-patch is applied both of the updates will be undone.
> > 
> 
> There is no necessity for both API renaming and dma-ranges implementation to be
> in the same patch as long as first one is functionally independent. But I'll
> defer it to you.
> 
> > > 
> > > > Secondly aside with the memory window index and type the new
> > > > dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
> > > > and size as its arguments. These parameters define the PCIe and CPU memory
> > > > ranges which will be used to setup the respective inbound ATU mapping. The
> > > > passed parameters need to be verified against the ATU ranges constraints
> > > > in the same way as it is done for the outbound ranges.
> > > > 
> > > > Finally the DMA-ranges detected for the PCIe controller need to be
> > > > converted to the inbound ATU entries during the host controller
> > > > initialization procedure. It will be done in the framework of the
> > > > dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
> > > > need to disable all the inbound ATU entries in order to prevent unexpected
> > > > PCIe TLPs translations defined by some third party software like
> > > > bootloaders.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > ---
> > > > 
> > > > Changelog v3:
> > > > - Drop inbound iATU window size alignment constraint. (@Manivannan)
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-designware.c  | 56 ++++++++++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
> > > >  4 files changed, 89 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 83ddb190292e..237bb01d7852 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -171,8 +171,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > > >  		return -EINVAL;
> > > >  	}
> > > >  
> > > > -	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
> > > > -				       cpu_addr, bar);
> > > > +	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> > > > +					  cpu_addr, bar);
> > > >  	if (ret < 0) {
> > > >  		dev_err(pci->dev, "Failed to program IB window\n");
> > > >  		return ret;
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 39f3b37d4033..ea923c25e12d 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -643,12 +643,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > >  	}
> > > >  
> > > >  	/*
> > > > -	 * Ensure all outbound windows are disabled before proceeding with
> > > > -	 * the MEM/IO ranges setups.
> > > > +	 * Ensure all out/inbound windows are disabled before proceeding with
> > > > +	 * the MEM/IO (dma-)ranges setups.
> > > >  	 */
> > > >  	for (i = 0; i < pci->num_ob_windows; i++)
> > > >  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
> > > >  
> > > > +	for (i = 0; i < pci->num_ib_windows; i++)
> > > > +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
> > > > +
> > > >  	i = 0;
> > > >  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> > > >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > > > @@ -685,9 +688,32 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > >  	}
> > > >  
> > > >  	if (pci->num_ob_windows <= i)
> > > > -		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> > > > +		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> > > >  			 pci->num_ob_windows);
> > > >  
> > > > +	i = 0;
> > > > +	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> > > > +		if (resource_type(entry->res) != IORESOURCE_MEM)
> > > > +			continue;
> > > > +
> > > > +		if (pci->num_ib_windows <= i)
> > > > +			break;
> > > > +
> > > > +		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
> > > > +					       entry->res->start,
> > > > +					       entry->res->start - entry->offset,
> > > > +					       resource_size(entry->res));
> > > > +		if (ret) {
> > > > +			dev_err(pci->dev, "Failed to set DMA range %pr\n",
> > > > +				entry->res);
> > > > +			return ret;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (pci->num_ib_windows <= i)
> > > > +		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> > > 
> > 
> > > s/Dma/dma
> > 
> > Well, I could also make it like DMA-ranges. It depends on what you
> > imply by the message. I've made it looking like the Ranges-related
> > counterpart.
> > 
> 

> Either "DMA" or "dma" looks good. I haven't seen "Dma" mostly.

"DMA" it's then. So it would look more like the just "ranges"-related
warning.

-Sergey

> 
> Thanks,
> Mani
> 
> > -Sergey
> > 
> > > 
> > > Thanks,
> > > Mani
> > > 
> > > > +			 pci->num_ib_windows);
> > > > +
> > > >  	return 0;
> > > >  }
> > > >  
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index c6725c519a47..ca830ee794a7 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -393,8 +393,60 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
> > > >  	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
> > > >  }
> > > >  
> > > > -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > -			     int type, u64 cpu_addr, u8 bar)
> > > > +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > > +			     u64 cpu_addr, u64 pci_addr, u64 size)
> > > > +{
> > > > +	u64 limit_addr = pci_addr + size - 1;
> > > > +	u32 retries, val;
> > > > +
> > > > +	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
> > > > +	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > > > +	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_BASE,
> > > > +			      lower_32_bits(pci_addr));
> > > > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_BASE,
> > > > +			      upper_32_bits(pci_addr));
> > > > +
> > > > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LIMIT,
> > > > +			      lower_32_bits(limit_addr));
> > > > +	if (dw_pcie_ver_is_ge(pci, 460A))
> > > > +		dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_LIMIT,
> > > > +				      upper_32_bits(limit_addr));
> > > > +
> > > > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
> > > > +			      lower_32_bits(cpu_addr));
> > > > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
> > > > +			      upper_32_bits(cpu_addr));
> > > > +
> > > > +	val = type;
> > > > +	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
> > > > +	    dw_pcie_ver_is_ge(pci, 460A))
> > > > +		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > > > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > > > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > > > +
> > > > +	/*
> > > > +	 * Make sure ATU enable takes effect before any subsequent config
> > > > +	 * and I/O accesses.
> > > > +	 */
> > > > +	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > > > +		val = dw_pcie_readl_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2);
> > > > +		if (val & PCIE_ATU_ENABLE)
> > > > +			return 0;
> > > > +
> > > > +		mdelay(LINK_WAIT_IATU);
> > > > +	}
> > > > +
> > > > +	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> > > > +
> > > > +	return -ETIMEDOUT;
> > > > +}
> > > > +
> > > > +int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > +				int type, u64 cpu_addr, u8 bar)
> > > >  {
> > > >  	u32 retries, val;
> > > >  
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index a871ae7eb59e..37801bbce854 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -346,8 +346,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> > > >  			      u64 cpu_addr, u64 pci_addr, u64 size);
> > > >  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > >  				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > > > -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > -			     int type, u64 cpu_addr, u8 bar);
> > > > +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > > > +			     u64 cpu_addr, u64 pci_addr, u64 size);
> > > > +int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > > > +				int type, u64 cpu_addr, u8 bar);
> > > >  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
> > > >  void dw_pcie_setup(struct dw_pcie *pci);
> > > >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > > > -- 
> > > > 2.38.1
> > > > 
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
