Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D8056BD69
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiGHPpg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiGHPpf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 11:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD21F61D5D
        for <linux-pci@vger.kernel.org>; Fri,  8 Jul 2022 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657295133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApubLHj79sO6KJBa02heFvOEGJZIzBsIBJa7auv83sw=;
        b=GjBGODOeCtAfClQLzCWmewr45Wuz+rhNrEoKY2m1ZJJvl5viP0yXH6cxthopS6by65UiNh
        KRy2wMXJM/tWwY+CKNkqEKoTIWngrgHjGFKPgB6nZP6zBqI6pJnWGdmq+Y64TbiZNbCOHR
        Yui7D8U6TvKY/hjWsSJnoylNGHRhj4k=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-pCCtj2ucN_uSvYg7rYGKSg-1; Fri, 08 Jul 2022 11:45:31 -0400
X-MC-Unique: pCCtj2ucN_uSvYg7rYGKSg-1
Received: by mail-io1-f70.google.com with SMTP id n19-20020a056602341300b0066850b49e09so11422678ioz.12
        for <linux-pci@vger.kernel.org>; Fri, 08 Jul 2022 08:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ApubLHj79sO6KJBa02heFvOEGJZIzBsIBJa7auv83sw=;
        b=Gt3BwKvUG2u4f5QzW5Nn9s4r09Boz9C8rBEEhB5TNli5yV7pHr05VD8+kROczIbgvM
         N7qHLYiXTzabZS8lL4FopSvEgGYBvH152yYGZUNLtoK+fZVvoywLqILdYzhB4YrRn9Y6
         67iuQznHxMkfgf42d6ByXueTmxr+TcFTAeOCf7Gt1L6vIxvV9Z2TXv8jT0539kjp8scA
         Tdh0MF9xfjnakTSbRamlC70KZHPNP9GYZGDoZHYrLtB4fly/K/kSnssfpipKPnTYors/
         muXjWUYLScQMMyBH5BvyTiKp5OU8nYlsCpGVQ2I/yD3h73yZyNjTBI+vcRoQ0tSuORpO
         bPIA==
X-Gm-Message-State: AJIora9BPdRQO8ZKqJtsCIinkMMhZ6qJGAAU+gogmhV31Bzkw50MVrng
        oxiOIV2G5G0yMVbi9SiD/SONzAqIeHKOKa+ZOm8wGhU/pcOcjLxSLuhDjbTnQd/pnpHRehn1YPb
        12woZTiFauCQ/Zq8a5wbS
X-Received: by 2002:a05:6e02:13ea:b0:2dc:3737:5e5e with SMTP id w10-20020a056e0213ea00b002dc37375e5emr2597046ilj.207.1657295130944;
        Fri, 08 Jul 2022 08:45:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uAggma+eBI7WZgGP+IskGEnDGQVgf5MaA5g2UzqNlQebJGcK3vKJgPCRUM63ulS16MDDLEow==
X-Received: by 2002:a05:6e02:13ea:b0:2dc:3737:5e5e with SMTP id w10-20020a056e0213ea00b002dc37375e5emr2597020ilj.207.1657295130568;
        Fri, 08 Jul 2022 08:45:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id j12-20020a6b794c000000b0067275a52928sm19295198iop.9.2022.07.08.08.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:45:30 -0700 (PDT)
Date:   Fri, 8 Jul 2022 09:45:08 -0600
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
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/6] vfio/pci: Mask INTx during runtime suspend
Message-ID: <20220708094508.49ba647f.alex.williamson@redhat.com>
In-Reply-To: <3b143762-d6ce-ac70-59ae-a0c2e66ffc1b@nvidia.com>
References: <20220701110814.7310-1-abhsahu@nvidia.com>
        <20220701110814.7310-2-abhsahu@nvidia.com>
        <20220706093945.30d65ce6.alex.williamson@redhat.com>
        <3b143762-d6ce-ac70-59ae-a0c2e66ffc1b@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 8 Jul 2022 14:51:30 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> On 7/6/2022 9:09 PM, Alex Williamson wrote:
> > On Fri, 1 Jul 2022 16:38:09 +0530
> > Abhishek Sahu <abhsahu@nvidia.com> wrote:
> >  =20
> >> This patch adds INTx handling during runtime suspend/resume.
> >> All the suspend/resume related code for the user to put the device
> >> into the low power state will be added in subsequent patches.
> >>
> >> The INTx are shared among devices. Whenever any INTx interrupt comes =
=20
> >=20
> > "The INTx lines may be shared..."
> >  =20
> >> for the VFIO devices, then vfio_intx_handler() will be called for each
> >> device. Inside vfio_intx_handler(), it calls pci_check_and_mask_intx()=
 =20
