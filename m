Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27CD283181
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgJEIH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 04:07:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36173 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIH3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 04:07:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id 60so7790122otw.3;
        Mon, 05 Oct 2020 01:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjOaJs8tKfCAg5C+o37LhwA6Bc/GwY1ErSVcBYhWJ/0=;
        b=fY7UQMCcFE3qROUGtZa9wCgwYj7a7HOvLm6P23TWT5LVwtcHSJ9Bi61DQoegnEPsBV
         G/rhS4l9POlqYcSQq0gEFjcasEeP993gyGu6pwADnpA1yJ7L2pDcgDToEMztKvMGgZDD
         a63r1OwFORUN8NML/QZjovv2efoJKqm9IbCCPYECBa/yofeSefN6g9YRA/aAZMpae/uc
         s7e73S+c53LKmkjB0a/9U/EUrjLKwB2RTywuSsowiODFtXKxLJ9oif3XdA3/ojvzcg0N
         RDKBDWa+Y/a2XWEgR5XfMJ5dr2X5hajFUwJfmX9BQ/W3W/Xr6izQVZlOTwiy9Hw5EssS
         wqJQ==
X-Gm-Message-State: AOAM5324/0rWhX6J27KHpomySJyxWIhQdkjZrugSo59oaFfFPSwHPAd9
        mUC6YRFKVtS1oqK/NbjgNsHbU8xGvH4lfmXGCAo=
X-Google-Smtp-Source: ABdhPJxcR0HZM1t7KE89hNSWoiP2xYg44MGLLJZ7oPsamy+8qPenNnf7G1fCtdVG3XfsqisKUzWBezAkVXLWI/5it/E=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr10157331otp.107.1601885248054;
 Mon, 05 Oct 2020 01:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200926160934.136182-1-marek.vasut@gmail.com>
 <CAMuHMdURuSsYRwi10FT+s-rVjok0f-FgS6G8rmpg46u98scMkQ@mail.gmail.com>
 <1431d12a-0e19-6795-b2e0-fb652f8a95c1@gmail.com> <CAMuHMdWtj=c=y7a2+W10HgYNj3rh2P6nSDd-j4RKKuUiztCxjA@mail.gmail.com>
 <668471a3-af14-e083-bed9-722015546830@gmail.com>
In-Reply-To: <668471a3-af14-e083-bed9-722015546830@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Oct 2020 10:07:16 +0200
Message-ID: <CAMuHMdWxPNC32ns_+mUiEtebhk0od0qcSW=do_Fmu_HrBnJoww@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Mon, Oct 5, 2020 at 10:00 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 10/5/20 9:31 AM, Geert Uytterhoeven wrote:
> > On Sun, Oct 4, 2020 at 4:16 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On 9/28/20 11:35 AM, Geert Uytterhoeven wrote:
> >> [...]
> >>>> +static int __init rcar_pcie_init(void)
> >>>> +{
> >>>> +#ifdef CONFIG_ARM_LPAE
> >>>> +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> >>>> +                       "asynchronous external abort");
> >>>> +#else
> >>>> +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> >>>> +                       "imprecise external abort");
> >>>> +#endif
> >>>
> >>> As there can be only a single handler, this may interfere with a handler
> >>> for another platform in a multi-platform kernel.
> >>> Hence I think this should not be done unconditionally, but be moved to
> >>> the driver's .probe() callback.
> >>
> >> Why is nobody doing this in the probe code then ? It seems all the other
> >
> > drivers/pci/controller/dwc/pci-keystone.c is:
> >
> >   ks_pcie_probe()
> >     ks_pcie_add_pcie_port()
> >       dw_pcie_host_init()
> >         pp->ops->host_init(pp) = ks_pcie_host_init()
> >           hook_fault_code()
>
> Well that one is interesting. I wonder whether that driver has the same
> LPAE bug (different fault code for LPAE and non-LPAE configuration) we
> found here too, since it is used on CA15 TI SoCs.

Isn't that an ARM "feature"?

    arch/arm/mm/fault.c-/* FSR definition */
    arch/arm/mm/fault.c:#ifdef CONFIG_ARM_LPAE
    arch/arm/mm/fault.c-#include "fsr-3level.c"
    arch/arm/mm/fault.c-#else
    arch/arm/mm/fault.c-#include "fsr-2level.c"
    arch/arm/mm/fault.c-#endif

> >> drivers which hook fault code do it in init as well. I can imagine that
> >
> > Probably nobody bothered exercising the external abort handler on
> > multi-platform kernels?
> >
> >> something might trip the fault handler even before probe is called, e.g.
> >> some PM handling or simply user accessing that PCIe area using setpci.
> >
> > If that is the case, it must indeed by done earlier, but still
> > conditional on the presence of the actual PCIe controller.
>
> I am open to suggestions how to do that part.

    if (of_find_matching_node(...))
           do_the_right_stuff();

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
