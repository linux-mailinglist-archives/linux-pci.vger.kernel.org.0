Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE72B38EF
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 20:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgKOTze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 14:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgKOTze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 14:55:34 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE8FC0613CF
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2020 11:55:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id oq3so21453774ejb.7
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2020 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5nM1Cp39iy5bVLNTzfiQjcRIsGdFyVgBh8LybDWFVc=;
        b=un34enj3U770N2DIna9ITRJ6e0he+8AXTan21KvotS8gHhOu7ruN2cj1klpvykFYM/
         kZmohXD2uX17vctguE6CBv1huia2vxL4qIVEijO/C308FILJ7cTjYa6DllL1Xu4YPf0Q
         SG0C7RcVrWQYiFe4pxOJenhXz8L+YY7f5vqGmYQgEkzLcXbUbbwI2etumm1nOka7cXNN
         u9JA+wGQWbGyEtKhPjhj1T0o9nHzWGh8U4lcrwyyBS6WHtYJeAYLs6V3sAb9ke5W3Cnr
         5YnKYN32XkzlD7eq9B+X9EBU8nHrs4MmsvO9VKwZqV3q38vxQxDQZulWMIxCnAiwWv3Q
         gIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5nM1Cp39iy5bVLNTzfiQjcRIsGdFyVgBh8LybDWFVc=;
        b=pRXwUfReWltWOhHC2+psQTH4TGoNC91a7qKNWWvnl0SHBm5qRg/JUlpxKlJxuDY7+U
         raWh3y6tTp29uR/Pn7beVYHR0IcU7yxxQchNLLFFktHDkbNsolHClgK4cQd4SPasTRkm
         FNI6J6gFw7ZDh5rqLNEUbaXrUfNesmgylnZ5QWAfmhvuYBv8AX2+ZZi7nazhmPi6wsLN
         y9jJeTh8fWJDtezLhr4po1nBQn8IJXspBXMQVYsbRnGpo2di+6dgKORFuXRPSmHiZlPj
         qQyVGBYEUlpTXwApXiyEiMI+UdyUv2i4iwGIjbiwGqhEiBvl6HCqXaYp9+6J3IBu+Uvb
         45cw==
X-Gm-Message-State: AOAM533b9a/WKrJsZXVF/hk9KgJn2bTeMxBILV+JrS8y8SUFUk4OvWeR
        zedD6C0wF3DaS+WG2U6UO0ly6Cn5qbvx055lnpUZ0Q==
X-Google-Smtp-Source: ABdhPJw4HArYtv6BmPZzmR8XEH8QDDKZApBn1fjxXXKd+mqpbOikm26rRC3rOjEExRDnc9NF3DFg/WShSZt2g7FEygA=
X-Received: by 2002:a17:906:c41:: with SMTP id t1mr11622210ejf.19.1605470131112;
 Sun, 15 Nov 2020 11:55:31 -0800 (PST)
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
 <e4ba4457-bd08-42fe-ade7-32059367701a@posteo.de>
