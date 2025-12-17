Return-Path: <linux-pci+bounces-43172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08235CC854D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F25305A802
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6204203710;
	Wed, 17 Dec 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IACCM4D6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3C133556A
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982754; cv=none; b=UegX1tgFkRCvO7Y+aI5RsqNpxxkPC3cW/zR7+1PE8YKC1DuKRveSbshHxJIXV2+oj4AFc7q0JFQAduDkxqg4kBEqkjRnaGac/mOK3Tvsgy1sVpCGNdUh2e4xKHiR3qTu7W2ZLaxy1viB0v3Ej2+KSjQVzml7mJkQAwIn8Zi/azo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982754; c=relaxed/simple;
	bh=Uj7Jw3bncBxQcTu24XpGcQ5wlaHtL0/IWdbHSJUyeAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ9Vr24KPuP/J4F6Ib5b9gzu8s4moDiNwmbQnt7JzI2AsHhim2GPVqOcSyyAY+WBmTGDaRvE7z7KVZWtehZsL8RfGjMV0FRY56fJQ1rHKYTo8EPlbICzmu+LUS42ECFPO0KgCFZtRUsY8QQMokAzCJx2oBJsj4h49UoQoAHztbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IACCM4D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2235CC4CEF5
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765982754;
	bh=Uj7Jw3bncBxQcTu24XpGcQ5wlaHtL0/IWdbHSJUyeAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IACCM4D61JuktvxKtKybvg9PGVdrAZm+MI3xSTbym1oXs9qGhlkkVUfFWt8QdEqVg
	 rvQs43htlWRxHIn5Cx+uOvkuUAi6DZdkg0kSiqYQxvl6nOF3hAGpCOD/y8ZKWAhXtV
	 pgYl9ewooQiO3TM1JdB9e3LclxzP/sKzzW8xRot+KLOV1IoDA7D/TZsAp511+8uAPZ
	 qaOz2EZaiArvkcSRwPTae5NeNH0tyecH5/6Tx0xrckv4sTytVUsDoPX+MJIVQ1uSvg
	 wJG8B64fHbpyx7uq0rx7odnbzYRf7Qyfe5J+gX+uhQ71JxN0OIbCN9WjhfBJlNWmAO
	 ohNESUmyZvQHQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c7533dbd87so4981912a34.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 06:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpLSJN+U9m54WRkn7pBoYW6utGQYZpQHwB7Y7kx8HdldHw5y2tgU3fhzeUoHy5WGFU+NKEO7cVBs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSc6RdJW12T2DPASvgLJwpZ9aMMj7kHQr7eAFVB9ygQjaAbDvk
	ma44sHRmFq5Li3pXZma/NF833yhTPQUvjeiKOtvNa2OlBa4zD0FNk+i5wTtsH4R5NoDymPiQdjv
	a0HyRmlvCLq1FhNVwmd9VFsTx0WbZkh0=
X-Google-Smtp-Source: AGHT+IGru571n6LEQRQcP3oWM3KWt3LuuRTYuBI1b7zy9ahwnzID+Z1zO4ejogcUX3WIGEvnl9hOFuDYJYjxL430aVE=
X-Received: by 2002:a05:6820:2201:b0:659:9a49:8eb2 with SMTP id
 006d021491bc7-65b4523b585mr7664762eaf.54.1765982752979; Wed, 17 Dec 2025
 06:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015080710.1468409-1-badal.nilawar@intel.com> <20251015080710.1468409-3-badal.nilawar@intel.com>
In-Reply-To: <20251015080710.1468409-3-badal.nilawar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Dec 2025 15:45:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0itN6X-_vRTbNsaUPkYMZB5KQGDgX3=3oSeq_DkxB7drw@mail.gmail.com>
X-Gm-Features: AQt7F2pgXVF39xZ30iWTdXcNXovHLxA7Mbsd-D9NbtqAfNiN3IUzyVoKlWqsRSE
Message-ID: <CAJZ5v0itN6X-_vRTbNsaUPkYMZB5KQGDgX3=3oSeq_DkxB7drw@mail.gmail.com>
Subject: Re: [PATCH v5 02/12] PCI/ACPI: Per Root/Switch Downstream Port allow
 one aux power limit request
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com, rafael@kernel.org, 
	lenb@kernel.org, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com, karthik.poosa@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:02=E2=80=AFAM Badal Nilawar <badal.nilawar@intel=
.com> wrote:
>
> Since aggregation of auxiliary power across multiple devices under a
> Root or Switch Downstream Port is not supported, allow only one device
> is to request auxiliary power
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>

Sorry for the long delay, but in addition to the comments posted
earlier, I have some more to say regarding this patch (see below).

