Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683CA5856EC
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jul 2022 00:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiG2WoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 18:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiG2WoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 18:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED18C5AA;
        Fri, 29 Jul 2022 15:44:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A456206D;
        Fri, 29 Jul 2022 22:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541C3C433D6;
        Fri, 29 Jul 2022 22:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659134646;
        bh=pl/mRPW10T7FgTE1Cnftxoabm8FSgqBbhJdhJgLAiAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GtoJ+nALFYcIgvNATCEd6beO5y9T4yj42HSBxbgSrLdUhEPu27ykIY4jrzc8q+6C4
         T+La7p+bsiUstMXP9T1OsG8lABmEKat/onBrIz/uM9x5uB0Q801sbX+HSvfWKdd+Q8
         Gjacji2Kk/Bw9WYAT4lJ9+zMkpg2pMiIziTAoy9BsE+JYJR/cqZ5QmGujL8iYFAgKt
         Gyb1GsCIHtmXKaTYHQ327cG3gxjeHx4ZRZecAyuwDVtJ//7eeZ5uBgC3KGCBGFYQIn
         2TY8r3jXTgh0hNgTUKexp1Gmpo+RSpxHaSCKAhA1UrO+RhfHC+IWCurvDFYYmjFRl1
         wffS6WC40dVsw==
Date:   Fri, 29 Jul 2022 17:44:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220729224404.GA478920@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Xiaowei (author of 6bfc9c3a2c70), Hou (author of 8bcca2658558)]

On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
> On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> > On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> > > Platforms that cannot support their core initialization without the
> > > reference clock from the host, implement the feature 'core_init_notifier'
> > > to indicate the DesignWare sub-system about when their core is getting
> > > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > > core to dw_pcie_ep_init_complete() API which is effectively called only
> > > after the core initialization.
> > 
> > I assume this is still broken.  I want to fix it.  I assume this patch
> > fixes it and there are no known problems with it.  I assume this can
> > be fixed so it works on all platforms, whether they use
> > core_init_notifier or not.
>
> Yes. All your assumptions are correct.
> 
> > I'd like the commit log to be specific about where the hang occurs so
> > it's easy for a non-DesignWare expert (me!) to see the problem.  E.g.,
> > on tegra194, X depends on Y, but Y is initialized after X.  Say
> > specifically what functions X and Y are.
>
> X = DBI accesses
> Y = Core initialization which in turn depends on the REFCLK from the host
> 
> Without this patch, hang happens when DBI registers are accessed without
> core being initialized. In the case of Tegra194 at least, core gets
> initialized only after REFCLK is available from the host. The way we make
> sure that the REFCLK is available from the host is by checking for PERST#
> de-assertion interrupt. (PCIe spec mandates that the host must supply REFCLK
> before de-asserting PERST# signal).
> This patch prevents any accesses to the DBI/Core registers if the platform
> says that it supports core_init_notifier.

There are several commits involved in this, oldest to newest:

  e966f7390da9 ("PCI: dwc: Refactor core initialization code for EP mode")
    Split EP initialization into dw_pcie_ep_init() (which doesn't
    touch core registers) and dw_pcie_ep_init_complete() (which does).

    dw_pcie_ep_init
      of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows)
      ep->ib_window_map = devm_kcalloc(..., ep->num_ib_windows, ...)
      dw_pcie_ep_init_complete        # core regs are available
        dw_pcie_readb_dbi             # <-- read core regs

  6bfc9c3a2c70 ("PCI: designware-ep: Move the function of getting MSI capability forward")
    Move MSI capability lookup from dw_pcie_ep_init_complete() to
    dw_pcie_ep_init().

    dw_pcie_ep_init
      dw_pcie_find_capability(pci, PCI_CAP_ID_MSI)
        dw_pcie_readw_dbi             # <-- read core regs
      dw_pcie_ep_init_complete        # core regs are available

    This is broken because we access the DBI registers before the core
    is initialized.

  281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
    Read num_ib_windows from iATU registers instead of from DT
    property.

    dw_pcie_ep_init
      ib_window_map = devm_kcalloc(..., pci->num_ib_windows, ...)  # use
      dw_pcie_ep_init_complete
        dw_pcie_setup
          dw_pcie_iatu_detect_regions
            dw_pcie_readl_dbi
            pci->num_ib_windows = ib                               # init

    This ordering is broken because we use pci->num_ib_windows before
    we initialize it.

  8bcca2658558 ("PCI: dwc: Move iATU detection earlier")
    Fix the use-before-init problem by moving init earlier:

    dw_pcie_ep_init
      dw_pcie_iatu_detect
        dw_pcie_readl_dbi             # <-- read core regs
        pci->num_ib_windows = ib                                   # init
      ib_window_map = devm_kcalloc(..., pci->num_ib_windows, ...)  # use
      dw_pcie_ep_init_complete        # core regs are available
        dw_pcie_setup

    This fixed the use-before-init, but it causes the hang by
    accessing the DBI registers before the core is initialized.

