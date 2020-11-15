Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440032B350E
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKONaP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 08:30:15 -0500
Received: from mout01.posteo.de ([185.67.36.65]:59539 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgKONaP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Nov 2020 08:30:15 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A2409160064
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2020 14:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1605447011; bh=MGqMsgArhZl+KrAtGwxgm1ffeCx32N+ssaCovhTwn1w=;
        h=To:Cc:From:Subject:Date:From;
        b=ad2eT7c23Z+XuPVzHLMv5JN57GRDkTzKad6+9LdRgrX/QkoeAfpJ8RDs571IxLCpa
         BoyUknVDi5mR/oxj3Ql05Wojfw9tLNPQhrlj/NvZnQYTmPTFX0s5/pvVGiJQBFBHXD
         pAwQzcf62lnqU4vyUXIKgGcx009G65K+OdHmMiBgecn96i0TECfUj+6z0PbNCdjL8g
         3t1Tg9rWqDKGFhCUSnfH3ANKpSFXUfgi/PtI7n9zz3puk/XQxxpVAqJ0KN+S0W97UI
         iJHHJ/d6rqcTB7SG+/rU31eiT5+GYk/M9b0RS7wjbLR1Mde3nf4eluv2gXT/Sz2nTR
         3Htop1slosBsA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CYtNv6Lphz6tmL;
        Sun, 15 Nov 2020 14:30:07 +0100 (CET)
To:     wi nk <wink@technolu.st>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
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
From:   Thomas Krause <thomaskrause@posteo.de>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
Message-ID: <e4ba4457-bd08-42fe-ade7-32059367701a@posteo.de>
Date:   Sun, 15 Nov 2020 14:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAHUdJJXpfkNikreQ_JdpKDkwjEGN0oY8PyYT=aWsw1armz83Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Am 12.11.20 um 16:44 schrieb wi nk:
> On Thu, Nov 12, 2020 at 10:00 AM Kalle Valo <kvalo@codeaurora.org> wrot=
e:
>> wi nk <wink@technolu.st> writes:
>>
>>> On Thu, Nov 12, 2020 at 8:15 AM Kalle Valo <kvalo@codeaurora.org> wro=
te:
>>>> Stefani Seibold <stefani@seibold.net> writes:
>>>>
>>>>> Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
>>>>>> I've yet to see any instability after 45 minutes of exercising it,=
 I
>>>>>> do see a couple of messages that came out of the driver:
>>>>>>
>>>>>> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
>>>>>> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
>>>>>>
>>>>>> then when it associates:
>>>>>>
>>>>>> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
>>>>>> [   16.722636] wlp85s0: authenticated
>>>>>> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)=

>>>>>> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
>>>>>> (capab=3D0x411 status=3D0 aid=3D8)
>>>>>> [   16.738443] wlp85s0: associated
>>>>>> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link become=
s
>>>>>> ready
>>>>>>
>>>>>> The adapter is achieving around 500 mbps on my gigabit connection,=
 my
>>>>>> 2018 mbp sees around 650, so it's doing pretty well so far.
>>>>>>
>>>>>> Stefani - when you applied the patch that Kalle shared, which bran=
ch
>>>>>> did you apply it to?  I applied it to ath11k-qca6390-bringup and w=
hen
>>>>>> I revert 7fef431be9c9 there is a small merge conflict I needed to
>>>>>> resolve.  I wonder if either the starting branch, or your chosen
>>>>>> resolution are related to the instability you see (or I'm just luc=
ky
>>>>>> so far! :)).
>>>>>>
>>>>> I used the vanilla kernel tree
>>>>> https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of =
this
>>>>> i applied the
>>>>>
>>>>> RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch
>>>>>
>>>>> and reverted the patch 7fef431be9c9
>>>> I did also my testing on v5.10-rc2 and I recommend to use that as th=
e
>>>> baseline when debuggin these ath11k problems. It helps to compare th=
e
>>>> results if everyone have the same baseline.
>>>>
>>>> --
>>>> https://patchwork.kernel.org/project/linux-wireless/list/
>>>>
>>>> https://wireless.wiki.kernel.org/en/developers/documentation/submitt=
ingpatches
>>> Absolutely, I'll rebuild to 5.10 later today and apply the same serie=
s
>>> of patches and report back.
>> Great, thanks.
>>
>>> I'll also test out the patch on both versions from Carl to fix
>>> resuming. It stands to reason that we may be seeing another regressio=
n
>>> between Stefani (5.10) and myself (5.9 bringup branch) as I don't see=

>>> any disconnections or instability once the interface is online.
>> Yeah, there is something strange happening between v5.9 and v5.10 we
>> have not yet figured out. Most likely it has something to do with memo=
ry
>> allocations and DMA transfers failing, but no clear understanding yet.=

>>
>> But to keep things simple let's only discuss the MSI problem on this
>> thread, and discuss the timeouts in the another thread:
>>
>> http://lists.infradead.org/pipermail/ath11k/2020-November/000641.html
>>
>> I'll include you and other reporters to that thread.
>>
>> --
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittin=
gpatches
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

I can confirm this behavior on my configuration. I managed to login once =

and select the Wifi and connect to it. It seemed curiously enough be=20
stable long enough to enter the Wifi passphrase. After the connection=20
was established, the system hang and on each attempt to reboot into the=20
graphical system it would freeze at some point (sometimes even before=20
showing the login screen).

Kernel was both based on 5.10-rc2 and 5.10-rc3 (I did see the same=20
behavior) with the patch applied, 7fef431be9c9 reverted and firmware=20
downloaded and copied to /lib/firmware/ath11k/QCA6390/hw2.0/.


