Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6357D6F7
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 00:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiGUWfB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiGUWe5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 18:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22C2A7FE76
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658442895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQio+55hxj6+t1WAQxWAmFxvlBH4CtIfnR9T5vDPgcw=;
        b=IqTfNkm1qchlMBWPtJVW36B4705JY8BzWNkpP2SEwysToIzp2OV65IqafLBMSSYEKanlH+
        cbpefx7eZ5cJ4KCwZpkEJoVnEo5TRy2OowuyqcH2bv7BiJJjz1+joNgSg8gyy8z6f0x0ZO
        iT7xwhGknaCa6Z3EG3jSoKw2qWC3AI4=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-N9ALQMNwPVWrZlvfb-SjBw-1; Thu, 21 Jul 2022 18:34:54 -0400
X-MC-Unique: N9ALQMNwPVWrZlvfb-SjBw-1
Received: by mail-il1-f198.google.com with SMTP id f11-20020a056e02168b00b002dc8abbf7f9so1617773ila.12
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 15:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bQio+55hxj6+t1WAQxWAmFxvlBH4CtIfnR9T5vDPgcw=;
        b=WCVunNNz0eeQBH9/TOyDBikSPzKwM0/+WzT2KB45F2MD6zS7tLtpbxghS3w/yxQnsY
         siMoaG+fjnwZv2WRLtKKB9JvgcHVmi/AtuY91C/dHu1m/icVEOEN9AeeIHS2DX7qTmEz
         aNdUcnPeBL2VxX+BrJ+rgkVFh5PWsufDMz8TBO69x11IGhNRbPijqvi1rUyv3R5pV4ct
         Svg0OXhdefxq8igM321sOH/WK6ZUCvyRDUWekFkxE7NhHZq614ZXCrhlQZ/WIz6zGqFs
         1eCDGrxXnO9GB4xSCFOleg4OJHmPoQqSuMxMv/XBwII+BughuO+k5EGNLlQCGtEKfzFx
         kcow==
X-Gm-Message-State: AJIora/o0ANYModykhST5eXyRtrTQ/Je4IVg9oqONzEeBSEFp3SrgQa9
        Qu2FAzN9261grXvY9JDtx7II9/u5UNjMFJ8hvHTQLueQzSP6bPG6P0sVwgoOD3wlKV9jHik210u
        4J1ieOEZDmn+mvrHtEsJL
X-Received: by 2002:a05:6e02:2168:b0:2dc:7313:c62e with SMTP id s8-20020a056e02216800b002dc7313c62emr250454ilv.220.1658442893507;
        Thu, 21 Jul 2022 15:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulehtgJhid5KOUip5hnDSLWdR5VEHckEdwptR7hMFLjpLBbJ0zd2Oko5/1xv6SQrR78MEm7A==
X-Received: by 2002:a05:6e02:2168:b0:2dc:7313:c62e with SMTP id s8-20020a056e02216800b002dc7313c62emr250442ilv.220.1658442893292;
        Thu, 21 Jul 2022 15:34:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m30-20020a026a5e000000b0034149185a92sm1297066jaf.148.2022.07.21.15.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:34:52 -0700 (PDT)
Date:   Thu, 21 Jul 2022 16:34:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] vfio: Increment the runtime PM usage count
 during IOCTL call
Message-ID: <20220721163451.67cd9be8.alex.williamson@redhat.com>
In-Reply-To: <20220719121523.21396-3-abhsahu@nvidia.com>
References: <20220719121523.21396-1-abhsahu@nvidia.com>
        <20220719121523.21396-3-abhsahu@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Jul 2022 17:45:20 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> The vfio-pci based drivers will have runtime power management
