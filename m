Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C67392127
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhEZTyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 15:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhEZTyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 15:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622058759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i3vKmjSZ7IkKYL8yuzFSZP5zA3ZWNm8a674UK7ccWA=;
        b=PeaCW3LnhxugHwzChLzZhXlN1mAqlZpo3yhSEDrYMAQlvX4us29CufByy0DAkXDuuYKran
        kz1rkqYl5T6f5IPf4tdoiLWWQoR2LyfdMaJFhAGYctSsF8W1lu+hI13n7YstzE8zgfJPso
        60BptvsEJHQRkvKGpQ0oES/TRNUbEPk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-8lnhivh5NFmJZfBMwmDFBA-1; Wed, 26 May 2021 15:52:36 -0400
X-MC-Unique: 8lnhivh5NFmJZfBMwmDFBA-1
Received: by mail-ot1-f72.google.com with SMTP id f89-20020a9d2c620000b0290280d753a255so1258161otb.2
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 12:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2i3vKmjSZ7IkKYL8yuzFSZP5zA3ZWNm8a674UK7ccWA=;
        b=FRzrJe8s1oIHyl0+q2AKK+DrWhbWElIN1PZJtwri/kKm+1ZSfkXyQMuhMA+7VAzCAK
         +fOSTApaHX4iZCu0teaC9puhWKt0+Hp35MRFaVOafo0X9N2TlR8HdxnQ/Sj7f/p9uuEc
         2MZ0i1kfp1WmvcJehVlvb+Vtgm5Db1/UKIyPC3Wv2iOOGKEi/n22EIP83gHPdGgRYx01
         KCz/fhR5gGDuTg3hglV3wesI5ozhjA8QmsCjiYT0Oazi3nvj/sn8ftkadnJSfX3ZBTrw
         19MNbIXpikBjlj4kFL5kKgr0In13RNSI4xhUlOsB04w4uhyCg3c8QkMH2KDumF7RkYrw
         BHBQ==
X-Gm-Message-State: AOAM533p3Qw7D3B606MvZk1TseJvyHwx3u/BrO3az4lFO77qeKa39C76
        OUml6nrNBSE/E2AcPt/r6dYZegsicJwlRwTpT2rhtMt+QuyLt+kfFrbfklXt1/S2UX7Quxp4szn
        lfznhVeh1idGMPLyTWQ0l
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr3065119oie.7.1622058755338;
        Wed, 26 May 2021 12:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWgPl17Dz7Zhtsgc67ifNpM9fKxXAlWIV7fGwTDvqEQyaY/7+zXAmC1snZaHONQFn6fm8/MQ==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr3065108oie.7.1622058754909;
        Wed, 26 May 2021 12:52:34 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id r10sm42316oic.4.2021.05.26.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 12:52:34 -0700 (PDT)
Date:   Wed, 26 May 2021 13:52:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3 7/7] PCI: Change the type of probe argument in reset
 functions
Message-ID: <20210526135230.2ecd94d3.alex.williamson@redhat.com>
In-Reply-To: <20210526101403.108721-8-ameynarkhede03@gmail.com>
References: <20210526101403.108721-1-ameynarkhede03@gmail.com>
        <20210526101403.108721-8-ameynarkhede03@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 26 May 2021 15:44:03 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> Introduce a new enum pci_reset_mode_t to make the context
> of probe argument in reset functions clear and the code
> easier to read.
> Change the type of probe argument in functions which implement
> reset methods from int to pci_reset_mode_t to make the intent clear.
> Add a new line in return statement of pci_reset_bus_function.
>=20
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c    |  2 +-
>  .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
>  drivers/pci/hotplug/pciehp.h                  |  2 +-
>  drivers/pci/hotplug/pciehp_hpc.c              |  7 +-
>  drivers/pci/pci.c                             | 85 +++++++++++++------
>  drivers/pci/pci.h                             |  8 +-
>  drivers/pci/pcie/aer.c                        |  2 +-
>  drivers/pci/quirks.c                          | 46 +++++++---
>  include/linux/pci.h                           |  8 +-
>  include/linux/pci_hotplug.h                   |  2 +-
>  10 files changed, 112 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/=
cavium/nitrox/nitrox_main.c
> index 15d6c8452..f97fa8e99 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -306,7 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
> =20
> -	pcie_reset_flr(pdev, 0);
> +	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
> =20
>  	pci_restore_state(pdev);
> =20
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers=
/net/ethernet/cavium/liquidio/lio_vf_main.c
> index 336d149ee..6e666be69 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
> @@ -526,7 +526,7 @@ static void octeon_destroy_resources(struct octeon_de=
vice *oct)
>  			oct->irq_name_storage =3D NULL;
>  		}
>  		/* Soft reset the octeon device before exiting */
> -		if (!pcie_reset_flr(oct->pci_dev, 1))
> +		if (!pcie_reset_flr(oct->pci_dev, PCI_RESET_PROBE))
>  			octeon_pci_flr(oct);
>  		else
>  			cn23xx_vf_ask_pf_to_do_flr(oct);
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 4fd200d8b..7cbc30dd3 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -181,7 +181,7 @@ void pciehp_release_ctrl(struct controller *ctrl);
> =20
>  int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
>  int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
> -int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe);
> +int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, pci_reset_mode_=
t probe);
>  int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *s=
tatus);
>  int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 stat=
us);
>  int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *sta=
tus);
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index fb3840e22..31f75f5f2 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -834,14 +834,17 @@ void pcie_disable_interrupt(struct controller *ctrl)
>   * momentarily, if we see that they could interfere. Also, clear any spu=
rious
>   * events after.
>   */
> -int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
> +int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, enum pci_reset_=
mode probe)

