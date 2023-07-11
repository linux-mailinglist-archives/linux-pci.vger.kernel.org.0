Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1E74F2E9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 17:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjGKPBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGKPBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 11:01:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D010CF;
        Tue, 11 Jul 2023 08:01:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f954d7309fso7232529e87.1;
        Tue, 11 Jul 2023 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689087688; x=1691679688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU4XR1QanIyk4Xzx6nQ+M2edqTQrT9XWFJQn7RHLzs4=;
        b=gIKvGcWiiPfFeHCRGVXMbl80umHW43eLlrhIsWN9WUETqAJKb4dL4Hld0fYSRID48o
         YDELsiG5iXc0NqDwdeWINSVdjMZU1I6h9lrvlhiYgZCi3XCbwvzoFb5Md6QmvdEPfem6
         gza6y0LpnfoHZOh2S3EGmHmM9oAYYkWgbbfXV2pzX+y5L7gyjJO8shBpbZE69ygwwkXU
         ZQSyvJ0FacnJsTyRVGdbbV9FOJIT87colaI8SAd1wfOX1RJSk5TqiM/DBYssoQm9dgCv
         09TKiTl1rIhMwYKrI4MjVfvREtKFZPlp310+kAS3YU871et58ZTXoFSpVCxtyJztbebW
         OtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087688; x=1691679688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU4XR1QanIyk4Xzx6nQ+M2edqTQrT9XWFJQn7RHLzs4=;
        b=hS2EJLYvMTgGDSTF7Ej8hQrmFBJRdG+FjrIbMRgwt0bnSoIkJER6aecp5hnPmr2qP3
         ZHkRKmjefNLXFp5mdsIqR/BOcO2ISO2mTBXnkcLtZRF/Is4vGntYpRRtwnk5X39gn1O4
         4w//YNx9BcYPeMi4J8NRITw6tCW5KVQCObUowXTfOBzJnXEmMmKz+Jju9gGMJSyVhZ0B
         pjWgBquMxaEbavEHY/a3qH3VkrsNCL83skId9wVG79ig5S1lK2HelHSeppad5plHBGlC
         2TmlZwnSh/8yoZAC/qLwNK9egwdMcxD9MWSgJ7d0NOKxUUDAvH2P2nJEXSQyxRBtFYro
         VbZw==
X-Gm-Message-State: ABy/qLZlrqzpyap9ooKCWp6UzIIPIoZkRiWGc8pIVuyZjgPNdPUTOsu3
        nImUAcW1hqIAQosyqW2AiYw=
X-Google-Smtp-Source: APBJJlFIviX7ZB0xBPU8WRhrIbT4iqIJzglUbNZuRqvYBYOwaoZtyzVhGcSuX2qEcihti1RY8BxDbg==
X-Received: by 2002:a19:910e:0:b0:4f8:1e2a:1de1 with SMTP id t14-20020a19910e000000b004f81e2a1de1mr5408361lfd.29.1689087687836;
        Tue, 11 Jul 2023 08:01:27 -0700 (PDT)
Received: from mobilestation ([85.249.18.12])
        by smtp.gmail.com with ESMTPSA id f15-20020ac2532f000000b004fb745fd232sm353868lfh.30.2023.07.11.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:01:27 -0700 (PDT)
Date:   Tue, 11 Jul 2023 18:01:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 06/20] PCI: designware-ep: Add INTx IRQs support
Message-ID: <leliqp56nmecbzowzxyx7hurdat2styt4itl2yh63vgmc4rvf2@ro3o6w2ox47u>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705114206.3585188-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 05, 2023 at 08:41:52PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering INTx IRQs by using outbound iATU.
> Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> The message is generated based on the payloadless Msg TLP with type
> 0x14, where 0x4 is the routing code implying the Terminate at
> Receiver message. The message code is specified as b1000xx for
> the INTx assertion and b1001xx for the INTx de-assertion.

Looking good. Feel free to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 69 +++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  2 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index fe2e0d765be9..1d24ebf9686f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -6,9 +6,11 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
> @@ -484,14 +486,60 @@ static const struct pci_epc_ops epc_ops = {
>  	.get_features		= dw_pcie_ep_get_features,
>  };
>  
> +static int dw_pcie_ep_send_msg(struct dw_pcie_ep *ep, u8 func_no, u8 code,
> +			       u8 routing)
> +{
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
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
>  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
> +	int ret;
>  
> -	dev_err(dev, "EP cannot trigger INTx IRQs\n");
> +	if (!ep->intx_mem) {
> +		dev_err(dev, "INTx not supported\n");
> +		return -EOPNOTSUPP;
> +	}
>  
> -	return -EINVAL;
> +	/*
> +	 * Even though the PCI bus specification implies the level-triggered
> +	 * INTx interrupts the kernel PCIe endpoint framework has a single
> +	 * PCI_EPC_IRQ_INTx flag defined for the legacy IRQs simulation. Thus
> +	 * this function sends the Deassert_INTx PCIe TLP after the Assert_INTx
> +	 * message with the 50 usec duration basically implementing the
> +	 * rising-edge triggering IRQ. Hopefully the interrupt controller will
> +	 * still be able to register the incoming IRQ event...
> +	 */
> +	ret = dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_ASSERT_INTA,
> +				  PCI_MSG_TYPE_R_ROUTING_LOCAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(50, 100);
> +
> +	return dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_DEASSERT_INTA,
> +				   PCI_MSG_TYPE_R_ROUTING_LOCAL);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
>  
> @@ -622,6 +670,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
> @@ -793,9 +845,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> @@ -812,7 +869,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> index c626d21243b0..812c221b3f7c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -365,6 +365,8 @@ struct dw_pcie_ep {
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
