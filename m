Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828AA342134
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCSPvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 11:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhCSPvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 11:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 066C661958;
        Fri, 19 Mar 2021 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616169067;
        bh=Gq99zMTfS839iv5eD+lVSuZ2Ekpn/SvAmKBiII1gFqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1GIJDW3rChLnNn9n4eQ1LHldoFJ6HeIt7DsCetvfiPM8ubbd2cXV1UCTXQZ0k9yM
         hSs0N7I6dXCphrb8Q5HrwdXpW7KXRDGzi+SpXAGPNDyajnFRno5l9xYQW36IB+IQrZ
         G4toEeHaDgByQq1oJ653krn9ah/15n0uuMDR3nR4kN91Y6whOwCGgf5oq+/lewJQf5
         hiLpkP/K+kt2JPGrVM7mw7di5aHmPouwfCUDVBfwMhoR+YJvyDc7MLsdRONLj334gN
         PT0dCyzgkT+zBa/AWS7MwaRsJomj8dYb14ECJd7fHu4ZL15V0EoTEChUnxe02p0RiG
         GZ8IGSsbjQidA==
Date:   Fri, 19 Mar 2021 17:51:03 +0200
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
Message-ID: <YFTIZ8nbQ3U25RGl@unreal>
References: <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
 <YFOMShJAm4j/3vRl@unreal>
 <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
 <YFSgQ2RWqt4YyIV4@unreal>
 <27aedf13-9c08-0ac7-e6ef-a027913c288a@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27aedf13-9c08-0ac7-e6ef-a027913c288a@metux.net>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 19, 2021 at 02:48:12PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 19.03.21 13:59, Leon Romanovsky wrote:

<...>

> In any case, I still fail to see why giving operators an debug knob
> should make anything worse.

I see this patch as a workaround to stop and provide quirks for reset issues.
As a way forward, we can do this sysfs visible for DEBUG/EXPERT .config builds.
What do you think?

> 
> > > [ And often, even a combination of them isn't enough. Did you know that
> > >    even Google doesn't get all specs necessary to replace away the ugly
> > >    FSP blob ? (it's the same w/ AMD, but meanwhile I'm pissed enought to
> > >    reverse engineer their AGESA blob). ]
> > 
> > I don't know about this specific Google case, but from my previous experience.
> > The reasons why vendor says no to Google are usually due to licensing and legal
> > issues and not open source vs. proprietary.
> 
> In short words: Google did (still does?) build their own mainboards and
> FW (IIRC that's where LinuxBoot came from), but even with their HUGE
> quantities (they buy cpus in quantities of truck loads) they still did
> not manage to get any specs for writing their own early init w/o the
> proprietary FSP.
> 
> The licensing / legal issues can either be:
> 
> a) we, the mightly Intel Corp., have been so extremly stupid for
>    licensing some vital IP stuff (what exactly could that be, in exactly
>    the prime domain of Intel ?) and signing such insane crontracts, that
>    we're not allowed to tell anybody how to actually use our own
>    products (yes: initializing the CPU and built-in interfaces belongs
>    exactly into that category)
> b) we, the mighty Intel Corp., couldn't build something on our own, but
>    just stolen IP (in our primary domain) and are scared that anybody
>    could find out from just reading some early setup code.
> c) we, the mighty Intel Corp., rule the world and we give a phrack on
>    what some tiny Customers like Google want from us.
> d) we, the mightly Intel Corp., did do what our name tells: INTEL,
>    and we don't want anybody raise unpleasant questions.

I would say
 e) We, Intel, have fixes and optimization logic (patented or specific to different
 customers) that is applicable  to our HW and we can't open it to Google because it
 will be used against us, in procurement and development. See recent article about
 ex-Intel employee who used this information when placed bids in Microsoft.
 https://www.usnews.com/news/best-states/oregon/articles/2021-02-08/intel-sues-engineer-who-went-to-microsoft-over-trade-secrets

> 
> 
> choose your poison :P
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
