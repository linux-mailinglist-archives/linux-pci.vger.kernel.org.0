Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06857C684
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiGUIjV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 04:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGUIi5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 04:38:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC57E814
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 01:38:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l124so1127579pfl.8
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 01:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xsmhjzXcB2PDTloWeEwW/cdLOTAut/918qYRhypWu3M=;
        b=FchWfWzxhqkAu8Ppo3Y6LOnpcC1AU316HJgUvx3kgt5KZ+ZAJdRdVWmcSi3BIis/jg
         RijGdFgc7goatlaaG+K6GwtL1u/UJ7aOEPwnvgkMB6Y8m6ehVibV8sVivYbiPsteGfqL
         xIf8Aru0Zp9mtrGC5LtBqtW4mKS1f10VulFszeccdsg8bdKb9tlSputJD9MDZ03o7kSW
         fNSPfTPlA5daR47sW63BISsH85ZYxVVUvhDc7aXIuKYBwZYuaohatY+8P/Xi8Kx7WCk9
         cJ9irkAf/+ISFTaZGcUOM8V/5Mj6iK2njOCg5aj0fCSJhAL0GtzPRhRCYxTGFuZvgeIK
         yVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xsmhjzXcB2PDTloWeEwW/cdLOTAut/918qYRhypWu3M=;
        b=zcmDcP3xW1NQbHkfiyPVmb1BzaMQU8WTdV8TtAL0d8SVxCD3cUnb24/lhy6YpFXIu6
         Z4Ipi2T4aa6A60z77kG3D4rt8kkoYcg8AzpYGjwu6lHOxumJS79ao5ltEJv5w7IRIIcS
         rQUjeM3fUaMcM03sDEbHfR6Z8VwlLkHZwgal/G8y9Ss3qN46ZaBdZrbJ+/8EECW+oICp
         5/X6MNMQ1U/dndlpKdfgrhmwNI/wNxSKvOdMguiOSretiS/wBfok7VfSjl/TGgRaU7W3
         Wf/kTupwlWXxHTdZapfS0Lil8ogSq2zZYfzlWnhZ1cBSLYuooA2hO75Fnd63UD5nzaSn
         XJcQ==
X-Gm-Message-State: AJIora9hhfDe5aibG9HA3fmDNVYY0CMOe5IctUc0/n5mwUL56z7hhTK1
        xprsCkUxVVAtrXiaq6wrnCtPrPpPbWd8
X-Google-Smtp-Source: AGRyM1ufUy6be75/2vnSbnWaCywU9r+bSMKoIO+nKlx6h3J4bBZOuxCzVdnU7JWtCWopu8ZSeuKV9Q==
X-Received: by 2002:a63:686:0:b0:414:1a88:3b98 with SMTP id 128-20020a630686000000b004141a883b98mr37262278pgg.106.1658392732678;
        Thu, 21 Jul 2022 01:38:52 -0700 (PDT)
Received: from thinkpad ([117.217.186.184])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b0015eab1b097dsm1103816pls.22.2022.07.21.01.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:38:52 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:08:45 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: designware-ep: Move DBI access to init_complete if
 notifier is used
Message-ID: <20220721083845.GA36189@thinkpad>
References: <20220719034348.GA4390@thinkpad>
 <20220719223814.GA1586913@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719223814.GA1586913@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 05:38:14PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 19, 2022 at 09:13:58AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jul 15, 2022 at 04:39:58PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
