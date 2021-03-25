Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD91F348BA7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 09:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYIiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 04:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhCYIh7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 04:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33C9661A21;
        Thu, 25 Mar 2021 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616661478;
        bh=uYMbFGxqTZIsfXRgrg19l9ZILT2TSPjtKuvKv3EIrnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBu01kHzevQo/p44eWLLhzipn9jKUkOE/fP8H/XbBuFxEHaCN2B2IIMdwGwU6Uqps
         WyEZBTnqdvhTeqjFDySjv/blH4kkNbvZvaJciN4p+UGf4ZKDyGypglc0ohHlV8QIOU
         fJv+a68dE+u1BzmzUgvBsaCM4Rui38vWfzjNvk6CWpOHTS/Fp7J3WucRic8C34rLC9
         9+w18WqYN1UCuitCGNVRMRkiOkVl/fG56SRuvBYwXqhCciuUELl00WdPGTN82SIlT/
         tiMmWP2s/5aNnI0JhStZlHoMpSGUJCmFPmLAc89ghb6mZa+UlZUbmJ3s6VpGKGoO9w
         VJZmVOSPytttg==
Date:   Thu, 25 Mar 2021 10:37:54 +0200
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
Message-ID: <YFxL4o/QpmhM8KiH@unreal>
References: <YFSgQ2RWqt4YyIV4@unreal>
 <20210319102313.179e9969@omen.home.shazbot.org>
 <YFW78AfbhYpn16H4@unreal>
 <20210320085942.3cefcc48@x1.home.shazbot.org>
 <YFcGlzbaSzQ5Qota@unreal>
 <20210322111003.50d64f2c@omen.home.shazbot.org>
 <YFsOVNM1zIqNUN8f@unreal>
 <20210324083743.791d6191@omen.home.shazbot.org>
 <YFtXNF+t/0G26dwS@unreal>
 <20210324111729.702b3942@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324111729.702b3942@omen.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 24, 2021 at 11:17:29AM -0600, Alex Williamson wrote:
> On Wed, 24 Mar 2021 17:13:56 +0200
> Leon Romanovsky <leon@kernel.org> wrote:

<...>

> > Yes, and real testing/debugging almost always requires kernel rebuild.
> > Everything else is waste of time.
> 
> Sorry, this is nonsense.  Allowing users to debug issues without a full
> kernel rebuild is a good thing.

It is far from debug, this interface doesn't give you any answers why
the reset didn't work, it just helps you to find the one that works.

Unless you believe that this information will be enough to understand
the root cause, you will need to ask from the user to perform extra
tests, maybe try some quirk. All of that requires from the users to
rebuild their kernel.

So no, it is not debug.

> 
> > > > > For policy preference, I already described how I've configured QEMU to
> > > > > prefer a bus reset rather than a PM reset due to lack of specification
> > > > > regarding the scope of a PM "soft reset".  This interface would allow a
> > > > > system policy to do that same thing.
> > > > > 
> > > > > I don't think anyone is suggesting this as a means to avoid quirks that
> > > > > would resolve reset issues and create the best default general behavior.
> > > > > This provides a mechanism to test various reset methods, and thereby
> > > > > identify broken methods, and set a policy.  Sure, that policy might be
> > > > > to avoid a broken reset in the interim before it gets quirked and
> > > > > there's potential for abuse there, but I think the benefits outweigh
> > > > > the risks.    
> > > > 
> > > > This interface is proposed as first class citizen in the general sysfs
> > > > layout. Of course, it will be seen as a way to bypass the kernel.
> > > > 
> > > > At least, put it under CONFIG_EXPERT option, so no distro will enable it
> > > > by default.  
> > > 
> > > Of course we're proposing it to be accessible, it should also require
> > > admin privileges to modify, sysfs has lots of such things.  If it's
> > > relegated to non-default accessibility, it won't be used for testing
> > > and it won't be available for system policy and it's pointless.  
> > 
> > We probably have difference in view of what testing is. I expect from
> > the users who experience issues with reset to do extra steps and one of
> > them is to require from them to compile their kernel.
> 
> I would define the ability to generate a CI test that can pick a
> device, unbind it from its driver, and iterate reset methods as a
> worthwhile improvement in testing.

Who is going to run this CI? At least all kernel CIs (external and
internal to HW vendors) that I'm familiar are building kernel themselves.

Distro kernel is too bloat to be really usable for CI.

> 
> > The root permissions doesn't protect from anything, SO lovers will use
> > root without even thinking twice.
> 
> Yes, with great power comes great responsibility.  Many admins ignore
> this.  That's far beyond the scope of this series.

<...>

> > I'm trying to help you with your use case of providing reset policy
> > mechanism, which can be without CONFIG_EXPERT. However if you want
> > to continue path of having specific reset type only, please ensure
> > that this is not taken to the "bypass kernel" direction.
> 
> You've lost me, are you saying you'd be in favor of an interface that
> allows an admin to specify an arbitrary list of reset methods because
> that's somehow more in line with a policy choice than a userspace
> workaround?  This seems like unnecessary bloat because (a) it allows
> the same bypass mechanism, and (b) a given device is only going to use
> a single method anyway, so the functionality is unnecessary.  Please
> help me understand how this favors the policy use case.  Thanks,

The policy decision is global logic that is easier to grasp. At some
point of our discussion, you presented the case where PM reset is not
defined well and you prefer to do bus reset (something like that).

I expect that QEMU sets same reset policy for all devices at the same
time instead of trying per-device to guess which one works.

And yes, you will be able to bypass kernel, but at least this interface
will be broader than initial one that serves only SO and workarounds.

Thanks

> 
> Alex
> 
