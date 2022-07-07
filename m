Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFE256A755
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 18:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiGGQAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiGGQAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 12:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5F0248F2;
        Thu,  7 Jul 2022 09:00:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE541623C5;
        Thu,  7 Jul 2022 16:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF367C3411E;
        Thu,  7 Jul 2022 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657209633;
        bh=X0hgtXNtPCzDVoTa+AfUO/GtPtIMRl92mG9LfpPYDp8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sezTfx1JdEg0rAdJLz1ko+a+Rcyr96gJZ6oK1gMW8b7mAbaxUSFd7SyOTemewO0kR
         uAqyO/Luirmy8QB46O3+xzhkuCXvNR0j0KvnxyC8YBDTq2xGzIQQU+JmvUntIdyWFV
         1QZdsP1y3myBQFskF5pLiJeebbYI3d/i9u1HarBw/WwcL57gTaRJ+hmpmqBWOHXkwX
         2myg5/9DUDBJKAItodUIHTm5F2C3e3w+6QbvsPQmZEElI55cUoDkdqmXt0LtXIqsJF
         zo9SV7nSMC/t7fEM0Lt3LFI4eBTWoUKTf2+6QzJrCsMELBCSgB8tDcbBpHrTkZ1KOS
         lk0VMK89ShEWA==
Date:   Thu, 7 Jul 2022 11:00:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220707160031.GA306375@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c36260c-6bb6-7eb5-be82-c60cd927c02d@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Serge]

On Thu, Jul 07, 2022 at 02:39:08PM +0530, Vidya Sagar wrote:
> Hi,
> Anyone has review comments for this change?
> Without this change, Tegra194's endpoint mode is effectively broken.

Did Tegra194 endpoint mode ever work, or has this always been broken.
Wondering if there's a Fixes: or stable tag we should add.  Also cc'd
Serge since he's been doing similar work on dwc.

> On 6/22/2022 9:31 AM, Vidya Sagar wrote:
> > Platforms that cannot support their core initialization without the
> > reference clock from the host, implement the feature 'core_init_notifier'
> > to indicate the DesignWare sub-system about when their core is getting
> > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > core to dw_pcie_ep_init_complete() API which is effectively called only
> > after the core initialization.
> > 
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >   .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
> >   1 file changed, 49 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 0eda8236c125..9feec720175f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> >   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >   {
> >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct dw_pcie_ep_func *ep_func;
> > +	struct device *dev = pci->dev;
> > +	struct pci_epc *epc = ep->epc;
> >   	unsigned int offset;
> >   	unsigned int nbars;
> >   	u8 hdr_type;
> > +	u8 func_no;
> > +	void *addr;
> >   	u32 reg;
> >   	int i;
> > @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >   		return -EIO;
> >   	}
> > +	dw_pcie_iatu_detect(pci);
> > +
> > +	ep->ib_window_map = devm_kcalloc(dev,
> > +					 BITS_TO_LONGS(pci->num_ib_windows),
> > +					 sizeof(long),
> > +					 GFP_KERNEL);
> > +	if (!ep->ib_window_map)
> > +		return -ENOMEM;
> > +
> > +	ep->ob_window_map = devm_kcalloc(dev,
> > +					 BITS_TO_LONGS(pci->num_ob_windows),
> > +					 sizeof(long),
> > +					 GFP_KERNEL);
> > +	if (!ep->ob_window_map)
> > +		return -ENOMEM;
> > +
> > +	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > +			    GFP_KERNEL);
> > +	if (!addr)
> > +		return -ENOMEM;
> > +	ep->outbound_addr = addr;
> > +
> > +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > +		if (!ep_func)
> > +			return -ENOMEM;
> > +
> > +		ep_func->func_no = func_no;
> > +		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > +							      PCI_CAP_ID_MSI);
> > +		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > +							       PCI_CAP_ID_MSIX);
> > +
> > +		list_add_tail(&ep_func->list, &ep->func_list);
> > +	}
> > +
> >   	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> >   	dw_pcie_dbi_ro_wr_en(pci);
> > @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> >   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   {
> >   	int ret;
> > -	void *addr;
> > -	u8 func_no;
> >   	struct resource *res;
> >   	struct pci_epc *epc;
> >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   	struct platform_device *pdev = to_platform_device(dev);
> >   	struct device_node *np = dev->of_node;
> >   	const struct pci_epc_features *epc_features;
> > -	struct dw_pcie_ep_func *ep_func;
> >   	INIT_LIST_HEAD(&ep->func_list);
> > @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   		}
> >   	}
> > -	dw_pcie_iatu_detect(pci);
> > -
> >   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> >   	if (!res)
> >   		return -EINVAL;
> > @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   	ep->phys_base = res->start;
> >   	ep->addr_size = resource_size(res);
> > -	ep->ib_window_map = devm_kcalloc(dev,
> > -					 BITS_TO_LONGS(pci->num_ib_windows),
> > -					 sizeof(long),
> > -					 GFP_KERNEL);
> > -	if (!ep->ib_window_map)
> > -		return -ENOMEM;
> > -
> > -	ep->ob_window_map = devm_kcalloc(dev,
> > -					 BITS_TO_LONGS(pci->num_ob_windows),
> > -					 sizeof(long),
> > -					 GFP_KERNEL);
> > -	if (!ep->ob_window_map)
> > -		return -ENOMEM;
> > -
> > -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > -			    GFP_KERNEL);
> > -	if (!addr)
> > -		return -ENOMEM;
> > -	ep->outbound_addr = addr;
> > -
> >   	if (pci->link_gen < 1)
> >   		pci->link_gen = of_pci_get_max_link_speed(np);
> > @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   	if (ret < 0)
> >   		epc->max_functions = 1;
> > -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > -		if (!ep_func)
> > -			return -ENOMEM;
> > -
> > -		ep_func->func_no = func_no;
> > -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > -							      PCI_CAP_ID_MSI);
> > -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > -							       PCI_CAP_ID_MSIX);
> > -
> > -		list_add_tail(&ep_func->list, &ep->func_list);
> > -	}
> > -
> >   	if (ep->ops->ep_init)
> >   		ep->ops->ep_init(ep);
> > @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >   			return 0;
> >   	}
> > +	/*
> > +	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> > +	 * step as platforms that implement 'core_init_notifier' feature may
> > +	 * not have the hardware ready (i.e. core initialized) for access
> > +	 * (Ex: tegra194). Any hardware access on such platforms result
> > +	 * in system hard hang.
> > +	 */
> > +
> >   	return dw_pcie_ep_init_complete(ep);
> >   }
> >   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > 
