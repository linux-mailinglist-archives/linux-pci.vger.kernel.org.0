Return-Path: <linux-pci+bounces-24886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A00A73E58
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 20:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F040A3BB80B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36301BCA0E;
	Thu, 27 Mar 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcjxtNcR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1F1B4233;
	Thu, 27 Mar 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102326; cv=none; b=eC1gi4tjMQQUbdfePhF28GscgmPVh3I2i+KKv80rrXugiH64K7Q9v/XhCJCqlPjfel+ow8qAtnYNUpSzUb7Km1936sn4VlQd91SK7r80bAv7wQRjldANRXT+bafLizYy6St5lr0+RzX3AnGdiKI9WGlDu+iZbW4vKR5Mbogek94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102326; c=relaxed/simple;
	bh=royO+w2c6N9+Ae4O+8R9pvu8Oa6kniOImOeVjP+Vgo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkksAwGwate//vSXS9GhWJpbW3U6JibjtrMtOX8D+QlbHvPkLKKQ61EMUia4eboqeShbPH19NxNI35QJb6Ud4VuhWP8/efFXX0+L54EH2zH66lRZGpA6cyVRKsi+QKwQQ1RhQVfH7pSU7z9KV6P2lZ+6ttrhoVBikNh4+OzBgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcjxtNcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F967C4CEEA;
	Thu, 27 Mar 2025 19:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743102326;
	bh=royO+w2c6N9+Ae4O+8R9pvu8Oa6kniOImOeVjP+Vgo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BcjxtNcRk2a5gj9Jo1yGk5c+nyUjO85bmg20mflzNVETdkhRNzqBplv5rk+268ab4
	 ewCGop7tC8fSB/BzZh8iVsUUDVMHdIKUI/FQYOUyUiGSrAwHMTM970qh0lnbriiLG+
	 ouyZQ8HbWjli9nOdyoojRGRXqti2QAfOQiVu95udrxkAAjUy0YeR3YeQKfiHRjvDGC
	 wTYtGQoYLKd9WTnBW3jCgBsOTONvYNglI+yixuA59dRTOWq5y+qeX1xtllRCWFc6A/
	 Qa75ypbXEVtgOx96jJzwIfqJg9vHwmyqZ7zukFXMcbd54WoVm8z/wtigjt36oPw3Da
	 gA7URGLk5xUCg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c769da02b0so727580fac.3;
        Thu, 27 Mar 2025 12:05:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsDycktYPzZQuQmpHNzkgQ0MtvopmtfXFaI6cBRKwoa4aX22WE5FuCqOk8dDQ3BO1hPnmYWcGGrkt8@vger.kernel.org, AJvYcCWKdYLmxZ7fqzHPWGLe4gTKlIy7C/tGQ3o8e3TQieGUoUoGpMLtFV/WPYWF7VBzJjlbJ7yk8A5GkSLG@vger.kernel.org, AJvYcCXckiE6R+THC6S/3hhWst8hhyejYnm7sT453ykgYYFFhxv04JX84yBfQp5H9U2g7nx4J5aAHY8afw/ByHSN@vger.kernel.org
X-Gm-Message-State: AOJu0YyiK/Z/tNl7Vjx9gzQN3xuyRKOOelvj1t1wPGEVK4C1YI98U5Sv
	HFNlTJhECZcyHKLHZF/47nljWSrTEn9jGqmMWx9B4GXPIBbxbXWhuzrWvAX1GslQgOWWhYYFkNH
	hXs8WtHdB2mJNMB0LtDSdOunV5u0=
X-Google-Smtp-Source: AGHT+IE/2aQJNTEVm5F9T/mY1JuTqpsVUFboEGKZv4C9PsotATB3DZ4H6GW/BJBYunP13VbST/P9FXomPk09bn2SKG4=
X-Received: by 2002:a05:6870:2891:b0:29e:569a:f90d with SMTP id
 586e51a60fabf-2c84823dfeamr3093612fac.32.1743102325633; Thu, 27 Mar 2025
 12:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313100658.15805-1-zhoushengqing@ttyinfo.com> <CAJZ5v0jBrTuuf_RJ45Eu2OwpRNXS-hFyL-PxGMv2K+jYVQtn2w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jBrTuuf_RJ45Eu2OwpRNXS-hFyL-PxGMv2K+jYVQtn2w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 20:05:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gd5-QfbLhneYKJxER6XC1aDE8KxvX5j695=FdZWHc-kQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoKVaAeBmRAv4MMHbTxt02rfq6mRQYHxuSVaxLpnITNa1jOYmm9ErObqDQ