> ---
> V1:
>  - Use guard(mutex) for new mutex (Rafael)
>  - Add mutex_detroy (Ilpo J=C3=A4rvinen)
>  - %s/pci_warn/pci_info/ for -EAGAIN
>  - Allow the same device to re-request auxiliary power if it has already =
been granted
> ---
>  drivers/acpi/scan.c     |  3 +++
>  drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  3 +++
>  3 files changed, 28 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ef16d58b2949..4573fb0f4f3e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -518,6 +518,7 @@ static void acpi_device_release(struct device *dev)
>         acpi_free_properties(acpi_dev);
>         acpi_free_pnp_ids(&acpi_dev->pnp);
>         acpi_free_power_resources_lists(acpi_dev);
> +       mutex_destroy(&acpi_dev->power.aux_pwr_lock);
>         kfree(acpi_dev);
>  }
>
> @@ -746,6 +747,8 @@ int acpi_device_add(struct acpi_device *device)
>         INIT_LIST_HEAD(&device->physical_node_list);
>         INIT_LIST_HEAD(&device->del_list);
>         mutex_init(&device->physical_node_lock);
> +       mutex_init(&device->power.aux_pwr_lock);
> +       device->power.dev =3D NULL;
>
>         mutex_lock(&acpi_device_lock);
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index c7eab1e75dd5..74f118016b1d 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1477,6 +1477,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_de=
v *dev, u32 requested_mw,
>         union acpi_object *out_obj;
>         int result, ret =3D -EINVAL;
>         struct pci_dev *bdev;
> +       struct acpi_device *adev;
>
>         if (!dev || PCI_FUNC(dev->devfn) !=3D 0)
>                 return -EINVAL;
> @@ -1486,6 +1487,19 @@ int pci_acpi_request_d3cold_aux_power(struct pci_d=
ev *dev, u32 requested_mw,
>         if (IS_ERR(bdev))
>                 return PTR_ERR(bdev);
>
> +       adev =3D ACPI_COMPANION(&bdev->dev);
> +       if (!adev)
> +               return -EINVAL;
> +
> +       guard(mutex)(&adev->power.aux_pwr_lock);
> +
> +       /* Check if aux power already granted to different device */
> +       if (adev->power.dev && adev->power.dev !=3D &dev->dev) {
> +               pci_info(to_pci_dev(adev->power.dev), "D3cold Aux Power r=
equest already granted: %u mW\n",
> +                        adev->power.aux_power_limit);
> +               return -EPERM;
> +       }
> +
>         out_obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
>                                           &pci_acpi_dsm_guid, 4,
>                                           DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> @@ -1501,14 +1515,20 @@ int pci_acpi_request_d3cold_aux_power(struct pci_=
dev *dev, u32 requested_mw,
>         case AUX_PWR_REQ_DENIED:
>                 pci_dbg(bdev, "D3cold Aux Power %u mW request denied\n",
>                         requested_mw);
> +               adev->power.aux_power_limit =3D 0;
> +               adev->power.dev =3D NULL;
>                 break;
>         case AUX_PWR_REQ_GRANTED:
>                 pci_info(bdev, "D3cold Aux Power request granted: %u mW\n=
",
>                          requested_mw);
> +               adev->power.aux_power_limit =3D requested_mw;
> +               adev->power.dev =3D &dev->dev;
>                 ret =3D 0;
>                 break;
>         case AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL:
>                 pci_info(bdev, "D3cold Aux Power: Main power won't be rem=
oved\n");
> +               adev->power.aux_power_limit =3D 0;
> +               adev->power.dev =3D NULL;
>                 ret =3D -EBUSY;
>                 break;
>         default:
> @@ -1524,6 +1544,8 @@ int pci_acpi_request_d3cold_aux_power(struct pci_de=
v *dev, u32 requested_mw,
>                         pci_err(bdev, "D3cold Aux Power: Reserved or unsu=
pported response: 0x%x\n",
>                                 result);
>                 }
> +               adev->power.aux_power_limit =3D 0;
> +               adev->power.dev =3D NULL;
>                 break;
>         }
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..cfa0c7233f13 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -294,6 +294,9 @@ struct acpi_device_power {
>         struct acpi_device_power_flags flags;
>         struct acpi_device_power_state states[ACPI_D_STATE_COUNT];      /=
* Power states (D0-D3Cold) */
>         u8 state_for_enumeration; /* Deepest power state for enumeration =
*/
> +       u32 aux_power_limit;            /* aux power limit granted by pla=
tform firmware */
> +       struct device *dev;             /* device to which aux power is g=
ranted */
> +       struct mutex aux_pwr_lock;      /* prevent concurrent aux power l=
imit requests */
>  };

So this adds a u32, a device pointer, and a mutex structure to every
struct acpi_device object in the system even on systems that don't
care about the use case at hand at all.

You need to find a different way to attach the information needed to
synchronize the aux power requests to the PCI bridge the _DSM is
evaluated for, sorry.

