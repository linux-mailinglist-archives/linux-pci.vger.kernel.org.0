Return-Path: <linux-pci+bounces-25154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2874AA78CD9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F59E3AAE17
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA751EB9F3;
	Wed,  2 Apr 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdFqW9nr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA131DE3CA;
	Wed,  2 Apr 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592015; cv=none; b=plaswzxm0pR+GlvO6eH93RAbc2+802HJmkof41PXioZiekMkZk98ReS7ktPgOPL6R3S5CZIkgTxg9rrwU24aMk56j/swUKM+aEIfiSKitvvgqEQFB1Otw+8nIt5X64i8iUAQJbjfB5PxPdAsIhC+PgE2x4P/pXnMJenn9L0Mj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592015; c=relaxed/simple;
	bh=p946U+eWh0ixKKutduyN8smhnfbZOXFWYfcTO8vFmV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdSNxp3qMRZLA0pyiOSo6Rfu7fBJ5rPv5o93gg3pShEFGFZlOPFRhNULlPNOueVJO8D+KKJQEFfboSeP/bAMWHvBfAR2aGX7ZNXCuUERMr2BZo0cRAdeogtPfgFFBBryL491RuDtz7WA2eOsbkTKDG6SC5tePf3tmIAnOHqho6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdFqW9nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972E5C4CEED;
	Wed,  2 Apr 2025 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743592014;
	bh=p946U+eWh0ixKKutduyN8smhnfbZOXFWYfcTO8vFmV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jdFqW9nroEndzzhDuVJwDFOL5qaZdM4y7lqmkWKsnVLhHBzwy759GT6jaSWkvsKN7
	 BnzxR4/6IhzVdwo13zV/JgPXNHBGPw319povwHxXA8EMT4onjGSa4qgaDaThmGiqKx
	 zCTQOsPc37F7bWUSvfe00cGjxqUaAoKwgWGfiDKB97wOPYS7236gz+ffDHvf+sZxzc
	 FktrmLf1w+12UfOz+awPVrGNy9vm4lNqeI0iurX4YSSkUdyv9E7so4h6Y2bKi3NTv6
	 yFmRA+kOLrFJCM5iw25tw7z28mQNQ4b5YHbKEiaqfXCf3IjSrIVHw5TVwgNeQjY/rv
	 X6FKPFYlGFN7Q==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ff0df81fdbso1771412b6e.3;
        Wed, 02 Apr 2025 04:06:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNOmCnOVXdesQHq/YiITxgXzSzFLhFf+KogjtINw0E3rrtMQqtiWCRiOPuokRGjIE95ZZ9pulfocdf@vger.kernel.org, AJvYcCWwTTtP+NZsvtUEltxLUSNCL+W3jyXbhUFuh/IBkz0x2o5cvCetbX6QVrwqeWwqk+p9Pa5tMUx8//hM@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoKC8Z2iTUH00k6Z4ucK+zVKs6fmmfxRDjHyA7b8YQm116pFc
	t9iNA+ObEWgIYNHH3BIDNPr4T6AI1vTfCpQPLWL8AOnTkAJzIeCBIGjLtANeiz6GEsxhV0K0rn1
	8phZ1HKZui32P7Wjy1GLSK4fB+vE=
X-Google-Smtp-Source: AGHT+IFLl6HjaDTLpz/XeX0IQKbmahhhsSHpeKlhKBgDjSR0IhsN24QI8/QcMALvLuR+JZTwvewX2L848MHFZeGn1I0=
X-Received: by 2002:a05:6808:219a:b0:3fa:caf4:7bae with SMTP id
 5614622812f47-3ff0f5b5434mr8980654b6e.24.1743592013902; Wed, 02 Apr 2025
 04:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401153225.96379-1-anshuman.gupta@intel.com> <20250401153225.96379-3-anshuman.gupta@intel.com>
