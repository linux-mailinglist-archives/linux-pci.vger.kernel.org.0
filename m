Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285B96277BE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 09:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiKNIce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 03:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiKNIcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 03:32:33 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD201B79C;
        Mon, 14 Nov 2022 00:32:31 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u11so12155409ljk.6;
        Mon, 14 Nov 2022 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ZMJdgRtxLwX6ZNHcI79KOMvsJKu2KGy/OzjhSKFJb0=;
        b=c8sb+80RvFMlGaEfTz81y3xyBmCYJ988XD5DPcfIdOeSXgh0HH2BZS9mMXi1leL7yG
         IN/qLp2vuQ59AEBVZjmoaen22cOyum61ZSSckYWWmQefcE/RTnM/n5hoGDZzxUVN5dYF
         sBqayxe2giwqJCwuBAXBYXAEdnK3kRuOPW1zRDoVQXW2yyvMXvfdkeQVKVExK1L1r/U+
         pOSxrzsDCcUPDmycZ4sVUeqZaXOhDDrTnqQnSJjAHrwibNnBp1BDDxRzU3qpk2qu3v79
         bmIkGtpQosoZItfJRSysEaKFeasv2syhBT2iAFF0w8ygWgufkkzsj09fOplai7sL9yaO
         T0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZMJdgRtxLwX6ZNHcI79KOMvsJKu2KGy/OzjhSKFJb0=;
        b=mkH+3S+mW//AbL/gy2YARdZsJcGmmLk/DBG2hesNm58gBCz3O1UiZiQyshZBG1JfEL
         YWSS68zbKAKS+D/hbtRZPfV152B5iSAFeGPSSX2rYbxErXzUFPhfP4A+n4ThFRkNjGc6
         B/zeM/vuak0Uv7J7OVMNNbLe5RvhtlRnG5acR65wXaJVIId0m0huurrgN/zS0pS1ssOm
         UzLvAl5GZOxQw4iZdJ7fF7wL9hXPe3hQrZxiOsOq601qZKefTCoTmNjL0cuVB6NwH09M
         TRM8sXVHgmA9qt6sqPE7ywiUptijXJMSEbaX2Zqqzz2GleGiw6vS0feapyD5KZpmpWSM
         dFgQ==
X-Gm-Message-State: ANoB5pkThXa6l3QuPQAftYUczgih9sZRiaP5NVJk3JRZfAEcLewJyJmr
        rT45zGVORk5voO2/yhLHoSw=
X-Google-Smtp-Source: AA0mqf54rtHTP2npzMWbM/c/zOtdWld/wwFMVedTFLJn2urqXeysIlzw7uMME8I+8GxXRzq8wUgC0Q==
X-Received: by 2002:a2e:5011:0:b0:26d:d94d:37e0 with SMTP id e17-20020a2e5011000000b0026dd94d37e0mr3561188ljb.54.1668414749881;
        Mon, 14 Nov 2022 00:32:29 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id i13-20020ac25d2d000000b004b0b2212315sm1728423lfb.121.2022.11.14.00.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 00:32:29 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:32:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 15/20] PCI: dwc: Introduce dma-ranges property support
 for RC-host
Message-ID: <20221114083227.j4ynx6wjwfwseqqy@mobilestation>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-16-Sergey.Semin@baikalelectronics.ru>
 <20221114063915.GC3869@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114063915.GC3869@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 12:09:15PM +0530, Manivannan Sadhasivam wrote:
> On Sun, Nov 13, 2022 at 10:12:56PM +0300, Serge Semin wrote:
> > In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> > property has the same format as the "ranges" property. The only difference
> > is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> > memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> > property. Even though the DW PCIe controllers are normally equipped with
> > the internal Address Translation Unit which inbound and outbound tables
> > can be used to implement both properties semantics, it was surprising for
> > me to discover that the host-related part of the DW PCIe driver currently
> > supports the "ranges" property only while the "dma-ranges" windows are
> > just ignored. Having the "dma-ranges" supported in the driver would be
> > very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> > mapping and require a customized PCIe memory layout. So let's fix that by
> > introducing the "dma-ranges" property support.
> > 
> > First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
> > dw_pcie_prog_ep_inbound_atu() and create a new version of the
> > dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for the
> > RC and EP controllers respectively in the same way as it has been
> > developed for the outbound ATU setup methods.
> > 
> 

> I think you should split the function renaming part into a separate patch.

Don't see this necessary especially at the current stage of the
patchset. Without this modification the renaming isn't required. So
should a revert-patch is applied both of the updates will be undone.

