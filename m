Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D944AE5C1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 01:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiBIAIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 19:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiBIAII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 19:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F251AC0613CB
        for <linux-pci@vger.kernel.org>; Tue,  8 Feb 2022 16:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644365285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YVyzYjceHqtJTEnTgolmjHSaev9BDBTYcDygUVIpE8=;
        b=ecdRFW8gsGLOqOx3YlOQn9NhkVLcyEXkEoWFmBkFw/Ntg6xxfQnwfPwOSv+IFN7FggrsUd
        eSYWYEYgmHvvwLdytdvb7pi/gly0smmyQuzDwYMuwFEwvfMMraa1p0GjFYWnFxr6gmos83
        siLEcaBCpmnx+SOrvg5HKhETzA21BQU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-2VH-LYkKNIiW-_RhWTJuTA-1; Tue, 08 Feb 2022 19:08:04 -0500
X-MC-Unique: 2VH-LYkKNIiW-_RhWTJuTA-1
Received: by mail-il1-f197.google.com with SMTP id x6-20020a92d306000000b002bdff65a8e1so328043ila.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Feb 2022 16:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9YVyzYjceHqtJTEnTgolmjHSaev9BDBTYcDygUVIpE8=;
        b=a1Ly862VWN5CtHzM5gd5lZRTOZR/HsfdzdbrbXIO7cQQVMqkxzBTQrJjVtlKZ68nOV
         ucDG2B8jtuPD7p7f9TewuDoeeKaEfZWPn/BL/JxhQTtDvnxTs2TzE9dnR2Acqxd9pzfP
         /DNVLz0QBBoWYNeMo6cbR/zaNGF7hB7M+f2Yfe7mjglBBSHQg3g43CmFF4IpSqYhYrKI
         18a6qyh4RSgpL3aYCn4ocNXwy/dkah/eNm43SaMff2+0DNov1jnh8vObc9OEBGWyUPLt
         PA93lIwMZEfMzDePa+R2h1BGX4n4kB+CE68H1uozc5L0nIzVHl+yBKSxUgbavVbVJuRs
         aQHg==
X-Gm-Message-State: AOAM530TsyNKys34to+6eev6fM0ClHtTyOF7PykPblkvPMBzy6lxINMj
        xo7sbslZhFz0etYZMQn1vYrOGgE7v8OsKjGP4X3VLdhGtJpbBWoRXf0PK1dy04L4CSCUlJMHP0j
        jU5k2ijUopRI7/QcevKbC
X-Received: by 2002:a05:6602:2d86:: with SMTP id k6mr3204801iow.79.1644365284027;
        Tue, 08 Feb 2022 16:08:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyja9pFPPCXhJ6O1Zq/AO3xSYZ5NoOsc6hBQIZAv+1Y7UhbtQH5nWOVMXaoGTRxmmqSDSsGw==
X-Received: by 2002:a05:6602:2d86:: with SMTP id k6mr3204782iow.79.1644365283841;
        Tue, 08 Feb 2022 16:08:03 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c2sm5294501ilh.43.2022.02.08.16.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:08:03 -0800 (PST)
Date:   Tue, 8 Feb 2022 17:08:01 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <jgg@nvidia.com>, <saeedm@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>, <leonro@nvidia.com>,
        <kwankhede@nvidia.com>, <mgurtovoy@nvidia.com>, <maorg@nvidia.com>,
        <ashok.raj@intel.com>, <kevin.tian@intel.com>,
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH V7 mlx5-next 14/15] vfio/mlx5: Use its own PCI
 reset_done error handler
Message-ID: <20220208170801.39dab353.alex.williamson@redhat.com>
In-Reply-To: <20220207172216.206415-15-yishaih@nvidia.com>
References: <20220207172216.206415-1-yishaih@nvidia.com>
        <20220207172216.206415-15-yishaih@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 7 Feb 2022 19:22:15 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> Register its own handler for pci_error_handlers.reset_done and update
> state accordingly.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/main.c | 57 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
> index acd205bcff70..63a889210ef3 100644
> --- a/drivers/vfio/pci/mlx5/main.c
> +++ b/drivers/vfio/pci/mlx5/main.c
> @@ -28,9 +28,12 @@
>  struct mlx5vf_pci_core_device {
>  	struct vfio_pci_core_device core_device;
>  	u8 migrate_cap:1;
> +	u8 deferred_reset:1;
>  	/* protect migration state */
>  	struct mutex state_mutex;
>  	enum vfio_device_mig_state mig_state;
> +	/* protect the reset_done flow */
> +	spinlock_t reset_lock;
>  	u16 vhca_id;
>  	struct mlx5_vf_migration_file *resuming_migf;
>  	struct mlx5_vf_migration_file *saving_migf;
> @@ -437,6 +440,25 @@ mlx5vf_pci_step_device_state_locked(struct mlx5vf_pci_core_device *mvdev,
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +/*
> + * This function is called in all state_mutex unlock cases to
> + * handle a 'deferred_reset' if exists.
> + */
> +static void mlx5vf_state_mutex_unlock(struct mlx5vf_pci_core_device *mvdev)
> +{
> +again:
> +	spin_lock(&mvdev->reset_lock);
> +	if (mvdev->deferred_reset) {
> +		mvdev->deferred_reset = false;
> +		spin_unlock(&mvdev->reset_lock);
> +		mvdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
> +		mlx5vf_disable_fds(mvdev);
> +		goto again;
> +	}
> +	mutex_unlock(&mvdev->state_mutex);
> +	spin_unlock(&mvdev->reset_lock);
> +}
> +
>  static struct file *
>  mlx5vf_pci_set_device_state(struct vfio_device *vdev,
>  			    enum vfio_device_mig_state new_state)
> @@ -465,7 +487,7 @@ mlx5vf_pci_set_device_state(struct vfio_device *vdev,
>  			break;
>  		}
>  	}
> -	mutex_unlock(&mvdev->state_mutex);
> +	mlx5vf_state_mutex_unlock(mvdev);
>  	return res;
>  }
>  
> @@ -477,10 +499,34 @@ static int mlx5vf_pci_get_device_state(struct vfio_device *vdev,
>  
>  	mutex_lock(&mvdev->state_mutex);
>  	*curr_state = mvdev->mig_state;
> -	mutex_unlock(&mvdev->state_mutex);
> +	mlx5vf_state_mutex_unlock(mvdev);
>  	return 0;

I still can't see why it wouldn't be a both fairly trivial to implement
and a usability improvement if the unlock wrapper returned -EAGAIN on a
deferred reset so we could avoid returning a stale state to the user
and a dead fd in the former case.  Thanks,

Alex

