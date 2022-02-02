Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087834A7BCC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 00:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiBBXhC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 18:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240544AbiBBXhB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 18:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643845021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Myt2UuUCiXyRDsU5d06lDAE5LKcz4J1lOiDKKvfEUQ=;
        b=d8Z2PQ8lo1qpKTZnJ2czbEhhPvEG119HNp42EHwUdJUPsl7crj3isLDLMOuDwuTJie4lO1
        p12RqMu6Qit4zm+ves20/BzeWhHD0WQalFVS2UqyMyB5a91m0wywwT/yyK2rUi04DzsOhC
        jVwyO67U8B2W2uw7NDH1RZjC/R+zuZQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-Y5Z9W23POhG4pyl1xBw3jg-1; Wed, 02 Feb 2022 18:37:00 -0500
X-MC-Unique: Y5Z9W23POhG4pyl1xBw3jg-1
Received: by mail-oi1-f198.google.com with SMTP id bq20-20020a05680823d400b002cf93c09f23so447674oib.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Feb 2022 15:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Myt2UuUCiXyRDsU5d06lDAE5LKcz4J1lOiDKKvfEUQ=;
        b=zeNj0H5gskcyfvL/ZxWIHSVN9CMYOCmDu9xJP9CdrWeUG8VRDeNju8Vfc9ddMltFRN
         ZVBMUyhxkmhIwBrho3qsXynJsT3WHMEcdb3U+E6M63jOEZunRILFWmO98kmExN6ILmy/
         cvc/qordeYqKavx8yMQMir86IMHaOkeoICZtdrnpuPLTJVu7yb/FPMQNG17kDPcjeTm8
         lF7ewztPbF4T4sMIRCCIqNWEJ7GixjjOHp1hau0RKl8fESPa1ErUY47OBVOcts1jJMaZ
         W9VZdZrNCNHeJ4mPB716HaYLV9JJ2Owfa8Eq6nRMbn5RZUlLu/vZFZhPNaLNPqLHZfnM
         Y7sw==
X-Gm-Message-State: AOAM533p+1sGclwOikZwIvxOU/1w0c9ENb2hUhgovNQqi+6ziG81QB2v
        zFVF2gFmxAq9uiLq6LKmgTklmj5cSprITkuZ67586nfM1vM6RoeJuffoJUy/oLQGdq3+rMyy6rx
        Y6lFjdpZWw3+gXQJuIcdh
X-Received: by 2002:a05:6808:1414:: with SMTP id w20mr6042624oiv.7.1643845019300;
        Wed, 02 Feb 2022 15:36:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQv4HvvB0UNAIDsNvwJn4kAWviB8Gtiws57m3WKKCECSGGUjz8ATPDGn91pJCdxqCkUIUk+g==
X-Received: by 2002:a05:6808:1414:: with SMTP id w20mr6042609oiv.7.1643845019004;
        Wed, 02 Feb 2022 15:36:59 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d65sm13247013otb.17.2022.02.02.15.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:36:58 -0800 (PST)
Date:   Wed, 2 Feb 2022 16:36:56 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V6 mlx5-next 08/15] vfio: Define device migration
 protocol v2
Message-ID: <20220202163656.4c0cc386.alex.williamson@redhat.com>
In-Reply-To: <20220202002459.GP1786498@nvidia.com>
References: <20220130160826.32449-1-yishaih@nvidia.com>
        <20220130160826.32449-9-yishaih@nvidia.com>
        <20220131164318.3da9eae5.alex.williamson@redhat.com>
        <20220201003124.GZ1786498@nvidia.com>
        <20220201100408.4a68df09.alex.williamson@redhat.com>
        <20220201183620.GL1786498@nvidia.com>
        <20220201144916.14f75ca5.alex.williamson@redhat.com>
        <20220202002459.GP1786498@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 20:24:59 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 01, 2022 at 02:49:16PM -0700, Alex Williamson wrote:
> > On Tue, 1 Feb 2022 14:36:20 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Tue, Feb 01, 2022 at 10:04:08AM -0700, Alex Williamson wrote:
> > >   
> > > > Ok, let me parrot back to see if I understand.  -ENOTTY will be
> > > > returned if the ioctl doesn't exist, in which case device_state is
> > > > untouched and cannot be trusted.  At the same time, we expect the user
> > > > to use the feature ioctl to make sure the ioctl exists, so it would
> > > > seem that we've reclaimed that errno if we believe the user should
> > > > follow the protocol.    
> > > 
> > > I don't follow - the documentation says what the code does, if you get
> > > ENOTTY returned then you don't get the device_state too. Saying the
> > > user shouldn't have called it in the first place is completely
> > > correct, but doesn't change the device_state output.  
> > 
> > The documentation says "...the device state output is not reliable", and
> > I have to question whether this qualifies as a well specified,
> > interoperable spec with such language.  We're essentially asking users
> > to keep track that certain errnos result in certain fields of the
> > structure _maybe_ being invalid.  
> 
> So you are asking to remove "is not reliable" and just phrase is as:
> 
> "device_state is updated to the current value when -1 is returned,
> except when these XXX errnos are returned?
> 
> (actually userspace can tell directly without checking the errno - as
> if -1 is returned the device_state cannot be the requested target
> state anyhow)

If we decide to keep the existing code, then yes the spec should
indicate the device_state is invalid, not just unreliable for those
errnos, but I'm also of the opinion that returning an error condition
AND providing valid data in the return structure for all but a few
errnos and expecting userspace to get this correct is not a good API.
 
> > Now you're making me wonder how much I care to invest in semantic
> > arguments over extended errnos :-\  
> 
> Well, I know I don't :) We don't have consistency in the kernel and
> userspace is hard pressed to make any sense of it most of the time,
> IMHO. It just doesn't practically matter..
> 
> > > We don't know the device_state in the core code because it can only be
> > > read under locking that is controlled by the driver. I hope when we
> > > get another driver merged that we can hoist the locking, but right now
> > > I'm not really sure - it is a complicated lock.  
> > 
> > The device cannot self transition to a new state, so if the core were
> > to serialize this ioctl then the device_state provided by the driver is
> > valid, regardless of its internal locking.  
> 
> It is allowed to transition to RUNNING due to reset events it captures
> and since we capture the reset through the PCI hook, not from VFIO,
> the core code doesn't synchronize well. See patch 14

Looking... your .reset_done() function sets a deferred_reset flag and
attempts to grab the state_mutex.  If there's contention on that mutex,
exit since the lock holder will perform the state transition when
dropping that mutex, otherwise reset_done will itself drop the mutex to
do that state change.  The reset_lock assures that we cannot race as the
state_mutex is being released.

So the scenario is that the user MUST be performing a reset coincident
to accessing the device_state and the solution is that the user's
SET_STATE returns success and a new device state that's already bogus
due to the reset.  Why wouldn't the solution here be to return -EAGAIN
to the user or reattempt the SET_STATE since the user is clearly now
disconnected from the actual device_state?

> > Whether this ioctl should be serialized anyway is probably another good
> > topic to breach.  Should a user be able to have concurrent ioctls
> > setting conflicting states?  
> 
> The driver is required to serialize, the core code doesn't touch any
> global state and doesn't need serializing.
> 
> > I'd suggest that ioctl return structure is only valid at all on
> > success and we add a GET interface to return the current device  
> 
> We can do this too, but it is a bunch of code to achieve this and I
> don't have any use case to read back the device_state beyond debugging
> and debugging is fine with this. IMHO

A bunch of code?  If we use a FEATURE ioctl, it just extends the
existing implementation to add GET support.  That looks rather trivial.
That seems like a selling point for using the FEATURE ioctl TBH.
 
