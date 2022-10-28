Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1B611876
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJ1Q6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 12:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1Q6Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 12:58:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F341CC76F;
        Fri, 28 Oct 2022 09:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0BBBB82BAF;
        Fri, 28 Oct 2022 16:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23436C433B5;
        Fri, 28 Oct 2022 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976275;
        bh=f6QxoPZM16FkHAtZfmG9jqMgLXfpHxawFf5SQdBOWC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V6rlBW4rH0wMLLonaaEynw4AvVpx8OGAG7Po7M8owcLQpNi7LF4QXhNF/e35y5aEK
         lcoBjR89hcnbdjDJK0934TiAXM1ljogZZq7lDXV8nt7CgVUk2LGakUa35rcn+wpbm+
         PZZ9Rh7Asdo0QFMwbpZl/vuPheoIeExxj4hRzfAAnez2Oae+zW8rmdzfjGRsB16QT2
         thnUvPeskXQfdRbUAu/QmH7mDyZ0DVTfsA2QRZ07T/jCwR5yThO62kzZfC9b/eJPGY
         vhymvrYuXY4S6S2tt3msmdckqcDqffhavAuRPWRBOOtAd/rrMyeN+i9hHALUOeDCRL
         IQhrvBd+vLdeA==
Date:   Fri, 28 Oct 2022 11:57:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1 2/2] PCI: designware-ep: Disable PTM capabilities for
 EP mode
Message-ID: <20221028165753.GA897928@bhelgaas>
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
> 
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

Per spec, PTM Responder Capable, PTM Root Capable, and Local Clock
Granularity may only be set for Root Ports, RCRBs, and Switches (PCIe
r6.0, sec 7.9.15.2).

And this is just a matter of making an Endpoint comply with the spec,
i.e., configures the Endpoint so it doesn't advertise that it can be a
PTM Responder, right?

But the Endpoint probably still *can* be a PTM Requester?

> +	}
> +
>  	dw_pcie_setup(pci);
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> -- 
> 2.17.1
> 
