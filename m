Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7346C5053
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 17:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCVQRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCVQRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 12:17:47 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D355AB66;
        Wed, 22 Mar 2023 09:17:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h25so12452202lfv.6;
        Wed, 22 Mar 2023 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679501864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YAaJqJLoY2bwmxM5uCAHDI5M/NLn51JTM0BScqL85SM=;
        b=kDeDlGYfPqnH+MggYoZXJVZV45kpXAseu1aKW0fb5bTUf5SJMILjz3X3O8SOw3skrM
         RCaWEaWpBCGFvFbB36YPWjWSBk1HIc11+RjRXCZouZs7jh3spIR+v6u+hW8uzDJ3xZbD
         5Z2yTxICzfODJg1lYRxL/6tUTeeABxMIrpCPSK1uPfBn5WJBhFXOy+wxcEJxfit92OI5
         NlObLvedg2HtDXdcSAN3y50MW5TZJXFuRTACeB73J33GcGpgLJ5ftiN9BryHkXpWNI9y
         JhSksgjE3SCuDNszL926s88w7Ig90usJrIZueFrh7bc1c7fmGndrDqvrGYqneFkqKGtL
         GHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAaJqJLoY2bwmxM5uCAHDI5M/NLn51JTM0BScqL85SM=;
        b=mB3GK6PO0h5x/XV1ENW4rgHXNt1PBWZ4d4Is2Dm5PiaL3KWme4nHedMrUUGcRLSJjw
         Q6cHAhEUvInlWT2plT/T8I1Ie0hjdaK/X5GepKnAAF7AvbdrXAAQtpacwFnqaqDE/Wjk
         Wf79/kcq6Hec/73r1Lb+RQodfxqOngbsjYuLjrGzJOCCoxmYymAVlQm3hYnl6oLkoBAZ
         aS9Q1wohioSQ539F24oMU1OcnGnQ/j0OdvqlH2nozIZAR/q9r6o1Mb1B6P/Hdlb9OFeN
         G3Ji5KgIP086KWUwmVLTqSfBQBr7CwcC4Nt42XR8tMeINJ0kWn4V4cmAgtpOL2VI7jpa
         msLA==
X-Gm-Message-State: AO0yUKVjeSBB1AKLITBr6pQIChOrtgNZp3YuCPQPCq7/oKOCQkQZhJbO
        yvQoOD8umpvWwskdjgSYn1I=
X-Google-Smtp-Source: AK7set+QaPrcFxmBO4Z7DcvNpOyYJx7tEYQxoW4OX/eioOGkrcTJ11/PRhC2ybDLG17yA8p3oAXyyw==
X-Received: by 2002:ac2:5457:0:b0:4b5:9e70:ca6e with SMTP id d23-20020ac25457000000b004b59e70ca6emr934847lfn.17.1679501863943;
        Wed, 22 Mar 2023 09:17:43 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id d18-20020ac24c92000000b004e8497a5604sm2617246lfl.108.2023.03.22.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:17:43 -0700 (PDT)
Date:   Wed, 22 Mar 2023 19:17:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v11 09/13] PCI: dwc: Add support for triggering legacy
 IRQs