> > > > For controllers supporting the CORE_INIT notifier, the resources are
> > > > supposed to be enabled in the init_complete function. Currently,
> > > > these controllers are enabling the resources during probe time due to
> > > > the DBI access happens in dw_pcie_ep_init().
> > > > 
> > > > This creates the dependency with the host PCIe controller since the
> > > > resource enablement like PHY depends on host PCIe to be up. For the
> > > > standalone endpoint usecase, this would never work. So let's move all DBI
> > > > access to init_complete function if CORE_INIT notifier is used. For the
> > > > controllers those doesn't support this notifier, this change is a NO-OP.
> > > > 
> > > > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > Cc: Om Prakash Singh <omp@nvidia.com>
> > > > Cc: Vidya Sagar <vidyas@nvidia.com>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> > > >  2 files changed, 94 insertions(+), 45 deletions(-)
> > > 
> > > Sorry this got missed.  Seems like there are two patches to solve the
> > > same problem:
> > > 
> > >   1) This patch, and
> > >   2) Vidya's patch (https://lore.kernel.org/linux-pci/20220622040133.31058-1-vidyas@nvidia.com/)
> > > 
> > > I don't know much about dwc or this issue, but if these patches are
> > > functionally equivalent, I think Vidya's is a little more attractive
> > > because:
> > > 
> > >   - It's smaller (49 insertions(+), 39 deletions(-)).
> > > 
> > >   - "core_init_notifier" looks like sort of a corner-case feature and
> > >     Vidya's patch doesn't depend on it so it seems more maintainable.
> > > 
> > >   - It's more straightforward to read -- it basically just moves
> > >     things from dw_pcie_ep_init() to dw_pcie_ep_init_complete(), which
> > >     is exactly the sort of thing I expect if we're doing something out
> > >     of order.
> > 
> > I agree that Vidya's patch is simple but as per the feedback from
> > Kishon on my previous patch, I had to add some extra logic to make
> > sure the move of DBI access doesn't affect the non
> > core_init_notifier platforms.
> > 
> > So with my patch, the logic added is essentailly a NO-OP on those.
> 
> Can you include the lore URL for Kishon's feedback?  I can't find it.
> 

https://patchwork.kernel.org/project/linux-pci/patch/1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com/#24633629

> If we think moving the DBI access is safe on non-core_init_notifier
> platforms, I'd like to do it everywhere so they're all the same.  I
> don't want different behavior just to avoid the risk of theoretical
> problems that we think should not happen.
> 

One more issue Kishon pointed out was that, in the patch the endpoint
controller is configured after pci_epc_create(). So he raised a concern that
if ecp_ops is invoked before the controller gets configured fully, it could
result in aborts.

While the concern may be true for non-core_init_notifier platforms (I'm not sure
though) but I'm certain not for the core_init_notifier ones as the EFP drivers
only access EPC ops after dw_pcie_ep_init_complete().

Thanks,
Mani 