In-Reply-To: <20250401153225.96379-3-anshuman.gupta@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 13:06:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hN1qRzU96uAGf1+BoQyqF-1=C4XbCcPA-0xtGt8gj7qQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoePQfJgVFH2XZkbqEpDt6rtmrU16qNOmcpFg1DFVlgQTpqYTtStOYqsNY
Message-ID: <CAJZ5v0hN1qRzU96uAGf1+BoQyqF-1=C4XbCcPA-0xtGt8gj7qQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com, 
	rodrigo.vivi@intel.com, badal.nilawar@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 5:36=E2=80=AFPM Anshuman Gupta <anshuman.gupta@intel=
.com> wrote:
>
> Implement _DSM Method 11 as per PCI firmware specs
> section 4.6.11 Rev 3.3.
>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>

I have basically the same comments as for the previous patch (in
addition to Bjorn's comments).

> ---
>  drivers/pci/pci-acpi.c   | 53 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  7 ++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index ebd49e43457e..04149f037664 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1499,6 +1499,59 @@ int pci_acpi_request_d3cold_aux_power(struct pci_d=
ev *dev, u32 requested_power)
>  }
>  EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);
>
> +/**
> + * pci_acpi_add_perst_assertion_delay - Request PERST# delay via ACPI DS=
M
> + * @dev: PCI device instance
> + * @delay_us: Requested delay_us

How's the caller supposed to find out what value to use here?

> + *
> + * This function sends a request to the host BIOS via ACPI _DSM to grant=
 the
> + * required PERST# delay for the specified PCI device. It evaluates the =
_DSM
> + * to request the PERST# delay and handles the response accordingly.
> + *
> + * Return: returns 0 on success and errno on failure.
> + */
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us=
)
> +{
> +       union acpi_object in_obj =3D {
> +               .integer.type =3D ACPI_TYPE_INTEGER,
> +               .integer.value =3D delay_us,
> +       };
> +
> +       union acpi_object *out_obj;
> +       acpi_handle handle;
> +       int result, ret =3D -EINVAL;
> +
> +       if (!dev || !ACPI_HANDLE(&dev->dev))
> +               return -EINVAL;
> +
> +       handle =3D ACPI_HANDLE(&dev->dev);

Please use ACPI_HANDLE() once.

> +
> +       out_obj =3D acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4=
,

This is something I haven't noticed in the previous patch, but also
applies to it.

Why is rev 4 of the interface hard-coded here?

> +                                         DSM_PCI_PERST_ASSERTION_DELAY,
> +                                         &in_obj, ACPI_TYPE_INTEGER);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       result =3D out_obj->integer.value;
> +
> +       if (result =3D=3D delay_us) {
> +               dev_info(&dev->dev, "PERST# Assertion Delay set to"
> +                        "%u microseconds\n", delay_us);
> +               ret =3D 0;
> +       } else if (result =3D=3D 0) {
> +               dev_warn(&dev->dev, "PERST# Assertion Delay request faile=
d,"
> +                        "no previous valid request\n");
> +       } else {
> +               dev_warn(&dev->dev,
> +                        "PERST# Assertion Delay request failed"
> +                        "Previous valid delay: %u microseconds\n", resul=
t);
> +       }
> +
> +       ACPI_FREE(out_obj);
> +       return ret;
> +}
> +EXPORT_SYMBOL(pci_acpi_add_perst_assertion_delay);

EXPORT_SYMBOL_GPL()?

> +
>  static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>         u8 val;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index dbc4b0ed433c..4b7373f91a9a 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -122,6 +122,7 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_POWER_ON_RESET_DELAY           0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS     0x09
>  #define DSM_PCI_D3COLD_AUX_POWER_LIMIT         0x0A
> +#define DSM_PCI_PERST_ASSERTION_DELAY          0x0B
>
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> @@ -134,6 +135,7 @@ static inline void pci_acpi_remove_edr_notifier(struc=
t pci_dev *pdev) { }
>  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struc=
t pci_dev *));
>  void pci_acpi_clear_companion_lookup_hook(void);
>  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested=
_power);
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us=
);
>
>  #else  /* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> @@ -142,6 +144,11 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev=
 *dev, u32 requested_power)
>  {
>         return -EOPNOTSUPP;
>  }
> +
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us=
)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_ACPI */
>
>  #endif /* _PCI_ACPI_H_ */
> --

