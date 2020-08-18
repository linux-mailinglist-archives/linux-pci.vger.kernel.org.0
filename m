Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C942248D79
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 19:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHRRtc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHRRtb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2020 13:49:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE0C061389
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2020 10:49:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so9545058plk.13
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2020 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMrT9C5AFoMvfd0icRmwdmikCEIc/NXJSQt8b1yXCkw=;
        b=sAK+0rf9juJXiwHzeHjlRJRWIPHclN8Phlv51l+2QJIKpBcC34ipELa2VfI7E17BvK
         m68XbGNzwGepUZZ1Pr0P9h9Jc/7bg6spmjHt5NSFaLNagz7dalWVtN1tKYuM5bOPi6Op
         If24cwckYg9jm6rdn6n4Um6N2mlzxhZT+GRBTkAydj+iXoS0a+0v7+kWnPZcETMabcbp
         iSUiSqH6yqjsQkeFOrUegOfeNTUVWwfScVhxUMh8qRsKYl1J7qDnzRi771PmHHAXZ0aU
         TmfaTSiINFimh+dbuxpQwh+YY6+u3LnHrKoqOfAQe1o3Y7mTernmzlxHt7P9FeyD1YmS
         ZbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMrT9C5AFoMvfd0icRmwdmikCEIc/NXJSQt8b1yXCkw=;
        b=QDLzHB2kVHh04TRRloohUgYk+XoT3DkmWjGpU3RZapWIz4MJbKLVYZ5H0wpyoie3RB
         eWPHsasVahhMm5TqcCjvgGw/SEp5+2KPgOB4cNd5eX7ncl41SKVYnhGtvfQozCvzSqpa
         fsuHBnFtdXvEbEZmokL7U5VOPPGnJTIkhxtn3vMWrwnL4QZRnGh9GqGg85Sciva44Mci
         gE5Gzi2Vuzi8I2ClFicjqMhoRug3mTkOnUpWJpBAH2pwhQM3VQy+lc3qc8Fz3L4ROlEO
         /HmnQv7hQ631elVzJ+WH6i77BbtDHwrmzogeEy84HqqhuC5nPr/lF4Qb1XRFGp5MYde5
         9wJg==
X-Gm-Message-State: AOAM532v6c5w0LTlpNnbnkmLtu8DPSkvgfjNrvzCPhRkc8TJvT4zPTmy
        zAJ8YCa/TsKYeWJAYm3SZMqznHB55qC8ucghfmT/pw==
X-Google-Smtp-Source: ABdhPJzVVyPcZ+7Gs0AXJVZxiCetyUr6nk23IoYNH1FZlus2gp2HDkcMI/FTOQ/mx9fK0t2ODFmqRjeqa113FBmxApY=
X-Received: by 2002:a17:90a:f98e:: with SMTP id cq14mr871303pjb.51.1597772970220;
 Tue, 18 Aug 2020 10:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200815125112.462652-2-maz@kernel.org> <20200815232228.GA1325245@bjorn-Precision-5520>
 <87pn7qnabq.wl-maz@kernel.org> <CAL_Jsq+fDNa60+6+s9MwVjUFUPAuc43+uMx4Fm2nZhUgrV7LEg@mail.gmail.com>
 <e2cde177e82fbdf158732ad73ccdc6c5@kernel.org> <CAL_JsqL1_d2grS3Pz6NNeVAOMPbx_hAe+MrseQeQp=bHRQ7rfQ@mail.gmail.com>
 <72c10e43023289b9a4c36226fe3fd5d9@kernel.org>
