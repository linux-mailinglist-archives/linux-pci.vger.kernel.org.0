Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44714341EB9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 14:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCSNsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 09:48:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSNsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 09:48:22 -0400
Received: from [192.168.1.155] ([95.114.29.199]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mzydy-1lZqeJ1yGE-00x5Wc; Fri, 19 Mar 2021 14:48:13 +0100
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Leon Romanovsky <leon@kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
References: <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux> <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux> <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org> <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org> <YFOMShJAm4j/3vRl@unreal>
 <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net> <YFSgQ2RWqt4YyIV4@unreal>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <27aedf13-9c08-0ac7-e6ef-a027913c288a@metux.net>
Date:   Fri, 19 Mar 2021 14:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFSgQ2RWqt4YyIV4@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YuQY/oPIl1gjw5CVFKYwndq+QPlRq6cXN5N0R+s6dC6fCrlwTIP
 Sd/uA36LCSxAzGcyfWlWDY4BQtmhtHLy4FLt/X9MoKZccpch5LSkP3tp4uDuxP3H6iw2l+D
 Gx2gdR/ndHfQ2H0niyRZcgkABPpxME47a5Qc4OCKq8Yze3CIhCKet1LiBfeO3JHOZUu/Ybl
 FfB/H/OWZcYOpAZkBZGMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iSB6CUCeqYg=:wdzZZxPh/GwsMbZS5KydnJ
 hmY2rEuGblfg+iMdwRd6+CJGxwCfmKAUaTUgbP0VoiVdEUda8hdPHOYRlCXXFtIaX7wjG0mnf
 0g3eCKU6Z315GY+F0qMriF6pjnywyehYtPr9syKebDXPzin4gSZRzhN0wUjHTUJDqy2hkL/pV
 1odCHqKXDl8rEm3SvB6erRRwuvia5N/dfLKcHL38vyLgEqEx8qoZsYrn2FUAkpag0ovr3W06g
 5J3v6NSpyKWdXskDG+qn2o0jydB6/zoBtWuKppoD/MOCTHmGCKBB7aYPA4YlA55EQlppr2LTN
 /KUWdyttys5FEgwFULPb8MUkDQb8Ro9peMuzlk5DDKVBc6yxJnISYd9NCpxoA2YnfQBAZ+g10
 5OUM1jICSis9wo+o59YnC5Z2ynxEtU2APkcWMs328xCCxXYMv8aXiu1elC3/T
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19.03.21 13:59, Leon Romanovsky wrote:

>> I really doubt we can influence that by any technical decision here in
>> the kernel.
> 
> There are subsystems that succeeded to do it, for example netdev, RDMA e.t.c.

I'd guess either hi-end / server or embedded products - already
mentioned that these are different fields. I've been talking about the
average consumer products.

OTOH, there're also very expensive vendors that are exceptionally bad,
eg. National instruments (who even are capable of breaking rpm so badly
with their proprietary packages that they open up 0day holes - i once
filed a report @FD on such a case).

>> IMHO, the expensive ones don't care either.
>>
>> Does eg. Dell publish board schematics ? Do they even publish exact part
>> lists (exact chipsets) along with their brochures, so customers can
>> check wether their HW is supported, before buying and trying out ?
> 
> They do it because they are allowed to do it and not because they
> explicitly want to annoyance their customers.

Yes, they're just ignorant. They can still do that, because buy their
pretty expensive cheap-hardware. And that's mostly driven by purchase
people inside the customer organisations, who just don't care how much
damage they do to their own employers, by dictating purchase of
expensive broken-by-design hardware. ... but that's nothing we here have
any influence on - except for dissuasion and purchase boycott ...

In any case, I still fail to see why giving operators an debug knob
should make anything worse.

>> [ And often, even a combination of them isn't enough. Did you know that
>>    even Google doesn't get all specs necessary to replace away the ugly
>>    FSP blob ? (it's the same w/ AMD, but meanwhile I'm pissed enought to
>>    reverse engineer their AGESA blob). ]
> 
> I don't know about this specific Google case, but from my previous experience.
> The reasons why vendor says no to Google are usually due to licensing and legal
> issues and not open source vs. proprietary.

In short words: Google did (still does?) build their own mainboards and
FW (IIRC that's where LinuxBoot came from), but even with their HUGE
quantities (they buy cpus in quantities of truck loads) they still did
not manage to get any specs for writing their own early init w/o the
proprietary FSP.

The licensing / legal issues can either be:

a) we, the mightly Intel Corp., have been so extremly stupid for
    licensing some vital IP stuff (what exactly could that be, in exactly
    the prime domain of Intel ?) and signing such insane crontracts, that
    we're not allowed to tell anybody how to actually use our own
    products (yes: initializing the CPU and built-in interfaces belongs
    exactly into that category)
b) we, the mighty Intel Corp., couldn't build something on our own, but
    just stolen IP (in our primary domain) and are scared that anybody
    could find out from just reading some early setup code.
c) we, the mighty Intel Corp., rule the world and we give a phrack on
    what some tiny Customers like Google want from us.
d) we, the mightly Intel Corp., did do what our name tells: INTEL,
    and we don't want anybody raise unpleasant questions.


choose your poison :P


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
