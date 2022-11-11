Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110A2625A87
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKKMeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 07:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKKMeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 07:34:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2966CBF;
        Fri, 11 Nov 2022 04:34:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64AE261FA3;
        Fri, 11 Nov 2022 12:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B19C433C1;
        Fri, 11 Nov 2022 12:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668170055;
        bh=sTpTwk/WJqD1ipHmx8zTGanYJOqQKPK9c45HM11yvCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2wHWBnJy21qg5kMk7OIx3DLhxEcK/lXU71IdwlIbp+SJp464kzHEttSgtwLa6Zrh
         oqbUjNE1pzIy56MqyzguLHryevQkXEh4p2bYuBHlWPU87kOlerTkPENjV3mx3nWbod
         m45LSGzvh4MgqDXnRhv1NhWiIcwdweMz2FpHbVpI3G8FU45XrD2WkhpVXRu0cokd6b
         bCOi3lnatC88CK+H+iXDJrhDYh5sy4iFEw3EFBxHsktQeCxrl8dZBpzbgyNnB76Ki2
         OEpy0aUuUMBVJremWKEaAc45EfR7MJCuVHJaY5OSj2NNDjtBO9Gi+CcZPVUIjmGCdo
         fCIhGUCob3Cow==
Date:   Fri, 11 Nov 2022 13:34:09 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        kishon@kernel.org
Cc:     robh+dt@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzk+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 06/10] PCI: dwc: Add reset_all_bars flag
Message-ID: <Y25BQS3GZkzbz8OL@lpieralisi>
References: <20220922080647.3489791-1-yoshihiro.shimoda.uh@renesas.com>
 <20220922080647.3489791-7-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922080647.3489791-7-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 22, 2022 at 05:06:43PM +0900, Yoshihiro Shimoda wrote:
> Some PCIe endpoint drivers reset all BARs in each ep_init() ops.
> So, we can reset the BARs into the common code if the flag is set.

Is there a reason why only some drivers do it ? What I am really asking
is whether instead of a flag we could reset them unconditionally in all
drivers.

It would be good to come up with a set of guidelines on kernel
expectations rather than adding them per EP.

Lorenzo

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 ++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h    |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 1b7e9e1b8d52..a79482824e74 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -83,6 +83,14 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
>  
> +static void dw_pcie_ep_reset_all_bars(struct dw_pcie *pci)
> +{
> +	enum pci_barno bar;
> +
> +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
>  static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
>  		u8 cap_ptr, u8 cap)
>  {
> @@ -759,6 +767,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  	if (ep->ops->ep_init)
>  		ep->ops->ep_init(ep);
> +	if (ep->reset_all_bars)
> +		dw_pcie_ep_reset_all_bars(pci);
>  
>  	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
>  			       ep->page_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9ed9621a12e4..0ad9ed77affb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -353,6 +353,7 @@ struct dw_pcie_ep {
>  	void __iomem		*msi_mem;
>  	phys_addr_t		msi_mem_phys;
>  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> +	bool			reset_all_bars;
>  };
>  
>  struct dw_pcie_ops {
> -- 
> 2.25.1
> 
