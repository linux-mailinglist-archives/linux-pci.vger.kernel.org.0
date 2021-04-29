Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9EF36E99F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhD2Ldo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Ldn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 07:33:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D1C06138B
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 04:32:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so7843837wmq.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Apr 2021 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHVvBdX5yruZNuaE6au3mmpWmkpoYnyq1LRiMVUzyEs=;
        b=i6TqpaqwZIaTAklta46eRDAvyvsRvTWw7hhqFDWaP2OQ4TmLVFWxv3ZtA2QYnC5AP5
         1t1ohca7oAD7FIgbIn4ZE0Lj9ChX5ctebQ0hrydD21BhpPvDXo8DI59OtgD8imrwHgw7
         ABYSeruiRE+HCbHgwoGJ/kt/q4ouXEr4vfEr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHVvBdX5yruZNuaE6au3mmpWmkpoYnyq1LRiMVUzyEs=;
        b=DSbQqHTvWUyrDdNCGm0ElaOWFjMzJv0FHZR++3NgQdumVO/ays9aP/jv4yUYnfP/Bm
         OGcmHOLKzJ9jLNyzp/vhBpNkoX3I2hcVBM+uuEWKERQfWfaHEex3xt34Z+jeqFLGa+l3
         3+xL/sVHIf/pt8f+dDjsQ3VOHFN6SW8z83eXu8A6j7kMYZ9CrgQ1nf1x8aDj9dzyNz/s
         mTC0WZnOoLHMfB7WiSG1zRouPXO7erw1hqH51Bs3R6HmbOJLJFPaoMQSpIyrlQfxLqZR
         xGA2SP8y7vZXLRtjtVs/nlsE44OYVGShtCQO1udjBrzdKJJJesCSqcTq1Nb6bSLxVMQs
         ZuVw==
X-Gm-Message-State: AOAM533zjFOFTsJ+novkH6Ul4WDE+HnaG4vLqIr8dNjV5TzFIQHompeQ
        GfW7pl6pd3WTLFVvCxu+fLOf1g==
X-Google-Smtp-Source: ABdhPJwmPDSU2R2T2gFQK0GFek3qSa8MyzcXyXewBZob9l1eoq+OGIfRwULnAPSgltMO1QmTvugW0w==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr2176067wml.93.1619695975670;
        Thu, 29 Apr 2021 04:32:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm10503457wmc.6.2021.04.29.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 04:32:55 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:32:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs  with
 drm_dev_enter/exit
Message-ID: <YIqZZW9iFyGCyOmU@phenom.ffwll.local>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
 <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 01:23:19PM +0200, Daniel Vetter wrote:
> On Wed, Apr 28, 2021 at 11:12:00AM -0400, Andrey Grodzovsky wrote:
> > With this calling drm_dev_unplug will flush and block
> > all in flight IOCTLs
> > 
> > Also, add feature such that if device supports graceful unplug
> > we enclose entire IOCTL in SRCU critical section.
> > 
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> 
> Nope.
> 
> The idea of drm_dev_enter/exit is to mark up hw access. Not entire ioctl.
> 
> Especially not with an opt-in flag so that it could be shrugged of as a
> driver hack. Most of these ioctls should have absolutely no problem
> working after hotunplug.
> 
> Also, doing this defeats the point since it pretty much guarantees
> userspace will die in assert()s and stuff. E.g. on i915 the rough contract
> is that only execbuf (and even that only when userspace has indicated
> support for non-recoverable hw ctx) is allowed to fail. Anything else
> might crash userspace.
> 
> You probably need similar (and very precisely defined) rules for amdgpu.
> And those must definitely exclude any shard ioctls from randomly failing
> with EIO, because that just kills the box and defeats the point of trying
> to gracefully handling hotunplug and making sure userspace has a chance of
> survival. E.g. for atomic everything should continue, including flip
> completion, but we set all outputs to "disconnected" and send out the
> uevent. Maybe crtc enabling can fail too, but that can also be handled
> through the async status we're using to signal DP link failures to
> userspace.
> 
> I guess we should clarify this in the hotunplug doc?

To clarify: I'm not against throwing an ENODEV at userspace for ioctl that
really make no sense, and where we're rather confident that all properly
implemented userspace will gracefully handle failures. Like a modeset, or
opening a device, or trying to import a dma-buf or stuff like that which
can already fail in normal operation for any kind of reason.

But stuff that never fails, like GETRESOURCES ioctl, really shouldn't fail
after hotunplug.

And then there's the middle ground, like doing a pageflip or buffer flush,
which I guess some userspace might handle, but risky to inflict those
consequences on them. atomic modeset is especially fun since depending
what you're doing it can be both "failures expected" and "failures not
really expected in normal operation".

Also, this really should be consistent across drivers, not solved with a
driver flag for every possible combination.

If you look at the current hotunplug kms drivers, they have
drm_dev_enter/exit sprinkled in specific hw callback functions because of
the above problems. But maybe it makes sense to change things in a few
cases. But then we should do it across the board.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
