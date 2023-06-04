Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4523721B1F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 01:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjFDX4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 19:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFDX4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 19:56:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D295C4;
        Sun,  4 Jun 2023 16:56:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so3277072e87.2;
        Sun, 04 Jun 2023 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685922971; x=1688514971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWGxEA9l0UGhuiYJWE5IMwjM3NqB6B1yogiaO86CIeI=;
        b=CG5wcdhkEP+Kri6HWVLpjcVMFzZqlSasqqNaP4dv8ofm8ecD+NnUzS302dCvFT+ftC
         r8dAqHoz7GEDYS0ES4i+VAiHy9ssMJDO1G2eaYATKgXqwy1qUaziUnXIljrQURn/jh78
         j2i2+cPgSdAV5wK4twarnG8SXK02SCZU1mfftPwKIqWOW3wpV3FT9Y/YJ6S6HgmY/kop
         CMFvuFOhc4xnOHn6jJfUkNm8T2y1/8nxe4GTys6mNTd4guMk3ExwdhF4Rr8Y8lOT5XQI
         8IbcxszSrEQ8OIXrUze7HBfc3OCcHcKTkcLOumViSszKxrqJIXEwVT6DFvs7uFXCYMOK
         lHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685922971; x=1688514971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWGxEA9l0UGhuiYJWE5IMwjM3NqB6B1yogiaO86CIeI=;
        b=bhjAnJComIE//QJYVNlNmkHT79sbnCMuVpaMGlvRGTP6s1wueSfSnuZ/0zkjosb8jm
         nNiIeRYngX9pA9HBpkBq32XRCapDJ1pcLKCPXOstw2xkO132d6cRwwq4KzNFp1uGnmXb
         ytEftcqEcgckknzzUtetpJd/Y18hj5l8AfYdcqbFkaTVFRmJffeOuPmTyAa5gS0MPO6C
         EWIawGTknW5ki4QvkE3xezlG4tsz9quMEPbnrlPskxZdUS/qtxOH22DrsJLsINM8buM4
         Toj1hbdPR+NFetPkkoVcMbt3ni2MXzhxHB5cZukd8suT8juY+vudav/akutT3D7ihECM
         FWZA==
X-Gm-Message-State: AC+VfDywct5P0vbLszueZEqy/8rlJVoahXIQJ6NZ6bx/+sPH1lxFoolw
        QlJERWW//zph2yXO2ddaYoI=
X-Google-Smtp-Source: ACHHUZ7WoT1EQDx1v2u7rfSJ64Grww9YCa6m+t6rWb2WHhXg6467KQLvg7MLETytv5kiO8UfKTzenw==
X-Received: by 2002:a2e:7310:0:b0:298:a840:ec65 with SMTP id o16-20020a2e7310000000b00298a840ec65mr3224022ljc.36.1685922970605;
        Sun, 04 Jun 2023 16:56:10 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id a24-20020a2e9818000000b002ad994b0b51sm1207147ljj.16.2023.06.04.16.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 16:56:10 -0700 (PDT)
Date:   Mon, 5 Jun 2023 02:56:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 06/22] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <20230604235607.nyiy4ghk3idgsd7u@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:18PM +0900, Yoshihiro Shimoda wrote:
> To add more arguments to the dw_pcie_prog_outbound_atu() in
> the future, introduce struct dw_pcie_ob_atu_cfg and change
> the argument. And, drop dw_pcie_prog_ep_outbound_atu(). No behavior
> changes.

I doubt anyone not being aware of the change context will understand
your message. More details would help with that: why the conversion
was necessary, how come the dw_pcie_prog_ep_outbound_atu() function
turns to be redundant, what additional parameters will be added
afterwards so this patch turns to be a preparation patch for that, etc.