Message-ID: <20230322161741.4m5dgnjtcicfawqd@mobilestation>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-10-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310123510.675685-10-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 09:35:06PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering legacy IRQs by using outbound iATU.
> Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> The message is generated based on the payloadless Msg TLP with type
> 0x14, where 0x4 is the routing code implying the terminated at
> Receiver message. The message code is specified as b1000xx for
> the INTx assertion and b1001xx for the INTx de-assertion.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 66 ++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.c  | 88 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  | 11 ++-
>  3 files changed, 126 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 95efe14f1036..73b3844e8a09 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  
> @@ -182,8 +183,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>  	return 0;
>  }
>  
> -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> -				   phys_addr_t phys_addr,
> +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> +				   u8 code, u8 routing, phys_addr_t phys_addr,
>  				   u64 pci_addr, size_t size)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -196,8 +197,9 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EINVAL;
>  	}
>  
> -	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
> -					   phys_addr, pci_addr, size);
> +	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, type,
> +					   code, routing, phys_addr, pci_addr,
> +					   size);
>  	if (ret)
>  		return ret;
>  
> @@ -306,7 +308,8 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  
> -	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> +	ret = dw_pcie_ep_outbound_atu(ep, func_no, PCIE_ATU_TYPE_MEM, 0, 0,
> +				      addr, pci_addr, size);
>  	if (ret) {
>  		dev_err(pci->dev, "Failed to enable address\n");
>  		return ret;
> @@ -479,14 +482,46 @@ static const struct pci_epc_ops epc_ops = {
>  	.get_features		= dw_pcie_ep_get_features,
>  };
>  
> +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8 code,
> +			       u8 routing)
> +{
> +	struct pci_epc *epc = ep->epc;
> +	int ret;
> +
> +	ret = dw_pcie_ep_outbound_atu(ep, func_no, PCIE_ATU_TYPE_MSG, code,
> +				      routing, ep->intx_mem_phys, 0,
> +				      epc->mem->window.page_size);
> +	if (ret)
> +		return ret;

< newline pls

> +	writel(0, ep->intx_mem);

< nelinew pls

> +	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> +
> +	return 0;
> +}
> +
> +static int __dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no,
> +					 int intx)
> +{
> +	int ret;
> +

> +	ret = dw_pcie_ep_send_msg(ep, func_no, PCIE_MSG_ASSERT_INTA + intx, 0x04);

0x04 - magic number. Please create a macro for it.
* PCIe specification clearly states what 0x04 means.

> +	if (ret)
> +		return ret;

< newline pls

> +	usleep_range(1000, 2000);

< newline pls

> +	return dw_pcie_ep_send_msg(ep, func_no, PCIE_MSG_DEASSERT_INTA + intx, 0x04);
> +}
> +
>  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  
> -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> +	if (!ep->intx_mem) {
> +		dev_err(dev, "EP cannot trigger legacy IRQs\n");
> +		return -EINVAL;
> +	}
>  
> -	return -EINVAL;
> +	return __dw_pcie_ep_raise_legacy_irq(ep, func_no, 0);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
>  
> @@ -617,6 +652,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  
>  	dw_pcie_edma_remove(pci);
>  
> +	if (ep->intx_mem)
> +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> +				      epc->mem->window.page_size);
> +
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>  			      epc->mem->window.page_size);
>  
> @@ -789,9 +828,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		goto err_exit_epc_mem;
>  	}
>  
> +	ep->intx_mem = pci_epc_mem_alloc_addr(epc, &ep->intx_mem_phys,
> +					      epc->mem->window.page_size);
> +	if (!ep->intx_mem)
> +		dev_warn(dev, "Failed to reserve memory for INTx\n");
> +
>  	ret = dw_pcie_edma_detect(pci);
>  	if (ret)
> -		goto err_free_epc_mem;
> +		goto err_free_epc_mem_intx;
>  
>  	if (ep->ops->get_features) {
>  		epc_features = ep->ops->get_features(ep);
> @@ -808,7 +852,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  err_remove_edma:
>  	dw_pcie_edma_remove(pci);
>  
> -err_free_epc_mem:
> +err_free_epc_mem_intx:
> +	if (ep->intx_mem)
> +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> +				      epc->mem->window.page_size);
> +
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>  			      epc->mem->window.page_size);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 47860da5738e..364926832126 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -23,6 +23,17 @@
>  #include "../../pci.h"
>  #include "pcie-designware.h"
>  
> +struct dw_pcie_outbound_atu {
> +	u64 cpu_addr;
> +	u64 pci_addr;
> +	u64 size;
> +	int index;
> +	int type;
> +	u8 func_no;
> +	u8 code;
> +	u8 routing;
> +};

Please detach the __dw_pcie_prog_outbound_atu() method conversion to a
pre-requisite patch to make this change smaller and easier to review.

