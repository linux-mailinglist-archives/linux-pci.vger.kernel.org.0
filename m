Return-Path: <linux-pci+bounces-31241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C488CAF1352
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4E83B0D51
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F53D253B7E;
	Wed,  2 Jul 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks6SUZYB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E60236A9F;
	Wed,  2 Jul 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454501; cv=none; b=lUkYIAy+lXbeYuV4C2FSDFaxpmdgJY6AzdZ32R2c1++HpA5E7chjIOOyCq1zox2stJKx9ICEI9lPtB6Pq+zrdLamPeI/ssciK/AyDCUPxH/0qLbgOmHY6/qQHmr/qVWLAOloAHAH5cGc35OuIDVPL3Q95+ksXsgnSsqZwwpzwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454501; c=relaxed/simple;
	bh=pGAsTwO4nedv4ZptOpPXY0xiBm1d9gCL8IfkcvWQVIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEa/2KHhe/spEzPNqMG0IN9lT8gvl0sWQX+9WewQBgtYtyRfwszqhM4uO8X7nr1wZK+SKo7CxMGXpoGp1ymnzhjT8MdfSY2NO6oEvXIj/pru8t7hYvsJOUfTiUNbu6jytLLq3zxphMUjUcGKgEl6/qWvfelVN0m9YaGrLV6AHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks6SUZYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC785C4CEF0;
	Wed,  2 Jul 2025 11:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751454501;
	bh=pGAsTwO4nedv4ZptOpPXY0xiBm1d9gCL8IfkcvWQVIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ks6SUZYBQhwE27ILoyNKcU94ZusLykB6qbwxZtjuinKo8gIxJi7VBzDXzv+DTcr4v
	 L4o8S46mr4M68cT8nI0t7N8AXCDMZD2SzV4f/K04P769URLWERtg3l93vwvlJMeGnJ
	 CUDrP2S6mU8IgrS01gnNvBRS7lJmxBKQ8QNFU9ThnRAsc4QqIc/6oEuPLTwutakM0D
	 7ltx0V9vBftux18n8G6ifb8zWwhOAWocXws/sxwE8dk25QT+qgNKrVpyUufq4MreU2
	 MBAkri1KWjjK1Rt5MsDSQ9A8fxdGhy3ys7yK0n9qMAqIKQiWw6bfPblGssWN9ehmzI
	 Ln11vTxi+LOyA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6120049f09fso423382eaf.2;
        Wed, 02 Jul 2025 04:08:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWl33DqUASuwUwP8nwAJngblD9efWqgqpUMbr2JKM8kP6kc2pQjcu2cSBXTrcNg7FNb1F3qL+nHNnT4@vger.kernel.org, AJvYcCXIz5ofl6xaoreYqTElnLOlVjT+BQgNcrf2/DohPy6RyHR7u07va0riFXWDpuNiaKTzrTGkr5FKic6Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5ngJ+IbaJiFx8GaLOHP8Hvxr9fYgGtbSfIE1OEKa+0c6n+MM
	T0lGoY8oI1XVorxv0uVnOGiuNbZFZXn93uIXMlfZrKxzxQRqKLHjkL4f6Afu9XDpw4RbDQGf+iW
	MFUPj0rsj9cMsasex0W+6aJd1uSOVDDk=
X-Google-Smtp-Source: AGHT+IHkIVCnmJgkGAu7G1qnWZGAGZtxEA3UbZ+srtYNJgnEnqT01JZaI/4hnS1PgFDjZXHE0guv+7GKe7AGEeeYKPY=
X-Received: by 2002:a05:6820:150f:b0:611:e31c:5d23 with SMTP id
 006d021491bc7-612010c1539mr1515499eaf.4.1751454500115; Wed, 02 Jul 2025
 04:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529111654.3140766-1-badal.nilawar@intel.com> <20250529111654.3140766-2-badal.nilawar@intel.com>
In-Reply-To: <20250529111654.3140766-2-badal.nilawar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 13:08:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7BENMDCOHVD6ZdF7o1OwE=RAOzkC0+r+G=-3qpjfn0Q@mail.gmail.com>
X-Gm-Features: Ac12FXxPFu3QcdhDxeEnqZD1NVDJtj98rI7oLIBr9DAoZ9EA3vlsdPhbwF6SqU8
Message-ID: <CAJZ5v0h7BENMDCOHVD6ZdF7o1OwE=RAOzkC0+r+G=-3qpjfn0Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
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
> From: Anshuman Gupta <anshuman.gupta@intel.com>
>
> Implement _DSM method 0Ah according to PCI firmware specifications,
> section 4.6.10 Rev 3.3., to request auxilary power needed for the
> device when in D3Cold.
>
> Note that this implementation assumes only a single device below the
> Downstream Port will request for Aux Power Limit under a given
> Root Port because it does not track and aggregate requests
> from all child devices below the Downstream Port as required
> by Section 4.6.10 Rev 3.3.
>
> One possible mitigation would be only allowing only first PCIe
> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
>
> Signed-off-by: Varun Gupta <varun.gupta@intel.com>

