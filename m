Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C233A306233
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 18:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbhA0Rhu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 12:37:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343711AbhA0RhM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 12:37:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 302FF64DAD;
        Wed, 27 Jan 2021 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611768991;
        bh=xPPYeS8RgTbH6m2KaElCiQqXoxTl8PfHtu7YhvH5PVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oBTl0XpT9oEcyg8xXeTkEBk299yvLhFS/OjGvzYFkBoaBAH44uF2yt11nU9RzETWN
         sTbtKI4Xh2MGCAXJTxQv+D00gQFs1ZT/kTqOg/xqpOaLRVE3fcKs0R7yXEl6P6/dVC
         62FK4NTmrLD+rSnkDJRt7jG3mx4Nxuz84YEh3qBeXU4R2q2bB9jDzkBaTLpGWsgpM8
         TthckL4y96pgoLGf+AswoEFrVuMnfAqmLjMQ+1fkGg3GK0fWRuirpfSAPYLONqJLHV
         gOXmz01v5z0FlnkUgO4NLV1+wnYsIScocQ2jZZ25gaOKy7eI7qm0YoUiBm6VWC81CB
         4JhHXmJ3MvQ7g==
Received: by mail-ej1-f43.google.com with SMTP id g3so3824194ejb.6;
        Wed, 27 Jan 2021 09:36:31 -0800 (PST)
X-Gm-Message-State: AOAM530GF1wcKouKCaDBtsotnuzZYtxAGsMeJbVDQ6R30cNP/STWSBkx
        1I2vHUl6yTlRgOdDCGcUb+1Z9NLrovqaKlIS0w==
X-Google-Smtp-Source: ABdhPJwE05PAYH7KnUHJXOkOgtbUgUL0QlDpzJJHvHFxcbgledtd80aF6K0pJvt369Zw11dGEv8ReHApo/fGLcsBOqE=
X-Received: by 2002:a17:906:a94:: with SMTP id y20mr7301878ejf.525.1611768989608;
 Wed, 27 Jan 2021 09:36:29 -0800 (PST)
MIME-Version: 1.0
References: <1611223156-8787-1-git-send-email-bharat.kumar.gogada@xilinx.com> <20210121162827.GA2658969@bjorn-Precision-5520>
In-Reply-To: <20210121162827.GA2658969@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Jan 2021 11:36:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJET2A5Ob+s=pOewhpfvLxbUH5cLD9_=NE_e73XbjW53g@mail.gmail.com>
Message-ID: <CAL_JsqJET2A5Ob+s=pOewhpfvLxbUH5cLD9_=NE_e73XbjW53g@mail.gmail.com>
Subject: Re: [PATCH] PCI: xilinx-nwl: Enable coherenct PCIe traffic using CCI
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 10:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rob]
>
> s/coherenct/coherent/ in subject
> s/traffic/DMA/ (this applies specifically to DMA, not to MMIO)
>
> On Thu, Jan 21, 2021 at 03:29:16PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for routing PCIe traffic coherently when
> >  Cache Coherent Interconnect(CCI) is enabled in the system.
>
> s/- Add/Add/
> s/Interconnect(CCI)/Interconnect (CCI)/
>
> Can you include a URL to a CCI spec?  I'm not familiar with it.  I
> guess this is something upstream from the host bridge, i.e., between
> the CPU and the host bridge, so it's outside the PCI domain?
>
> I'd like to mention the DT "dma-coherent" property in the commit log
> to help connect this with the knob that controls it.
>
> The "dma-coherent" property is mentioned several places in
> Documentation/devicetree/bindings/pci/ (but not anything obviously
> related to xilinx-nwl).  Should it be moved to something like
> Documentation/devicetree/bindings/pci/pci.txt to make it more generic?

It is generic (beyond PCI), but needs to be documented as used in each
PCI host binding. Don't need any more than 'dma-coherent: true'.

>
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 07e3666..08e06057 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -26,6 +26,7 @@
> >
> >  /* Bridge core config registers */
> >  #define BRCFG_PCIE_RX0                       0x00000000
> > +#define BRCFG_PCIE_RX1                       0x00000004
> >  #define BRCFG_INTERRUPT                      0x00000010
> >  #define BRCFG_PCIE_RX_MSG_FILTER     0x00000020
> >
> > @@ -128,6 +129,7 @@
> >  #define NWL_ECAM_VALUE_DEFAULT               12
> >
> >  #define CFG_DMA_REG_BAR                      GENMASK(2, 0)
> > +#define CFG_PCIE_CACHE                       GENMASK(7, 0)
> >
> >  #define INT_PCI_MSI_NR                       (2 * 32)
> >
> > @@ -675,6 +677,12 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> >       nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> >                         BRCFG_PCIE_RX_MSG_FILTER);
> >
> > +     /* This routes the PCIe DMA traffic to go through CCI path */
> > +     if (of_dma_is_coherent(dev->of_node)) {
> > +             nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
> > +                               CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> > +     }
> > +
> >       err = nwl_wait_for_link(pcie);
> >       if (err)
> >               return err;
> > --
> > 2.7.4
> >
