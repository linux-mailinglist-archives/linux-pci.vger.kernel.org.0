Return-Path: <linux-pci+bounces-31246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1233AF13B3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E4B1C241AC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9C27055A;
	Wed,  2 Jul 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLCFXYr/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB692701D0;
	Wed,  2 Jul 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455276; cv=none; b=evIgunsWXa2zsukYkeQ6v1xbrZ6LUUmNFrPX++AXnODEYfOHML9E74iPlnOY0egqRVOhCt80jOXxLEXUhupyQ56bqYW2zMQcGjtE5rAhh3iQkzgdZJAhsc/EGoHIwI/Me0nr7w+DfeGJLB+iqJEAu8VxJL/N5E3o8QBihx1axEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455276; c=relaxed/simple;
	bh=fgKskA436b6t6iVcOiw9e6fDneyVRrPZE9sZsry4XXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxK1bXsHflpYfkC6gsnPcbnhhq3sAmSNkCZq1j3+tcdHnXjof8zs4c9BYz0uTjPrHmZCFV1iGi/aooLCTv2JjONLtpN5ahmRGnq6vs/Qr0vOPTBJaxXlHFWvWCsjoDQrJB4fj7bJPLbVt3DVdJGDBopUy2ztBKmDRN5BOBRASEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLCFXYr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDBAC4CEF1;
	Wed,  2 Jul 2025 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751455276;
	bh=fgKskA436b6t6iVcOiw9e6fDneyVRrPZE9sZsry4XXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZLCFXYr/m7oGCaDte1ccJtMROzs8Qqz7z54WPPk5PnIXuS988KSG+c6dhxcC9h/ge
	 y2wKB7H/rM2xgJPE3oI5VctU2d0izdRqHrWUssXd+wcwCA67XB93sbE2gHYosl8Mgu
	 8F5IUw9YBH7r/vgqZiCN+r/W/gpdVN918H3IoVxttvVCqeCi6217G2fuhjHJCaoxhr
	 fhyyEIujx9VwCr8ReUISLsF4iL4Woo8OnQmzdcXfKo5ob/13WG0X+FpbDIv9tmHPfN
	 iXXHrCiJ/GDdYVHOqdd7eOmA4n0uiO0e/Md4f3H0ktwVk2PQ1IX/fjyCzIQabuxXLX
	 edSnl3SwQ2wtw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-610db3f3f90so3130078eaf.2;
        Wed, 02 Jul 2025 04:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUa0jjq7mgyfosp8XFf6mjFC7zKTfKk+SnA8aB/7x1QrSW+5zGjx81XCwGIxW4UfZQOvODX9WFj10HA@vger.kernel.org, AJvYcCV3TDvo++fitQqfqPEM65MAsihpbQZAAV6R4iwynBVYaqEcIHO2f6nkKUk+Bd7M5ug8WXcP+TndUZPK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hIxaVEGfNhkT5XjhLv5pEK5rolPUnRa6jD8s3vD4OLTPESrk
	MO12shIJ/Agb9rs35mK+D1s7loAiVBmGGibktLv4mIXib8lMo/b28NLnft4XXSn+6eKbRROt+LV
	rflwLQpBtFVL4LQn0aMQk3K8ZEbibDz8=
X-Google-Smtp-Source: AGHT+IEbThx4tZ5F3NTymMSVaG796qBbxJWgnti1/XhvkHWXzJSleHS3eo77NT65NZRALQhzK08fYSI+NxNwgLzx6ng=
X-Received: by 2002:a4a:ca89:0:b0:611:aabf:2b7d with SMTP id
 006d021491bc7-612012d05e1mr1354692eaf.7.1751455275305; Wed, 02 Jul 2025
 04:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529111654.3140766-1-badal.nilawar@intel.com> <20250529111654.3140766-3-badal.nilawar@intel.com>
In-Reply-To: <20250529111654.3140766-3-badal.nilawar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 13:21:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0izykarC5yXNbd=Gdycfk7Qdy+U8uehhHK0bmXbt40O2g@mail.gmail.com>
X-Gm-Features: Ac12FXyRmp-p5k074rpMsRndPCpQ1djbtbuPofaUrn03pa7aEY-2USgcW4kg6xM
Message-ID: <CAJZ5v0izykarC5yXNbd=Gdycfk7Qdy+U8uehhHK0bmXbt40O2g@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com, rafael@kernel.org, 
	lenb@kernel.org, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 1:14=E2=80=AFPM Badal Nilawar <badal.nilawar@intel.=
