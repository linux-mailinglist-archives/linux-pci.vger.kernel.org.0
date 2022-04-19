Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423FC5060E3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 02:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiDSA0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 20:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiDSA0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 20:26:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1A01FA45;
        Mon, 18 Apr 2022 17:23:35 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r189so8575904ybr.6;
        Mon, 18 Apr 2022 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpIj5nFYZ+LCeIvaeVUxMdEu7PH6JH2Cp37sIzyz/0g=;
        b=U2owpANdeEDN0xiL9wt3ENoKM3RY4lW+ZIANdqwZXqGIJWA7ke6HzcYQltDEQzOYp4
         ZEYoFk7ByOQOY1lpj6CqdYvIsDHB4BZe6YGOtTPk6JV6LxIlesFQmyZ9f+OxpyCMate7
         1iahfugDoknFmVNKPCHYrWJ+qFKBmitf5bvaik1T1HCjfetpaqYfob95IYCL8jk4JYl8
         E6RtiaIhTI//Ovyt2qw6RvkzkRExJ8LIM1qvZuNWoh5O7+CEE/AXP9JgOo5XsqCFFZl1
         he8GdK7emuOTY/FfDPsrE37AWS3ntjDbxUgjcmPXAkRnzy+IiRjmxTqTX6ZQRb1DWB9x
         9E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpIj5nFYZ+LCeIvaeVUxMdEu7PH6JH2Cp37sIzyz/0g=;
        b=0ZHAw7C+AtALNr8dRA75P+4TPnBcGfSDMBG9Fwask2x9uD54b5J5FQh568XCO+dXuO
         oSd5gfP2Zl7VABBlctSbg+hU5Q2tzc9815/Hh8xLzKhCk7Su2jfi+x5CsiS+Oz9tAGqa
         tyuQ8meTUlFGzSwvakCFH0t5YxtBh7v/Z4q1ecI0fai7dWrrLhRcO/DCpq1LQG7R0/DJ
         PvDlE+g/T7/DvimFYEN+/8FClXdU7W4uiSM45CHLmLD0Z2kUNq65J4AFGSsW8frRpdiO
         s2qpzNawVWnlE1gQgp1VkQeQ2QW1vBfPRa/MExNqf6p8s6oiSlqupfTD6Tu+3V2+oH39
         rcCA==
X-Gm-Message-State: AOAM532CH5Y6mLJauotAY0j6owemN4X4WKC3UnnFZjAbjWkzlEeHiC+b
        FbwbWJUNna1j4c3bWHDhrjkjGiVDX/GSMT5DD2w=
X-Google-Smtp-Source: ABdhPJwTgFI3+EQywY1+yIRoSPODiYFHNCFsej3qTaNq+T5Y/cSqagDgebDP3oRz4YO9Y2kPKZ8tEmcOZiERZSSwe3o=
X-Received: by 2002:a05:6902:143:b0:628:7cf1:f2a9 with SMTP id
 p3-20020a056902014300b006287cf1f2a9mr12121954ybh.51.1650327814809; Mon, 18
 Apr 2022 17:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220416110507.642398-1-pgwipeout@gmail.com> <20220416110507.642398-3-pgwipeout@gmail.com>
 <308e9c47197d4f7ae5a31cfcb5a10886@kernel.org> <CAMdYzYo+YeAgT92baMOoWpra230wro_WynRcajL-__9RNkeE9Q@mail.gmail.com>
 <87zgkk9gtc.wl-maz@kernel.org> <CAMdYzYo_+7rakc=GCTueEZvH_F4Co6+=eKAUztJaafiDXSKKXQ@mail.gmail.com>
 <87sfqaa7uv.wl-maz@kernel.org> <CAMdYzYouLoYX89EWjQTRAjd-1bvJEJtfYQa2KrtFH22Kp-4Efw@mail.gmail.com>
 <878rs2c8ay.wl-maz@kernel.org>
