Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CD56F36A4
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjEATYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjEATYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 15:24:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203042129;
        Mon,  1 May 2023 12:24:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4efeea05936so3442205e87.2;
        Mon, 01 May 2023 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969078; x=1685561078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwKYFOfxrqJkU6TZHpFIChi7F4s2o0J3FLm10CuV1Is=;
        b=GQahmOYtpdDY2qonnqVzQnvS6tCI/DuKSU/+tI4fGQ/u2Tps5cioKRD9e6G00pHwxQ
         TmwtxMYJZsvlBNXtxW0pl0FQ/FWHCUdH2IKNFxKVBzA79iNkRJMamOtmgT7wZ0Nkvq3i
         N2nVwCJ43Vo3Pfmk1ciqS5C8EU6UAuY4/2oG/iC5OwmKWdBX796Zzn8r4AI2mGHj612w
         b4sJLRpeQ/+MAF1VXxNyg0yBx19EGlZX4CS3VP+CZHMFoG8Nd+eiS4Qk1P8qn+NL7YkF
         Du5BnE2dI5YGwz0jhvVMFZCr3FRPJO5Y/T8f8rECrOpErG1dg4FRQd5mxDjAJqyMGvMI
         nDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969078; x=1685561078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwKYFOfxrqJkU6TZHpFIChi7F4s2o0J3FLm10CuV1Is=;
        b=g/n+udQcCBDR64G2JNv5/m+aYzus3gzg44Nign8F2W/PDEqeJxGTw2tk7fu0JuSuXS
         Gmu0QxgnBbQtlkzW4l9J2lov4fJOhr9Au7QtbSmU9hhoW8em8vEt8HEkLvW6r0ewwcOY
         PJ++gWTcAnQVfptCwJvukYSjczuOn9K4p0Ysn2imtIhQafqNjvYLCGHDIfB/JsNaH+wv
         6Eg0qP3X8Cb1wJZUvDUpyZ+z3SeCPmO0rI5czhmvXBG0VL9RaSZTRdybY04df8MCajFM
         2Jtt2x0xsEnMMeHcWQf07Nvba06TCOIZ89j4ykIXaA8GTMLrlUrg2HhwAvhm/nDxrwkG
         LeSA==
X-Gm-Message-State: AC+VfDztiSVH5Wq7SdtP0q3EndqEJ62g2hvm5Vmi/G2mh58nppOvQtgZ
        MUxnZ2XSfzEXf1rZGvRuqFY=
X-Google-Smtp-Source: ACHHUZ7AWmffs/NlKprNHDVov+6fTyDALglSaexdmUpiF7VF+mjGIaLWgdvWYorTXYL1EsKHAPXYdw==
X-Received: by 2002:ac2:5de3:0:b0:4dd:af29:92c1 with SMTP id z3-20020ac25de3000000b004ddaf2992c1mr3178093lfq.44.1682969078156;
        Mon, 01 May 2023 12:24:38 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004f0c9120a41sm948249lfk.214.2023.05.01.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:24:37 -0700 (PDT)
Date:   Mon, 1 May 2023 22:24:35 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v14 08/21] PCI: dwc: Add support for triggering INTx IRQs
 from endpoint drivers
Message-ID: <20230501192435.hn6j4ihiejcm5lzp@mobilestation>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426045557.3613826-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 26, 2023 at 01:55:44PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering INTx IRQs by using outbound iATU.
> Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> The message is generated based on the payloadless Msg TLP with type
> 0x14, where 0x4 is the routing code implying the Terminate at
> Receiver message. The message code is specified as b1000xx for
> the INTx assertion and b1001xx for the INTx de-assertion.

[PATCH v14 08/21] PCI: dwc: Add support for triggering INTx IRQs from endpoint drivers

What about shortening the subject out a bit:
"PCI: designware-ep: Add INTx IRQs support"
?

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 71 +++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  2 files changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 96375b0aba82..b35ed2b06193 100644
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
> @@ -485,14 +486,63 @@ static const struct pci_epc_ops epc_ops = {
>  	.get_features		= dw_pcie_ep_get_features,
>  };
>  
> +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8 code,
> +			       u8 routing)
> +{
> +	struct dw_pcie_outbound_atu atu = { 0 };
> +	struct pci_epc *epc = ep->epc;
> +	int ret;
> +
> +	atu.func_no = func_no;
> +	atu.code = code;
> +	atu.routing = routing;
> +	atu.type = PCIE_ATU_TYPE_MSG;
> +	atu.cpu_addr = ep->intx_mem_phys;
> +	atu.size = epc->mem->window.page_size;
> +
> +	ret = dw_pcie_ep_outbound_atu(ep, &atu);
> +	if (ret)
> +		return ret;
> +
> +	writel(0, ep->intx_mem);
> +
> +	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> +
> +	return 0;
> +}
> +

> +static int __dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no,
> +					 int intx)
> +{
> +	int ret;
> +
> +	ret = dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA + intx,
> +				  PCI_MSG_ROUTING_LOCAL);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The documents of PCIe and the controller don't mention how long
> +	 * the INTx should be asserted. If 10 usec, sometimes it failed.
> +	 * So, asserted for 50 usec.
> +	 */
> +	usleep_range(50, 100);
> +
> +	return dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_DEASSERT_INTA + intx,
> +				   PCI_MSG_ROUTING_LOCAL);
> +}

Why do you need the underscored version of the method? I don't see it
being utilized anywhere but in the dw_pcie_ep_raise_intx_irq()
function. Thus its body can be completely moved to
dw_pcie_ep_raise_intx_irq().

-Serge(y)

> +
>  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
>  
> -	dev_err(dev, "EP cannot trigger INTx IRQs\n");
> +	if (!ep->intx_mem) {
> +		dev_err(dev, "INTx not supported\n");
> +		return -EOPNOTSUPP;
> +	}
>  
> -	return -EINVAL;
> +	return __dw_pcie_ep_raise_intx_irq(ep, func_no, 0);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
>  
> @@ -623,6 +673,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
> @@ -794,9 +848,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> @@ -813,7 +872,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 954d504890a1..8c08159ea08e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -369,6 +369,8 @@ struct dw_pcie_ep {
>  	unsigned long		*ob_window_map;
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
> +	void __iomem		*intx_mem;
> +	phys_addr_t		intx_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
>  };
>  
> -- 
> 2.25.1
> 
