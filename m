Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3CB56C773
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 08:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGIGEu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 02:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIGEu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 02:04:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCEE1401A
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 23:04:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3807614pjc.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Jul 2022 23:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VfmUDBzWKaAYUtuKo7kSYyRHIxCs6A8SWq6RQ+iZIRs=;
        b=rK0QXtD1/EyOLb23AlQbK3+lrqx86wrnBdmTdgQz3GeDeMknu4Z7xDZ0eS/X1ussC1
         N3a8RhKRY9QgycNXbD+A03MezYV+RcTSl+cP5htSCVkeYYAStNE+fYkeXTuDOtZeBJsO
         EVr5UP34eXxJOH/26qB1YqrQT/LytTtN1tQ6RF6FFq1JBM7jHFUAbhJcL3sJQwFvx9DS
         0tG1LHxHMwLebS6/CHuAl0AilVC1Ona8W7Rj//0qXWn9fA7eytbOLUU2f9BfIrU8m+KP
         hyiL7xwoaMcWHaKCJc+NmErndNPHT1BhuHH7/Ln2Po7MABFRxY3GtFN2HFZ5FGBV6cna
         t52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VfmUDBzWKaAYUtuKo7kSYyRHIxCs6A8SWq6RQ+iZIRs=;
        b=xwoN/WOE80K8oCoEIwYWoZr8pfqnhVAxymbqOCGpE4yIl+xsOl8cmpzU41AqxTPmYh
         oS7xZN0bzlKwhGKQKUyVT/R9gjCZ+6i7/84ohY3yPKAA/Gg8ddULFYKQfEA+ozpa03Un
         Kfp35QiGL16uaVZnlBHHlUqxgP/Dw43GBcbgehLpB5+OVqeCM851p2RgK/T8W6ql/qtb
         NafaquD3uOI1I0m/vnlsBD0Vuh6iVC9EU65ccPkqg2litswD4LIUBWPSSYmM58hRgbOp
         nBkUIXkl6aCYHhAvzPwx01gULdUP9zf3K7lnNpcMT7kwtsf9RUqzYmHVzKCw3fYapaq8
         pGlg==
X-Gm-Message-State: AJIora/CWckxev24Cccl7FWNKSDHGQ8QYdZGx1FyickMpbkMEJsxdcIM
        MG6lnx5E5YSNeQH0JaFRVEFRWUIeSVR7
X-Google-Smtp-Source: AGRyM1sln5odRSOSML8gY9Qgm1iKb8zALcEF9UF+5rkrsALJ3XRMgUdsf0orPXVQ+kvdgezHfVqv8w==
X-Received: by 2002:a17:902:d1cb:b0:16c:1fda:dcd7 with SMTP id g11-20020a170902d1cb00b0016c1fdadcd7mr7383089plb.170.1657346686945;
        Fri, 08 Jul 2022 23:04:46 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id e7-20020aa79807000000b0052a8128699fsm598394pfl.207.2022.07.08.23.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 23:04:46 -0700 (PDT)
Date:   Sat, 9 Jul 2022 11:34:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: designware-ep: Move DBI access to init_complete if
 notifier is used
Message-ID: <20220709060439.GA5063@thinkpad>
References: <20220330060515.22328-1-manivannan.sadhasivam@linaro.org>
 <20220427101820.GC2536@thinkpad>
 <20220707165751.GB5458@thinkpad>
 <29c5a103-6f91-e978-6d80-45db6dc4a18b@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29c5a103-6f91-e978-6d80-45db6dc4a18b@socionext.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 09, 2022 at 10:42:32AM +0900, Kunihiko Hayashi wrote:
> Hi Manivannan,
> 
> On 2022/07/08 1:57, Manivannan Sadhasivam wrote:
> > On Wed, Apr 27, 2022 at 03:48:26PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
> > > > For controllers supporting the CORE_INIT notifier, the resources are
> > > > supposed to be enabled in the init_complete function. Currently,
> > > > these controllers are enabling the resources during probe time due to
> > > > the DBI access happens in dw_pcie_ep_init().
> > > > 
> > > > This creates the dependency with the host PCIe controller since the
> > > > resource enablement like PHY depends on host PCIe to be up. For the
> > > > standalone endpoint usecase, this would never work. So let's move all
> > > > DBI
> > > > access to init_complete function if CORE_INIT notifier is used. For the
> > > > controllers those doesn't support this notifier, this change is a NO-OP.
> > > > 
> > > > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > Cc: Om Prakash Singh <omp@nvidia.com>
> > > > Cc: Vidya Sagar <vidyas@nvidia.com>
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > A gentle ping on this patch!
> > > 
> 
> Sorry I couldn't check it.
> I think the original source seems to have changed in the latest, so please
> rebase and fix some conflicts.
> 

