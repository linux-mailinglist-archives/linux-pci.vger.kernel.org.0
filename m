Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C558460F641
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 13:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiJ0Lco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 07:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJ0Lcn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 07:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3726F114DDF;
        Thu, 27 Oct 2022 04:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C826562291;
        Thu, 27 Oct 2022 11:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DE0C43144;
        Thu, 27 Oct 2022 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666870362;
        bh=mSWAsUxDE3EBIXC90iH0VJmw8rHTYfLTHhgMsJ9b89k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3rtT6gxMwHkn7ceFPoQ6Rbt+N3JvKSIlAx9Ao0WyQKtxKzgWm7sZVv11gtXlV9y4
         +Rxhz8JNqKpEQeT75r4Y/TxvvL6j7Ud9Jd7kau9n1vEjU9e6ww/9bnxBlcAaRpk+w1
         g/LUWU7sbGZJ5vW+Zp6IHYCsTH24Vvqlb8mu3Anh8jFuj68OnkKiCEtGfk9d4UcJTK
         bcHXRzWfvcBR0WFQYcL5g7+VcfYY39TJeAvk/gfIp7odA2dIW/MUO0235nXzo0aIOc
         qeXr00yEb/LFrlut40cefr4EIrTXQXQLVJyFkAKug1xwzwHgQafLJnSqm4prvUZ/rJ
         DnfoXBmVKTc7w==
Date:   Thu, 27 Oct 2022 13:32:35 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 2/2] PCI: designware-ep: Disable PTM capabilities for
 EP mode
Message-ID: <Y1psU2P4uqD2rUub@lpieralisi>
References: <20220919143340.4527-1-vidyas@nvidia.com>
 <20220919143340.4527-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919143340.4527-3-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 19, 2022 at 08:03:40PM +0530, Vidya Sagar wrote:
> Dual mode DesignWare PCIe IP has PTM capability enabled (if supported) even
> in the EP mode. The PCIe compliance for the EP mode expects PTM
> capabilities (ROOT_CAPABLE, RES_CAPABLE, CLK_GRAN) be disabled.
> Hence disable PTM for the EP mode.

"PCIe compliance" - what is this referring to ?

Was this reported to Synopsys ?

Thanks,
Lorenzo

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e9529ae3824..dc3057b18f36 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -646,7 +646,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  	struct dw_pcie_ep_func *ep_func;
>  	struct device *dev = pci->dev;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int offset;
> +	unsigned int offset, ptm_cap_base;
>  	unsigned int nbars;
>  	u8 hdr_type;
>  	u8 func_no;
> @@ -698,6 +698,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  	}
>  
>  	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> @@ -710,6 +711,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
>  	}
>  
> +	/*
> +	 * PTM responder capability can be disabled only after disabling
> +	 * PTM root capability.
> +	 */
> +	if (ptm_cap_base) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		reg &= ~PCI_PTM_CAP_ROOT;
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +
> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +
>  	dw_pcie_setup(pci);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> -- 
> 2.17.1
> 
