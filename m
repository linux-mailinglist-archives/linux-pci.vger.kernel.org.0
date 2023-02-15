Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC7697F5F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 16:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBOPTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 10:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBOPTU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 10:19:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A7C72A4;
        Wed, 15 Feb 2023 07:19:18 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mc25so11647610ejb.13;
        Wed, 15 Feb 2023 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWjWayzWFiWnvCbvFd6B45HYCVrR5UvgWU/JtS3dv2o=;
        b=pLW35xOf6ygQLVpyP+glvXdNYZ2keZEEIWUU+zfZNqgygC6bzseLlSUt3vzcwam3i7
         4PZAEnH87velYv9sTtWUR3PZgcdgM5gi9XqpxpuoWXKQKRPMy4ptniyKu9y2p3mXxX5O
         yIjIvaWVnjoVZ1tY4Wehj1rrnoUrQvyqiRtJtG/lIVd63fLeMbQJ7hJgTwOXDivs8o27
         SXYOW4UQ0MwBCQMB43nl7ShCYY4OL0769UneP5auV3toYQdH3qn9+aPtj6wLpAAN+DJC
         jvLc0NnG5KVhK0eJNcHW9Zg5iHJrNEtzEtDuScHAE7sAYQjOG3lTdJssU+zT+1oeGE2X
         ITUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWjWayzWFiWnvCbvFd6B45HYCVrR5UvgWU/JtS3dv2o=;
        b=3HKjSdCNwrAsgsJs0K77KbZTtz7vQE3fKRXloTJwe5zDHjIN37azF+kyUu5+6sf5f8
         BDcIS3qhbBb8wjq3w5AAj9SYTsMyOuFJ0BmJa1kdKivtobFy5MZ6P/qHI3AtvQyu7osm
         /qXgJ2eTpyqWOM9HEvUu83FAxH88NHKbQHckyDuVmJW1vwiaEjlrqmAiM7asJinsXEGs
         oNtViQcVWSpFRhww6tukaFs9iHJ805wEMOHSerI2DBm07lG/yYcSuhj6WNstUVIeyVRw
         gH9roINgX2hrXX9O7CrBC6aWhDssEnQFGL1qnwQY8yMi7RZ9T2e9I2b5IuMWI594SiPa
         WgvA==
X-Gm-Message-State: AO0yUKWdGDIpJUH7na4wwQZQ7BN5N/jMAqm60oHxug8sGy33zx2gweC7
        XAZ4eLKUEm8DgaKSPOgFmUE=
X-Google-Smtp-Source: AK7set/Sa1o6jfHHZBzx8++0P7GRlSEJlKikREn2cXH0TNgP2zn36NYKQHIZ8CxPNleS4q8iOlpA+Q==
X-Received: by 2002:a17:907:a50e:b0:88f:8a5:b4cd with SMTP id vr14-20020a170907a50e00b0088f08a5b4cdmr3101307ejc.1.1676474356876;
        Wed, 15 Feb 2023 07:19:16 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709060c4400b008b14399b74fsm980195ejf.201.2023.02.15.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:19:16 -0800 (PST)
Date:   Wed, 15 Feb 2023 18:19:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 5/8] PCI: dwc: Add support for triggering legacy IRQs
Message-ID: <20230215151913.ilqqzbfzfbitpeop@mobilestation>
References: <20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com>
 <20230210134917.2909314-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210134917.2909314-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 10:49:14PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering legacy IRQs by using outbound ATU.

I supposed a little more details would nice, like outbound iATU is
utilized to send assert and de-assert INTx TLPs. The message is
generated based on the payloadless Msg TLP with type 0x14, where 0x4
is the routing code implying the terminated at Receiver message. The
message code is specified as b1000xx for the INTx assertion and
b1001xx for the INTx de-assertion. Etc...

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 66 +++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.c  | 25 ++++---
>  drivers/pci/controller/dwc/pcie-designware.h  | 12 +++-
>  3 files changed, 87 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 95efe14f1036..886483bf378b 100644
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
> @@ -479,11 +482,43 @@ static const struct pci_epc_ops epc_ops = {
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
> +	writel(0, ep->intx_mem);
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
> +	if (ret)
> +		return ret;
> +	usleep_range(1000, 2000);
> +	return dw_pcie_ep_send_msg(ep, func_no, PCIE_MSG_DEASSERT_INTA + intx, 0x04);
> +}
> +
>  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  

> +	if (ep->intx_by_atu)

IMO the flag is redundant. Your implementation is generic enough to be
useful for all the DW PCIe EPs. If you are afraid to break things,
then just make it optional. If no outbound physical memory could be
allocated then initialize intx_mem with NULL and move on with further
initializations. As before the Legacy IRQ raise method shall return
EINVAL in that case.

> +		return __dw_pcie_ep_raise_legacy_irq(ep, func_no, 0);
> +
>  	dev_err(dev, "EP cannot trigger legacy IRQs\n");
>  
>  	return -EINVAL;
> @@ -617,6 +652,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  
>  	dw_pcie_edma_remove(pci);
>  
> +	if (ep->intx_by_atu)
> +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> +				      epc->mem->window.page_size);
> +
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>  			      epc->mem->window.page_size);
>  
> @@ -789,9 +828,19 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		goto err_exit_epc_mem;
>  	}
>  

