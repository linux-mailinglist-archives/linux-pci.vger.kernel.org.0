Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285F642FC91
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 21:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbhJOTyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 15:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242849AbhJOTyt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 15:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634327562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GV9zqP3c6hzIikmWFsKlvAc1/jvxPMYoo5Mql5FA8OI=;
        b=if1s7KQc+FAQhCgfbZ87+P9YKHSaQHBCsF1FgLWGZlLTtUy6a0/oT7ZQm25BJ3EAd7SN1M
        FuumEfcTTwSrgMCweny4umFuIWC8Zn5g3wC5+8E0wTWl+EO/acKrnryyrvFZNW4N0JbDOL
        8esiVMi4l+oE+I0H/vGWHSffqjQFLpM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-cqdywp20OBOUbz1t0FiN6A-1; Fri, 15 Oct 2021 15:52:41 -0400
X-MC-Unique: cqdywp20OBOUbz1t0FiN6A-1
Received: by mail-oi1-f200.google.com with SMTP id q11-20020aca5c0b000000b00299035e02b4so1310295oib.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 12:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GV9zqP3c6hzIikmWFsKlvAc1/jvxPMYoo5Mql5FA8OI=;
        b=Ks18W1sB1/yTODiYszjIiVbmvNeTVP92FwfIJqliHGcoIiBynsU/B/V63xyMjDhwiN
         KBBNqQDL3Hc8VVwbVT4s1xriRo6y1rOWCBhIR9fwhwabz/Ivzadp/L1Q+2OkqtlmFLBW
         UkzUrVDHeRHnREUVKtp7trf5UFulCxMUa4dKOS2lQxkv/z+3cwrXvDqCDmzuOqL4iJze
         BHR6yGqVQTiXGq1t2b6uqNX9DsgQ/QuUt90hPF2xHUebCrNEAYWeOeQV6gnjcwb7/pJN
         k6VBcX2o4uvcWz3mOIScBd30fhiRzvmJMwhB+5jYPNqCoCBLc3kS4A9rsMuBY6DM7uQY
         CT+g==
X-Gm-Message-State: AOAM5324zsadeawYYZTcyQNiA6UQcbnNuzi1T0lOH9KkbSrmuawggpdD
        6GXw70bJe0PHGm5r3X6RE/73dlOkPP0/QnEtXJ/427hp7hYrcro3EbE8RVgBCDaZySKivNO9na9
        9NUDAmk5YNIAM7+WbXyDx
X-Received: by 2002:a4a:9510:: with SMTP id m16mr10523664ooi.14.1634327560581;
        Fri, 15 Oct 2021 12:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0A9XtIVqnCAaW4W4omTD8XF9Y0bTUB+rr9daDcGFalROkSyZ+BzVr4su0z7BE3/vMzJaExg==
X-Received: by 2002:a4a:9510:: with SMTP id m16mr10523649ooi.14.1634327560396;
        Fri, 15 Oct 2021 12:52:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id bp21sm1215602oib.31.2021.10.15.12.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 12:52:39 -0700 (PDT)
Date:   Fri, 15 Oct 2021 13:52:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <jgg@nvidia.com>, <saeedm@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>, <leonro@nvidia.com>,
        <kwankhede@nvidia.com>, <mgurtovoy@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 mlx5-next 12/13] vfio/pci: Add infrastructure to let
 vfio_pci_core drivers trap device RESET
Message-ID: <20211015135237.759fe688.alex.williamson@redhat.com>
In-Reply-To: <20211013094707.163054-13-yishaih@nvidia.com>
References: <20211013094707.163054-1-yishaih@nvidia.com>
        <20211013094707.163054-13-yishaih@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Oct 2021 12:47:06 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> Add infrastructure to let vfio_pci_core drivers trap device RESET.
> 
> The motivation for this is to let the underlay driver be aware that
> reset was done and set its internal state accordingly.

I think the intention of the uAPI here is that the migration error
state is exited specifically via the reset ioctl.  Maybe that should be
made more clear, but variant drivers can already wrap the core ioctl
for the purpose of determining that mechanism of reset has occurred.
Thanks,

Alex

 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c |  8 ++++++--
>  drivers/vfio/pci/vfio_pci_core.c   |  2 ++
>  include/linux/vfio_pci_core.h      | 10 ++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 6e58b4bf7a60..002198376f43 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -859,7 +859,9 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  
>  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -			pci_try_reset_function(vdev->pdev);
> +			ret = pci_try_reset_function(vdev->pdev);
> +			if (!ret && vdev->ops && vdev->ops->reset_done)
> +				vdev->ops->reset_done(vdev);
>  			up_write(&vdev->memory_lock);
>  		}
>  	}
> @@ -941,7 +943,9 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  
>  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
> -			pci_try_reset_function(vdev->pdev);
> +			ret = pci_try_reset_function(vdev->pdev);
> +			if (!ret && vdev->ops && vdev->ops->reset_done)
> +				vdev->ops->reset_done(vdev);
>  			up_write(&vdev->memory_lock);
>  		}
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index e581a327f90d..d2497a8ed7f1 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -923,6 +923,8 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
>  
>  		vfio_pci_zap_and_down_write_memory_lock(vdev);
>  		ret = pci_try_reset_function(vdev->pdev);
> +		if (!ret && vdev->ops && vdev->ops->reset_done)
> +			vdev->ops->reset_done(vdev);
>  		up_write(&vdev->memory_lock);
>  
>  		return ret;
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index ef9a44b6cf5d..6ccf5824f098 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -95,6 +95,15 @@ struct vfio_pci_mmap_vma {
>  	struct list_head	vma_next;
>  };
>  
> +/**
> + * struct vfio_pci_core_device_ops - VFIO PCI driver device callbacks
> + *
> + * @reset_done: Called when the device was reset
> + */
> +struct vfio_pci_core_device_ops {
> +	void	(*reset_done)(struct vfio_pci_core_device *vdev);
> +};
> +
>  struct vfio_pci_core_device {
>  	struct vfio_device	vdev;
>  	struct pci_dev		*pdev;
> @@ -137,6 +146,7 @@ struct vfio_pci_core_device {
>  	struct mutex		vma_lock;
>  	struct list_head	vma_list;
>  	struct rw_semaphore	memory_lock;
> +	const struct vfio_pci_core_device_ops *ops;
>  };
>  
>  #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)

