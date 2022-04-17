Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0AC504963
	for <lists+linux-pci@lfdr.de>; Sun, 17 Apr 2022 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiDQULL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Apr 2022 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiDQULK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2022 16:11:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C0FCFC;
        Sun, 17 Apr 2022 13:08:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so14924932lji.1;
        Sun, 17 Apr 2022 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dril2/s0OpSqxhkClsZ/XlpkAvJevxfYXd46BKy6e1g=;
        b=ZJ5PeBH+0QeLAcI8Atc65URjsKLXEHQZSkTXZNlhujiYs6b62xufTQvCk0C7XbilAA
         YSwJEQDV8dLQHcRW8Cjwo1cr3cvx2oz64c0tMHyQYNcoLIkZl3Mp6eWDuMNALvQ8SlTo
         TXQCJjrxEGoVkfW5/AoDKE0t3Mesz5J1suMh7Oa6jXNuOHMp0bLcE8Rn0GcBJCRqpmlx
         rI0zGrlWVv9Ue3NcfkBrjmYNkXUjM46nwf0zCe/3neKHwWq6WgIMsrblKGLlskNZvqfr
         53WsKLdjuPIwdn965MAoL6PxddTk8p7RuzsqQL1XHQzo4MaVpNIZPM7HXzG7xQ/pt1AA
         vo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dril2/s0OpSqxhkClsZ/XlpkAvJevxfYXd46BKy6e1g=;
        b=uhnWtVhSSy3mWrgAfroQL9RlYjT+7prpFwVvZWKGIgHuubatPGT9fLpaBlujF2Ve/h
         BWJaLqbz0xr/tMClJlEeSsfhmUJei6QW7pUfpoFz17hav2ktpmtkCuWgDAgYIwr5dIA0
         fEwN0JpkJFGvLUyuxBe97vRxikcEsS5bq5AjIs7DZU1owb/NAlDAFKDm6aABVq4Z5rGq
         W+b378vkOcumA+yjPFv6u/lShNQLGs7kFwIinxaHv2fljxta0FzWCPFLBSs717ZJS5Zr
         7VNf63DCaWBthYdiWnlWrgKqD9dSwqrtPej/NyeBBmrMtoHWY4bRWo8QsfO5BmLanCIs
         1L5g==
X-Gm-Message-State: AOAM532vwuetg4epWSEyrnYYNzfzRhT5l2nG9jXaFQZtSUNYwcQECpxY
        Uzy14jfalYKbRopFAcZf3kg=
X-Google-Smtp-Source: ABdhPJyoQKcTCUvLV4fqiTBspdAwPZw63BgUkyVZsHDvEj2dm8DP3liNZJZrQGxQkl4/QpzBu+V1Wg==
X-Received: by 2002:a05:651c:556:b0:24d:b7ba:bd6b with SMTP id q22-20020a05651c055600b0024db7babd6bmr2661496ljp.223.1650226110147;
        Sun, 17 Apr 2022 13:08:30 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id q20-20020a2eb4b4000000b0024da4507c59sm920904ljm.20.2022.04.17.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 13:08:29 -0700 (PDT)
Date:   Sun, 17 Apr 2022 23:08:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] PCI: dwc: Simplify in/outbound iATU setup methods
Message-ID: <20220417200826.auhzzcuzmvbxvqft@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-10-Sergey.Semin@baikalelectronics.ru>
 <YkMluF9uEdoRyeH0@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkMluF9uEdoRyeH0@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 29, 2022 at 10:28:56AM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 04:37:27AM +0300, Serge Semin wrote:
