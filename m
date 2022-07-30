Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92153585ADA
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jul 2022 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiG3Ouh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Jul 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiG3Oug (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jul 2022 10:50:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF818355
        for <linux-pci@vger.kernel.org>; Sat, 30 Jul 2022 07:50:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so6167910pgb.4
        for <linux-pci@vger.kernel.org>; Sat, 30 Jul 2022 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DrncD3onKxZF5yhems+JHbQznjyNcw1aP3dIQ3WpAPI=;
        b=DthVpUpC22v5on9byDrgwsxaDfuYChPOHTmSva2C7kQvwit/lVU1pxUgyzHE8pAQH+
         aXdtOkSw0fYAUJuCnpo1lKuGa2/Q79RIxQRQAqOInakFpr0EpESRYvuHGmNkxakuj+Vp
         63BD3t22z8e4tN57r2vMRc2H2dMxgZjuYcLyaHFpJZC+Cv6EnEDd6mbQyOY6WeS/WwXF
         qAFv2f5VHEpW1BLWkNU5G1mt9ghhvUGuLj/jOqnTBDXAt4TMBxhMj/9dhvhjCtrrrx0T
         7O+yc4wfS+e5IBsHKU1eY3Ou5El1FGcXwpjqIPET/aHtH04afnRwwJemhGh/7WM4u+wJ
         TqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DrncD3onKxZF5yhems+JHbQznjyNcw1aP3dIQ3WpAPI=;
        b=8R1xw4XAQ2jZf5akOI6DvaDJ+PXylzhQOnbk3yGhS2CgZ68qMmCEZgSpC3mQrcsy+F
         aivzHOkGAL7oA4TO/Mei6M553QwJANIUPQ/f9DuP0hdHZTkokzNsLecBVTWSZoN9OVIg
         9fWfpBAwGe+jLmOR3fYIkSe8U1rGcrvI30JIHS4sfF34oZAYfNC6S/Xoe/Ua93fyKywc
         r/AWFskgVhuO29lrLbaXrQAitxzXDuo0oH7Jr840sLruNTcE4zXNN0xbcBoKzH1rVQYO
         NxFVaP0RSvRjkD8g5i5SZcpm+8GSXjKlf420LyDP6OMnqTQe2bKw+q3OGPxay0aE2xrA
         D+ow==
X-Gm-Message-State: AJIora+T+EXKbE9S3/LY1ZNlZ3hgqCyWYxbcJtcTqIj/EsiwvpZS8G2r
        SgJDP06u+F8aj/3dpy904Al6
X-Google-Smtp-Source: AGRyM1sgi7Lwjc0XMlmGOILKZz47/JtwTAexMGJcdfcjGAq2MVh2zhSGNcxDtUNippxNlfxoe5KgBg==
X-Received: by 2002:a05:6a00:1745:b0:52a:f0d3:ae7 with SMTP id j5-20020a056a00174500b0052af0d30ae7mr8644017pfc.72.1659192633852;
        Sat, 30 Jul 2022 07:50:33 -0700 (PDT)
Received: from thinkpad ([117.207.28.107])
        by smtp.gmail.com with ESMTPSA id n5-20020a170903110500b0016d3935eff0sm5902018plh.176.2022.07.30.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 07:50:33 -0700 (PDT)
Date:   Sat, 30 Jul 2022 20:20:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220730145025.GA4005@thinkpad>
References: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
 <20220729224404.GA478920@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729224404.GA478920@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 29, 2022 at 05:44:04PM -0500, Bjorn Helgaas wrote:
> [+cc Xiaowei (author of 6bfc9c3a2c70), Hou (author of 8bcca2658558)]
> 
> On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
> > On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> > > On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> > > > Platforms that cannot support their core initialization without the
> > > > reference clock from the host, implement the feature 'core_init_notifier'
> > > > to indicate the DesignWare sub-system about when their core is getting
> > > > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > > > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > > > core to dw_pcie_ep_init_complete() API which is effectively called only
> > > > after the core initialization.
> > > 
> > > I assume this is still broken.  I want to fix it.  I assume this patch
> > > fixes it and there are no known problems with it.  I assume this can
> > > be fixed so it works on all platforms, whether they use
> > > core_init_notifier or not.
> >
> > Yes. All your assumptions are correct.
> > 
> > > I'd like the commit log to be specific about where the hang occurs so
> > > it's easy for a non-DesignWare expert (me!) to see the problem.  E.g.,
> > > on tegra194, X depends on Y, but Y is initialized after X.  Say
> > > specifically what functions X and Y are.
> >
> > X = DBI accesses
> > Y = Core initialization which in turn depends on the REFCLK from the host
> > 
> > Without this patch, hang happens when DBI registers are accessed without
> > core being initialized. In the case of Tegra194 at least, core gets
> > initialized only after REFCLK is available from the host. The way we make
> > sure that the REFCLK is available from the host is by checking for PERST#
> > de-assertion interrupt. (PCIe spec mandates that the host must supply REFCLK
> > before de-asserting PERST# signal).
> > This patch prevents any accesses to the DBI/Core registers if the platform
> > says that it supports core_init_notifier.
> 
> There are several commits involved in this, oldest to newest:
> 
>   e966f7390da9 ("PCI: dwc: Refactor core initialization code for EP mode")
>     Split EP initialization into dw_pcie_ep_init() (which doesn't
>     touch core registers) and dw_pcie_ep_init_complete() (which does).
> 
>     dw_pcie_ep_init
>       of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows)
>       ep->ib_window_map = devm_kcalloc(..., ep->num_ib_windows, ...)
>       dw_pcie_ep_init_complete        # core regs are available
>         dw_pcie_readb_dbi             # <-- read core regs
> 
>   6bfc9c3a2c70 ("PCI: designware-ep: Move the function of getting MSI capability forward")
>     Move MSI capability lookup from dw_pcie_ep_init_complete() to
>     dw_pcie_ep_init().
> 
>     dw_pcie_ep_init
>       dw_pcie_find_capability(pci, PCI_CAP_ID_MSI)
>         dw_pcie_readw_dbi             # <-- read core regs
>       dw_pcie_ep_init_complete        # core regs are available
> 
>     This is broken because we access the DBI registers before the core
>     is initialized.
> 
>   281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
>     Read num_ib_windows from iATU registers instead of from DT
>     property.
> 
>     dw_pcie_ep_init
>       ib_window_map = devm_kcalloc(..., pci->num_ib_windows, ...)  # use
>       dw_pcie_ep_init_complete
>         dw_pcie_setup
>           dw_pcie_iatu_detect_regions
>             dw_pcie_readl_dbi
>             pci->num_ib_windows = ib                               # init
> 
>     This ordering is broken because we use pci->num_ib_windows before
>     we initialize it.
> 
>   8bcca2658558 ("PCI: dwc: Move iATU detection earlier")
>     Fix the use-before-init problem by moving init earlier:
> 
>     dw_pcie_ep_init
>       dw_pcie_iatu_detect
>         dw_pcie_readl_dbi             # <-- read core regs
>         pci->num_ib_windows = ib                                   # init
>       ib_window_map = devm_kcalloc(..., pci->num_ib_windows, ...)  # use
>       dw_pcie_ep_init_complete        # core regs are available
>         dw_pcie_setup
> 
>     This fixed the use-before-init, but it causes the hang by
>     accessing the DBI registers before the core is initialized.
> 
> This patch addresses the problems of 6bfc9c3a2c70 and 8bcca2658558 by
> moving dw_pcie_iatu_detect() and dw_pcie_ep_find_capability() from
> dw_pcie_ep_init() to dw_pcie_ep_init_complete().
> 
> We probably need Fixes: tags for both.
> 

That sounds right to me.

> But I don't think this patch is enough, and I have a lot of questions:
> 
>   1) The "core_init_notifier" mechanism is kind of obtuse.  IIUC, any
>      driver that sets ".core_init_notifier = true" is responsible for
>      calling dw_pcie_ep_init_complete() at some point.  But that's not
>      explicit at all in the code.  There's no "notifier" involved.  I
>      suppose the idea is that the *interrupt* is the notifier, but the
>      naming doesn't help connect things.