This patch addresses the problems of 6bfc9c3a2c70 and 8bcca2658558 by
moving dw_pcie_iatu_detect() and dw_pcie_ep_find_capability() from
dw_pcie_ep_init() to dw_pcie_ep_init_complete().

We probably need Fixes: tags for both.

But I don't think this patch is enough, and I have a lot of questions:

  1) The "core_init_notifier" mechanism is kind of obtuse.  IIUC, any
     driver that sets ".core_init_notifier = true" is responsible for
     calling dw_pcie_ep_init_complete() at some point.  But that's not
     explicit at all in the code.  There's no "notifier" involved.  I
     suppose the idea is that the *interrupt* is the notifier, but the
     naming doesn't help connect things.

  2) I still want to know exactly where (what function) the critical
     transition that enables DBI access is.  I guess it's
     qcom_pcie_perst_deassert() for qcom and
     pex_ep_event_pex_rst_deassert() for tegra?  And for drivers that
     don't set .core_init_notifier, DBI is accessible any time in
     dw_pcie_ep_init() or later?

  3) How do these interrupt handlers work?  I'm used to the model of:

       Install interrupt handler
       Do something to the device so it will generate an interrupt
       Later, the device generates the interrupt
       Execute the interrupt handler

     We register tegra_pcie_ep_pex_rst_irq() as an interrupt handler,
     but what touches the device and starts the process that causes
     the interrupt?

  4) 6bfc9c3a2c70 moved the MSI capability lookup to dw_pcie_ep_init()
     because .ep_init() functions, e.g., ls_pcie_ep_init(), depend on
     ep_func->msi_cap.  Moving the MSI lookup to
     dw_pcie_ep_init_complete() will break that again, won't it?

  5) dw_pcie_ep_init() calls ep->ops->ep_init(ep), and almost all of
     those .ep_init() methods, e.g., dra7xx_pcie_ep_init(),
     ls_pcie_ep_init(), etc., call dw_pcie_ep_reset_bar(), which does
     DBI writes.  These are before dw_pcie_ep_init_complete(), so they
     are broken per the design (though they probably *work* because
     the drivers don't set .core_init_notifier, so DBI accesses
     probably work earlier).

     The only .ep_init() in a driver that sets .core_init_notifier is
     qcom_pcie_ep_init().  That *looks* like it should actually be
     broken because it runs before dw_pcie_ep_init_complete().

  6) What's going on with the CORE_INIT and LINK_UP notifiers?
     dw_pcie_ep_init_notify() is only called by qcom and tegra.
     dw_pcie_ep_linkup() is only called by dra7xx, qcom, and tegra.
     As far as I can tell, nobody at all registers to handle those
     events except a test.  I think it's pointless to have that code
     if nobody uses it.

