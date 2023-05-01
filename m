Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDE6F3662
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjEAS6m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjEAS6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 14:58:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BEDE65;
        Mon,  1 May 2023 11:58:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so28050501fa.2;
        Mon, 01 May 2023 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682967516; x=1685559516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hxYC1A8BcG0xD7QAbsS4zQxHF3JEXsuO/06+/RMMQso=;
        b=kpiWAA32Ri3zyUuYcaV20mAgLLI0NddFlPjrl1e3tzpTotMqA57UVL7raIML9+JDXy
         FlEOf3EnDrDHqQg3gV03KK5uzVIlNvasQhrGuF3ozH+GbSYzcIeIHnq6atO8LDYpgSL6
         xfTxUQn63O0mhxv/aEsXkP38IeN1z17xJ46hc253AArbyRiIwEVq83/1RyFbccZSz3cD
         OkFOq7LaqZIgUVK6n8gILpLJOKDsCoKPe0VSIXjq3eDc7lhj+HhozFORKk4OJOeGgZLI
         xkm4OTpsMoJTzUr1M4a7K3zBzzYfWV3NFr8kFJiSwKZ0IdtXqIsxN37/+l/Xpw5v4n99
         Tnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967516; x=1685559516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxYC1A8BcG0xD7QAbsS4zQxHF3JEXsuO/06+/RMMQso=;
        b=PqKbnaYiHDnJmVJyDzAXCeyI3ajFgQTf6E5R2MhIf+6/W7ukaDo2AU4o2kf5/2R8Ic
         zpWGOT7+6SmoONTA+pV6wPgEgu870ymLFI4I97IOF4l3bt7Yl/6nmOTov3rxwVk98ocz
         G4oi8SkcabiaTVfa7YXmvQMNS17axKi//t6KuBOAFTgc7IFYsMgXTzu/1bX001Y8FzoD
         aQ9k3xPTC1Czv4NTfdRUHp1RhOvdIELvYgISvJHCcdbKepzFDkCJJBUY1BmAAjqZaMH7
         WutSmn6NqHIMEpBfLxinrGHUsrDBjjJTJ17M2xZccH1aBSLMS1DybUhtzp7pyZNtFFb5
         kgQA==
X-Gm-Message-State: AC+VfDypgnK/K3ks/Emgufs/7T2mu3O3pGNrgxqzwvXlVeYhHlAdQ8g/
        X6LwDAh/SxMiqFo+Yh8FbKA=
X-Google-Smtp-Source: ACHHUZ6DCuS3CLo9IyL5T75/xMoxoUbbS+EZ8qZtzdydeprz4C9SwUASDOwi9znBwrBj2MnnRL4S5Q==
X-Received: by 2002:a2e:8482:0:b0:2a9:e6e7:b027 with SMTP id b2-20020a2e8482000000b002a9e6e7b027mr3563765ljh.41.1682967516354;
        Mon, 01 May 2023 11:58:36 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e8315000000b002a7899eaf9csm4683777ljh.63.2023.05.01.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:58:35 -0700 (PDT)
Date:   Mon, 1 May 2023 21:58:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v14 06/21] PCI: dwc: Change arguments of
 dw_pcie_prog_ep_outbound_atu()
Message-ID: <20230501185833.mcunpdtvc3qjl72w@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:42PM +0900, Yoshihiro Shimoda wrote:
> To add more arguments to the dw_pcie_prog_ep_outbound_atu() in
> the future, introduce struct dw_pcie_outbound_atu and change
> the argument. No behavior changes.

The change now looks much more coherent than before. Though it still looks
as an incomplete measure. The core driver still have two global outbound
ATU windows config methods which basically cause the same update
(performed by the same backend function), but which prototypes are
completely different. What about dropping the separate
dw_pcie_prog_outbound_atu() and dw_pcie_prog_outbound_atu() methods,
convert __dw_pcie_prog_outbound_atu() to dw_pcie_prog_outbound_atu(pci, atu)
and use it in both RP and EP drivers instead?

As a result we would have got a single outbound ATUs config method with
the next prototype:
int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, struct dw_pcie_ob_atu_cfg *atu);
Thus we would have reduced a number of the globally defined methods,
would have got a more unified outbound ATU setup interface which
by its nature would imply that the OB ATU entries setup is almost the
same for both RP and EP platforms.

Please see a few more comments below.

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 21 ++++---
>  drivers/pci/controller/dwc/pcie-designware.c  | 63 ++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h  | 13 +++-
>  3 files changed, 57 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index a80b9fd03638..96375b0aba82 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -183,9 +183,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> -				   phys_addr_t phys_addr,
> -				   u64 pci_addr, size_t size)
> +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> +				   struct dw_pcie_outbound_atu *atu)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	u32 free_win;
> @@ -197,13 +196,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EINVAL;
>  	}
>  
> -	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> -					   phys_addr, pci_addr, size);
> +	atu->index = free_win;
> +	ret = dw_pcie_prog_ep_outbound_atu(pci, atu);
>  	if (ret)
>  		return ret;
>  
>  	set_bit(free_win, ep->ob_window_map);
> -	ep->outbound_addr[free_win] = phys_addr;
> +	ep->outbound_addr[free_win] = atu->cpu_addr;
>  
>  	return 0;
>  }
> @@ -306,8 +305,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	int ret;
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> -
> -	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> +	struct dw_pcie_outbound_atu atu = { 0 };
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
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index ede166645289..782c4b34d0a3 100644
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

This changes the method semantic a bit. The passed structure will be
updated meanwhile the former semantic implies the locally defined
variable modification. Please define a local var "cpu_addr" initialized
with the atu->cpu_addr field by default.

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
> @@ -528,16 +527,20 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,

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
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr,
> -				 u64 size)
> +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
> +				 struct dw_pcie_outbound_atu *atu)
>  {
> -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> -					   cpu_addr, pci_addr, size);
> +	return __dw_pcie_prog_outbound_atu(pci, atu);
>  }

This could have been dropped if you got to implement what I suggested in
the head of the message.

>  
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9acf6c40d252..81c7558a4718 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
>  	DW_PCIE_NUM_CORE_RSTS
>  };
> 
 
> +struct dw_pcie_outbound_atu {

what about using the name "dw_pcie_ob_atu_cfg" instead?

> +	u64 cpu_addr;
> +	u64 pci_addr;
> +	u64 size;
> +	int index;
> +	int type;
> +	u8 func_no;

The structure will be padded by 7 bytes anyway. Let's move the "index",
"type" and "func_no" group to the head of the structure declaration.

> +};
> +
>  struct dw_pcie_host_ops {
>  	int (*host_init)(struct dw_pcie_rp *pp);
>  	void (*host_deinit)(struct dw_pcie_rp *pp);
> @@ -421,8 +430,8 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);

>  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size);
> -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
> +				 struct dw_pcie_outbound_atu *atu);

What about converting it to just a single:
dw_pcie_prog_outbound_atu(struct dw_pcie *pci, const struct dw_pcie_ob_atu_cfg *atu);
?

-Serge(y)

>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -- 
> 2.25.1
> 