The actual notifier is used *inside* the interrupt handler.
dw_pcie_ep_init_notify(). This notifies the EPF drivers.

LINK_UP notifier is used with dw_pcie_ep_linkup().

> 
>   2) I still want to know exactly where (what function) the critical
>      transition that enables DBI access is.  I guess it's
>      qcom_pcie_perst_deassert() for qcom and
>      pex_ep_event_pex_rst_deassert() for tegra?  And for drivers that
>      don't set .core_init_notifier, DBI is accessible any time in
>      dw_pcie_ep_init() or later?
> 

On the Qcom platforms, qcom_pcie_enable_resources() is what enabling all
resources required for DBI access. This function turns ON clocks, brings the
endpoint IP block out of reset and turns ON the PHY. The last step (turning
ON the PHY) requires active refclk from the host.

So with mainline pcie-qcom-ep driver, the PCIe host should be active by the
time the ep driver probes. Then only refclk will be active and phy_power_on()
will succeed. Now, this creates a hard dependency with the PCIe host even for
ep driver probing (remember the phy_power_on() gets called during probe time),
and this order won't work if we'd like to use the pcie-qcom-ep driver in a
standalone product like a PCIe modem, where the modem would power up
independently of the PCIe host.

And this is the reason, *I* wanted to move all the DBI access to
dw_pcie_ep_init_complete(), so that the ep driver can probe successfully
independent of the host and becomes operational when the PCIe host comes up
and deasserts the PERST#.