What's this S-o-b for?

> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> V2(Bjorn/Rafael):
>   - Call acpi_dsm_check() to find method 0Ah supported
>   - Return retry interval to caller
> V3(Kuppuswamy)
>   - Add NULL check for retry interval
> ---
>  drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  8 ++++
>  2 files changed, 95 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..87f30910a5f1 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct pci_dev=
 *pdev,
>         ACPI_FREE(obj);
>  }
>
> +/**
> + * pci_acpi_request_d3cold_aux_power - Request aux power while device is=
 in D3Cold
> + * @dev: PCI device instance
> + * @requested_power: Requested auxiliary power in milliwatts
> + * @retry_interval: Retry interval returned by platform to retry auxilia=
ry
> + *                  power request
> + *
> + * This function sends a request to the host BIOS via root port ACPI _DS=
M Function 0Ah
> + * for the auxiliary power needed by the PCI device when it is in D3Cold=
.
> + * It checks and evaluates the _DSM (Device Specific Method) to request =
the auxiliary
> + * power and handles the response accordingly.
> + *
> + * This function shall be only called by 1st non-bridge Endpoint driver
> + * on Function 0. For a Multi-Function Device, the driver for Function 0=
 is
> + * required to report an aggregate power requirement covering all
> + * functions contained within the device.
> + *
> + * Return: Returns 0 on success and errno on failure.
> + */
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested=
_power,
> +                                     u32 *retry_interval)
> +{
> +       union acpi_object in_obj =3D {
> +               .integer.type =3D ACPI_TYPE_INTEGER,
> +               .integer.value =3D requested_power,
> +       };
> +
> +       union acpi_object *out_obj;
> +       acpi_handle handle;
> +       int result, ret =3D -EINVAL;
> +
> +       if (!dev || !retry_interval)
> +               return -EINVAL;
> +
> +       handle =3D ACPI_HANDLE(&dev->dev);
> +       if (!handle)
> +               return -EINVAL;
> +
> +       if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_D=
3COLD_AUX_POWER_LIMIT)) {
> +               pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_D3=
COLD_AUX_POWER_LIMIT);
> +               return -ENODEV;
> +       }
> +
> +       out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4=
,
> +                                         DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> +                                         &in_obj, ACPI_TYPE_INTEGER);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       result =3D out_obj->integer.value;
> +       if (retry_interval)
> +               *retry_interval =3D 0;
> +
> +       switch (result) {
> +       case 0x0:

It would be better to use an enum for the possible return values.

> +               pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
> +                       requested_power);
> +               break;
> +       case 0x1:
> +               pci_info(dev, "D3cold Aux Power request granted: %u mW\n"=
,
> +                        requested_power);
> +               ret =3D 0;
> +               break;
> +       case 0x2:
> +               pci_info(dev, "D3cold Aux Power: Main power won't be remo=
ved\n");
> +               ret =3D -EBUSY;
> +               break;
> +       default:
> +               if (result >=3D 0x11 && result <=3D 0x1F) {

if (!(result & ~0x1F))

I think, and it would be better to use a symbol for this mask (and below to=
o).

> +                       if (retry_interval) {

This has been checked already and is guaranteed to be nonzero at this point=
.

> +                               *retry_interval =3D result & 0xF;
> +                               pci_warn(dev, "D3cold Aux Power request n=
eeds retry interval: %u seconds\n",
> +                                        *retry_interval);
> +                               ret =3D -EAGAIN;
> +                       }
> +               } else {
> +                       pci_err(dev, "D3cold Aux Power: Reserved or unsup=
ported response: 0x%x\n",
> +                               result);
> +               }
> +               break;
> +       }
> +
> +       ACPI_FREE(out_obj);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
> +
>  static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>         u8 val;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 078225b514d4..6079306ad754 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_DEVICE_NAME                    0x07
>  #define DSM_PCI_POWER_ON_RESET_DELAY           0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS     0x09
> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT         0x0A
>
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> @@ -132,10 +133,17 @@ static inline void pci_acpi_remove_edr_notifier(str=
uct pci_dev *pdev) { }
>
>  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struc=
t pci_dev *));
>  void pci_acpi_clear_companion_lookup_hook(void);
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested=
_power,
> +                                     u32 *retry_interval);
>
>  #else  /* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> +static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev,=
 u32 requested_power,
> +                                                   u32 *retry_interval)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_ACPI */
>
>  #endif /* _PCI_ACPI_H_ */
> --