> > > ---
> > >   .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
> > >   1 file changed, 49 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 0eda8236c125..9feec720175f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
> > >   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > >   {
> > >        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +     struct dw_pcie_ep_func *ep_func;
> > > +     struct device *dev = pci->dev;
> > > +     struct pci_epc *epc = ep->epc;
> > >        unsigned int offset;
> > >        unsigned int nbars;
> > >        u8 hdr_type;
> > > +     u8 func_no;
> > > +     void *addr;
> > >        u32 reg;
> > >        int i;
> > > 
> > > @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> > >                return -EIO;
> > >        }
> > > 
> > > +     dw_pcie_iatu_detect(pci);
> > > +
> > > +     ep->ib_window_map = devm_kcalloc(dev,
> > > +                                      BITS_TO_LONGS(pci->num_ib_windows),
> > > +                                      sizeof(long),
> > > +                                      GFP_KERNEL);
> > > +     if (!ep->ib_window_map)
> > > +             return -ENOMEM;
> > > +
> > > +     ep->ob_window_map = devm_kcalloc(dev,
> > > +                                      BITS_TO_LONGS(pci->num_ob_windows),
> > > +                                      sizeof(long),
> > > +                                      GFP_KERNEL);
> > > +     if (!ep->ob_window_map)
> > > +             return -ENOMEM;
> > > +
> > > +     addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > +                         GFP_KERNEL);
> > > +     if (!addr)
> > > +             return -ENOMEM;
> > > +     ep->outbound_addr = addr;
> > > +
> > > +     for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > +             ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > +             if (!ep_func)
> > > +                     return -ENOMEM;
> > > +
> > > +             ep_func->func_no = func_no;
> > > +             ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > +                                                           PCI_CAP_ID_MSI);
> > > +             ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > +                                                            PCI_CAP_ID_MSIX);
> > > +
> > > +             list_add_tail(&ep_func->list, &ep->func_list);
> > > +     }
> > > +
> > >        offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > > 
> > >        dw_pcie_dbi_ro_wr_en(pci);
> > > @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> > >   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >   {
> > >        int ret;
> > > -     void *addr;
> > > -     u8 func_no;
> > >        struct resource *res;
> > >        struct pci_epc *epc;
> > >        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >        struct platform_device *pdev = to_platform_device(dev);
> > >        struct device_node *np = dev->of_node;
> > >        const struct pci_epc_features *epc_features;
> > > -     struct dw_pcie_ep_func *ep_func;
> > > 
> > >        INIT_LIST_HEAD(&ep->func_list);
> > > 
> > > @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >                }
> > >        }
> > > 
> > > -     dw_pcie_iatu_detect(pci);
> > > -
> > >        res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> > >        if (!res)
> > >                return -EINVAL;
> > > @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >        ep->phys_base = res->start;
> > >        ep->addr_size = resource_size(res);
> > > 
> > > -     ep->ib_window_map = devm_kcalloc(dev,
> > > -                                      BITS_TO_LONGS(pci->num_ib_windows),
> > > -                                      sizeof(long),
> > > -                                      GFP_KERNEL);
> > > -     if (!ep->ib_window_map)
> > > -             return -ENOMEM;
> > > -
> > > -     ep->ob_window_map = devm_kcalloc(dev,
> > > -                                      BITS_TO_LONGS(pci->num_ob_windows),
> > > -                                      sizeof(long),
> > > -                                      GFP_KERNEL);
> > > -     if (!ep->ob_window_map)
> > > -             return -ENOMEM;
> > > -
> > > -     addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> > > -                         GFP_KERNEL);
> > > -     if (!addr)
> > > -             return -ENOMEM;
> > > -     ep->outbound_addr = addr;
> > > -
> > >        if (pci->link_gen < 1)
> > >                pci->link_gen = of_pci_get_max_link_speed(np);
> > > 
> > > @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >        if (ret < 0)
> > >                epc->max_functions = 1;
> > > 
> > > -     for (func_no = 0; func_no < epc->max_functions; func_no++) {
> > > -             ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> > > -             if (!ep_func)
> > > -                     return -ENOMEM;
> > > -
> > > -             ep_func->func_no = func_no;
> > > -             ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > -                                                           PCI_CAP_ID_MSI);
> > > -             ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> > > -                                                            PCI_CAP_ID_MSIX);
> > > -
> > > -             list_add_tail(&ep_func->list, &ep->func_list);
> > > -     }
> > > -
> > >        if (ep->ops->ep_init)
> > >                ep->ops->ep_init(ep);
> > > 
> > > @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >                        return 0;
> > >        }
> > > 
> > > +     /*
> > > +      * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> > > +      * step as platforms that implement 'core_init_notifier' feature may
> > > +      * not have the hardware ready (i.e. core initialized) for access
> > > +      * (Ex: tegra194). Any hardware access on such platforms result
> > > +      * in system hard hang.
> > > +      */
> > > +
> > >        return dw_pcie_ep_init_complete(ep);
> > >   }
> > >   EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > > --
> > > 2.17.1
> > > 
