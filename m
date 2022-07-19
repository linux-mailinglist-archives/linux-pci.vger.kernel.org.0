Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129E357916E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 05:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiGSDoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 23:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiGSDoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 23:44:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3F81BE84
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 20:44:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s21so13532234pjq.4
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 20:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w7xQfXVqVf+8i390/ce6X32QWNcsJH7gQ4PHVa5GP2M=;
        b=JmGrMusyuRsDt0oP7DI0K9GQpc60uNkLyxoFSHiiEIP2z7dttoYdgxqIOAh+k+mhZa
         FIc7p0ptfXFLgMQDGxQesX4p5TteXU2VjO7DfWQLDLhdhaGvP0IAEn+ixzS+IKn5idq5
         JNTr0JZpPDrtd7xD1ncv2SL6p8WRtKukg3t7CLnsQrBYkYnXjCVOTKb/6fWwXE9BOnzE
         aAItQTm/hgCo79ehPVx3TvcIqd340sK8egm3iQvWdN6Ah0S9F24pH+l/ypCqxMt/wkOH
         L/wo5Q0FgHIgy7K74MflbkGE1ihMug0s2LBnVXYdChHUnKYNzTb9uFImFQ/rjuJCLbx6
         6M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w7xQfXVqVf+8i390/ce6X32QWNcsJH7gQ4PHVa5GP2M=;
        b=CUXbkZ1caO8aFi5pDX06XeiXK2YinIHmPkDbsg5LD/+CEVROOcqA4KU+M0ZUcCiFkq
         4aHp56CN+Fh/TmduP5aMSmmV1Os/SLztXr0ehqYl+Xj+QR7JwyEeP+m+KibgFXMCExYI
         y5papa+C3bRN0FspXaLesTn5ObFi0cwZECyZdGAsv60l5kqRErLiF5OKaUGJFTE1JmsL
         w9GawZGGerMWU+H4lVo9rwMnsp7SumjwKdcTHnvVD5hRMjb6byk19TmJxOmEGf4jjSk8
         j0gZ2G7XijN+TSpfuUBQcbu88YqUpYIyaVoBeFVzJM12VOOTDu7eGpRFwdGCBFCmbfKa
         +m8A==
X-Gm-Message-State: AJIora8LsJ76vh3dTrR+O2sFOcgqhoIZkGZMDAS43mPUVDiLRHjsOOOw
        4d8mU6WgnuzWC1VCfwcyF9IO
X-Google-Smtp-Source: AGRyM1uuwgPjI/vdy0x4Wjg9ytwvWrXBcB2ldK0xBU0IWbw8MNXu0yJQl2+nq37k3PsWcL1JpBAS7A==
X-Received: by 2002:a17:90b:3911:b0:1ef:fa84:dc80 with SMTP id ob17-20020a17090b391100b001effa84dc80mr42742343pjb.7.1658202245165;
        Mon, 18 Jul 2022 20:44:05 -0700 (PDT)
Received: from thinkpad ([117.217.180.99])
        by smtp.gmail.com with ESMTPSA id br12-20020a17090b0f0c00b001ef42b3c5besm10202842pjb.23.2022.07.18.20.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 20:44:04 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:13:58 +0530
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
Message-ID: <20220719034348.GA4390@thinkpad>
References: <20220330060515.22328-1-manivannan.sadhasivam@linaro.org>
 <20220715213958.GA1192967@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715213958.GA1192967@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 04:39:58PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
> > For controllers supporting the CORE_INIT notifier, the resources are
> > supposed to be enabled in the init_complete function. Currently,
> > these controllers are enabling the resources during probe time due to
> > the DBI access happens in dw_pcie_ep_init().
> > 
> > This creates the dependency with the host PCIe controller since the
> > resource enablement like PHY depends on host PCIe to be up. For the
> > standalone endpoint usecase, this would never work. So let's move all DBI
> > access to init_complete function if CORE_INIT notifier is used. For the
> > controllers those doesn't support this notifier, this change is a NO-OP.
> > 
> > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Cc: Om Prakash Singh <omp@nvidia.com>
> > Cc: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
> >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> >  2 files changed, 94 insertions(+), 45 deletions(-)
> 
> Sorry this got missed.  Seems like there are two patches to solve the
> same problem:
> 
>   1) This patch, and
>   2) Vidya's patch (https://lore.kernel.org/linux-pci/20220622040133.31058-1-vidyas@nvidia.com/)
> 
> I don't know much about dwc or this issue, but if these patches are
> functionally equivalent, I think Vidya's is a little more attractive
> because:
> 
>   - It's smaller (49 insertions(+), 39 deletions(-)).
> 
>   - "core_init_notifier" looks like sort of a corner-case feature and
>     Vidya's patch doesn't depend on it so it seems more maintainable.
> 
>   - It's more straightforward to read -- it basically just moves
>     things from dw_pcie_ep_init() to dw_pcie_ep_init_complete(), which
>     is exactly the sort of thing I expect if we're doing something out
>     of order.
> 

