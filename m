Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405902B18A9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 10:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKMJwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 04:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMJwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 04:52:44 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FBBC0613D6
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 01:52:31 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id w13so12428317eju.13
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 01:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sAPnUqkuDiKhQoJxuYmBfDJGGrKE4T/utkk3lGV54eY=;
        b=KdlnMs6AtWKy9C7hxX938qeabPHXiIvW80Ipv3MwL0+Zd5FfRh3D/SVM9SmgzPDX+y
         7Spg0tRo4MbCxtaXNIOissV4kqkaC8JRe4b/TAkHW2l+qzGW8ISdHr9kfeavSBgwEGvx
         bTTIXRAN5r5De9n0po5w2Lja9gWYzUz8RW8gA8LFHSJHS/Va1PSK99UxeqKtK23I4Euy
         /Iidcpmu3gOgNRzAl+EfnNBuHe/Wo+t8HjD2vdyDmDUuNDd+ibysIB/U7KID7mWNE8Ny
         Ou8gO5QsVwE6DrdNu4xINKpTNNx03/+YOPy6xEfqmPucBf7JsfPNOC9eF29j2SZcmDjX
         cj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sAPnUqkuDiKhQoJxuYmBfDJGGrKE4T/utkk3lGV54eY=;
        b=R0gjE6POCmzRqIAfdC/nAkklnMaC8VMr1JCiffwM7K89NqO38eI9Vb3fbUkLUXoCV4
         u9YRS4ds8MBSD6SeSoIfLTYubrc9ijRi4cc8rw1VblVllw4jxfTnY7QwpaCLOw1gTwzs
         yPDTpAj5f8xtyaYNo8EbQXXFmCpLPYhr6EX8UQKH3A0Dh0wILF7kNIuxkO28AZeIHCJP
         XSU14QKdln6rUZZfDiZen4lW8l0Mc9q9hBdh3um2MCEgTPlqLq8CM5rqyw8R78c+GTFZ
         h3OEETiQAgWMJy/jl5yVGILG7+3Myv62UrMXC2MVgbOqv12bx9egHktSoDuCULjkC8/c
         +Lvg==
X-Gm-Message-State: AOAM530fVwZASkKOl6vrzsmtb3iEBzTfRB6QsRhUC4DL4Npowk3pOqna
        2iMpqaS6C8qCQgWpaW24faNvl82yfOu5WtFMvEc2Hg==
X-Google-Smtp-Source: ABdhPJygtrkGUAGf0vhT+ialsN11r1P33/9mJCM9/tP+PxTytjWS1vOqzbkeFmw+W0HlNTkk3Tv1n2UX8TlpZlBTb3M=
X-Received: by 2002:a17:906:c41:: with SMTP id t1mr1116850ejf.19.1605261149728;
 Fri, 13 Nov 2020 01:52:29 -0800 (PST)
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
 <87pn4j2bna.fsf@codeaurora.org> <CAHUdJJXpfkNikreQ_JdpKDkwjEGN0oY8PyYT=aWsw1armz83Kw@mail.gmail.com>
In-Reply-To: <CAHUdJJXpfkNikreQ_JdpKDkwjEGN0oY8PyYT=aWsw1armz83Kw@mail.gmail.com>
From:   wi nk <wink@technolu.st>
Date:   Fri, 13 Nov 2020 10:52:18 +0100
Message-ID: <CAHUdJJU2XW+9AmV8aCcC=U2yMLUj4gQnU8=NHNte_X5WLgGGcg@mail.gmail.com>
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

