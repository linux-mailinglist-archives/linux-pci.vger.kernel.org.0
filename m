Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3995255F0
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 21:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbiELTlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiELTlm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 15:41:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AB6668D;
        Thu, 12 May 2022 12:41:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o22so6892841ljp.8;
        Thu, 12 May 2022 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cGDizKqz57NFsljUh93KIrEBVX36w/j5wUeJwwId2hs=;
        b=ICOQWV7zK6sj2RzT+enPZ2r6wWemflkEfBS0w2YroWDxw3k0bQwUrA8gght4Hf7NiH
         fzAYAZCIGighSJ16253ETDjhYWgNXYxa09sXBRTs3JNTA2U1KV28Ea0HGNE5sxVQjYX/
         YGyXpACp8LFcrqdeF4A02RR//awj+M2REGFdi2XYEUYp7CAajW78ZR0r2qFs8xDb75o/
         C8KZRoD9/eKjTPE/I/hgUZjwJNAN7xrU9MoaTaL8tv8/8shd94Kszls6nZjBHbSchq/X
         WBj4GXi6lsEmpN61dV7T7ngmcVL8PWynPJBOgeMhXZ5KuDtizSX/0RFPqBKJj31vBdXk
         CGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cGDizKqz57NFsljUh93KIrEBVX36w/j5wUeJwwId2hs=;
        b=yEW9i0D/gbJX7eBCcT0SVar/2nV3ibaEZfgMYpLpjK4jnnZ2Q5pxYyjsAELTy9OHMt
         JbF5hUsmmVu6LeRDK7PqvHJKwNpPI0QkUDSxq6Den/U/B8VzW37CVh+4FmKZvXTaJrUK
         jjLBBUVr0rr2WCd9GM9IHL9nLm3UJ8iGTHWjbrZet5cIsPLx4bsZ/iJaKuUP0NxSiNgK
         gGKbin9VvCtjG/w59/9yW1t3OHh8wfAIxn3sAaSFEAN3yemm53FiQ/iGFvJzz5eEj/bO
         /2CvRGS0mDgHJiydflrRfPT8QZmfyRM4klBH9vg2k6NiKVDsXhYimfVawMUtYrt8BZYd
         2BJA==
X-Gm-Message-State: AOAM5329rze3vZycDaZOZ/OH5UMSeu/zI3WagPXjlrtl1gIv7zgN5I2h
        otk3ldL2K0d3PGbXwIAD9pM=
X-Google-Smtp-Source: ABdhPJzrsq0ZUWidqAWa3NN1GUC6DpohPgUcRchGIK6CHREZah8SYDzcZ3P39/lwlK0mKBy5/altqA==
X-Received: by 2002:a2e:9105:0:b0:24f:2558:8787 with SMTP id m5-20020a2e9105000000b0024f25588787mr934101ljg.65.1652384498592;
        Thu, 12 May 2022 12:41:38 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id r27-20020a2eb61b000000b0024f3d1dae80sm68655ljn.8.2022.05.12.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:41:38 -0700 (PDT)
Date:   Thu, 12 May 2022 22:41:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <20220512194135.ku73pae2xdvyocx7@mobilestation>
References: <20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru>
 <20220503214638.1895-16-Sergey.Semin@baikalelectronics.ru>
 <20220512135708.GC35848@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512135708.GC35848@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 07:27:08PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 04, 2022 at 12:46:36AM +0300, Serge Semin wrote:
> > In accordance with the generic PCIe Root Port DT-bindings the "dma-ranges"
> > property has the same format as the "ranges" property. The only difference
> > is in their semantics. The "dma-ranges" property describes the PCIe-to-CPU
> > memory mapping in opposite to the CPU-to-PCIe mapping of the "ranges"
> > property. Even though the DW PCIe controllers are normally equipped with
> > internal Address Translation Unit which inbound and outbound tables can be
> > used to implement both properties semantics, it was surprise for me to
> > discover that the host-related part of the DW PCIe driver currently
> > supports the "ranges" property only while the "dma-ranges" windows are
> > just ignored. Having the "dma-ranges" supported in the driver would be
> > very handy for the platforms, that don't tolerate the 1:1 CPU-PCIe memory
> > mapping and require customized the PCIe memory layout. So let's fix that
> > by introducing the "dma-ranges" property support.
> > 
> > First of all we suggest to rename the dw_pcie_prog_inbound_atu() method to
> > dw_pcie_prog_ep_inbound_atu() and create a new version of the
> > dw_pcie_prog_inbound_atu() function. Thus we'll have two methods for RC
> > and EP controllers respectively in the same way as it has been developed
> > for the outbound ATU setup methods.
> > 
> > Secondly aside with the memory window index and type the new
> > dw_pcie_prog_inbound_atu() function will accept CPU address, PCIe address
> > and size as its arguments. These parameters define the PCIe and CPU memory
> > ranges which will be used to setup the respective inbound ATU mapping. The
> > passed parameters need to be verified against the ATU ranges constraints
> > in the same way as it is done for the outbound ranges.
> > 
> > Finally the DMA-ranges detected for the PCIe controller need to be
> > converted into the inbound ATU entries during the host controller
> > initialization procedure. It will be done in the framework of the
> > dw_pcie_iatu_setup() method. Note before setting the inbound ranges up we
> > need to disable all the inbound ATU entries in order to prevent unexpected
> > PCIe TLPs translations defined by some third party software like
> > bootloader.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
> >  .../pci/controller/dwc/pcie-designware-host.c | 32 ++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.c  | 57 ++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h  |  6 +-
> >  4 files changed, 90 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index c62640201246..9b0540cfa9e8 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -167,8 +167,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
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
> > index 7caca6c575a5..9cb406f5c185 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -612,12 +612,15 @@ static int dw_pcie_iatu_setup(struct pcie_port *pp)
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
> > @@ -654,9 +657,32 @@ static int dw_pcie_iatu_setup(struct pcie_port *pp)
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
> > +			 pci->num_ib_windows);
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 747e252c09e6..33718ed6c511 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -397,8 +397,61 @@ static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 index, u32 reg
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
> > +	    !IS_ALIGNED(pci_addr, pci->region_align) ||
> > +	    !IS_ALIGNED(size, pci->region_align) ||
> 

> Why do you want the size to be aligned? What if I want to transfer a small size
> buffer?
> 
> Same question applies to outbound programming as well.

You can't program a region with the unaligned size by the DW PCIe CSRs
design. The limit address lower bits are read-only and fixed with
one's in accordance with the IP-core synthesize parameter
CX_ATU_MIN_REGION_SIZE. So the mapping is always performed in the
CX_ATU_MIN_REGION_SIZE chunks.

IATU_LIMIT_ADDR_OFF_{IN,OUT}BOUND.LIMIT_ADDR_HW = 
{(CX_ATU_MIN_REGION_SIZE == 65536) ? "0xffff" :
 (CX_ATU_MIN_REGION_SIZE == 32768) ? "0x7fff" :
 (CX_ATU_MIN_REGION_SIZE == 16384) ? "0x3fff" :
 (CX_ATU_MIN_REGION_SIZE == 8192)  ? "0x1fff" :
 (CX_ATU_MIN_REGION_SIZE == 4096)  ? "0xfff" : "0xffff"}

-Sergey

> 
> Thanks,
> Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