> > From maintainability and scalability points of view it has been wrong to
> > use different iATU inbound and outbound regions accessors for the viewport
> > and unrolled versions of the iATU CSRs mapping. Seeing the particular iATU
> > region-wise registers layout is almost fully compatible for different
> > IP-core versions, there were no much points in splitting the code up that
> > way since it was possible to implement a common windows setup methods for
> > both viewport and unrolled iATU CSRs spaces. While what we can observe in
> > the current driver implementation of these methods, is a lot of code
> > duplication, which consequently worsen the code readability,
> > maintainability and scalability. Note the current implementation is a bit
> > more performant than the one suggested in this commit since it implies
> > having less MMIO accesses. But the gain just doesn't worth having the
> > denoted difficulties especially seeing the iATU setup methods are mainly
> > called on the DW PCIe controller and peripheral devices initialization
> > stage.
> > 
> > Here we suggest to move the iATU viewport and unrolled CSR access
> > specifics in the dw_pcie_readl_atu() and dw_pcie_writel_atu() method, and
> > convert the dw_pcie_prog_outbound_atu() and
> > dw_pcie_prog_{ep_}inbound_atu() functions to being generic instead of
> > having a different methods for each viewport and unrolled types of iATU
> > CSRs mapping. Nothing complex really. First of all the dw_pcie_readl_atu()
> > and dw_pcie_writel_atu() are converted to accept relative iATU CSRs
> > address together with the iATU region direction (inbound or outbound) and
> > region index. If DW PCIe controller doesn't have the unrolled iATU CSRs
> > space, then the accessors will need to activate a iATU viewport based on
> > the specified direction and index, otherwise a base address for the
> > corresponding region CSRs will be calculated by means of the
> > PCIE_ATU_UNROLL_BASE() macro. The CSRs macro have been modified in
> > accordance with that logic in the pcie-designware.h header file.
> > 
> > The rest of the changes in this commit just concern converting the iATU
> > in-/out-bound setup methods and iATU regions detection procedure to be
> > compatible with the new accessors semantics. As a result we've dropped the
> > no more required dw_pcie_prog_outbound_atu_unroll(),
> > dw_pcie_prog_inbound_atu_unroll() and dw_pcie_iatu_detect_regions_unroll()
> > methods.
> > 
> > Note aside with the denoted code improvements, there is an additional
> > positive side effect of this change. If at some point an atomic iATU
> > configs setup procedure is required, it will be possible to be done with
> > no much effort just by adding the synchronization into the
> > dw_pcie_readl_atu() and dw_pcie_writel_atu() accessors.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 301 ++++++-------------
> >  drivers/pci/controller/dwc/pcie-designware.h |  50 ++-
> >  2 files changed, 112 insertions(+), 239 deletions(-)
> 

> Nice diffstat. I didn't really like how this was implemented either.

Yeah, the change has turned to be a bit bulky. I wouldn't really
bother with it if I didn't need to add the "dma-ranges" support.

> 
> I'm guessing you tested the unrolled case only? IIRC, QEMU has the older 
> interface. I can also throw this at kernel-ci if needed. There's a few 
> platforms with DWC that get tested.

In fact I tested the series on DW PCIe Host v4.60a with the legacy
iATU/eDMA registers mapping (viewport-based). So testing on the modern
controllers with the unrolled iATU/eDMA region would be very welcome.

> 
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index b983128584ff..f1aa6e2e85fe 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -205,48 +205,67 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
> >  		dev_err(pci->dev, "write DBI address failed\n");
> >  }
> >  
> > -static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
> > +static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 dir, u32 region, u32 reg)
> >  {
> > +	void __iomem *base;
> >  	int ret;
> >  	u32 val;
> >  
> > +	if (pci->iatu_unroll_enabled) {
> > +		base = pci->atu_base;
> > +		reg = reg + PCIE_ATU_UNROLL_BASE(dir, region);
> > +	} else {
> > +		base = pci->dbi_base;
> > +		reg = reg + PCIE_ATU_VIEWPORT_BASE;
> > +
> > +		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | region);
> > +	}
> > +
> >  	if (pci->ops && pci->ops->read_dbi)
> > -		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
> > +		return pci->ops->read_dbi(pci, base, reg, 4);
> >  
> > -	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
> > +	ret = dw_pcie_read(base + reg, 4, &val);
> >  	if (ret)
> >  		dev_err(pci->dev, "Read ATU address failed\n");
> >  
> >  	return val;
> >  }
> >  
> > -static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
> > +static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 dir, u32 region,
> > +			       u32 reg, u32 val)
> >  {
> > +	void __iomem *base;
> >  	int ret;
> >  
> > +	if (pci->iatu_unroll_enabled) {
> > +		base = pci->atu_base;
> > +		reg = reg + PCIE_ATU_UNROLL_BASE(dir, region);
> > +	} else {
> > +		base = pci->dbi_base;
> > +		reg = reg + PCIE_ATU_VIEWPORT_BASE;
> > +
> > +		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | region);
> > +	}
> 