> +	if (ep->intx_by_atu) {
> +		ep->intx_mem = pci_epc_mem_alloc_addr(epc, &ep->intx_mem_phys,
> +						      epc->mem->window.page_size);
> +		if (!ep->intx_mem) {
> +			ret = -ENOMEM;
> +			dev_err(dev, "Failed to reserve memory for INTx\n");

As I suggested above you can just dev_warn() here and move on with
EP initialization.

> +			goto err_free_epc_mem;
> +		}
> +	}
> +
>  	ret = dw_pcie_edma_detect(pci);
>  	if (ret)
> -		goto err_free_epc_mem;
> +		goto err_free_epc_mem_intx;
>  
>  	if (ep->ops->get_features) {
>  		epc_features = ep->ops->get_features(ep);
> @@ -808,6 +857,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  err_remove_edma:
>  	dw_pcie_edma_remove(pci);
>  
> +err_free_epc_mem_intx:
> +	if (ep->intx_by_atu)
> +		pci_epc_mem_free_addr(epc, ep->intx_mem_phys, ep->intx_mem,
> +				      epc->mem->window.page_size);
> +
>  err_free_epc_mem:
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>  			      epc->mem->window.page_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 53a16b8b6ac2..b4315cf84340 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -465,8 +465,8 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
>  }
>  

>  static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
> -				       int index, int type, u64 cpu_addr,
> -				       u64 pci_addr, u64 size)
> +				       int index, int type, u8 code, u8 routing,
> +				       u64 cpu_addr, u64 pci_addr, u64 size)

The implementation gets to be too complicated especially with having
nine arguments now. Seven args have been not that good either, but at
the very least it was more-or-less coherent with respect to the Mem/IO
outbound TLPs generations. Now in addition to that it will be also
responsible for the MSG TLPs mapping. What we could simplify here is:

< either 1. Drop separate routing arg. It can be merged into the type
argument seeing it's a part of one by specification. Thus we'll have
only eight arguments left. That will simplify the prototype, but not
the implementation.

< or 2. Split up the outbound mem/IO and MSG windows setups.
In the later case you'll need only the next data for the MSG TLPs
mapping: function #, MW index, message code, CPU base address, MW size.

< or 3. Convert __dw_pcie_prog_outbound_atu() to accepting a
dw_pcie_outbound_atu(-ish) structure with all the arguments listed as
fields: MW index, function #, message type, routing type, message
code (valid if MSG type specified), CPU base address, PCIe base
address, MW size.

What do you think? @Rob, @Bjorn?

(Please don't forget to define the macros for the routing and message
code values.)

>  {
>  	u32 retries, val;
>  	u64 limit_addr;
> @@ -498,7 +498,7 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
>  			      upper_32_bits(pci_addr));
>  
> -	val = type | PCIE_ATU_FUNC_NUM(func_no);
> +	val = type | routing | PCIE_ATU_FUNC_NUM(func_no);
>  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
>  	    dw_pcie_ver_is_ge(pci, 460A))
>  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> @@ -506,7 +506,14 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  		val = dw_pcie_enable_ecrc(val);
>  	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
>  
> -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);

> +	if (code)
> +		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2,
> +				      PCIE_ATU_ENABLE |
> +				      PCIE_ATU_INHIBIT_PAYLOAD |
> +				      PCIE_ATU_HEADER_SUB_ENABLE | code);

AFAICS the setup above is only specific to the Msg TLPs. If so then it
would have been more generic to use if(type == ?) conditional
statement here. What do you think?

> +	else
> +		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2,
> +				      PCIE_ATU_ENABLE);

The next modification seems to be looking better in this case:
+ val = PCIE_ATU_ENABLE;
+ if (type == PCIE_ATU_TYPE_MSG)
+ 	val |= PCIE_ATU_INHIBIT_PAYLOAD | PCIE_ATU_HEADER_SUB_ENABLE | code;
+ 
+ dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, val);

-Serge(y)

>  
>  	/*
>  	 * Make sure ATU enable takes effect before any subsequent config
> @@ -528,16 +535,16 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>  			      u64 cpu_addr, u64 pci_addr, u64 size)
>  {
> -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> +	return __dw_pcie_prog_outbound_atu(pci, 0, index, type, 0, 0,
>  					   cpu_addr, pci_addr, size);
>  }
>  
>  int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
> -				 int type, u64 cpu_addr, u64 pci_addr,
> -				 u64 size)
> +				 int type, u8 code, u8 routing, u64 cpu_addr,
> +				 u64 pci_addr, u64 size)
>  {
> -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> -					   cpu_addr, pci_addr, size);
> +	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type, code,
> +					   routing, cpu_addr, pci_addr, size);
>  }
>  
>  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 79713ce075cc..1a6e7e9489ee 100644
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
> @@ -352,7 +358,10 @@ struct dw_pcie_ep {
>  	unsigned long		*ob_window_map;
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
> +	void __iomem		*intx_mem;
> +	phys_addr_t		intx_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> +	bool			intx_by_atu;
>  };
>  
>  struct dw_pcie_ops {
> @@ -419,7 +428,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci);
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
