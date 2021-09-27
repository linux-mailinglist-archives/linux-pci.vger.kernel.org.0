Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2706A41A342
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 00:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhI0Wsc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 18:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237844AbhI0Wsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 18:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632782812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8F+8mdvFnjyvb27t/Z7nCLuVODAh1SKK2P1DV+cBzVQ=;
        b=T8rl9bJniw4vopVQ7mtIaOb48I3cuFVPEbhpGi+9B/WGYumaEZSxPdI3yPReDQgDkWaAI2
        n9lDoWkfWL9fazmKwT11LSAv5xpOnP5rtAkEzqlHhgHKfB8LxYXCEjSTcb+QLzCiEldJJm
        rnak6LdxAQKREuTWXfkkUHizZbpSBe0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-UGs-gR9mNVKpAQhMl8f4OQ-1; Mon, 27 Sep 2021 18:46:50 -0400
X-MC-Unique: UGs-gR9mNVKpAQhMl8f4OQ-1
Received: by mail-oi1-f200.google.com with SMTP id y65-20020aca4b44000000b002719194f1e0so16411443oia.7
        for <linux-pci@vger.kernel.org>; Mon, 27 Sep 2021 15:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8F+8mdvFnjyvb27t/Z7nCLuVODAh1SKK2P1DV+cBzVQ=;
        b=6Iy5zw1y9pZ7R/BMvBoqG4VHLMMbfOq7kLOjwELzWrdP9XzU2+bVoZiV7sO5gn1q4G
         9v5U9YNg2F78BD4C0/3ClPqhGXrcgLJ+Nn98DiTnTN7GDxeGWFEwGKm6+hfEegbvYnVr
         V85SBYS6MxMv8zBJxgu8gJgyJ6q8wAr3olHju6s1btom7twN6xyBqrVbTbDbdczGSngW
         sQfMcXAybTrz88Js4u2/GIZKhot4FdNkv5IiPg+mQZfzyb+LDF2i/UQcqP4ksKNe6Oo1
         4RCWBhgoKoKja40pjg0NXRt3yArZThTVE30oE9CfnLWmn9h7YC8zWYd/Tdzo/XZLCzz+
         iXNA==
X-Gm-Message-State: AOAM533Jc1k6u6I6Viqrv4/WaYpb/OyUHPVu8UXj8DAv+LnPCYDYzfmU
        TGR9WgnLE0l2FqKctgM7EN0FG/cGqif7zvsP3beCHjulAocwJW/i5foN8ouyExegdbzT/z9Xz6q
        0txDCYK6B16N1cvpP2q8g
X-Received: by 2002:a9d:3e4b:: with SMTP id h11mr2287823otg.294.1632782810027;
        Mon, 27 Sep 2021 15:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1jND2vrOW39yVryOFHax2Bs9KlJre1+KCsNJKeV9Tr2lKgH+ZgnhOc6Tb6usJYsbl04jIhQ==
X-Received: by 2002:a9d:3e4b:: with SMTP id h11mr2287802otg.294.1632782809801;
        Mon, 27 Sep 2021 15:46:49 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id y9sm4403779ooe.10.2021.09.27.15.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:46:49 -0700 (PDT)
Date:   Mon, 27 Sep 2021 16:46:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210927164648.1e2d49ac.alex.williamson@redhat.com>
In-Reply-To: <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
References: <cover.1632305919.git.leonro@nvidia.com>
        <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 22 Sep 2021 13:38:51 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Add an API in the core layer to check migration state transition validity
> as part of a migration flow.
> 
> The valid transitions follow the expected usage as described in
> uapi/vfio.h and triggered by QEMU.
> 
> This ensures that all migration implementations follow a consistent
> migration state machine.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/vfio.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/vfio.h |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 3c034fe14ccb..c3ca33e513c8 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -1664,6 +1664,47 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
>  	return 0;
>  }
>  
> +/**
> + * vfio_change_migration_state_allowed - Checks whether a migration state
> + *   transition is valid.
> + * @new_state: The new state to move to.
> + * @old_state: The old state.
> + * Return: true if the transition is valid.
> + */
> +bool vfio_change_migration_state_allowed(u32 new_state, u32 old_state)
> +{
> +	enum { MAX_STATE = VFIO_DEVICE_STATE_RESUMING };
> +	static const u8 vfio_from_state_table[MAX_STATE + 1][MAX_STATE + 1] = {
> +		[VFIO_DEVICE_STATE_STOP] = {
> +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> +			[VFIO_DEVICE_STATE_RESUMING] = 1,
> +		},

Our state transition diagram is pretty weak on reachable transitions
out of the _STOP state, why do we select only these two as valid?

Consistent behavior to userspace is of course nice, but I wonder if we
were expecting a device reset to get us back to _RUNNING, or if the
drivers would make use of the protocol through which a driver can nak
(write error, no state change) or fault (_ERROR device state) a state
change.

There does need to be a way to get back to _RUNNING to support a
migration failure without a reset, but would that be from _SAVING
or from _STOP and what's our rationale for the excluded states?

I'll see if I can dig through emails to find what was intended to be
reachable from _STOP.  Kirti or Connie, do you recall?

Also, I think the _ERROR state is implicitly handled correctly here,
its value is >MAX_STATE so we can't transition into or out of it, but a
comment to indicate that it's been considered for this would be nice.

> +		[VFIO_DEVICE_STATE_RUNNING] = {
> +			[VFIO_DEVICE_STATE_STOP] = 1,
> +			[VFIO_DEVICE_STATE_SAVING] = 1,
> +			[VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING] = 1,
> +		},

Shameer's comment is correct here, _RESUMING is a valid next state
since the default state is _RUNNING.

> +		[VFIO_DEVICE_STATE_SAVING] = {
> +			[VFIO_DEVICE_STATE_STOP] = 1,
> +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> +		},

What's the rationale that we can't return to _SAVING|_RUNNING here?

> +		[VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING] = {
> +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> +			[VFIO_DEVICE_STATE_SAVING] = 1,
> +		},

Can't we always _STOP the device at any point?

> +		[VFIO_DEVICE_STATE_RESUMING] = {
> +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> +			[VFIO_DEVICE_STATE_STOP] = 1,
> +		},

Couldn't it be possible to switch immediately to _RUNNING|_SAVING for
tracing purposes?  Or _SAVING, perhaps to validate the restored state
without starting the device?  Thanks,

Alex

> +	};
> +
> +	if (new_state > MAX_STATE || old_state > MAX_STATE)
> +		return false;
> +
> +	return vfio_from_state_table[old_state][new_state];
> +}
> +EXPORT_SYMBOL_GPL(vfio_change_migration_state_allowed);
> +
>  static long vfio_device_fops_unl_ioctl(struct file *filep,
>  				       unsigned int cmd, unsigned long arg)
>  {
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index b53a9557884a..e65137a708f1 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -83,6 +83,7 @@ extern struct vfio_device *vfio_device_get_from_dev(struct device *dev);
>  extern void vfio_device_put(struct vfio_device *device);
>  
>  int vfio_assign_device_set(struct vfio_device *device, void *set_id);
> +bool vfio_change_migration_state_allowed(u32 new_state, u32 old_state);
>  
>  /* events for the backend driver notify callback */
>  enum vfio_iommu_notify_type {