> > It's entirely possible that I'm overly averse to ioctl proliferation,
> > but for every new ioctl we need to take a critical look at the proposed
> > API, use case, applicability, and extensibility.    
> 
> This is all basicly the same no matter where it is put, the feature
> multiplexer is just an ioctl in some semi-standard format, but the
> vfio pattern of argsz/flags is also a standard format that is
> basically the same thing.
> 
> We still need to think about extensibility, alignment, etc..
> 
> The problem I usually see with ioctls is not proliferation, but ending
> up with too many choices and a big ?? when it comes to adding
> something new.
> 
> Clear rules where things should go and why is the best, it matters
> less what the rules actually are IMHO.
> 
> > > I don't want to touch capabilities, but we can try to use feature for
> > > set state. Please confirm this is what you want.  
> > 
> > It's a team sport, but to me it seems like it fits well both in my
> > mental model of interacting with a device feature, without
> > significantly altering the uAPI you're defining anyway.  
> 
> Well, my advice is that ioctls are fine, and a bit easier all around.
> eg strace and syzkaller are a bit easier if everything neatly maps
> into one struct per ioctl - their generator tools are optimized for
> this common case.
> 
> Simple multiplexors are next-best-fine, but there should be a clear
> idea when to use the multiplexer, or not.
> 
> Things like the cap chains enter a whole world of adventure for
> strace/syzkaller :)

vfio's argsz/flags is not only a standard framework, but it's one that
promotes extensions.  We were able to add capability chains with
backwards compatibility because of this design.  IMO, that's avoided
ioctl sprawl; we've been able to maintain a fairly small set of core
ioctls rather than add add a new ioctl every time we want to describe
some new property of a device or region or IOMMU.  I think that
improves the usability of the uAPI.  I certainly wouldn't want to
program to a uAPI with a million ioctls.  A counter argument is that
we're making the interface more complex, but at the same time we're
adding shared infrastructure for dealing with that complexity.

Of course we do continue to add new ioctls as necessary, including this
FEATURE ioctl, and I recognize that with such a generic multiplexer we
run the risk of over using it, ie. everything looks like a nail.  You
initially did not see the fit for setting device state as interacting
with a device feature, but it doesn't seem like you had a strong
objection to my explanation of it in that context.

So I think if the FEATURE ioctl has an ongoing place in our uAPI (using
it to expose migration flags would seem to be a point in that
direction) and it doesn't require too many contortions to think of the
operation we're trying to perform on the device as interacting with a
device FEATURE, and there are no functional or performance implications
of it, I would think we should use it.  To do otherwise would suggest
that we should consider the FEATURE ioctl a failed experiment and not
continue to expand its use.

I'd be interested to hear more input on this from the community.
 
> > > You'll want the same for the PRE_COPY related information too?  
> > 
> > I hadn't gotten there yet.  It seems like a discontinuity to me that
> > we're handing out new FDs for data transfer sessions, but then we
> > require the user to come back to the device to query about the data its
> > reading through that other FD.    
> 
> An earlier draft of this put it on the data FD, but v6 made it fully
> optional with no functional impact on the data FD. The values decrease
> as the data FD progresses and increases as the VM dirties data - ie it
> is 50/50 data_fd/device behavior.
> 
> It doesn't matter which way, but it feels quite weird to have the main
> state function is a FEATURE and the precopy query is an ioctl.

If the main state function were a FEATURE ioctl on the device and the
data transfer query was an ioctl on the FD returned from that feature
ioctl, I don't see how that's weird at all.  Different FDs, different
interfaces.

To me, the device has provided a separate FD for data transfer, so the
fact that we consume the data via that FD, but monitor our progress in
consuming that data back on the device FD is a bit strange.
 
> > Should that be an ioctl on the data stream FD itself?    
> 
> I can be. Implementation wise it is about a wash.
> 
> > Is there a use case for also having it on the STOP_COPY FD?  
> 
> I didn't think of one worthwhile enough to mandate implementing it in
> every driver.

Can the user perform an lseek(2) on the migration FD?  Maybe that would
be the difference between what we need for PRE_COPY vs STOP_COPY.  In
the latter case the data should be a fixes size and perhaps we don't
need another interface to know how much data to expect.

One use case would be that we want to be able to detect whether we can
meet service guarantees as quickly as possible with the minimum
resource consumption and downtime.  If we can determine from the device
that we can't possibly transfer its state in the required time, we can
abort immediately without waiting for a downtime exception or flooding
the migration link.  Thanks,

Alex

