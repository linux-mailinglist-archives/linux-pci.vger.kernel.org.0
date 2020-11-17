Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9522B690F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgKQPts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 10:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQPts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 10:49:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E2FC0617A6
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 07:49:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f23so30152482ejk.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2020 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DPLyMD10PeYkijOwRrJDtclP3Mop2qKv+wAnTfFZv0=;
        b=wMmatarnIxEyWFb8Hgh7f0sucLVfOpndV5Mi1JqTnM8D4jHW7lpBNfaXANlCTsckey
         WJMyIxX1aN+EFcO0Pm057R4ri+b2HXnjC4EX81fF8nvQwD9xyGEd3DURC/z1nA+C5jng
         11rGVdmzbBYb9dsj14yy91/lOrbuDQDohRIM8L7eHEXKolM/L7JU/Ppfg0RksKOSmbNU
         hM9RryiXno+nfbXsJcuX3S6iTbmBteGjC5/QkLHfEZT43INevs6jzBZrLaNrYrGJ51mN
         XTZIrdVFSLbNEmhBAeYqzRli/0HUm9sNUmcuUiuvPkTD1fZMav48do19D8KsMrfb5PQ0
         ve/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DPLyMD10PeYkijOwRrJDtclP3Mop2qKv+wAnTfFZv0=;
        b=kv/z9sm+b+UnQ070YEF2sQz2Ur+8H80vdpMe/RpWljjkz468zS7lbqjQwHtdYjKbVe
         e5CRDGmScJgdG6IPVK4GrP3pfh+BZBQTqvKUqE/2gpqReTo8kAd3ZP1M4PnL9recZg92
         /+pH65wVn+bO+HbMGr4mbhpzFtTn1v8+ruzVSSdXQadO4IJYrMAG0vu9m9wnr3G9yeCA
         31j+ohNO/tayKspxWFPCwgT2NABorQK+PAwjJMlqY/7zk1pBjuydSoMTYlg7nAij1Qro
         2CWfiqg/Jqd4Ky57THN2KndoZQXphNbbOKNUINF7qe+LQEwbztoDU+zPbCWx/ZmVZiFu
         Kqzw==
X-Gm-Message-State: AOAM533PLZ3JB8/BQjub71+D2gOqsAXXrFwIytuPXR4fRjXUOa7PYkHp
        CuqaBT7WevKIe3Lofg/6NM+qskKfh2fj8RJh3swNBA==
X-Google-Smtp-Source: ABdhPJzxBKBkfRqBPj4jMIyy0nvFm9wGqdlxU84Fw6g3q4w52ESWX1KjbGT+uaXMtKJgygkgPzIlhxKdQ50jQLvAMjY=
X-Received: by 2002:a17:906:c41:: with SMTP id t1mr19872996ejf.19.1605628185669;
 Tue, 17 Nov 2020 07:49:45 -0800 (PST)
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
 <e4ba4457-bd08-42fe-ade7-32059367701a@posteo.de> <CAHUdJJVoi2_BnubtADpdLQoe1xAuHCvkPF-RMX=dnY3nXoTm5g@mail.gmail.com>
In-Reply-To: <CAHUdJJVoi2_BnubtADpdLQoe1xAuHCvkPF-RMX=dnY3nXoTm5g@mail.gmail.com>
From:   wi nk <wink@technolu.st>
Date:   Tue, 17 Nov 2020 16:49:34 +0100
Message-ID: <CAHUdJJXy4FvmTeO648QMst9-bm1asqjZz=ktkps3ug4Hw=UweQ@mail.gmail.com>
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

