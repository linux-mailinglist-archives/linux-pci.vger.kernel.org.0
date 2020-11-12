Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217992AFBFD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 02:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgKLBb1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 20:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgKLBMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 20:12:32 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A9C061A48
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 17:11:27 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id o9so5379853ejg.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 17:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFCtis8RMvpDH0LV6+B1UizWzLwWkm5y+UkEj7eA6fI=;
        b=bsJw5TnHrOYGZ6z6koJHWMYr62oFDE2M9tzcNlHR4+NA9bAvX20jEo133dJu6sefRQ
         SAozTyjA5ERI451RWiW1FfJBBgJJe+Kjybu2DIZfMN6M+6nxjvEr/jlJMivppghkYn7D
         euGYQaRhOgYqdybdsP673IFrBa4zskDNANg7QboGdMXXlsbfVKPa6+e2rzEW5MT7Zc56
         oCb3DUC4/owxfv+SFdqEOZhuhRxnWdra258h7HTiyXpzhuuO0xVrAIfcVVWNrLLSJ4Be
         p+89SPXD81mNtHzdWh/g9Vtar5Va7NM6ziUJHtlxFGn7DUy3x5XOZgtp5JHMAAKqce7N
         fqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFCtis8RMvpDH0LV6+B1UizWzLwWkm5y+UkEj7eA6fI=;
        b=U+Ng+tGT4pCaRU3gobwNGGMtBMQgctGOO/bSTrS/Ywv5Ur9H7d1BLZg7T7ctCRwvMs
         bWXlQBmA6qe6GL8GRwBZiPGJFBkZ2BlumGfInnFXrwJbXo1dMyAF/I/dxr7ObN/+dhsC
         VF+qmKNKNeg+pFUKI+AaOeeh8qV5hlNErKJjXRGfm6MWuIk0exLiOIog/0OXW0I7wWGI
         W7nWPDLwzXdDQEZ++187z6oL9vp0iXiJ8gb7NW40Tz2QY9HrO3oFp+jX9J9f3R0siWMI
         sv2DywjOeUZDBNhqZPmpEjqJGqcFcKmDovar3NEZCja1Dk20r644S1G/Bf3rqPmf179Q
         rdmA==
X-Gm-Message-State: AOAM530O9G6oMLG/4/ABIPLLzT0Hc8OzTfTD7MSM9lCeKy85iJuoUmWk
        FG4f2E99s9bSRw41otxCeohBMHKQ6wDnUxgo8CqktQ==
X-Google-Smtp-Source: ABdhPJw8CbrtZOsD2SBgGSK03NgviwnC9hYlEHajxxXUANkdrm61lGkM9yqL3uG0jb6Co03N61vKRB0+1oFIsvgk1nw=
X-Received: by 2002:a17:906:77c5:: with SMTP id m5mr28216170ejn.424.1605143486536;
 Wed, 11 Nov 2020 17:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org> <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
 <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com> <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
In-Reply-To: <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
From:   wi nk <wink@technolu.st>
Date:   Thu, 12 Nov 2020 02:11:15 +0100
Message-ID: <CAHUdJJUkvcShSXw4mkFUDcEh101xNQbOUc0YEv6-TyLdyTs4Og@mail.gmail.com>
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

On Thu, Nov 12, 2020 at 2:10 AM wi nk <wink@technolu.st> wrote:
>
> I've yet to see any instability after 45 minutes of exercising it, I
> do see a couple of messages that came out of the driver:
>
> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
>
> then when it associates:
>
> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> [   16.722636] wlp85s0: authenticated
> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> (capab=0x411 status=0 aid=8)
> [   16.738443] wlp85s0: associated
> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes ready
>
> The adapter is achieving around 500 mbps on my gigabit connection, my
> 2018 mbp sees around 650, so it's doing pretty well so far.
>
> Stefani - when you applied the patch that Kalle shared, which branch
> did you apply it to?  I applied it to ath11k-qca6390-bringup and when
> I revert 7fef431be9c9 there is a small merge conflict I needed to
> resolve.  I wonder if either the starting branch, or your chosen
> resolution are related to the instability you see (or I'm just lucky
> so far! :)).
>
> On Thu, Nov 12, 2020 at 1:24 AM wi nk <wink@technolu.st> wrote:
> >
> > On Wed, Nov 11, 2020 at 11:02 PM Stefani Seibold <stefani@seibold.net> wrote:
> > >
> > > On Wed, 2020-11-11 at 21:10 +0200, Kalle Valo wrote:
> > > >
> > > > The proof of concept patch for v5.10-rc2 is here:
> > > >
> > > > https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
> > > >
> > > > Hopefully it makes it possible to boot the firmware now. But this is
> > > > a
> > > > quick hack and most likely buggy, so keep your expectations low :)
> > > >
> > > > In case there are these warnings during firmware initialisation:
> > > >
> > > > ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> > > > ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> > > >
> > > > Try reverting this commit:
> > > >
> > > > 7fef431be9c9 mm/page_alloc: place pages to tail in
> > > > __free_pages_core()
> > > >
> > > > That's another issue which is debugged here:
> > > >
> > > > http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
> > > >
> > >
> > > Applying the patch and revert patch 7fef431be9c9 worked on the first
> > > glance.
> > >
> > > After a couple of minutes the connection get broken. The kernel log
> > > shows the following error:
> > >
> > > ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> > > ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
> > > ath11k_pc
> > > i 0000:55:00.0: failed to enable PMF QOS: (-11
> > >
> > > It is also not possible to unload the ath11k_pci, rmmod will hang.
> > >
> > >
> >
> > I can confirm the same behavior as Stefani so far.  After applying the
> > patch, and reverting commit 7fef431be9c9, I am able to connect to a
> > network.  It hasn't disconnected yet (I'm sending this email via that
> > connection).  I'll report what I find next.
> >
> > Thanks again for the help!

Sigh.... sorry for the top post again.  I'll now get a real email client.
