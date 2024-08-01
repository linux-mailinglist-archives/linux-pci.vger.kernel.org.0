Return-Path: <linux-pci+bounces-11140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF079453FD
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A818B2280E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9B13E04C;
	Thu,  1 Aug 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ajbJIxdO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C180142E77
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546492; cv=none; b=ZSWZ/tdNkKGo3lBT6kW6KPOf74NFZvB3DH8CxHqFEoFHm3RKTkfq99WXjFcJOzvM3h664Hnth73KFlotH4rV1ODmMecSxJeTUUqckjQRb/pnZPGs/WLUgBGJi0kAycwVpQVMp6f64fSgJhR4CulU2trrIDxJzH0K2NomQWobsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546492; c=relaxed/simple;
	bh=anC5dtbw0tjvZ9C1wWZfXKwpzp6bty/pmHpHG70F2E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lu31PNiLvMgh5S0v/3aH0DCxHdWYPrC9TsANE2GbQCZkG+EpCEYScIYibVlwQmOMVXp7GSGTC486iJl4WFAadVOAIXGH8HzEbOwWei6FBOg3h4ZuwKD3N2NKAfYe2kDGAVD+Apj2PT8tcDvKRwWhfJtIzqPXMJOupsYr2Gw7Tcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ajbJIxdO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc346ceso10448930a12.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722546488; x=1723151288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX21iLrmBulFRj9S4b2XHLql0iDxbD+W54L9778VX2A=;
        b=ajbJIxdO+S/WdZcryXdB13MRV0Rv60jEK/qIg7/w4nbxhDoonSXycdfzsWDDHrXCNQ
         KH6wd0Rg6lXqlFVeYAvK4fJQrkWZ59dOCHlDehlS6BuouDlzK2YDCSPFgR2J+8aw18+u
         +LY3HDBp4qxQSUBKXr/MxLRJgfWQbOI0xZciU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722546488; x=1723151288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX21iLrmBulFRj9S4b2XHLql0iDxbD+W54L9778VX2A=;
        b=at2Ygqts9X9auLrgBGBWHnohfU0Dehps0L5knBR3K0XuZS8HZk8zj7YRlzo34RL2US
         CPleCMVHpkS5GNVRlYSETMU7PrnmStdjXPJbO7sQe4HDWg8aYcGZm0IQEmAoazVp6to1
         ntJbyyZZlKPFjDWAyTTL6L1yX8lOKLv6VEv9UK63BbYvMm2RcvBiy93JOKivLbdj7I13
         KXpM5FxOGI+BVVxaI3AkekgcYlDCi3ZAMkv5hO2jExU+ZYry3SwVQOEypDJAnLCqTNgy
         SMy7J5v80wwG6I2tflHL1AzxptxZYhBe4Q9EoVOaU7KLfUrFZQLiag68M+MosCeIEIpm
         QlDw==
X-Forwarded-Encrypted: i=1; AJvYcCUKGPOCytDU6p8n4MHSJJXHkC7qKuR5DmIV7GuWUrJU5PhjFTxtek2fLcY0IsD1DFgn1jhAZhTCNd+sxKYkfgY6WVQIFAmxMkfc
X-Gm-Message-State: AOJu0YxcYHa82L2fayp5ILQrA2hhKbag1wBTSo6hw7EpzSEKn1jH++Kr
	chbo1ZWayW1DLycO3DQRgHHLM44+7PuBoq7pDiFnX0aW5qWqF7sE57tihcTCmc6gmpKjcOHV4qi
	Lm+K8RkAhGQ5dOkNAtF5veaKbLAMfeKZcOKlY
X-Google-Smtp-Source: AGHT+IHs68DtMdyFgfsxaUIPho3oPWXPqknnY50KPiL18/qrGIdopTR/pGjoRy7H67eLX+/B0SB6Myo39fud8N+rzkc=
X-Received: by 2002:aa7:d604:0:b0:5a1:cc07:6bb0 with SMTP id
 4fb4d7f45d1cf-5b7f3ada312mr1116779a12.15.1722546487523; Thu, 01 Aug 2024
 14:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org> <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org>
