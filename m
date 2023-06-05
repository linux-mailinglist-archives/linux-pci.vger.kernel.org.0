Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A4C722077
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 10:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFEIFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFEIFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 04:05:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C776A1;
        Mon,  5 Jun 2023 01:05:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso5545213e87.0;
        Mon, 05 Jun 2023 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685952343; x=1688544343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+P17w6os3VlVktb8tzavWx48OAiemwkjf6b5gb7S80=;
        b=ATLKkK7Byb9mQFYPEefddnjKblvkT3hYp3IR/K9EXn12TfUhuOyXeVfuBrL7wi8jaV
         jaYhIHq6gAssvsl6Mo0jRjiNYTPYJEmwqBhnpok5BejMMwhg6weMWjJWwvhohyAmXQ01
         LnfOeM+mK5D19qO+bUnqMGqs7Ii7c0llDyH+mGwDOihyGiKTG2TFHY3IAoSC4sKIVTIu
         xeYbhJKi/cS1UovqD9xLG2zeR9i+LhcndcvQxgUgbHv2u4WZRPazHswXjnP9hLjfNiP7
         mxrijGCLHh09wQTI+ad+Noox5ctWEyPiJ1Ic2AAt0NG7d/0dXKiOfL0I+YbLRPbZsNu2
         kv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685952343; x=1688544343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+P17w6os3VlVktb8tzavWx48OAiemwkjf6b5gb7S80=;
        b=a4C2y5O2/iL3TxRvk7mghthyOqrLpDe10cvFa7W5KBeIscse2Wr2P8wpWdR9qrt2y8
         lL6eWH8to9G/lq6BJiAH8c/a902S+WWUQksROK82HIHnnG1HDUl0uFCFITP2iX6R4xe/
         zYUn3iEd20yEqJdSW86asFPme5Xc8/KTbyNB9uVF3iY98TfYPDHZsLTNcTin1k2LbwL4
         +OdRXBOd9sQuzCsE1OUC80A9oCPo7uI0reQp6hf9MNNXolAdZKA8VccciM5NlkjG2Tm0
         CbFZMuEBBn0nJj0DBdWi8IAIQOeK682aqzUDwGmf4vBT7sz0CDqCOspk7mDu/dW6w5/o
         qOxw==
X-Gm-Message-State: AC+VfDxTL6hObLqra8el6dfpRrtfLXOJNGTqkzun8J+j+DJX/fuHYctE
        WGGNyMvOSepBQ6nMKAbmgR4=
X-Google-Smtp-Source: ACHHUZ7TG7uY2wGNnpHdmzkXGDqwicdkIgnj02shvhhVGbq2eWqmEy0ftrf8sGjc3fVWZfZ89K/FBQ==
X-Received: by 2002:ac2:4c31:0:b0:4f6:10e9:c507 with SMTP id u17-20020ac24c31000000b004f610e9c507mr3921078lfq.23.1685952342983;
        Mon, 05 Jun 2023 01:05:42 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id i21-20020ac25235000000b004f0199e8770sm1040382lfl.65.2023.06.05.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:05:42 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:05:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        kishon@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v16 08/22] PCI: designware-ep: Add INTx IRQs support
Message-ID: <20230605080540.hz6hn45zciqsun7o@mobilestation>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-9-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510062234.201499-9-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 03:22:20PM +0900, Yoshihiro Shimoda wrote:
> Add support for triggering INTx IRQs by using outbound iATU.
> Outbound iATU is utilized to send assert and de-assert INTx TLPs.
> The message is generated based on the payloadless Msg TLP with type
> 0x14, where 0x4 is the routing code implying the Terminate at
> Receiver message. The message code is specified as b1000xx for
> the INTx assertion and b1001xx for the INTx de-assertion.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 66 +++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  2 files changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index fe2e0d765be9..0abc0073b1cf 100644
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
> @@ -484,14 +486,57 @@ static const struct pci_epc_ops epc_ops = {
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

> +	 * According to the document of PCIe, the INTx emulation should be
> +	 * level-triggered. However, the Linux PCIe Endpoint framework only
> +	 * supports edge-triggered for now. So, this function asserts INTx for
> +	 * 50 usec, and then deasserts it.

"Document of PCIe"?)
What about the next message:
Even though the PCI bus specification implies the level-triggered INTx
interrupts the kernel PCIe endpoint framework has a single
PCI_EPC_IRQ_INTx flag defined for the legacy IRQs simulation. Thus
this function sends the Deassert_INTx PCIe TLP after the Assert_INTx
message with the 50 usec duration basically implementing the
rising-edge triggering IRQ. Hopefully the interrupt controller will
still be able to register the incoming IRQ event...

Other than that the change looks good.

-Serge(y)

> +	 */
> +	ret = dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_ASSERT_INTA,
> +				  PCI_MSG_ROUTING_LOCAL);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(50, 100);
> +
> +	return dw_pcie_ep_send_msg(ep, func_no, PCI_CODE_DEASSERT_INTA,
> +				   PCI_MSG_ROUTING_LOCAL);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
>  
> @@ -622,6 +667,10 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
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
> @@ -793,9 +842,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> @@ -812,7 +866,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> index c83d1d176e62..06e044e2163a 100644
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
