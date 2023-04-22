Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25A06EB8C8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 13:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDVLPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLPw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 07:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DC51703;
        Sat, 22 Apr 2023 04:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F7360BEC;
        Sat, 22 Apr 2023 11:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DEDC433D2;
        Sat, 22 Apr 2023 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682162150;
        bh=8SrgS9teGsL6VT9smLGt8UC6Y0BZhTUAYC3uDFghMTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNsMUxNq1akSHZ1QWHgSVfpuZv2mtq8EeGdaVtUfE3k7d27/ULDMeXGhsC+YvvmCh
         fLKVz9NX0ifdmD9gC/hPZGX/fyhp9ydiUFszm6DgNI9MDKlcJkIcrH8MkS23aiMYS4
         YG0xjdZa55Vzt0i9QfntBo74AnhiVklh61X1To0N+RWHnQhKuCJ+EYQj5vILN1a2CC
         MXMrxiAJHnoCeMDdxEuDYM/8i3L+Yo8rZSpGortIj3KXEtLt7GkcLVcNKNZihHId6z
         +3n0R3qrz7t+688BijOmVJbbnXHhZTlZRalgD/da0T8bmT9KvfdkgB8tsq17+mWtmr
         m+gleIasj/04Q==
Date:   Sat, 22 Apr 2023 16:45:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 06/22] PCI: dwc: Introduce struct dw_pcie_outbound_atu
Message-ID: <20230422111543.GE4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-7-yoshihiro.shimoda.uh@renesas.com>
 <20230422110956.GC4769@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230422110956.GC4769@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 22, 2023 at 04:39:56PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 18, 2023 at 09:23:47PM +0900, Yoshihiro Shimoda wrote:
> > To add more arguments to the dw_pcie_prog_ep_outbound_atu() in
> > the future, introduce struct dw_pcie_outbound_atu. No behavior changes.
> > 
> 
> Why are you limiting this struct within DWC core and not exposing to client
> drivers?

Sry, not client drivers but with the dw_pcie_ep_outbound_atu() API.

- Mani

> 
> - Mani
> 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 66 ++++++++++++--------
> >  drivers/pci/controller/dwc/pcie-designware.h |  9 +++
> >  2 files changed, 48 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index ede166645289..92bee9d5180d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -464,56 +464,55 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> >  	return val | PCIE_ATU_TD;
> >  }
> >  
> > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> > -				       int index, int type, u64 cpu_addr,
> > -				       u64 pci_addr, u64 size)
> > +static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +				       struct dw_pcie_outbound_atu *atu)
> >  {
> >  	u32 retries, val;
> >  	u64 limit_addr;
> >  
> >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> > -		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> > +		atu->cpu_addr = pci->ops->cpu_addr_fixup(pci, atu->cpu_addr);
> >  
> > -	limit_addr = cpu_addr + size - 1;
> > +	limit_addr = atu->cpu_addr + atu->size - 1;
> >  
> > -	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
> > -	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > +	if ((limit_addr & ~pci->region_limit) != (atu->cpu_addr & ~pci->region_limit) ||
> > +	    !IS_ALIGNED(atu->cpu_addr, pci->region_align) ||
> > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
> >  		return -EINVAL;
> >  	}
> >  
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > -			      lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > -			      upper_32_bits(cpu_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> > +			      lower_32_bits(atu->cpu_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> > +			      upper_32_bits(atu->cpu_addr));
> >  
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> >  			      lower_32_bits(limit_addr));
> >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> >  				      upper_32_bits(limit_addr));
> >  
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > -			      lower_32_bits(pci_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > -			      upper_32_bits(pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(atu->pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(atu->pci_addr));
> >  
> > -	val = type | PCIE_ATU_FUNC_NUM(func_no);
> > -	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > +	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > +	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (dw_pcie_ver_is(pci, 490A))
> >  		val = dw_pcie_enable_ecrc(val);
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >  
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> >  
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> >  	 * and I/O accesses.
> >  	 */
> >  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> > -		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> > +		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >  
> > @@ -528,16 +527,29 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> >  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> >  			      u64 cpu_addr, u64 pci_addr, u64 size)
> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > -					   cpu_addr, pci_addr, size);
> > +	struct dw_pcie_outbound_atu atu = { 0 };
> > +
> > +	atu.index = index;
> > +	atu.type = type;
> > +	atu.cpu_addr = cpu_addr;
> > +	atu.pci_addr = pci_addr;
> > +	atu.size = size;
> > +	return __dw_pcie_prog_outbound_atu(pci, &atu);
> >  }
> >  
> >  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> >  				 int type, u64 cpu_addr, u64 pci_addr,
> >  				 u64 size)
> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > -					   cpu_addr, pci_addr, size);
> > +	struct dw_pcie_outbound_atu atu = { 0 };
> > +
> > +	atu.func_no = func_no;
> > +	atu.index = index;
> > +	atu.type = type;
> > +	atu.cpu_addr = cpu_addr;
> > +	atu.pci_addr = pci_addr;
> > +	atu.size = size;
> > +	return __dw_pcie_prog_outbound_atu(pci, &atu);
> >  }
> >  
> >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 9acf6c40d252..c6556ee24836 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
> >  	DW_PCIE_NUM_CORE_RSTS
> >  };
> >  
> > +struct dw_pcie_outbound_atu {
> > +	u64 cpu_addr;
> > +	u64 pci_addr;
> > +	u64 size;
> > +	int index;
> > +	int type;
> > +	u8 func_no;
> > +};
> > +
> >  struct dw_pcie_host_ops {
> >  	int (*host_init)(struct dw_pcie_rp *pp);
> >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > -- 
> > 2.25.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
