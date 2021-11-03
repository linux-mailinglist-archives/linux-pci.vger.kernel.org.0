Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E014444D5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 16:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhKCPqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 11:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbhKCPqx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 11:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635954256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZiz8bgd2IYdJNUZ4cuGa9YeyGcuozlOPlontcI7tiE=;
        b=R3iq5mWrFGuLscA8cNtxtOcaMOc8vFL/u7+SPpiTRXQXVglZAxPYn3KmhUSSYVkLo0CqS+
        nsopB6PiCT5KN6FunzmDNM2cpSx9iyBHxHgFIrLq88VLSPNKSZYIsUyRdh2Ymyv4L16f3c
        hdInfC+0WEFufJfCe/lLcdyLWCvsk98=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-srYBBZihOL-FmhDTkfX6mA-1; Wed, 03 Nov 2021 11:44:13 -0400
X-MC-Unique: srYBBZihOL-FmhDTkfX6mA-1
Received: by mail-ot1-f72.google.com with SMTP id 61-20020a9d02c3000000b00553c97d94abso1634530otl.9
        for <linux-pci@vger.kernel.org>; Wed, 03 Nov 2021 08:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tZiz8bgd2IYdJNUZ4cuGa9YeyGcuozlOPlontcI7tiE=;
        b=6CQnbD3UhXvtTOwfevqHlipiAG+aTX1i5tUk7bnSGQNQZMrZ/mOCutdOWt33mkGz21
         2BORx2nYnoXACmNwdG3aJ5f1X9wWvNFNCkPvPo74X9vc3AIcAj+1+ndVtPLQbEP1Z0F2
         OmzPuclYlk8pR9o/XNa1a1Srp1ZjMVN33fB3x9HvGUmnaP817E47RzCECFCdB+VhKZ9a
         9kyvBC/IoxioXGY7gCme3ULIJ4UydtDFqIvd7hfPkiB3ZQtxMiD8frPqEkNlGrzH3gTE
         VZ3DH3Y8Uaf5o7UBZ1VuYBieKRj/EATcM5BAWBWHxQE45OZGIZxvUCe85bkYE11RQzdi
         21Bg==
X-Gm-Message-State: AOAM531ocLyX4nQi70ri0+ei3+XJrbwhPGuH76aq1Q/++frGr8vHvRev
        +DSdRbGArubITSmqpOKkB37nc17q8LXWFnNake7tTZI8jDIiXGo2upQsgiCskndv2wfB2E7K2ip
        LVvowwyYIyrK0tYnYAMXE
X-Received: by 2002:a05:6808:11c6:: with SMTP id p6mr11357427oiv.158.1635954252498;
        Wed, 03 Nov 2021 08:44:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqdNIwBbBjQaA0dktrX5jxvW3JQ5HKlh4yDvBgx+shkcepd/rNrVD0/YfjSkdaBx5uxUfMqQ==
X-Received: by 2002:a05:6808:11c6:: with SMTP id p6mr11357391oiv.158.1635954252228;
        Wed, 03 Nov 2021 08:44:12 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r13sm583837oot.41.2021.11.03.08.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:44:11 -0700 (PDT)
Date:   Wed, 3 Nov 2021 09:44:09 -0600
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
Message-ID: <20211103094409.3ea180ab.alex.williamson@redhat.com>
In-Reply-To: <20211103120955.GK2744544@nvidia.com>
References: <20211027192345.GJ2744544@nvidia.com>
        <20211028093035.17ecbc5d.alex.williamson@redhat.com>
        <20211028234750.GP2744544@nvidia.com>
        <20211029160621.46ca7b54.alex.williamson@redhat.com>
        <20211101172506.GC2744544@nvidia.com>
        <20211102085651.28e0203c.alex.williamson@redhat.com>
        <20211102155420.GK2744544@nvidia.com>
        <20211102102236.711dc6b5.alex.williamson@redhat.com>
        <20211102163610.GG2744544@nvidia.com>
        <20211102141547.6f1b0bb3.alex.williamson@redhat.com>
        <20211103120955.GK2744544@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 3 Nov 2021 09:09:55 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Nov 02, 2021 at 02:15:47PM -0600, Alex Williamson wrote:
> > On Tue, 2 Nov 2021 13:36:10 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Tue, Nov 02, 2021 at 10:22:36AM -0600, Alex Williamson wrote:
> > >   
> > > > > > There's no point at which we can do SET_IRQS other than in the
> > > > > > _RESUMING state.  Generally SET_IRQS ioctls are coordinated with the
> > > > > > guest driver based on actions to the device, we can't be mucking
> > > > > > with IRQs while the device is presumed running and already
> > > > > > generating interrupt conditions.      
> > > > > 
> > > > > We need to do it in state 000
> > > > > 
> > > > > ie resume should go 
> > > > > 
> > > > >   000 -> 100 -> 000 -> 001
> > > > > 
> > > > > With SET_IRQS and any other fixing done during the 2nd 000, after the
> > > > > migration data has been loaded into the device.    
> > > > 
> > > > Again, this is not how QEMU works today.    
> > > 
> > > I know, I think it is a poor choice to carve out certain changes to
> > > the device that must be preserved across loading the migration state.
> > >   
> > > > > The uAPI comment does not define when to do the SET_IRQS, it seems
> > > > > this has been missed.
> > > > > 
> > > > > We really should fix it, unless you feel strongly that the
> > > > > experimental API in qemu shouldn't be changed.    
> > > > 
> > > > I think the QEMU implementation fills in some details of how the uAPI
> > > > is expected to work.    
> > > 
> > > Well, we already know QEMU has problems, like the P2P thing. Is this a
> > > bug, or a preferred limitation as designed?
> > >   
> > > > MSI/X is expected to be restored while _RESUMING based on the
> > > > config space of the device, there is no intermediate step between
> > > > _RESUMING and _RUNNING.  Introducing such a requirement precludes
> > > > the option of a post-copy implementation of (_RESUMING | _RUNNING).    
> > > 
> > > Not precluded, a new state bit would be required to implement some
> > > future post-copy.
> > > 
> > > 0000 -> 1100 -> 1000 -> 1001 -> 0001
> > > 
> > > Instead of overloading the meaning of RUNNING.
> > > 
> > > I think this is cleaner anyhow.
> > > 
> > > (though I don't know how we'd structure the save side to get two
> > > bitstreams)  
> > 
> > The way this is supposed to work is that the device migration stream
> > contains the device internal state.  QEMU is then responsible for
> > restoring the external state of the device, including the DMA mappings,
> > interrupts, and config space.  It's not possible for the migration
> > driver to reestablish these things.  So there is a necessary division
> > of device state between QEMU and the migration driver.
> > 
> > If we don't think the uAPI includes the necessary states, doesn't
> > sufficiently define the states, and we're not following the existing
> > QEMU implementation as the guide for the intentions of the uAPI spec,
> > then what exactly is the proposed mlx5 migration driver implementing
> > and why would we even considering including it at this point?  Thanks,  
> 
> The driver posting follows the undocumented behaviors of QEMU

In one email I read that QEMU clearly should not be performing SET_IRQS
while the device is _RESUMING (which it does) and we need to require an
interim state before the device becomes _RUNNING to poke at the device
(which QEMU doesn't do and the uAPI doesn't require), and the next I
read that we should proceed with some useful quanta of work despite
that we clearly don't intend to retain much of the protocol of the
current uAPI long term...

> You asked that these all be documented, evaluated and formalized as a
> precondition to merging it.
> 
> So, what do you want? A critical review of the uAPI design or
> documenting whatever behvaior is coded in qemu?

Too much is in flux and we're only getting breadcrumbs of the changes
to come.  It's becoming more evident that we're likely to sufficiently
modify the uAPI to the point where I'd probably suggest a new "v2"
subtype for the region.

> A critical review suggest SET_IRQ should not happen during RESUMING,
> but mlx5 today doesn't care either way.

But if it can't happening during _RESUMING and once the device is
_RUNNING it's too late, then we're demanding an interim state that is
not required by the existing protocol.  We're redefining that existing
operations on the device while in _RESUMING cannot occur in that device
state.  That's more than uAPI clarification.  Thanks,

Alex

