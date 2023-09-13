Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F152679F58D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 01:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjIMXbb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 19:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjIMXbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 19:31:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7663D170B;
        Wed, 13 Sep 2023 16:31:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CC0C433C7;
        Wed, 13 Sep 2023 23:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694647878;
        bh=hxr26k1B7gBayRPGem0+EIMrG1KjojApXUJldbdhIms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tuQ0PIVv2S5ZditTMDcbxY/v+34J/uHH2IhIYQtdhBGZsvDeTTQS9L42B2rLFESIz
         iOeUTRS4SdFqrqNMDzSM6xOT1gtU77aAaNfQ9488SHn/mllIfbishfhHNcp8Wfx3UX
         3XqwlbSO2th8jhZQt7cOBe5dia+DtEvPiFBAJ1hL/1Na9Ds3gzgwzEFkAZGpH9DDA/
         yyLtI+OYdaiVDdYE45AqRUOJqCFeGeF4gR8h7sj0OoXO23TTteQSxP3Vkg6WB3HN3r
         XQnkbyEw2ooUw+wXAbrobzSLfuZfclexMEJEfLnyM/VGCS8BkfgM5YiXBakoOZdcqv
         jiVGM7sYmf+fg==
Date:   Wed, 13 Sep 2023 18:31:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 04/19] PCI: designware-ep: Add INTx IRQs support
Message-ID: <20230913233115.GA11062@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-5-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 06:32:04PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering INTx IRQs by using outbound iATU.
> Outbound iATU is utilized to send assert and de-assert INTA TLPs
> as simulated edge IRQ for INTA. (Other INT[BCD] are not asserted.)
> This INTx support is optional (if there is no memory for INTx,
> probe will not fail).
> 
> The message is generated based on the payloadless Msg TLP with type
> 0x14, where 0x4 is the routing code implying the Terminate at
> Receiver message. The message code is specified as b1000xx for
> the INTx assertion and b1001xx for the INTx de-assertion.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 70 +++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  2 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 747d5bc07222..91e3c4335031 100644
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
> @@ -484,14 +486,61 @@ static const struct pci_epc_ops epc_ops = {
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
> +	/* A dummy-write ep->intx_mem is converted to a Msg TLP */
> +	writel(0, ep->intx_mem);
> +
> +	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->intx_mem_phys);
> +
> +	return 0;
> +}
> +
>  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct device *dev = pci->dev;
> +	int ret;
>  
> -	dev_err(dev, "EP cannot trigger legacy IRQs\n");
> +	if (!ep->intx_mem) {
> +		dev_err(dev, "legacy IRQs not supported\n");
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

I'm not really convinced about this "assert INTA, wait 50us, deassert
INTA" thing.  All the INTx language in the spec is like this:

  ... the virtual INTx wire must be asserted whenever and *as long as*
  the following conditions are satisfied:

    - The Interrupt Disable bit in the Command register is set to 0b.

    - The <feature> Interrupt Enable bit in the <feature> Control
      Register is set to 1b.

    - The <feature> Status bit in the <feature> Status register is
      set.

E.g., sec PCIe r6.0, sec 5.5.6 (Link Activation), 6.1.6 (Native PME),
6.2.4.1.2 (AER Interrupt Generation), 6.2.11.1 (DPC Interrupts),
6.7.3.4 (Software Notification of Hot-Plug Events).

So it seems to me like the endpoint needs an "interrupt status" bit,
and the Deassert_INTx message would be sent when the host interrupt
handler clears that bit.

> +	 */
> +	ret = dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_ASSERT_INTA,
> +				  PCI_MSG_TYPE_R_LOCAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(50, 100);
> +
> +	return dw_pcie_ep_send_msg(ep, func_no, PCI_MSG_CODE_DEASSERT_INTA,
> +				   PCI_MSG_TYPE_R_LOCAL);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_legacy_irq);
>  
> @@ -622,6 +671,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
> @@ -793,9 +846,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> @@ -812,7 +870,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> index 8f22a7bc0523..e02d4986bc2b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -376,6 +376,8 @@ struct dw_pcie_ep {
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
