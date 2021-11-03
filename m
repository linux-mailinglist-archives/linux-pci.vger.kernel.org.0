Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93A4447DD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhKCSGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhKCSGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635962655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErzL4VuHaD4f7PaUIMhaeJLVvgQwTuoWvGf4q52DOQU=;
        b=KOVe5iEywj3ZoNVQD5PJUXWbT4eUapvP3tQCOIPNexTPIwVYgBFyekIqrvdg3y+yHDvsYv
        5ZHVBmKXuQ33DsIGhNuefbPBw+FFNyxyQn2P0zC/+lILq108PjWA6DKL5PEdTD+yMF0H2k
        22V677mvzVM2r3SjQpAHHABlBvFPfEA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-XOQCLJpxNq-Sgp4iwCgaRQ-1; Wed, 03 Nov 2021 14:04:14 -0400
X-MC-Unique: XOQCLJpxNq-Sgp4iwCgaRQ-1
Received: by mail-oi1-f200.google.com with SMTP id k124-20020acaba82000000b002a7401b177cso1938606oif.8
        for <linux-pci@vger.kernel.org>; Wed, 03 Nov 2021 11:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ErzL4VuHaD4f7PaUIMhaeJLVvgQwTuoWvGf4q52DOQU=;
        b=PMHfxbiGTdBl0qCd6qsZL0BMsZ4GJFhDL1aQ+EbxNlYiHgkfK9ehgPkhLtU59PY/RF
         QoeZdp19djXU9QnnRZP+8zhBHp25/vhn8Rk6ugt7hnJ1XANQUsnynEMfocimATGwkfQ+
         ++3szU4j+o00TC8gPbZUly/1DIv/1nAStENjxV4wD2xLXekaWifqeGX6kUxLFmTtov3M
         FQBhtvgERTyZpj0qyTKOo8VFdiW7I8uxp2Kz9DTUBFp1nnHEjvZSS5TuhzKHbyHL5sUm
         tXrwPjsd76dUMH1e81BXERiZdoed7sj6XAyS81/2Om2b/KztdaviHVnwlDJ/ZPROh18U
         202g==
X-Gm-Message-State: AOAM531k/hj8GIkhtLkHH4DnNbqsoVbE6JwZVTYgpVOClphGcqnHSlXc
        Q62+mXFGHXEOmxl1kHwn0ct6B8EFXYmMZCDMaxYsyskT2r83Z3qzMAL06YkK3ENO6zPQqReI4Tw
        iL7xGTkGvLoy30tl//fdK
X-Received: by 2002:aca:3a06:: with SMTP id h6mr11821856oia.22.1635962653818;
        Wed, 03 Nov 2021 11:04:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMH2unmxL14Rka6aUDt8tPHbTQoAknsmdn15KQ74qkvHHD3LOwNuVSnf44YSHKyYZBOE8nTw==
X-Received: by 2002:aca:3a06:: with SMTP id h6mr11821823oia.22.1635962653506;
        Wed, 03 Nov 2021 11:04:13 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t12sm806805oiw.39.2021.11.03.11.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:04:13 -0700 (PDT)
Date:   Wed, 3 Nov 2021 12:04:11 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH V2 mlx5-next 12/14] vfio/mlx5: Implement vfio_pci driver
 for mlx5 devices
Message-ID: <20211103120411.3a470501.alex.williamson@redhat.com>
In-Reply-To: <20211103161019.GR2744544@nvidia.com>
References: <20211028234750.GP2744544@nvidia.com>
        <20211029160621.46ca7b54.alex.williamson@redhat.com>
        <20211101172506.GC2744544@nvidia.com>
        <20211102085651.28e0203c.alex.williamson@redhat.com>
        <20211102155420.GK2744544@nvidia.com>
        <20211102102236.711dc6b5.alex.williamson@redhat.com>
        <20211102163610.GG2744544@nvidia.com>
        <20211102141547.6f1b0bb3.alex.williamson@redhat.com>
        <20211103120955.GK2744544@nvidia.com>
        <20211103094409.3ea180ab.alex.williamson@redhat.com>
        <20211103161019.GR2744544@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 3 Nov 2021 13:10:19 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Nov 03, 2021 at 09:44:09AM -0600, Alex Williamson wrote:
> 
> > In one email I read that QEMU clearly should not be performing SET_IRQS
> > while the device is _RESUMING (which it does) and we need to require an
> > interim state before the device becomes _RUNNING to poke at the device
> > (which QEMU doesn't do and the uAPI doesn't require), and the next I
> > read that we should proceed with some useful quanta of work despite
> > that we clearly don't intend to retain much of the protocol of the
> > current uAPI long term...  
> 
> mlx5 implements the protocol as is today, in a way that is compatible
> with today's qemu. Qemu has various problems like the P2P issue we
> talked about, but it is something working.
> 
> If you want to do a full re-review of the protocol and make changes,
> then fine, let's do that, but everything should be on the table, and
> changing qemu shouldn't be a blocker.

I don't think changing QEMU is a blocker, but QEMU should be seen as
the closest thing we currently have to a reference user implementation
against the uAPI and therefore may define de facto behaviors that are
not sufficiently clear in the uAPI.  So if we see issues with the QEMU
implementation, that's a reflection on gaps and disagreements in the
uAPI itself.  If we think we need new device states and protocols to
handle the issues being raised, we need plans to incrementally add
those to the uAPI, otherwise we should halt and reevaluate the existing
uAPI for a full overhaul.

We agreed that it's easier to add a feature than a restriction in a
uAPI, so how do we resolve that some future device may require a new
state in order to apply the SET_IRQS configuration?  Existing userspace
would fail with such a device.

> In one email you are are saying we need to document and decide things
> as a pre-condition to move the driver forward, and then in the next
> email you say whatever qemu does is the specification, and can't
> change it.

I don't think I ever said we can't change it.  I'm being presented with
new information, new requirements, new protocols that existing QEMU
code does not follow.  We can change QEMU, but as I noted before we're
getting dangerously close to having a formal, non-experimental user
while we're poking holes in the uAPI and we need to consider how the
uAPI extends to fill those holes and remains backwards compatible to
the current implementation.

> Part of this messy discussion is my fault as I've been a little
> unclear in mixing my "community view" of how the protocol should be
> designed to maximize future HW support and then switching to topics
> that have direct relevance to mlx5 itself.

Better sooner than later to evaluate the limitations and compatibility
issues against what we think is reasonable hardware behavior with
respect to migration states and transitions.

> I want to see devices like hns be supportable and, from experience,
> I'm very skeptical about placing HW design restrictions into a
> uAPI. So I don't like those things.
> 
> However, mlx5's HW is robust and more functional than hns, and doesn't
> care which way things are decided.

Regardless, the issues are already out on the table.  We want migration
for mlx5, but we also want it to be as reasonably close to what we
think can support any device designed for this use case.  You seem to
have far more visibility into that than I do.

> > Too much is in flux and we're only getting breadcrumbs of the
> > changes to come.  
> 
> We have no intention to go in and change the uapi after merging beyond
> solving the P2P issue.

Then I'm confused where we're at with the notion that we shouldn't be
calling SET_IRQS while in the _RESUMING state.

> Since we now have confirmation that hns cannot do P2P I see no issue
> to keep the current design as the non-p2p baseline that hns will
> implement and the P2P upgrade should be designed separately.
> 
> > It's becoming more evident that we're likely to sufficiently modify
> > the uAPI to the point where I'd probably suggest a new "v2" subtype
> > for the region.  
> 
> I don't think this is evident. It is really your/community choice what
> to do in VFIO.
> 
> If vfio sticks with the uAPI "as is" then it places additional
> requirements on future HW designs.
> 
> If you want to relax these requirements before stabilizing the uAPI,
> then we need to make those changes now.
> 
> It is your decision. I don't know of any upcoming HW designs that have
> a problem with any of the choices.

If we're going to move forward with the existing uAPI, then we're going
to need to start factoring compatibility into our discussions of
missing states and protocols.  For example, requiring that the device
is "quiesced" when the _RUNNING bit is cleared and "frozen" when
pending_bytes is read has certain compatibility advantages versus
defining a new state bit.  Likewise, it might be fair to define that
userspace should not touch device MMIO during _RESUMING until after the
last bit of the device migration stream has been written, and then it's
free to touch MMIO before transitioning directly to the _RUNNING state.

IOW, we at least need to entertain methods to achieve the
clarifications were trying for within the existing uAPI rather than
toss out new device states and protocols at every turn for the sake of
API purity.  The rate at which we're proposing new states and required
transitions without a plan for the uAPI is not where I want to be for
adding the driver that could lock us in to a supported uAPI.  Thanks,

Alex

