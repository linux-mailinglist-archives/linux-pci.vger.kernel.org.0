Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEDC568E3D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiGFPsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 11:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiGFPsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 11:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2A922BB30
        for <linux-pci@vger.kernel.org>; Wed,  6 Jul 2022 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657122054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOBngKK5ObcYp0aTM/eJADmU4zkvY2wG1pNNZ2Kjb4Y=;
        b=a10f16dFXoeNw05eGRnG9kMKSE/tsujHuODJjrLuZsSf/ULwvhGE3ZZa3CCfKAQMVbUw6E
        fiXhWMXcWYIlEEzPZTeUdJyUG5ar8rfCBpSRGi92Z1f7X1RBjgWgOgZ5tmsUJg7Sz/2ca4
        CvqUIJVzbls/KRaOorqNAt2HhDs3/Ok=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-Aef06cIvPUWpvPgupK22hQ-1; Wed, 06 Jul 2022 11:40:51 -0400
X-MC-Unique: Aef06cIvPUWpvPgupK22hQ-1
Received: by mail-il1-f200.google.com with SMTP id d3-20020a056e02214300b002dc0d8abab3so5121447ilv.20
        for <linux-pci@vger.kernel.org>; Wed, 06 Jul 2022 08:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hOBngKK5ObcYp0aTM/eJADmU4zkvY2wG1pNNZ2Kjb4Y=;
        b=RbHsVpbOdVfY93aH4t8Vv9VA+oQ1uoh5R43dZfIYPbQvMwc0lsPMhgNM/8q8+ckm89
         ZKLZn4hVGjdXxvh+hLnb6VRa2GUo7VfwuoMDTn6VPHofzLVwn7nsFfDWiEYowG473Lhi
         GHJpZMeiXFqwFvUOyJwCGfbmNEx8OulaZ6j30uOrKR62srUuCGtkmoq+t0vCtVbzzlfF
         gdZVo+jWqz3hyuxai1rU/zwGGmpAv5fGs3sLxG8QliVUVqCpQi5jS7fVEXHrltgTnN6V
         DeWYF55BBAAiDC8drI3aENwl6IbDyd22npi7yzQt9zFlyazDiHQxd1zlIPmuDyKwWPIC
         /2Hw==
X-Gm-Message-State: AJIora8ODli3nADync3pkUHT0eZ3h/Nl4NIXeYRr0DJaZVvlVbrdx3eK
        qpMijgLNrkzLk1qw9LYuzSWbz1EW9AEbIc9GQW1Tob87NBdNJSl7Dh8By7ygpg1aL5fnpvOdHi7
        OEfM54s2yDqzFK14jBQda
X-Received: by 2002:a05:6638:2651:b0:33e:b468:ece9 with SMTP id n17-20020a056638265100b0033eb468ece9mr15106871jat.85.1657122050738;
        Wed, 06 Jul 2022 08:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tGVw+lSRAIoA4x4g8L15GS3fsLZBAb9mQaFyjvIkhW6p55QeD0DJfDTS201tOSes4EYKjdeg==
X-Received: by 2002:a05:6638:2651:b0:33e:b468:ece9 with SMTP id n17-20020a056638265100b0033eb468ece9mr15106847jat.85.1657122050465;
        Wed, 06 Jul 2022 08:40:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d12-20020a0566022bec00b0066958ec56d9sm17003884ioy.40.2022.07.06.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:40:49 -0700 (PDT)
Date:   Wed, 6 Jul 2022 09:39:45 -0600
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
Subject: Re: [PATCH v4 1/6] vfio/pci: Mask INTx during runtime suspend
Message-ID: <20220706093945.30d65ce6.alex.williamson@redhat.com>
In-Reply-To: <20220701110814.7310-2-abhsahu@nvidia.com>
References: <20220701110814.7310-1-abhsahu@nvidia.com>
        <20220701110814.7310-2-abhsahu@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 1 Jul 2022 16:38:09 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> This patch adds INTx handling during runtime suspend/resume.
> All the suspend/resume related code for the user to put the device
> into the low power state will be added in subsequent patches.
> 
> The INTx are shared among devices. Whenever any INTx interrupt comes

"The INTx lines may be shared..."

> for the VFIO devices, then vfio_intx_handler() will be called for each
> device. Inside vfio_intx_handler(), it calls pci_check_and_mask_intx()

"...device sharing the interrupt."

