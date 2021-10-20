Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918DD435556
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 23:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhJTVkd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 17:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230287AbhJTVkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 17:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634765897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbdsG4EcQisr17Iskog0vXpruq6STxaIgx5C21IY1Zo=;
        b=H1j3fNi78hTHI35eFdB4sohqnb/FPCjOEsYXidOKEUrJMaRZn0Sj6pKlJcj9MZW4CzLlS3
        U2RS1P0TgmqWcH0s/Q286GL0M6E/SHr5GbinpUgULm9wOYArO9vh2GDVEkPPPJAKGbFVs3
        9A84kDGgoiScfdEZfh8jSSxfIY2tQzk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-p-biOCkvOdilTTTUuxJNAw-1; Wed, 20 Oct 2021 17:38:16 -0400
X-MC-Unique: p-biOCkvOdilTTTUuxJNAw-1
Received: by mail-ot1-f70.google.com with SMTP id z15-20020a9d71cf000000b0055036817463so4430223otj.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Oct 2021 14:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbdsG4EcQisr17Iskog0vXpruq6STxaIgx5C21IY1Zo=;
        b=txURxWSHXZcXMlW6nOA0f077zxOoYjQPZ19j620lDk2kz3Hjptkx99Huzj7qpEY6aU
         V/JIe5r9HhU0hKiyuhQ5ZxGjc7UIBvUF+jBOKSV1K5qlTD0vv2Y5o0/o2FktYd0PQAJi
         RIUaOXnE9Z/187DZG7CS3hDtk0swpiMlgzyV26LJcVQG91GR/occB5fAub+Wt9eubx8d
         baiow5V++iS3oUZxxBBRHnJjce8krWq1rvAvnKw16zcuYJZwTBfwPE4IG4MnIHtlR0bh
         moBXCfbMSnvCTC4KNZDjZ6OfSGS2AGRiFK5jT1wGFORKVyVchYplGzfq4pflirlHt8jV
         HiFw==
X-Gm-Message-State: AOAM530NSgb9t8KKDS5LBNLR3pHbvN6cMqFL6dJM9+I6JKKAKMnqdohT
        /DH2HxltXUGYjPXnAQKE7HBhJwiD3PBMDuR/iaUq6/WTND3doocpLxCYtnmP4a78IzfxiBMHc7l
        hm9wIYIwkgfM14qXBRWCZ
X-Received: by 2002:a05:6830:23a6:: with SMTP id m6mr1395871ots.38.1634765896057;
        Wed, 20 Oct 2021 14:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcYwv8zbsaoSRcNVZjvX/sdYTsJO3gGahLP/SP6a466G/UR5ZPiviXT+kWQPZGr7oDTSa6RQ==
X-Received: by 2002:a05:6830:23a6:: with SMTP id m6mr1395858ots.38.1634765895851;
        Wed, 20 Oct 2021 14:38:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id n17sm646213oic.21.2021.10.20.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:38:15 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:38:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V2 mlx5-next 14/14] vfio/mlx5: Use its own PCI
 reset_done error handler
Message-ID: <20211020153814.61477e2e.alex.williamson@redhat.com>
In-Reply-To: <20211020185721.GA334@nvidia.com>
References: <20211019105838.227569-1-yishaih@nvidia.com>
        <20211019105838.227569-15-yishaih@nvidia.com>
        <20211019125513.4e522af9.alex.williamson@redhat.com>
        <20211019191025.GA4072278@nvidia.com>
        <5cf3fb6c-2ca0-f54e-3a05-27762d29b8e2@nvidia.com>
        <20211020164629.GG2744544@nvidia.com>
        <20211020114514.560ce2fa.alex.williamson@redhat.com>
        <20211020185721.GA334@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Oct 2021 15:57:21 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Oct 20, 2021 at 11:45:14AM -0600, Alex Williamson wrote:
> > On Wed, 20 Oct 2021 13:46:29 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Wed, Oct 20, 2021 at 11:46:07AM +0300, Yishai Hadas wrote:
> > >   
> > > > What is the expectation for a reasonable delay ? we may expect this system
> > > > WQ to run only short tasks and be very responsive.    
> > > 
> > > If the expectation is that qemu will see the error return and the turn
> > > around and issue FLR followed by another state operation then it does
> > > seem strange that there would be a delay.
> > > 
> > > On the other hand, this doesn't seem that useful. If qemu tries to
> > > migrate and the device fails then the migration operation is toast and
> > > possibly the device is wrecked. It can't really issue a FLR without
> > > coordinating with the VM, and it cannot resume the VM as the device is
> > > now irrecoverably messed up.
> > > 
> > > If we look at this from a RAS perspective would would be useful here
> > > is a way for qemu to request a fail safe migration data. This must
> > > always be available and cannot fail.
> > > 
> > > When the failsafe is loaded into the device it would trigger the
> > > device's built-in RAS features to co-ordinate with the VM driver and
> > > recover. Perhaps qemu would also have to inject an AER or something.
> > > 
> > > Basically instead of the device starting in an "empty ready to use
> > > state" it would start in a "failure detected, needs recovery" state.  
> > 
> > The "fail-safe recovery state" is essentially the reset state of the
> > device.  
> 
> This is only the case if qemu does work to isolate the recently FLR'd
> device from the VM until the VM acknowledges that it understands it is
> FLR'd.
> 
> At least it would have to remove it from CPU access and the IOMMU, as
> though the memory enable bit was cleared.
> 
> Is it reasonable to do this using just qemu, AER and no device
> support?

I suspect yes, worst case could be a surprise hot-remove or DPC event,
but IIRC Linux will reset a device on a fatal AER error regardless of
the driver.

> > If a device enters an error state during migration, I would
> > think the ultimate recovery procedure would be to abort the migration,
> > send an AER to the VM, whereby the guest would trigger a reset, and
> > the RAS capabilities of the guest would handle failing over to a
> > multipath device, ejecting the failing device, etc.  
> 
> Yes, this is my thinking, except I would not abort the migration but
> continue on to the new hypervisor and then do the RAS recovery with
> the new device.

Potentially a valid option, QEMU might optionally insert a subsection in
the migration stream to indicate the device failed during the migration
process.  The option might also allow migrating devices that don't
support migration, ie. the recovery process on the target is the same.
This is essentially a policy decision and I think QEMU probably leans
more towards failing the migration and letting a management tool
decided on the next course of action.  Thanks,

Alex