> >=20
> > "...device sharing the interrupt."
> >  =20
> >> and checks if the interrupt has been generated for the current device.
> >> Now, if the device is already in the D3cold state, then the config spa=
ce
> >> can not be read. Attempt to read config space in D3cold state can
> >> cause system unresponsiveness in a few systems. To prevent this, mask
> >> INTx in runtime suspend callback and unmask the same in runtime resume
> >> callback. If INTx has been already masked, then no handling is needed
> >> in runtime suspend/resume callbacks. 'pm_intx_masked' tracks this, and
> >> vfio_pci_intx_mask() has been updated to return true if INTx has been
> >> masked inside this function.
> >>
> >> For the runtime suspend which is triggered for the no user of VFIO
> >> device, the is_intx() will return false and these callbacks won't do
> >> anything.
> >>
> >> The MSI/MSI-X are not shared so similar handling should not be
> >> needed for MSI/MSI-X. vfio_msihandler() triggers eventfd_signal()
> >> without doing any device-specific config access. When the user performs
> >> any config access or IOCTL after receiving the eventfd notification,
> >> then the device will be moved to the D0 state first before
> >> servicing any request.
> >>
> >> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> >> ---
> >>  drivers/vfio/pci/vfio_pci_core.c  | 37 +++++++++++++++++++++++++++----
> >>  drivers/vfio/pci/vfio_pci_intrs.c |  6 ++++-
> >>  include/linux/vfio_pci_core.h     |  3 ++-
> >>  3 files changed, 40 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_=
pci_core.c
> >> index a0d69ddaf90d..5948d930449b 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -259,16 +259,45 @@ int vfio_pci_set_power_state(struct vfio_pci_cor=
e_device *vdev, pci_power_t stat
> >>  	return ret;
> >>  }
> >> =20
> >> +#ifdef CONFIG_PM
> >> +static int vfio_pci_core_runtime_suspend(struct device *dev)
> >> +{
> >> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(dev);
> >> +
> >> +	/*
> >> +	 * If INTx is enabled, then mask INTx before going into the runtime
> >> +	 * suspended state and unmask the same in the runtime resume.
> >> +	 * If INTx has already been masked by the user, then
> >> +	 * vfio_pci_intx_mask() will return false and in that case, INTx
> >> +	 * should not be unmasked in the runtime resume.
> >> +	 */
> >> +	vdev->pm_intx_masked =3D (is_intx(vdev) && vfio_pci_intx_mask(vdev));
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int vfio_pci_core_runtime_resume(struct device *dev)
> >> +{
> >> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(dev);
> >> +
> >> +	if (vdev->pm_intx_masked)
> >> +		vfio_pci_intx_unmask(vdev);
> >> +
> >> +	return 0;
> >> +}
> >> +#endif /* CONFIG_PM */
> >> +
> >>  /*
> >> - * The dev_pm_ops needs to be provided to make pci-driver runtime PM =
working,
> >> - * so use structure without any callbacks.
> >> - *
> >>   * The pci-driver core runtime PM routines always save the device sta=
te
> >>   * before going into suspended state. If the device is going into low=
 power
> >>   * state with only with runtime PM ops, then no explicit handling is =
needed
> >>   * for the devices which have NoSoftRst-.
> >>   */
> >> -static const struct dev_pm_ops vfio_pci_core_pm_ops =3D { };
> >> +static const struct dev_pm_ops vfio_pci_core_pm_ops =3D {
> >> +	SET_RUNTIME_PM_OPS(vfio_pci_core_runtime_suspend,
> >> +			   vfio_pci_core_runtime_resume,
> >> +			   NULL)
> >> +};
> >> =20
> >>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
> >>  {
> >> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio=
_pci_intrs.c
> >> index 6069a11fb51a..1a37db99df48 100644
> >> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> >> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> >> @@ -33,10 +33,12 @@ static void vfio_send_intx_eventfd(void *opaque, v=
oid *unused)
> >>  		eventfd_signal(vdev->ctx[0].trigger, 1);
> >>  }
> >> =20
> >> -void vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
> >> +/* Returns true if INTx has been masked by this function. */
> >> +bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
> >>  {
> >>  	struct pci_dev *pdev =3D vdev->pdev;
> >>  	unsigned long flags;
> >> +	bool intx_masked =3D false;
> >> =20
> >>  	spin_lock_irqsave(&vdev->irqlock, flags);
> >> =20
> >> @@ -60,9 +62,11 @@ void vfio_pci_intx_mask(struct vfio_pci_core_device=
 *vdev)
> >>  			disable_irq_nosync(pdev->irq);
> >> =20
> >>  		vdev->ctx[0].masked =3D true;
> >> +		intx_masked =3D true;
> >>  	}
> >> =20
> >>  	spin_unlock_irqrestore(&vdev->irqlock, flags);
> >> +	return intx_masked;
> >>  } =20
> >=20
> >=20
> > There's certainly another path through this function that masks the
> > interrupt, which makes the definition of this return value a bit
> > confusing. =20
>=20
>  For our case we should not hit that path. But we can return the
>  intx_masked true from that path as well to align return value.
>=20
> > Wouldn't it be simpler not to overload the masked flag on
> > the interrupt context like this and instead set a new flag on the vdev
> > under irqlock to indicate the device is unable to generate interrupts.
> > The irq handler would add a test of this flag before any tests that
> > would access the device.  Thanks,
> >=20
> > Alex
> >   =20
>=20
>  We will set this flag inside runtime_suspend callback but the
>  device can be in non-D3cold state (For example, if user has
>  disabled d3cold explicitly by sysfs, the D3cold is not supported in
>  the platform, etc.). Also, in D3cold supported case, the device will
>  be in D0 till the PCI core moves the device into D3cold. In this case,
>  there is possibility that the device can generate an interrupt.
>  If we add check in the IRQ handler, then we won=E2=80=99t check and clear
>  the IRQ status, but the interrupt line will still be asserted
>  which can cause interrupt flooding.
>=20
>  This was the reason for disabling interrupt itself instead of
>  checking flag in the IRQ handler.

Ok, maybe this is largely a clarification of the return value of
vfio_pci_intx_mask().  I think what you're looking for is whether the
context mask was changed, rather than whether the interrupt is masked,
which I think avoids the confusion regarding whether the first branch
should return true or false.  So the variable should be something like
"masked_changed" and the comment changed to "Returns true if the INTx
vfio_pci_irq_ctx.masked value is changed".

Testing is_intx() outside of the irqlock is potentially racy, so do we
need to add the pm-get/put wrappers on ioctls first to avoid the
possibility that pm-suspend can race a SET_IRQS ioctl?  Thanks,

Alex

