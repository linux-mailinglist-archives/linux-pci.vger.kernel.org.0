Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230193494B7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCYOzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 10:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231296AbhCYOzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 10:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616684131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kn2t3/GSxXfvrEv0CvBOK8eosR6M+6rYSsq3942c6LI=;
        b=RxIxio56D+DB9VJe6L/hoPNHm8CruyzvUNlM3/0AdfcLzh5tSy7Np5mTDBq3q96CdFMGkS
        q02bYjgHs0gWItgv6Xy1o/j5fRF5qJSohcoZa4wigaO8lSiV8T6B0kCJ7stEm9ylyLcNTf
        KdT/D2TOFqT1px36Y8rXXTW333doEi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-fNaUMYDBM_eMLsMaHC0NSg-1; Thu, 25 Mar 2021 10:55:27 -0400
X-MC-Unique: fNaUMYDBM_eMLsMaHC0NSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB13610059D2;
        Thu, 25 Mar 2021 14:55:05 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFE7D5D9DE;
        Thu, 25 Mar 2021 14:55:04 +0000 (UTC)
Date:   Thu, 25 Mar 2021 08:55:04 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210325085504.051e93f2@omen.home.shazbot.org>
In-Reply-To: <YFxL4o/QpmhM8KiH@unreal>
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
        <YFxL4o/QpmhM8KiH@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Mar 2021 10:37:54 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Mar 24, 2021 at 11:17:29AM -0600, Alex Williamson wrote:
> > On Wed, 24 Mar 2021 17:13:56 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:  
> 
> <...>
> 
> > > Yes, and real testing/debugging almost always requires kernel rebuild.
> > > Everything else is waste of time.  
> > 
> > Sorry, this is nonsense.  Allowing users to debug issues without a full
> > kernel rebuild is a good thing.  
> 
> It is far from debug, this interface doesn't give you any answers why
> the reset didn't work, it just helps you to find the one that works.
> 
> Unless you believe that this information will be enough to understand
> the root cause, you will need to ask from the user to perform extra
> tests, maybe try some quirk. All of that requires from the users to
> rebuild their kernel.
> 
> So no, it is not debug.

It allows a user to experiment to determine (a) my device doesn't work
in a given scenario with the default configuration, but (b) if I change
the reset to this other thing it does work.  That is a step in
debugging.

It's absurd to think that a sysfs attribute could provide root cause,
but it might be enough for someone to further help that user.  It would
be a useful clue for a bug report.  Yes, reaching root cause might
involve building a kernel, but that doesn't invalidate that having a
step towards debugging in the base kernel might be a useful tool.

> > > > > > For policy preference, I already described how I've configured QEMU to
> > > > > > prefer a bus reset rather than a PM reset due to lack of specification
> > > > > > regarding the scope of a PM "soft reset".  This interface would allow a
> > > > > > system policy to do that same thing.
> > > > > > 
> > > > > > I don't think anyone is suggesting this as a means to avoid quirks that
> > > > > > would resolve reset issues and create the best default general behavior.
> > > > > > This provides a mechanism to test various reset methods, and thereby
> > > > > > identify broken methods, and set a policy.  Sure, that policy might be
> > > > > > to avoid a broken reset in the interim before it gets quirked and
> > > > > > there's potential for abuse there, but I think the benefits outweigh
> > > > > > the risks.      
> > > > > 
> > > > > This interface is proposed as first class citizen in the general sysfs
> > > > > layout. Of course, it will be seen as a way to bypass the kernel.
> > > > > 
> > > > > At least, put it under CONFIG_EXPERT option, so no distro will enable it
> > > > > by default.    
> > > > 
> > > > Of course we're proposing it to be accessible, it should also require
> > > > admin privileges to modify, sysfs has lots of such things.  If it's
> > > > relegated to non-default accessibility, it won't be used for testing
> > > > and it won't be available for system policy and it's pointless.    
> > > 
> > > We probably have difference in view of what testing is. I expect from
> > > the users who experience issues with reset to do extra steps and one of
> > > them is to require from them to compile their kernel.  
> > 
> > I would define the ability to generate a CI test that can pick a
> > device, unbind it from its driver, and iterate reset methods as a
> > worthwhile improvement in testing.  
> 
> Who is going to run this CI? At least all kernel CIs (external and
> internal to HW vendors) that I'm familiar are building kernel themselves.
> 
> Distro kernel is too bloat to be really usable for CI.

At this point I'm suspicious you're trolling.  A distro kernel CI
certainly uses the kernel they intend to ship and support in their
environment. You're concerned about a bloated kernel, but the proposal
here adds 2-bytes per device to track reset methods and a trivial array
in text memory, meanwhile you're proposing multiple per-device memory
allocations to enhance the feature you think is too bloated for CI.

> > > The root permissions doesn't protect from anything, SO lovers will use
> > > root without even thinking twice.  
> > 
> > Yes, with great power comes great responsibility.  Many admins ignore
> > this.  That's far beyond the scope of this series.  
> 
> <...>
> 
> > > I'm trying to help you with your use case of providing reset policy
> > > mechanism, which can be without CONFIG_EXPERT. However if you want
> > > to continue path of having specific reset type only, please ensure
> > > that this is not taken to the "bypass kernel" direction.  
> > 
> > You've lost me, are you saying you'd be in favor of an interface that
> > allows an admin to specify an arbitrary list of reset methods because
> > that's somehow more in line with a policy choice than a userspace
> > workaround?  This seems like unnecessary bloat because (a) it allows
> > the same bypass mechanism, and (b) a given device is only going to use
> > a single method anyway, so the functionality is unnecessary.  Please
> > help me understand how this favors the policy use case.  Thanks,  
> 
> The policy decision is global logic that is easier to grasp. At some
> point of our discussion, you presented the case where PM reset is not
> defined well and you prefer to do bus reset (something like that).
> 
> I expect that QEMU sets same reset policy for all devices at the same
> time instead of trying per-device to guess which one works.
> 
> And yes, you will be able to bypass kernel, but at least this interface
> will be broader than initial one that serves only SO and workarounds.

I still think allocating objects for a list and managing that list is
too bloated and complicated, but I agree that being able to have more
fine grained control could be useful.  Is it necessary to be able to
re-order reset methods or might it still be better aligned to a policy
use case if we allow plus and minus operators?  For example, a device
might list:

[pm] [bus]

Indicating that PM and bus reset are both available and enabled.  The
user could do:

echo -pm > reset_methods

This would result in:

pm [bus]

Indicating that both PM and bus resets are available, but only bus reset
is enabled (note this is the identical result to "echo bus >" in the
current proposal).  "echo +pm" or "echo default" could re-enable the PM
reset.  Would something like that be satisfactory?

If we need to allow re-ording, we'd want to use a byte-array where each
byte indicates a type of reset and perhaps a non-zero value in the
array indicates the method is enabled and the value indicates priority.
For example writing "dev_spec,flr,bus" would parse to write 1 to the
byte associated with the device specific reset, 2 to flr, 3 to bus
reset, then we'd process low to high (or maybe starting at a high value
to count down to zero might be more simple).  We could do that with
only adding less than a fixed 8-bytes per device and no dynamic
allocation.  Thoughts?  Thanks,

Alex

