Return-Path: <linux-pci+bounces-31242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A0AF1359
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAED64A49F6
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F9244EA0;
	Wed,  2 Jul 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpvQVZkG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E3219A86;
	Wed,  2 Jul 2025 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454673; cv=none; b=KvfV9S8nhoaNGdzZLiHw7svggKPJOFbBfTBROAodL0b7jgDK/wYBoFaj8q80i3iVEj4QEhxq4jGj1CJtBoOv/l2lIkszODasFa4W7HxQcVFTx1MBEFEmBcXhZiamcgvv8ForqSRi/Z7zlxnP/VfI2OfeVKn9evXJJKyIf3YaCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454673; c=relaxed/simple;
	bh=bsMtw3zK5TNgNeh1WODeeWPJyyYiNq3OYiYUWQ3xQbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dThUFdqnW2scouTxTB3z97Nug7rLPbWywO53QPSRF+nqEcwi9OUvOpT2xQrDhEBg1Xko2vvdaxzyryexHrV1FAgBoJUH+XaWFug2okzNVp+aw1mSck+DgajBKHx8vxyr1u5rQeHD9OSM6OA9g8W3WLuU9uE4mZnk7es5N/nzzOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpvQVZkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0DAC4CEF3;
	Wed,  2 Jul 2025 11:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751454673;
	bh=bsMtw3zK5TNgNeh1WODeeWPJyyYiNq3OYiYUWQ3xQbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QpvQVZkG0pyX2a0OZ64i1/52ZJhFl3rNDlcAJTxfuBTXaZkIQF9goRzZMDtYimn7k
	 nTajuMNPsrukIX/7m388eGyIvRSsrIKHalXWmLW0QSAxkrWPFsL+mfV30Km+PUJdLl
	 oExmDXcw3/z5ghwVQgFgxP1GF6KAKTBJ7R5PgEiaa59TJw1RlSo1xv7Qw3XNSuS+YO
	 UHr0oPfEFNdwd704Xne0tOYTRwOri2y8vNCHoC8p/gV2KJRkiTPBfVYH27IW70Rnu6
	 /REMrP/lQSNn0crYTBF2vFO/gDyGGY1UbYN7QJ7XeqkJpIR9Z6MJ4Rtl2p/gWnMESF
	 AVIyLlmDJNEfw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7382a999970so3471047a34.3;
        Wed, 02 Jul 2025 04:11:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrMS4HkLK7uZIFtQTk8v+lUONNjdEKkuvCZyu6J4vsr+yr5Js5gZSL/3c7bPg9fqN2KS7fFZnMOTmR@vger.kernel.org, AJvYcCWxZEV7micPLtb0XjZ9DodPENFvF7KNc1KinqTdxlgilX3w0V85Q+CWB88OP1jqxVkq/spcIvYt60kX@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFjtJM4TBoLHuKBqFwT1oFsvb2tCMO5ubbbrxVY05DKjrU6TO
	4KYlE6YpHy3OkuHFPpPK8JXXMTy//NFQVB6T2kAK59j8BaizctP7hbRdHGeR5FAQREm+zDl2pcN
	vsD33Jg2sxoDU9NZQ8G0MgZZflJtjmJQ=
X-Google-Smtp-Source: AGHT+IGa+Rw/cMy590FiJwiEGqqKmliVcDaetHV3zVOfMk+IIxdLD+NepjMz9wUxEqwLMlQYU2nk4eUA7h0vZMq6H+M=
X-Received: by 2002:a05:6830:6484:b0:72c:320b:fc8c with SMTP id
 46e09a7af769-73b4d1a87fbmr1893227a34.21.1751454672486; Wed, 02 Jul 2025
 04:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-3-badal.nilawar@intel.com> <98fc8402-0bda-4333-8407-75c7a6472375@linux.intel.com>
In-Reply-To: <98fc8402-0bda-4333-8407-75c7a6472375@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 13:11:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hm_UyEEXz+1LYGwGXNi908vYgKw0CD3C=wmBvT=vAh0Q@mail.gmail.com>
X-Gm-Features: Ac12FXxIAduxIODCi3wN-S2nsn3sMmozW1G3nApQ8LgR_4RlnSXYlEMp9tZ3RUs
Message-ID: <CAJZ5v0hm_UyEEXz+1LYGwGXNi908vYgKw0CD3C=wmBvT=vAh0Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	anshuman.gupta@intel.com, rafael@kernel.org, lenb@kernel.org, 
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com, 
	rodrigo.vivi@intel.com, varun.gupta@intel.com, ville.syrjala@linux.intel.com, 
	uma.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 11:41=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 5/29/25 4:16 AM, Badal Nilawar wrote:
