Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A593497DC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYRYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 13:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCYRXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 13:23:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FBC06174A;
        Thu, 25 Mar 2021 10:23:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so4400141pjb.0;
        Thu, 25 Mar 2021 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ym9voxZu7yLQUsQnhxCTKr8deT/eCHFgvC8f9ub3VuY=;
        b=f4MEAeLzi2w/gYlNPG8dZmH4XGi1G6EWZInBQkCr4va+UufzQDuPNniZBaGFKtoE3u
         GTZc+C3JDoDxaDD0P8mK6EgC3Lyz8TnD5GbnzMg5rIylX4aspKRC6cA/wweuwUdUt4Se
         k/2PgTgE27okpRy2uUoFxcTec53S7ifg4IeRpesDi/7LYeg79nxcBKVz2pa3ZYxfjxZm
         sy3kJ/uwf2QwhOlZo/v3AiCd1s+nhdvLGr6JGkk/a43V4ffDYJOvw5uPTa/A2B5mxaNS
         ieFILJfJmc1jCYcBvIFVUY/dFxY3R8+WRjL4ZvPWl7WVDOUsrgnQ36KF6gn6a0kKhZVY
         rtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ym9voxZu7yLQUsQnhxCTKr8deT/eCHFgvC8f9ub3VuY=;
        b=VpPvW602EVZZIvbJTyh4l0hJEdbqsmJAlHyfInVnDNvIYh8S17tkGH45gs1wou+LlE
         jzaO+tIXO0K+x4hKy09oC3JDGGCJmQg3q5xN5/UegWSvZflDQf7Vgrm56YvIfBk4d0C8
         24GbJUsV6Y0mx1Vu+jMXsS56SzlT9sLG9bIpYOkP9RWFVE60N3s9vNH+RuU+mZFyGmkL
         /5EsGCqpOpG/T4yh0RWFGp8Ni/QmMYeeowygHWDQeiKfa2FOHIYkkWqRxbzuP50YwyPW
         GXu0Oov67YNv+C/DNyy8/bvaef21UChumnJVo72th4364WsRSUBEnQ59Zvk+7KLfVhrL
         LSCA==
X-Gm-Message-State: AOAM530cCSJdDt0aWLuj0jB03WvNtG4EI1f0NrP2kk9RaPyRx5lhPUyF
        JTenh0nIB1t1xfc1NyCzUnw=
X-Google-Smtp-Source: ABdhPJxkUT8CExL0d1SBenIEwPlPKq9wH8s3HIxOsfzTLxn4txZXcATpcQZk7AqBgZZ/HaZ9ZNwq5g==
X-Received: by 2002:a17:90a:498d:: with SMTP id d13mr10219390pjh.47.1616693026894;
        Thu, 25 Mar 2021 10:23:46 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id u1sm6265943pgg.11.2021.03.25.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 10:23:46 -0700 (PDT)
Date:   Thu, 25 Mar 2021 22:52:57 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     info@metux.net, raphael.norwitz@nutanix.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210325172257.jo67q62zxw45adwi@archlinux>
References: <20210320085942.3cefcc48@x1.home.shazbot.org>
 <YFcGlzbaSzQ5Qota@unreal>
 <20210322111003.50d64f2c@omen.home.shazbot.org>
 <YFsOVNM1zIqNUN8f@unreal>
 <20210324083743.791d6191@omen.home.shazbot.org>
 <YFtXNF+t/0G26dwS@unreal>
 <20210324111729.702b3942@omen.home.shazbot.org>
 <YFxL4o/QpmhM8KiH@unreal>
 <20210325085504.051e93f2@omen.home.shazbot.org>
 <YFy11u+fm4MEGU5X@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFy11u+fm4MEGU5X@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/25 06:09PM, Leon Romanovsky wrote:
