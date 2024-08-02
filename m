Return-Path: <linux-pci+bounces-11205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34F946423
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 21:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0727D1F21123
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE104AED7;
	Fri,  2 Aug 2024 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0gtymhN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42A222626
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722628453; cv=none; b=hhyJbqO4FGY1zcFUMu8xnBytiQMFGad+HUjumfqTPciTFGv0gvYyN2kQgwysXMziEsQv5D06VjRMfBOPq8FpwFYJDyjuj1gNnyyFQ9DxSj586RX8z4GafX67kXGejSwwEwgRnUMIEKkVIqWyNFp5KG0taG6IRUZOUFRq5Lp18xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722628453; c=relaxed/simple;
	bh=7zYm9HYJC4hW3OeBmVvC/aK3hYq3sUpLv99V+ty7zMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EindvazBWMgdS90ohGfGFsceCPFGxsXF20kwiEFZ1KYlYlyKXF0qhodWtEkxlh4aq6VKHHVN/fjEgDmcY2p3B7ASFwEAqtfHyNk+a3oKrT41uN3P3JF9dvI8DWQm5paq5I1PvV7LO0uY3YRQxLfqlg/rCI+dRNEIjiuxKAPhh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T0gtymhN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso9077974a12.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Aug 2024 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722628449; x=1723233249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97pj0XT9lbEhPmXE/qPIwkhJe372JSDiqTqAJL7ohJo=;
        b=T0gtymhNAi4rofATda1RRT3tJGf5IIAaiwkE6SZr+Y55ksu/T1jme7yCjjHngpV/oa
         88QAFatfuiGQN+cfM8FYz2N2bAcfQzR3dugIPjAHRi8pGdPaV4LnJqs/NSlblNjbb9cr
         F+/BBxVOUv0VNoVacnnDKiZeqAvKyfPo9qUyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722628449; x=1723233249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97pj0XT9lbEhPmXE/qPIwkhJe372JSDiqTqAJL7ohJo=;
        b=YVuQRAsfu5xqdZCE+JarnAU444iE9d1Ths2oEMMTKcvM2Jlp2RdCnf/RUgPd/PhwAF
         +ip02IOj3ZUQlPUX0AXcVnepw4Ftu0SthlDIvZ6/uZqhx0PrKPn23uLfW+f6XpDJ3iGM
         bCj4yekqjVN20SqGBunbfkvOTYYWTTeAjIipPmozWI4NrAxTWAxIwx0R0NL7ILH9uvSb
         US4ZR81j0UD8vxSIQTpzPkPaksD7VA+E4l9+/7ta4saIa80o/G47g/vmP7CJLVVq2I5n
         tyVtkOh9BtDbdyvAs/J43er7dryKq1SuBL8zAa4JArl2NjK335M5ZzWo83Ce4tSmTxbg
         OocA==
X-Forwarded-Encrypted: i=1; AJvYcCXlwVx/NFJfsDnRDOrtmAzBONwdiTld2hDz4UwlOAwfi3y4xsG6P59TdNTAUxS4dosCAdzGf3TG8eTlUiMEdSYmHmhTfWEcNlPe
X-Gm-Message-State: AOJu0YzTMqXm92GNcUQGYAnBSCSmDRHh5G/ckMMscL66BOjPRme+GCFM
	7Ts8baiwFqsn1gMC4IwJ1gtnF/8yTBaueoh2VkTinnt/NhmYJHTjitW3AHIcCTwaQMiF5WTl1ZV
	4BGETh9FctO2+/NkBRdjGofEfH5d14iZFcjI4
X-Google-Smtp-Source: AGHT+IEhbG0LvzS1ry3MtHY1fRtxIWekpW46sgZlnjnTmPIPrTYszhZy+E3fXge5+XZhhsc20imTsjC5fymNWCcegzk=
X-Received: by 2002:a05:6402:706:b0:5a2:2b56:e08e with SMTP id
 4fb4d7f45d1cf-5b7f3eba07fmr3083433a12.18.1722628448955; Fri, 02 Aug 2024
 12:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org> <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
 <20240802053302.GB4206@thinkpad>
