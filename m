Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ADE3496BF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 17:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYQ1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhCYQ1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 12:27:35 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557EBC06174A;
        Thu, 25 Mar 2021 09:27:35 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2502989otr.4;
        Thu, 25 Mar 2021 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5Ii9ioTk5DBDRo/eb1vw/NJjq462M7hb+quoEebhFs=;
        b=SI43kF7g+Di3eYvvOCKPXYO/c3EsrTGm/th0BOeocVpNjJICcBN9UUHDD4o/bnYP4j
         /+bwOXP0/STQj2eieD/TIfRkLdN5R9xA/lUKm2wrsf6r5YfOrHeVUwnLSk80r/LQHZYo
         +sQI5Cfahre+9eBCQ7acn1BlWEmuG19HaDVNFmwxjCLRUgue6gV/iq8KYiGcFxxwAG1j
         40x8+bzOQe9c5TVcs+vdfFZo1D1iO1WsKpiaiSGgOH7nLW63T76Vddgu857YDBAWvnvh
         iUBWs8V57Q5ppBKT118ply7Apmrh+A0LtZXJrRhLYnDDerWMMuTKTDrocgxL8zXtbrnj
         7rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5Ii9ioTk5DBDRo/eb1vw/NJjq462M7hb+quoEebhFs=;
        b=jGwKSMFBSV193p3hX2SQ6jG4tp1VC9UbCtvCwFT8cMnJ3C5V7DM+suzax0DNRFeWpH
         vgJwoLUergAK8jUm3OZwqOgD7HWiEOzdniaW+VSrS11gf4Gk1eOD9055nPD0hk7r60ZM
         MKBowZdD6OqXwjn2O+Sf64Wc/46GiqxMKCkJnNP/ZgPBiK8DMJkPon1eeXVfeNRfy4Po
         QlNaMdLtAZ4B3gUAueFvZKE071xCSouoiOm99BbPSWVl7m5bqx+YNuDZXevAQMD9yoAY
         /Ydu9kvk6R0FCJ+fYxqkYrE+X05r8I56rCJhjz+f2GgHCYpo6TwzZ/kgJ+zqjQtTX6eU
         37nQ==
X-Gm-Message-State: AOAM5311TxfopUF4kffboyA1QaDmRVi6H3gTYpd8/j1mMcuYQmM2M1ul
        xnfuQijHIEVVo7AyTmEuJOM=
X-Google-Smtp-Source: ABdhPJys8cK7TtoIBv7+WCzlBYVwiw8Ojq/Eh27ptGjRuCb9Dus+boDLq+IejwdFHbcVjdS8M153PQ==
X-Received: by 2002:a9d:6951:: with SMTP id p17mr7966095oto.158.1616689654572;
        Thu, 25 Mar 2021 09:27:34 -0700 (PDT)
Received: from localhost ([107.181.165.199])
        by smtp.gmail.com with ESMTPSA id z25sm1504626otj.68.2021.03.25.09.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:27:33 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:56:37 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     info@metux.net, raphael.norwitz@nutanix.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210325162637.6ewxkxhvogdsgdxv@archlinux>
References: <20210319102313.179e9969@omen.home.shazbot.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxL4o/QpmhM8KiH@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/25 10:37AM, Leon Romanovsky wrote:
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
>
> >
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
>
> >
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
The current reset attribute does the same thing internally you described
at the end.
> And yes, you will be able to bypass kernel, but at least this interface
> will be broader than initial one that serves only SO and workarounds.
>
What does it mean by "bypassing" kernel?
I don't see any problem with SO and workaround if that is the only
way an user can use their device. Why are you expecting every vendor to
develop quirk? Also I don't see any point of using linked list to
unnecessarily complicate a simple thing.

Thanks,
Amey
