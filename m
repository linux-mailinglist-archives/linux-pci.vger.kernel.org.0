Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADED46795B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 15:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbhLCOZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 09:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhLCOZJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 09:25:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25219C061751;
        Fri,  3 Dec 2021 06:21:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8AAF62B6C;
        Fri,  3 Dec 2021 14:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242D1C53FAD;
        Fri,  3 Dec 2021 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638541304;
        bh=HC2g+xufwLJVVSHrTbpsdqX0NWDmqRszv3PT2k3Yk+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HZuDJGrDddtmB+IJrYZC8RXVR3oLz2xmD5jACl3RSc+xXfeNC4H2uZUyvU6+eOGru
         jPwQLSLEC6qeo6nr/WbhviNIfUxOw0oRk+bQ9P09sWpBGMbkkCyTG38lXUl5jSzKdX
         O04SJgWK6TmBH8Js5RT822yOCaurBAZodIzHiOdqFgwdOGO68fnBeisr8quuQanjCv
         pzDoLXyljZHcHkKKpxESjHW5H5cADLI7Pc9WKPSI1itNt5wJQ1eYx7e3I7uSufy6n+
         WB7qqBItKn2NxKm6HQO465UT1JGmjl8efYwsssoILB/mS11fihABsU5noThI0Xrzvq
         3y6dZzvCi0iQA==
Received: by mail-ed1-f45.google.com with SMTP id z5so12391083edd.3;
        Fri, 03 Dec 2021 06:21:44 -0800 (PST)
X-Gm-Message-State: AOAM532WQRrWJ6yxfIo81s9xOE4adjwXqGpgsGUFBirMSwV7027cNFzU
        fybOaU1OCJu9tvnsHReSeOdhJi2ba9tNFTtY/Q==
X-Google-Smtp-Source: ABdhPJx4K+NI6m9v2jp/WCu2sGD9MipZmsiwA7Z6F8/fXzhrS26X0Cr7vffSAv0to+GN6ZsD2gaHhZQtV1yx1ZVUuh8=
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr27630276eda.22.1638541288935;
 Fri, 03 Dec 2021 06:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20211122111332.72264-1-marcan@marcan.st> <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
 <8e881b80-614c-dccf-ddaf-895d1acf26c7@marcan.st> <CAL_JsqLMgkTdbKNP=kAvwKFQp+m330ztTX8v_UFmj2zvzsB-KA@mail.gmail.com>
 <7f6928fc-97fd-cbe8-f7e9-954945b4574b@marcan.st> <CAL_Jsq+2svQ+1GOw2HcxR88dHog7V=5dbCVgi37Dw6ariZsiqQ@mail.gmail.com>
 <f3c5f961-d06c-47e2-453f-ec48e758a684@marcan.st>
In-Reply-To: <f3c5f961-d06c-47e2-453f-ec48e758a684@marcan.st>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Dec 2021 08:21:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5_iy0b4ayj26-V+r3i_E9RbxCGKhY_ssBW2bjbCn98A@mail.gmail.com>
Message-ID: <CAL_JsqK5_iy0b4ayj26-V+r3i_E9RbxCGKhY_ssBW2bjbCn98A@mail.gmail.com>
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

On Fri, Dec 3, 2021 at 7:47 AM Hector Martin <marcan@marcan.st> wrote:
>
> On 02/12/2021 23.33, Rob Herring wrote:
> >>>>>> +       max_gen = of_pci_get_max_link_speed(port->np);
> >>>>>> +       if (max_gen < 0) {
> >>>>>> +               dev_err(port->pcie->dev, "max link speed not specified\n");
> >>>>>
> >>>>> Better to fail than limp along in gen1? Though you don't check the
> >>>>> return value...
> >>>>>
> >>>>> Usually, the DT property is there to limit the speed when there's a
> >>>>> board limitation.
> >>>>
> >>>> The default *setting* is actually Gen4, but without
> >>>> PCIE_LINK_WIDTH_SPEED_CONTROL poked it always trains at Gen1. Might make
> >>>> more sense to only set the LNKCTL field if max-link-speed is specified,
> >>>> and unconditionally poke that bit. That'll get us Gen4 by default (or
> >>>> even presumably Gen5 in future controllers, if everything else stays
> >>>> compatible).
> >>>
> >>> You already do some setup in firmware for ECAM, right? I think it
> >>> would be better if you can do any default setup there and then
> >>> max-link-speed is only an override for the kernel.
> >>
> >> I thought the PCIE_LINK_WIDTH_SPEED_CONTROL thing had to be set later,
> >> but trying it now I realized we were missing a bit of initialization
> >> that was causing it not to work. Indeed it can be done there and we can
> >> drop it from the kernel.
> >>
> >> We could even do the max-link-speed thing in m1n1 if we want. It has
> >> access to the value from the ADT directly, which to be correct we'd have
> >> to dynamically transplant to the DT, since there's at least one device
> >> that has different PCIe devices on one port depending on hardware
> >> variant, while sharing a devicetree. If we're okay with the kernel just
> >> not implementing this feature for now, we can say it's the bootloader's job.
> >>
> >> Ultimately we ship the DTs along with m1n1, so there's an argument that
> >> if some day we need to override the max-link-speed for whatever reason
> >> over what the ADT says, well, we'd be shipping the updated DT along with
> >> m1n1 anyway, so we might as well make m1n1 do it... if so, it might make
> >> sense to drop those properties from the actual DTs we ship altogether,
> >> at least for now.
> >>
> >> If we decide to make it m1n1's job entirely, we can drop this patch
> >> altogether, at least for now (I can't say how this will interact with
> >> suspend/resume and other power management, and hotplug... but we'll open
> >> that can of worms when we get there).
> >
> > Shouldn't you be setting PCI_EXP_LNKCAP_SLS and/or PCI_EXP_LNKCAP2 if
> > you need to limit the max speed and then you can use that instead of
> > max-link-speed? If that's lost in low power modes, the driver just has
> > to save and restore it.
>
> Those registers aren't writable as far as I can tell. All we can do is
> set LNKCTL2 to tell the hardware what actual max speed to use, the same
> thing this patch does.

I believe they are if you set the PCIE_DBI_RO_WR_EN bit. Multiple DWC
drivers write PCI_EXP_LNKCAP.

Rob