This should use your typedef, pci_reset_mode_t.  Is "probe" still the
best name for this arg?  The enum name suggests a "mode", the MAX entry
suggests an "action", "probe" is but one mode/action.

>  {
>  	struct controller *ctrl =3D to_ctrl(hotplug_slot);
>  	struct pci_dev *pdev =3D ctrl_dev(ctrl);
>  	u16 stat_mask =3D 0, ctrl_mask =3D 0;
>  	int rc;
> =20
> -	if (probe)
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	down_write(&ctrl->reset_lock);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1d859b100..e731dab9f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4616,10 +4616,13 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>   *
>   * Initiate a function level reset on @dev.
>   */
> -int pcie_reset_flr(struct pci_dev *dev, int probe)
> +int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t probe)
>  {
>  	u32 cap;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
> =20
> @@ -4627,18 +4630,21 @@ int pcie_reset_flr(struct pci_dev *dev, int probe)
>  	if (!(cap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
> =20
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	return pcie_flr(dev);
>  }
>  EXPORT_SYMBOL_GPL(pcie_reset_flr);
> =20
> -static int pci_af_flr(struct pci_dev *dev, int probe)
> +static int pci_af_flr(struct pci_dev *dev, pci_reset_mode_t probe)
>  {
>  	int pos;
>  	u8 cap;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	pos =3D pci_find_capability(dev, PCI_CAP_ID_AF);
>  	if (!pos)
>  		return -ENOTTY;
> @@ -4650,7 +4656,7 @@ static int pci_af_flr(struct pci_dev *dev, int prob=
e)
>  	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
>  		return -ENOTTY;
> =20
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	/*
> @@ -4693,10 +4699,13 @@ static int pci_af_flr(struct pci_dev *dev, int pr=
obe)
>   * by default (i.e. unless the @dev's d3hot_delay field has a different =
value).
>   * Moreover, only devices in D0 can be reset by this function.
>   */
> -static int pci_pm_reset(struct pci_dev *dev, int probe)
> +static int pci_pm_reset(struct pci_dev *dev, pci_reset_mode_t probe)
>  {
>  	u16 csr;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
>  		return -ENOTTY;
> =20
> @@ -4704,7 +4713,7 @@ static int pci_pm_reset(struct pci_dev *dev, int pr=
obe)
>  	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
>  		return -ENOTTY;
> =20
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	if (dev->current_state !=3D PCI_D0)
> @@ -4953,10 +4962,13 @@ int pci_bridge_secondary_bus_reset(struct pci_dev=
 *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
> =20
> -static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
> +static int pci_parent_bus_reset(struct pci_dev *dev, pci_reset_mode_t pr=
obe)
>  {
>  	struct pci_dev *pdev;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
>  	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>  		return -ENOTTY;
> @@ -4965,16 +4977,19 @@ static int pci_parent_bus_reset(struct pci_dev *d=
ev, int probe)
>  		if (pdev !=3D dev)
>  			return -ENOTTY;
> =20
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	return pci_bridge_secondary_bus_reset(dev->bus->self);
>  }
> =20
> -static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int prob=
e)
> +static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, pci_rese=
t_mode_t probe)
>  {
>  	int rc =3D -ENOTTY;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (!hotplug || !try_module_get(hotplug->owner))
>  		return rc;
> =20
> @@ -4986,8 +5001,11 @@ static int pci_reset_hotplug_slot(struct hotplug_s=
lot *hotplug, int probe)
>  	return rc;
>  }
> =20
> -static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
> +static int pci_dev_reset_slot_function(struct pci_dev *dev, pci_reset_mo=
de_t probe)
>  {
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (dev->multifunction || dev->subordinate || !dev->slot ||
>  	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>  		return -ENOTTY;
> @@ -4995,12 +5013,16 @@ static int pci_dev_reset_slot_function(struct pci=
_dev *dev, int probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
> =20
> -static int pci_reset_bus_function(struct pci_dev *dev, int probe)
> +static int pci_reset_bus_function(struct pci_dev *dev, pci_reset_mode_t =
probe)
>  {
>  	int rc =3D pci_dev_reset_slot_function(dev, probe);
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> +
>  	return pci_parent_bus_reset(dev, probe);
>  }
> =20
> @@ -5081,17 +5103,20 @@ static void pci_dev_restore(struct pci_dev *dev)
>   * @dev: device to reset
>   * @probe: check if _RST method is included in the acpi_device context.
>   */
> -static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
> +static int pci_dev_acpi_reset(struct pci_dev *dev, pci_reset_mode_t prob=
e)
>  {
>  #ifdef CONFIG_ACPI
>  	acpi_handle handle =3D ACPI_HANDLE(&dev->dev);
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	/* Return -ENOTTY if _RST method is not included in the dev context */
>  	if (!handle || !acpi_has_method(handle, "_RST"))
>  		return -ENOTTY;
> =20
>  	/* Return 0 for probe phase indicating that we can reset this device */
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	/* Invoke _RST() method to perform a function level reset */
> @@ -5157,7 +5182,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  				 * other error, we're also finished: this indicates that further
>  				 * reset mechanisms might be broken on the device.
>  				 */
> -				rc =3D pci_reset_fn_methods[i].reset_fn(dev, 0);
> +				rc =3D pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_DO_RESET);
>  				if (rc !=3D -ENOTTY)
>  					return rc;
>  				break;
> @@ -5193,7 +5218,7 @@ void pci_init_reset_methods(struct pci_dev *dev)
>  	might_sleep();
> =20
>  	for (i =3D 0; i < PCI_RESET_METHODS_NUM; i++) {
> -		rc =3D pci_reset_fn_methods[i].reset_fn(dev, 1);
> +		rc =3D pci_reset_fn_methods[i].reset_fn(dev, PCI_RESET_PROBE);
>  		if (!rc)
>  			reset_methods[i] =3D prio--;
>  		else if (rc !=3D -ENOTTY)
> @@ -5509,21 +5534,24 @@ static void pci_slot_restore_locked(struct pci_sl=
ot *slot)
>  	}
>  }
> =20
> -static int pci_slot_reset(struct pci_slot *slot, int probe)
> +static int pci_slot_reset(struct pci_slot *slot, pci_reset_mode_t probe)
>  {
>  	int rc;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (!slot || !pci_slot_resetable(slot))
>  		return -ENOTTY;
> =20
> -	if (!probe)
> +	if (probe =3D=3D PCI_RESET_DO_RESET)
>  		pci_slot_lock(slot);
> =20
>  	might_sleep();
> =20
>  	rc =3D pci_reset_hotplug_slot(slot->hotplug, probe);
> =20
> -	if (!probe)
> +	if (probe =3D=3D PCI_RESET_DO_RESET)
>  		pci_slot_unlock(slot);
> =20
>  	return rc;
> @@ -5537,7 +5565,7 @@ static int pci_slot_reset(struct pci_slot *slot, in=
t probe)
>   */
>  int pci_probe_reset_slot(struct pci_slot *slot)
>  {
> -	return pci_slot_reset(slot, 1);
> +	return pci_slot_reset(slot, PCI_RESET_PROBE);
>  }
>  EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
> =20
> @@ -5560,14 +5588,14 @@ static int __pci_reset_slot(struct pci_slot *slot)
>  {
>  	int rc;
> =20
> -	rc =3D pci_slot_reset(slot, 1);
> +	rc =3D pci_slot_reset(slot, PCI_RESET_PROBE);
>  	if (rc)
>  		return rc;
> =20
>  	if (pci_slot_trylock(slot)) {
>  		pci_slot_save_and_disable_locked(slot);
>  		might_sleep();
> -		rc =3D pci_reset_hotplug_slot(slot->hotplug, 0);
> +		rc =3D pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
>  		pci_slot_restore_locked(slot);
>  		pci_slot_unlock(slot);
>  	} else
> @@ -5576,14 +5604,17 @@ static int __pci_reset_slot(struct pci_slot *slot)
>  	return rc;
>  }
> =20
> -static int pci_bus_reset(struct pci_bus *bus, int probe)
> +static int pci_bus_reset(struct pci_bus *bus, pci_reset_mode_t probe)
>  {
>  	int ret;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (!bus->self || !pci_bus_resetable(bus))
>  		return -ENOTTY;
> =20
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	pci_bus_lock(bus);
> @@ -5622,14 +5653,14 @@ int pci_bus_error_reset(struct pci_dev *bridge)
>  			goto bus_reset;
> =20
>  	list_for_each_entry(slot, &bus->slots, list)
> -		if (pci_slot_reset(slot, 0))
> +		if (pci_slot_reset(slot, PCI_RESET_DO_RESET))
>  			goto bus_reset;
> =20
>  	mutex_unlock(&pci_slot_mutex);
>  	return 0;
>  bus_reset:
>  	mutex_unlock(&pci_slot_mutex);
> -	return pci_bus_reset(bridge->subordinate, 0);
> +	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
>  }
> =20
>  /**
> @@ -5640,7 +5671,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
>   */
>  int pci_probe_reset_bus(struct pci_bus *bus)
>  {
> -	return pci_bus_reset(bus, 1);
> +	return pci_bus_reset(bus, PCI_RESET_PROBE);
>  }
>  EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
> =20
> @@ -5654,7 +5685,7 @@ static int __pci_reset_bus(struct pci_bus *bus)
>  {
>  	int rc;
> =20
> -	rc =3D pci_bus_reset(bus, 1);
> +	rc =3D pci_bus_reset(bus, PCI_RESET_PROBE);
>  	if (rc)
>  		return rc;
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1b3ba3116..f05db86af 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -609,19 +609,19 @@ static inline int pci_enable_ptm(struct pci_dev *de=
v, u8 *granularity)
>  struct pci_dev_reset_methods {
>  	u16 vendor;
>  	u16 device;
> -	int (*reset)(struct pci_dev *dev, int probe);
> +	int (*reset)(struct pci_dev *dev, pci_reset_mode_t probe);
>  };
> =20
>  struct pci_reset_fn_method {
> -	int (*reset_fn)(struct pci_dev *, int probe);
> +	int (*reset_fn)(struct pci_dev *, pci_reset_mode_t probe);
>  	char *name;
>  };
> =20
>  extern const struct pci_reset_fn_method pci_reset_fn_methods[];
>  #ifdef CONFIG_PCI_QUIRKS
> -int pci_dev_specific_reset(struct pci_dev *dev, int probe);
> +int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t probe);
>  #else
> -static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
> +static inline int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_=
mode_t probe)
>  {
>  	return -ENOTTY;
>  }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f4e891bd5..1259f1cdb 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1405,7 +1405,7 @@ static pci_ers_result_t aer_root_reset(struct pci_d=
ev *dev)
>  	}
> =20
>  	if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC_END) {
> -		rc =3D pcie_reset_flr(dev, 0);
> +		rc =3D pcie_reset_flr(dev, PCI_RESET_DO_RESET);
>  		if (!rc)
>  			pci_info(dev, "has been reset\n");
>  		else
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ceec67342..17ed9a9c8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3693,8 +3693,11 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>   * reset a single function if other methods (e.g. FLR, PM D0->D3) are
>   * not available.
>   */
> -static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
> +static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, pci_reset_m=
ode_t probe)
>  {
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	/*
>  	 * http://www.intel.com/content/dam/doc/datasheet/82599-10-gbe-controll=
er-datasheet.pdf
>  	 *
> @@ -3703,7 +3706,7 @@ static int reset_intel_82599_sfp_virtfn(struct pci_=
dev *dev, int probe)
>  	 * Thus we must call pcie_flr() directly without first checking if it is
>  	 * supported.
>  	 */
> -	if (!probe)
> +	if (probe =3D=3D PCI_RESET_DO_RESET)
>  		pcie_flr(dev);
>  	return 0;
>  }
> @@ -3715,13 +3718,16 @@ static int reset_intel_82599_sfp_virtfn(struct pc=
i_dev *dev, int probe)
>  #define NSDE_PWR_STATE		0xd0100
>  #define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */
> =20
> -static int reset_ivb_igd(struct pci_dev *dev, int probe)
> +static int reset_ivb_igd(struct pci_dev *dev, pci_reset_mode_t probe)
>  {
>  	void __iomem *mmio_base;
>  	unsigned long timeout;
>  	u32 val;
> =20
> -	if (probe)
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	mmio_base =3D pci_iomap(dev, 0, 0);
> @@ -3758,11 +3764,14 @@ static int reset_ivb_igd(struct pci_dev *dev, int=
 probe)
>  }
> =20
>  /* Device-specific reset method for Chelsio T4-based adapters */
> -static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
> +static int reset_chelsio_generic_dev(struct pci_dev *dev, pci_reset_mode=
_t probe)
>  {
>  	u16 old_command;
>  	u16 msix_flags;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	/*
>  	 * If this isn't a Chelsio T4-based device, return -ENOTTY indicating
>  	 * that we have no device-specific reset method.
> @@ -3774,7 +3783,7 @@ static int reset_chelsio_generic_dev(struct pci_dev=
 *dev, int probe)
>  	 * If this is the "probe" phase, return 0 indicating that we can
>  	 * reset this device.
>  	 */
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	/*
> @@ -3836,17 +3845,20 @@ static int reset_chelsio_generic_dev(struct pci_d=
ev *dev, int probe)
>   *    Chapter 3: NVMe control registers
>   *    Chapter 7.3: Reset behavior
>   */
> -static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
> +static int nvme_disable_and_flr(struct pci_dev *dev, pci_reset_mode_t pr=
obe)
>  {
>  	void __iomem *bar;
>  	u16 cmd;
>  	u32 cfg;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;
> +
>  	if (dev->class !=3D PCI_CLASS_STORAGE_EXPRESS ||
> -	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
> +	    pcie_reset_flr(dev, PCI_RESET_PROBE) || !pci_resource_start(dev, 0))
>  		return -ENOTTY;
> =20
> -	if (probe)
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return 0;
> =20
>  	bar =3D pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> @@ -3910,11 +3922,16 @@ static int nvme_disable_and_flr(struct pci_dev *d=
ev, int probe)
>   * device too soon after FLR.  A 250ms delay after FLR has heuristically
>   * proven to produce reliably working results for device assignment case=
s.
>   */
> -static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
> +static int delay_250ms_after_flr(struct pci_dev *dev, pci_reset_mode_t p=
robe)
>  {
> -	int ret =3D pcie_reset_flr(dev, probe);
> +	int ret;
> +
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;

pcie_reset_flr() handles this case, we could simply test (ret || probe
=3D=3D PCI_RESET_PROBE) below.  In fact, that's probably what the code flow
should have been regardless of this series.

> =20
> -	if (probe)
> +	ret =3D pcie_reset_flr(dev, probe);
> +
> +	if (probe =3D=3D PCI_RESET_PROBE)
>  		return ret;
> =20
>  	msleep(250);
> @@ -3941,10 +3958,13 @@ static const struct pci_dev_reset_methods pci_dev=
_reset_methods[] =3D {
>   * because when a host assigns a device to a guest VM, the host may need
>   * to reset the device but probably doesn't have a driver for it.
>   */
> -int pci_dev_specific_reset(struct pci_dev *dev, int probe)
> +int pci_dev_specific_reset(struct pci_dev *dev, pci_reset_mode_t probe)
>  {
>  	const struct pci_dev_reset_methods *i;
> =20
> +	if (probe >=3D PCI_RESET_ACTION_MAX)
> +		return -EINVAL;

If we test this here, none of the device specific resets modified above
need a duplicate check.  Thanks,

Alex

> +
>  	for (i =3D pci_dev_reset_methods; i->reset; i++) {
>  		if ((i->vendor =3D=3D dev->vendor ||
>  		     i->vendor =3D=3D (u16)PCI_ANY_ID) &&
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9bec3c616..ee7cd3577 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,6 +51,12 @@
> =20
>  #define PCI_RESET_METHODS_NUM 6
> =20
> +typedef enum pci_reset_mode {
> +	PCI_RESET_DO_RESET,
> +	PCI_RESET_PROBE,
> +	PCI_RESET_ACTION_MAX,
> +} pci_reset_mode_t;
> +
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> @@ -1222,7 +1228,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, s=
truct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
>  void pcie_print_link_status(struct pci_dev *dev);
> -int pcie_reset_flr(struct pci_dev *dev, int probe);
> +int pcie_reset_flr(struct pci_dev *dev, pci_reset_mode_t probe);
>  int pcie_flr(struct pci_dev *dev);
>  bool pci_reset_supported(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index b482e42d7..84976d620 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -44,7 +44,7 @@ struct hotplug_slot_ops {
>  	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
>  	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
>  	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
> -	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
> +	int (*reset_slot)		(struct hotplug_slot *slot, pci_reset_mode_t probe);
>  };
> =20
>  /**

