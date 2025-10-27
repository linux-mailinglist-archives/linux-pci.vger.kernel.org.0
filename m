Return-Path: <linux-pci+bounces-39460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789BC10D2B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 540FF5073C5
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9407E32D7C7;
	Mon, 27 Oct 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEX6lAVF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDCF2C15BB
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592324; cv=none; b=P57ANPZH3AXUH07Q8DO5ACqDfiCXenvnQjqgSO5jcK4x/qj0gsTw4VKf/+y3bukO0OLLY4xCnT7tiqa7iStT+lG4tUPJbUpF3BiMTnI+Gp8SCgEth9UAcqpLQUkiVD4OJZ3STp1OG43hWuAHIBgGKNjdvFuv0gMEArLNqM0AzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592324; c=relaxed/simple;
	bh=Yk5bCvyoIhck1IsHtW1GjnSEubDvy93rYurC0A+0mKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=by6s5OLsBrL6AG7tuCn2b0xldE8/6tz1A6K77/CZoQlcf4YHxNQOMXDZh61zNse7P46/+8CLMkT+oRi2C0LGk7IBk5WOhfK52uVyUJMOwNjeCrk53Sa9uHrbsmqdZpDBgMcLStIN+0GJLFDXpu3fq6sRkrG1ZIkepSdeS+zlLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEX6lAVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3430FC19422
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592324;
	bh=Yk5bCvyoIhck1IsHtW1GjnSEubDvy93rYurC0A+0mKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZEX6lAVFROyr7DXh1l1qatVv5OWNzbdQDOq+VbHYfINJ3/ahU446ah24IWjDRj0oW
	 JbAkQX5mXhOYqu4Yv6cwA7Uk+qNe+jHiP8xjfOrnFWcSIeD/BtqiOazw5/SPw55njI
	 MfdB9thW4ImJ55eSqW/kzQJaTL4HzAB3UTcaOrEEhhk/r3vuRz1FxbXQ0oJFR/Q706
	 lRySFvAo3gaU8UFYfwSB3K+MadOQC2mJ3m6T3WxcljLqBkVUpfMjxEDXxCl7O7+fAL
	 7SycXSQFyx1QsgHTDsN4hxCXx5ZdBHcSCrlTQkuG84vPaCQMCQjGLPntFk/ttNKJcG
	 yM7x68w/6dIxQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c531445494so1821220a34.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 12:12:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVVlhfbTZPIcEDKUbPhd4PabiO8E7IA0uVy3jqjNay0Gy/YhbqiEgvlSEIXuTO5KldE3t3YLx0PUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtHnTpVAbq97qusjhqN5vuiyWbnUjL8m6whBvlsZocT/Etfil
	3fIbQowfFCGvuZezBUloss4LJvfFY9qDOeVEzJ3LVtmffnkIxP4NhES1zGLifaCmFWmDGQJy6aV
	HDQC5qrj7eQBZR8Y8nri2EGZePH+eNLI=
X-Google-Smtp-Source: AGHT+IGj95WjixoYNKSXMWsRjFCr6mKjst4+LEjYC3fqtfHJbiNM1Q8lY0Bm1Iv4z+jhi3Aq9f9e4dGobB6I6tvM9Xg=
X-Received: by 2002:a05:6808:6d90:b0:437:eb1d:cdde with SMTP id
 5614622812f47-44f6bae3bcemr359787b6e.33.1761592323393; Mon, 27 Oct 2025
 12:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015080710.1468409-1-badal.nilawar@intel.com> <20251015080710.1468409-3-badal.nilawar@intel.com>
In-Reply-To: <20251015080710.1468409-3-badal.nilawar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:11:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ggTNajjOcXCLKvLXgsLPvsjKJTXM_2F6_bg1JNhdBfbw@mail.gmail.com>
X-Gm-Features: AWmQ_bl9t6HQufoJcwZl2Kx-tU0yNBtYR5woQH8NIhLZ2_h1qTrjbbFR-ln8fOo
Message-ID: <CAJZ5v0ggTNajjOcXCLKvLXgsLPvsjKJTXM_2F6_bg1JNhdBfbw@mail.gmail.com>
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

I would prefer this one to be folded into the previous patch.  It
would be easier to review for me then.

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

Why this error code?

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

I forgot to ask about this when reviewing the previous patch: Is it
really an error situation?

The AML tells you that main power is not going to be removed, so aux
power is not necessary.  Why would it be a problem?

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

Call this aux_power_dev, please.

> +       struct mutex aux_pwr_lock;      /* prevent concurrent aux power l=
imit requests */
>  };
>
>  struct acpi_dep_data {
> --

Is there a way to revoke a previously requested aux power limit?

