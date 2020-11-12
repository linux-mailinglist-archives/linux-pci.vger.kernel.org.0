Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF422AFD58
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 02:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKLBb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 20:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgKLBKb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 20:10:31 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40DC0613D6
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 17:10:30 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id e18so4339505edy.6
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 17:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2MV6sEGObJ+BD/sFs6H86mUXgsooPRIOrewrU3Scb3Y=;
        b=Oc5LcDnX0NjHLM4cSPlFxTOanWcqzovUo2SZJN7ehzphA6YZ7V5HQi/H6k+DwMnxJu
         ZlvdIlwjyBwwARCVmPNAG1Xif5wNc2VEkhRsqadAkrvtBZQTT9HiKRaXUuTZ4SyKKOf5
         NM7MebtQif3ty5MT5k+4hVOnARON5zlDDg4bo5f2maszKQfxvGy8c8uEunsy5QB/2UDZ
         EUMdyl1t9Os2/pxbbsYJkgHb9pnusdtwvJOOKMkkk1K8ztaocqYqtEpbYqb4SzfF4eI8
         FlRHw4/KiF2yQByBDJmPMdFG+G8NSOsR+zUEBL6llGJSBFg74HE6KK3OuX9+J6IptSsA
         Pgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2MV6sEGObJ+BD/sFs6H86mUXgsooPRIOrewrU3Scb3Y=;
        b=S3fyGDYRONEEeBu255Hk1s5+Vk7mRga9fYAFsdG3O3qFkhLvDAUPv8PdZ48DXc16tC
         55y9FSXTjhuBu0PhJvFqgRGCikcS4h5r06NKFp918iZ5K6rq+WhJTcFhjdcgqJisplRB
         ZPj7aORsvx4f0CFeWkDlvc0vP6vHHaLr3oPN2MpdM1e7AKIoP/MTHAo96FmBlX1f5wa3
         jAFVJMT5OgHekE3GayT9IRAeHBcKOhxcpYFg0OtXHMoEIBzgv+CizT7GAKtIzCaiKeWs
         Xb+Lo/bKJDFO3cSkB3nryHn41/Vjy8yvjKAjNnuQsgZ0GOQ4a2LQEDcPnydZ/NMLjnws
         octg==
X-Gm-Message-State: AOAM531CoxNNhzcRcHStkduZ8VIeYinw0ykJmxSLHsaC8QNqPQpB22z7
        3won0NIOaU1Tmtqu7fYuS3ninymFQlTRi2hI3iEwGw==
X-Google-Smtp-Source: ABdhPJxP8vLVdIhISz8A+knmSJfxgrEiOkw/OM0BExfX9WZbuFh0MWZ+JJSMVbwoEyXrPigrc4VSqusgbKjRZi9EtiM=
X-Received: by 2002:a50:d315:: with SMTP id g21mr2557302edh.84.1605143429277;
 Wed, 11 Nov 2020 17:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org> <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
 <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
In-Reply-To: <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
From:   wi nk <wink@technolu.st>
Date:   Thu, 12 Nov 2020 02:10:18 +0100
Message-ID: <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Stefani Seibold <stefani@seibold.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Thomas Krause <thomaskrause@posteo.de>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've yet to see any instability after 45 minutes of exercising it, I
do see a couple of messages that came out of the driver:

[    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
[   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a

then when it associates:

[   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
[   16.722636] wlp85s0: authenticated
[   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
[   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
(capab=0x411 status=0 aid=8)
[   16.738443] wlp85s0: associated
[   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes ready

The adapter is achieving around 500 mbps on my gigabit connection, my
2018 mbp sees around 650, so it's doing pretty well so far.

Stefani - when you applied the patch that Kalle shared, which branch
did you apply it to?  I applied it to ath11k-qca6390-bringup and when
I revert 7fef431be9c9 there is a small merge conflict I needed to
resolve.  I wonder if either the starting branch, or your chosen
resolution are related to the instability you see (or I'm just lucky
so far! :)).

On Thu, Nov 12, 2020 at 1:24 AM wi nk <wink@technolu.st> wrote:
>
> On Wed, Nov 11, 2020 at 11:02 PM Stefani Seibold <stefani@seibold.net> wrote:
> >
> > On Wed, 2020-11-11 at 21:10 +0200, Kalle Valo wrote:
> > >
> > > The proof of concept patch for v5.10-rc2 is here:
> > >
> > > https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
> > >
> > > Hopefully it makes it possible to boot the firmware now. But this is
> > > a
> > > quick hack and most likely buggy, so keep your expectations low :)
> > >
> > > In case there are these warnings during firmware initialisation:
> > >
> > > ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> > > ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> > >
> > > Try reverting this commit:
> > >
> > > 7fef431be9c9 mm/page_alloc: place pages to tail in
> > > __free_pages_core()
> > >
> > > That's another issue which is debugged here:
> > >
> > > http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
> > >
> >
> > Applying the patch and revert patch 7fef431be9c9 worked on the first
> > glance.
> >
> > After a couple of minutes the connection get broken. The kernel log
> > shows the following error:
> >
> > ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> > ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
> > ath11k_pc
> > i 0000:55:00.0: failed to enable PMF QOS: (-11
> >
> > It is also not possible to unload the ath11k_pci, rmmod will hang.
> >
> >
>
> I can confirm the same behavior as Stefani so far.  After applying the
> patch, and reverting commit 7fef431be9c9, I am able to connect to a
> network.  It hasn't disconnected yet (I'm sending this email via that
> connection).  I'll report what I find next.
>
> Thanks again for the help!