On Thu, Nov 12, 2020 at 4:44 PM wi nk <wink@technolu.st> wrote:
>
> On Thu, Nov 12, 2020 at 10:00 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> > wi nk <wink@technolu.st> writes:
> >
> > > On Thu, Nov 12, 2020 at 8:15 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> > >>
> > >> Stefani Seibold <stefani@seibold.net> writes:
> > >>
> > >> > Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
> > >> >> I've yet to see any instability after 45 minutes of exercising it, I
> > >> >> do see a couple of messages that came out of the driver:
> > >> >>
> > >> >> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
> > >> >> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
> > >> >>
> > >> >> then when it associates:
> > >> >>
> > >> >> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> > >> >> [   16.722636] wlp85s0: authenticated
> > >> >> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> > >> >> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> > >> >> (capab=0x411 status=0 aid=8)
> > >> >> [   16.738443] wlp85s0: associated
> > >> >> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes
> > >> >> ready
> > >> >>
> > >> >> The adapter is achieving around 500 mbps on my gigabit connection, my
> > >> >> 2018 mbp sees around 650, so it's doing pretty well so far.
> > >> >>
> > >> >> Stefani - when you applied the patch that Kalle shared, which branch
> > >> >> did you apply it to?  I applied it to ath11k-qca6390-bringup and when
> > >> >> I revert 7fef431be9c9 there is a small merge conflict I needed to
> > >> >> resolve.  I wonder if either the starting branch, or your chosen
> > >> >> resolution are related to the instability you see (or I'm just lucky
> > >> >> so far! :)).
> > >> >>
> > >> >
> > >> > I used the vanilla kernel tree
> > >> > https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of this
> > >> > i applied the
> > >> >
> > >> > RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch
> > >> >
> > >> > and reverted the patch 7fef431be9c9
> > >>
> > >> I did also my testing on v5.10-rc2 and I recommend to use that as the
> > >> baseline when debuggin these ath11k problems. It helps to compare the
> > >> results if everyone have the same baseline.
> > >>
> > >> --
> > >> https://patchwork.kernel.org/project/linux-wireless/list/
> > >>
> > >> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> > >
> > > Absolutely, I'll rebuild to 5.10 later today and apply the same series
> > > of patches and report back.
> >
> > Great, thanks.
> >
> > > I'll also test out the patch on both versions from Carl to fix
> > > resuming. It stands to reason that we may be seeing another regression
> > > between Stefani (5.10) and myself (5.9 bringup branch) as I don't see
> > > any disconnections or instability once the interface is online.
> >
> > Yeah, there is something strange happening between v5.9 and v5.10 we
> > have not yet figured out. Most likely it has something to do with memory
> > allocations and DMA transfers failing, but no clear understanding yet.
> >
> > But to keep things simple let's only discuss the MSI problem on this
> > thread, and discuss the timeouts in the another thread:
> >
> > http://lists.infradead.org/pipermail/ath11k/2020-November/000641.html
> >
> > I'll include you and other reporters to that thread.
> >
> > --
> > https://patchwork.kernel.org/project/linux-wireless/list/
> >
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
> Ok, I've tried a clean checkout of 5.10-rc2 with the one MSI patch
> applied and 7fef431be9c9 reverted.  I can't get my machine to  boot
> into anything usable with that configuration.  I'm running ubuntu so
> its starting right into X and sometime between showing the available
> users and me clicking the icon to login the machine freezes.  I can
> see in the system tray that the wifi adapter is being activated and
> appears to have associated with an AP, I just can't do much beyond
> that as the keyboard backlight wakes up, but the caps lock key doesn't
> work.  I see similar behavior with the 5.9 configuration, but after a
> reboot or two I win whatever race is occuring.  With 5.10, I tried
> maybe 10-15 times with 0 success.

Kalle, what would be a useful next move for trying to hunt this?  It
seems I can't really test the single MSI patch on 5.10 since with the
patch (+ the reverted commit) the driver isn't stable enough for my
machine to stay running.  It seems your hunch is that this is related
to the issues in the other thread
(http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html)?
 I see the SOTA for debugging these things would be to use the kdump
tools and let the secondary kernel dump diagnostics for me.  Would
such logs be useful for you/this?

Thanks!
