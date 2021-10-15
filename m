Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505A942FC97
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbhJOT4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 15:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242844AbhJOT4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 15:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634327669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjEbcwJXPeNzawEznVGMrMsBe5Mx657awI84UVBQf88=;
        b=iHWOckWWGPPGoVH6yYfy6cYBQnKnlVdrqMc1qGPgoKUr9toIngDwbMm5p8HXKMHFxVwZ6K
        f2ef6fre5YyM8iK2fPyMNsz6S7gEt65/WieBtqtKZG9OPXo/GuXjaKVErhYeMeHV7HHgl3
        ne9sf7nW+GN8sfLJO2zCS+9YXvIfn4U=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-sra8nOmnMniR0W00u67P9g-1; Fri, 15 Oct 2021 15:54:26 -0400
X-MC-Unique: sra8nOmnMniR0W00u67P9g-1
Received: by mail-ot1-f71.google.com with SMTP id 100-20020a9d02ed000000b0054e1a7095faso6241653otl.5
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 12:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjEbcwJXPeNzawEznVGMrMsBe5Mx657awI84UVBQf88=;
        b=iaG6rh1XiblzNrNzouq2Afe7SR5vKWIR/a8zeH7yM7MK0FrizgfF3d10d17mx136jb
         hs9wYyc2KZxKS8WSVQUAOL4zWEoKqZu32nLskM9sB+E6sqnb7Z/Zc4VHMWmt0bSlz+d1
         mS25bf/Aj0uEbB2DZ3VmHjkQX6HllF7eTQg+L33WcMrIPgQsCPhaUSyih16nUlj8wTam
         DXaQUnqvmg3yhfhSQyhrIF58ljqEMzQ+eyH45Rzcfs7Rhf4nIPienetSnaYxLfEJsjBj
         rpblornZAP7Vt1ZoCa5gDvdKpD9QTMei1zDusJDS4dLzNILWTY+7l4ZRIzayxvEwQl+r
         VsuA==
X-Gm-Message-State: AOAM533Jo+woduYAmzYdqdtcV9E+M1AVt9D+zSBuhQpQmh5LVgK/H0sn
        GkMR0N4RvXCqrBFUcUQ8Y1qNZ/efzPEijaPOgYcqaBrjQCc6q6jOcLgx5B3/WztVVTkykCJryLl
        1UMjw1DLVSGcBIvtIvj1h
X-Received: by 2002:a05:6830:31b3:: with SMTP id q19mr9345828ots.2.1634327665458;
        Fri, 15 Oct 2021 12:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6NoACyVD6ADSV4rkjsWjJ5hmWgFi3c/Z4bw4ieq9WBxteAkcQmlbzt7SDuxoRkXcjpCp2Jw==
X-Received: by 2002:a05:6830:31b3:: with SMTP id q19mr9345819ots.2.1634327665303;
        Fri, 15 Oct 2021 12:54:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f14sm1163491oop.8.2021.10.15.12.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 12:54:24 -0700 (PDT)
Date:   Fri, 15 Oct 2021 13:54:23 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, <bhelgaas@google.com>,
        <saeedm@nvidia.com>, <linux-pci@vger.kernel.org>,
        <kvm@vger.kernel.org>, <netdev@vger.kernel.org>, <kuba@kernel.org>,
        <leonro@nvidia.com>, <kwankhede@nvidia.com>,
        <mgurtovoy@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 mlx5-next 13/13] vfio/mlx5: Trap device RESET and
 update state accordingly
Message-ID: <20211015135423.5f8db5d7.alex.williamson@redhat.com>
In-Reply-To: <cae3309e-4175-b134-c1f6-5ec02f352078@nvidia.com>
References: <20211013094707.163054-1-yishaih@nvidia.com>
        <20211013094707.163054-14-yishaih@nvidia.com>
        <20211013180651.GM2744544@nvidia.com>
        <cae3309e-4175-b134-c1f6-5ec02f352078@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Oct 2021 12:18:30 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 10/13/2021 9:06 PM, Jason Gunthorpe wrote:
> > On Wed, Oct 13, 2021 at 12:47:07PM +0300, Yishai Hadas wrote:  
> >> Trap device RESET and update state accordingly, it's done by registering
> >> the matching callbacks.
> >>
> >> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> >> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >>   drivers/vfio/pci/mlx5/main.c | 17 ++++++++++++++++-
> >>   1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
> >> index e36302b444a6..8fe44ed13552 100644
> >> +++ b/drivers/vfio/pci/mlx5/main.c
> >> @@ -613,6 +613,19 @@ static const struct vfio_device_ops mlx5vf_pci_ops = {
> >>   	.match = vfio_pci_core_match,
> >>   };
> >>   
> >> +static void mlx5vf_reset_done(struct vfio_pci_core_device *core_vdev)
> >> +{
> >> +	struct mlx5vf_pci_core_device *mvdev = container_of(
> >> +			core_vdev, struct mlx5vf_pci_core_device,
> >> +			core_device);
> >> +
> >> +	mvdev->vmig.vfio_dev_state = VFIO_DEVICE_STATE_RUNNING;  
> > This should hold the state mutex too
> >  
> Thanks Jason, I'll add as part of V2.
> 
> Alex,
> 
> Any feedback from your side before that we'll send V2 ?
> 
> We already got ACK for the PCI patches, there are some minor changes to 
> be done so far.

Provided.  Thanks,

Alex

