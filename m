Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4A76CB27
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjHBKnq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjHBKnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 06:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C552D7B;
        Wed,  2 Aug 2023 03:41:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E6961917;
        Wed,  2 Aug 2023 10:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A357C433C8;
        Wed,  2 Aug 2023 10:41:00 +0000 (UTC)
Date:   Wed, 2 Aug 2023 16:10:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Message-ID: <20230802104049.GB57374@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
 <20230724114005.GL6291@thinkpad>
 <TYBPR01MB5341F4EF6F814E72ABD8FE5ED800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <mjda4qpbqbavvdi26sfdp62kduz3wpsjehaftreja37gssvyqy@n5z3o23rcc7g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mjda4qpbqbavvdi26sfdp62kduz3wpsjehaftreja37gssvyqy@n5z3o23rcc7g>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 01, 2023 at 03:15:41AM +0300, Serge Semin wrote:
> On Wed, Jul 26, 2023 at 03:02:13AM +0000, Yoshihiro Shimoda wrote:
> > Hi Manivannan,
> > 
> > > From: Manivannan Sadhasivam, Sent: Monday, July 24, 2023 8:40 PM
> > > 
> > > On Fri, Jul 21, 2023 at 04:44:45PM +0900, Yoshihiro Shimoda wrote:
> > > > Renesas R-Car Gen4 PCIe controllers require vender-specific
> > > > initialization before .ep_init(). To use dw->dbi and dw->num-lanes
> > > > in the initialization code, introduce .ep_pre_init() into struct
> > > > dw_pcie_ep_ops. Also introduce .ep_deinit() to disable the controller
> > > > by using vender-specific de-initialization.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 ++++++
> > > >  drivers/pci/controller/dwc/pcie-designware.h    | 2 ++
> > > >  2 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 14c641395c3b..52b3e7f67513 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -684,6 +684,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > >  	struct pci_epc *epc = ep->epc;
> > > >
> > > > +	if (ep->ops->ep_deinit)
> > > > +		ep->ops->ep_deinit(ep);
> > > > +
> > > >  	dw_pcie_edma_remove(pci);
> > > >
> > > >  	if (ep->intx_mem)
> > > > @@ -797,6 +800,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  	ep->phys_base = res->start;
> > > >  	ep->addr_size = resource_size(res);
> > > >
> > > > +	if (ep->ops->ep_pre_init)
> > > > +		ep->ops->ep_pre_init(ep);
> > > > +
> > > >  	dw_pcie_version_detect(pci);
> > > >
> > > >  	dw_pcie_iatu_detect(pci);
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index 6821446d7c66..c3aeafd0f4c9 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -332,7 +332,9 @@ struct dw_pcie_rp {
> > > >  };
> > > >
> > > >  struct dw_pcie_ep_ops {
> > > > +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
> > > >  	void	(*ep_init)(struct dw_pcie_ep *ep);
> > > > +	void	(*ep_deinit)(struct dw_pcie_ep *ep);
> > > 
> > > Since the struct name itself has "ep", there is no need to add the "ep" suffix
> > > to callbacks. You should fix the existing ep_init callback too in a separate
> > > patch.
> > 
> 
> > I got it. I'll make such a separate patch before this patch.
> > 
> > Best regards,
> > Yoshihiro Shimoda
> > 
> > > (this series is just GROWING!!!)
> 
> The series indeed gets to be too bulky. What about moving that cleanup
> patch to a separate patchset which Yoshihiro promised to create
> afterwards? Mani?
> 
> Anyway should you provide the init()/deinit() callbacks prefix
> dropping patch it should fix the dw_pcie_host_ops fields too. It also
> has a redundant prefix/suffix. Though it's up to Mani to decide
> whether it should be really done.
> 

I'm fine with a separate cleanup series/patch later.

- Mani

> -Serge(y)
> 
> > > 
> > > - Mani
> > > 
> > > >  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> > > >  			     enum pci_epc_irq_type type, u16 interrupt_num);
> > > >  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> > > > --
> > > > 2.25.1
> > > >
> > > 
> > > --
> > > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
