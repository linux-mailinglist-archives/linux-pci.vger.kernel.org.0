Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75584B0BA8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 12:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiBJLCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 06:02:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiBJLCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 06:02:18 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34418FE2
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 03:02:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d187so9537236pfa.10
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 03:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D3n9GGBmDktyoUOPvx6bv8pnSzGQstasxqMB02evq5Y=;
        b=i0SrODC31YHkgfQRD4n8OMDj+NFU1Vq1WCcnbgUx57RNw+QVi584LCQLISQYBW6k22
         LtCz9NpQeiy8iizL03jsva87BNjRzegD/8yTtpT9cpK4uQ2TXoEHnyopgjAT3U7Rb7yR
         Q37m9xZ/oxkxSI3d8FuDPwjishj4mFQTJoL9pPB0WuWd2mlzJFhzqOT20ZFduPkYEwma
         eo22FGV/6rmm4WbzIDGP3rggbi06kskL8cGccnR17auRrNhayehgnYhHFtfcEW3SRSHV
         rj5J9Zt4odyPc96JPh0zCJ3d9gwvltzvtmitLaTjOe9anof4SzJDdkARbAoLE36TIM4b
         mwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D3n9GGBmDktyoUOPvx6bv8pnSzGQstasxqMB02evq5Y=;
        b=6GX/gDDWEqahMZ53EQhgu1E6asbeoraXtqGfhLnjP6/QPh+Iv11rw+IGeV6tU9cpNc
         7xqPPdcRUpI1p1h2kKQOTcR9sLk1o3KqY1xWg/VEqhquty6ggxYLwB+nnCZZ7YQlueKS
         Z4CWu6QjGrT8aDDnf0UJj6YhQvyPf4P7ku0a1LzYw35e9NqpUT+VD/qUWWJXNTo9hw4O
         ppPflkRSEOUjOjwtIchgCX4P2/crvZLTN2l9LRIs4UqzPJ9EV9tsKeAJ1dCHMqbe+Rj7
         L8GwzZJSGgT6fA89ki8DBl34v/mMXK41AoU9BjVrnSZ7eyi48Ezlh8PqqlOkBmDKCjy7
         q03A==
X-Gm-Message-State: AOAM531VrN1ZzQTa+shtQE3QJHu6SRfCbX6sUTWSIzQKOM0/WzJSxaum
        bDjkDu2KwGXj/1H6eLXT9Xbn
X-Google-Smtp-Source: ABdhPJxu3t6vJViDB9slmnnfMVZr3euogAjFa+bxRwkWwfcx6AwWlt5EvzczDuFNojXgeCvMRRMIig==
X-Received: by 2002:a05:6a00:140e:: with SMTP id l14mr7055920pfu.22.1644490938557;
        Thu, 10 Feb 2022 03:02:18 -0800 (PST)
Received: from thinkpad ([27.111.75.88])
        by smtp.gmail.com with ESMTPSA id y5sm6851248pfw.165.2022.02.10.03.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 03:02:17 -0800 (PST)
Date:   Thu, 10 Feb 2022 16:32:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: designware-ep: Fix the access to DBI/iATU
 registers before enabling controller
Message-ID: <20220210110212.GC69529@thinkpad>
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com>
 <576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Fri, Dec 03, 2021 at 10:36:00AM +0530, Kishon Vijay Abraham I wrote:
> Hi Kunihiko,
> 
> On 01/09/21 10:46 am, Kunihiko Hayashi wrote:
> > The driver using core_init_notifier, e.g. pcie-tegra194.c, runs according
> > to the following sequence:
> > 
> >     probe()
> >         dw_pcie_ep_init()
> > 
> >     bind()
> >         dw_pcie_ep_start()
> >             enable_irq()
> > 
> >     (interrupt occurred)
> >     handler()
> >         [enable controller]
> >         dw_pcie_ep_init_complete()
> >         dw_pcie_ep_init_notify()
> > 
> > After receiving an interrupt from RC, the handler enables the controller
> > and the controller registers can be accessed.
> > So accessing the registers should do in dw_pcie_ep_init_complete().
> > 
> > Currently dw_pcie_ep_init() has functions dw_iatu_detect() and
> > dw_pcie_ep_find_capability() that include accesses to DWC registers.
> > As a result, accessing the registers before enabling the controller,
> > the access will fail.
> > 
> > The function dw_pcie_ep_init() shouldn't have any access to DWC registers
> > if the controller is enabled after calling bind(). This moves access codes
> > to DBI/iATU registers and depending variables from dw_pcie_ep_init() to
> > dw_pcie_ep_init_complete().
> 
> Ideally pci_epc_create() should be the last step by the controller driver before
> handing the control to the core EPC framework. Since after this step the EPC
> framework can start invoking the epc_ops.
> 
> Here more stuff is being added to dw_pcie_ep_init_complete() which is required
> for epc_ops and this could result in aborts for platforms which does not add
> core_init_notifier.
> 

Is there a better way to handle this situation? IMO the existing situation is
messy. Assume that if EP is gonna powered separately by an independent power
rail not tied to host PCIe domain (that's the typical endpoint device usecase),
the EP driver will fail to probe due to PHY link not getting stabilized.

So ultimately the board design needs to take care of an extra logic to power the
EP device after powering the host properly and that's not ideal.

Thanks,
Mani

> Thanks,
> Kishon
> 
> > 
> > Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Cc: Vidya Sagar <vidyas@nvidia.com>
> > Fixes: 6bfc9c3a2c70 ("PCI: designware-ep: Move the function of getting MSI capability forward")
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > Acked-by: Om Prakash Singh <omp@nvidia.com>
> > Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 81 +++++++++++++------------
> >  1 file changed, 41 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 998b698..00ce83c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -636,16 +636,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> >  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct dw_pcie_ep_func *ep_func;
> > +	struct device *dev = pci->dev;
> >  	unsigned int offset;
> >  	unsigned int nbars;
> >  	u8 hdr_type;
> > +	u8 func_no;
> > +	void *addr;
> >  	u32 reg;
> >  	int i;
> >  
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
> > +	for (func_no = 0; func_no < ep->epc->max_functions; func_no++) {
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
> >  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
> >  		   PCI_HEADER_TYPE_MASK;
> >  	if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> > -		dev_err(pci->dev,
> > +		dev_err(dev,
> >  			"PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
> >  			hdr_type);
> >  		return -EIO;
> > @@ -674,8 +714,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> >  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  {
> >  	int ret;
> > -	void *addr;
> > -	u8 func_no;
> >  	struct resource *res;
> >  	struct pci_epc *epc;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > @@ -683,7 +721,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct device_node *np = dev->of_node;
> >  	const struct pci_epc_features *epc_features;
> > -	struct dw_pcie_ep_func *ep_func;
> >  
> >  	INIT_LIST_HEAD(&ep->func_list);
> >  
> > @@ -705,8 +742,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		}
> >  	}
> >  
> > -	dw_pcie_iatu_detect(pci);
> > -
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> >  	if (!res)
> >  		return -EINVAL;
> > @@ -714,26 +749,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > @@ -750,20 +765,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > -
> > -		list_add_tail(&ep_func->list, &ep->func_list);
> > -	}
> > -
> >  	if (ep->ops->ep_init)
> >  		ep->ops->ep_init(ep);
> >  
> > 
