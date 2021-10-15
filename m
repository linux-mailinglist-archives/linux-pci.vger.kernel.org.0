Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FFA42FD29
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhJOVBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 17:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232377AbhJOVBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 17:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634331564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v99JWcKKrqW7DU+3CyphAVwqwj1tzyLiI7G6EPgS3Vo=;
        b=g0uvGgDaLqO0LTb49rnr8MuSVE8Bhbh9oh/8Wqn7q7lV85wPjoi8cprCtG6AQQUMgPInY7
        tJIbXnactUq+AcK3mVOuuHhEDIVLhUlVeZrDy8+mm1CvOlMiAzQzRXPH6yIziCGhuws2ro
        +uXmIX+9sBuL9Wf8xvgno+VXEvYAS+Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-VvTa8JFAPGyOg7aGuSViUQ-1; Fri, 15 Oct 2021 16:59:23 -0400
X-MC-Unique: VvTa8JFAPGyOg7aGuSViUQ-1
Received: by mail-oi1-f200.google.com with SMTP id m5-20020a05680806c500b00276dd287318so5836278oih.20
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 13:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v99JWcKKrqW7DU+3CyphAVwqwj1tzyLiI7G6EPgS3Vo=;
        b=51LTGjBzHrJyI3zuotA1+u8P6BY+v2MpSMfjhqJ7YkFqT+O5FxrYUuPJZSXZzyQmk+
         Wgxaq4vr54MIdr6y1CQsF1Ct2LBHZpDuiWkc+73iLdPK/ueYt3vaxl9JHPxHQpBKhZvQ
         NoGuGP6pvguPric+9HVtzu9hkGTd8pA/rkpaRtqhvXklxUBWi55kNCW+BKQEzl2hAucq
         v0bbXSLIR009Ph/0f3IZ1OeCkhn3j8jNgicjNgWz/5WJbKKAdq37+VlHwfwcCoJ+MBL2
         j6fySwlzraGEbfXOpvHLuCaH4vXvzguW5KUkAVKEPPFaiyiiPXO449rqMsjh7Dfm4JJd
         5rLA==
X-Gm-Message-State: AOAM531AnQTEzWVp0iza/QL2HAzlZcynR02CMnxJw0Nt6b78hulIja+p
        yJXIp6MMPXgvcRbQn5ZjUtAzXbXEO0i6a4va5LJJV9/zjDWLihlLYQldWaXJCIwu4HKIBnpQxk2
        Bbb+wSG3Cif54tHbDD7VC
X-Received: by 2002:aca:3e86:: with SMTP id l128mr12942169oia.120.1634331562759;
        Fri, 15 Oct 2021 13:59:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym7mNH86TE1dnlVg0esBKlyshh5+PxNWaTruNOVWx7TNl3EVM2DUbqX/P4AtRyh3rRBx9L6Q==
X-Received: by 2002:aca:3e86:: with SMTP id l128mr12942152oia.120.1634331562564;
        Fri, 15 Oct 2021 13:59:22 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v5sm1415847oix.6.2021.10.15.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:59:22 -0700 (PDT)
Date:   Fri, 15 Oct 2021 14:59:21 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1 mlx5-next 11/13] vfio/mlx5: Implement vfio_pci driver
 for mlx5 devices
Message-ID: <20211015145921.0abf7cb0.alex.williamson@redhat.com>
In-Reply-To: <20211015201654.GH2744544@nvidia.com>
References: <20211013094707.163054-1-yishaih@nvidia.com>
        <20211013094707.163054-12-yishaih@nvidia.com>
        <20211015134820.603c45d0.alex.williamson@redhat.com>
        <20211015195937.GF2744544@nvidia.com>
        <20211015141201.617049e9.alex.williamson@redhat.com>
        <20211015201654.GH2744544@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 15 Oct 2021 17:16:54 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Oct 15, 2021 at 02:12:01PM -0600, Alex Williamson wrote:
> > On Fri, 15 Oct 2021 16:59:37 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Fri, Oct 15, 2021 at 01:48:20PM -0600, Alex Williamson wrote:  
> > > > > +static int mlx5vf_pci_set_device_state(struct mlx5vf_pci_core_device *mvdev,
> > > > > +				       u32 state)
> > > > > +{
> > > > > +	struct mlx5vf_pci_migration_info *vmig = &mvdev->vmig;
> > > > > +	u32 old_state = vmig->vfio_dev_state;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	if (vfio_is_state_invalid(state) || vfio_is_state_invalid(old_state))
> > > > > +		return -EINVAL;    
> > > > 
> > > > if (!VFIO_DEVICE_STATE_VALID(old_state) || !VFIO_DEVICE_STATE_VALID(state))    
> > > 
> > > AFAICT this macro doesn't do what is needed, eg
> > > 
> > > VFIO_DEVICE_STATE_VALID(0xF000) == true
> > > 
> > > What Yishai implemented is at least functionally correct - states this
> > > driver does not support are rejected.  
> > 
> > 
> > if (!VFIO_DEVICE_STATE_VALID(old_state) || !VFIO_DEVICE_STATE_VALID(state)) || (state & ~VFIO_DEVICE_STATE_MASK))
> > 
> > old_state is controlled by the driver and can never have random bits
> > set, user state should be sanitized to prevent setting undefined bits.  
> 
> In that instance let's just write
> 
> old_state != VFIO_DEVICE_STATE_ERROR
> 
> ?

Not quite, the user can't set either of the other invalid states
either.

> 
> I'm happy to see some device specific mask selecting the bits it
> supports.

There are currently no optional bits within the mask, but the
RESUME|RUNNING state is rather TBD.  I figured we'd use flags in the
region info to advertise additional feature bits when it comes to that.
Thanks,

Alex

