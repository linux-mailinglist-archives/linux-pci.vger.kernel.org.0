Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4319F505BB1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 17:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbiDRPrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345793AbiDRPqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 11:46:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582C15AA46;
        Mon, 18 Apr 2022 08:13:51 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v77so25976550ybi.12;
        Mon, 18 Apr 2022 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UD05IbcZ2rf5qvJ6A93X+/jr+vU3bRZx5RLWQDEGt1I=;
        b=Pjj9yRLO9dfTboleo6SJMPQgWC8TvkyB63hnmKy8gYvh0uGqQdx3aGD6CzWSQXEddN
         tPuhqFSulSxiwq996BZ9ztVVYJZQWGZ+HG7wT3kxTdHO+KCfMeVWxPnKJRPl67IKCggy
         sE6Ga1oTaw8UdJAxivjX1oDAcpjDoROMAbn+qVzTmEA2j4UIlSmPLr6p4xOHkapm7MDP
         mBPYUiDkuyOBPnGQqjpa2Vw5GBl/n2f0L6D3Lvn4vQ4G5acCVRe2KsR0uezYt02+MLyg
         f4SobePJdgLFuZMdRMTKguUTIxzt9zRSJPNx16UVjLkBzjnmkL5AJ6FUpJ1ZlAbdul8c
         Lp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UD05IbcZ2rf5qvJ6A93X+/jr+vU3bRZx5RLWQDEGt1I=;
        b=RMsOy39LlyAq7MqqEB5tMo/rTFleQyhXuU7cVxTqSbTbwtjkV5DzdXzy2Qi4AsLBGd
         M7nL9ywIsyP69xUWAL7j29j/XNToJdrXlFpzJxeLGvVVxwWW7JSet/bT5uScEzKIzdd8
         n0u5Qfff3hN86dbjvWzZdPn2+FJwTE+F+6E7q3wwVFRQTaoIm+LCt4aglCOgJiE/j5uZ
         feTrJU0N3DD/nHUCrmp3rNmmE80CJnDkitMrh5FGR/xIPsp2RC4Pcw6euJILQTM312bu
         CMaHWuvW/eAsauAnQmPJk0FCOVVTcvnoMbJ9vxqmsF7P+KnD5FOeMjEtuxjcanBPAmsu
         yYNA==
X-Gm-Message-State: AOAM53144zXXusUAUeA6CXEHMPKS+YNf4zxCv8paQ95/eoQ8svwUlQ4F
        OhotdL89KJU2dvwP/E5pJtChDK1S8umGJsnFeSI=
X-Google-Smtp-Source: ABdhPJyglgnLuoSw1DyURkg6CGKqtEJL4ymjfUewdv/sJ/JuvH0Bue0GwV9LJ769SlOf0P2VWW9+SDrsMuiERFAhTZI=
X-Received: by 2002:a25:c54b:0:b0:641:cfe9:27e9 with SMTP id
 v72-20020a25c54b000000b00641cfe927e9mr9915958ybe.228.1650294830426; Mon, 18
 Apr 2022 08:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220416110507.642398-1-pgwipeout@gmail.com> <20220416110507.642398-3-pgwipeout@gmail.com>
 <308e9c47197d4f7ae5a31cfcb5a10886@kernel.org> <CAMdYzYo+YeAgT92baMOoWpra230wro_WynRcajL-__9RNkeE9Q@mail.gmail.com>
 <87zgkk9gtc.wl-maz@kernel.org> <CAMdYzYo_+7rakc=GCTueEZvH_F4Co6+=eKAUztJaafiDXSKKXQ@mail.gmail.com>
 <87sfqaa7uv.wl-maz@kernel.org>
In-Reply-To: <87sfqaa7uv.wl-maz@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 18 Apr 2022 11:13:39 -0400
Message-ID: <CAMdYzYouLoYX89EWjQTRAjd-1bvJEJtfYQa2KrtFH22Kp-4Efw@mail.gmail.com>
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

On Mon, Apr 18, 2022 at 8:34 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 18 Apr 2022 12:37:00 +0100,
> Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Sun, Apr 17, 2022 at 5:53 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sat, 16 Apr 2022 14:24:26 +0100,
> > > Peter Geis <pgwipeout@gmail.com> wrote:
> > > >
> > > > Okay, that makes sense. I'm hitting the entire block when it should be
> > > > the individual IRQ.
> > > > I also notice some drivers protect this with a spinlock while others
> > > > do not, how should this be handled?
> > >
> > > It obviously depends on how the HW. works. If this is a shared
> > > register using a RMW sequence, then you need some form of mutual
> > > exclusion in order to preserve the atomicity of the update.
> > >
> > > If the HW supports updating the masks using a set of hot bits (with
> > > separate clear/set registers), than there is no need for locking.  In
> > > your case PCIE_CLIENT_INTR_MASK_LEGACY seems to support this odd
> > > "write-enable" feature which can probably be used to implement a
> > > lockless access, something like:
> > >
> > >         void mask(struct irq_data *d)
> > >         {
> > >                 u32 val = BIT(d->hwirq + 16) | BIT(d->hwirq);
> >
> > This is what HIWORD_UPDATE_BIT does, it's rather common in Rockchip code.
> > I believe I can safely drop the spinlock when enabling/disabling
> > individual interrupts.
>
> Yes.
>
> >
> > >                 writel_relaxed(val, ...);
> > >         }
> > >
> > >         void mask(struct irq_data *d)
> > >         {
> > >                 u32 val = BIT(d->hwirq + 16);
> > >                 writel_relaxed(val, ...);
> > >         }
> > >
> > > Another thing is that it is completely unclear to me what initialises
> > > these interrupts the first place (INTR_MASK_LEGACY, INTR_EN_LEGACY).
> > > Are you relying on the firmware to do that for you?
> >
> > There is no dedicated mask or enable/disable for the legacy interrupt
> > line (unless it's undocumented).
>
> I'm talking about the INTR_MASK_LEGACY and INTR_EN_LEGACY registers,
> which control the INTx (although the latter seems to default to some
> reserved values). I don't see where you initialise them to a state
> where they are enabled and masked, which should be the initial state
> once this driver has probed. The output interrupt itself is obviously
> controlled by the GIC driver.

PCIE_CLIENT_INTR_MASK_LEGACY is the register I use here to mask/unmask
the interrupts.
It defaults to all masked on reset.
The current rk3568 trm v1.1 does not reference an INTR_EN_LEGACY register.

>
> > It appears to be enabled via an "or" function with the emulated interrupts.
> > As far as I can tell this is common for dw-pcie, looking at the other drivers.
>
> I think we're talking past each other. I'm solely concerned with the
> initialisation of the input control registers, for which I see no code
> in this patch.

Downstream points to the mask/unmask functions for the enable/disable
functions, which would be superfluous here as mainline defaults to
that anyways if they are null.

I've double checked and downstream only uses the mask register, enable
and routing config appears to be left as is from reset.
I'm rather concerned about the lack of any obvious way to control
routing, nor an ack mechanism for the irq.
I see other implementations reference the core registers or vendor
defined registers for these functions.
Unfortunately the rk3568 trm does not include the core register
definitions, and the designware documentation appears to be behind a
paywall/nda.

I suspect most of the confusion here boils down to a lack of
documentation, but it's entirely possible I am simply not
understanding the question.
I'm already aware of other functions that I need documentation for
that is currently unavailable.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thank you for your time,
Peter