Other than that the change looks good.

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 21 +++++---
>  .../pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.c  | 49 ++++++-----------
>  drivers/pci/controller/dwc/pcie-designware.h  | 15 ++++--
>  4 files changed, 77 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 27278010ecec..fe2e0d765be9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -182,9 +182,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> -				   phys_addr_t phys_addr,
> -				   u64 pci_addr, size_t size)
> +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> +				   struct dw_pcie_ob_atu_cfg *atu)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	u32 free_win;
> @@ -196,13 +195,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EINVAL;
>  	}
>  
> -	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> -					   phys_addr, pci_addr, size);
> +	atu->index = free_win;
> +	ret = dw_pcie_prog_outbound_atu(pci, atu);
>  	if (ret)
>  		return ret;
>  
>  	set_bit(free_win, ep->ob_window_map);
> -	ep->outbound_addr[free_win] = phys_addr;
> +	ep->outbound_addr[free_win] = atu->cpu_addr;
>  
>  	return 0;
>  }
> @@ -305,8 +304,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	int ret;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -
> -	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> +
> +	atu.func_no = func_no;
> +	atu.type = PCIE_ATU_TYPE_MEM;
> +	atu.cpu_addr = addr;
> +	atu.pci_addr = pci_addr;
> +	atu.size = size;
> +	ret = dw_pcie_ep_outbound_atu(ep, &atu);
>  	if (ret) {
>  		dev_err(pci->dev, "Failed to enable address\n");
>  		return ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 5718b4bb67f0..676216d540fe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -544,6 +544,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  {
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	int type, ret;
>  	u32 busdev;
>  
> @@ -566,8 +567,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>  	else
>  		type = PCIE_ATU_TYPE_CFG1;
>  
> -	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
> -					pp->cfg0_size);
> +	atu.type = type;
> +	atu.cpu_addr = pp->cfg0_base;
> +	atu.pci_addr = busdev;
> +	atu.size = pp->cfg0_size;
> +
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  	if (ret)
>  		return NULL;
>  
> @@ -579,6 +584,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
>  {
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	int ret;
>  
>  	ret = pci_generic_config_read(bus, devfn, where, size, val);
> @@ -586,9 +592,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
>  		return ret;
>  
>  	if (pp->cfg0_io_shared) {
> -		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> -						pp->io_base, pp->io_bus_addr,
> -						pp->io_size);
> +		atu.type = PCIE_ATU_TYPE_IO;
> +		atu.cpu_addr = pp->io_base;
> +		atu.pci_addr = pp->io_bus_addr;
> +		atu.size = pp->io_size;
> +
> +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret)
>  			return PCIBIOS_SET_FAILED;
>  	}
> @@ -601,6 +610,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
>  {
>  	struct dw_pcie_rp *pp = bus->sysdata;
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	int ret;
>  
>  	ret = pci_generic_config_write(bus, devfn, where, size, val);
> @@ -608,9 +618,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
>  		return ret;
>  
>  	if (pp->cfg0_io_shared) {
> -		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
> -						pp->io_base, pp->io_bus_addr,
> -						pp->io_size);
> +		atu.type = PCIE_ATU_TYPE_IO;
> +		atu.cpu_addr = pp->io_base;
> +		atu.pci_addr = pp->io_bus_addr;
> +		atu.size = pp->io_size;
> +
> +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret)
>  			return PCIBIOS_SET_FAILED;
>  	}
> @@ -645,6 +658,7 @@ static struct pci_ops dw_pcie_ops = {
>  static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
>  	struct resource_entry *entry;
>  	int i, ret;
>  
> @@ -672,10 +686,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		if (pci->num_ob_windows <= ++i)
>  			break;
>  
> -		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
> -						entry->res->start,
> -						entry->res->start - entry->offset,
> -						resource_size(entry->res));
> +		atu.index = i;
> +		atu.type = PCIE_ATU_TYPE_MEM;
> +		atu.cpu_addr = entry->res->start;
> +		atu.pci_addr = entry->res->start - entry->offset;
> +		atu.size = resource_size(entry->res);
> +
> +		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret) {
>  			dev_err(pci->dev, "Failed to set MEM range %pr\n",
>  				entry->res);
> @@ -685,10 +702,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  	if (pp->io_size) {
>  		if (pci->num_ob_windows > ++i) {
> -			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
> -							pp->io_base,
> -							pp->io_bus_addr,
> -							pp->io_size);
> +			atu.index = i;
> +			atu.type = PCIE_ATU_TYPE_IO;
> +			atu.cpu_addr = pp->io_base;
> +			atu.pci_addr = pp->io_bus_addr;
> +			atu.size = pp->io_size;
> +
> +			ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  			if (ret) {
>  				dev_err(pci->dev, "Failed to set IO range %pr\n",
>  					entry->res);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index ede166645289..bd85a73d354b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -464,56 +464,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
>  	return val | PCIE_ATU_TD;
>  }
>  
> -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> -				       int index, int type, u64 cpu_addr,
> -				       u64 pci_addr, u64 size)
> +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> +			      const struct dw_pcie_ob_atu_cfg *atu)
>  {
> +	u64 cpu_addr = atu->cpu_addr;
>  	u32 retries, val;
>  	u64 limit_addr;
>  
>  	if (pci->ops && pci->ops->cpu_addr_fixup)
>  		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
>  
> -	limit_addr = cpu_addr + size - 1;
> +	limit_addr = cpu_addr + atu->size - 1;
>  
>  	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
>  	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
>  		return -EINVAL;
>  	}
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
>  			      lower_32_bits(cpu_addr));
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
>  			      upper_32_bits(cpu_addr));
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
> +	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
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
> @@ -525,21 +525,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  	return -ETIMEDOUT;
>  }
>  
> -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			      u64 cpu_addr, u64 pci_addr, u64 size)
> -{
> -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> -					   cpu_addr, pci_addr, size);
> -}
> -
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr,
> -				 u64 size)
> -{
> -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> -					   cpu_addr, pci_addr, size);
> -}
> -
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
>  {
>  	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9acf6c40d252..b8fa099bbed3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
>  	DW_PCIE_NUM_CORE_RSTS
>  };
>  
> +struct dw_pcie_ob_atu_cfg {
> +	int index;
> +	int type;
> +	u8 func_no;
> +	u64 cpu_addr;
> +	u64 pci_addr;
> +	u64 size;
> +};
> +
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
>  	void (*host_deinit)(struct dw_pcie_rp *pp);
> @@ -419,10 +428,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
> -int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			      u64 cpu_addr, u64 pci_addr, u64 size);
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> +int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> +			      const struct dw_pcie_ob_atu_cfg *atu);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -- 
> 2.25.1
> 
