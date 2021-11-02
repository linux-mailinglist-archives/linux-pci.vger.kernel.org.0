Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF044371F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 21:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKBUSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 16:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhKBUSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 16:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635884171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xrr7Nswb1zSUeN/enXyBsdfTuUeQZHbFjkSfA/cUnkk=;
        b=U//ID9oYTOTmiodekAxGBMaOW1W0lldKyB83+NB8bKdGD9PrhBEUki5AmLBS4QZX+0pFa4
        dsXER8WdekM34HPytBGMotuGWxMbwYhCqqHKzwpStN8yvrZCYhBMLvtTHfRfgWoe5KPkuy
        oPlk8OmGXC2oGnxXXE7IlZTY4+vXSZw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-XbHFdnioMoG3eiBrKC_Qew-1; Tue, 02 Nov 2021 16:15:50 -0400
X-MC-Unique: XbHFdnioMoG3eiBrKC_Qew-1
Received: by mail-oo1-f70.google.com with SMTP id i1-20020a4a9001000000b002a9c41e0eabso126086oog.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Nov 2021 13:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xrr7Nswb1zSUeN/enXyBsdfTuUeQZHbFjkSfA/cUnkk=;
        b=Z1zetJP3rH5p6AnkZyD9OiLqPsBIF7ecIbZ6Df9AXs+P6GNuT1aBiYOcg/aYnfQQAG
         9zXaP8faz9J5ucQ4Ga6lE5c1A5gQwrJWRiagzbmjM3DmsWM3450nl6JWuRWCGnHOT0d+
         /EKkSS9tcIX79A9Rzv1g99Hj5aPKDhFTumMtb6v0EXyffrRdgMj2AZ7VUAGJWEr8nGKd
         HoDUgIpGNzwcmgwQQqLKA/TD4TR/W3+uNXdQRyuYGH4GOoHe6I/mW70Z969wguVESIOz
         LcyNrKkqtrGE2yi9JPKP1UDHCEWsgTiG/00/RqjGAv48RM6jonIfhXdpqa+ZffJ+zgxC
         Ddmg==
X-Gm-Message-State: AOAM533vR8vff9JsZMDQdAZOIRZULqwP8LOGMkONs2InCQU2QGWBnRVG
        iFJsypVPxBibXMNnV1T9a5mpTZLwjSidXnLDx6WCqe7wb5C8qhfgIwR/kG5+T8bYd8doEsLU65H
        R9rYUHK5aoJ430NWzXvnF
X-Received: by 2002:aca:502:: with SMTP id 2mr6911484oif.121.1635884150177;
        Tue, 02 Nov 2021 13:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB1YIom/qnGCnU3mQ5wd7qinnolUIYz9BC2zuiV9Oo21uixIulObHuoTWjbBeBw4sEtvoYGg==
X-Received: by 2002:aca:502:: with SMTP id 2mr6911462oif.121.1635884149950;
        Tue, 02 Nov 2021 13:15:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m16sm1632822oiw.13.2021.11.02.13.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 13:15:49 -0700 (PDT)
Date:   Tue, 2 Nov 2021 14:15:47 -0600
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
Message-ID: <20211102141547.6f1b0bb3.alex.williamson@redhat.com>
In-Reply-To: <20211102163610.GG2744544@nvidia.com>
References: <20211026234300.GA2744544@nvidia.com>
        <20211027130520.33652a49.alex.williamson@redhat.com>
        <20211027192345.GJ2744544@nvidia.com>
        <20211028093035.17ecbc5d.alex.williamson@redhat.com>
        <20211028234750.GP2744544@nvidia.com>
        <20211029160621.46ca7b54.alex.williamson@redhat.com>
        <20211101172506.GC2744544@nvidia.com>
        <20211102085651.28e0203c.alex.williamson@redhat.com>
        <20211102155420.GK2744544@nvidia.com>
        <20211102102236.711dc6b5.alex.williamson@redhat.com>
        <20211102163610.GG2744544@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2 Nov 2021 13:36:10 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Nov 02, 2021 at 10:22:36AM -0600, Alex Williamson wrote:
> 
> > > > There's no point at which we can do SET_IRQS other than in the
> > > > _RESUMING state.  Generally SET_IRQS ioctls are coordinated with the
> > > > guest driver based on actions to the device, we can't be mucking
> > > > with IRQs while the device is presumed running and already
> > > > generating interrupt conditions.    
> > > 
> > > We need to do it in state 000
> > > 
> > > ie resume should go 
> > > 
> > >   000 -> 100 -> 000 -> 001
> > > 
> > > With SET_IRQS and any other fixing done during the 2nd 000, after the
> > > migration data has been loaded into the device.  
> > 
> > Again, this is not how QEMU works today.  
> 
> I know, I think it is a poor choice to carve out certain changes to
> the device that must be preserved across loading the migration state.
> 
> > > The uAPI comment does not define when to do the SET_IRQS, it seems
> > > this has been missed.
> > > 
> > > We really should fix it, unless you feel strongly that the
> > > experimental API in qemu shouldn't be changed.  
> > 
> > I think the QEMU implementation fills in some details of how the uAPI
> > is expected to work.  
> 
> Well, we already know QEMU has problems, like the P2P thing. Is this a
> bug, or a preferred limitation as designed?
> 
> > MSI/X is expected to be restored while _RESUMING based on the
> > config space of the device, there is no intermediate step between
> > _RESUMING and _RUNNING.  Introducing such a requirement precludes
> > the option of a post-copy implementation of (_RESUMING | _RUNNING).  
> 
> Not precluded, a new state bit would be required to implement some
> future post-copy.
> 
> 0000 -> 1100 -> 1000 -> 1001 -> 0001
> 
> Instead of overloading the meaning of RUNNING.
> 
> I think this is cleaner anyhow.
> 
> (though I don't know how we'd structure the save side to get two
> bitstreams)

The way this is supposed to work is that the device migration stream
contains the device internal state.  QEMU is then responsible for
restoring the external state of the device, including the DMA mappings,
interrupts, and config space.  It's not possible for the migration
driver to reestablish these things.  So there is a necessary division
of device state between QEMU and the migration driver.

If we don't think the uAPI includes the necessary states, doesn't
sufficiently define the states, and we're not following the existing
QEMU implementation as the guide for the intentions of the uAPI spec,
then what exactly is the proposed mlx5 migration driver implementing
and why would we even considering including it at this point?  Thanks,

Alex

