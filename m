Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB42B08AF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 16:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgKLPoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 10:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgKLPoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 10:44:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2DC0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 07:44:18 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t9so6787111edq.8
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZYSgbLgcFtBhxOEkI6MpXLGBNFPcT15SB8w4SZEAJQ=;
        b=Hz4y80cnGthVh/REHCiC35b2CB7bCQ0I2SGtIgLNXfuDBJHEGmwoqq5N+vCgobNxvP
         /GXIy4AztB1mDVZr8EVJ15AdEmVYBNiT/OvLtO4WHPUy9vHSKVqae0hY3jdM+JCLvmM2
         BWc6pfIKHlv+bIwVwnpUY4/q2kxdLvZeRL7h51tdVodUcHm/zKZOECo1jwDEl30lEHgJ
         5N+UFXn+T6LeS+zjzrI/Gbm3QU0ItFNxshb6x+yqlliC5f70jfES0jUy8XuIcva2ukcU
         3lzt/2tWhdlYWqLZfkwVBC2E8NgWXWpCcog2PqI1OUyJZYrhy0yDIYfikojGbBi/irh3
         Gamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZYSgbLgcFtBhxOEkI6MpXLGBNFPcT15SB8w4SZEAJQ=;
        b=Ucqwxs+ZY2Y4pR14PBH7N7W3HylToVS8ZKG4AIXtNhWYUcUhRyoV/G7E96YD9DUbd+
         pFnXx5pwmOb5pjgrfTgKbFsGtVnHrffhWyXPNkUwQ868iWieVqLHrUoNA+aIfeVTyzNO
         I4QEGInml++NweuciSlRt2w7Mmtiskqs8GrX02EGYxYhmlAkGHtGcP1Tepyar+lKJRal
         zLe+06xGb7OIGRoJqqEH0qvPoY6le7kTed2gfYWQHqSZ/NHCkXpZQtKqhpZpVuloI7gq
         YF79ZNvgBH3dWdqDxSmnbSiPo+30LUNw5gwbreqnIXrkJW1Ap7MO7n/h1OymJTt17viX
         UrFA==
X-Gm-Message-State: AOAM530W19lHj8OXsKEEzTGAf4aJQ4TCKw0k6lCnoMWSSBgrzY47iOMb
        tjgH597pBzSWOgU6KQ2jDFBQyKfWUR/3u7TUq0FQmg==
X-Google-Smtp-Source: ABdhPJy1bFNKfm53aGoqW7ZAfOcry0HYeaX0AVrT6lyphbebboQN0DrPRNp9Hy6sPZrWXEoRBDFcxp9dtjnwAo1p/aE=
X-Received: by 2002:aa7:da44:: with SMTP id w4mr336421eds.131.1605195855709;
 Thu, 12 Nov 2020 07:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org> <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
 <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
 <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
 <0b58872b4f27dbf5aad2a39f5ec4a066e080d806.camel@seibold.net>
 <875z6b3v22.fsf@codeaurora.org> <CAHUdJJVK1vH2_9YkCQ99n5mak3oGN09422gG0APkWwcy=ZDQ-Q@mail.gmail.com>
 <87pn4j2bna.fsf@codeaurora.org>
In-Reply-To: <87pn4j2bna.fsf@codeaurora.org>
From:   wi nk <wink@technolu.st>
Date:   Thu, 12 Nov 2020 16:44:04 +0100
Message-ID: <CAHUdJJXpfkNikreQ_JdpKDkwjEGN0oY8PyYT=aWsw1armz83Kw@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Krause <thomaskrause@posteo.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 10:00 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> wi nk <wink@technolu.st> writes:
>
> > On Thu, Nov 12, 2020 at 8:15 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >>
> >> Stefani Seibold <stefani@seibold.net> writes:
> >>
> >> > Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
> >> >> I've yet to see any instability after 45 minutes of exercising it, I
> >> >> do see a couple of messages that came out of the driver:
> >> >>
> >> >> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
> >> >> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
> >> >>
> >> >> then when it associates:
> >> >>
> >> >> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> >> >> [   16.722636] wlp85s0: authenticated
> >> >> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> >> >> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> >> >> (capab=0x411 status=0 aid=8)
> >> >> [   16.738443] wlp85s0: associated
> >> >> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes
> >> >> ready
> >> >>
> >> >> The adapter is achieving around 500 mbps on my gigabit connection, my
> >> >> 2018 mbp sees around 650, so it's doing pretty well so far.
> >> >>
> >> >> Stefani - when you applied the patch that Kalle shared, which branch
> >> >> did you apply it to?  I applied it to ath11k-qca6390-bringup and when
> >> >> I revert 7fef431be9c9 there is a small merge conflict I needed to
> >> >> resolve.  I wonder if either the starting branch, or your chosen
> >> >> resolution are related to the instability you see (or I'm just lucky
> >> >> so far! :)).
> >> >>
> >> >
> >> > I used the vanilla kernel tree
> >> > https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of this
> >> > i applied the
> >> >
> >> > RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch
> >> >
> >> > and reverted the patch 7fef431be9c9
> >>
> >> I did also my testing on v5.10-rc2 and I recommend to use that as the
> >> baseline when debuggin these ath11k problems. It helps to compare the
> >> results if everyone have the same baseline.
> >>
> >> --
> >> https://patchwork.kernel.org/project/linux-wireless/list/
> >>
> >> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> >
> > Absolutely, I'll rebuild to 5.10 later today and apply the same series
> > of patches and report back.
>
> Great, thanks.
>
> > I'll also test out the patch on both versions from Carl to fix
> > resuming. It stands to reason that we may be seeing another regression
> > between Stefani (5.10) and myself (5.9 bringup branch) as I don't see
> > any disconnections or instability once the interface is online.
>
> Yeah, there is something strange happening between v5.9 and v5.10 we
> have not yet figured out. Most likely it has something to do with memory
> allocations and DMA transfers failing, but no clear understanding yet.
>
> But to keep things simple let's only discuss the MSI problem on this
> thread, and discuss the timeouts in the another thread:
>
> http://lists.infradead.org/pipermail/ath11k/2020-November/000641.html
>
> I'll include you and other reporters to that thread.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Ok, I've tried a clean checkout of 5.10-rc2 with the one MSI patch
applied and 7fef431be9c9 reverted.  I can't get my machine to  boot
into anything usable with that configuration.  I'm running ubuntu so
its starting right into X and sometime between showing the available
users and me clicking the icon to login the machine freezes.  I can
see in the system tray that the wifi adapter is being activated and
appears to have associated with an AP, I just can't do much beyond
that as the keyboard backlight wakes up, but the caps lock key doesn't
work.  I see similar behavior with the 5.9 configuration, but after a
reboot or two I win whatever race is occuring.  With 5.10, I tried
maybe 10-15 times with 0 success.
