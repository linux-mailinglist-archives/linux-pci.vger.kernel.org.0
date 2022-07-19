Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2657A9E6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 00:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiGSWiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 18:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSWiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 18:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51F51A35;
        Tue, 19 Jul 2022 15:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 886D961B5C;
        Tue, 19 Jul 2022 22:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99823C341C6;
        Tue, 19 Jul 2022 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658270295;
        bh=obJWTUw1NA9T0L+goOsAOuGwnxuMngwTRG7icA6zQrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ml9Qpw4VQoX87l5mNYTggCGEDulmZxeAIK7yh+05xACyn6kgm/aaLLcmVqFbbnvLt
         FUOF5hWDgm5q1xGTb2+TDzlnFFleJbCIiWH6YSButttJJ7YJ0Sr91M1UCOS33jq0cf
         SusMSohFcooS/HK2/MSoPZAGLNFJ0IARe3JV6y35kCNparzuXcSUGbh/chHIGXZOaq
         swowGfgv0P2Zl+BI5gWfrkDfdO1shasw8woFJVDyr04A9ZsPIJ41/yq433uTqzPZwB
         vjsxsfop3arof5NZQfVZYPbFe+fxyzx2sRUkHizmxBPy+gtadNQu8sPaIpOEyE/pud
         bJXLAiqtxVEog==
Date:   Tue, 19 Jul 2022 17:38:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: designware-ep: Move DBI access to init_complete if
 notifier is used
Message-ID: <20220719223814.GA1586913@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719034348.GA4390@thinkpad>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 09:13:58AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 15, 2022 at 04:39:58PM -0500, Bjorn Helgaas wrote:
> > On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
> > > For controllers supporting the CORE_INIT notifier, the resources are
> > > supposed to be enabled in the init_complete function. Currently,
> > > these controllers are enabling the resources during probe time due to
> > > the DBI access happens in dw_pcie_ep_init().
> > > 
> > > This creates the dependency with the host PCIe controller since the
> > > resource enablement like PHY depends on host PCIe to be up. For the
> > > standalone endpoint usecase, this would never work. So let's move all DBI
> > > access to init_complete function if CORE_INIT notifier is used. For the
> > > controllers those doesn't support this notifier, this change is a NO-OP.
> > > 
> > > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > Cc: Om Prakash Singh <omp@nvidia.com>
> > > Cc: Vidya Sagar <vidyas@nvidia.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
> > >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> > >  2 files changed, 94 insertions(+), 45 deletions(-)
> > 
> > Sorry this got missed.  Seems like there are two patches to solve the
> > same problem:
> > 
> >   1) This patch, and
> >   2) Vidya's patch (https://lore.kernel.org/linux-pci/20220622040133.31058-1-vidyas@nvidia.com/)
> > 
> > I don't know much about dwc or this issue, but if these patches are
> > functionally equivalent, I think Vidya's is a little more attractive
> > because:
> > 
> >   - It's smaller (49 insertions(+), 39 deletions(-)).
> > 
> >   - "core_init_notifier" looks like sort of a corner-case feature and
> >     Vidya's patch doesn't depend on it so it seems more maintainable.
> > 
> >   - It's more straightforward to read -- it basically just moves
> >     things from dw_pcie_ep_init() to dw_pcie_ep_init_complete(), which
> >     is exactly the sort of thing I expect if we're doing something out
> >     of order.
> 
> I agree that Vidya's patch is simple but as per the feedback from
> Kishon on my previous patch, I had to add some extra logic to make
> sure the move of DBI access doesn't affect the non
> core_init_notifier platforms.
> 
> So with my patch, the logic added is essentailly a NO-OP on those.

Can you include the lore URL for Kishon's feedback?  I can't find it.

If we think moving the DBI access is safe on non-core_init_notifier
platforms, I'd like to do it everywhere so they're all the same.  I
don't want different behavior just to avoid the risk of theoretical
problems that we think should not happen.

