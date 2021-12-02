Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1946654D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 15:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358566AbhLBOhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 09:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358563AbhLBOhm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 09:37:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA5C06174A;
        Thu,  2 Dec 2021 06:34:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1921CB823A7;
        Thu,  2 Dec 2021 14:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEE1C00446;
        Thu,  2 Dec 2021 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638455656;
        bh=ZA74ApQWbIzE4Eo3zZiySRb5DlNCDS7i0zc47ylSO0I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k8JBoOtuii6iDf0XGj4N4mRmpQPaSG6G+Y/1dXPEPHt1WqxNpdslLfViki5JM2UAV
         4geaeb7J79HZ5C+az1qBeSq9uyTpJgs9h/e69uTk74Laemz1DqkoIqTpN8tfAEFtnQ
         D7fYMnSud47u7eoHtKFLxQKDCNYwcgJJGi96Kz5JiALLBw8NfxF1ArCs1sY+3Bg/aO
         d18KPZEK2MrtD8Dgq8hSN8cwJvg7JlbFn/MVHZz08pXpd5oy0gKjkSLa3dcjd/ATOB
         kheHM/mvNT33EmBvtM3gGbgK82zb8C0T0ItEoGK9vIysB36hQZZWrWt2AhaZ103l5N
         b3eahaYcqvkrg==
Received: by mail-ed1-f46.google.com with SMTP id l25so116713594eda.11;
        Thu, 02 Dec 2021 06:34:16 -0800 (PST)
X-Gm-Message-State: AOAM5321QnbA7CkfoILPAVsE7kfJnEVVyVaW14Puzm6uw+KplPvstrJn
        0q9eVH1WxgWoAnhaq2UDe/L1A1r54778MLq6zw==
X-Google-Smtp-Source: ABdhPJwgr61Fsh1QRDOL3UJvZdoyx00MsTV9B4WbP2bzYbUvrc7Vcm3WAnzOxOUgAdrMVFifmxkfr2n6oylUqQ1IkD8=
X-Received: by 2002:aa7:cc82:: with SMTP id p2mr17672819edt.201.1638455647872;
 Thu, 02 Dec 2021 06:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20211122111332.72264-1-marcan@marcan.st> <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
 <8e881b80-614c-dccf-ddaf-895d1acf26c7@marcan.st> <CAL_JsqLMgkTdbKNP=kAvwKFQp+m330ztTX8v_UFmj2zvzsB-KA@mail.gmail.com>
 <7f6928fc-97fd-cbe8-f7e9-954945b4574b@marcan.st>
In-Reply-To: <7f6928fc-97fd-cbe8-f7e9-954945b4574b@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Dec 2021 08:33:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+2svQ+1GOw2HcxR88dHog7V=5dbCVgi37Dw6ariZsiqQ@mail.gmail.com>
Message-ID: <CAL_Jsq+2svQ+1GOw2HcxR88dHog7V=5dbCVgi37Dw6ariZsiqQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: apple: Configure link speeds properly
To:     Hector Martin <marcan@marcan.st>
Cc:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 1, 2021 at 10:55 PM Hector Martin <marcan@marcan.st> wrote:
>
> On 30/11/2021 00.02, Rob Herring wrote:
> >> Sure, it just means I have to reinvent the PCI capability lookup wheel
> >> again. I'd love to use the regular accessors, but the infrastructure
> >> isn't up to the point where we can do that yet yere. DWC also reinvents
> >> this wheel, but we can't reuse that code because it pokes these
> >> registers through a separate reg range, not config space (even though it
> >> seems like they should be the same thing? I'm not sure what's going on
> >> in the DWC devices... for the Apple controller it's just the ECAM).
> >
> > Since it is just ECAM, can you use the regular config space accessors?
>
> The problem is this is before the PCI objects are created, so those
> wouldn't work since they expect to be called on a pci_dev and such.

Ah, right. That's something I want to fix because lots of drivers have
2 sets of accessors for this reason.

> >>>> +       max_gen = of_pci_get_max_link_speed(port->np);
> >>>> +       if (max_gen < 0) {
> >>>> +               dev_err(port->pcie->dev, "max link speed not specified\n");
> >>>
> >>> Better to fail than limp along in gen1? Though you don't check the
> >>> return value...
> >>>
> >>> Usually, the DT property is there to limit the speed when there's a
> >>> board limitation.
> >>
> >> The default *setting* is actually Gen4, but without
> >> PCIE_LINK_WIDTH_SPEED_CONTROL poked it always trains at Gen1. Might make
> >> more sense to only set the LNKCTL field if max-link-speed is specified,
> >> and unconditionally poke that bit. That'll get us Gen4 by default (or
> >> even presumably Gen5 in future controllers, if everything else stays
> >> compatible).
> >
> > You already do some setup in firmware for ECAM, right? I think it
> > would be better if you can do any default setup there and then
> > max-link-speed is only an override for the kernel.
>
> I thought the PCIE_LINK_WIDTH_SPEED_CONTROL thing had to be set later,
> but trying it now I realized we were missing a bit of initialization
> that was causing it not to work. Indeed it can be done there and we can
> drop it from the kernel.
>
> We could even do the max-link-speed thing in m1n1 if we want. It has
> access to the value from the ADT directly, which to be correct we'd have
> to dynamically transplant to the DT, since there's at least one device
> that has different PCIe devices on one port depending on hardware
> variant, while sharing a devicetree. If we're okay with the kernel just
> not implementing this feature for now, we can say it's the bootloader's job.
>
> Ultimately we ship the DTs along with m1n1, so there's an argument that
> if some day we need to override the max-link-speed for whatever reason
> over what the ADT says, well, we'd be shipping the updated DT along with
> m1n1 anyway, so we might as well make m1n1 do it... if so, it might make
> sense to drop those properties from the actual DTs we ship altogether,
> at least for now.
>
> If we decide to make it m1n1's job entirely, we can drop this patch
> altogether, at least for now (I can't say how this will interact with
> suspend/resume and other power management, and hotplug... but we'll open
> that can of worms when we get there).

Shouldn't you be setting PCI_EXP_LNKCAP_SLS and/or PCI_EXP_LNKCAP2 if
you need to limit the max speed and then you can use that instead of
max-link-speed? If that's lost in low power modes, the driver just has
to save and restore it.

All this link handling is also something we want to make common as
much as possible. There's a lot of drivers poking these registers in
different ways and it's not clear whether they really need to be
different. So the less you do in the kernel the better.

Rob
