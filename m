Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD862B7094
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 22:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgKQU7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 15:59:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgKQU7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 15:59:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605646772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9/68O94wj/uDMlx/3jfQcpnTqyYonc5KOR75ihqBhE=;
        b=dHLYV9csZYO0Nlow8cBTxwXadbbE2IY0AR9mjiSCG4iby6PGCMVh3sNRK4tIsSRsRaLuAA
        6dc7Jiq6lGYGqekwsNpS1OV2msONGxq2/W1690eaqhihmkmFZ1IoQOm/tSUP3OLUn//Isv
        GUrklLkisPstw42sfoPt38Z2a2hgvXSP9ofSMU7uvAzTnwbAuwsjlD+Cq+tRAcFuRDYNSr
        s4VmCjVzcPX9TjC37huDMuoWMmH6VeuRE3opii4p7Hhr+7GtHQrGvprbmMCGeW9XMkgE0c
        a5zuyp4awzPiWQXWB5UjPdDiVO6Xhp1EP1ep4rg3jS11/YNvx9Y+ZeXQsUpR0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605646772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9/68O94wj/uDMlx/3jfQcpnTqyYonc5KOR75ihqBhE=;
        b=CN7sn13d6TRk8DdzKSVcd1hW/7r6NMLcRt8RoLpimnvgT+6UsbFrvMMgkVsO8Y/vei8FUP
        L3ZQF9epGIy5gtBA==
To:     wi nk <wink@technolu.st>, Thomas Krause <thomaskrause@posteo.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>, ath11k@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
In-Reply-To: <CAHUdJJXy4FvmTeO648QMst9-bm1asqjZz=ktkps3ug4Hw=UweQ@mail.gmail.com>
References: <20201103160838.GA246433@bjorn-Precision-5520>
 <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
 <87mtzxkus5.fsf@nanos.tec.linutronix.de> <87wnz0hr9k.fsf@codeaurora.org>
 <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
 <87v9ec9rk3.fsf@codeaurora.org> <87imab4slq.fsf@codeaurora.org>
 <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
 <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
 <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
 <0b58872b4f27dbf5aad2a39f5ec4a066e080d806.camel@seibold.net>
 <875z6b3v22.fsf@codeaurora.org>
 <CAHUdJJVK1vH2_9YkCQ99n5mak3oGN09422gG0APkWwcy=ZDQ-Q@mail.gmail.com>
 <87pn4j2bna.fsf@codeaurora.org>
 <CAHUdJJXpfkNikreQ_JdpKDkwjEGN0oY8PyYT=aWsw1armz83Kw@mail.gmail.com>
 <e4ba4457-bd08-42fe-ade7-32059367701a@posteo.de>
 <CAHUdJJVoi2_BnubtADpdLQoe1xAuHCvkPF-RMX=dnY3nXoTm5g@mail.gmail.com>
 <CAHUdJJXy4FvmTeO648QMst9-bm1asqjZz=ktkps3ug4Hw=UweQ@mail.gmail.com>
Date:   Tue, 17 Nov 2020 21:59:32 +0100
Message-ID: <87sg97wvgr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17 2020 at 16:49, wi nk wrote:
> On Sun, Nov 15, 2020 at 8:55 PM wi nk <wink@technolu.st> wrote:
> So up until this point, everything is working without issues.
> Everything seems to spiral out of control a couple of seconds later
> when my system attempts to actually bring up the adapter.  In most of
> the crash states I will see this:
>
> [   31.286725] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
> [   31.390187] wlp85s0: send auth to ec:08:6b:27:01:ea (try 2/3)
> [   31.391928] wlp85s0: authenticated
> [   31.394196] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
> [   31.396513] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
> (capab=0x411 status=0 aid=6)
> [   31.407730] wlp85s0: associated
> [   31.434354] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes ready
>
> And then either somewhere in that pile of messages, or a second or two
> after this my machine will start to stutter as I mentioned before, and
> then it either hangs, or I see this message (I'm truncating the
> timestamp):
>
> [   35.xxxx ] sched: RT throttling activated

As this driver uses threaded interrupts, this looks like an interrupt
storm and the interrupt thread consumes the CPU fully. The RT throttler
limits the RT runtime of it which allows other tasks make some
progress. That's what you observe as stutter.

You can apply the hack below so the irq thread(s) run in the SCHED_OTHER
class which prevents them from monopolizing the CPU. That might make the
problem simpler to debug.

Thanks,

        tglx
---
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e0496006..8473ecacac7a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1320,7 +1320,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	if (IS_ERR(t))
 		return PTR_ERR(t);
 
-	sched_set_fifo(t);
+	//sched_set_fifo(t);
 
 	/*
 	 * We keep the reference to the task struct even if