> 
> > Secondly aside with the memory window index and type the new
> > dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
> > and size as its arguments. These parameters define the PCIe and CPU memory
> > ranges which will be used to setup the respective inbound ATU mapping. The
> > passed parameters need to be verified against the ATU ranges constraints
> > in the same way as it is done for the outbound ranges.
> > 
> > Finally the DMA-ranges detected for the PCIe controller need to be
> > converted to the inbound ATU entries during the host controller
> > initialization procedure. It will be done in the framework of the
> > dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
> > need to disable all the inbound ATU entries in order to prevent unexpected
> > PCIe TLPs translations defined by some third party software like
> > bootloaders.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > ---
> > 
> > Changelog v3:
> > - Drop inbound iATU window size alignment constraint. (@Manivannan)
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
> >  .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.c  | 56 ++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
> >  4 files changed, 89 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 83ddb190292e..237bb01d7852 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -171,8 +171,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> >  		return -EINVAL;
> >  	}
> >  
> > -	ret = dw_pcie_prog_inbound_atu(pci, func_no, free_win, type,
> > -				       cpu_addr, bar);
> > +	ret = dw_pcie_prog_ep_inbound_atu(pci, func_no, free_win, type,
> > +					  cpu_addr, bar);
> >  	if (ret < 0) {
> >  		dev_err(pci->dev, "Failed to program IB window\n");
> >  		return ret;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 39f3b37d4033..ea923c25e12d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -643,12 +643,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	}
> >  
> >  	/*
> > -	 * Ensure all outbound windows are disabled before proceeding with
> > -	 * the MEM/IO ranges setups.
> > +	 * Ensure all out/inbound windows are disabled before proceeding with
> > +	 * the MEM/IO (dma-)ranges setups.
> >  	 */
> >  	for (i = 0; i < pci->num_ob_windows; i++)
> >  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, i);
> >  
> > +	for (i = 0; i < pci->num_ib_windows; i++)
> > +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
> > +
> >  	i = 0;
> >  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> > @@ -685,9 +688,32 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	}
> >  
> >  	if (pci->num_ob_windows <= i)
> > -		dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
> > +		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> >  			 pci->num_ob_windows);
> >  
> > +	i = 0;
> > +	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> > +		if (resource_type(entry->res) != IORESOURCE_MEM)
> > +			continue;
> > +
> > +		if (pci->num_ib_windows <= i)
> > +			break;
> > +
> > +		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
> > +					       entry->res->start,
> > +					       entry->res->start - entry->offset,
> > +					       resource_size(entry->res));
> > +		if (ret) {
> > +			dev_err(pci->dev, "Failed to set DMA range %pr\n",
> > +				entry->res);
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (pci->num_ib_windows <= i)
> > +		dev_warn(pci->dev, "Dma-ranges exceed inbound iATU size (%u)\n",
> 

> s/Dma/dma

Well, I could also make it like DMA-ranges. It depends on what you
imply by the message. I've made it looking like the Ranges-related
counterpart.

-Sergey

> 
> Thanks,
> Mani
> 
> > +			 pci->num_ib_windows);
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index c6725c519a47..ca830ee794a7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -393,8 +393,60 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
> >  	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg, val);
> >  }
> >  
> > -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > -			     int type, u64 cpu_addr, u8 bar)
> > +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > +			     u64 cpu_addr, u64 pci_addr, u64 size)
> > +{
> > +	u64 limit_addr = pci_addr + size - 1;
> > +	u32 retries, val;
> > +
> > +	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
> > +	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > +	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > +		return -EINVAL;
> > +	}
> > +
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_BASE,
> > +			      lower_32_bits(pci_addr));
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_BASE,
> > +			      upper_32_bits(pci_addr));
> > +
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LIMIT,
> > +			      lower_32_bits(limit_addr));
> > +	if (dw_pcie_ver_is_ge(pci, 460A))
> > +		dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_LIMIT,
> > +				      upper_32_bits(limit_addr));
> > +
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(cpu_addr));
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(cpu_addr));
> > +
> > +	val = type;
> > +	if (upper_32_bits(limit_addr) > upper_32_bits(pci_addr) &&
> > +	    dw_pcie_ver_is_ge(pci, 460A))
> > +		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > +
> > +	/*
> > +	 * Make sure ATU enable takes effect before any subsequent config
> > +	 * and I/O accesses.
> > +	 */
> > +	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > +		val = dw_pcie_readl_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2);
> > +		if (val & PCIE_ATU_ENABLE)
> > +			return 0;
> > +
> > +		mdelay(LINK_WAIT_IATU);
> > +	}
> > +
> > +	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > +				int type, u64 cpu_addr, u8 bar)
> >  {
> >  	u32 retries, val;
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index a871ae7eb59e..37801bbce854 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -346,8 +346,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> >  			      u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> >  				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > -int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > -			     int type, u64 cpu_addr, u8 bar);
> > +int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> > +			     u64 cpu_addr, u64 pci_addr, u64 size);
> > +int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > +				int type, u64 cpu_addr, u8 bar);
> >  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
> >  void dw_pcie_setup(struct dw_pcie *pci);
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > -- 
> > 2.38.1
> > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