In-Reply-To: <e4ba4457-bd08-42fe-ade7-32059367701a@posteo.de>
From:   wi nk <wink@technolu.st>
Date:   Sun, 15 Nov 2020 20:55:20 +0100
Message-ID: <CAHUdJJVoi2_BnubtADpdLQoe1xAuHCvkPF-RMX=dnY3nXoTm5g@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Thomas Krause <thomaskrause@posteo.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 15, 2020 at 2:30 PM Thomas Krause <thomaskrause@posteo.de> wrote:
>
>
> Am 12.11.20 um 16:44 schrieb wi nk:
> > On Thu, Nov 12, 2020 at 10:00 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >> wi nk <wink@technolu.st> writes:
> >>
> >>> On Thu, Nov 12, 2020 at 8:15 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >>>> Stefani Seibold <stefani@seibold.net> writes:
> >>>>
> >>>>> Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
> >>>>>> I've yet to see any instability after 45 minutes of exercising it, I
> >>>>>> do see a couple of messages that came out of the driver:
> >>>>>>
> >>>>>> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
> >>>>>> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
> >>>>>>
> >>>>>> then when it associates:
> >>>>>>
> >>>>>> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> >>>>>> [   16.722636] wlp85s0: authenticated
> >>>>>> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> >>>>>> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> >>>>>> (capab=0x411 status=0 aid=8)
> >>>>>> [   16.738443] wlp85s0: associated
> >>>>>> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes
> >>>>>> ready
> >>>>>>
> >>>>>> The adapter is achieving around 500 mbps on my gigabit connection, my
> >>>>>> 2018 mbp sees around 650, so it's doing pretty well so far.
> >>>>>>
> >>>>>> Stefani - when you applied the patch that Kalle shared, which branch
> >>>>>> did you apply it to?  I applied it to ath11k-qca6390-bringup and when
> >>>>>> I revert 7fef431be9c9 there is a small merge conflict I needed to
> >>>>>> resolve.  I wonder if either the starting branch, or your chosen
> >>>>>> resolution are related to the instability you see (or I'm just lucky
> >>>>>> so far! :)).
> >>>>>>
> >>>>> I used the vanilla kernel tree
> >>>>> https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of this
> >>>>> i applied the
> >>>>>
> >>>>> RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch
> >>>>>
> >>>>> and reverted the patch 7fef431be9c9
> >>>> I did also my testing on v5.10-rc2 and I recommend to use that as the
> >>>> baseline when debuggin these ath11k problems. It helps to compare the
> >>>> results if everyone have the same baseline.
> >>>>
> >>>> --
> >>>> https://patchwork.kernel.org/project/linux-wireless/list/
> >>>>
> >>>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> >>> Absolutely, I'll rebuild to 5.10 later today and apply the same series
> >>> of patches and report back.
> >> Great, thanks.
> >>
> >>> I'll also test out the patch on both versions from Carl to fix
> >>> resuming. It stands to reason that we may be seeing another regression
> >>> between Stefani (5.10) and myself (5.9 bringup branch) as I don't see
> >>> any disconnections or instability once the interface is online.
> >> Yeah, there is something strange happening between v5.9 and v5.10 we
> >> have not yet figured out. Most likely it has something to do with memory
> >> allocations and DMA transfers failing, but no clear understanding yet.
> >>
> >> But to keep things simple let's only discuss the MSI problem on this
> >> thread, and discuss the timeouts in the another thread:
> >>
> >> http://lists.infradead.org/pipermail/ath11k/2020-November/000641.html
> >>
> >> I'll include you and other reporters to that thread.
> >>
> >> --
> >> https://patchwork.kernel.org/project/linux-wireless/list/
> >>
> >> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> > Ok, I've tried a clean checkout of 5.10-rc2 with the one MSI patch
> > applied and 7fef431be9c9 reverted.  I can't get my machine to  boot
> > into anything usable with that configuration.  I'm running ubuntu so
> > its starting right into X and sometime between showing the available
> > users and me clicking the icon to login the machine freezes.  I can
> > see in the system tray that the wifi adapter is being activated and
> > appears to have associated with an AP, I just can't do much beyond
> > that as the keyboard backlight wakes up, but the caps lock key doesn't
> > work.  I see similar behavior with the 5.9 configuration, but after a
> > reboot or two I win whatever race is occuring.  With 5.10, I tried
> > maybe 10-15 times with 0 success.
>
> I can confirm this behavior on my configuration. I managed to login once
> and select the Wifi and connect to it. It seemed curiously enough be
> stable long enough to enter the Wifi passphrase. After the connection
> was established, the system hang and on each attempt to reboot into the
> graphical system it would freeze at some point (sometimes even before
> showing the login screen).
>
> Kernel was both based on 5.10-rc2 and 5.10-rc3 (I did see the same
> behavior) with the patch applied, 7fef431be9c9 reverted and firmware
> downloaded and copied to /lib/firmware/ath11k/QCA6390/hw2.0/.
>
>

I did a bit more digging to see if I could find any new information,
I'm not sure I did but here's what I did / found.  I spent the time to
get a kdump kernel running and enabled, I was able to SysRq-C (both
via keyboard and echo c > /proc/sysrq-trigger) and generate a crash
dump.  Actually viewing them at the moment will require reverting a
couple of patches to printk to fix the file for the crash utility
(https://github.com/crash-utility/crash/issues/67), but right now
that's not super important since the mechanism isn't being triggered.
As reported here and by Mitchell, the adapter will work occasionally,
but more often it will hang the machine (I too tried 5.10-rc3 with no
noticable differences).  Whatever is causing the system to hang isn't
triggering the kdump kernel to take over and dump the vmcore.  I've
set watchdog=1 , nmi_watchdog=1, hung_task_panic=1, softlockup_panic=1
trying to convince the kernel to dump it's state during this.  I've
not been able to make it write a crash, it just sits 'hung'.  One
interesting observation that may be related, is that if the lockup
occurs during my login, I can actually see the system grind to a halt
over the course of a number of frames (the rendering of the login
animations starts to stutter/get really slow, then after a few frames
everything is frozen).  If something were spin locking/ed, I'd expect
the soft lockup panic to find it, but I don't know these mechanisms
well.

The only consistent behavior that I managed to create is that if the
wifi adapter / machine are in a 'working' state (ie: I can browse the
internet, etc) and I issue sysrq-c to crash the kernel and then let
the crash dump write and reboot the machine, once booted the adapter
is no longer seen by the kernel, and there are zero messages in dmesg
that match "ath11k".  The driver shows up in lsmod , but it reports
zero messages and it's like the adapter is completely invisible.  A
power off and back on of the machine will re-enter it into the
freezing/wifi working lottery.
