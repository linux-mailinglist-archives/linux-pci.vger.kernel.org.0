Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE360340D1C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 19:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCRSfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 14:35:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhCRSfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 14:35:07 -0400
Received: from [192.168.1.155] ([77.4.36.33]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M42Ss-1lMxU11GeO-0007h2; Thu, 18 Mar 2021 19:34:57 +0100
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
To:     Leon Romanovsky <leon@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
References: <YFGDgqdTLBhQL8mN@unreal>
 <20210317102447.73no7mhox75xetlf@archlinux> <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux> <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux> <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org> <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org> <YFOMShJAm4j/3vRl@unreal>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
Date:   Thu, 18 Mar 2021 19:34:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFOMShJAm4j/3vRl@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iywlJkpEFuxNE/Ve6FtQn70Tv1GKx5OB/MLu/Wy84sZPqnA43sn
 12syIC+nmB61lPzHc+9NFDntPxP6RYhT4aqjusTif341gD2PMiEy94bMXzfF8tPpPztEGDt
 SH3kOvoO+oxdRP4qDN5Rom2pRDeOBfRpisU9Eefw/SLdcYJ5oevNYj4XbeaIIDzAIYGcaLb
 eNLYM6wcN6w2/FBy/l3Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E/WAgxaRGZ4=:kTlG8ndNRYWqorilUkQbSJ
 blx0MMl0Hl1bzNdh/OEg+HOich4a9SIRNVFuQVHIqC2KBdq/Y8kHTLVV2356JwHPEfkTIyQjB
 c3Tvzjf/Npf1oaw/YMbGebr64DEezhCo1MuHz8gmmZhrlIjwzcAmjON4nUv2KLQ4g/l39vJ8V
 c34ELhpoho4FYDb3g5IHLJnK3JXYKvB9AG2CSrkN/n/UWaVFlflOyRsxTAJhzwG+2+wKAwec0
 kRi3HqI1XIF5YF6B+Xid0sjlYs7q6RVD9EezcmRrLY7nNsmJwlEUroON5i1HK8YEi+PuQY4Mr
 LBB29ruhIdGdsY6zxhG+5X8a9vfAvLYU1Xvbey1sZc8Lrm1ZWaJ1oy3gxn04292KFnxmiCPwp
 N9d30UBSZ9l2urXZ7XdRoL6m05cS1sgfEdLf5zQVSwEOzE+U/H1R9huxayYQl
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.03.21 18:22, Leon Romanovsky wrote:

> Which email client do you use?
> Your responses are grouped as one huge block without any chance to respond
> to you on specific point or answer to your question.

I'm reading this thread in Tbird, and threading / quoting all looks
nice.

> I see your flow and understand your position, but will repeat my
> position. We need to make sure that vendors will have incentive to
> supply quirks.

I really doubt we can influence that by any technical decision here in
the kernel.

> And regarding vendors, see Amey response below about his touchpad troubles.
> The cheap electronics vendors don't care about their users.

IMHO, the expensive ones don't care either.

Does eg. Dell publish board schematics ? Do they even publish exact part
lists (exact chipsets) along with their brochures, so customers can
check wether their HW is supported, before buying and trying out ?

Doesn't seem so. I've personally seen a lot cases where some supposedly
supported HW turned out to be some completely different and unsupported
HW that's sold under exactly the same product ID. One of many reasons
for not giving them a single penny anymore.

IMHO, there're only very few changes of convincing some HW vendor for
doing a better job on driver side:

a) product is targeted for a niche that can't live without Linux
    (eg. embedded)
b) it's really *dangerous* for your market share if anything doesn't
    work properly on Linux (eg. certan server machines)
c) somebody *really* big (like Google) is gun-pointing at some supplier,
    who's got a lot to loose
d) a *massive* worldwide shitstorm against the vendor

[ And often, even a combination of them isn't enough. Did you know that
   even Google doesn't get all specs necessary to replace away the ugly
   FSP blob ? (it's the same w/ AMD, but meanwhile I'm pissed enought to
   reverse engineer their AGESA blob). ]

You see, what we do here in the kernel has no practical influence on
those hw vendors.


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
