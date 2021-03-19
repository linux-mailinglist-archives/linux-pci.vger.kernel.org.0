Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A1341D98
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 14:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCSM75 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 08:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCSM7v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 08:59:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7000A64ECD;
        Fri, 19 Mar 2021 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616158791;
        bh=s1jBvRIzG2KtXnlm97XSiogBmYB5Emrm/1OV0N1QTEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rwOsufUV2ChWTrrOGzFS76/AIq8CUh4toMupaCQSNNTfy1xIUPx4Drpf0tEypTeiX
         SS/hsRPSFhgvYpmTNrM6+ny0hkWDmCSjSZfh1BaBaXz/Ic6KMb+Cz6XXHpwZxbbrX7
         KNSlkdLOtHZ2Tc1PX93rDqzQSCOJG4CPZE9vyKL0+8MC4cdMeMG2aGjU+OF/s3Wxde
         OHmDbsTjnRELvHu2wXHsg44dfi3MfSf4JEYk8rw7NCASrZ5y96omUiyblKhLhhxyFG
         U8COopenns+BT+fbEaX1PzNn8qQ14YF4B/y3c0Q7KdxdutaIoRprjlEDxSsSpVyYfj
         CkMD3eSqUUVZw==
Date:   Fri, 19 Mar 2021 14:59:47 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFSgQ2RWqt4YyIV4@unreal>
References: <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
 <YFOMShJAm4j/3vRl@unreal>
 <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 18, 2021 at 07:34:56PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 18.03.21 18:22, Leon Romanovsky wrote:
> 
> > Which email client do you use?
> > Your responses are grouped as one huge block without any chance to respond
> > to you on specific point or answer to your question.
> 
> I'm reading this thread in Tbird, and threading / quoting all looks
> nice.

I'm not talking about threading or quoting but about response itself.
See it here https://lore.kernel.org/lkml/20210318103935.2ec32302@omen.home.shazbot.org/
Alex's response is one big chunk without any separations to paragraphs.

> 
> > I see your flow and understand your position, but will repeat my
> > position. We need to make sure that vendors will have incentive to
> > supply quirks.
> 
> I really doubt we can influence that by any technical decision here in
> the kernel.

There are subsystems that succeeded to do it, for example netdev, RDMA e.t.c.

> 
> > And regarding vendors, see Amey response below about his touchpad troubles.
> > The cheap electronics vendors don't care about their users.
> 
> IMHO, the expensive ones don't care either.
> 
> Does eg. Dell publish board schematics ? Do they even publish exact part
> lists (exact chipsets) along with their brochures, so customers can
> check wether their HW is supported, before buying and trying out ?

They do it because they are allowed to do it and not because they
explicitly want to annoyance their customers. 

> 
> Doesn't seem so. I've personally seen a lot cases where some supposedly
> supported HW turned out to be some completely different and unsupported
> HW that's sold under exactly the same product ID. One of many reasons
> for not giving them a single penny anymore.
> 
> IMHO, there're only very few changes of convincing some HW vendor for
> doing a better job on driver side:
> 
> a) product is targeted for a niche that can't live without Linux
>    (eg. embedded)
> b) it's really *dangerous* for your market share if anything doesn't
>    work properly on Linux (eg. certan server machines)
> c) somebody *really* big (like Google) is gun-pointing at some supplier,
>    who's got a lot to loose
> d) a *massive* worldwide shitstorm against the vendor
> 
> [ And often, even a combination of them isn't enough. Did you know that
>   even Google doesn't get all specs necessary to replace away the ugly
>   FSP blob ? (it's the same w/ AMD, but meanwhile I'm pissed enought to
>   reverse engineer their AGESA blob). ]

I don't know about this specific Google case, but from my previous experience.
The reasons why vendor says no to Google are usually due to licensing and legal
issues and not open source vs. proprietary.

> 
> You see, what we do here in the kernel has no practical influence on
> those hw vendors.

I see it differently, but it doesn't matter. This is too theoretical
discussion to my taste.

> 
> 
> --mtx
> 
> -- 
> ---
> Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
> werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
> GPG/PGP-Schlüssel zu.
> ---
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
