Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9642308F35
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 22:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhA2VVR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jan 2021 16:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232781AbhA2VVP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jan 2021 16:21:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E64D564E06;
        Fri, 29 Jan 2021 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611955234;
        bh=DM5sQEzyeZQYMcv/NaSI/egJ43G1u2n09nG0uwuL3WY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FIDLV8XNeZ1l66lLMPHxljPeKYJ+ZTJbAuPp+NuXCBWm3PSdSnENF+nfQ0jFSkUdH
         rY4flYpfbKBikYZPqLhkf3404J5nD2SXAhD96nZIlm5iDiOvNv8/SlQyoFvmHzLR1l
         VPBDgQr7ML2hLmUydmGT1Jx3f+MK1T3M/5nDhM7WJ8WKeUihNQpsBeO4OP4pXSq5mV
         rY6d4WPHktV6s9e7rTZMmTTvsGm4b6udTJ5bvAYwWMacud25mDnrWM2FbZY/A00mSK
         Jt7HnJDWzMqr9wKnDKGe1rfJ8m6lBgerRgJkd8oC68yvvw+svAsp3MFAyRTumRUtdI
         fKnwI1mz0l4QQ==
Date:   Fri, 29 Jan 2021 15:20:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc MERLIN <marc_nouveau@merlins.org>
Cc:     nouveau@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: 5.9.11 still hanging 2mn at each boot and looping on nvidia-gpu
 0000:01:00.3: PME# enabled (Quadro RTX 4000 Mobile)
Message-ID: <20210129212032.GA99457@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129005626.GP29348@merlins.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 28, 2021 at 04:56:26PM -0800, Marc MERLIN wrote:
> On Wed, Jan 27, 2021 at 03:33:00PM -0600, Bjorn Helgaas wrote:
> > Hi Marc, I appreciate your persistence on this.  I am frankly
> > surprised that you've put up with this so long.
>  
> Well, been using linux for 27 years, but also it's not like I have much
> of a choice outside of switching to windows, as tempting as it's getting
> sometimes ;)
> 
> > > after boot, when it gets the right trigger (not sure which ones), it
> > > loops on this evern 2 seconds, mostly forever.
> > > 
> > > I'm not sure if it's nouveau's fault or the kernel's PCI PME's fault, or something else.
> > 
> > IIUC there are basically two problems:
> > 
> >   1) A 2 minute delay during boot
> > Another random thought: is there any chance the boot delay could be
> > related to crypto waiting for entropy?
> 
> So, the 2mn hang went away after I added the nouveau firwmare in initrd.
> The only problem is that the nouveau driver does not give a very good
> clue as to what's going on and what to do.
>
> For comparison the intel iwlwifi driver is very clear about firmware
> it's trying to load, if it can't and what exact firmware you need to
> find on the internet (filename)

I guess you're referring to this in iwl_request_firmware()?

  IWL_ERR(drv, "check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git\n"); 

How can we fix this in nouveau so we don't have the debug this again?
I don't really know how firmware loading works, but "git grep -A5
request_firmware drivers/gpu/drm/nouveau/" shows that we generally
print something when request_firmware() fails.

But I didn't notice those messages in your logs, so I'm probably
barking up the wrong tree.

> >   2) Some sort of event every 2 seconds that kills your battery life
> > Your machine doesn't sound unusual, and I haven't seen a flood of
> > similar reports, so maybe there's something unusual about your config.
> > But I really don't have any guesses for either one.
> 
> Honestly, there are not too many thinpad P73 running linux out there. I
> wouldn't be surprised if it's only a handful or two.
> 
> > It sounds like v5.5 worked fine and you first noticed the slow boot
> > problem in v5.8.  We *could* try to bisect it, but I know that's a lot
> > of work on your part.
> 
> I've done that in the past, to be honest now that it works after I added
> the firmware that nouveau started needing, and didn't need before, the
> hang at boot is gone for sure.
> The PCI PM wakeup issues on batteries happen sometimes still, but they
> are much more rare now.

So maybe the wakeups are related to having vs not having the nouveau
firmware?  I'm still curious about that, and it smells like a bug to
me, but probably something to do with nouveau where I have no hope of
debugging it.

> > Grasping for any ideas for the boot delay; could you boot with
> > "initcall_debug" and collect your "lsmod" output?  I notice async_tx
> > in some of your logs, but I have no idea what it is.  It's from
> > crypto, so possibly somewhat unusual?
> 
> Is this still neeeded? I think of nouveau does a better job of helping
> the user correct the issue if firmware is missing (I think intel even
> gives a URL in printk), that would probably be what's needed for the
> most part.

Nope, don't bother with this, thanks.

Bjorn
