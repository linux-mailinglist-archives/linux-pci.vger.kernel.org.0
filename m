Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675E9433B0B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhJSPui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 11:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhJSPui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 11:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634658505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u3Piw9dqGW8KX5c4wzu0TReP8OMfYCDJCIB53OxyOgc=;
        b=KrDUzLRECujoPmNJ2vdpP23kpboLgKBukDo0zXZSIdyy66llgJiqtlvAb+D+z/3/8mC04B
        /mHoBwjyUR3f0hx4zTmVLG6nirLo4gUhB/r0MuLpLIeRJ6rjEw8cip9G4GkPi4IpXmzljr
        NfPlOHyNeZ7JjTVgtdmXYvDHS/9/QXk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-KmRwz536MeiD-eMyYH-www-1; Tue, 19 Oct 2021 11:48:23 -0400
X-MC-Unique: KmRwz536MeiD-eMyYH-www-1
Received: by mail-oi1-f198.google.com with SMTP id f65-20020aca3844000000b002989bd3fe60so2103289oia.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Oct 2021 08:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3Piw9dqGW8KX5c4wzu0TReP8OMfYCDJCIB53OxyOgc=;
        b=IfhaVjN52dRH8mu7YNBMSjJA2c/09lg7AdYmSBqW7oUl+kwXfwCHzIMUAkjbwdLuhA
         K0wIIyJzEtb/L/xDjDP7JG552c4W5X4pJErrrtUSmpLHJjcFtMi0OM/iQ9tYWB8zbAJF
         MxfQrpxO9rrlcHhgPrkRnQTmbVhgWNoatvfSKmRA+YzwO9K8/DmrvqA2w29Un1NzDQ3E
         Zke+6pl35aewQNjCY/arERNbMsFnvw+WZz4DMKfbZql4ljFUJLDvQlsK1zlXlsARBKKN
         MW9rcUBWbCnu4QJt9yyboju9yGs3csay+b3QWl82NOWRBlQkmZbOYB81NQFxTKDnCciT
         s3UQ==
X-Gm-Message-State: AOAM531pt9Ycz4U9m7QI38dDhsvLfnzAO4D2jzpAP7E5rXgOmsyqqNL0
        tK0FjZnLmW8rpJTWV7Ghd2MX7j4z6Q/1NJnwRpO3ViFc95IqxsxPQUk0FDYD8TpwpYlPuiRGmtP
        tDISID5D/7RQbCa+VEWk7
X-Received: by 2002:a05:6830:308a:: with SMTP id f10mr6082822ots.150.1634658502497;
        Tue, 19 Oct 2021 08:48:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsvt2knK92qkTY42CACssaCcc4yXHQw/N/K5pD6CeNVMYIgblNrRm1oMRU/lODA/PQz3J/Ag==
X-Received: by 2002:a05:6830:308a:: with SMTP id f10mr6082810ots.150.1634658502306;
        Tue, 19 Oct 2021 08:48:22 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id bk8sm3226393oib.57.2021.10.19.08.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:48:21 -0700 (PDT)
Date:   Tue, 19 Oct 2021 09:48:20 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <jgg@nvidia.com>, <saeedm@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>, <leonro@nvidia.com>,
        <kwankhede@nvidia.com>, <mgurtovoy@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V2 mlx5-next 08/14] vfio: Add a macro for
 VFIO_DEVICE_STATE_ERROR
Message-ID: <20211019094820.2e9bfc01.alex.williamson@redhat.com>
In-Reply-To: <20211019105838.227569-9-yishaih@nvidia.com>
References: <20211019105838.227569-1-yishaih@nvidia.com>
        <20211019105838.227569-9-yishaih@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Oct 2021 13:58:32 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> Add a macro for VFIO_DEVICE_STATE_ERROR to be used to set/check an error
> state.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 114ffcefe437..6d41a0f011db 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -631,6 +631,8 @@ struct vfio_device_migration_info {
>  	__u64 data_size;
>  };
>  
> +#define VFIO_DEVICE_STATE_ERROR (VFIO_DEVICE_STATE_SAVING | \
> +				 VFIO_DEVICE_STATE_RESUMING)

This should be with the other VFIO_DEVICE_STATE_foo #defines.  I'd
probably put it between _RESUMING and _MASK.  Thanks,

Alex

>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within