In-Reply-To: <20240802053302.GB4206@thinkpad>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 2 Aug 2024 12:53:42 -0700
Message-ID: <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for bridges
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, lukas@wunner.de, mika.westerberg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:33=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Aug 01, 2024 at 02:07:41PM -0700, Hsin-Yi Wang wrote:
> > On Fri, Jul 26, 2024 at 4:02=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Currently, there is no proper distinction between D3Hot and D3Cold wh=
ile
> > > handling the power management for PCI bridges. For instance,
> > > pci_bridge_d3_allowed() API decides whether it is allowed to put the
> > > bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Co=
ld
> > > is allowed in a scenario. This often leads to confusion and may be pr=
one
> > > to errors.
> > >
> > > So let's split the D3Hot and D3Cold handling where possible. The curr=
ent
> > > pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowe=
d()
> > > and pci_bridge_d3cold_allowed() APIs and used in relevant places.
> > >
> > > Also, pci_bridge_d3_update() API is now renamed to
> > > pci_bridge_d3cold_update() since it was only used to check the possib=
ility
> > > of D3Cold.
> > >
> > > Note that it is assumed that only D3Hot needs to be checked while
> > > transitioning the bridge during runtime PM and D3Cold in other places=
. In
> > > the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold ar=
e
> > > allowed for the bridge.
> > >
> > > Still, there are places where just 'd3' is used opaquely, but those a=
re
> > > hard to distinguish, hence left for future cleanups.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.or=
g>
> > > ---
> > >  drivers/pci/bus.c          |  2 +-
> > >  drivers/pci/pci-acpi.c     |  5 +--
> > >  drivers/pci/pci-sysfs.c    |  2 +-
> > >  drivers/pci/pci.c          | 78 ++++++++++++++++++++++++++++++------=
----------
> > >  drivers/pci/pci.h          | 12 ++++---
> > >  drivers/pci/pcie/portdrv.c | 16 +++++-----
> > >  drivers/pci/remove.c       |  2 +-
> > >  include/linux/pci.h        |  3 +-
> > >  8 files changed, 75 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > index 826b5016a101..cb1a1aaefa90 100644
> > > --- a/drivers/pci/bus.c
> > > +++ b/drivers/pci/bus.c
> > > @@ -346,7 +346,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >                 of_pci_make_dev_node(dev);
> > >         pci_create_sysfs_dev_files(dev);
> > >         pci_proc_attach_device(dev);
> > > -       pci_bridge_d3_update(dev);
> > > +       pci_bridge_d3cold_update(dev);
> > >
> > >         dev->match_driver =3D !dn || of_device_is_available(dn);
> > >         retval =3D device_attach(&dev->dev);
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index 0f260cdc4592..aaf5a68e7984 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct =
acpi_device *adev)
> > >          * reason is that the bridge may have additional methods such=
 as
