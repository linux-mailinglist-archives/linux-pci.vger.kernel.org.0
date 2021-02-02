Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1427630CCE9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 21:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhBBUSP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 15:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbhBBURF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 15:17:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE0F64E40;
        Tue,  2 Feb 2021 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612296983;
        bh=qIjafVk/Rk4FeQ07dzQifmvvi/VRPKppKlwfr/mWr38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u9Il5PnjZu+ykh0hxob74AeELxKzJ/ONJbG7M++ni9C+SqGwMuF61pj2YXp8+TIhh
         rsDSYJeg3KA7PyNKdjdF8GMf5va/m5ABwwGxx6Kp0HeU943Cg9VOfrQxEqVyRpKdXn
         c8P+fMoKlEMA/T2+xJPJLHNAdCCH7hY9xCbC1XK7o1jlnEelQKCLZhg+XUYvVuQ/vc
         sceh8yQEhwwhYzZ/5WHps5RkINX8MKAD+7yqKm/KBWGwgq3sIKSzl59m7NhuynUhtT
         HjdZB5a51tSgZYIZegQzhw//HAbgqqot2O8eRYwAk9gxzZYCemZevMTnZm7Ex+KcWn
         D7A979JrJdyqQ==
Date:   Tue, 2 Feb 2021 14:16:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "A. Vladimirov" <vladimirov.atanas@gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20210202201621.GA127455@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d07f39d-1f8c-e545-c5e7-8f21aa0e94f3@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 01:50:20PM -0600, Alex G. wrote:
> On 1/29/21 3:56 PM, Bjorn Helgaas wrote:
> > On Thu, Jan 28, 2021 at 06:07:36PM -0600, Alex G. wrote:
> > > On 1/28/21 5:51 PM, Sinan Kaya wrote:
> > > > On 1/28/2021 6:39 PM, Bjorn Helgaas wrote:
> > > > > AFAICT, this thread petered out with no resolution.
> > > > > 
> > > > > If the bandwidth change notifications are important to somebody,
> > > > > please speak up, preferably with a patch that makes the notifications
> > > > > disabled by default and adds a parameter to enable them (or some other
> > > > > strategy that makes sense).
> > > > > 
> > > > > I think these are potentially useful, so I don't really want to just
> > > > > revert them, but if nobody thinks these are important enough to fix,
> > > > > that's a possibility.
> > > > 
> > > > Hide behind debug or expert option by default? or even mark it as BROKEN
> > > > until someone fixes it?
> > > > 
> > > Instead of making it a config option, wouldn't it be better as a kernel
> > > parameter? People encountering this seem quite competent in passing kernel
> > > arguments, so having a "pcie_bw_notification=off" would solve their
> > > problems.
> > 
> > I don't want people to have to discover a parameter to solve issues.
> > If there's a parameter, notification should default to off, and people
> > who want notification should supply a parameter to enable it.  Same
> > thing for the sysfs idea.
> 
> I can imagine cases where a per-port flag would be useful. For example, a
> machine with a NIC and a couple of PCIe storage drives. In this example, the
> PCIe drives downtrain willie-nillie, so it's useful to turn off their
> notifications, but the NIC absolutely must not downtrain. It's debatable
> whether it should be default on or default off.
>
> > I think we really just need to figure out what's going on.  Then it
> > should be clearer how to handle it.  I'm not really in a position to
> > debug the root cause since I don't have the hardware or the time.
> 
> I wonder
> (a) if some PCIe devices are downtraining willie-nillie to save power
> (b) if this willie-nillie downtraining somehow violates PCIe spec
> (c) what is the official behavior when downtraining is intentional
> 
> My theory is: YES, YES, ASPM. But I don't know how to figure this out
> without having the problem hardware in hand.
> 
> > If nobody can figure out what's going on, I think we'll have to make it
> > disabled by default.
> 
> I think most distros do "CONFIG_PCIE_BW is not set". Is that not true?

I think it *is* true that distros do not enable CONFIG_PCIE_BW.

But it's perfectly reasonable for people building their own kernels to
enable it.  It should be safe to enable all config options.  If they
do enable CONFIG_PCIE_BW, I don't want them to waste time debugging
messages they don't expect.

If we understood why these happen and could filter out the expected
ones, that would be great.  But we don't.  We've already wasted quite
a bit of Jan's and Atanas' time, and no doubt others who haven't
bothered to file bug reports.

So I think I'll queue up a patch to remove the functionality for now.
It's easily restored if somebody debugs the problem or adds a
command-line switch or something.

Bjorn
