Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8344436F031
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbhD2TMQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbhD2TFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 15:05:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F2C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 12:05:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z6so6708253wrm.4
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pFNa8DXNOTRwI0q0kqi1H3IoccMGxWweupDE/jx4l44=;
        b=lqQK4b4ZEYaPpj/if1uYjE3EBlBia+XQKYSbavESxEPbhgmxpmplkKQoSBAFjDQKxm
         BAjDK6xnAGx0C4CFF7A2oWUn5KFHOYmehsZpZ6hkL8H/qEkmR5d+OwjhMcVRUaYe5wUP
         WhyN6Q9Gp0xnRYLKT+rs1alOf/YxdcXgSauBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pFNa8DXNOTRwI0q0kqi1H3IoccMGxWweupDE/jx4l44=;
        b=swX5KVlx7Kc2ONEsm4AAYkpymIFjBQTp8hnec/zJBMXdS26pBBA25YBorkyl7Od9VI
         QgmaLX6tNo9MS33mfUU4bI5Pc8oaXFbxnKGlSZj1AKVKKBlK212VGng6GHDByGeOzPlW
         7FPC+npVLYKtanPKLCR4tKssCJcrpGQnEUaN049ZCawVsyP1VIWHoarP+mWewboZ3N0D
         Jby8GUjBJKz7i0bAW9rR99sTv5wJSplh1oflpaQaZbHAQ83ivrR8fLZQ7Lg35UKXjddz
         NP4IidXwxMWBh1AOxDqip/pz7Br2GW8GH1Jn24XSTDkloRn9ZJsXDs5KYcM5/NFZ9NoQ
         UeRA==
X-Gm-Message-State: AOAM532tJ0AlSFoBA3iV6lIjwdy3EcS4jS67jLmfSCWKt2Gb6VqZcDDu
        ikGOhYsqWAbtpI8j5RhqNHvNOQ==
X-Google-Smtp-Source: ABdhPJzc5PIOUKnuRM85hXu9tyRpgsayL+dt3hWjkxSkGODDwr8h8aWOQselQ2K5Cghq/9E9oXWxiQ==
X-Received: by 2002:a5d:4acf:: with SMTP id y15mr1427195wrs.245.1619723103936;
        Thu, 29 Apr 2021 12:05:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q20sm18333656wmq.2.2021.04.29.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:05:03 -0700 (PDT)
Date:   Thu, 29 Apr 2021 21:05:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        ckoenig.leichtzumerken@gmail.com, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com, ppaalanen@gmail.com,
        Alexander.Deucher@amd.com, gregkh@linuxfoundation.org,
        helgaas@kernel.org, Felix.Kuehling@amd.com
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs with
 drm_dev_enter/exit
Message-ID: <YIsDXWMYkMeNhBYk@phenom.ffwll.local>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
 <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local>
 <YIqZZW9iFyGCyOmU@phenom.ffwll.local>
 <95935e46-408b-4fee-a7b4-691e9db4f455@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95935e46-408b-4fee-a7b4-691e9db4f455@amd.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 12:04:33PM -0400, Andrey Grodzovsky wrote:
> 
> 
> On 2021-04-29 7:32 a.m., Daniel Vetter wrote:
> > On Thu, Apr 29, 2021 at 01:23:19PM +0200, Daniel Vetter wrote:
> > > On Wed, Apr 28, 2021 at 11:12:00AM -0400, Andrey Grodzovsky wrote:
> > > > With this calling drm_dev_unplug will flush and block
> > > > all in flight IOCTLs
> > > > 
> > > > Also, add feature such that if device supports graceful unplug
> > > > we enclose entire IOCTL in SRCU critical section.
> > > > 
> > > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > > 
> > > Nope.
> > > 
> > > The idea of drm_dev_enter/exit is to mark up hw access. Not entire ioctl.
> 
> Then I am confused why we have https://elixir.bootlin.com/linux/v5.12/source/drivers/gpu/drm/drm_ioctl.c#L826
> currently in code ?

I forgot about this one, again. Thanks for reminding.

> > > Especially not with an opt-in flag so that it could be shrugged of as a
> > > driver hack. Most of these ioctls should have absolutely no problem
> > > working after hotunplug.
> > > 
> > > Also, doing this defeats the point since it pretty much guarantees
> > > userspace will die in assert()s and stuff. E.g. on i915 the rough contract
> > > is that only execbuf (and even that only when userspace has indicated
> > > support for non-recoverable hw ctx) is allowed to fail. Anything else
> > > might crash userspace.
> 
> Given that as I pointed above we already fail any IOCTls with -ENODEV
> when device is unplugged, it seems those crashes don't happen that
> often ? Also, in all my testing I don't think I saw a user space crash
> I could attribute to this.