> support where the user can put the device into the low power state
> and then PCI devices can go into the D3cold state. If the device is
> in the low power state and the user issues any IOCTL, then the
> device should be moved out of the low power state first. Once
> the IOCTL is serviced, then it can go into the low power state again.
> The runtime PM framework manages this with help of usage count.
> 
> One option was to add the runtime PM related API's inside vfio-pci
> driver but some IOCTL (like VFIO_DEVICE_FEATURE) can follow a
> different path and more IOCTL can be added in the future. Also, the
> runtime PM will be added for vfio-pci based drivers variant currently,
> but the other VFIO based drivers can use the same in the
> future. So, this patch adds the runtime calls runtime-related API in
> the top-level IOCTL function itself.
> 
> For the VFIO drivers which do not have runtime power management
> support currently, the runtime PM API's won't be invoked. Only for
> vfio-pci based drivers currently, the runtime PM API's will be invoked
> to increment and decrement the usage count. In the vfio-pci drivers also,
> the variant drivers can opt-out by incrementing the usage count during
> device-open. The pm_runtime_resume_and_get() checks the device
> current status and will return early if the device is already in the
> ACTIVE state.
> 
> Taking this usage count incremented while servicing IOCTL will make
> sure that the user won't put the device into the low power state when any
> other IOCTL is being serviced in parallel. Let's consider the
> following scenario:
> 
>  1. Some other IOCTL is called.
>  2. The user has opened another device instance and called the IOCTL for
>     low power entry.
>  3. The low power entry IOCTL moves the device into the low power state.
>  4. The other IOCTL finishes.
> 
> If we don't keep the usage count incremented then the device
> access will happen between step 3 and 4 while the device has already
> gone into the low power state.
> 
> The pm_runtime_resume_and_get() will be the first call so its error
> should not be propagated to user space directly. For example, if
> pm_runtime_resume_and_get() can return -EINVAL for the cases where the
> user has passed the correct argument. So the
> pm_runtime_resume_and_get() errors have been masked behind -EIO.
> 
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index bd84ca7c5e35..1d005a0a9d3d 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -32,6 +32,7 @@
>  #include <linux/vfio.h>
>  #include <linux/wait.h>
>  #include <linux/sched/signal.h>
> +#include <linux/pm_runtime.h>
>  #include "vfio.h"
>  
>  #define DRIVER_VERSION	"0.3"
> @@ -1335,6 +1336,39 @@ static const struct file_operations vfio_group_fops = {
>  	.release	= vfio_group_fops_release,
>  };
>  
> +/*
> + * Wrapper around pm_runtime_resume_and_get().
> + * Return error code on failure or 0 on success.
> + */
> +static inline int vfio_device_pm_runtime_get(struct vfio_device *device)
> +{
> +	struct device *dev = device->dev;
> +
> +	if (dev->driver && dev->driver->pm) {
> +		int ret;
> +
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {

Nit, pm_runtime_resume_and_get() cannot return a positive value, it's
either zero or -errno, so we could just test (ret).  Thanks,

Alex

> +			dev_info_ratelimited(dev,
> +				"vfio: runtime resume failed %d\n", ret);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Wrapper around pm_runtime_put().
> + */
> +static inline void vfio_device_pm_runtime_put(struct vfio_device *device)
> +{
> +	struct device *dev = device->dev;
> +
> +	if (dev->driver && dev->driver->pm)
> +		pm_runtime_put(dev);
> +}
> +
>  /*
>   * VFIO Device fd
>   */
> @@ -1649,15 +1683,27 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>  				       unsigned int cmd, unsigned long arg)
>  {
>  	struct vfio_device *device = filep->private_data;
> +	int ret;
> +
> +	ret = vfio_device_pm_runtime_get(device);
> +	if (ret)
> +		return ret;
>  
>  	switch (cmd) {
>  	case VFIO_DEVICE_FEATURE:
> -		return vfio_ioctl_device_feature(device, (void __user *)arg);
> +		ret = vfio_ioctl_device_feature(device, (void __user *)arg);
> +		break;
> +
>  	default:
>  		if (unlikely(!device->ops->ioctl))
> -			return -EINVAL;
> -		return device->ops->ioctl(device, cmd, arg);
> +			ret = -EINVAL;
> +		else
> +			ret = device->ops->ioctl(device, cmd, arg);
> +		break;
>  	}
> +
> +	vfio_device_pm_runtime_put(device);
> +	return ret;
>  }
>  
>  static ssize_t vfio_device_fops_read(struct file *filep, char __user *buf,