I have mentioned this in my version of the patch:
https://lore.kernel.org/lkml/20220330060515.22328-1-manivannan.sadhasivam@linaro.org/

The reason why I decided to use core_init_notifier in the first place was, it
ensures that the endpoint gets initialized only when the PCIe host de-asserts
the PERST# signal. And this behaviour matches the PCIe spec.

>   3) How do these interrupt handlers work?  I'm used to the model of:
> 
>        Install interrupt handler
>        Do something to the device so it will generate an interrupt
>        Later, the device generates the interrupt
>        Execute the interrupt handler
> 
>      We register tegra_pcie_ep_pex_rst_irq() as an interrupt handler,
>      but what touches the device and starts the process that causes
>      the interrupt?
> 
>   4) 6bfc9c3a2c70 moved the MSI capability lookup to dw_pcie_ep_init()
>      because .ep_init() functions, e.g., ls_pcie_ep_init(), depend on
>      ep_func->msi_cap.  Moving the MSI lookup to
>      dw_pcie_ep_init_complete() will break that again, won't it?
> 

Good catch! Yes, it will break the NXP driver. But the rest of the ep drivers
set the msi{x}_capable flags statically and this information should be known
beforehand IMO.

>   5) dw_pcie_ep_init() calls ep->ops->ep_init(ep), and almost all of
>      those .ep_init() methods, e.g., dra7xx_pcie_ep_init(),
>      ls_pcie_ep_init(), etc., call dw_pcie_ep_reset_bar(), which does
>      DBI writes.  These are before dw_pcie_ep_init_complete(), so the
>      are broken per the design (though they probably *work* because
>      the drivers don't set .core_init_notifier, so DBI accesses
>      probably work earlier).
> 
>      The only .ep_init() in a driver that sets .core_init_notifier is
>      qcom_pcie_ep_init().  That *looks* like it should actually be
>      broken because it runs before dw_pcie_ep_init_complete().

As per my above justification, it is not broken technically.

> 
>   6) What's going on with the CORE_INIT and LINK_UP notifiers?
>      dw_pcie_ep_init_notify() is only called by qcom and tegra.
>      dw_pcie_ep_linkup() is only called by dra7xx, qcom, and tegra.
>      As far as I can tell, nobody at all registers to handle those
>      events except a test.  I think it's pointless to have that code
>      if nobody uses it.
>

I have submitted an actual driver that makes use of these notifiers:
https://lore.kernel.org/lkml/20220502060611.58987-9-manivannan.sadhasivam@linaro.org/

Thanks,
Mani

