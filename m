Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301146EB8C1
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDVLKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 07:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 07:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F8199A;
        Sat, 22 Apr 2023 04:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86C6960B1B;
        Sat, 22 Apr 2023 11:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A2DC433EF;
        Sat, 22 Apr 2023 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682161804;
        bh=qCRHUiz1mBFiNYBBR10wZwZKDQORhsZ5/9c1C4eIm1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fl1qSc/X15xvjfIPQlKzMg6BggZXVWlcb6ttMXzqRMsTAwjicHkmSaIYOzOh58MeZ
         m85tbWA+ZAItW6Pe5ryBIso6MWJfudAi40zVKW4nViqxNf0xgEh4WNNcgyUXR+gXJh
         sH28kOjYUBRx8z6imK6gKQHbccm4nRakdcIe/H5DkXpN7fIQ3zIkdz8UYV0t39loDD
         CkTffK80Ags0tg42Ojsz/2aHV1SvGNj4cB45tyXEI3P61MxsjgnOXFZxa58TIgtVur
         xwut5ktgjOJIJuMROXvCnsjZNFVNxs52W8/wwFEXMyiFI8HAtpoXjhqiAYyXEUJg7V
         ESU55qiPNdhCA==
Date:   Sat, 22 Apr 2023 16:39:56 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 06/22] PCI: dwc: Introduce struct dw_pcie_outbound_atu
Message-ID: <20230422110956.GC4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:47PM +0900, Yoshihiro Shimoda wrote:
> To add more arguments to the dw_pcie_prog_ep_outbound_atu() in
> the future, introduce struct dw_pcie_outbound_atu. No behavior changes.
> 

Why are you limiting this struct within DWC core and not exposing to client
drivers?

- Mani

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 66 ++++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h |  9 +++
>  2 files changed, 48 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index ede166645289..92bee9d5180d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -464,56 +464,55 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
>  	return val | PCIE_ATU_TD;
>  }
>  
> -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> -				       int index, int type, u64 cpu_addr,
> -				       u64 pci_addr, u64 size)
> +static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> +				       struct dw_pcie_outbound_atu *atu)
>  {
>  	u32 retries, val;
>  	u64 limit_addr;
>  
>  	if (pci->ops && pci->ops->cpu_addr_fixup)
> -		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> +		atu->cpu_addr = pci->ops->cpu_addr_fixup(pci, atu->cpu_addr);
>  
> -	limit_addr = cpu_addr + size - 1;
> +	limit_addr = atu->cpu_addr + atu->size - 1;
>  
> -	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
> -	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> +	if ((limit_addr & ~pci->region_limit) != (atu->cpu_addr & ~pci->region_limit) ||
> +	    !IS_ALIGNED(atu->cpu_addr, pci->region_align) ||
> +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
>  		return -EINVAL;
>  	}
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> -			      lower_32_bits(cpu_addr));
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> -			      upper_32_bits(cpu_addr));
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> +			      lower_32_bits(atu->cpu_addr));
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> +			      upper_32_bits(atu->cpu_addr));
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
>  			      lower_32_bits(limit_addr));
>  	if (dw_pcie_ver_is_ge(pci, 460A))
> -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
>  				      upper_32_bits(limit_addr));
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> -			      lower_32_bits(pci_addr));
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> -			      upper_32_bits(pci_addr));
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> +			      lower_32_bits(atu->pci_addr));
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> +			      upper_32_bits(atu->pci_addr));
>  
> -	val = type | PCIE_ATU_FUNC_NUM(func_no);
> -	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> +	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> +	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
>  	if (dw_pcie_ver_is(pci, 490A))
>  		val = dw_pcie_enable_ecrc(val);
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
>  
>  	/*
>  	 * Make sure ATU enable takes effect before any subsequent config
>  	 * and I/O accesses.
>  	 */
>  	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
> -		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> +		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
>  		if (val & PCIE_ATU_ENABLE)
>  			return 0;
>  
> @@ -528,16 +527,29 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size)
>  {
> -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> -					   cpu_addr, pci_addr, size);
> +	struct dw_pcie_outbound_atu atu = { 0 };
> +
> +	atu.index = index;
> +	atu.type = type;
> +	atu.cpu_addr = cpu_addr;
> +	atu.pci_addr = pci_addr;
> +	atu.size = size;
> +	return __dw_pcie_prog_outbound_atu(pci, &atu);
>  }
>  
>  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				 int type, u64 cpu_addr, u64 pci_addr,
>  				 u64 size)
>  {
> -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> -					   cpu_addr, pci_addr, size);
> +	struct dw_pcie_outbound_atu atu = { 0 };
> +
> +	atu.func_no = func_no;
> +	atu.index = index;
> +	atu.type = type;
> +	atu.cpu_addr = cpu_addr;
> +	atu.pci_addr = pci_addr;
> +	atu.size = size;
> +	return __dw_pcie_prog_outbound_atu(pci, &atu);
>  }
>  
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9acf6c40d252..c6556ee24836 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
>  	DW_PCIE_NUM_CORE_RSTS
>  };
>  
> +struct dw_pcie_outbound_atu {
> +	u64 cpu_addr;
> +	u64 pci_addr;
> +	u64 size;
> +	int index;
> +	int type;
> +	u8 func_no;
> +};
> +
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
>  	void (*host_deinit)(struct dw_pcie_rp *pp);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
