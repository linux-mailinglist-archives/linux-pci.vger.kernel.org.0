Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E57843AE3F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhJZInM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 04:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234304AbhJZInF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 04:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635237640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xfjmzkgFWA1L7jlAQ35kT9YQRKqeL4m1Zaudd45fWoU=;
        b=ShYDxjJoAL0zHPJIsgxBqRRUU9KBSnaUelwjo5igSvjC7u1vGPTA839Mf0Vj0QuuuArrxM
        nEbeLlWQylYMhCRW/NyQ7apSZnEVC+ME225nnTa3G/u4PJ/nqIU3XfEaD710RxJmOoalnF
        HI42iDZ0vgaf19jm+LozJvu7GXwLB98=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-4D7NVjZMNYS_sLvSWAevdQ-1; Tue, 26 Oct 2021 04:40:38 -0400
X-MC-Unique: 4D7NVjZMNYS_sLvSWAevdQ-1
Received: by mail-wr1-f72.google.com with SMTP id g15-20020a5d64ef000000b0016a1331535eso1026121wri.10
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 01:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfjmzkgFWA1L7jlAQ35kT9YQRKqeL4m1Zaudd45fWoU=;
        b=bZZBsDe/oh7ySHpq1dzB4fhMFVNWv274Rd+jGgNHZLhCovC7HblwsdqWub5CMhhR45
         j94TDhUCSX4leibYhaDSoCP0a+nwxBc9xdVQ4W/iDaWP5ebkN33IGzwZH0FIMUiIx4c3
         wj9B0mJNScFLs2cljGp3Tg3odg9Xg6WvHPsa12zzfj9qhIahnVJXecuYovFB5SoYtXEa
         kjBTxxDWLb4axwg2OejVXv8wF33Y9eocmkp/PB+HhI2l4B/kCXiUueExqB2CAtooQpm9
         /3y+XyBrLLhkc8K97jWhweql2y6LGeKQBqYT8zLrfVkdO8XY80bHKJ+7I2yY/+ZhzWmm
         RUeg==
X-Gm-Message-State: AOAM530wxQG0PS2UxF8ueD+FOqQmH1LY+YacaRbSqSvE7Yt3D9Bkb12P
        sklNZPqtbQpTp4wxaxNj36UJYrh7WQyviTHM/xEXLpcBPB+irf/zEM8v1JYYEs77l/ZWFbwXBhW
        iSifGTEU01XcwF0Iot7Xw
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr17547135wrz.54.1635237637570;
        Tue, 26 Oct 2021 01:40:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5GdEzMaju+58GxCQgRDsiOrRrD/jJb7jUfrLgVL9mXDAbPVNJiHhiKtV/0v4Tq6aEaUO8Rg==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr17547112wrz.54.1635237637425;
        Tue, 26 Oct 2021 01:40:37 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id d1sm18850117wrr.72.2021.10.26.01.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 01:40:36 -0700 (PDT)
Date:   Tue, 26 Oct 2021 09:40:34 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V2 mlx5-next 12/14] vfio/mlx5: Implement vfio_pci driver
 for mlx5 devices
Message-ID: <YXe/AvwQcAxJ/hXQ@work-vm>
References: <20211019124352.74c3b6ba.alex.williamson@redhat.com>
 <20211019192328.GZ2744544@nvidia.com>
 <20211019145856.2fa7f7c8.alex.williamson@redhat.com>
 <20211019230431.GA2744544@nvidia.com>
 <5a496713-ae1d-11f2-1260-e4c1956e1eda@nvidia.com>
 <20211020105230.524e2149.alex.williamson@redhat.com>
 <YXbceaVo0q6hOesg@work-vm>
 <20211025115535.49978053.alex.williamson@redhat.com>
 <YXb7wejD1qckNrhC@work-vm>
 <20211025191509.GB2744544@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025191509.GB2744544@nvidia.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* Jason Gunthorpe (jgg@nvidia.com) wrote:
> On Mon, Oct 25, 2021 at 07:47:29PM +0100, Dr. David Alan Gilbert wrote:
> 
> > It may need some further refinement; for example in that quiesed state
> > do counters still tick? will a NIC still respond to packets that don't
> > get forwarded to the host?
> 
> At least for the mlx5 NIC the two states are 'able to issue outbound
> DMA' and 'all internal memories and state are frozen and unchanging'.

Yeh, so my point was just that if you're adding a new state to this
process, you need to define the details like that.

Dave

> The later means it should not respond/count/etc to network packets
> either.
> 
> Roughly it is
>  'able to mutate external state' / 'able to mutate internal state'
> 
> The invariant should be that successive calls to serialize the
> internal state while frozen should return the same serialization.
> 
> We may find that migratable PCI functions must have some limited
> functionality. Ie anything with a realtime compoment - for instance a
> sync-ethernet clock synchronization control loop, may become
> challenging to migrate without creating a serious functional
> distortion.
> 
> Jason
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