com> wrote:
>
> For given root port allow one Aux power limit request.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>  drivers/acpi/scan.c     |  1 +
>  drivers/pci/pci-acpi.c  | 25 ++++++++++++++++++++++++-
>  include/acpi/acpi_bus.h |  2 ++
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..9ae7be9db01a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -745,6 +745,7 @@ int acpi_device_add(struct acpi_device *device)
>         INIT_LIST_HEAD(&device->physical_node_list);
>         INIT_LIST_HEAD(&device->del_list);
>         mutex_init(&device->physical_node_lock);
> +       mutex_init(&device->power.aux_pwr_lock);
>
>         mutex_lock(&acpi_device_lock);
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 87f30910a5f1..d33efba4ca94 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1451,6 +1451,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_de=
v *dev, u32 requested_power,
>         union acpi_object *out_obj;
>         acpi_handle handle;
>         int result, ret =3D -EINVAL;
> +       struct acpi_device *adev;
>
>         if (!dev || !retry_interval)
>                 return -EINVAL;
> @@ -1464,11 +1465,27 @@ int pci_acpi_request_d3cold_aux_power(struct pci_=
dev *dev, u32 requested_power,
>                 return -ENODEV;
>         }
>
> +       adev =3D ACPI_COMPANION(&dev->dev);
> +       if (!adev)
> +               return -EINVAL;
> +
> +       mutex_lock(&adev->power.aux_pwr_lock);

Use a mutex locking guard for this new lock, please.

> +
> +       /* Check if aux power already granted */
> +       if (adev->power.aux_power_limit) {
> +               pci_info(dev, "D3cold Aux Power request already granted: =
%u mW\n",
> +                        adev->power.aux_power_limit);
> +               mutex_unlock(&adev->power.aux_pwr_lock);
> +               return -EPERM;

Maybe -EALREADY?

> +       }
> +
>         out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4=
,
>                                           DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>                                           &in_obj, ACPI_TYPE_INTEGER);
> -       if (!out_obj)
> +       if (!out_obj) {
> +               mutex_unlock(&adev->power.aux_pwr_lock);
>                 return -EINVAL;
> +       }
>
>         result =3D out_obj->integer.value;
>         if (retry_interval)
> @@ -1478,14 +1495,17 @@ int pci_acpi_request_d3cold_aux_power(struct pci_=
dev *dev, u32 requested_power,
>         case 0x0:
>                 pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>                         requested_power);
> +               adev->power.aux_power_limit =3D 0;
>                 break;
>         case 0x1:
>                 pci_info(dev, "D3cold Aux Power request granted: %u mW\n"=
,
>                          requested_power);
> +               adev->power.aux_power_limit =3D requested_power;
>                 ret =3D 0;
>                 break;
>         case 0x2:
>                 pci_info(dev, "D3cold Aux Power: Main power won't be remo=
ved\n");
> +               adev->power.aux_power_limit =3D 0;
>                 ret =3D -EBUSY;
>                 break;
>         default:
> @@ -1500,9 +1520,12 @@ int pci_acpi_request_d3cold_aux_power(struct pci_d=
ev *dev, u32 requested_power,
>                         pci_err(dev, "D3cold Aux Power: Reserved or unsup=
ported response: 0x%x\n",
>                                 result);
>                 }
> +               adev->power.aux_power_limit =3D 0;
>                 break;
>         }
>
> +       mutex_unlock(&adev->power.aux_pwr_lock);
> +
>         ACPI_FREE(out_obj);
>         return ret;
>  }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..c4ce3d84be00 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -294,6 +294,8 @@ struct acpi_device_power {
>         struct acpi_device_power_flags flags;
>         struct acpi_device_power_state states[ACPI_D_STATE_COUNT];      /=
* Power states (D0-D3Cold) */
>         u8 state_for_enumeration; /* Deepest power state for enumeration =
*/
> +       u32 aux_power_limit;            /* aux power limit granted by bio=
s */
> +       struct mutex aux_pwr_lock;      /* prevent concurrent aux power l=
imit requests */
>  };
>
>  struct acpi_dep_data {
> --
> 2.34.1
>