In-Reply-To: <878rs2c8ay.wl-maz@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 18 Apr 2022 20:23:23 -0400
Message-ID: <CAMdYzYqfitnPYSUEeeUB=x9=L9xzAu6o0SBmEdF8WKeb-+b6uQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] PCI: dwc: rockchip: add legacy interrupt support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 18, 2022 at 6:53 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 18 Apr 2022 16:13:39 +0100,
> Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Mon, Apr 18, 2022 at 8:34 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Mon, 18 Apr 2022 12:37:00 +0100,
> > > Peter Geis <pgwipeout@gmail.com> wrote:
> > > >
> > > > On Sun, Apr 17, 2022 at 5:53 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Sat, 16 Apr 2022 14:24:26 +0100,
> > > > > Peter Geis <pgwipeout@gmail.com> wrote:
> > > > > >
> > > > > > Okay, that makes sense. I'm hitting the entire block when it should be
> > > > > > the individual IRQ.
> > > > > > I also notice some drivers protect this with a spinlock while others
> > > > > > do not, how should this be handled?
> > > > >
> > > > > It obviously depends on how the HW. works. If this is a shared
> > > > > register using a RMW sequence, then you need some form of mutual
> > > > > exclusion in order to preserve the atomicity of the update.
> > > > >
> > > > > If the HW supports updating the masks using a set of hot bits (with
> > > > > separate clear/set registers), than there is no need for locking.  In
> > > > > your case PCIE_CLIENT_INTR_MASK_LEGACY seems to support this odd
> > > > > "write-enable" feature which can probably be used to implement a
> > > > > lockless access, something like:
> > > > >
> > > > >         void mask(struct irq_data *d)
> > > > >         {
> > > > >                 u32 val = BIT(d->hwirq + 16) | BIT(d->hwirq);
> > > >
> > > > This is what HIWORD_UPDATE_BIT does, it's rather common in Rockchip code.
> > > > I believe I can safely drop the spinlock when enabling/disabling
> > > > individual interrupts.
> > >
> > > Yes.
> > >
> > > >
> > > > >                 writel_relaxed(val, ...);
> > > > >         }
> > > > >
> > > > >         void mask(struct irq_data *d)
> > > > >         {
> > > > >                 u32 val = BIT(d->hwirq + 16);
> > > > >                 writel_relaxed(val, ...);
> > > > >         }
> > > > >
> > > > > Another thing is that it is completely unclear to me what initialises
> > > > > these interrupts the first place (INTR_MASK_LEGACY, INTR_EN_LEGACY).
> > > > > Are you relying on the firmware to do that for you?
> > > >
> > > > There is no dedicated mask or enable/disable for the legacy interrupt
> > > > line (unless it's undocumented).
> > >
> > > I'm talking about the INTR_MASK_LEGACY and INTR_EN_LEGACY registers,
> > > which control the INTx (although the latter seems to default to some
> > > reserved values). I don't see where you initialise them to a state
> > > where they are enabled and masked, which should be the initial state
> > > once this driver has probed. The output interrupt itself is obviously
> > > controlled by the GIC driver.
> >
> > PCIE_CLIENT_INTR_MASK_LEGACY is the register I use here to mask/unmask
> > the interrupts.
> > It defaults to all masked on reset.
>
> And? Are your really expecting that the firmware that runs before the
> kernel will preserve this register and not write anything silly to it
> because, oh wait, it wants to use interrupts? Or that nobody will
> kexec a secondary kernel from the first one after having used these
> interrupts?
>
> Rule #1: Initialise the HW to sensible values
> Rule #2: See Rule #1

I don't disagree here, there are plenty of examples of bugs that stem
from this in Rockchip's code.
Working on this series has given me ideas for improvements to the
rk3399 controller as well.

>
> > The current rk3568 trm v1.1 does not reference an INTR_EN_LEGACY register.
>
> The TRM for RK3588 mentions it, and is the same IP.

Unfortunately this assumption doesn't hold up to testing.
On rk356x this entire register block is 0x0, which if it was
implemented means legacy interrupts would not work, among other
issues.
Even in the rk3588 it's marked as "reserved" which means there's a
good possibility it isn't fully implemented there either.
A number of other blocks in the rk3588 trm are labeled as being
available only after a specific hardware revision.
We are seeing other bugs in the hardware implementation Rockchip has
here, so making assumptions based on other implementations of the DW
IP is unsafe.

>
> > >
> > > > It appears to be enabled via an "or" function with the emulated interrupts.
> > > > As far as I can tell this is common for dw-pcie, looking at the other drivers.
> > >
> > > I think we're talking past each other. I'm solely concerned with the
> > > initialisation of the input control registers, for which I see no code
> > > in this patch.
> >
> > Downstream points to the mask/unmask functions for the enable/disable
> > functions, which would be superfluous here as mainline defaults to
> > that anyways if they are null.
>
> Yeah, that's completely dumb. But there is no shortage of dumb stuff
> in the RK downstream code...

You'll find no argument from me here, I'm merely using it as an
example of the vendor's implementation.
The only resources I have available are the publically released
documentation and the publically released downstream code.

>
> >
> > I've double checked and downstream only uses the mask register, enable
> > and routing config appears to be left as is from reset.
>
> And that's a bug.
>
> > I'm rather concerned about the lack of any obvious way to control
> > routing, nor an ack mechanism for the irq.
>
> Which routing? Do you mean the affinity? You can't change it, as this
> would change the affinity of all interrupts at once.
>
> > I see other implementations reference the core registers or vendor
> > defined registers for these functions.
> > Unfortunately the rk3568 trm does not include the core register
> > definitions, and the designware documentation appears to be behind a
> > paywall/nda.
>
> If you use a search engine, you'll find *CONFIDENTIAL* copies of the
> DW stuff. The whole thing is a laugh anyway.
>
> >
> > I suspect most of the confusion here boils down to a lack of
> > documentation, but it's entirely possible I am simply not
> > understanding the question.
>
> My only ask is that you properly initialise the HW. This will save
> countless amount of head-scratching once you have a decent firmware or
> kexec.

The only way to ensure that in a sane way is to trigger the resets at
driver probe.
Can that be safely done without causing other issues with an already
configured card or should I power cycle it as well?
This is starting to feature creep from the original intention of this
series, since a pre-configured controller would affect more than just
interrupts.
If you wish, as a compromise I can ensure all INTx interrupts are
masked at probe (which would hilariously be the opposite of
downstream).


>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
