Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C5641CF5A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 00:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbhI2Wp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 18:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346393AbhI2Wp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 18:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632955453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDnZg0/6giW9XllEqIndueSNzorfdQE2gNriGLCrs+s=;
        b=PV7kY0JHbqRzJy5V0K5Y6wpr/SmJ8JQ6BKg+AaHZzxnKSNIyerDzyvf4JUWHX0FRRY2C9m
        XfFMQHEIiz8XOyOpexXqszNUETFKD9z0aktvP0z8HwVHlAW7vYD2Lu+D6vuOsyKlwzgfO/
        O0vHw6yfCNXELo9Pm5OpytuVaEPzzOE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-dFHSGzPxMQ6err-4re9tRQ-1; Wed, 29 Sep 2021 18:44:12 -0400
X-MC-Unique: dFHSGzPxMQ6err-4re9tRQ-1
Received: by mail-ot1-f71.google.com with SMTP id a19-20020a9d3e13000000b0054d67e67b64so2918346otd.22
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 15:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDnZg0/6giW9XllEqIndueSNzorfdQE2gNriGLCrs+s=;
        b=WiARVxHD0tztY4Ry6YwGWHOgYZfKJ4FiDgcxqft4pIfpTiceIAqoRTYr7UVZGXW+eE
         /nfJOzsi6C+NIwEI4oh4ooaZhEijy0LskgzANoAxjQ1PCTII8is0i5NvT8y8kfWWkU4n
         HcJpW4QyujiUnBsjsC7EFQGVj+gvAcuVlGdOQo8Wp6wyNW4lLtEJLxnqjp7rPTUbgUEx
         6EE8hsmgCLV64kxH3BWdTIOmewXvwS9C7foHJQPE9Ike863Xluf2jXCflaMNPeJqum2y
         J1oFVK8AwpnW4AzgeNYY5rb+EL7CubVBP8CnVPiCe8+xEkKbcr09W2MlEzfmXWHC0kMN
         Vkcg==
X-Gm-Message-State: AOAM533j1zfTr+TEidAvoRTPJAXT9FKliw9KgN2ASYn6mPOp1AdwvcoA
        6wFF7FviDziGaL2UJELQ86FefbSka5TEH/Xy2kZvY2Ah6SmIr+RDZ7X8XgsVvJlAMoOJ0Zg+j/4
        8F9n7J407EQUapBbOKk9t
X-Received: by 2002:a05:6808:1595:: with SMTP id t21mr78471oiw.98.1632955451621;
        Wed, 29 Sep 2021 15:44:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVU6jEU+ZG3AcZVTtnnVZT8dq+yX76s5pQMOm4ir4e1zUDW6chJsiIv463tHWR/ZUtQthMIQ==
X-Received: by 2002:a05:6808:1595:: with SMTP id t21mr78446oiw.98.1632955451416;
        Wed, 29 Sep 2021 15:44:11 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id d21sm229884ooh.43.2021.09.29.15.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:44:10 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:44:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210929164409.3c33e311.alex.williamson@redhat.com>
In-Reply-To: <29835bf4-d094-ae6d-1a32-08e65847b52c@nvidia.com>
References: <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
        <20210927164648.1e2d49ac.alex.williamson@redhat.com>
        <20210927231239.GE3544071@ziepe.ca>
        <25c97be6-eb4a-fdc8-3ac1-5628073f0214@nvidia.com>
        <20210929063551.47590fbb.alex.williamson@redhat.com>
        <1eba059c-4743-4675-9f72-1a26b8f3c0f6@nvidia.com>
        <20210929075019.48d07deb.alex.williamson@redhat.com>
        <d2e94241-a146-c57d-cf81-8b7d8d00e62d@nvidia.com>
        <20210929091712.6390141c.alex.williamson@redhat.com>
        <e1ba006f-f181-0b89-822d-890396e81c7b@nvidia.com>
        <20210929161433.GA1808627@ziepe.ca>
        <29835bf4-d094-ae6d-1a32-08e65847b52c@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 Sep 2021 00:48:55 +0300
Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 9/29/2021 7:14 PM, Jason Gunthorpe wrote:
> > On Wed, Sep 29, 2021 at 06:28:44PM +0300, Max Gurtovoy wrote:
> >  
> >>> So you have a device that's actively modifying its internal state,
> >>> performing I/O, including DMA (thereby dirtying VM memory), all while
> >>> in the _STOP state?  And you don't see this as a problem?  
> >> I don't see how is it different from vfio-pci situation.  
> > vfio-pci provides no way to observe the migration state. It isn't
> > "000b"  
> 
> Alex said that there is a problem of compatibility.
> 
> I migration SW is not involved, nobody will read this migration state.

The _STOP state has a specific meaning regardless of whether userspace
reads the device state value.  I think what you're suggesting is that
the device reports itself as _STOP'd but it's actually _RUNNING.  Is
that the compatibility workaround, create a self inconsistency?

We cannot impose on userspace to move a device from _STOP to _RUNNING
simply because the device supports the migration region, nor should we
report a device state that is inconsistent with the actual device state.

> >> Maybe we need to rename STOP state. We can call it READY or LIVE or
> >> NON_MIGRATION_STATE.  
> > It was a poor choice to use 000b as stop, but it doesn't really
> > matter. The mlx5 driver should just pre-init this readable to running.  
> 
> I guess we can do it for this reason. There is no functional problem nor 
> compatibility issue here as was mentioned.
> 
> But still we need the kernel to track transitions. We don't want to 
> allow moving from RESUMING to SAVING state for example. How this 
> transition can be allowed ?
> 
> In this case we need to fail the request from the migration SW...

_RESUMING to _SAVING seems like a good way to test round trip migration
without running the device to modify the state.  Potentially it's a
means to update a saved device migration data stream to a newer format
using an intermediate driver version.

If a driver is written such that it simply sees clearing the _RESUME
bit as an indicator to de-serialize the data stream to the device, and
setting the _SAVING flag as an indicator to re-serialize that data
stream from the device, then this is just a means to make use of
existing data paths.

The uAPI specifies a means for drivers to reject a state change, but
that risks failing to support a transition which might find mainstream
use cases.  I don't think common code should be responsible for
filtering out viable transitions.  Thanks,

Alex