> and checks if the interrupt has been generated for the current device.
> Now, if the device is already in the D3cold state, then the config space
> can not be read. Attempt to read config space in D3cold state can
> cause system unresponsiveness in a few systems. To prevent this, mask
> INTx in runtime suspend callback and unmask the same in runtime resume
> callback. If INTx has been already masked, then no handling is needed
> in runtime suspend/resume callbacks. 'pm_intx_masked' tracks this, and
> vfio_pci_intx_mask() has been updated to return true if INTx has been
> masked inside this function.
> 
> For the runtime suspend which is triggered for the no user of VFIO
> device, the is_intx() will return false and these callbacks won't do
> anything.
> 
> The MSI/MSI-X are not shared so similar handling should not be
> needed for MSI/MSI-X. vfio_msihandler() triggers eventfd_signal()
> without doing any device-specific config access. When the user performs
> any config access or IOCTL after receiving the eventfd notification,
> then the device will be moved to the D0 state first before
> servicing any request.
> 
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c  | 37 +++++++++++++++++++++++++++----
>  drivers/vfio/pci/vfio_pci_intrs.c |  6 ++++-
>  include/linux/vfio_pci_core.h     |  3 ++-
>  3 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a0d69ddaf90d..5948d930449b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -259,16 +259,45 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM
> +static int vfio_pci_core_runtime_suspend(struct device *dev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
> +
> +	/*
> +	 * If INTx is enabled, then mask INTx before going into the runtime
> +	 * suspended state and unmask the same in the runtime resume.
> +	 * If INTx has already been masked by the user, then
> +	 * vfio_pci_intx_mask() will return false and in that case, INTx
> +	 * should not be unmasked in the runtime resume.
> +	 */
> +	vdev->pm_intx_masked = (is_intx(vdev) && vfio_pci_intx_mask(vdev));
> +
> +	return 0;
> +}
> +
> +static int vfio_pci_core_runtime_resume(struct device *dev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
> +
> +	if (vdev->pm_intx_masked)
> +		vfio_pci_intx_unmask(vdev);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM */
> +
>  /*
> - * The dev_pm_ops needs to be provided to make pci-driver runtime PM working,
> - * so use structure without any callbacks.
> - *
>   * The pci-driver core runtime PM routines always save the device state
>   * before going into suspended state. If the device is going into low power
>   * state with only with runtime PM ops, then no explicit handling is needed
>   * for the devices which have NoSoftRst-.
>   */
> -static const struct dev_pm_ops vfio_pci_core_pm_ops = { };
> +static const struct dev_pm_ops vfio_pci_core_pm_ops = {
> +	SET_RUNTIME_PM_OPS(vfio_pci_core_runtime_suspend,
> +			   vfio_pci_core_runtime_resume,
> +			   NULL)
> +};
>  
>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  {
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 6069a11fb51a..1a37db99df48 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -33,10 +33,12 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
>  		eventfd_signal(vdev->ctx[0].trigger, 1);
>  }
>  
> -void vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
> +/* Returns true if INTx has been masked by this function. */
> +bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  	unsigned long flags;
> +	bool intx_masked = false;
>  
>  	spin_lock_irqsave(&vdev->irqlock, flags);
>  
> @@ -60,9 +62,11 @@ void vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
>  			disable_irq_nosync(pdev->irq);
>  
>  		vdev->ctx[0].masked = true;
> +		intx_masked = true;
>  	}
>  
>  	spin_unlock_irqrestore(&vdev->irqlock, flags);
> +	return intx_masked;
>  }


There's certainly another path through this function that masks the
interrupt, which makes the definition of this return value a bit
confusing.  Wouldn't it be simpler not to overload the masked flag on
the interrupt context like this and instead set a new flag on the vdev
under irqlock to indicate the device is unable to generate interrupts.
The irq handler would add a test of this flag before any tests that
would access the device.  Thanks,

Alex
 
>  /*
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 23c176d4b073..cdfd328ba6b1 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -124,6 +124,7 @@ struct vfio_pci_core_device {
>  	bool			needs_reset;
>  	bool			nointx;
>  	bool			needs_pm_restore;
> +	bool			pm_intx_masked;
>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;
> @@ -147,7 +148,7 @@ struct vfio_pci_core_device {
>  #define is_irq_none(vdev) (!(is_intx(vdev) || is_msi(vdev) || is_msix(vdev)))
>  #define irq_is(vdev, type) (vdev->irq_type == type)
>  
> -extern void vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
> +extern bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
>  extern void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
>  
>  extern int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev,