> +
>  static const char * const dw_pcie_app_clks[DW_PCIE_NUM_APP_CLKS] = {
>  	[DW_PCIE_DBI_CLK] = "dbi",
>  	[DW_PCIE_MSTR_CLK] = "mstr",
> @@ -464,56 +475,58 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
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
> +	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
> +	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
>  	if (dw_pcie_ver_is(pci, 490A))
>  		val = dw_pcie_enable_ecrc(val);
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> +	val = PCIE_ATU_ENABLE;
> +	if (atu->type == PCIE_ATU_TYPE_MSG)
> +		val |= PCIE_ATU_INHIBIT_PAYLOAD | PCIE_ATU_HEADER_SUB_ENABLE | atu->code;
> +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
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
> @@ -528,16 +541,33 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size)
>  {
> -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> -					   cpu_addr, pci_addr, size);
> +	struct dw_pcie_outbound_atu atu;
> +

> +	memset(&atu, 0, sizeof(atu));

can be replaced with struct dw_pcie_outbound_atu atu = {0};

> +	atu.index = index;
> +	atu.type = type;
> +	atu.cpu_addr = cpu_addr;
> +	atu.pci_addr = pci_addr;
> +	atu.size = size;
> +	return __dw_pcie_prog_outbound_atu(pci, &atu);
>  }
>  
>  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr,
> -				 u64 size)
> +				 int type, u8 code, u8 routing, u64 cpu_addr,
> +				 u64 pci_addr, u64 size)

The __dw_pcie_prog_outbound_atu() conversion has a near zero value
if dw_pcie_prog_ep_outbound_atu() will be left with the bunch of arguments.
The same concerns the dw_pcie_ep_outbound_atu() method which now accepts
eight arguments.

>  {
> -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> -					   cpu_addr, pci_addr, size);
> +	struct dw_pcie_outbound_atu atu;
> +

> +	memset(&atu, 0, sizeof(atu));

can be replaced with struct dw_pcie_outbound_atu atu = {0};

-Serge(y)

> +	atu.func_no = func_no;
> +	atu.index = index;
> +	atu.type = type;
> +	atu.code = code;
> +	atu.routing = routing;
> +	atu.cpu_addr = cpu_addr;
> +	atu.pci_addr = pci_addr;
> +	atu.size = size;
> +	return __dw_pcie_prog_outbound_atu(pci, &atu);
>  }
>  
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 36f3e2c818fe..3dbadb8043ab 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -147,11 +147,14 @@
>  #define PCIE_ATU_TYPE_IO		0x2
>  #define PCIE_ATU_TYPE_CFG0		0x4
>  #define PCIE_ATU_TYPE_CFG1		0x5
> +#define PCIE_ATU_TYPE_MSG		0x10
>  #define PCIE_ATU_TD			BIT(8)
>  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>  #define PCIE_ATU_REGION_CTRL2		0x004
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> +#define PCIE_ATU_HEADER_SUB_ENABLE	BIT(21)
>  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>  #define PCIE_ATU_LOWER_BASE		0x008
>  #define PCIE_ATU_UPPER_BASE		0x00C
> @@ -244,6 +247,9 @@
>  /* Default eDMA LLP memory size */
>  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
>  
> +#define PCIE_MSG_ASSERT_INTA		0x20
> +#define PCIE_MSG_DEASSERT_INTA		0x24
> +
>  struct dw_pcie;
>  struct dw_pcie_rp;
>  struct dw_pcie_ep;
> @@ -352,6 +358,8 @@ struct dw_pcie_ep {
>  	unsigned long		*ob_window_map;
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
> +	void __iomem		*intx_mem;
> +	phys_addr_t		intx_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
>  };
>  
> @@ -420,7 +428,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> +				 int type, u8 code, u8 routing, u64 cpu_addr,
> +				 u64 pci_addr, u64 size);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
>  			     u64 cpu_addr, u64 pci_addr, u64 size);
>  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -- 
> 2.25.1
> 
> 