> You have this same sequence twice. Make it a helper function.

Ok. I'll move this code into a helper function - dw_pcie_select_atu().

> 
> > +
> >  	if (pci->ops && pci->ops->write_dbi) {
> > -		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
> > +		pci->ops->write_dbi(pci, base, reg, 4, val);
> >  		return;
> >  	}
> >  
> > -	ret = dw_pcie_write(pci->atu_base + reg, 4, val);
> > +	ret = dw_pcie_write(base + reg, 4, val);
> >  	if (ret)
> >  		dev_err(pci->dev, "Write ATU address failed\n");
> >  }
> >  
> > -static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
> > +static inline u32 dw_pcie_readl_atu_ob(struct dw_pcie *pci, u32 region, u32 reg)
> >  {
> > -	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> > -
> > -	return dw_pcie_readl_atu(pci, offset + reg);
> > +	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_OB, region, reg);
> >  }
> >  
> > -static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
> > -				     u32 val)
> > +static inline void dw_pcie_writel_atu_ob(struct dw_pcie *pci, u32 region, u32 reg,
> > +					 u32 val)
> >  {
> > -	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> > -
> > -	dw_pcie_writel_atu(pci, offset + reg, val);
> > +	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_OB, region, reg, val);
> >  }
> >  
> >  static inline u32 dw_pcie_enable_ecrc(u32 val)
> > @@ -290,50 +309,6 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> >  	return val | PCIE_ATU_TD;
> >  }
> >  
> > -static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > -					     int index, int type,
> > -					     u64 cpu_addr, u64 pci_addr,
> > -					     u64 size)
> > -{
> > -	u32 retries, val;
> > -	u64 limit_addr = cpu_addr + size - 1;
> > -
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
> > -				 lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
> > -				 upper_32_bits(cpu_addr));
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_LIMIT,
> > -				 lower_32_bits(limit_addr));
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_LIMIT,
> > -				 upper_32_bits(limit_addr));
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
> > -				 lower_32_bits(pci_addr));
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> > -				 upper_32_bits(pci_addr));
> > -	val = type | PCIE_ATU_FUNC_NUM(func_no);
> > -	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
> > -		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > -	if (dw_pcie_ver_is(pci, 490A))
> > -		val = dw_pcie_enable_ecrc(val);
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
> > -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > -				 PCIE_ATU_ENABLE);
> > -
> > -	/*
> > -	 * Make sure ATU enable takes effect before any subsequent config
> > -	 * and I/O accesses.
> > -	 */
> > -	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > -		val = dw_pcie_readl_ob_unroll(pci, index,
> > -					      PCIE_ATU_UNR_REGION_CTRL2);
> > -		if (val & PCIE_ATU_ENABLE)
> > -			return;
> > -
> > -		mdelay(LINK_WAIT_IATU);
> > -	}
> > -	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> > -}
> > -
> >  static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  					int index, int type, u64 cpu_addr,
> >  					u64 pci_addr, u64 size)
> > @@ -344,49 +319,46 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> >  		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> >  
> > -	if (pci->iatu_unroll_enabled) {
> > -		dw_pcie_prog_outbound_atu_unroll(pci, func_no, index, type,
> > -						 cpu_addr, pci_addr, size);
> > -		return;
> > -	}
> > -
> >  	limit_addr = cpu_addr + size - 1;
> >  
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT,
> > -			   PCIE_ATU_REGION_OUTBOUND | index);
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_BASE,
> > -			   lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_BASE,
> > -			   upper_32_bits(cpu_addr));
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
> > -			   lower_32_bits(limit_addr));
> > +	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > +			      lower_32_bits(cpu_addr));
> > +	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > +			      upper_32_bits(cpu_addr));
> > +
> > +	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > +			      lower_32_bits(limit_addr));
> >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > -		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> > -				   upper_32_bits(limit_addr));
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
> > -			   lower_32_bits(pci_addr));
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
> > -			   upper_32_bits(pci_addr));
> > +		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > +				      upper_32_bits(limit_addr));
> > +
> > +	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(pci_addr));
> > +
> >  	val = type | PCIE_ATU_FUNC_NUM(func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (dw_pcie_ver_is(pci, 490A))
> >  		val = dw_pcie_enable_ecrc(val);
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
> > +	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > +
> > +	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> >  
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> >  	 * and I/O accesses.
> >  	 */
> >  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > -		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
> > +		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return;
> >  
> >  		mdelay(LINK_WAIT_IATU);
> >  	}
> > +
> >  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> >  }
> >  
> > @@ -405,54 +377,15 @@ void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> >  				    cpu_addr, pci_addr, size);
> >  }
> >  
> > -static u32 dw_pcie_readl_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg)
> > -{
> > -	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
> > -
> > -	return dw_pcie_readl_atu(pci, offset + reg);
> > -}
> > -
> > -static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
> > -				     u32 val)
> > +static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 region, u32 reg)
> >  {
> > -	u32 offset = PCIE_GET_ATU_INB_UNR_REG_OFFSET(index);
> > -
> > -	dw_pcie_writel_atu(pci, offset + reg, val);
> > +	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, region, reg);
> >  }
> >  
> > -static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> > -					   int index, int type,
> > -					   u64 cpu_addr, u8 bar)
> > +static inline void dw_pcie_writel_atu_ib(struct dw_pcie *pci, u32 region, u32 reg,
> > +					 u32 val)
> >  {
> > -	u32 retries, val;
> > -
> > -	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
> > -				 lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> > -				 upper_32_bits(cpu_addr));
> > -
> > -	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, type |
> > -				 PCIE_ATU_FUNC_NUM(func_no));
> > -	dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > -				 PCIE_ATU_FUNC_NUM_MATCH_EN |
> > -				 PCIE_ATU_ENABLE |
> > -				 PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
> > -
> > -	/*
> > -	 * Make sure ATU enable takes effect before any subsequent config
> > -	 * and I/O accesses.
> > -	 */
> > -	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > -		val = dw_pcie_readl_ib_unroll(pci, index,
> > -					      PCIE_ATU_UNR_REGION_CTRL2);
> > -		if (val & PCIE_ATU_ENABLE)
> > -			return 0;
> > -
> > -		mdelay(LINK_WAIT_IATU);
> > -	}
> > -	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> > -
> > -	return -EBUSY;
> > +	dw_pcie_writel_atu(pci, PCIE_ATU_REGION_DIR_IB, region, reg, val);
> >  }
> >  
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> > @@ -460,65 +393,51 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> >  {
> >  	u32 retries, val;
> >  
> > -	if (pci->iatu_unroll_enabled)
> > -		return dw_pcie_prog_inbound_atu_unroll(pci, func_no, index, type,
> > -						       cpu_addr, bar);
> > -
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND |
> > -			   index);
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET, upper_32_bits(cpu_addr));
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(cpu_addr));
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(cpu_addr));
> >  
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> > -			   PCIE_ATU_FUNC_NUM(func_no));
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE |
> > -			   PCIE_ATU_FUNC_NUM_MATCH_EN |
> > -			   PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL1, type |
> > +			      PCIE_ATU_FUNC_NUM(func_no));
> > +	dw_pcie_writel_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2,
> > +			      PCIE_ATU_ENABLE | PCIE_ATU_FUNC_NUM_MATCH_EN |
> > +			      PCIE_ATU_BAR_MODE_ENABLE | (bar << 8));
> >  
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> >  	 * and I/O accesses.
> >  	 */
> >  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > -		val = dw_pcie_readl_dbi(pci, PCIE_ATU_CR2);
> > +		val = dw_pcie_readl_atu_ib(pci, index, PCIE_ATU_REGION_CTRL2);
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >  
> >  		mdelay(LINK_WAIT_IATU);
> >  	}
> > +
> >  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> >  
> > -	return -EBUSY;
> > +	return -ETIMEDOUT;
> >  }
> >  
> >  void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
> >  			 enum dw_pcie_region_type type)
> >  {
> > -	int region;
> > +	u32 dir;
> >  
> >  	switch (type) {
> >  	case DW_PCIE_REGION_INBOUND:
> > -		region = PCIE_ATU_REGION_INBOUND;
> > +		dir = PCIE_ATU_REGION_DIR_IB;
> 

> Is this the same double definition with the enum?

Absolutely right. I'll drop it in the next patch of this series. I'll
also move that patch to being applied before this one so to prevent
this question from araising and to simplify this patch a bit.

> 
> >  		break;
> >  	case DW_PCIE_REGION_OUTBOUND:
> > -		region = PCIE_ATU_REGION_OUTBOUND;
> > +		dir = PCIE_ATU_REGION_DIR_OB;
> >  		break;
> >  	default:
> >  		return;
> >  	}
> >  
> > -	if (pci->iatu_unroll_enabled) {
> > -		if (region == PCIE_ATU_REGION_INBOUND) {
> > -			dw_pcie_writel_ib_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > -						 ~(u32)PCIE_ATU_ENABLE);
> > -		} else {
> > -			dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
> > -						 ~(u32)PCIE_ATU_ENABLE);
> > -		}
> > -	} else {
> > -		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, region | index);
> > -		dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, ~(u32)PCIE_ATU_ENABLE);
> > -	}
> > +	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> >  }
> >  
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > @@ -622,63 +541,29 @@ static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> >  	return false;
> >  }
> >  
> > -static void dw_pcie_iatu_detect_regions_unroll(struct dw_pcie *pci)
> > -{
> > -	int max_region, i, ob = 0, ib = 0;
> > -	u32 val;
> > -
> > -	max_region = min((int)pci->atu_size / 512, 256);
> > -
> > -	for (i = 0; i < max_region; i++) {
> > -		dw_pcie_writel_ob_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET,
> > -					0x11110000);
> > -
> > -		val = dw_pcie_readl_ob_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET);
> > -		if (val == 0x11110000)
> > -			ob++;
> > -		else
> > -			break;
> > -	}
> > -
> > -	for (i = 0; i < max_region; i++) {
> > -		dw_pcie_writel_ib_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET,
> > -					0x11110000);
> > -
> > -		val = dw_pcie_readl_ib_unroll(pci, i, PCIE_ATU_UNR_LOWER_TARGET);
> > -		if (val == 0x11110000)
> > -			ib++;
> > -		else
> > -			break;
> > -	}
> > -	pci->num_ib_windows = ib;
> > -	pci->num_ob_windows = ob;
> > -}
> > -
> >  static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
> >  {
> > -	int max_region, i, ob = 0, ib = 0;
> > +	int max_region, ob, ib;
> >  	u32 val;
> >  
> > -	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
> > -	max_region = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT) + 1;
> > +	if (pci->iatu_unroll_enabled) {
> > +		max_region = min((int)pci->atu_size / 512, 256);
> > +	} else {
> > +		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
> > +		max_region = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT) + 1;
> > +	}
> >  
> > -	for (i = 0; i < max_region; i++) {
> > -		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_OUTBOUND | i);
> > -		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, 0x11110000);
> > -		val = dw_pcie_readl_dbi(pci, PCIE_ATU_LOWER_TARGET);
> > -		if (val == 0x11110000)
> > -			ob++;
> > -		else
> > +	for (ob = 0; ob < max_region; ob++) {
> > +		dw_pcie_writel_atu_ob(pci, ob, PCIE_ATU_LOWER_TARGET, 0x11110000);
> > +		val = dw_pcie_readl_atu_ob(pci, ob, PCIE_ATU_LOWER_TARGET);
> > +		if (val != 0x11110000)
> >  			break;
> >  	}
> >  
> > -	for (i = 0; i < max_region; i++) {
> > -		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, PCIE_ATU_REGION_INBOUND | i);
> > -		dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET, 0x11110000);
> > -		val = dw_pcie_readl_dbi(pci, PCIE_ATU_LOWER_TARGET);
> > -		if (val == 0x11110000)
> > -			ib++;
> > -		else
> > +	for (ib = 0; ib < max_region; ib++) {
> > +		dw_pcie_writel_atu_ib(pci, ib, PCIE_ATU_LOWER_TARGET, 0x11110000);
> > +		val = dw_pcie_readl_atu_ib(pci, ib, PCIE_ATU_LOWER_TARGET);
> > +		if (val != 0x11110000)
> >  			break;
> >  	}
> >  
> > @@ -707,12 +592,10 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >  		if (!pci->atu_size)
> >  			/* Pick a minimal default, enough for 8 in and 8 out windows */
> >  			pci->atu_size = SZ_4K;
> > -
> > -		dw_pcie_iatu_detect_regions_unroll(pci);
> > -	} else {
> > -		dw_pcie_iatu_detect_regions(pci);
> >  	}
> >  
> > +	dw_pcie_iatu_detect_regions(pci);
> > +
> >  	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
> >  		"enabled" : "disabled");
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 449c5ad92edc..6adf0c957c3b 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -103,10 +103,20 @@
> >  #define PCIE_VERSION_NUMBER		0x8F8
> >  #define PCIE_VERSION_TYPE		0x8FC
> >  

