Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6E436D05
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 23:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJUVtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 17:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231440AbhJUVtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 17:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634852853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QX0K+ol2Lenj9SRy5tdw8mHtG1vzf/+KLfCSzAQPQCc=;
        b=AcvFoXQJVjlFGjiW574jVmhaXUJS4qJczPZICVIS0snRwyb4a3NX2VhcsRSskCYooRtfk1
        SsP4ntawcLyzzZnUQK4PZ2rJqWdXZyc+U3U60JOWsybbf6xaL0SeAahar1nTRAueqoJyR+
        g/mbX+4QGNCSyaIvU6Qn5D/XMcUW884=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Tq5sQR3IPR2d_kF1zBBwZg-1; Thu, 21 Oct 2021 17:47:31 -0400
X-MC-Unique: Tq5sQR3IPR2d_kF1zBBwZg-1
Received: by mail-ot1-f72.google.com with SMTP id b22-20020a056830311600b00552b48856bdso905683ots.6
        for <linux-pci@vger.kernel.org>; Thu, 21 Oct 2021 14:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QX0K+ol2Lenj9SRy5tdw8mHtG1vzf/+KLfCSzAQPQCc=;
        b=UsgO7wBhWPZMiN1kdK4p3jKZZqyujG7ZU3TJ3aPO/wEb+AcfLa2m4ahfft62QnHuuA
         knvpGl8nry6WpwAjxLqyijS9ty9gJKxU8BhEZiZk9q3CL7HmQuVvVy/csL53MG9CZEmv
         VioW4XP4ZCNQCGR9TIdK5TjhPxenuBQvME3PmIchAm9JQ9kdZQjX2E3P6PZYFIGba3zK
         R1wRTMi7ZCbCGfkc0GDgVS+zq8+V2f+htWArO4BOvawCCtW5snLPq3ek20tJX1tNo/Vw
         rg7FNB/gLQAOJ9XKZ6gpfySjCUxpZK1gY/QgXXswevJxvvG/ja99EjDJvv2PD5leYiaI
         /DxQ==
X-Gm-Message-State: AOAM531KchaiCjyeKpdL4xaGU3cGs1FCgvnj23s7XlRhWMpUtp043wqr
        LGvwYB5REG/7DBL7KkSbG0gYU1Qm9zgELrqANAHVvW0nwyEi+eymyMLaD+GpwQD89IRB37rzWu+
        DBf/lfAiMT4rhFLZ6caRr
X-Received: by 2002:a9d:4b95:: with SMTP id k21mr6844964otf.345.1634852851214;
        Thu, 21 Oct 2021 14:47:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGtR3NFRWaPJeO+7/DPajK4J4hqs651VUuk49wM4FBsssY4SSkK+siLHZJ+Vceo3C1DN8erg==
X-Received: by 2002:a9d:4b95:: with SMTP id k21mr6844926otf.345.1634852850828;
        Thu, 21 Oct 2021 14:47:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s18sm1307854otd.55.2021.10.21.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:47:30 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:47:29 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH V2 mlx5-next 12/14] vfio/mlx5: Implement vfio_pci driver
 for mlx5 devices
Message-ID: <20211021154729.0e166e67.alex.williamson@redhat.com>
In-Reply-To: <87o87isovr.fsf@redhat.com>
References: <20211019105838.227569-1-yishaih@nvidia.com>
        <20211019105838.227569-13-yishaih@nvidia.com>
        <20211019124352.74c3b6ba.alex.williamson@redhat.com>
        <20211019192328.GZ2744544@nvidia.com>
        <20211019145856.2fa7f7c8.alex.williamson@redhat.com>
        <20211019230431.GA2744544@nvidia.com>
        <5a496713-ae1d-11f2-1260-e4c1956e1eda@nvidia.com>
        <20211020105230.524e2149.alex.williamson@redhat.com>
        <20211020185919.GH2744544@nvidia.com>
        <20211020150709.7cff2066.alex.williamson@redhat.com>
        <87o87isovr.fsf@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 Oct 2021 11:34:00 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, Oct 20 2021, Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Wed, 20 Oct 2021 15:59:19 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  
> >> On Wed, Oct 20, 2021 at 10:52:30AM -0600, Alex Williamson wrote:
> >>   
> >> > I'm wondering if we're imposing extra requirements on the !_RUNNING
> >> > state that don't need to be there.  For example, if we can assume that
> >> > all devices within a userspace context are !_RUNNING before any of the
> >> > devices begin to retrieve final state, then clearing of the _RUNNING
> >> > bit becomes the device quiesce point and the beginning of reading
> >> > device data is the point at which the device state is frozen and
> >> > serialized.  No new states required and essentially works with a slight
> >> > rearrangement of the callbacks in this series.  Why can't we do that?    
> >> 
> >> It sounds worth checking carefully. I didn't come up with a major
> >> counter scenario.
> >> 
> >> We would need to specifically define which user action triggers the
> >> device to freeze and serialize. Reading pending_bytes I suppose?  
> >
> > The first read of pending_bytes after clearing the _RUNNING bit would
> > be the logical place to do this since that's what we define as the start
> > of the cycle for reading the device state.
> >
> > "Freezing" the device is a valid implementation, but I don't think it's
> > strictly required per the uAPI.  For instance there's no requirement
> > that pending_bytes is reduced by data_size on each iteratio; we
> > specifically only define that the state is complete when the user reads
> > a pending_bytes value of zero.  So a driver could restart the device
> > state if the device continues to change (though it's debatable whether
> > triggering an -errno on the next migration region access might be a
> > more supportable approach to enforce that userspace has quiesced
> > external access).  
> 
> Hm, not so sure. From my reading of the uAPI, transitioning from
> pre-copy to stop-and-copy (i.e. clearing _RUNNING) implies that we
> freeze the device (at least, that's how I interpret "On state transition
> from pre-copy to stop-and-copy, the driver must stop the device, save
> the device state and send it to the user application through the
> migration region.")

"[S]end it to the user application through the migration region" is
certainly not something that's encompassed just by clearing the _RUNNING
bit.  There's a sequence of operations there.  If the device is
quiesced for outbound DMA and frozen from inbound DMA (or can
reasonably expect no further inbound DMA) before the user reads the
data, I think that meets the description.

We can certainly clarify the spec in the process if we agree that we
can do this without adding another state bit.

I recall that we previously suggested a very strict interpretation of
clearing the _RUNNING bit, but again I'm questioning if that's a real
requirement or simply a nice-to-have feature for some undefined
debugging capability.  In raising the p2p DMA issue, we can see that a
hard stop independent of other devices is not really practical but I
also don't see that introducing a new state bit solves this problem any
more elegantly than proposed here.  Thanks,

Alex

