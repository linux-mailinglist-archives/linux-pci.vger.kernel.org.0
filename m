Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D884397DB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhJYNwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 09:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhJYNwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 09:52:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E69C061767
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 06:50:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s19so12880598wra.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Oct 2021 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zO//Njv5YS97vppMMVlVgZZUjNA2rAR2HbiLnMq5guY=;
        b=WAJHDBQ9M9IsmiDeUxxWHPYr+sCVbX/bI2CcVAuFyyhDOTB2poQayGA0ZinLaHiK9y
         z8cSONPK2YzrZZk6ypTUZDOu0KGjHbgqLFQDpCEtdMxXzFE0/TEjs1XeGc79+Ors7i1o
         +IzpvsLL/wXEfoqgwUVj6L1+8+4k5FfGIlkDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zO//Njv5YS97vppMMVlVgZZUjNA2rAR2HbiLnMq5guY=;
        b=dTRsmUmdTLWIb0Rh+xUllq7mB36xQE5Q4IE7XqNywbphk0yWfHOy0QzeuGZjB4iz3m
         pHdX2smSYxT70evHmGNSG0VHRgvfe3p693Y0s7qqaq8rqmQwcdIijf/oFJF2ZCJfdGeR
         JcyvQBUE81RpYL33JXlhmL5DRZbaJSA5O8oZFYMoAycDHF2YRmOg+TxYUgZgu38PKNvR
         EdxrtpNLLospZ2ubVZOs23qiTrlNhP3wmNQNaKNaLOGjJDpxVSulCkDelS6tWopjpZMw
         vNQVrHf3/zB5DT8NEe4Nxl971NeDKTBlC72lH9LWbo5sZHhFNWO90knjxen27erhGva9
         sZqg==
X-Gm-Message-State: AOAM5316BQPqddVY2Iz2nYP6gSFguBn78X1TISaio5AxrgAlpczHEiUR
        PykHKFaq9BHRGluLmWe3I0W3CR3/haQJ4CNgGzw48A==
X-Google-Smtp-Source: ABdhPJz5aj5JNuMgfqZUwaXY/cwE1jkvjSaX9jTe8FLYMARW9hORElaPxrAsk3O1APxlNE9m9YAEL0HbosNKjgNmgu4=
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr24072888wrx.128.1635169820558;
 Mon, 25 Oct 2021 06:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk> <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
 <YXMVSVpeC1Kqsg5x@sirena.org.uk>
In-Reply-To: <YXMVSVpeC1Kqsg5x@sirena.org.uk>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 25 Oct 2021 09:50:09 -0400
Message-ID: <CA+-6iNxQAekCQTJKE5L7LO6QF+UC6xnyE=XVq_7z3=4hp8ASXQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 3:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 22, 2021 at 03:15:59PM -0400, Jim Quinlan wrote:
>
> > Each different SOC./board we deal with may present different ways of
> > making the EP device power on.  We are using
> > an abstraction name "brcm-ep-a"  to represent some required regulator
> > to make the EP  work for a specific board.  The RC
> > driver cannot hard code a descriptive name as it must work for all
> > boards designed by us, others, and third parties.
> > The EP driver also doesn't know  or care about the regulator name, and
> > this driver is often closed source and often immutable.  The EP
> > device itself may come from Brcm, a third party,  or sometimes a competitor.
>
> > Basically, we find using a generic name such as "brcm-ep-a-supply"
> > quite handy and many of our customers embrace this feature.
> > I know that Rob was initially against such a generic name, but I
> > vaguely remember him seeing some merit to this, perhaps a tiny bit :-)
> > Or my memory is shot, which could very well be the case.
>
> That sounds like it just shouldn't be a regulator at all, perhaps the
> board happens to need a regulator there but perhaps it needs a clock,
> GPIO or some specific sequence of actions.  It sounds like you need some
> sort of quirking mechanism to cope with individual boards with board
> specific bindings.
The boards involved may have no PCIe sockets, or run the gamut of the different
PCIe sockets.  They all offer gpio(s) to turn off/on their power supply(s) to
make their PCIe device endpoint functional.  It is not viable to add
new Linux quirk or DT
code for each board.  First is the volume and variety of the boards
that use our SOCs.. Second, is
our lack of information/control:  often, the board is designed by one
company (not us), and
given to another company as the middleman, and then they want the
features outlined
in my aforementioned commit message.

>
> I'd suggest as a first pass omitting this and then looking at some
> actual systems later when working out how to support them, no sense in
> getting the main thing held up by difficult edge cases.

These are not edge cases -- some of these are major customers.

Regards,
Jim

>
> > > > +     /* This is for Broadcom STB/CM chips only */
> > > > +     if (pcie->type == BCM2711)
> > > > +             return 0;
>
> > > It is a relief that other chips have managed to work out how to avoid
> > > requiring power.
>
> > I'm not sure that the other Broadcom groups have our customers, our
> > customers' requirements, and the amount and variation of boards that
> > run our PCIe driver on the SOC.
>
> Sure, but equally they might (even if they didn't spot it yet) and in
> general it's safer to err on the side of describing the hardware so we
> can use that information later.