> > >          * _DSW that need to be called.
> > >          */
> > > -       if (pci_dev->bridge_d3_allowed)
> > > +       if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_a=
llowed)
> > >                 device_wakeup_enable(dev);
> > >
> > >         acpi_pci_wakeup(pci_dev, false);
> > > @@ -1452,7 +1452,8 @@ void pci_acpi_cleanup(struct device *dev, struc=
t acpi_device *adev)
> > >         pci_acpi_remove_pm_notifier(adev);
> > >         if (adev->wakeup.flags.valid) {
> > >                 acpi_device_power_remove_dependent(adev, dev);
> > > -               if (pci_dev->bridge_d3_allowed)
> > > +               if (pci_dev->bridge_d3cold_allowed &&
> > > +                   pci_dev->bridge_d3hot_allowed)
> > >                         device_wakeup_disable(dev);
> > >
> > >                 device_set_wakeup_capable(dev, false);
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 40cfa716392f..45628b0dd116 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -529,7 +529,7 @@ static ssize_t d3cold_allowed_store(struct device=
 *dev,
> > >                 return -EINVAL;
> > >
> > >         pdev->d3cold_allowed =3D !!val;
> > > -       pci_bridge_d3_update(pdev);
> > > +       pci_bridge_d3cold_update(pdev);
> > >
> > >         pm_runtime_resume(dev);
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 0edc4e448c2d..48e2ca0cd8a0 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -166,9 +166,9 @@ bool pci_ats_disabled(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_ats_disabled);
> > >
> > > -/* Disable bridge_d3 for all PCIe ports */
> > > +/* Disable both D3Hot and D3Cold for all PCIe ports */
> > >  static bool pci_bridge_d3_disable;
> > > -/* Force bridge_d3 for all PCIe ports */
> > > +/* Force both D3Hot and D3Cold for all PCIe ports */
> > >  static bool pci_bridge_d3_force;
> > >
> > >  static int __init pcie_port_pm_setup(char *str)
> > > @@ -2966,14 +2966,11 @@ static const struct dmi_system_id bridge_d3_b=
lacklist[] =3D {
> > >         { }
> > >  };
> > >
> > > -/**
> > > - * pci_bridge_d3_allowed - Is it allowed to put the bridge into D3
> > > - * @bridge: Bridge to check
> > > - *
> > > - * This function checks if the bridge is allowed to move to D3.
> > > - * Currently we only allow D3 for recent enough PCIe ports and Thund=
erbolt.
> > > +/*
> > > + * Helper function to check whether it is allowed to put the bridge =
into D3
> > > + * states (D3Hot and D3Cold).
> > >   */
> > > -bool pci_bridge_d3_allowed(struct pci_dev *bridge)
> > > +static bool pci_bridge_d3_allowed(struct pci_dev *bridge, pci_power_=
t state)
> > >  {
> > >         if (!pci_is_pcie(bridge))
> > >                 return false;
> > > @@ -3026,6 +3023,32 @@ bool pci_bridge_d3_allowed(struct pci_dev *bri=
dge)
> > >         return false;
> > >  }
> > >
> > > +/**
> > > + * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into =
D3Cold
> > > + * @bridge: Bridge to check
> > > + *
> > > + * This function checks if the bridge is allowed to move to D3Cold.
> > > + * Currently we only allow D3Cold for recent enough PCIe ports on AC=
PI based
> > > + * platforms and Thunderbolt.
> > > + */
> > > +bool pci_bridge_d3cold_allowed(struct pci_dev *bridge)
> > > +{
> > > +       return pci_bridge_d3_allowed(bridge, PCI_D3cold);
> > > +}
> > > +
> > > +/**
> > > + * pci_bridge_d3cold_allowed - Is it allowed to put the bridge into =
D3Hot
> >
> > typo? pci_bridge_d3hot_allowed.
> >
>
> Yep, nice catch!
>
> > > + * @bridge: Bridge to check
> > > + *
> > > + * This function checks if the bridge is allowed to move to D3Hot.
> > > + * Currently we only allow D3Hot for recent enough PCIe ports on ACP=
I based
> > > + * platforms and Thunderbolt.
> > > + */
> > > +bool pci_bridge_d3hot_allowed(struct pci_dev *bridge)
> > > +{
> > > +       return pci_bridge_d3_allowed(bridge, PCI_D3hot);
> > > +}
> > > +
> > >  static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
> > >  {
> > >         bool *d3cold_ok =3D data;
> > > @@ -3046,55 +3069,55 @@ static int pci_dev_check_d3cold(struct pci_de=
v *dev, void *data)
> > >  }
> > >
> > >  /*
> > > - * pci_bridge_d3_update - Update bridge D3 capabilities
> > > + * pci_bridge_d3cold_update - Update bridge D3Cold capabilities
> > >   * @dev: PCI device which is changed
> > >   *
> > >   * Update upstream bridge PM capabilities accordingly depending on i=
f the
> > >   * device PM configuration was changed or the device is being remove=
d.  The
> > >   * change is also propagated upstream.
> > >   */
> > > -void pci_bridge_d3_update(struct pci_dev *dev)
> > > +void pci_bridge_d3cold_update(struct pci_dev *dev)
> > >  {
> > >         bool remove =3D !device_is_registered(&dev->dev);
> > >         struct pci_dev *bridge;
> > >         bool d3cold_ok =3D true;
> > >
> > >         bridge =3D pci_upstream_bridge(dev);
> > > -       if (!bridge || !pci_bridge_d3_allowed(bridge))
> > > +       if (!bridge || !pci_bridge_d3cold_allowed(bridge))
> > >                 return;
> > >
> > >         /*
> > > -        * If D3 is currently allowed for the bridge, removing one of=
 its
> > > +        * If D3Cold is currently allowed for the bridge, removing on=
e of its
> > >          * children won't change that.
> > >          */
> > > -       if (remove && bridge->bridge_d3_allowed)
> > > +       if (remove && bridge->bridge_d3cold_allowed)
> > >                 return;
> > >
> > >         /*
> > > -        * If D3 is currently allowed for the bridge and a child is a=
dded or
> > > -        * changed, disallowance of D3 can only be caused by that chi=
ld, so
> > > +        * If D3Cold is currently allowed for the bridge and a child =
is added or
> > > +        * changed, disallowance of D3Cold can only be caused by that=
 child, so
> > >          * we only need to check that single device, not any of its s=
iblings.
> > >          *
> > > -        * If D3 is currently not allowed for the bridge, checking th=
e device
> > > -        * first may allow us to skip checking its siblings.
> > > +        * If D3Cold is currently not allowed for the bridge, checkin=
g the
> > > +        * device first may allow us to skip checking its siblings.
> > >          */
> > >         if (!remove)
> > >                 pci_dev_check_d3cold(dev, &d3cold_ok);
> > >
> > >         /*
> > > -        * If D3 is currently not allowed for the bridge, this may be=
 caused
> > > +        * If D3Cold is currently not allowed for the bridge, this ma=
y be caused
> > >          * either by the device being changed/removed or any of its s=
iblings,
> > >          * so we need to go through all children to find out if one o=
f them
> > > -        * continues to block D3.
> > > +        * continues to block D3Cold.
> > >          */
> > > -       if (d3cold_ok && !bridge->bridge_d3_allowed)
> > > +       if (d3cold_ok && !bridge->bridge_d3cold_allowed)
> > >                 pci_walk_bus(bridge->subordinate, pci_dev_check_d3col=
d,
> > >                              &d3cold_ok);
> > >
> > > -       if (bridge->bridge_d3_allowed !=3D d3cold_ok) {
> > > -               bridge->bridge_d3_allowed =3D d3cold_ok;
> > > +       if (bridge->bridge_d3cold_allowed !=3D d3cold_ok) {
> > > +               bridge->bridge_d3cold_allowed =3D d3cold_ok;
> > >                 /* Propagate change to upstream bridges */
> > > -               pci_bridge_d3_update(bridge);
> > > +               pci_bridge_d3cold_update(bridge);
> > >         }
> > >  }
> > >
> > > @@ -3110,7 +3133,7 @@ void pci_d3cold_enable(struct pci_dev *dev)
> > >  {
> > >         if (dev->no_d3cold) {
> > >                 dev->no_d3cold =3D false;
> > > -               pci_bridge_d3_update(dev);
> > > +               pci_bridge_d3cold_update(dev);
> > >         }
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_d3cold_enable);
> > > @@ -3127,7 +3150,7 @@ void pci_d3cold_disable(struct pci_dev *dev)
> > >  {
> > >         if (!dev->no_d3cold) {
> > >                 dev->no_d3cold =3D true;
> > > -               pci_bridge_d3_update(dev);
> > > +               pci_bridge_d3cold_update(dev);
> > >         }
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_d3cold_disable);
> > > @@ -3167,7 +3190,8 @@ void pci_pm_init(struct pci_dev *dev)
> > >         dev->pm_cap =3D pm;
> > >         dev->d3hot_delay =3D PCI_PM_D3HOT_WAIT;
> > >         dev->d3cold_delay =3D PCI_PM_D3COLD_WAIT;
> > > -       dev->bridge_d3_allowed =3D pci_bridge_d3_allowed(dev);
> > > +       dev->bridge_d3cold_allowed =3D pci_bridge_d3cold_allowed(dev)=
;
> > > +       dev->bridge_d3hot_allowed =3D pci_bridge_d3hot_allowed(dev);
> > >         dev->d3cold_allowed =3D true;
> > >
> > >         dev->d1_support =3D false;
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index 53ca75639201..f819eab793fc 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -92,8 +92,9 @@ void pci_pm_init(struct pci_dev *dev);
> > >  void pci_ea_init(struct pci_dev *dev);
> > >  void pci_msi_init(struct pci_dev *dev);
> > >  void pci_msix_init(struct pci_dev *dev);
> > > -bool pci_bridge_d3_allowed(struct pci_dev *dev);
> > > -void pci_bridge_d3_update(struct pci_dev *dev);
> > > +bool pci_bridge_d3cold_allowed(struct pci_dev *dev);
> > > +bool pci_bridge_d3hot_allowed(struct pci_dev *dev);
> > > +void pci_bridge_d3cold_update(struct pci_dev *dev);
> > >  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *res=
et_type);
> > >
> > >  static inline void pci_wakeup_event(struct pci_dev *dev)
> > > @@ -111,9 +112,12 @@ static inline bool pci_power_manageable(struct p=
ci_dev *pci_dev)
> > >  {
> > >         /*
> > >          * Currently we allow normal PCI devices and PCI bridges tran=
sition
> > > -        * into D3 if their bridge_d3 is set.
> > > +        * into D3 states if both bridge_d3cold_allowed and bridge_d3=
hot_allowed
> > > +        * are set.
> > >          */
> >
> > If pm requires both D3hot and D3cold, can we add a flag for DT to
> > support D3cold? Otherwise during suspend, pcieport still stays at D0.
> >
>
> You mean D3hot?
>
> > [   42.202016] mt7921e 0000:01:00.0: PM: calling
> > pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
> > [   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
>
> Here I can see that the port entered D3hot
>
This one is the wifi device connected to the port.

> > [   42.238048] mt7921e 0000:01:00.0: PM:
> > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
> > [   42.247083] pcieport 0000:00:00.0: PM: calling
> > pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
> > [   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
>
This is the port suspended with D0. If we hack power_manageable to
only consider D3hot, the state here for pcieport will become D3hot
(compared in below).

If it's D0 (and s2idle), in resume it won't restore config:
https://elixir.bootlin.com/linux/v6.10/source/drivers/pci/pci-driver.c#L959=
,
and in resume it would be an issue.

Comparison:
1. pcieport can go to D3:
(suspend)
[   61.645809] mt7921e 0000:01:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2f8 @ 1139, parent: 0000:00:00.0
[   61.675562] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
[   61.681931] mt7921e 0000:01:00.0: PM:
pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 26502 usecs
[   61.690959] pcieport 0000:00:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x2f8 @ 3248, parent: pci0000:00
[   61.755359] pcieport 0000:00:00.0: PCI PM: Suspend power state: D3hot
[   61.761832] pcieport 0000:00:00.0: PM:
pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 61345 usecs

(resume)
[   65.243981] pcieport 0000:00:00.0: PM: calling
pci_pm_resume_noirq+0x0/0x190 @ 3258, parent: pci0000:00
[   65.253122] mtk-pcie-phy 16930000.phy: CKM_38=3D0x13040500,
GLB_20=3D0x0, GLB_30=3D0x0, GLB_38=3D0x30453fc, GLB_F4=3D0x1453b000
[   65.262725] pcieport 0000:00:00.0: PM:
pci_pm_resume_noirq+0x0/0x190 returned 0 after 175 usecs
[   65.273159] mtk-pcie-phy 16930000.phy: No calibration info
[   65.281903] mt7921e 0000:01:00.0: PM: calling
pci_pm_resume_noirq+0x0/0x190 @ 3259, parent: 0000:00:00.0
[   65.297108] mt7921e 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x190
returned 0 after 329 usecs


2. pcieport stays at D0 due to power_manageable returns false:
(suspend)
[   52.435375] mt7921e 0000:01:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x300 @ 2040, parent: 0000:00:00.0
[   52.465235] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
[   52.471610] mt7921e 0000:01:00.0: PM:
pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26602 usecs
[   52.480674] pcieport 0000:00:00.0: PM: calling
pci_pm_suspend_noirq+0x0/0x300 @ 143, parent: pci0000:00
[   52.529876] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
                <-- port is still D0
[   52.536056] pcieport 0000:00:00.0: PCI PM: Skipped

(resume)
[   56.026298] pcieport 0000:00:00.0: PM: calling
pci_pm_resume_noirq+0x0/0x190 @ 3243, parent: pci0000:00
[   56.035379] mtk-pcie-phy 16930000.phy: CKM_38=3D0x13040500,
GLB_20=3D0x0, GLB_30=3D0x0, GLB_38=3D0x30453fc, GLB_F4=3D0x1453b000
[   56.044776] pcieport 0000:00:00.0: PM:
pci_pm_resume_noirq+0x0/0x190 returned 0 after 13 usecs
[   56.055409] mtk-pcie-phy 16930000.phy: No calibration info
[   56.064098] mt7921e 0000:01:00.0: PM: calling
pci_pm_resume_noirq+0x0/0x190 @ 3244, parent: 0000:00:00.0
[   56.078962] mt7921e 0000:01:00.0: Unable to change power state from
D3hot to D0, device inaccessible                    <-- resume failed.
[   56.152363] mt7921e 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x190
returned 0 after 73406 usecs


> And resuming with D0.
>
> Problem with D3Cold is, it is a power off state. If a driver wants a devi=
ce/port
> to enter D3Cold, then it needs to know the power supply. Otherwise, techi=
nically
> the driver cannot put the device into D3Cold. And there is no power suppl=
y
> exposed in DT for most of the rootports/bridges.
>

I think maybe it can be fixed in the power_manageable checking? Since
suspend flow still considers this state. If this returns false due to
being unable to D3cold, pcieport still stays at D0 and would cause
device resume failure.

> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

