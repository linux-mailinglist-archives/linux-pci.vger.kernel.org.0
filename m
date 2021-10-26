Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500AC43BB3C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhJZTxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 15:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239047AbhJZTxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 15:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635277853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6YsqIJF4cmqUM5VoIFLtZ3R3oEYuHT98TJT5vDKLv0=;
        b=VmFMPltyE2xIpZWjagtuPiJatv7Te7kIAvbaPiRZ0YPra7xqRfJ4N1UKWNimTR6tL0WHqb
        XJ25+CQeIimYTcwiFHvXGKgNxHrmCF49kyEu6/J661m0TFq7Bx6TRO/WmFgXhZ0ixII9jO
        q5NgSkWA1ybOAKm3lZlpXPZbz6CF5Dg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-MNOxruPAOvCrTqQuckMNmA-1; Tue, 26 Oct 2021 15:50:49 -0400
X-MC-Unique: MNOxruPAOvCrTqQuckMNmA-1
Received: by mail-oo1-f71.google.com with SMTP id e3-20020a4ada03000000b002b85240388dso166217oou.8
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 12:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6YsqIJF4cmqUM5VoIFLtZ3R3oEYuHT98TJT5vDKLv0=;
        b=l11HZn0Md2YbeJ8sIyo+a3DigBlsphVeeKk2Y+1WeIP3HnkJMiDtUVWXjS36YlGfeF
         vcThp128U5DOj7K36xenAfhnIo621V21hKOgqBpgW7D1iCdHN/tMYZjKp/hxYDwvualk
         LxU9ZGssVYzS1DTorCWKvheb8QgSnq6j7MlZRc08zjUJm0/x/zOPHbSqAbMN6UgEOyXe
         3/2Id0S3aUL8eHXYNphnrgmguo6IiFMyPA6rkURQ0ScicW58kG2tUzPMGN3Enz3N5PcM
         qrnbZBI7qL6kPMq+kSZ3rxzLcjH2f046p9rKuladxsYKHtD1p+Yqg+WnEAmQQPs68RO/
         m7MQ==
X-Gm-Message-State: AOAM530dPuKN2jklKKfkY3+EiMNwMQ+K3BQbhHUV9AMFEwOvsuy1BEkB
        CBCI9kMpouLVlEzz7kiJ4DPduRYIvqE4MMjUX7gsK5PQbHI5emvlQSFY0yumV4tOTkJkgdGApU7
        YIzSpiuVyfJ6lbVeLsFQZ
X-Received: by 2002:a05:6830:2b11:: with SMTP id l17mr21915527otv.298.1635277848322;
        Tue, 26 Oct 2021 12:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP54OPC5IwSQShzWiwXn/t8EIhJAPy/ttWlrC47tIMalPERR7bNfkUdrFXsvQn1ejkueIxKw==
X-Received: by 2002:a05:6830:2b11:: with SMTP id l17mr21915507otv.298.1635277848077;
        Tue, 26 Oct 2021 12:50:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m7sm5109762oiw.49.2021.10.26.12.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:50:47 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:50:46 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH V2 mlx5-next 12/14] vfio/mlx5: Implement vfio_pci driver
 for mlx5 devices
Message-ID: <20211026135046.5190e103.alex.williamson@redhat.com>
In-Reply-To: <20211026151851.GW2744544@nvidia.com>
References: <5a496713-ae1d-11f2-1260-e4c1956e1eda@nvidia.com>
        <20211020105230.524e2149.alex.williamson@redhat.com>
        <20211020185919.GH2744544@nvidia.com>
        <20211020150709.7cff2066.alex.williamson@redhat.com>
        <87o87isovr.fsf@redhat.com>
        <20211021154729.0e166e67.alex.williamson@redhat.com>
        <20211025122938.GR2744544@nvidia.com>
        <20211025082857.4baa4794.alex.williamson@redhat.com>
        <20211025145646.GX2744544@nvidia.com>
        <20211026084212.36b0142c.alex.williamson@redhat.com>
        <20211026151851.GW2744544@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Oct 2021 12:18:51 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Oct 26, 2021 at 08:42:12AM -0600, Alex Williamson wrote:
> 
> > > This is also why I don't like it being so transparent as it is
> > > something userspace needs to care about - especially if the HW cannot
> > > support such a thing, if we intend to allow that.  
> > 
> > Userspace does need to care, but userspace's concern over this should
> > not be able to compromise the platform and therefore making VF
> > assignment more susceptible to fatal error conditions to comply with a
> > migration uAPI is troublesome for me.  
> 
> It is an interesting scenario.
> 
> I think it points that we are not implementing this fully properly.
> 
> The !RUNNING state should be like your reset efforts.
> 
> All access to the MMIO memories from userspace should be revoked
> during !RUNNING
> 
> All VMAs zap'd.
> 
> All IOMMU peer mappings invalidated.
> 
> The kernel should directly block userspace from causing a MMIO TLP
> before the device driver goes to !RUNNING.
> 
> Then the question of what the device does at this edge is not
> relevant as hostile userspace cannot trigger it.
> 
> The logical way to implement this is to key off running and
> block/unblock MMIO access when !RUNNING.
> 
> To me this strongly suggests that the extra bit is the correct way
> forward as the driver is much simpler to implement and understand if
> RUNNING directly controls the availability of MMIO instead of having
> an irregular case where !RUNNING still allows MMIO but only until a
> pending_bytes read.
> 
> Given the complexity of this can we move ahead with the current
> mlx5_vfio and Yishai&co can come with some followup proposal to split
> the freeze/queice and block MMIO?

I know how much we want this driver in, but I'm surprised that you're
advocating to cut-and-run with an implementation where we've identified
a potentially significant gap with some hand waving that we'll resolve
it later.

Deciding at some point in the future to forcefully block device MMIO
access from userspace when the device stops running is clearly a user
visible change and therefore subject to the don't-break-userspace
clause.  It also seems to presume that the device relies on the
vfio-core to block device access, whereas device implementations may
not require such if they're able to snapshot device state.  That might
also indicate that "freeze" is only an implementation specific
requirement.  Thanks,

Alex

