Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC77286736
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJGS3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 14:29:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35769 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGS3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 14:29:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id w141so3538396oia.2;
        Wed, 07 Oct 2020 11:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDzHhW9LDGPASDV0QrY0c30B4pdX3NkGe7Qj/I5UDy0=;
        b=MgVnYN5FtrPMV1FrNsS8WNFkAwChEEnaCt7P/DJIG/f5FgERSq1SttDMCuTpPnyEt+
         o34otXXTf1eL4wDwIV9ZcvhY6LvdcRmI2krRSJ/urcPblYFi+Fx/faMvWqVkJixe/pht
         YCnJEHapOq7bX4hc0Wpcqkml0iCeDhIEewslsD25ZAzqUm/t0AnWnU1K2ENdbNQytEZ7
         ZHvcd3D3foIVyU4O38LkFxzmCAG2PPQosr+syrfQAH9l9UCOuwgMw7VBuCKGb1b76geT
         CBQGOPXGg3LTw9+8n45XgCrwEyaiJn9jHDcpwQQFTonfoWXOTd0VlB7amMXi/72q49Cl
         vBAA==
X-Gm-Message-State: AOAM53348ggbcdZyamv+6y1iygQJ6znE7jn+sAX9aT8GWx24c/jAlhjn
        5bjN16zhAZVIb/IbxfJLYDBwkyDjiDUN
X-Google-Smtp-Source: ABdhPJxuO6ZUOxhlR8smJRkNCcIJPWRBNHriJqSRdlivM3fxZMy5dXZSJOQCIb+YblujJ33XhJ1u+w==
X-Received: by 2002:aca:d17:: with SMTP id 23mr2844662oin.9.1602095378349;
        Wed, 07 Oct 2020 11:29:38 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 92sm2201349otl.1.2020.10.07.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:29:37 -0700 (PDT)
Received: (nullmailer pid 497563 invoked by uid 1000);
        Wed, 07 Oct 2020 18:29:36 -0000
Date:   Wed, 7 Oct 2020 13:29:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201007182936.GA470998@bogus>
References: <20200926160934.136182-1-marek.vasut@gmail.com>
 <CAMuHMdURuSsYRwi10FT+s-rVjok0f-FgS6G8rmpg46u98scMkQ@mail.gmail.com>
 <1431d12a-0e19-6795-b2e0-fb652f8a95c1@gmail.com>
 <CAMuHMdWtj=c=y7a2+W10HgYNj3rh2P6nSDd-j4RKKuUiztCxjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWtj=c=y7a2+W10HgYNj3rh2P6nSDd-j4RKKuUiztCxjA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 05, 2020 at 09:31:54AM +0200, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Sun, Oct 4, 2020 at 4:16 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> > On 9/28/20 11:35 AM, Geert Uytterhoeven wrote:
> > [...]
> > >> +static int __init rcar_pcie_init(void)
> > >> +{
> > >> +#ifdef CONFIG_ARM_LPAE
> > >> +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > >> +                       "asynchronous external abort");
> > >> +#else
> > >> +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > >> +                       "imprecise external abort");
> > >> +#endif
> > >
> > > As there can be only a single handler, this may interfere with a handler
> > > for another platform in a multi-platform kernel.
> > > Hence I think this should not be done unconditionally, but be moved to
> > > the driver's .probe() callback.
> >
> > Why is nobody doing this in the probe code then ? It seems all the other
> 
> drivers/pci/controller/dwc/pci-keystone.c is:
> 
>   ks_pcie_probe()
>     ks_pcie_add_pcie_port()
>       dw_pcie_host_init()
>         pp->ops->host_init(pp) = ks_pcie_host_init()
>           hook_fault_code()

Looks broken in deferred probe case as hook_fault_code is __init.

Really, hook_fault_code needs to be exported so these drivers can be 
modules. Or we split out all the abort handlers to a separate broken, 
aborting PCI hosts module.


> > drivers which hook fault code do it in init as well. I can imagine that
> 
> Probably nobody bothered exercising the external abort handler on
> multi-platform kernels?
> 
> > something might trip the fault handler even before probe is called, e.g.
> > some PM handling or simply user accessing that PCIe area using setpci.

I don't see how that's possible. You'd first hit translation faults as 
nothing is mapped.


> If that is the case, it must indeed by done earlier, but still
> conditional on the presence of the actual PCIe controller.

imx6 should be conditional too.

Rob