Message-ID: <CAJZ5v0gd5-QfbLhneYKJxER6XC1aDE8KxvX5j695=FdZWHc-kQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Add rev 2 check for PRESERVE_BOOT_CONFIG function
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 7:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Mar 13, 2025 at 11:07=E2=80=AFAM Zhou Shengqing
> <zhoushengqing@ttyinfo.com> wrote:
> >
> > Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> > for PCI. Preserve PCI Boot Configuration Initial Revision ID changed to=
 2.
> >
> > And add acpi_check_dsm() for DSM_PCI_PRESERVE_BOOT_CONFIG.
> >
> > Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> > ---
> > v5:follow Bjorn advice, add acpi_check_dsm for PCI _DSM.
> > v4:Initialize *obj to NULL.
> > v3:try revision id 1 first, then try revision id 2.
> > v2:add Fixes tag.
> >
> > Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to=
 pci_re")
> > ---
> >  drivers/pci/pci-acpi.c | 43 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 31 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index af370628e583..4f9e0548c96d 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -122,24 +122,43 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_hand=
le handle)
> >
> >  bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
> >  {
> > -       if (ACPI_HANDLE(&host_bridge->dev)) {
> > -               union acpi_object *obj;
> > +       bool rc =3D false;
> > +       union acpi_object *obj;
>
> + u64 rev;
>
> >
> > -               /*
> > -                * Evaluate the "PCI Boot Configuration" _DSM Function.=
  If it
> > -                * exists and returns 0, we must preserve any PCI resou=
rce
> > -                * assignments made by firmware for this host bridge.
> > -                */
> > +       if (!ACPI_HANDLE(&host_bridge->dev))
> > +               return false;
> > +
> > +       /*
> > +        * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> > +        * exists and returns 0, we must preserve any PCI resource
> > +        * assignments made by firmware for this host bridge.
> > +        *
> > +        * Per PCI Firmware r3.2, released Jan 26, 2015,
> > +        * DSM_PCI_PRESERVE_BOOT_CONFIG Revision ID is 1. But PCI Firmw=
are r3.3,
> > +        * released Jan 20, 2021, changed sec 4.6.5 to say
> > +        * "lowest valid Revision ID value: 2". So check rev 1 first, t=
hen rev 2.
> > +        */
>
> +         for (rev =3D 1; rev <=3D 2; rev++) {
> +                 if (!acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
> &pci_acpi_dsm_guid,
> +                                   rev, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG=
)))
> +                         continue;
> +
> +                obj =3D
> acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev), ,
> &pci_acpi_dsm_guid,
> +                                  rev, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG)=
);

Of course, the above acpi_evaluate_dsm_typed() call has been
messed-up, it should be

obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev),
                                  &pci_acpi_dsm_guid, rev,
                                  DSM_PCI_PRESERVE_BOOT_CONFIG,
                                 NULL, ACPI_TYPE_INTEGER);

but the idea should be clear nevertheless.

> +                if (obj && obj->integer.value =3D=3D 0)
> +                        rc =3D true;
> +
> +                ACPI_FREE(obj);
> +
> +                if (rc)
> +                       return true;
> +         }
> +
> +         return false;
>
> would achieve the same with fewer lines of code and less code
> duplication if I'm not mistaken.
>
> > +       if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
> > +                               &pci_acpi_dsm_guid, 1, BIT(DSM_PCI_PRES=
ERVE_BOOT_CONFIG))) {
> >                 obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridg=
e->dev),
> > -                                             &pci_acpi_dsm_guid,
> > -                                             1, DSM_PCI_PRESERVE_BOOT_=
CONFIG,
> > -                                             NULL, ACPI_TYPE_INTEGER);
> > +                                               &pci_acpi_dsm_guid,
> > +                                               1, DSM_PCI_PRESERVE_BOO=
T_CONFIG,
> > +                                               NULL, ACPI_TYPE_INTEGER=
);
> >                 if (obj && obj->integer.value =3D=3D 0)
> > -                       return true;
> > +                       rc =3D true;
> > +               ACPI_FREE(obj);
> > +       } else if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
> > +                                       &pci_acpi_dsm_guid, 2, BIT(DSM_=
PCI_PRESERVE_BOOT_CONFIG))) {
> > +               obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridg=
e->dev),
> > +                                               &pci_acpi_dsm_guid,
> > +                                               2, DSM_PCI_PRESERVE_BOO=
T_CONFIG,
> > +                                               NULL, ACPI_TYPE_INTEGER=
);
> > +               if (obj && obj->integer.value =3D=3D 0)
> > +                       rc =3D true;
> >                 ACPI_FREE(obj);
> >         }
> >
> > -       return false;
> > +       return rc;
> >  }
> >
> >  /* _HPX PCI Setting Record (Type 0); same as _HPP */
> > --