On Sun, Nov 15, 2020 at 8:55 PM wi nk <wink@technolu.st> wrote:
>
> On Sun, Nov 15, 2020 at 2:30 PM Thomas Krause <thomaskrause@posteo.de> wrote:
> >
> >
> > Am 12.11.20 um 16:44 schrieb wi nk:
> > > On Thu, Nov 12, 2020 at 10:00 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> > >> wi nk <wink@technolu.st> writes:
> > >>
> > >>> On Thu, Nov 12, 2020 at 8:15 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> > >>>> Stefani Seibold <stefani@seibold.net> writes:
> > >>>>
> > >>>>> Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
> > >>>>>> I've yet to see any instability after 45 minutes of exercising it, I
> > >>>>>> do see a couple of messages that came out of the driver:
> > >>>>>>
> > >>>>>> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
> > >>>>>> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
> > >>>>>>
> > >>>>>> then when it associates:
> > >>>>>>
> > >>>>>> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> > >>>>>> [   16.722636] wlp85s0: authenticated
> > >>>>>> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> > >>>>>> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> > >>>>>> (capab=0x411 status=0 aid=8)
> > >>>>>> [   16.738443] wlp85s0: associated
> > >>>>>> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes
> > >>>>>> ready
> > >>>>>>
> > >>>>>> The adapter is achieving around 500 mbps on my gigabit connection, my
> > >>>>>> 2018 mbp sees around 650, so it's doing pretty well so far.
> > >>>>>>
> > >>>>>> Stefani - when you applied the patch that Kalle shared, which branch
> > >>>>>> did you apply it to?  I applied it to ath11k-qca6390-bringup and when
> > >>>>>> I revert 7fef431be9c9 there is a small merge conflict I needed to
> > >>>>>> resolve.  I wonder if either the starting branch, or your chosen
> > >>>>>> resolution are related to the instability you see (or I'm just lucky
> > >>>>>> so far! :)).
> > >>>>>>
> > >>>>> I used the vanilla kernel tree
> > >>>>> https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of this
> > >>>>> i applied the
> > >>>>>
> > >>>>> RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch
> > >>>>>
> > >>>>> and reverted the patch 7fef431be9c9
> > >>>> I did also my testing on v5.10-rc2 and I recommend to use that as the
> > >>>> baseline when debuggin these ath11k problems. It helps to compare the
> > >>>> results if everyone have the same baseline.
> > >>>>
> > >>>> --
> > >>>> https://patchwork.kernel.org/project/linux-wireless/list/
> > >>>>
> > >>>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> > >>> Absolutely, I'll rebuild to 5.10 later today and apply the same series
> > >>> of patches and report back.
> > >> Great, thanks.
> > >>
> > >>> I'll also test out the patch on both versions from Carl to fix
> > >>> resuming. It stands to reason that we may be seeing another regression
> > >>> between Stefani (5.10) and myself (5.9 bringup branch) as I don't see
> > >>> any disconnections or instability once the interface is online.
> > >> Yeah, there is something strange happening between v5.9 and v5.10 we
> > >> have not yet figured out. Most likely it has something to do with memory
> > >> allocations and DMA transfers failing, but no clear understanding yet.
> > >>
> > >> But to keep things simple let's only discuss the MSI problem on this
> > >> thread, and discuss the timeouts in the another thread:
> > >>
> > >> http://lists.infradead.org/pipermail/ath11k/2020-November/000641.html
> > >>
> > >> I'll include you and other reporters to that thread.
> > >>
> > >> --
> > >> https://patchwork.kernel.org/project/linux-wireless/list/
> > >>
> > >> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> > > Ok, I've tried a clean checkout of 5.10-rc2 with the one MSI patch
> > > applied and 7fef431be9c9 reverted.  I can't get my machine to  boot
> > > into anything usable with that configuration.  I'm running ubuntu so
> > > its starting right into X and sometime between showing the available
> > > users and me clicking the icon to login the machine freezes.  I can
> > > see in the system tray that the wifi adapter is being activated and
> > > appears to have associated with an AP, I just can't do much beyond
> > > that as the keyboard backlight wakes up, but the caps lock key doesn't
> > > work.  I see similar behavior with the 5.9 configuration, but after a
> > > reboot or two I win whatever race is occuring.  With 5.10, I tried
> > > maybe 10-15 times with 0 success.
> >
> > I can confirm this behavior on my configuration. I managed to login once
> > and select the Wifi and connect to it. It seemed curiously enough be
> > stable long enough to enter the Wifi passphrase. After the connection
> > was established, the system hang and on each attempt to reboot into the
> > graphical system it would freeze at some point (sometimes even before
> > showing the login screen).
> >
> > Kernel was both based on 5.10-rc2 and 5.10-rc3 (I did see the same
> > behavior) with the patch applied, 7fef431be9c9 reverted and firmware
> > downloaded and copied to /lib/firmware/ath11k/QCA6390/hw2.0/.
> >
> >
>
> I did a bit more digging to see if I could find any new information,
> I'm not sure I did but here's what I did / found.  I spent the time to
> get a kdump kernel running and enabled, I was able to SysRq-C (both
> via keyboard and echo c > /proc/sysrq-trigger) and generate a crash
> dump.  Actually viewing them at the moment will require reverting a
> couple of patches to printk to fix the file for the crash utility
> (https://github.com/crash-utility/crash/issues/67), but right now
> that's not super important since the mechanism isn't being triggered.
> As reported here and by Mitchell, the adapter will work occasionally,
> but more often it will hang the machine (I too tried 5.10-rc3 with no
> noticable differences).  Whatever is causing the system to hang isn't
> triggering the kdump kernel to take over and dump the vmcore.  I've
> set watchdog=1 , nmi_watchdog=1, hung_task_panic=1, softlockup_panic=1
> trying to convince the kernel to dump it's state during this.  I've
> not been able to make it write a crash, it just sits 'hung'.  One
> interesting observation that may be related, is that if the lockup
> occurs during my login, I can actually see the system grind to a halt
> over the course of a number of frames (the rendering of the login
> animations starts to stutter/get really slow, then after a few frames
> everything is frozen).  If something were spin locking/ed, I'd expect
> the soft lockup panic to find it, but I don't know these mechanisms
> well.
>
> The only consistent behavior that I managed to create is that if the
> wifi adapter / machine are in a 'working' state (ie: I can browse the
> internet, etc) and I issue sysrq-c to crash the kernel and then let
> the crash dump write and reboot the machine, once booted the adapter
> is no longer seen by the kernel, and there are zero messages in dmesg
> that match "ath11k".  The driver shows up in lsmod , but it reports
> zero messages and it's like the adapter is completely invisible.  A
> power off and back on of the machine will re-enter it into the
> freezing/wifi working lottery.

Good evening all!  Just wanted to follow up as I think I've started to
uncover some of what's happening with the XPS and this driver.  So
since I can't get the kdump kernel to dump anything for me, I took a
bit more of a naive approach.  I blacklisted the modules (ath11k /
ath11k_pci) from modprobe so I could at least control when it was
loaded.  I managed to capture a series of crashes (in phone pics, but
I'll transcribe the relevant bits here) that seem to indicate some
kind of runaway / spin locked behavior.  In all but one case[*], both
the crash and the eventual working state, the driver completely
initialized successfully with messaging like this:

[   23.209335] ath11k_pci 0000:55:00.0: WARNING: ath11k PCI support is
experimental!
[   23.209404] ath11k_pci 0000:55:00.0: BAR 0: assigned [mem
0x8e300000-0x8e3fffff 64bit]
[   23.209421] ath11k_pci 0000:55:00.0: enabling device (0000 -> 0002)
[   23.209502] ath11k_pci 0000:55:00.0: MSI vectors: 1
[   23.454227] ath11k_pci 0000:55:00.0: Respond mem req failed,
result: 1, err: 0
[   23.454233] ath11k_pci 0000:55:00.0: qmi failed to respond fw mem req:-22
[   23.455810] ath11k_pci 0000:55:00.0: req mem_seg[0] 0x27d00000 524288 1
[   23.455814] ath11k_pci 0000:55:00.0: req mem_seg[1] 0x27d80000 524288 1
[   23.455816] ath11k_pci 0000:55:00.0: req mem_seg[2] 0x27e00000 524288 1
[   23.455817] ath11k_pci 0000:55:00.0: req mem_seg[3] 0x27e80000 294912 1
[   23.455819] ath11k_pci 0000:55:00.0: req mem_seg[4] 0x27f00000 524288 1
[   23.455820] ath11k_pci 0000:55:00.0: req mem_seg[5] 0x27f80000 524288 1
[   23.455822] ath11k_pci 0000:55:00.0: req mem_seg[6] 0x27800000 458752 1
[   23.455824] ath11k_pci 0000:55:00.0: req mem_seg[7] 0x27cc0000 131072 1
[   23.455825] ath11k_pci 0000:55:00.0: req mem_seg[8] 0x27880000 524288 4
[   23.455827] ath11k_pci 0000:55:00.0: req mem_seg[9] 0x27900000 360448 4
[   23.455829] ath11k_pci 0000:55:00.0: req mem_seg[10] 0x27ca4000 16384 1
[   23.466226] ath11k_pci 0000:55:00.0: chip_id 0x0 chip_family 0xb
board_id 0xff soc_id 0xffffffff
[   23.466230] ath11k_pci 0000:55:00.0: fw_version 0x101c06cc
fw_build_timestamp 2020-06-24 19:50 fw_build_id
[   23.677675] ath11k_pci 0000:55:00.0 wlp85s0: renamed from wlan0

So up until this point, everything is working without issues.
Everything seems to spiral out of control a couple of seconds later
when my system attempts to actually bring up the adapter.  In most of
the crash states I will see this:

[   31.286725] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
[   31.390187] wlp85s0: send auth to ec:08:6b:27:01:ea (try 2/3)
[   31.391928] wlp85s0: authenticated
[   31.394196] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
[   31.396513] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
(capab=0x411 status=0 aid=6)
[   31.407730] wlp85s0: associated
[   31.434354] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes ready

And then either somewhere in that pile of messages, or a second or two
after this my machine will start to stutter as I mentioned before, and
then it either hangs, or I see this message (I'm truncating the
timestamp):

[   35.xxxx ] sched: RT throttling activated

After that moment, the machine is unresponsive.  Sorry I can't seem to
extract this data other than screenshots from my phone at the moment,
you can see the dmesg output from 6 different hangs here:
https://github.com/w1nk/ath11k-debug

* - In the case where the driver didn't fully initialize successfully
and hung; during the initialization right after the "MSI vectors: %d"
printk, I started seeing these:

[ 77.xxx ] alloc_contig_range: [88d8e0, 88d8e9) PFNs busy