I agree that Vidya's patch is simple but as per the feedback from Kishon on my
previous patch, I had to add some extra logic to make sure the move of DBI
access doesn't affect the non core_init_notifier platforms.

So with my patch, the logic added is essentailly a NO-OP on those.

Thanks,
Mani

> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 0eda8236c125..fb2bf4bf5ba0 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -636,6 +636,63 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> >  	return 0;
> >  }
> >  
> > +static int dw_pcie_iatu_config(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct device *dev = pci->dev;
> > +	void *addr;
> > +
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
> > +
> > +	ep->outbound_addr = addr;
> > +
> > +	return 0;
> > +}
> > +
> > +static int dw_pcie_ep_func_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct dw_pcie_ep_func *ep_func;
> > +	struct pci_epc *epc = ep->epc;
> > +	struct device *dev = pci->dev;
> > +	u8 func_no;
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
> > +	return 0;
> > +}
> > +
> >  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > @@ -643,7 +700,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >  	unsigned int nbars;
> >  	u8 hdr_type;
> >  	u32 reg;
> > -	int i;
> > +	int ret, i;
> > +
> > +	if (ep->core_init_notifier) {
> > +		ret = dw_pcie_iatu_config(ep);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (ep->core_init_notifier) {
> > +		ret = dw_pcie_ep_func_init(ep);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (ep->ops->ep_init)
> > +			ep->ops->ep_init(ep);
> > +	}
> >  
> >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> >  		   PCI_HEADER_TYPE_MASK;
> > @@ -677,8 +749,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  {
> >  	int ret;
> > -	void *addr;
> > -	u8 func_no;
> >  	struct resource *res;
> >  	struct pci_epc *epc;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > @@ -686,7 +756,12 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct device_node *np = dev->of_node;
> >  	const struct pci_epc_features *epc_features;
> > -	struct dw_pcie_ep_func *ep_func;
> > +
> > +	if (ep->ops->get_features) {
> > +		epc_features = ep->ops->get_features(ep);
> > +		if (epc_features->core_init_notifier)
> > +			ep->core_init_notifier = true;
> > +	}
> >  
> >  	INIT_LIST_HEAD(&ep->func_list);
> >  
> > @@ -708,7 +783,11 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		}
> >  	}
> >  
> > -	dw_pcie_iatu_detect(pci);
> > +	if (!ep->core_init_notifier) {
> > +		ret = dw_pcie_iatu_config(ep);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> >  	if (!res)
> > @@ -717,26 +796,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	ep->phys_base = res->start;
> >  	ep->addr_size = resource_size(res);
> >  
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
> >  	if (pci->link_gen < 1)
> >  		pci->link_gen = of_pci_get_max_link_speed(np);
> >  
> > @@ -753,23 +812,15 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	if (ret < 0)
> >  		epc->max_functions = 1;
> >  
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
> > +	if (!ep->core_init_notifier) {
> > +		ret = dw_pcie_ep_func_init(ep);
> > +		if (ret)
> > +			return ret;
> >  
> > -		list_add_tail(&ep_func->list, &ep->func_list);
> > +		if (ep->ops->ep_init)
> > +			ep->ops->ep_init(ep);
> >  	}
> >  
> > -	if (ep->ops->ep_init)
> > -		ep->ops->ep_init(ep);
> > -
> >  	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
> >  			       ep->page_size);
> >  	if (ret < 0) {
> > @@ -784,12 +835,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		return -ENOMEM;
> >  	}
> >  
> > -	if (ep->ops->get_features) {
> > -		epc_features = ep->ops->get_features(ep);
> > -		if (epc_features->core_init_notifier)
> > -			return 0;
> > -	}
> > +	if (!ep->core_init_notifier)
> > +		return dw_pcie_ep_init_complete(ep);
> >  
> > -	return dw_pcie_ep_init_complete(ep);
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 7d6e9b7576be..aadb14159df7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -242,6 +242,7 @@ struct dw_pcie_ep {
> >  	void __iomem		*msi_mem;
> >  	phys_addr_t		msi_mem_phys;
> >  	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
> > +	bool			core_init_notifier;
> >  };
> >  
> >  struct dw_pcie_ops {
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
