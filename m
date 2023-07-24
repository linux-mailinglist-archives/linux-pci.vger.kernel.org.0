Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C10875EDB1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGXIek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 04:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGXIei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 04:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E728294;
        Mon, 24 Jul 2023 01:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 840CC60FC9;
        Mon, 24 Jul 2023 08:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB07C433C8;
        Mon, 24 Jul 2023 08:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690187675;
        bh=VeUBdTWkHlXJ19U7A+lvF9LuS0S/+KjCVOk7zIu9BCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rISmVT4MMXxDRs5qyJJ3z1u8UxS8ogKzkjKKhTCxkZj9Ioj4sHFNBBqUxEjh84K86
         AWcBGcui3puedAJbtdyupdjBNUDSQ1oIJc5Mgiz42V/k19sDO1MHHTDxOEuV0c557Y
         sfLnzi+M6w/9AzcrPar22Ch2535AKLCglaLVR3ObV6yg/lym3YxwfVGeKcCITAFQiJ
         /lm7QK376YlRs4Ry50wVcVN4FKyL4WxorvPfiBPFt25J+J7Q7Q+Je+5FR2oTA6xLN1
         G7IpVloSVdursocNgmspuYyOQMVr2O5diYkj5UJGUXbxI14VBOv456vlZSJ1bp+EIY
         muDGA2SfT+1KQ==
Date:   Mon, 24 Jul 2023 14:04:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 06/20] PCI: designware-ep: Add INTx IRQs support
Message-ID: <20230724083421.GE6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:38PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering INTx IRQs by using outbound iATU.
> Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> The message is generated based on the payloadless Msg TLP with type
> 0x14, where 0x4 is the routing code implying the Terminate at
> Receiver message. The message code is specified as b1000xx for
> the INTx assertion and b1001xx for the INTx de-assertion.
> 

Commit message is missing a few important points:

1. EDGE IRQ is simulated for INTx
2. Only INTA is asserted
3. INTx support is optional (if there is no memory for INTx, probe will not
fail)

Above points should be included in the commit message to properly describe the
change.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
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

This write is not described anywhere.

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்