> > +/*
> > + * iATU inbound and outbound windows CSRs. Before the IP-core v4.80a each
> > + * iATU region CSRs had been indirectly accessible by means of the dedicated
> > + * viewport selector. The iATU/eDMA CSRs space was re-designed in DWC PCIe
> > + * v4.80a in a way so the viewport was unrolled into the directly accessible
> > + * iATU/eDMA CSRs space.
> 
> IIRC, I think it is configurable in later versions. There was some 
> discussion when I did the detection.

There are two internal IP-core parameters which indicate whether the
unrolled eDMA/iATU CSRs mapping is enabled:
CC_UNROLL_EN = (CC_DMA_ENABLE || CX_INTERNAL_ATU_ENABLE) && !AHB_POPULATED
and
CC_UNROLL_ENABLE = ((CC_UNROLL_EN ==0) ? 0: 1)
Normally these parameters shouldn't be manually changed since they
aren't advertised in the list of the configurable IP-core parameters.
But there is a note in the databook (v4.90a, v5.20a, v5.40a) which
suggests to contact the Synopsys support if it's required to enable
the legacy mapping on the later IP-core versions. So basically you are
right. It is configurable, but not in the normal circumstances.
Practically I don't think there is any modern DW PCIe controller
implemented with the legacy eDMA/iATU CSRs mapping since the modern
CPUs/SoC-Interconnects mainly have enough unused IO space for
the unrolled access.

-Sergey

> 
> > + */
> >  #define PCIE_ATU_VIEWPORT		0x900
> > -#define PCIE_ATU_REGION_INBOUND		BIT(31)
> > -#define PCIE_ATU_REGION_OUTBOUND	0
> > -#define PCIE_ATU_CR1			0x904
> > +#define PCIE_ATU_REGION_DIR_IB		BIT(31)
> > +#define PCIE_ATU_REGION_DIR_OB		0
> > +#define PCIE_ATU_VIEWPORT_BASE		0x904
> > +#define PCIE_ATU_UNROLL_BASE(dir, region) \
> > +	(((region) << 9) | ((dir == PCIE_ATU_REGION_DIR_IB) ? BIT(8) : 0))
> > +#define PCIE_ATU_REGION_CTRL1		0x000
> >  #define PCIE_ATU_INCREASE_REGION_SIZE	BIT(13)
> >  #define PCIE_ATU_TYPE_MEM		0x0
> >  #define PCIE_ATU_TYPE_IO		0x2
> > @@ -114,19 +124,19 @@
> >  #define PCIE_ATU_TYPE_CFG1		0x5
> >  #define PCIE_ATU_TD			BIT(8)
> >  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> > -#define PCIE_ATU_CR2			0x908
> > +#define PCIE_ATU_REGION_CTRL2		0x004
> >  #define PCIE_ATU_ENABLE			BIT(31)
> >  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> >  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
> > -#define PCIE_ATU_LOWER_BASE		0x90C
> > -#define PCIE_ATU_UPPER_BASE		0x910
> > -#define PCIE_ATU_LIMIT			0x914
> > -#define PCIE_ATU_LOWER_TARGET		0x918
> > +#define PCIE_ATU_LOWER_BASE		0x008
> > +#define PCIE_ATU_UPPER_BASE		0x00C
> > +#define PCIE_ATU_LIMIT			0x010
> > +#define PCIE_ATU_LOWER_TARGET		0x014
> >  #define PCIE_ATU_BUS(x)			FIELD_PREP(GENMASK(31, 24), x)
> >  #define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
> >  #define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
> > -#define PCIE_ATU_UPPER_TARGET		0x91C
> > -#define PCIE_ATU_UPPER_LIMIT		0x924
> > +#define PCIE_ATU_UPPER_TARGET		0x018
> > +#define PCIE_ATU_UPPER_LIMIT		0x020
> >  
> >  #define PCIE_MISC_CONTROL_1_OFF		0x8BC
> >  #define PCIE_DBI_RO_WR_EN		BIT(0)
> > @@ -143,19 +153,6 @@
> >  
> >  #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
> >  
> > -/*
> > - * iATU Unroll-specific register definitions
> > - * From 4.80 core version the address translation will be made by unroll
> > - */
> > -#define PCIE_ATU_UNR_REGION_CTRL1	0x00
> > -#define PCIE_ATU_UNR_REGION_CTRL2	0x04
> > -#define PCIE_ATU_UNR_LOWER_BASE		0x08
> > -#define PCIE_ATU_UNR_UPPER_BASE		0x0C
> > -#define PCIE_ATU_UNR_LOWER_LIMIT	0x10
> > -#define PCIE_ATU_UNR_LOWER_TARGET	0x14
> > -#define PCIE_ATU_UNR_UPPER_TARGET	0x18
> > -#define PCIE_ATU_UNR_UPPER_LIMIT	0x20
> > -
> >  /*
> >   * The default address offset between dbi_base and atu_base. Root controller
> >   * drivers are not required to initialize atu_base if the offset matches this
> > @@ -164,13 +161,6 @@
> >   */
> >  #define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
> >  
> > -/* Register address builder */
> > -#define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region) \
> > -		((region) << 9)
> > -
> > -#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region) \
> > -		(((region) << 9) | BIT(8))
> > -
> >  #define MAX_MSI_IRQS			256
> >  #define MAX_MSI_IRQS_PER_CTRL		32
> >  #define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
> > -- 
> > 2.35.1
> > 