In-Reply-To: <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 1 Aug 2024 14:07:41 -0700
Message-ID: <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for bridges
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, lukas@wunner.de, mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:02=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Currently, there is no proper distinction between D3Hot and D3Cold while
> handling the power management for PCI bridges. For instance,
> pci_bridge_d3_allowed() API decides whether it is allowed to put the
> bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
> is allowed in a scenario. This often leads to confusion and may be prone
> to errors.
>
> So let's split the D3Hot and D3Cold handling where possible. The current
> pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
> and pci_bridge_d3cold_allowed() APIs and used in relevant places.
>
> Also, pci_bridge_d3_update() API is now renamed to
> pci_bridge_d3cold_update() since it was only used to check the possibilit=
y
> of D3Cold.
>
> Note that it is assumed that only D3Hot needs to be checked while
> transitioning the bridge during runtime PM and D3Cold in other places. In
> the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
> allowed for the bridge.
>
> Still, there are places where just 'd3' is used opaquely, but those are
> hard to distinguish, hence left for future cleanups.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/bus.c          |  2 +-
>  drivers/pci/pci-acpi.c     |  5 +--
>  drivers/pci/pci-sysfs.c    |  2 +-
>  drivers/pci/pci.c          | 78 ++++++++++++++++++++++++++++++----------=
------
>  drivers/pci/pci.h          | 12 ++++---
>  drivers/pci/pcie/portdrv.c | 16 +++++-----
>  drivers/pci/remove.c       |  2 +-
>  include/linux/pci.h        |  3 +-
>  8 files changed, 75 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 826b5016a101..cb1a1aaefa90 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -346,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 of_pci_make_dev_node(dev);
>         pci_create_sysfs_dev_files(dev);
>         pci_proc_attach_device(dev);
> -       pci_bridge_d3_update(dev);
> +       pci_bridge_d3cold_update(dev);
>
>         dev->match_driver =3D !dn || of_device_is_available(dn);
>         retval =3D device_attach(&dev->dev);
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 0f260cdc4592..aaf5a68e7984 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi=
_device *adev)
>          * reason is that the bridge may have additional methods such as
>          * _DSW that need to be called.
>          */
> -       if (pci_dev->bridge_d3_allowed)
> +       if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allow=
ed)
>                 device_wakeup_enable(dev);
>
>         acpi_pci_wakeup(pci_dev, false);
> @@ -1452,7 +1452,8 @@ void pci_acpi_cleanup(struct device *dev, struct ac=
pi_device *adev)
>         pci_acpi_remove_pm_notifier(adev);
>         if (adev->wakeup.flags.valid) {
>                 acpi_device_power_remove_dependent(adev, dev);
> -               if (pci_dev->bridge_d3_allowed)
> +               if (pci_dev->bridge_d3cold_allowed &&
> +                   pci_dev->bridge_d3hot_allowed)
>                         device_wakeup_disable(dev);
>
>                 device_set_wakeup_capable(dev, false);
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa716392f..45628b0dd116 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -529,7 +529,7 @@ static ssize_t d3cold_allowed_store(struct device *de=
v,
>                 return -EINVAL;
>
>         pdev->d3cold_allowed =3D !!val;
> -       pci_bridge_d3_update(pdev);
> +       pci_bridge_d3cold_update(pdev);
>
>         pm_runtime_resume(dev);
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0edc4e448c2d..48e2ca0cd8a0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -166,9 +166,9 @@ bool pci_ats_disabled(void)
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_disabled);
>
> -/* Disable bridge_d3 for all PCIe ports */
> +/* Disable both D3Hot and D3Cold for all PCIe ports */
>  static bool pci_bridge_d3_disable;
> -/* Force bridge_d3 for all PCIe ports */
> +/* Force both D3Hot and D3Cold for all PCIe ports */
>  static bool pci_bridge_d3_force;
>
>  static int __init pcie_port_pm_setup(char *str)
> @@ -2966,14 +2966,11 @@ static const struct dmi_system_id bridge_d3_black=
list[] =3D {
>         { }
>  };
>
> -/**
> - * pci_bridge_d3_allowed - Is it allowed to put the bridge into D3
> - * @bridge: Bridge to check
> - *
> - * This function checks if the bridge is allowed to move to D3.
> - * Currently we only allow D3 for recent enough PCIe ports and Thunderbo=
lt.
> +/*
> + * Helper function to check whether it is allowed to put the bridge into=
 D3
> + * states (D3Hot and D3Cold).
>   */
> -bool pci_bridge_d3_allowed(struct pci_dev *bridge)
> +static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_t st=
ate)
>  {
>         if (!pci_is_pcie(bridge))
>                 return false;
> @@ -3026,6 +3023,32 @@ bool pci_bridge_d3_allowed(struct pci_dev *bridge)
>         return false;
>  }
>
> +/**
> + * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into D3Co=
ld
> + * @bridge: Bridge to check
> + *
> + * This function checks if the bridge is allowed to move to D3Cold.
> + * Currently we only allow D3Cold for recent enough PCIe ports on ACPI b=
ased
> + * platforms and Thunderbolt.
> + */
> +bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
> +{
> +       return pci_bridge_d3_allowed(bridge, PCI_D3cold);
> +}
> +
> +/**
> + * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into D3Ho=
t

typo? pci_bridge_d3hot_allowed.

> + * @bridge: Bridge to check
> + *
> + * This function checks if the bridge is allowed to move to D3Hot.
> + * Currently we only allow D3Hot for recent enough PCIe ports on ACPI ba=
sed
> + * platforms and Thunderbolt.
> + */
> +bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
> +{
> +       return pci_bridge_d3_allowed(bridge, PCI_D3hot);
> +}
> +
>  static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
>  {
>         bool *d3cold_ok =3D data;
> @@ -3046,55 +3069,55 @@ static int pci_dev_check_d3cold(struct pci_dev *d=
ev, void *data)
>  }
>
>  /*
> - * pci_bridge_d3_update - Update bridge D3 capabilities
> + * pci_bridge_d3cold_update - Update bridge D3Cold capabilities
>   * @dev: PCI device which is changed
>   *
>   * Update upstream bridge PM capabilities accordingly depending on if th=
e
>   * device PM configuration was changed or the device is being removed.  =
The
>   * change is also propagated upstream.
>   */
> -void pci_bridge_d3_update(struct pci_dev *dev)
> +void pci_bridge_d3cold_update(struct pci_dev *dev)
>  {
>         bool remove =3D !device_is_registered(&dev->dev);
>         struct pci_dev *bridge;
>         bool d3cold_ok =3D true;
>
>         bridge =3D pci_upstream_bridge(dev);
> -       if (!bridge || !pci_bridge_d3_allowed(bridge))
> +       if (!bridge || !pci_bridge_d3cold_allowed(bridge))
>                 return;
>
>         /*
> -        * If D3 is currently allowed for the bridge, removing one of its
> +        * If D3Cold is currently allowed for the bridge, removing one of=
 its
>          * children won't change that.
>          */
> -       if (remove && bridge->bridge_d3_allowed)
> +       if (remove && bridge->bridge_d3cold_allowed)
>                 return;
>
>         /*
> -        * If D3 is currently allowed for the bridge and a child is added=
 or
> -        * changed, disallowance of D3 can only be caused by that child, =
so
> +        * If D3Cold is currently allowed for the bridge and a child is a=
dded or
> +        * changed, disallowance of D3Cold can only be caused by that chi=
ld, so
>          * we only need to check that single device, not any of its sibli=
ngs.
>          *
> -        * If D3 is currently not allowed for the bridge, checking the de=
vice
> -        * first may allow us to skip checking its siblings.
> +        * If D3Cold is currently not allowed for the bridge, checking th=
e
> +        * device first may allow us to skip checking its siblings.
>          */
>         if (!remove)
>                 pci_dev_check_d3cold(dev, &d3cold_ok);
>
>         /*
> -        * If D3 is currently not allowed for the bridge, this may be cau=
sed
> +        * If D3Cold is currently not allowed for the bridge, this may be=
 caused
>          * either by the device being changed/removed or any of its sibli=
ngs,
>          * so we need to go through all children to find out if one of th=
em
> -        * continues to block D3.
> +        * continues to block D3Cold.
>          */
> -       if (d3cold_ok && !bridge->bridge_d3_allowed)
> +       if (d3cold_ok && !bridge->bridge_d3cold_allowed)
>                 pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
>                              &d3cold_ok);
>
> -       if (bridge->bridge_d3_allowed !=3D d3cold_ok) {
> -               bridge->bridge_d3_allowed =3D d3cold_ok;
> +       if (bridge->bridge_d3cold_allowed !=3D d3cold_ok) {
> +               bridge->bridge_d3cold_allowed =3D d3cold_ok;
>                 /* Propagate change to upstream bridges */
> -               pci_bridge_d3_update(bridge);
> +               pci_bridge_d3cold_update(bridge);
>         }
>  }
>
> @@ -3110,7 +3133,7 @@ void pci_d3cold_enable(struct pci_dev *dev)
>  {
>         if (dev->no_d3cold) {
>                 dev->no_d3cold =3D false;
> -               pci_bridge_d3_update(dev);
> +               pci_bridge_d3cold_update(dev);
>         }
>  }
>  EXPORT_SYMBOL_GPL(pci_d3cold_enable);
> @@ -3127,7 +3150,7 @@ void pci_d3cold_disable(struct pci_dev *dev)
>  {
>         if (!dev->no_d3cold) {
>                 dev->no_d3cold =3D true;
> -               pci_bridge_d3_update(dev);
> +               pci_bridge_d3cold_update(dev);
>         }
>  }
>  EXPORT_SYMBOL_GPL(pci_d3cold_disable);
> @@ -3167,7 +3190,8 @@ void pci_pm_init(struct pci_dev *dev)
>         dev->pm_cap =3D pm;
>         dev->d3hot_delay =3D PCI_PM_D3HOT_WAIT;
>         dev->d3cold_delay =3D PCI_PM_D3COLD_WAIT;
> -       dev->bridge_d3_allowed =3D pci_bridge_d3_allowed(dev);
> +       dev->bridge_d3cold_allowed =3D pci_bridge_d3cold_allowed(dev);
> +       dev->bridge_d3hot_allowed =3D pci_bridge_d3hot_allowed(dev);
>         dev->d3cold_allowed =3D true;
>
>         dev->d1_support =3D false;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 53ca75639201..f819eab793fc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -92,8 +92,9 @@ void pci_pm_init(struct pci_dev *dev);
>  void pci_ea_init(struct pci_dev *dev);
>  void pci_msi_init(struct pci_dev *dev);
>  void pci_msix_init(struct pci_dev *dev);
> -bool pci_bridge_d3_allowed(struct pci_dev *dev);
> -void pci_bridge_d3_update(struct pci_dev *dev);
> +bool pci_bridge_d3cold_allowed(struct pci_dev *dev);
> +bool pci_bridge_d3hot_allowed(struct pci_dev *dev);
> +void pci_bridge_d3cold_update(struct pci_dev *dev);
>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_t=
ype);
>
>  static inline void pci_wakeup_event(struct pci_dev *dev)
> @@ -111,9 +112,12 @@ static inline bool pci_power_manageable(struct pci_d=
ev *pci_dev)
>  {
>         /*
>          * Currently we allow normal PCI devices and PCI bridges transiti=
on
> -        * into D3 if their bridge_d3 is set.
> +        * into D3 states if both bridge_d3cold_allowed and bridge_d3hot_=
allowed
> +        * are set.
>          */

If pm requires both D3hot and D3cold, can we add a flag for DT to
support D3cold? Otherwise during suspend, pcieport still stays at D0.

[   42.202016] mt7921e 0000:01:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
[   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
[   42.238048] mt7921e 0000:01:00.0: PM:
pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
[   42.247083] pcieport 0000:00:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
[   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
[   42.302500] pcieport 0000:00:00.0: PCI PM: Skipped

Thanks.


> -       return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3_allowe=
d;
> +       return !pci_has_subordinate(pci_dev) ||
> +              (pci_dev->bridge_d3cold_allowed &&
> +               pci_dev->bridge_d3hot_allowed);
>  }
>
>  static inline bool pcie_downstream_port(const struct pci_dev *dev)
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 8401a0f7b394..655754b9f06a 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -632,7 +632,7 @@ __setup("pcie_ports=3D", pcie_port_setup);
>  #ifdef CONFIG_PM
>  static int pcie_port_runtime_suspend(struct device *dev)
>  {
> -       if (!to_pci_dev(dev)->bridge_d3_allowed)
> +       if (!to_pci_dev(dev)->bridge_d3hot_allowed)
>                 return -EBUSY;
>
>         return pcie_port_device_runtime_suspend(dev);
> @@ -641,11 +641,11 @@ static int pcie_port_runtime_suspend(struct device =
*dev)
>  static int pcie_port_runtime_idle(struct device *dev)
>  {
>         /*
> -        * Assume the PCI core has set bridge_d3_allowed whenever it thin=
ks the
> -        * port should be good to go to D3.  Everything else, including m=
oving
> -        * the port to D3, is handled by the PCI core.
> +        * Assume the PCI core has set bridge_d3hot_allowed whenever it t=
hinks
> +        * the port should be good to go to D3Hot.  Everything else, incl=
uding
> +        * moving the port to D3Hot, is handled by the PCI core.
>          */
> -       return to_pci_dev(dev)->bridge_d3_allowed ? 0 : -EBUSY;
> +       return to_pci_dev(dev)->bridge_d3hot_allowed ? 0 : -EBUSY;
>  }
>
>  static const struct dev_pm_ops pcie_portdrv_pm_ops =3D {
> @@ -702,7 +702,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>         dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
>                                            DPM_FLAG_SMART_SUSPEND);
>
> -       if (dev->bridge_d3_allowed) {
> +       if (dev->bridge_d3hot_allowed) {
>                 /*
>                  * Keep the port resumed 100ms to make sure things like
>                  * config space accesses from userspace (lspci) will not
> @@ -720,7 +720,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>
>  static void pcie_portdrv_remove(struct pci_dev *dev)
>  {
> -       if (dev->bridge_d3_allowed) {
> +       if (dev->bridge_d3hot_allowed) {
>                 pm_runtime_forbid(&dev->dev);
>                 pm_runtime_get_noresume(&dev->dev);
>                 pm_runtime_dont_use_autosuspend(&dev->dev);
> @@ -733,7 +733,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>
>  static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  {
> -       if (dev->bridge_d3_allowed) {
> +       if (dev->bridge_d3hot_allowed) {
>                 pm_runtime_forbid(&dev->dev);
>                 pm_runtime_get_noresume(&dev->dev);
>                 pm_runtime_dont_use_autosuspend(&dev->dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d749ea8250d6..36d8cb50b582 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -41,7 +41,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>
>         pci_doe_destroy(dev);
>         pcie_aspm_exit_link_state(dev);
> -       pci_bridge_d3_update(dev);
> +       pci_bridge_d3cold_update(dev);
>         pci_free_resources(dev);
>         put_device(&dev->dev);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2a48c88512e1..d0947f932b9a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -375,7 +375,8 @@ struct pci_dev {
>         unsigned int    d2_support:1;   /* Low power state D2 is supporte=
d */
>         unsigned int    no_d1d2:1;      /* D1 and D2 are forbidden */
>         unsigned int    no_d3cold:1;    /* D3cold is forbidden */
> -       unsigned int    bridge_d3_allowed:1;    /* Allow D3 for bridge */
> +       unsigned int    bridge_d3cold_allowed:1;        /* Allow D3Cold f=
or bridge */
> +       unsigned int    bridge_d3hot_allowed:1;         /* Allow D3Hot fo=
r bridge */
>         unsigned int    d3cold_allowed:1;       /* D3cold is allowed by u=
ser */
>         unsigned int    mmio_always_on:1;       /* Disallow turning off i=
o/mem
>                                                    decoding during BAR si=
zing */
>
> --
> 2.25.1
>