> On Thu, Mar 25, 2021 at 08:55:04AM -0600, Alex Williamson wrote:
> > On Thu, 25 Mar 2021 10:37:54 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> >
> > > On Wed, Mar 24, 2021 at 11:17:29AM -0600, Alex Williamson wrote:
> > > > On Wed, 24 Mar 2021 17:13:56 +0200
> > > > Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > <...>
> > >
> > > > > Yes, and real testing/debugging almost always requires kernel rebuild.
> > > > > Everything else is waste of time.
> > > >
> > > > Sorry, this is nonsense.  Allowing users to debug issues without a full
> > > > kernel rebuild is a good thing.
> > >
> > > It is far from debug, this interface doesn't give you any answers why
> > > the reset didn't work, it just helps you to find the one that works.
> > >
> > > Unless you believe that this information will be enough to understand
> > > the root cause, you will need to ask from the user to perform extra
> > > tests, maybe try some quirk. All of that requires from the users to
> > > rebuild their kernel.
> > >
> > > So no, it is not debug.
> >
> > It allows a user to experiment to determine (a) my device doesn't work
> > in a given scenario with the default configuration, but (b) if I change
> > the reset to this other thing it does work.  That is a step in
> > debugging.
> >
> > It's absurd to think that a sysfs attribute could provide root cause,
> > but it might be enough for someone to further help that user.  It would
> > be a useful clue for a bug report.  Yes, reaching root cause might
> > involve building a kernel, but that doesn't invalidate that having a
> > step towards debugging in the base kernel might be a useful tool.
>
> Let's agree to do not agree.
>
> >
> > > > > > > > For policy preference, I already described how I've configured QEMU to
> > > > > > > > prefer a bus reset rather than a PM reset due to lack of specification
> > > > > > > > regarding the scope of a PM "soft reset".  This interface would allow a
> > > > > > > > system policy to do that same thing.
> > > > > > > >
> > > > > > > > I don't think anyone is suggesting this as a means to avoid quirks that
> > > > > > > > would resolve reset issues and create the best default general behavior.
> > > > > > > > This provides a mechanism to test various reset methods, and thereby
> > > > > > > > identify broken methods, and set a policy.  Sure, that policy might be
> > > > > > > > to avoid a broken reset in the interim before it gets quirked and
> > > > > > > > there's potential for abuse there, but I think the benefits outweigh
> > > > > > > > the risks.
> > > > > > >
> > > > > > > This interface is proposed as first class citizen in the general sysfs
> > > > > > > layout. Of course, it will be seen as a way to bypass the kernel.
> > > > > > >
> > > > > > > At least, put it under CONFIG_EXPERT option, so no distro will enable it
> > > > > > > by default.
> > > > > >
> > > > > > Of course we're proposing it to be accessible, it should also require
> > > > > > admin privileges to modify, sysfs has lots of such things.  If it's
> > > > > > relegated to non-default accessibility, it won't be used for testing
> > > > > > and it won't be available for system policy and it's pointless.
> > > > >
> > > > > We probably have difference in view of what testing is. I expect from
> > > > > the users who experience issues with reset to do extra steps and one of
> > > > > them is to require from them to compile their kernel.
> > > >
> > > > I would define the ability to generate a CI test that can pick a
> > > > device, unbind it from its driver, and iterate reset methods as a
> > > > worthwhile improvement in testing.
> > >
> > > Who is going to run this CI? At least all kernel CIs (external and
> > > internal to HW vendors) that I'm familiar are building kernel themselves.
> > >
> > > Distro kernel is too bloat to be really usable for CI.
> >
> > At this point I'm suspicious you're trolling.  A distro kernel CI
> > certainly uses the kernel they intend to ship and support in their
> > environment. You're concerned about a bloated kernel, but the proposal
> > here adds 2-bytes per device to track reset methods and a trivial array
> > in text memory, meanwhile you're proposing multiple per-device memory
> > allocations to enhance the feature you think is too bloated for CI.
>
> I don't know why you decided to focus on memory footprint which is not
> important at all during CI runs. The bloat is in Kconfig options that
> are not needed. Those extra options add significant overhead during
> builds and runs itself.
>
> And not, I'm not trolling, but representing HW vendor that pushes its CI
> and developers environment to the limit, by running full kernel builds with
> less than 30 seconds and boot-to-test with less than 6 seconds for full
> Fedora VM.
>
> >
> > > > > The root permissions doesn't protect from anything, SO lovers will use
> > > > > root without even thinking twice.
> > > >
> > > > Yes, with great power comes great responsibility.  Many admins ignore
> > > > this.  That's far beyond the scope of this series.
> > >
> > > <...>
> > >
> > > > > I'm trying to help you with your use case of providing reset policy
> > > > > mechanism, which can be without CONFIG_EXPERT. However if you want
> > > > > to continue path of having specific reset type only, please ensure
> > > > > that this is not taken to the "bypass kernel" direction.
> > > >
> > > > You've lost me, are you saying you'd be in favor of an interface that
> > > > allows an admin to specify an arbitrary list of reset methods because
> > > > that's somehow more in line with a policy choice than a userspace
> > > > workaround?  This seems like unnecessary bloat because (a) it allows
> > > > the same bypass mechanism, and (b) a given device is only going to use
> > > > a single method anyway, so the functionality is unnecessary.  Please
> > > > help me understand how this favors the policy use case.  Thanks,
> > >
> > > The policy decision is global logic that is easier to grasp. At some
> > > point of our discussion, you presented the case where PM reset is not
> > > defined well and you prefer to do bus reset (something like that).
> > >
> > > I expect that QEMU sets same reset policy for all devices at the same
> > > time instead of trying per-device to guess which one works.
> > >
> > > And yes, you will be able to bypass kernel, but at least this interface
> > > will be broader than initial one that serves only SO and workarounds.
> >
> > I still think allocating objects for a list and managing that list is
> > too bloated and complicated, but I agree that being able to have more
> > fine grained control could be useful.  Is it necessary to be able to
> > re-order reset methods or might it still be better aligned to a policy
> > use case if we allow plus and minus operators?  For example, a device
> > might list:
> >
> > [pm] [bus]
> >
> > Indicating that PM and bus reset are both available and enabled.  The
> > user could do:
> >
> > echo -pm > reset_methods
> >
> > This would result in:
> >
> > pm [bus]
> >
> > Indicating that both PM and bus resets are available, but only bus reset
> > is enabled (note this is the identical result to "echo bus >" in the
> > current proposal).  "echo +pm" or "echo default" could re-enable the PM
> > reset.  Would something like that be satisfactory?
>
> Yes, I actually imagined simpler interface:
> To set specific type:
> echo pm > reset_methods
> To set policy:
> echo "pm,bus" > reset_methods
>
> But your proposal is nicer.
>
Okay I'll include this in v2
> >
> > If we need to allow re-ording, we'd want to use a byte-array where each
> > byte indicates a type of reset and perhaps a non-zero value in the
> > array indicates the method is enabled and the value indicates priority.
> > For example writing "dev_spec,flr,bus" would parse to write 1 to the
> > byte associated with the device specific reset, 2 to flr, 3 to bus
> > reset, then we'd process low to high (or maybe starting at a high value
> > to count down to zero might be more simple).  We could do that with
> > only adding less than a fixed 8-bytes per device and no dynamic
> > allocation.  Thoughts?  Thanks,
>
> Like I suggested, linked list will be easier and the reset will be
> something like:
>  for_each_reset_type(device, type) {
>    switch (type) {
>    	case PM:
> 	       ret = do_some_reset(device);
> 	       break;
> 	case BUS:
> 		.....
> 	}
>    if (!ret || ret == -ENOMEM)  <-- go to next type in linked list
>      return ret;
>    }
>
Maybe we can use a byte array here. Lets consider current pci_reset_fn_methods
array. If a input is "pm, flr" we can have byte array with index of
those methods in pci_reset_fn_methods like [3, 1]. So when user triggers a
reset we use reset method at index 3(pm) and then at index 1(flr).
Does that make sense?

Thanks,
Amey