> > Thanks,
> > Mani
> > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 0eda8236c125..fb2bf4bf5ba0 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -636,6 +636,63 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int dw_pcie_iatu_config(struct dw_pcie_ep *ep)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +	struct device *dev = pci->dev;
> > > > +	void *addr;
> > > > +
> > > > +	dw_pcie_iatu_detect(pci);
> > > > +
> > > > +	ep->ib_window_map = devm_kcalloc(dev,
> > > > +					 BITS_TO_LONGS(pci->num_ib_windows),
> > > > +					 sizeof(long),
> > > > +					 GFP_KERNEL);
> > > > +	if (!ep->ib_window_map)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ep->ob_window_map = devm_kcalloc(dev,
> > > > +					 BITS_TO_LONGS(pci->num_ob_windows),
> > > > +					 sizeof(long),
> > > > +					 GFP_KERNEL);
> > > > +	if (!ep->ob_window_map)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > > +			    GFP_KERNEL);
> > > > +	if (!addr)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ep->outbound_addr = addr;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int dw_pcie_ep_func_init(struct dw_pcie_ep *ep)
> > > > +{
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +	struct dw_pcie_ep_func *ep_func;
> > > > +	struct pci_epc *epc = ep->epc;
> > > > +	struct device *dev = pci->dev;
> > > > +	u8 func_no;
> > > > +
> > > > +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > > +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > > +		if (!ep_func)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		ep_func->func_no = func_no;
> > > > +		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > +							      PCI_CAP_ID_MSI);
> > > > +		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > +							       PCI_CAP_ID_MSIX);
> > > > +
> > > > +		list_add_tail(&ep_func->list, &ep->func_list);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > > >  {
> > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > @@ -643,7 +700,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > > >  	unsigned int nbars;
> > > >  	u8 hdr_type;
> > > >  	u32 reg;
> > > > -	int i;
> > > > +	int ret, i;
> > > > +
> > > > +	if (ep->core_init_notifier) {
> > > > +		ret = dw_pcie_iatu_config(ep);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > > +	if (ep->core_init_notifier) {
> > > > +		ret = dw_pcie_ep_func_init(ep);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		if (ep->ops->ep_init)
> > > > +			ep->ops->ep_init(ep);
> > > > +	}
> > > >  
> > > >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> > > >  		   PCI_HEADER_TYPE_MASK;
> > > > @@ -677,8 +749,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> > > >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  {
> > > >  	int ret;
> > > > -	void *addr;
> > > > -	u8 func_no;
> > > >  	struct resource *res;
> > > >  	struct pci_epc *epc;
> > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > @@ -686,7 +756,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  	struct platform_device *pdev = to_platform_device(dev);
> > > >  	struct device_node *np = dev->of_node;
> > > >  	const struct pci_epc_features *epc_features;
> > > > -	struct dw_pcie_ep_func *ep_func;
> > > > +
> > > > +	if (ep->ops->get_features) {
> > > > +		epc_features = ep->ops->get_features(ep);
> > > > +		if (epc_features->core_init_notifier)
> > > > +			ep->core_init_notifier = true;
> > > > +	}
> > > >  
> > > >  	INIT_LIST_HEAD(&ep->func_list);
> > > >  
> > > > @@ -708,7 +783,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  		}
> > > >  	}
> > > >  
> > > > -	dw_pcie_iatu_detect(pci);
> > > > +	if (!ep->core_init_notifier) {
> > > > +		ret = dw_pcie_iatu_config(ep);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > >  
> > > >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> > > >  	if (!res)
> > > > @@ -717,26 +796,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  	ep->phys_base = res->start;
> > > >  	ep->addr_size = resource_size(res);
> > > >  
> > > > -	ep->ib_window_map = devm_kcalloc(dev,
> > > > -					 BITS_TO_LONGS(pci->num_ib_windows),
> > > > -					 sizeof(long),
> > > > -					 GFP_KERNEL);
> > > > -	if (!ep->ib_window_map)
> > > > -		return -ENOMEM;
> > > > -
> > > > -	ep->ob_window_map = devm_kcalloc(dev,
> > > > -					 BITS_TO_LONGS(pci->num_ob_windows),
> > > > -					 sizeof(long),
> > > > -					 GFP_KERNEL);
> > > > -	if (!ep->ob_window_map)
> > > > -		return -ENOMEM;
> > > > -
> > > > -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > > -			    GFP_KERNEL);
> > > > -	if (!addr)
> > > > -		return -ENOMEM;
> > > > -	ep->outbound_addr = addr;
> > > > -
> > > >  	if (pci->link_gen < 1)
> > > >  		pci->link_gen = of_pci_get_max_link_speed(np);
> > > >  
> > > > @@ -753,23 +812,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  	if (ret < 0)
> > > >  		epc->max_functions = 1;
> > > >  
> > > > -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > > -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > > -		if (!ep_func)
> > > > -			return -ENOMEM;
> > > > -
> > > > -		ep_func->func_no = func_no;
> > > > -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > -							      PCI_CAP_ID_MSI);
> > > > -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > -							       PCI_CAP_ID_MSIX);
> > > > +	if (!ep->core_init_notifier) {
> > > > +		ret = dw_pcie_ep_func_init(ep);
> > > > +		if (ret)
> > > > +			return ret;
> > > >  
> > > > -		list_add_tail(&ep_func->list, &ep->func_list);
> > > > +		if (ep->ops->ep_init)
> > > > +			ep->ops->ep_init(ep);
> > > >  	}
> > > >  
> > > > -	if (ep->ops->ep_init)
> > > > -		ep->ops->ep_init(ep);
> > > > -
> > > >  	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> > > >  			       ep->page_size);
> > > >  	if (ret < 0) {
> > > > @@ -784,12 +835,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  		return -ENOMEM;
> > > >  	}
> > > >  
> > > > -	if (ep->ops->get_features) {
> > > > -		epc_features = ep->ops->get_features(ep);
> > > > -		if (epc_features->core_init_notifier)
> > > > -			return 0;
> > > > -	}
> > > > +	if (!ep->core_init_notifier)
> > > > +		return dw_pcie_ep_init_complete(ep);
> > > >  
> > > > -	return dw_pcie_ep_init_complete(ep);
> > > > +	return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 7d6e9b7576be..aadb14159df7 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -242,6 +242,7 @@ struct dw_pcie_ep {
> > > >  	void __iomem		*msi_mem;
> > > >  	phys_addr_t		msi_mem_phys;
> > > >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > > > +	bool			core_init_notifier;
> > > >  };
> > > >  
> > > >  struct dw_pcie_ops {
> > > > -- 
> > > > 2.25.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
