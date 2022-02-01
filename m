Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C084A6073
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 16:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiBAPsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 10:48:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbiBAPsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 10:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643730482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Knci/X96aFPzSMVFU3zf+SkqZCYI3io+dJ2JPBOMDk=;
        b=TZtMiL7RYJxzfdfUFIrtps4nDp/rLHz7kAKFm1WkT0lrlbW6A/2K9N5SmANF97Gr4Icqck
        5yq3Q5ru+EJH4H40egEvNMMPqpb3A1yCaQHUufZtFncOip9hIx6kpJatAcyraKPq5ZmhXO
        mTAfQUEYG99CajERTOZqDtOuoMvOslM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-F_f94oQNPRmxeGoT7bqxlg-1; Tue, 01 Feb 2022 10:48:01 -0500
X-MC-Unique: F_f94oQNPRmxeGoT7bqxlg-1
Received: by mail-oo1-f70.google.com with SMTP id g2-20020a4a9242000000b002da7c459222so6817244ooh.13
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 07:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Knci/X96aFPzSMVFU3zf+SkqZCYI3io+dJ2JPBOMDk=;
        b=NrigCjS53uzCJ7Zv1aaZqiQzyaHsvLKZ0INHmjI+rG8RsObyEti1WIAviIV4ZMkCVX
         vSCh5gn5Pzb6xKei/nXgcsVcehYSOKFQr0xw7a7XrICEGLB6r4Hl2gubevYboN0BWaw0
         Pw9+O2q3PTdyWU9gUtOypELs2eHFpwHoMNjTuT7n3haI5sFQyyZUaQMHwChUIzWA3QjM
         cDKt6Lbb8MzU5q+w5q4iVZDFvGL1ZKnakC5oHLRjxbW1Ul59gtOl6Tv3PtLUIx5mnAkg
         ohforrbQ3aJILUyome8F2lmifB88FLFzCic1LhQM1QW5duyjpNgEUs3fdgqJOqHBKcNS
         iu9g==
X-Gm-Message-State: AOAM531bn30rkWtETIdzPWAsYfo5gfOPJTX7ugjrenP0dZCOOD4LaolM
        esjLfXg/tW3SYT4YzabG9obc2e6l6OGallAQvzx8R/krBecOCJOKM3DgYLU/vHpbloyjVgm8QcK
        ES0F2Ci5PUMJhwZ+uYRa1
X-Received: by 2002:a05:6808:23ca:: with SMTP id bq10mr1790901oib.231.1643730480394;
        Tue, 01 Feb 2022 07:48:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/ry/WmF0nAwd5BGAo0XXYdPkIIcEkBtT4hvQOF28RNhJmYh7Hg0chPAeCnJSrW0mLpwwJnA==
X-Received: by 2002:a05:6808:23ca:: with SMTP id bq10mr1790885oib.231.1643730480206;
        Tue, 01 Feb 2022 07:48:00 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s13sm56278ooh.43.2022.02.01.07.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:47:59 -0800 (PST)
Date:   Tue, 1 Feb 2022 08:47:58 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        saeedm@nvidia.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, kuba@kernel.org, leonro@nvidia.com,
        kwankhede@nvidia.com, mgurtovoy@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V6 mlx5-next 07/15] vfio: Have the core code decode the
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20220201084758.17e66f41.alex.williamson@redhat.com>
In-Reply-To: <20220201001148.GY1786498@nvidia.com>
References: <20220130160826.32449-1-yishaih@nvidia.com>
        <20220130160826.32449-8-yishaih@nvidia.com>
        <20220131164143.6c145fdb.alex.williamson@redhat.com>
        <20220201001148.GY1786498@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 Jan 2022 20:11:48 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jan 31, 2022 at 04:41:43PM -0700, Alex Williamson wrote:
> > > +int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> > > +				void __user *arg, size_t argsz)
> > > +{
> > > +	struct vfio_pci_core_device *vdev =
> > > +		container_of(device, struct vfio_pci_core_device, vdev);
> > > +	uuid_t uuid;
> > > +	int ret;  
> > 
> > Nit, should uuid at least be scoped within the token code?  Or token
> > code pushed to a separate function?  
> 
> Sure, it wasn't done before, but it would be nicer,.
> 
> > > +static inline int vfio_check_feature(u32 flags, size_t argsz, u32 supported_ops,
> > > +				    size_t minsz)
> > > +{
> > > +	if ((flags & (VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET)) &
> > > +	    ~supported_ops)
> > > +		return -EINVAL;  
> > 
> > These look like cases where it would be useful for userspace debugging
> > to differentiate errnos.  
> 
> I tried to keep it unchanged from what it was today.
> 
> > -EOPNOTSUPP?  
> 
> This would be my preference, but it would also be the first use in
> vfio
> 
> > > +	if (flags & VFIO_DEVICE_FEATURE_PROBE)
> > > +		return 0;
> > > +	/* Without PROBE one of GET or SET must be requested */
> > > +	if (!(flags & (VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET)))
> > > +		return -EINVAL;
> > > +	if (argsz < minsz)
> > > +		return -EINVAL;  
> >
> > -ENOSPC?  
> 
> Do you want to do all of these minsz then? There are lots..

Hmm, maybe this one is more correct as EINVAL.  In the existing use
cases the structure associated with the feature is a fixed size, so
it's not a matter that we down have space for a return like
HOT_RESET_INFO, it's simply invalid arguments by the caller.  I guess
keep this one as EINVAL, but EOPNOTSUPP seems useful for the previous.
Thanks,

Alex