> > > > ---
> > > >   .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
> > > >   1 file changed, 49 insertions(+), 39 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 0eda8236c125..9feec720175f 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > > >   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > > >   {
> > > >        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > +     struct dw_pcie_ep_func *ep_func;
> > > > +     struct device *dev = pci->dev;
> > > > +     struct pci_epc *epc = ep->epc;
> > > >        unsigned int offset;
> > > >        unsigned int nbars;
> > > >        u8 hdr_type;
> > > > +     u8 func_no;
> > > > +     void *addr;
> > > >        u32 reg;
> > > >        int i;
> > > > 
> > > > @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > > >                return -EIO;
> > > >        }
> > > > 
> > > > +     dw_pcie_iatu_detect(pci);
> > > > +
> > > > +     ep->ib_window_map = devm_kcalloc(dev,
> > > > +                                      BITS_TO_LONGS(pci->num_ib_windows),
> > > > +                                      sizeof(long),
> > > > +                                      GFP_KERNEL);
> > > > +     if (!ep->ib_window_map)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     ep->ob_window_map = devm_kcalloc(dev,
> > > > +                                      BITS_TO_LONGS(pci->num_ob_windows),
> > > > +                                      sizeof(long),
> > > > +                                      GFP_KERNEL);
> > > > +     if (!ep->ob_window_map)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > > +                         GFP_KERNEL);
> > > > +     if (!addr)
> > > > +             return -ENOMEM;
> > > > +     ep->outbound_addr = addr;
> > > > +
> > > > +     for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > > +             ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > > +             if (!ep_func)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             ep_func->func_no = func_no;
> > > > +             ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > +                                                           PCI_CAP_ID_MSI);
> > > > +             ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > +                                                            PCI_CAP_ID_MSIX);
> > > > +
> > > > +             list_add_tail(&ep_func->list, &ep->func_list);
> > > > +     }
> > > > +
> > > >        offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > > > 
> > > >        dw_pcie_dbi_ro_wr_en(pci);
> > > > @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> > > >   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >   {
> > > >        int ret;
> > > > -     void *addr;
> > > > -     u8 func_no;
> > > >        struct resource *res;
> > > >        struct pci_epc *epc;
> > > >        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >        struct platform_device *pdev = to_platform_device(dev);
> > > >        struct device_node *np = dev->of_node;
> > > >        const struct pci_epc_features *epc_features;
> > > > -     struct dw_pcie_ep_func *ep_func;
> > > > 
> > > >        INIT_LIST_HEAD(&ep->func_list);
> > > > 
> > > > @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >                }
> > > >        }
> > > > 
> > > > -     dw_pcie_iatu_detect(pci);
> > > > -
> > > >        res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> > > >        if (!res)
> > > >                return -EINVAL;
> > > > @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >        ep->phys_base = res->start;
> > > >        ep->addr_size = resource_size(res);
> > > > 
> > > > -     ep->ib_window_map = devm_kcalloc(dev,
> > > > -                                      BITS_TO_LONGS(pci->num_ib_windows),
> > > > -                                      sizeof(long),
> > > > -                                      GFP_KERNEL);
> > > > -     if (!ep->ib_window_map)
> > > > -             return -ENOMEM;
> > > > -
> > > > -     ep->ob_window_map = devm_kcalloc(dev,
> > > > -                                      BITS_TO_LONGS(pci->num_ob_windows),
> > > > -                                      sizeof(long),
> > > > -                                      GFP_KERNEL);
> > > > -     if (!ep->ob_window_map)
> > > > -             return -ENOMEM;
> > > > -
> > > > -     addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > > -                         GFP_KERNEL);
> > > > -     if (!addr)
> > > > -             return -ENOMEM;
> > > > -     ep->outbound_addr = addr;
> > > > -
> > > >        if (pci->link_gen < 1)
> > > >                pci->link_gen = of_pci_get_max_link_speed(np);
> > > > 
> > > > @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >        if (ret < 0)
> > > >                epc->max_functions = 1;
> > > > 
> > > > -     for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > > -             ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > > -             if (!ep_func)
> > > > -                     return -ENOMEM;
> > > > -
> > > > -             ep_func->func_no = func_no;
> > > > -             ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > -                                                           PCI_CAP_ID_MSI);
> > > > -             ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > > -                                                            PCI_CAP_ID_MSIX);
> > > > -
> > > > -             list_add_tail(&ep_func->list, &ep->func_list);
> > > > -     }
> > > > -
> > > >        if (ep->ops->ep_init)
> > > >                ep->ops->ep_init(ep);
> > > > 
> > > > @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >                        return 0;
> > > >        }
> > > > 
> > > > +     /*
> > > > +      * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> > > > +      * step as platforms that implement 'core_init_notifier' feature may
> > > > +      * not have the hardware ready (i.e. core initialized) for access
> > > > +      * (Ex: tegra194). Any hardware access on such platforms result
> > > > +      * in system hard hang.
> > > > +      */
> > > > +
> > > >        return dw_pcie_ep_init_complete(ep);
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > > > --
> > > > 2.17.1
> > > > 

-- 
மணிவண்ணன் சதாசிவம்
