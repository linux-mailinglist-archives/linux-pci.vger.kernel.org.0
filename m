Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB93431C4
	for <lists+linux-pci@lfdr.de>; Sun, 21 Mar 2021 09:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCUIlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 04:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhCUIlA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Mar 2021 04:41:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 349D96192F;
        Sun, 21 Mar 2021 08:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616316059;
        bh=hUjP8gjXkv59/qRwHCDIZvmaaJ65Cw8tqmmsnzvQ6fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1tmabDu7jn7+x+9IzhPgGZvbXrY9ooMFJlQp5k8FI7BCjUEK+07B4cDn+ZtHNWLV
         P47XVhhPiXR/CkgdhxHpu/fR71WZfY/jLMJxAwh+/+R5OjvaujypPKJa9ZMjh4nbdL
         0MK2e48mE80YRSWQh5ToUMkJxdnck6loIQFYS/rTxoOgKMtd5QmK9pUIog4xDKiHLK
         vfcn0QObgj2bSw7hEkGgcCiAhuG0np2T6Iza731HJBYBSQuktPOTnpWULbwNWNANSe
         xe/uGEZrhjWzaR6AOQNKyxUPDoVMqtRtLBlF6k473YvyEdKC8K5g5VDq2+lSvgBc4y
         ZNyb+dPB7gMXg==
Date:   Sun, 21 Mar 2021 10:40:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFcGlzbaSzQ5Qota@unreal>
References: <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
 <YFOMShJAm4j/3vRl@unreal>
 <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
 <YFSgQ2RWqt4YyIV4@unreal>
 <20210319102313.179e9969@omen.home.shazbot.org>
 <YFW78AfbhYpn16H4@unreal>
 <20210320085942.3cefcc48@x1.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320085942.3cefcc48@x1.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 20, 2021 at 08:59:42AM -0600, Alex Williamson wrote:
> On Sat, 20 Mar 2021 11:10:08 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> > On Fri, Mar 19, 2021 at 10:23:13AM -0600, Alex Williamson wrote: 
> > > 
> > > What if we taint the kernel or pci_warn() for cases where either all
> > > the reset methods are disabled, ie. 'echo none > reset_method', or any
> > > time a device specific method is disabled?  
> > 
> > What does it mean "none"? Does it mean nothing supported? If yes, I think that
> > pci_warn() will be enough. At least for me, taint is usable during debug stages,
> > probably if device doesn't crash no one will look to see /proc/sys/kernel/tainted.
> 
> "none" as implemented in this patch, clearing the enabled function
> reset methods.

It is far from intuitive, the empty string will be easier to understand,
because "none" means no reset at all.

> 
> > > I'd almost go so far as to prevent disabling a device specific reset
> > > altogether, but for example should a device specific reset that fixes
> > > an aspect of FLR behavior prevent using a bus reset?  I'd prefer in that
> > > case if direct FLR were disabled via a device flag introduced with the
> > > quirk and the remaining resets can still be selected by preference.  
> > 
> > I don't know enough to discuss the PCI details, but you raised good point.
> > This sysfs is user visible API that is presented as is from device point
> > of view. It can be easily run into problems if PCI/core doesn't work with
> > user's choice.
> > 
> > > 
> > > Theoretically all the other reset methods work and are available, it's
> > > only a policy decision which to use, right?  
> > 
> > But this patch was presented as a way to overcome situations where
> > supported != working and user magically knows which reset type to set.
> 
> It's not magic, the new sysfs attributes expose which resets are
> enabled and the order that they're used, the user can simply select the
> next one.  Being able to bypass a broken reset method is a helpful side
> effect of getting to select a preferred reset method.

Magic in a sense that user has no idea what those resets mean, the
expectation is that he will blindly iterate till something works.

> 
> > If you want to take this patch to be policy decision tool,
> > it will need to accept "reset_type1,reset_type2,..." sort of input,
> > so fallback will work natively.
> 
> I don't see that as a requirement.  We have fall-through support in the
> kernel, but for a given device we're really only ever going to make use
> of one of those methods.  If a user knows enough about a device to have
> a preference, I think it can be singular.  That also significantly
> simplifies the interface and supporting code.  Thanks,

I'm struggling to get requirements from this thread. You talked about
policy decision to overtake fallback mechanism, Amey wanted to avoid
quirks.

Do you have an example of such devices or we are talking about
theoretical case?

And I don't see why simple line parser with loop iterator over strchr()
suddenly becomes complicated code.

Thanks

> 
> Alex
> 
