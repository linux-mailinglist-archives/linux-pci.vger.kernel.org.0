Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55B507B12
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357672AbiDSUkl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 16:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiDSUkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 16:40:39 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96C40919;
        Tue, 19 Apr 2022 13:37:55 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ef4a241cc5so178900177b3.2;
        Tue, 19 Apr 2022 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHxhl2p9BcyJjH5gP5zVW7eAlhTagXkGJ068+53FUhc=;
        b=cuMa2lRM+x87AKopkE+LfRRbGktPpPk3lfwa+cfelKQe/jqguClWdey6LgUgAgxETM
         aeKV/GVjim7yFQDJKZqVRfQQzQDHakZ9OUH9+6/eBmRmdxBPJHeyJO8gZYn3sSLglK4E
         S/HrYwEYBVZ8QKREvANtDkP3f6m2hjX8gsrNlVziYOR+Tc1kbx56s1rDZCA/UkV5KXhr
         42HooZesHEbRupzG68QWbWVkgwUuJRQT9BLqVyhQtsMJH6ug1NbiN9wD1M0ETLCJ5msX
         8xXjrAP9FWio4X9h4hwhBsOeWxSF6efSN4kN4Q+Ul1L4LjDB3QUKVxUUnz6Sp43cv4s0
         leWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHxhl2p9BcyJjH5gP5zVW7eAlhTagXkGJ068+53FUhc=;
        b=tAO0odkDCknpyQwt75VkrBqfec+WUvF8duoSAjyym+OzZC8mPlFYFYclBsHYWHoX/8
         NTCQ3EEnJPw4w2pezyi7moQwZ2W3IUFF4N2VKTXWfjoK/rRIahVVNIafz2actbGVSdlQ
         +QrFMCwWMhTopz8rsVnddeWZqV2P136LDUhbFg9E6w5HS+9boJzJp1X0GXMyWf4gB3cB
         7+5nFrMO6zVjiYGBqMUv4KqotjcxCDS698vtzinY8jVXu0ebrr3tHdmZCriIsODsarDe
         KeooqTKieTUhtTq5dPxeFTIptkMrjymwNvoNvRGTHf1tLeoF/0YNUJERjBY2aY902pCD
         HNTw==
X-Gm-Message-State: AOAM533H/+uA2ThNpshuqnjfVTAeE3KGfCh96F1jYSDagIplY9HgAcgz
        dgNvZYrVM3uxoXvyow2X6uuvFwI9iUfRDmZOEaU=
X-Google-Smtp-Source: ABdhPJzhJDLqDzfN8OElgAf4e+hinhCr3LANIeefHr67lZzbulARP8TD/SxudgC1vRbV5b5gsLvHoIiWb7GjhAg99xc=
X-Received: by 2002:a0d:ef84:0:b0:2f1:ac72:6e05 with SMTP id
 y126-20020a0def84000000b002f1ac726e05mr9156226ywe.241.1650400674442; Tue, 19
 Apr 2022 13:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220416110507.642398-1-pgwipeout@gmail.com> <20220416110507.642398-3-pgwipeout@gmail.com>
 <308e9c47197d4f7ae5a31cfcb5a10886@kernel.org> <CAMdYzYo+YeAgT92baMOoWpra230wro_WynRcajL-__9RNkeE9Q@mail.gmail.com>
 <87zgkk9gtc.wl-maz@kernel.org> <CAMdYzYo_+7rakc=GCTueEZvH_F4Co6+=eKAUztJaafiDXSKKXQ@mail.gmail.com>
 <87sfqaa7uv.wl-maz@kernel.org> <CAMdYzYouLoYX89EWjQTRAjd-1bvJEJtfYQa2KrtFH22Kp-4Efw@mail.gmail.com>
 <878rs2c8ay.wl-maz@kernel.org> <CAMdYzYqfitnPYSUEeeUB=x9=L9xzAu6o0SBmEdF8WKeb-+b6uQ@mail.gmail.com>
 <87r15ta469.wl-maz@kernel.org>
In-Reply-To: <87r15ta469.wl-maz@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 19 Apr 2022 16:37:42 -0400
Message-ID: <CAMdYzYrskyNXYiwKY-O=+_69x7T4asjrfo5KNGao-_6PCwq-gw@mail.gmail.com>
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

On Tue, Apr 19, 2022 at 4:05 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 19 Apr 2022 01:23:23 +0100,
> Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > > My only ask is that you properly initialise the HW. This will save
> > > countless amount of head-scratching once you have a decent firmware or
> > > kexec.
> >
> > The only way to ensure that in a sane way is to trigger the resets at
> > driver probe.
>
> If that can be done, that'd be great.

Okay, I'll work on implementing this then.

>
> > Can that be safely done without causing other issues with an already
> > configured card or should I power cycle it as well?
>
> Well, you are already renegotiating the link anyway, so that's a very
> moot point.

Understood, thank you.

>
> > This is starting to feature creep from the original intention of this
> > series, since a pre-configured controller would affect more than just
> > interrupts.
>
> Configuring the HW is not exactly a feature creep. If your intention
> is to keep everything as it was left, then you don't have much of a
> driver, but instead a time bomb. And we can do without another one in
> the tree.

Understood, I apologize if I'm being difficult here, I just want to
make sure I completely understand the assignment.
Your comment about kexec made it clear for me, thank you.

>
> > If you wish, as a compromise I can ensure all INTx interrupts are
> > masked at probe (which would hilariously be the opposite of
> > downstream).
>
> As far as I'm concerned, downstream doesn't exist. If someone wants
> the downstream code, they can use it directly and we don't need to
> merge this code.

Once again, you'll have no argument from me in this regard.
I've had several blocks of hardware enablement sitting out of tree
waiting for the phy code to land.
As much testing as my branch has seen, it's still only a drop in the
bucket compared to finally being mainlined.
I appreciate all of your effort and review here and I absolutely want
this done correctly.

>
> If, on the other hand, you want this driver to be useful and to be
> maintained upstream, initialising the interrupt mask is the absolute
> bare minimum.

I think resetting the whole core is the best move, since it's the only
way we can guarantee a sane configuration with the documentation we
have.

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
