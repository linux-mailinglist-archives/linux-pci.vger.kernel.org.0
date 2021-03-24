Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC0347543
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 11:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhCXKDV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 06:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233339AbhCXKDE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 06:03:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94502619EC;
        Wed, 24 Mar 2021 10:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616580184;
        bh=vysyaDICHpR4+rEdgMHoZy2GtnTEVbUPcoP+QJWIJcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FatSt3OSOUuCy9oOv7XjnzjJvZLdrMonv/3eYWvvU9BThARt9G5rhIXHIpTWum0k1
         VlMfoD7yBfDzH7UkvREd0E0nd5nin69DrYkAIaEG3pA1DVNY3CgNsJxJ8YiwUH4r2v
         mWnsNmfNVar91mq7tBgnwaJ/nxkFXhF8Yx6uomuw+H5Ys7auGTiujdMNoUqIsh7DPo
         zrc828tSvf1oyYCbxMMJ/NzoloeNdpT+LptG9fclDQt1CKwPLVLvp2adgJUsetGcOi
         VlrfIPd/IKOrSbGSV2NVsE5cfjuGciEmX0/hqxuoOOc2MZDrCBXnGBqIJM/W5YVk8l
         Ro9t7qv/mTqwA==
Date:   Wed, 24 Mar 2021 12:03:00 +0200
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
Message-ID: <YFsOVNM1zIqNUN8f@unreal>
References: <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
 <YFOMShJAm4j/3vRl@unreal>
 <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
 <YFSgQ2RWqt4YyIV4@unreal>
 <20210319102313.179e9969@omen.home.shazbot.org>
 <YFW78AfbhYpn16H4@unreal>
 <20210320085942.3cefcc48@x1.home.shazbot.org>
 <YFcGlzbaSzQ5Qota@unreal>
 <20210322111003.50d64f2c@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322111003.50d64f2c@omen.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 22, 2021 at 11:10:03AM -0600, Alex Williamson wrote:
> On Sun, 21 Mar 2021 10:40:55 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Sat, Mar 20, 2021 at 08:59:42AM -0600, Alex Williamson wrote:
> > > On Sat, 20 Mar 2021 11:10:08 +0200
> > > Leon Romanovsky <leon@kernel.org> wrote:  
> > > > On Fri, Mar 19, 2021 at 10:23:13AM -0600, Alex Williamson wrote:   
> > > > > 
> > > > > What if we taint the kernel or pci_warn() for cases where either all
> > > > > the reset methods are disabled, ie. 'echo none > reset_method', or any
> > > > > time a device specific method is disabled?    
> > > > 
> > > > What does it mean "none"? Does it mean nothing supported? If yes, I think that
> > > > pci_warn() will be enough. At least for me, taint is usable during debug stages,
> > > > probably if device doesn't crash no one will look to see /proc/sys/kernel/tainted.  
> > > 
> > > "none" as implemented in this patch, clearing the enabled function
> > > reset methods.  
> > 
> > It is far from intuitive, the empty string will be easier to understand,
> > because "none" means no reset at all.
> 
> "No reset at all" is what "none" achieves, the
> pci_dev.reset_methods_enabled bitmap is cleared.  We can use an empty
> string, but I think we want a way to clear all enabled resets and a way
> to return it to the default.  I could see arguments for an empty string
> serving either purpose, so this version proposed explicitly using
> "none" and "default", as included in the ABI update.

I will stick with "default" only and leave "none" for something else.

> 
> > > > > I'd almost go so far as to prevent disabling a device specific reset
> > > > > altogether, but for example should a device specific reset that fixes
> > > > > an aspect of FLR behavior prevent using a bus reset?  I'd prefer in that
> > > > > case if direct FLR were disabled via a device flag introduced with the
> > > > > quirk and the remaining resets can still be selected by preference.    
> > > > 
> > > > I don't know enough to discuss the PCI details, but you raised good point.
> > > > This sysfs is user visible API that is presented as is from device point
> > > > of view. It can be easily run into problems if PCI/core doesn't work with
> > > > user's choice.
> > > >   
> > > > > 
> > > > > Theoretically all the other reset methods work and are available, it's
> > > > > only a policy decision which to use, right?    
> > > > 
> > > > But this patch was presented as a way to overcome situations where
> > > > supported != working and user magically knows which reset type to set.  
> > > 
> > > It's not magic, the new sysfs attributes expose which resets are
> > > enabled and the order that they're used, the user can simply select the
> > > next one.  Being able to bypass a broken reset method is a helpful side
> > > effect of getting to select a preferred reset method.  
> > 
> > Magic in a sense that user has no idea what those resets mean, the
> > expectation is that he will blindly iterate till something works.
> 
> Which ought to actually be a safe thing to do.  We should have quirks to
> exclude resets that are known broken but still probe as present and I'd
> be perfectly fine if we issue a warning if the user disables all resets
> for a given device.
>  
> > > > If you want to take this patch to be policy decision tool,
> > > > it will need to accept "reset_type1,reset_type2,..." sort of input,
> > > > so fallback will work natively.  
> > > 
> > > I don't see that as a requirement.  We have fall-through support in the
> > > kernel, but for a given device we're really only ever going to make use
> > > of one of those methods.  If a user knows enough about a device to have
> > > a preference, I think it can be singular.  That also significantly
> > > simplifies the interface and supporting code.  Thanks,  
> > 
> > I'm struggling to get requirements from this thread. You talked about
> > policy decision to overtake fallback mechanism, Amey wanted to avoid
> > quirks.
> > 
> > Do you have an example of such devices or we are talking about
> > theoretical case?
> 
> Look at any device that already has a reset quirk and the process it
> took to get there.  Those are more than just theoretical cases.

So let's fix the process. The long standing kernel policy is that kernel
bugs (and missing quirk can be seen as such bug) should be fixed in the
kernel and not workaround by the users.

> 
> For policy preference, I already described how I've configured QEMU to
> prefer a bus reset rather than a PM reset due to lack of specification
> regarding the scope of a PM "soft reset".  This interface would allow a
> system policy to do that same thing.
> 
> I don't think anyone is suggesting this as a means to avoid quirks that
> would resolve reset issues and create the best default general behavior.
> This provides a mechanism to test various reset methods, and thereby
> identify broken methods, and set a policy.  Sure, that policy might be
> to avoid a broken reset in the interim before it gets quirked and
> there's potential for abuse there, but I think the benefits outweigh
> the risks.

This interface is proposed as first class citizen in the general sysfs
layout. Of course, it will be seen as a way to bypass the kernel.

At least, put it under CONFIG_EXPERT option, so no distro will enable it
by default.

> 
> > And I don't see why simple line parser with loop iterator over strchr()
> > suddenly becomes complicated code.
> 
> Setting multiple bits in a bitmap is easy.  How do you then go on to
> allow the user to specify an ordering preference?  If you have an
> algorithm you'd like to propose that allows the user to manage the
> ordering when enabling multiple methods without substantially
> increasing the complexity, please share.  IMO, a given device will
> generally use one reset method and it seems sufficient to restrict user
> preference to achieve all the use cases I've noted.  Thanks,

Linked list + iterator will do the trick.

> 
> Alex
> 