I guess it should be ok.

My reasons for making this work is both less trouble for userspace (did
you test with various wayland compositors out there, not just amdgpu x86
driver?), but also testing.

We still need a bunch of these checks in various places or you'll wait a
very long time for a pending modeset or similar to complete. Being able to
run that code easily after hotunplug has completed should help a lot with
testing.

Plus various drivers already acquired drm_dev_enter/exit and now I wonder
whether that was properly tested or not ...

I guess maybe we need a drm module option to disable this check, so that
we can exercise the code as if the ioctl has raced with hotunplug at the
worst possible moment.

Also atomic is really tricky here: I assume your testing has just done
normal synchronous commits, but anything that goes through atomic can be
done nonblocking in a separate thread. Which the ioctl catch-all here wont
capture.

> > > You probably need similar (and very precisely defined) rules for amdgpu.
> > > And those must definitely exclude any shard ioctls from randomly failing
> > > with EIO, because that just kills the box and defeats the point of trying
> > > to gracefully handling hotunplug and making sure userspace has a chance of
> > > survival. E.g. for atomic everything should continue, including flip
> > > completion, but we set all outputs to "disconnected" and send out the
> > > uevent. Maybe crtc enabling can fail too, but that can also be handled
> > > through the async status we're using to signal DP link failures to
> > > userspace.
> 
> As I pointed before, because of the complexity of the topic I prefer to
> take it step by step and solve first for secondary device use case, not
> for primary, display attached device.

Yeah makes sense. But then I think the right patch is to roll this out for
all drivers, properly justified with existing code. Not behind a driver
flag, because with all these different compositors the last thing we want
is a proliferation of driver-specific behaviour. That's imo the worst
option of all of them and needs to be avoided.

Cheers, Daniel


> 
> > > 
> > > I guess we should clarify this in the hotunplug doc?
> 
> Agree
> 
> > 
> > To clarify: I'm not against throwing an ENODEV at userspace for ioctl that
> > really make no sense, and where we're rather confident that all properly
> > implemented userspace will gracefully handle failures. Like a modeset, or
> > opening a device, or trying to import a dma-buf or stuff like that which
> > can already fail in normal operation for any kind of reason.
> > 
> > But stuff that never fails, like GETRESOURCES ioctl, really shouldn't fail
> > after hotunplug.
> 
> As I pointed above, this a bit confuses me given that we already do
> blanker rejection of IOCTLs if device is unplugged.

Well I'm confused about this too :-/

> > And then there's the middle ground, like doing a pageflip or buffer flush,
> > which I guess some userspace might handle, but risky to inflict those
> > consequences on them. atomic modeset is especially fun since depending
> > what you're doing it can be both "failures expected" and "failures not
> > really expected in normal operation".
> > 
> > Also, this really should be consistent across drivers, not solved with a
> > driver flag for every possible combination.
> > 
> > If you look at the current hotunplug kms drivers, they have
> > drm_dev_enter/exit sprinkled in specific hw callback functions because of
> > the above problems. But maybe it makes sense to change things in a few
> > cases. But then we should do it across the board.
> 
> So as I understand your preferred approach is that I scope any back_end, HW
> specific function with drm_dev_enter/exit because that where MMIO
> access takes place. But besides explicit MMIO access thorough
> register accessors in the HW back-end there is also indirect MMIO access
> taking place throughout the code in the driver because of various VRAM
> BOs which provide CPU access to VRAM through the VRAM BAR. This kind of
> access is spread all over in the driver and even in mid-layers such as
> TTM and not limited to HW back-end functions. It means it's much harder
> to spot such places to surgically scope them with drm_dev_enter/exit and
> also that any new such code introduced will immediately break hot unplug
> because the developers can't be expected to remember making their code
> robust to this specific use case. That why when we discussed internally
> what approach to take to protecting code with drm_dev_enter/exit we
> opted for using the widest available scope.

The thing is, you kinda have to anyway. There's enormous amounts of
asynchronous processing going on. E.g. nonblocking atomic commits also do
ttm unpinning and fun stuff like that, which if you sync things wrong can
happen way late. So the door for bad fallout is wide open :-(

I'm not sure where the right tradeoff is to make sure we catch them all,
and can make sure with testing that we've indeed caught them all.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
