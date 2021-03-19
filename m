Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183FC342110
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 16:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCSPhq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 11:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhCSPh2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 11:37:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5BA661939;
        Fri, 19 Mar 2021 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616168248;
        bh=LlMhMwfyj68qC3d2kJUST0g5iZ0H8DWxAAFzPo3YAqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFWIBUK1vaKjrogvtAdNjakrLHuZGnDnwwWeNVxlTSsQUFOWL1li2ru3hPTgfPy0l
         7+alNk+RlUZpDOJnBPT1haY6CqqREQxCqw1UyMT8c0tE/MamCp2xiye+ASG0IsZHpk
         Nwz6rU86Vh5T9dUUJEyj9PaXrZhUytRilj64SdFA3mWUNlltpQlxko0X+QhRhRWkKk
         Q1JacBUD+dmC97Q6izh80CBSVZ9dX3yIq1GzkppMlsUvw0031qjuXrzlHk4VFZfH3k
         qZr84Er4sD7tvjYACK79DWk9cKtuWUOXKqXxDyD8SH098mxA1mBkGT3neRWaMND/Uk
         MVskgiHd2B+Yw==
Date:   Fri, 19 Mar 2021 17:37:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFTFNAeAyovUmQ/W@unreal>
References: <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318142252.fqi3das3mtct4yje@archlinux>
 <YFNqbJZo3wqhMc1S@unreal>
 <20210318170143.ustrbjaqdl644ozj@archlinux>
 <YFOPYs3IGaemTLMj@unreal>
 <20210318174344.yslqpfyct6ziwypd@archlinux>
 <YFShlUgePr1BNnRI@unreal>
 <20210319152317.babevldyslat2gqa@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319152317.babevldyslat2gqa@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 19, 2021 at 08:53:17PM +0530, Amey Narkhede wrote:
> On 21/03/19 03:05PM, Leon Romanovsky wrote:

<...>

> > > > It was exactly the reason why I think that VM usecase presented by
> > > > you is not viable.
> > > >
> > > Well I didn't present it as new use case. I just gave existing
> > > usecase based on existing reset attribute. Nothing new here.
> > > Nothing really changes wrt that use case.
> >
> > Of course it is new, please see Alex's response, he said that vfio uses
> > in-kernel API and not sysfs.
> >
> Still it doesn't change in-kernel API either.

Right, but the issue is with user space part of this proposal and not
in-kernel API.


<...>

> > > As mentioned earlier not all vendors care about Linux and not
> > > all of the population can afford to buy new HW just to run Linux.
> >
> > Sorry, but you are not consistent. At the beginning, we talked about new HW
> > that has bugs but don't have quirks yet. Here we are talking about old HW
> > that still doesn't have quirks.
> >
> > Thanks
> >
> Does it really matter whether HW is old or new?
> If old HW doesn't have quirks yet how can we expect
> new one to have quirks? What if new HW is made by same vendors
> who don't have any interest in Linux?

It is pretty clear that this sysfs won't improve quirks situation but
has all potential to reduce their amount even more.

Let's stop this discussion here.

Thanks

> 
> Thanks,
> Amey
