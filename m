Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2795543CD82
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 17:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbhJ0PcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 11:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242712AbhJ0PcO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 11:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635348588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyWc/N/hzZAc5JmBicW4mZo6NhyOujGkSJMtDUnE6+Q=;
        b=RQUpaKvXjb2ZBR/k3/DHn+tJ9ypRSapO0w5b+jH2yjU2a/RlvPnsGK0UhMNP36ehKWW5sM
        N5/zKbP/coMlIu2KW+4njWqxeV8kkrADamMrLmA/tMqUF8v5NqhoKsqzmFYIva7rgkPRuq
        UfuDVxNo/aWgbu1zSi1jSDM2nohWFlA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-rZ7BuTwGPnuf_ESCFdQepA-1; Wed, 27 Oct 2021 11:29:47 -0400
X-MC-Unique: rZ7BuTwGPnuf_ESCFdQepA-1
Received: by mail-ot1-f69.google.com with SMTP id h30-20020a9d3e5e000000b00553d08fc166so1296445otg.12
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 08:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OyWc/N/hzZAc5JmBicW4mZo6NhyOujGkSJMtDUnE6+Q=;
        b=Y47Kd6LJk+xmghFDutWYdsTNnd/pTgssrh5eHuK8P7kDwjit7DdGa59hExGR2wFbEA
         QuV5xGKTWYfaEh7rF6VH8rC1lD+szXe7geiseSccOoR00noblrFiwVO0V8NIOjBmNelM
         IwvV2J8CQ5CuuvGNENryPsfDZMYkRNNQkHFLVpvWXCezvO4FeIOwjbH2e4VLDDYZK1G4
         6zuDj31OVKXoKmqIoSOKV/RHOt2hQKaYEDsl1ak002TyPy0dq184utabpErKi49bgrpx
         q94LMl/1J8xbOekH9/FQLYEOF8c/tWw0ciN4WuCu8eK6LPTytbGh4CzHPTfnKBWrhnKB
         Wrbw==
X-Gm-Message-State: AOAM533a4vSoKMZ097fWsmNFlTQ8vQxZwc2Iyg98Q9zkiAn/g8GpdT2E
        jOTH/IWwA4ysARJJ7eMXex5/rLdFMjL4TAJxg/9Ib8UPxhpNYCFXHlVHNVp9wmU7neLrpV+I0xk
        iInLovq/I7vEXZstfsXB6
X-Received: by 2002:aca:300e:: with SMTP id w14mr4210042oiw.178.1635348586499;
        Wed, 27 Oct 2021 08:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTxFcAgeuq1Diai3BB4irLIENGYdyXntO6d+LQ7ij4Nc5NGrTPvQBz87bd/efni4z/y288kg==
X-Received: by 2002:aca:300e:: with SMTP id w14mr4210018oiw.178.1635348586264;
        Wed, 27 Oct 2021 08:29:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r14sm96409oiw.44.2021.10.27.08.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 08:29:45 -0700 (PDT)
Date:   Wed, 27 Oct 2021 09:29:43 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V4 mlx5-next 13/13] vfio/mlx5: Use its own PCI
 reset_done error handler
Message-ID: <20211027092943.4f95f220.alex.williamson@redhat.com>
In-Reply-To: <20211026235002.GC2744544@nvidia.com>
References: <20211026090605.91646-1-yishaih@nvidia.com>
        <20211026090605.91646-14-yishaih@nvidia.com>
        <20211026171644.41019161.alex.williamson@redhat.com>
        <20211026235002.GC2744544@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Oct 2021 20:50:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Oct 26, 2021 at 05:16:44PM -0600, Alex Williamson wrote:
> > > @@ -471,6 +474,47 @@ mlx5vf_pci_migration_data_rw(struct mlx5vf_pci_core_device *mvdev,
> > >  	return count;
> > >  }
> > >  
> > > +/* This function is called in all state_mutex unlock cases to
> > > + * handle a 'defered_reset' if exists.
> > > + */  
> > 
> > I refrained from noting it elsewhere, but we're not in net/ or
> > drivers/net/ here, but we're using their multi-line comment style.  Are
> > we using the strong relation to a driver that does belong there as
> > justification for the style here?  
> 
> I think it is an oversight, tell Yishai you prefer the other format in
> drivers/vfio and it can be fixed

Seems fixed in the new version.

> > > @@ -539,7 +583,7 @@ static ssize_t mlx5vf_pci_mig_rw(struct vfio_pci_core_device *vdev,
> > >  	}
> > >  
> > >  end:
> > > -	mutex_unlock(&mvdev->state_mutex);
> > > +	mlx5vf_state_mutex_unlock(mvdev);  
> > 
> > I'm a little lost here, if the operation was to read the device_state
> > and mvdev->vmig.vfio_dev_state was error, that's already been copied to
> > the user buffer, so the user continues to see the error state for the
> > first read of device_state after reset if they encounter this race?  
> 
> Yes. If the userspace races ioctls they get a deserved mess.
> 
> This race exists no matter what we do, as soon as the unlock happens a
> racing reset ioctl could run in during the system call exit path.
> 
> The purpose of the locking is to protect the kernel from hostile
> userspace, not to allow userspace to execute concurrent ioctl's in a
> sensible way.

The reset_done handler sets deferred_reset = true and if it's possible
to get the state_mutex, will reset migration data and device_state as
part of releasing that mutex.  If there's contention on state_mutex,
the deferred_reset field flags that this migration state is still stale.

So, I assume that it's possible that a user resets the device via ioctl
or config space, there was contention and the migration state is still
stale, right?

The user then goes to read device_state, but the staleness of the
migration state is not resolved until *after* the stale device state is
copied to the user buffer.

What did the user do wrong to see stale data?  Thanks,

Alex