> Thanks,
> Mani
> 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 0eda8236c125..fb2bf4bf5ba0 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -636,6 +636,63 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > >  	return 0;
> > >  }
> > >  
> > > +static int dw_pcie_iatu_config(struct dw_pcie_ep *ep)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +	struct device *dev = pci->dev;
> > > +	void *addr;
> > > +
> > > +	dw_pcie_iatu_detect(pci);
> > > +
> > > +	ep->ib_window_map = devm_kcalloc(dev,
> > > +					 BITS_TO_LONGS(pci->num_ib_windows),
> > > +					 sizeof(long),
> > > +					 GFP_KERNEL);
> > > +	if (!ep->ib_window_map)
> > > +		return -ENOMEM;
> > > +
> > > +	ep->ob_window_map = devm_kcalloc(dev,
> > > +					 BITS_TO_LONGS(pci->num_ob_windows),
> > > +					 sizeof(long),
> > > +					 GFP_KERNEL);
> > > +	if (!ep->ob_window_map)
> > > +		return -ENOMEM;
> > > +
> > > +	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > +			    GFP_KERNEL);
> > > +	if (!addr)
> > > +		return -ENOMEM;
> > > +
> > > +	ep->outbound_addr = addr;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int dw_pcie_ep_func_init(struct dw_pcie_ep *ep)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +	struct dw_pcie_ep_func *ep_func;
> > > +	struct pci_epc *epc = ep->epc;
> > > +	struct device *dev = pci->dev;
> > > +	u8 func_no;
> > > +
> > > +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > +		if (!ep_func)
> > > +			return -ENOMEM;
> > > +
> > > +		ep_func->func_no = func_no;
> > > +		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > +							      PCI_CAP_ID_MSI);
> > > +		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > +							       PCI_CAP_ID_MSIX);
> > > +
> > > +		list_add_tail(&ep_func->list, &ep->func_list);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > >  {
> > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > @@ -643,7 +700,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > >  	unsigned int nbars;
> > >  	u8 hdr_type;
> > >  	u32 reg;
> > > -	int i;
> > > +	int ret, i;
> > > +
> > > +	if (ep->core_init_notifier) {
> > > +		ret = dw_pcie_iatu_config(ep);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (ep->core_init_notifier) {
> > > +		ret = dw_pcie_ep_func_init(ep);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		if (ep->ops->ep_init)
> > > +			ep->ops->ep_init(ep);
> > > +	}
> > >  
> > >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> > >  		   PCI_HEADER_TYPE_MASK;
> > > @@ -677,8 +749,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> > >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  {
> > >  	int ret;
> > > -	void *addr;
> > > -	u8 func_no;
> > >  	struct resource *res;
> > >  	struct pci_epc *epc;
> > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > @@ -686,7 +756,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	struct platform_device *pdev = to_platform_device(dev);
> > >  	struct device_node *np = dev->of_node;
> > >  	const struct pci_epc_features *epc_features;
> > > -	struct dw_pcie_ep_func *ep_func;
> > > +
> > > +	if (ep->ops->get_features) {
> > > +		epc_features = ep->ops->get_features(ep);
> > > +		if (epc_features->core_init_notifier)
> > > +			ep->core_init_notifier = true;
> > > +	}
> > >  
> > >  	INIT_LIST_HEAD(&ep->func_list);
> > >  
> > > @@ -708,7 +783,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  		}
> > >  	}
> > >  
> > > -	dw_pcie_iatu_detect(pci);
> > > +	if (!ep->core_init_notifier) {
> > > +		ret = dw_pcie_iatu_config(ep);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > >  
> > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> > >  	if (!res)
> > > @@ -717,26 +796,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	ep->phys_base = res->start;
> > >  	ep->addr_size = resource_size(res);
> > >  
> > > -	ep->ib_window_map = devm_kcalloc(dev,
> > > -					 BITS_TO_LONGS(pci->num_ib_windows),
> > > -					 sizeof(long),
> > > -					 GFP_KERNEL);
> > > -	if (!ep->ib_window_map)
> > > -		return -ENOMEM;
> > > -
> > > -	ep->ob_window_map = devm_kcalloc(dev,
> > > -					 BITS_TO_LONGS(pci->num_ob_windows),
> > > -					 sizeof(long),
> > > -					 GFP_KERNEL);
> > > -	if (!ep->ob_window_map)
> > > -		return -ENOMEM;
> > > -
> > > -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > -			    GFP_KERNEL);
> > > -	if (!addr)
> > > -		return -ENOMEM;
> > > -	ep->outbound_addr = addr;
> > > -
> > >  	if (pci->link_gen < 1)
> > >  		pci->link_gen = of_pci_get_max_link_speed(np);
> > >  
> > > @@ -753,23 +812,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	if (ret < 0)
> > >  		epc->max_functions = 1;
> > >  
> > > -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > -		if (!ep_func)
> > > -			return -ENOMEM;
> > > -
> > > -		ep_func->func_no = func_no;
> > > -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > -							      PCI_CAP_ID_MSI);
> > > -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > -							       PCI_CAP_ID_MSIX);
> > > +	if (!ep->core_init_notifier) {
> > > +		ret = dw_pcie_ep_func_init(ep);
> > > +		if (ret)
> > > +			return ret;
> > >  
> > > -		list_add_tail(&ep_func->list, &ep->func_list);
> > > +		if (ep->ops->ep_init)
> > > +			ep->ops->ep_init(ep);
> > >  	}
> > >  
> > > -	if (ep->ops->ep_init)
> > > -		ep->ops->ep_init(ep);
> > > -
> > >  	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> > >  			       ep->page_size);
> > >  	if (ret < 0) {
> > > @@ -784,12 +835,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  		return -ENOMEM;
> > >  	}
> > >  
> > > -	if (ep->ops->get_features) {
> > > -		epc_features = ep->ops->get_features(ep);
> > > -		if (epc_features->core_init_notifier)
> > > -			return 0;
> > > -	}
> > > +	if (!ep->core_init_notifier)
> > > +		return dw_pcie_ep_init_complete(ep);
> > >  
> > > -	return dw_pcie_ep_init_complete(ep);
> > > +	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 7d6e9b7576be..aadb14159df7 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -242,6 +242,7 @@ struct dw_pcie_ep {
> > >  	void __iomem		*msi_mem;
> > >  	phys_addr_t		msi_mem_phys;
> > >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > > +	bool			core_init_notifier;
> > >  };
> > >  
> > >  struct dw_pcie_ops {
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