In-Reply-To: <72c10e43023289b9a4c36226fe3fd5d9@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 18 Aug 2020 10:48:54 -0700
Message-ID: <CAGETcx-hkz8fyAHuhRi=JhBFu4YUmL2UpHfgs7doLHK-RdKA0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: rockchip: Work around missing device_type
 property in DT
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 18, 2020 at 10:34 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-08-18 15:23, Rob Herring wrote:
> > On Tue, Aug 18, 2020 at 1:35 AM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-08-17 17:12, Rob Herring wrote:
> >> > On Sun, Aug 16, 2020 at 4:40 AM Marc Zyngier <maz@kernel.org> wrote:
> >> >>
> >> >> On Sun, 16 Aug 2020 00:22:28 +0100,
> >> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> >> >
> >> >> > On Sat, Aug 15, 2020 at 01:51:11PM +0100, Marc Zyngier wrote:
> >> >> > > Recent changes to the DT PCI bus parsing made it mandatory for
> >> >> > > device tree nodes describing a PCI controller to have the
> >> >> > > 'device_type = "pci"' property for the node to be matched.
> >> >> > >
> >> >> > > Although this follows the letter of the specification, it
> >> >> > > breaks existing device-trees that have been working fine
> >> >> > > for years.  Rockchip rk3399-based systems are a prime example
> >> >> > > of such collateral damage, and have stopped discovering their
> >> >> > > PCI bus.
> >> >> > >
> >> >> > > In order to paper over the blunder, let's add a workaround
> >> >> > > to the pcie-rockchip driver, adding the missing property when
> >> >> > > none is found at boot time. A warning will hopefully nudge the
> >> >> > > user into updating their DT to a fixed version if they can, but
> >> >> > > the insentive is obviously pretty small.
> >> >> >
> >> >> > s/insentive/incentive/ (Lorenzo or I can fix this up)
> >> >> >
> >> >> > > Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> >> >> > > Suggested-by: Roh Herring <robh+dt@kernel.org>
> >> >> >
> >> >> > s/Roh/Rob/ (similarly)
> >> >>
> >> >> Clearly not my day when it comes to proofreading commit messages.
> >> >> Thanks for pointing this out, and in advance for fixing it up.
> >> >>
> >> >> >
> >> >> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> >> >> >
> >> >> > This looks like a candidate for v5.9, since 2f96593ecc37 was merged
> >> >> > during the v5.9 merge window, right?
> >> >>
> >> >> Absolutely.
> >> >>
> >> >> > I wonder how many other DTs are similarly broken?  Maybe Rob's DT
> >> >> > checker has already looked?
> >> >>
> >> >> I've just managed to run the checker, which comes up with all kinds of
> >> >> goodies. Apart from the above, it also spots the following:
> >> >>
> >> >> - arch/arm64/boot/dts/mediatek/mt7622.dtsi: Has a device_type property
> >> >>   in its main PCIe node, but not in the child nodes. It isn't obvious
> >> >>   to me whether that's a violation or not (the spec doesn't say
> >> >>   whether the property should be set on a per-port basis). Rob?
> >> >
> >> > The rule is bridge nodes should have 'device_type = "pci"'. But what's
> >> > needed to fix these cases is setting device_type where we are parsing
> >> > ranges or dma-ranges which we're not doing on the child ndes.
> >> > Otherwise, I don't think it matters in this case unless you have child
> >> > (grandchild here) nodes for PCI devices. If you did have child nodes,
> >> > the address translation was already broken before this change.
> >>
> >> Fair enough.
> >>
> >> >> - arch/arm64/boot/dts/qcom/msm8996.dtsi: Only one out of the three
> >> >>   PCIe nodes has the device_type property, probably broken similarly
> >> >>   to rk3399.
> >> >
> >> > The only upstream board is DB820c, so probably not as wide an impact...
> >> >
> >> > There are also 92 (lots of duplicates due to multiple boards) more
> >> > cases in arch/arm/. A log is here[1].
> >>
> >> Mostly Broadcom stuff, apparently. I'll see if I can have a stab
> >> at it (although someone will have to test it).
> >>
> >> >
> >> >> I could move the workaround to drivers/pci/of.c, and have it called
> >> >> from the individual drivers. I don't have the HW to test those though.
> >> >>
> >> >> Thoughts?
> >> >
> >> > I think we should go with my other suggestion of looking at the node
> >> > name. Looks like just checking 'pcie' is enough. We can skip 'pci' as
> >> > I don't see any cases.
> >>
> >> I really dislike it.
> >>
> >> Once we put this node name matching in, there is no incentive for
> >> people to write their DT correctly at all. It also sound pretty
> >> fragile (what if the PCIe node is named something else?).
> >
> > That would require 2 wrongs. Both missing device_type and wrong node
> > name. You could still warn if we matched on node name.
>
> OK. So how about something like this?
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 590493e04b01..a7a6ee599b14 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -134,9 +134,13 @@ static int of_bus_pci_match(struct device_node *np)
>          * "pciex" is PCI Express
>          * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
>          * "ht" is hypertransport
> +        *
> +        * If none of the device_type match, and that the node name is
> +        * "pcie", accept the device as PCI (with a warning).
>          */
>         return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
> -               of_node_is_type(np, "vci") || of_node_is_type(np, "ht");
> +               of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
> +               WARN_ON_ONCE(of_node_name_eq(np, "pcie"));

I don't think we need the _ONCE. Otherwise, it'd warn only for the
first device that has this problem.

How about?
WARN(of_node_name_eq(np, "pcie"), "Missing device type in %pOF", np)

That'll even tell them which node is bad.

-Saravana
