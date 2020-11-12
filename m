Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279732B0003
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 08:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKLHF6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 02:05:58 -0500
Received: from www84.your-server.de ([213.133.104.84]:47384 "EHLO
        www84.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLHF5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 02:05:57 -0500
Received: from ipbcc25655.dynamic.kabel-deutschland.de ([188.194.86.85] helo=[192.168.0.7])
        by www84.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <stefani@seibold.net>)
        id 1kd6fw-00053Q-Ns; Thu, 12 Nov 2020 08:05:44 +0100
Message-ID: <0b58872b4f27dbf5aad2a39f5ec4a066e080d806.camel@seibold.net>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
From:   Stefani Seibold <stefani@seibold.net>
To:     wi nk <wink@technolu.st>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Thomas Krause <thomaskrause@posteo.de>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
Date:   Thu, 12 Nov 2020 08:05:40 +0100
In-Reply-To: <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: stefani@seibold.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25985/Wed Nov 11 14:18:01 2020)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
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
> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes
> ready
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

I used the vanilla kernel tree 
https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of this
i applied the 

RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch

and reverted the patch 7fef431be9c9


