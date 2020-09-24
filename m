Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014AD277ADC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 22:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIXU6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 16:58:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36636 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXU6C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 16:58:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so607270ljm.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 13:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUQcKqiDOwUz2zTMzeEjHzQX74O2oCYNXMsTTzrVXDo=;
        b=nnW/LUpSwLRV8c8aCOrSaplW5FDsu9L5zfRcO7yUhiiLBc3vF0L3JG8dCiuMYn2CcN
         lRcLj81Ygngu8ZJ9d9H8TfJvytUWwivBMNv4kRgVf3+Iv1tsrEysy9JpU0hzZmrd1tRY
         qYlT8gHoXryw75ULY36r59oRElYM6X14Kmbq/5xH0TJNglhWsyloTpwK31BTDjtMjgr9
         iwH71gDDXF25QM+EeA7Jp+h2da9R1fvXk15atfxY3l4LUZTVXF2JkuvDqwh/fqVoDpSZ
         1Q1i1/PAPmxi9Po2HcUm1LKCsh80+kktFJr4fPBMekoFhyFxmfoZ/z/hI4Zaa2DR0e08
         PS4A==
X-Gm-Message-State: AOAM531vBmjrinLZSbgcSC2JJxy21SerYfVPPSJoh8P0EDmq6YTH0G5A
        DA0C73fS7a4WwDVOVAcmaDQ=
X-Google-Smtp-Source: ABdhPJyPv1OzmL5UmmLc4orwZcGXXCcypokxlluPnk2TiFBzY6pW7DfYUR7MlVqBVMoC61eGvfUf1w==
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr295790ljg.98.1600981079714;
        Thu, 24 Sep 2020 13:57:59 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 193sm338255lfb.212.2020.09.24.13.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 13:57:57 -0700 (PDT)
Date:   Thu, 24 Sep 2020 22:57:56 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        PCI <linux-pci@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Robert Richter <rrichter@marvell.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: Unify ECAM constants in native PCI Express drivers
Message-ID: <20200924205756.GA56768@rocinante>
References: <20200905204416.GA83847@rocinante>
 <20200922232715.GA2238688@bjorn-Precision-5520>
 <CAL_JsqKs2m_echD97C+Q_NFS=yJif0LcgLMdDLnywjz35mboKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqKs2m_echD97C+Q_NFS=yJif0LcgLMdDLnywjz35mboKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn and Rob,

[...]
> > > #define PCIE_ECAM_BUS(x)      (((x) & 0xff) << 20)
> > > #define PCIE_ECAM_DEV(x)      (((x) & 0x1f) << 15)
> > > #define PCIE_ECAM_FUNC(x)     (((x) & 0x7) << 12)
> > >
> > > drivers/pci/controller/dwc/pcie-al.c:
> > >
> > > #define PCIE_ECAM_DEVFN(x)    (((x) & 0xff) << 12)
> > >
> > > I can move PCIE_ECAM_BUS, PCIE_ECAM_DEV and PCIE_ECAM_FUNC (as
> > > PCIE_ECAM_FUN) to the linux/pci-ecam.h file, as these seem useful, but
> > > without the masks, and then update other files to use these.  We could
> > > then leverage these, for example:
> > >
> > >       pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> > > -                                      (busnr_ecam << 20) +
> > > -                                      PCIE_ECAM_DEVFN(devfn));
> > > +                                      PCIE_ECAM_BUS(busnr_ecam) +
> > > +                                      PCIE_ECAM_FUN(devfn));
> > >
> > > What do you think?  Bjorn, would that be acceptable?
> >
> > It would be nice to use the same style and same macros for all of
> > the following, which are all really doing the same thing:
> >
> >   al_pcie_conf_addr_map()
> >     pci_base_addr = (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> >                                      (busnr_ecam << 20) +
> >                                      PCIE_ECAM_DEVFN(devfn));
> >
> >   rockchip_pcie_rd_other_conf()
> >     busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
> >                             PCI_FUNC(devfn), where);
> >
> >   nwl_pcie_map_bus()
> >     relbus = (bus->number << ECAM_BUS_LOC_SHIFT) |
> >                     (devfn << ECAM_DEV_LOC_SHIFT);
> >
> >     return pcie->ecam_base + relbus + where;
> >
> >   xilinx_pcie_map_bus()
> >     relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
> >              (devfn << ECAM_DEV_NUM_SHIFT);
> >
> >     return port->reg_base + relbus + where;
> >
> > Maybe that's something like using PCIE_ECAM_ADDR() everywhere?  I'm
> > not sure there's value in having the caller do the PCI_SLOT() and
> > PCI_FUNC() decomposition, though, i.e., maybe it's something like
> > this?
> >
> >   #define PCIE_ECAM_REG(x)  ((x) & 0xfff)
> >
> >   #define PCI_ECAM_OFFSET(bus, devfn, where) \
> >     PCIE_ECAM_BUS(bus->number) | \
> >     PCIE_ECAM_DEVFN(devfn) | \
> >     PCIE_ECAM_REG(where)
[...]
> LGTM. This was on my radar, but not something I've looked at.
> 
> There's also aardvark which isn't ECAM, but does the same calculation.
> Call it indirect ECAM:
> 
> drivers/pci/controller/pci-aardvark.c:#define PCIE_CONF_BUS(bus)
>                  (((bus) & 0xff) << 20)
> drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_DEV(dev)
>                  (((dev) & 0x1f) << 15)
> drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_FUNC(fun)
>                  (((fun) & 0x7)  << 12)
> drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_REG(reg)
>                  ((reg) & 0xffc)
> drivers/pci/controller/pci-aardvark.c-#define PCIE_CONF_ADDR(bus,
> devfn, where) \
> drivers/pci/controller/pci-aardvark.c-  (PCIE_CONF_BUS(bus) |
> PCIE_CONF_DEV(PCI_SLOT(devfn))    | \
> drivers/pci/controller/pci-aardvark.c-
> PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
> 
> And VMD:
> drivers/pci/controller/vmd.c-   char __iomem *addr = vmd->cfgbar +
> drivers/pci/controller/vmd.c:                        ((bus->number -
> vmd->busn_start) << 20) +
> drivers/pci/controller/vmd.c-                        (devfn << 12) + reg;
> drivers/pci/controller/vmd.c-
> 
> 
> And brcm_pcie_cfg_index().

Thank you both for good feedback!

I will send a v2 later incorporating the feedback and suggestions.

Krzysztof
