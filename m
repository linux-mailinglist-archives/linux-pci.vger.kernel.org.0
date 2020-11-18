Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6E2B7B26
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 11:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKRKWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 05:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgKRKWw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 05:22:52 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26AEC0613D4
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 02:22:51 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id oq3so1977002ejb.7
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sI3Qvd5uSLh3sTc/bNorfEjSUnZKG4TO/HsxvppIaZs=;
        b=O66dkVEEL0lYSTNUrP73tZdheyh1PKoIQOIeGGNJKTcXlGCHk+2z2sWtCiYCwLiFaZ
         IdpCa/yRZXMNOEPMIT+xyVoW6j8S6leF7lmIGmkbn1RkZFmDuool/XHtT91vJyxi9ad9
         YLdgEGRQRUV8hGPpfmt6Z222LrPpnb9WN1QdiMMYpnTsHFx+I+d0Scvd+4GTT8sz8DBO
         q0JatXZz2CHHBBX3gQfjHruhIseHRaswiEGhm96mdjrsruiXDbo1XZLT+ynUkKUOuMTM
         c+4w6dn2km/WwRCUUlWAxudAnOALVF/HZhorvCV3CAkK5CZc/VRvlMr+MlJdC4SSubqK
         gppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sI3Qvd5uSLh3sTc/bNorfEjSUnZKG4TO/HsxvppIaZs=;
        b=rTdj6/MUS9IxGa0D/dU1NKEo8N8bfsmKz4vyJ0v2LDW0+3DGP1fjUkV3OOKDilvfsD
         vx3K8ae2xGRmAnaAe/WSX70DK728A8hVBC5LFKlkFJF0xPkH/BleashOCfiiL6VljkzN
         WTjzpXw/dNaeSpq7sgNKifc7OvvmjU3l7T+1vMr3bQYoLD+/+vmMPJ94MS5Fpqw0LABx
         Qmw0KGsl3SkuBlmBKnWFgqGmCqFiFWru/0MKuzW0LAjlkoAHj3bhaQt9tGL2LCM5TmOh
         ok4DQPMYZWkQFPHy7lgsVm6UhScfVG1OJT3Ta7RePt8ti05YTWUXnxsF8cbwgRPTQATF
         41PA==
X-Gm-Message-State: AOAM5302FbmDsyhL2D9xcfjztoccdpmdDlwroY0q5hN+uC5K4YZpWqCg
        uG/wIVUD8CGu6UjNRkFEDVKxzYn9g66tGQxy3tF40Q==
X-Google-Smtp-Source: ABdhPJyYoZxPNz6y2iodXwBUE3ZT3AdI2dooDEciJ94egjPWhps05OUlkOAqmhcZsjXgSoTvit49QvWIp8fz9lWH+vg=
X-Received: by 2002:a17:906:b53:: with SMTP id v19mr22603373ejg.136.1605694970684;
 Wed, 18 Nov 2020 02:22:50 -0800 (PST)
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
 <CAHUdJJXy4FvmTeO648QMst9-bm1asqjZz=ktkps3ug4Hw=UweQ@mail.gmail.com> <87sg97wvgr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sg97wvgr.fsf@nanos.tec.linutronix.de>
From:   wi nk <wink@technolu.st>
Date:   Wed, 18 Nov 2020 11:22:39 +0100
Message-ID: <CAHUdJJUYNgyiE1C5y0rGYoHFv62D--5X9c-+E1c9g3aByRb1ow@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Krause <thomaskrause@posteo.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>, ath11k@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 9:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, Nov 17 2020 at 16:49, wi nk wrote:
> > On Sun, Nov 15, 2020 at 8:55 PM wi nk <wink@technolu.st> wrote:
> > So up until this point, everything is working without issues.
> > Everything seems to spiral out of control a couple of seconds later
> > when my system attempts to actually bring up the adapter.  In most of
> > the crash states I will see this:
> >
> > [   31.286725] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> > [   31.390187] wlp85s0: send auth to ec:08:6b:27:01:ea (try 2/3)
> > [   31.391928] wlp85s0: authenticated
> > [   31.394196] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> > [   31.396513] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> > (capab=0x411 status=0 aid=6)
> > [   31.407730] wlp85s0: associated
> > [   31.434354] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes ready
> >
> > And then either somewhere in that pile of messages, or a second or two
> > after this my machine will start to stutter as I mentioned before, and
> > then it either hangs, or I see this message (I'm truncating the
> > timestamp):
> >
> > [   35.xxxx ] sched: RT throttling activated
>
> As this driver uses threaded interrupts, this looks like an interrupt
> storm and the interrupt thread consumes the CPU fully. The RT throttler
> limits the RT runtime of it which allows other tasks make some
> progress. That's what you observe as stutter.
>
> You can apply the hack below so the irq thread(s) run in the SCHED_OTHER
> class which prevents them from monopolizing the CPU. That might make the
> problem simpler to debug.
>
> Thanks,
>
>         tglx
> ---
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c460e0496006..8473ecacac7a 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1320,7 +1320,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>         if (IS_ERR(t))
>                 return PTR_ERR(t);
>
> -       sched_set_fifo(t);
> +       //sched_set_fifo(t);
>
>         /*
>          * We keep the reference to the task struct even if

I was able to apply this patch and play a little bit.  Unfortunately,
whatever is still going on is mostly the same.  It seems this patch
extends the 'stuttering' I see a little bit, but the end result is
still an unresponsive machine.  I didn't get tons of time to play yet,
so the extra time may make it possible to finally get sysrq-c issued
and get a vmcore dump.  I also tried to replicate a google android
patch I found to basically BUG() on the rt throttling activating
(https://groups.google.com/a/chromium.org/g/chromium-os-reviews/c/NDyPucYrvRY)
but that path hasn't activated for me since I booted it.  I'll
hopefully have a chance again this evening.
