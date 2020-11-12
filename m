Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE212AFE8B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 06:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgKLFjB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 00:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgKLCcM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 21:32:12 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4DC0613D4
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 18:32:10 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so5584208ejk.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 18:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUzPg8y73vRxlAHH+zIia8Krjs+sYU9K0sC28KymEQY=;
        b=OFdfsyF59is2mlKKEZpxTJE38bU0jQpXcEKm0WKQv7bmSSLkS09VKmuD1R/V971ynM
         S3kh+zrHT/CWrjm0Ok6zUt2BiFhf56JU6hrhTQ9DThImfqMzK6eiDFzLaDgD8+6sDkPs
         dp64eW4FkOefdJbTYHBpvs2vRDNTyd1nvf5mkoRC5ijYPYziFUC2OemDikc/ZdvLPkSw
         MMuibtWAT4mKpeYRH4Y4nQNRWs3Rn4HB1RTYO8aeZHMV8IzR0uxD1hM5JoFHIjXqNzeB
         /licFcwyMdkqPLzMsrIyz5cvfcaMNZ0lebxqAla8KGzlHc545aPNvfysBlVFhPDMKTHP
         JFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUzPg8y73vRxlAHH+zIia8Krjs+sYU9K0sC28KymEQY=;
        b=sMqhePK9JszQG91F5CmUGPCij4IWYdjhef+QysypRsSBKIgTJ/QIuTsqNUrsQn7fa6
         VDYK6x0IMxKco4wH+VL2th4WCrGDJLgP4fHVVUMBY6re5hgVDV6ofe1F06GBE9MN2NER
         Txdag3QbbGM5ecOnXm/ol1sSUnJeb1HE4vWBYFLJLdE837D1s1CFBnXX3DIFlm1crZaX
         dZHGjFX4SJUGqbW7gPTpjwbyPzMCfOd0+1lNtHVxXqAzsDNyrL1tMQ0Mj0LK6wLRf+54
         RWCfly47oUOhArliWt9k5Szxl7uQRVABWOLmBwteNllPihRTst+TE0LdlPrE7+GPjnXe
         QCXA==
X-Gm-Message-State: AOAM530NikBxnqpgDS6/VkawKeopqfVEB4zd3X7iuRfnehpfwRZ/Nj6H
        C43Zy2ace1pykgHv/vH7YvIDLDt4j24q6muTSXfbwg==
X-Google-Smtp-Source: ABdhPJwknRlumIb+H14ad0cYTJI1zbP/rZ/TYVSzcwrQHSiyzy4KNPJ/xC5Llo26hk8i+tHzwh7VpyOhT3s2+ovFnvw=
X-Received: by 2002:a17:906:4c41:: with SMTP id d1mr29697883ejw.485.1605148329262;
 Wed, 11 Nov 2020 18:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org> <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
 <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
 <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com> <CAHUdJJUkvcShSXw4mkFUDcEh101xNQbOUc0YEv6-TyLdyTs4Og@mail.gmail.com>
In-Reply-To: <CAHUdJJUkvcShSXw4mkFUDcEh101xNQbOUc0YEv6-TyLdyTs4Og@mail.gmail.com>
From:   wi nk <wink@technolu.st>
Date:   Thu, 12 Nov 2020 03:31:57 +0100
Message-ID: <CAHUdJJWsCo6NJ6qr6kj=SASs+jO+fJFc3HhOO=fyek=OxSQa2Q@mail.gmail.com>
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

On Thu, Nov 12, 2020 at 2:11 AM wi nk <wink@technolu.st> wrote:
>
> On Thu, Nov 12, 2020 at 2:10 AM wi nk <wink@technolu.st> wrote:
> >
> > I've yet to see any instability after 45 minutes of exercising it, I
> > do see a couple of messages that came out of the driver:
> >
> > [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
> > [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
> >
> > then when it associates:
> >
> > [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> > [   16.722636] wlp85s0: authenticated
> > [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> > [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> > (capab=0x411 status=0 aid=8)
> > [   16.738443] wlp85s0: associated
> > [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes ready
> >
> > The adapter is achieving around 500 mbps on my gigabit connection, my
> > 2018 mbp sees around 650, so it's doing pretty well so far.
> >
> > Stefani - when you applied the patch that Kalle shared, which branch
> > did you apply it to?  I applied it to ath11k-qca6390-bringup and when
> > I revert 7fef431be9c9 there is a small merge conflict I needed to
> > resolve.  I wonder if either the starting branch, or your chosen
> > resolution are related to the instability you see (or I'm just lucky
> > so far! :)).
> >
> > On Thu, Nov 12, 2020 at 1:24 AM wi nk <wink@technolu.st> wrote:
> > >
> > > On Wed, Nov 11, 2020 at 11:02 PM Stefani Seibold <stefani@seibold.net> wrote:
> > > >
> > > > On Wed, 2020-11-11 at 21:10 +0200, Kalle Valo wrote:
> > > > >
> > > > > The proof of concept patch for v5.10-rc2 is here:
> > > > >
> > > > > https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
> > > > >
> > > > > Hopefully it makes it possible to boot the firmware now. But this is
> > > > > a
> > > > > quick hack and most likely buggy, so keep your expectations low :)
> > > > >
> > > > > In case there are these warnings during firmware initialisation:
> > > > >
> > > > > ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> > > > > ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> > > > >
> > > > > Try reverting this commit:
> > > > >
> > > > > 7fef431be9c9 mm/page_alloc: place pages to tail in
> > > > > __free_pages_core()
> > > > >
> > > > > That's another issue which is debugged here:
> > > > >
> > > > > http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
> > > > >
> > > >
> > > > Applying the patch and revert patch 7fef431be9c9 worked on the first
> > > > glance.
> > > >
> > > > After a couple of minutes the connection get broken. The kernel log
> > > > shows the following error:
> > > >
> > > > ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> > > > ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
> > > > ath11k_pc
> > > > i 0000:55:00.0: failed to enable PMF QOS: (-11
> > > >
> > > > It is also not possible to unload the ath11k_pci, rmmod will hang.
> > > >
> > > >
> > >
> > > I can confirm the same behavior as Stefani so far.  After applying the
> > > patch, and reverting commit 7fef431be9c9, I am able to connect to a
> > > network.  It hasn't disconnected yet (I'm sending this email via that
> > > connection).  I'll report what I find next.
> > >
> > > Thanks again for the help!
>
> Sigh.... sorry for the top post again.  I'll now get a real email client.

So the connection remained super stable for a while, so I decided to
tempt fate and suspend the laptop to see what would happen :).

[ 5994.143715] PM: suspend exit
[ 5997.260351] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[ 5997.260353] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[ 5997.260356] ath11k_pci 0000:55:00.0: failed to enable dynamic bw: -11
[ 6000.332299] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[ 6000.332303] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[ 6000.332308] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
[ 6003.404365] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[ 6003.404368] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[ 6003.404373] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
[ 6016.204347] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[ 6016.204351] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[ 6016.204357] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
[ 6019.276319] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[ 6019.276323] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[ 6019.276329] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
[ 6031.052272] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[ 6031.052275] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[ 6031.052279] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
[ 6034.128257] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
[ 6034.128261] ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
[ 6034.128265] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
[ 6039.500241] ath11k_pci 0000:55:00.0: qmi failed set mode request,
mode: 4, err = -110
[ 6039.500244] ath11k_pci 0000:55:00.0: qmi failed to send wlan mode off

I was able to remove the ath11k module using rmmod -f , and then
modprobe ath11k + atk11k_pci and the device was able to reassociate
and bring the connection back up.
