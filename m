Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D65B4694F3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbhLFL1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 06:27:11 -0500
Received: from foss.arm.com ([217.140.110.172]:54554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236397AbhLFL1L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 06:27:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 429AE152F;
        Mon,  6 Dec 2021 03:23:42 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADA943F73D;
        Mon,  6 Dec 2021 03:23:40 -0800 (PST)
Date:   Mon, 6 Dec 2021 11:23:35 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: designware-ep: Fix the access to DBI/iATU
 registers before enabling controller
Message-ID: <20211206112335.GA18520@lpieralisi>
References: <1630473361-27198-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com>
 <576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
> Ideally pci_epc_create() should be the last step by the controller
> driver before handing the control to the core EPC framework. Since
> after this step the EPC framework can start invoking the epc_ops.
> 
> Here more stuff is being added to dw_pcie_ep_init_complete() which is
> required for epc_ops and this could result in aborts for platforms
> which does not add core_init_notifier.

This patch needs rework, I will mark the series as "Changes requested".

Lorenzo

> 
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