Sure, will do.

> > Ping again!
> > 
> > Thanks,
> > Mani
> > 
> > > Thanks,
> > > Mani
> > > 
> > > > ---
> > > >   .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
> > > >   drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> > > >   2 files changed, 94 insertions(+), 45 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 0eda8236c125..fb2bf4bf5ba0 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -636,6 +636,63 @@ static unsigned int
> > > > dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > > >   	return 0;
> > > >   }
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
> > > >   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > > >   {
> > > >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > @@ -643,7 +700,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > > >   	unsigned int nbars;
> > > >   	u8 hdr_type;
> > > >   	u32 reg;
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
> 
> It isn't necessary to divide function calls under same condition
> (ep->core_init_notifier).
> 

Right. I think one of the part came from previous patch, so I forgot to merge
them.

> > > > 
> > > >   	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> > > >   		   PCI_HEADER_TYPE_MASK;
> > > > @@ -677,8 +749,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> > > >   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >   {
> > > >   	int ret;
> > > > -	void *addr;
> > > > -	u8 func_no;
> > > >   	struct resource *res;
> > > >   	struct pci_epc *epc;
> > > >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > @@ -686,7 +756,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >   	struct platform_device *pdev = to_platform_device(dev);
> > > >   	struct device_node *np = dev->of_node;
> > > >   	const struct pci_epc_features *epc_features;
> > > > -	struct dw_pcie_ep_func *ep_func;
> > > > +
> > > > +	if (ep->ops->get_features) {
> > > > +		epc_features = ep->ops->get_features(ep);
> > > > +		if (epc_features->core_init_notifier)
> > > > +			ep->core_init_notifier = true;
> > > > +	}
> > > > 
> > > >   	INIT_LIST_HEAD(&ep->func_list);
> > > > 
> > > > @@ -708,7 +783,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >   		}
> > > >   	}
> > > > 
> > > > -	dw_pcie_iatu_detect(pci);
> > > > +	if (!ep->core_init_notifier) {
> > > > +		ret = dw_pcie_iatu_config(ep);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > 
> > > >   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > > "addr_space");
> > > >   	if (!res)
> > > > @@ -717,26 +796,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >   	ep->phys_base = res->start;
> > > >   	ep->addr_size = resource_size(res);
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
> > > >   	if (pci->link_gen < 1)
> > > >   		pci->link_gen = of_pci_get_max_link_speed(np);
> > > > 
> > > > @@ -753,23 +812,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >   	if (ret < 0)
> > > >   		epc->max_functions = 1;
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
> > > >   	}
> > > > 
> > > > -	if (ep->ops->ep_init)
> > > > -		ep->ops->ep_init(ep);
> > > > -
> > > >   	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> > > >   			       ep->page_size);
> > > >   	if (ret < 0) {
> > > > @@ -784,12 +835,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >   		return -ENOMEM;
> > > >   	}
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
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> 
> Since devm_pci_epc_create() is called in dw_pcie_ep_init(), EPC functions
> are available at this time, however, the driver can't access any controller
> registers until PERST# signal interrupt occurs.
> 
> I think that EPC functions aren't called until PERST# signal, but
> I'm worried about whether controller access will occur.
> 

Most of the EPC accesses are carried out by EPF and that won't be available
until dw_pcie_ep_init_complete() gets completed for core_init_notifier case.
This is one of the concerns Kishon raised but I think here we are safe.

Thanks,
Mani

> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 7d6e9b7576be..aadb14159df7 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -242,6 +242,7 @@ struct dw_pcie_ep {
> > > >   	void __iomem		*msi_mem;
> > > >   	phys_addr_t		msi_mem_phys;
> > > >   	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > > > +	bool			core_init_notifier;
> > > >   };
> > > > 
> > > >   struct dw_pcie_ops {
> > > > -- 
> > > > 2.25.1
> > > > 
> 
> Thank you,
> 
> ---
> Best Regards
> Kunihiko Hayashi

-- 
மணிவண்ணன் சதாசிவம்
