Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5978556B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 12:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjHWKc2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 06:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHWKc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 06:32:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094219A;
        Wed, 23 Aug 2023 03:32:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so85672291fa.2;
        Wed, 23 Aug 2023 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692786743; x=1693391543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB2pJrofs4LzfpbPkQ+FsUFAgB6oSJLqrd6m25MNmGA=;
        b=BYK3wl1zDwUSOmpgxxM1qMGVXhqyrppyB9kP5BBOGUSZRDalC37zF34c07SjncxfAE
         mOWVErvXR95tWakhBpah5Y7jvQ/QNEZaCBrl+UTzun2OTK7I/3aebLlMdL5r1Zo41A9R
         4kvrfEfCNKjHUzzPMv9/KPhfaWyeznRzbiT0A1v3cRG0C2CKVVkyozkO+zp7LdHPAwct
         +qYLkLCppYtZdAmsYdVvjflWc0C5gflzGGfS6QneNsu1MTBToF1k3ZZPqYbEf8Jaja+X
         LZGv7Mkxvampd0OHC7QeqkkIpVNwSSidiCDThSJNYSJd3RyhzsyD3is3njBf0T99bwC1
         a7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692786743; x=1693391543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB2pJrofs4LzfpbPkQ+FsUFAgB6oSJLqrd6m25MNmGA=;
        b=b/qpV0GdZkV4+Me95XWyQ4JK3sszikhr6wdBwEhuW5xbcXUqBZGVHn5YVU5JJohwk2
         Mj9jkTzQ66BMxNGw2QhAMGQ3hyYZIsvtbG8FU7u/C2d8qtmv2E5zFKNaypjrzXIh0niV
         PjjLmq4hdctxKe03OnFhvG4m4vLQvwQFdICd+XHn9YdMDOkAEcy3RFJ/bVlKJfweZcoV
         9sCHAvOtzzKeC3et8OX982ZaDt2OADWzN6y7G8/8hf3YzoSbj4WcnfeJlJ3wzt6jz1Mb
         ow4Y+88pCQAg67xiodBl4PsWSYW8cn5IOSKxUsDoeyfMy1nsSrVodwExdAP0jubqDzGY
         +kaQ==
X-Gm-Message-State: AOJu0YyrdgGNVECUlXaLv761/TPdfTyb3rDOF5arhRbxcMkAHdsAz919
        IqbSuNLiutBozS0NXrpgk9w=
X-Google-Smtp-Source: AGHT+IFEf2//JCh/6d/J1+nsLndYyqZaB7YKabSBR9Bbx3WPt694cFFrWriXNoNgVdMUv9lFpSxWWQ==
X-Received: by 2002:a2e:8014:0:b0:2b6:e618:b593 with SMTP id j20-20020a2e8014000000b002b6e618b593mr9419710ljg.31.1692786743473;
        Wed, 23 Aug 2023 03:32:23 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v16-20020a2e9f50000000b002b70a8478ddsm3169455ljk.44.2023.08.23.03.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:32:23 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:32:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v19 04/19] PCI: designware-ep: Add INTx IRQs support
Message-ID: <m76plvpf5zfvrajtnqycagp5yyd7c2njunn3clux2svof6zh27@gquktcx4n7qm>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-5-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823091153.2578417-5-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:11:38PM +0900, Yoshihiro Shimoda wrote:
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
> index 747d5bc07222..4a8c116cdd4b 100644
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

> +	/* A MWr with an effecitive length of '0' is converted to Msg */

1. writel() means 4-byte IO-write. What is the "effecitive" length you are
talking about?
2. You don't generate MWr TLP here. It's Msg TLP. See the atu.type you
specified.
3. s/effecitive/effective

> +	writel(0, ep->intx_mem);

IMO what is done here is a dummy-write triggering the INTx Msg being
generated. I bet you could have done it within any address from
ep->intx_mem to (ep->intx_mem + epc->mem->window.page_size) and by
writing any value, not only 0 because the Msg TLP doesn't have the
memory address and data.

-Serge(y)

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
> index d31c018a3803..c17e5255fab6 100644
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