> > For given root port allow one Aux power limit request.
> >
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Anshuman Gupta <anshuman.gupta@intel.com>
> > Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> > ---
> >   drivers/acpi/scan.c     |  1 +
> >   drivers/pci/pci-acpi.c  | 25 ++++++++++++++++++++++++-
> >   include/acpi/acpi_bus.h |  2 ++
> >   3 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index fb1fe9f3b1a3..9ae7be9db01a 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -745,6 +745,7 @@ int acpi_device_add(struct acpi_device *device)
> >       INIT_LIST_HEAD(&device->physical_node_list);
> >       INIT_LIST_HEAD(&device->del_list);
> >       mutex_init(&device->physical_node_lock);
> > +     mutex_init(&device->power.aux_pwr_lock);
> >
> >       mutex_lock(&acpi_device_lock);
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 87f30910a5f1..d33efba4ca94 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1451,6 +1451,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_=
dev *dev, u32 requested_power,
> >       union acpi_object *out_obj;
> >       acpi_handle handle;
> >       int result, ret =3D -EINVAL;
> > +     struct acpi_device *adev;
> >
> >       if (!dev || !retry_interval)
> >               return -EINVAL;
> > @@ -1464,11 +1465,27 @@ int pci_acpi_request_d3cold_aux_power(struct pc=
i_dev *dev, u32 requested_power,
> >               return -ENODEV;
> >       }
> >
> > +     adev =3D ACPI_COMPANION(&dev->dev);
> > +     if (!adev)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&adev->power.aux_pwr_lock);
> > +
> > +     /* Check if aux power already granted */
> > +     if (adev->power.aux_power_limit) {
> > +             pci_info(dev, "D3cold Aux Power request already granted: =
%u mW\n",
> > +                      adev->power.aux_power_limit);
> > +             mutex_unlock(&adev->power.aux_pwr_lock);
> > +             return -EPERM;
> > +     }
> > +
> >       out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4=
,
> >                                         DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> >                                         &in_obj, ACPI_TYPE_INTEGER);
> > -     if (!out_obj)
> > +     if (!out_obj) {
> > +             mutex_unlock(&adev->power.aux_pwr_lock);
> >               return -EINVAL;
> > +     }
> >
> >       result =3D out_obj->integer.value;
> >       if (retry_interval)
> > @@ -1478,14 +1495,17 @@ int pci_acpi_request_d3cold_aux_power(struct pc=
i_dev *dev, u32 requested_power,
> >       case 0x0:
> >               pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
> >                       requested_power);
> > +             adev->power.aux_power_limit =3D 0;
> >               break;
> >       case 0x1:
> >               pci_info(dev, "D3cold Aux Power request granted: %u mW\n"=
,
> >                        requested_power);
> > +             adev->power.aux_power_limit =3D requested_power;
> >               ret =3D 0;
> >               break;
> >       case 0x2:
> >               pci_info(dev, "D3cold Aux Power: Main power won't be remo=
ved\n");
> > +             adev->power.aux_power_limit =3D 0;
> >               ret =3D -EBUSY;
> >               break;
> >       default:
> > @@ -1500,9 +1520,12 @@ int pci_acpi_request_d3cold_aux_power(struct pci=
_dev *dev, u32 requested_power,
> >                       pci_err(dev, "D3cold Aux Power: Reserved or unsup=
ported response: 0x%x\n",
> >                               result);
> >               }
> > +             adev->power.aux_power_limit =3D 0;
> >               break;
> >       }
> >
> > +     mutex_unlock(&adev->power.aux_pwr_lock);
> > +
> >       ACPI_FREE(out_obj);
> >       return ret;
> >   }
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index aad1a95e6863..c4ce3d84be00 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -294,6 +294,8 @@ struct acpi_device_power {
> >       struct acpi_device_power_flags flags;
> >       struct acpi_device_power_state states[ACPI_D_STATE_COUNT];      /=
* Power states (D0-D3Cold) */
> >       u8 state_for_enumeration; /* Deepest power state for enumeration =
*/
> > +     u32 aux_power_limit;            /* aux power limit granted by bio=
s */
> > +     struct mutex aux_pwr_lock;      /* prevent concurrent aux power l=
imit requests */
>
>
> Do you need a new lock ?

Yes.

> Is it possible to reuse existing mutex like device_lock()?

No.

Doing such things results in code where nobody knows what the given
lock scope is.

