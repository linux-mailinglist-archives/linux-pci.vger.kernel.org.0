Return-Path: <linux-pci+bounces-32365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15403B08A1B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A05165540
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC702989A4;
	Thu, 17 Jul 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv6bgSFT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82E298991;
	Thu, 17 Jul 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746424; cv=none; b=AHC9noFTXo5zChkjnMfvrTaVCF8b64uagN7R18hKsCNhqRg/0z2tNhGN5NBD6mJ3KgLKqN8vowOguNmID1RimwxIHaoiSvAbug/dScMFUA+7oZcwrHR3grHLRNZNGQh7ow9h31U/J1KDoEEqLGVJnVH0rNrXU9BoulGI2HbSX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746424; c=relaxed/simple;
	bh=IE0NO91nxGKmeHQZs/EVJN4vp00NgsdAr8J6xj5OtdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0WZQ5SJ9ShlcfyC9e/M8hNs5eDwPRyslhASOINPSndRNfYui65jYvBBDzsh0Ykq/EWhM4NmWbEQa/I79+9/aGGLpPNIaR1Fki+k1m8nMSoikPShViPKU5WXm0h/zDR/b1cbBLOaNRyi4Uu8kY5VDm+ZyXVIsbCCyxrAuEO7Bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv6bgSFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB7CC4CEEB;
	Thu, 17 Jul 2025 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752746423;
	bh=IE0NO91nxGKmeHQZs/EVJN4vp00NgsdAr8J6xj5OtdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yv6bgSFT+/bzsdl6NPBR/9mPsEalMBLfxsjohgLJ90kDFK4Je17LbD+JRKYZeokBZ
	 dVmYtoRVgctLEivz+p1gM88nwr/JV9LUeUmFTAGcII/guGVR3sNt5PDq2xn7XOCCP2
	 kI44obiJp/AsPQG8KpkUjJZs3kUqlysUpVfCfYIXlFz/041FiGxKv02gMmeXjqMnZQ
	 CNN5FlhLFiQ8kOs3/XnmIpQw47btRsT9UAY4R4IfVXQZ3GRWdJV6pX3oCTrg3BbPVx
	 5L92Yg0ozCP8+8fPf+4qbrLd/3GWxNYAkbXP3AoB6Vo+1FDaOfvCSChwyg0pZR+EkP
	 knD8HbRYUSmLQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2edec6c5511so355790fac.2;
        Thu, 17 Jul 2025 03:00:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFRZjvNzXmZo+7bAxm7mlNlzsJwKph2fXdI52JapLFtEzxF0F+SWKbZpOKKbT2utilCGdXX3O8YYg=@vger.kernel.org, AJvYcCUJS3QYoOK+UZYZ0JLNz4hnCPDJWdthoF9oW/G/dLvznlZlEpPniUSsZjph286LzVf7NOFWN9d/N1Nn@vger.kernel.org, AJvYcCWr1WOLBru0FFXSw511kzGXSesMCIrUp92eAyZKVExFZkREgTtDNSjuOseFEJGdXARG9Z3S16eLvgwgv1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhDbmLAgWsN139QbAz3kpQs+BNj8H7XeipKUJ4YkzoaiATUefP
	w/OrysCZtVqd7ymmHQHRMaE08E/3/oe9bffF+l7mKihzcE0I1xKSDSDyuqrksrcqUQNb7pcNp7z
	7MwQnD/i0URgBxou9ZOYpWDgKIsPjCWk=
X-Google-Smtp-Source: AGHT+IHlGQ6aBR+j4ITxrcadCHuCPTrLl815gfJvAVL43dZiwKp328ZkY1a2m0nCmhP2ud6L0CQR7w35Smm4naWvBrg=
X-Received: by 2002:a05:6870:2dca:b0:2d4:d07c:7cc5 with SMTP id
 586e51a60fabf-2ffaf2a273amr5034339fac.12.1752746418187; Thu, 17 Jul 2025
 03:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717004034.2998443-1-david.e.box@linux.intel.com> <20250717004034.2998443-2-david.e.box@linux.intel.com>
In-Reply-To: <20250717004034.2998443-2-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 12:00:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCTUBzM=UXf1jw6yRraVREDqpa4dAVwhHEkbxtqU9ogA@mail.gmail.com>
X-Gm-Features: Ac12FXwK7-e3oVMXuwnqEUl3MTV9qppscX0vtB1O3xwQQ5ORJ-Z43hQ2bboY5iI
Message-ID: <CAJZ5v0hCTUBzM=UXf1jw6yRraVREDqpa4dAVwhHEkbxtqU9ogA@mail.gmail.com>
Subject: Re: [RFC 1/2] PCI/ASPM: Allow drivers to provide ASPM link state via pci_bus
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 2:40=E2=80=AFAM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Synthetic PCIe hierarchies such as those created by Intel VMD are not
> enumerated or configured by firmware, and therefore do not receive
> BIOS-provided ASPM defaults. This leaves devices behind such domains with
> ASPM effectively disabled, despite platform intent.
>
> Introduce a mechanism to allow the bus owner (e.g. a controller driver) t=
o
> supply a default ASPM policy via a new aspm_bus_link_state field in
> pci_bus.  A new bus flag, PCI_BUS_FLAGS_ASPM_DEFAULT_OVERRIDE, indicates

This doesn't seem to match the code - the name of the new flag is
different there.

> that the core should use this value instead of the BIOS default when
> initializing link state.
>
> This avoids the need for controller-specific logic in ASPM core and allow=
s
> for proper power savings in these otherwise unsupported hierarchies.

I'm guessing that VMD is supposed to set
PCI_BUS_FLAGS_NO_ASPM_DEFAULT, but that doesn't happen in patch [2/2]
AFAICS.

And I would just merge the two patches, IMV there's no reason to keep
them separate.

> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/pci/pcie/aspm.c |  5 ++++-
>  include/linux/pci.h     | 12 ++++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 29fcb0689a91..2ad1852ac9b2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -866,7 +866,10 @@ static void pcie_aspm_cap_init(struct pcie_link_stat=
e *link, int blacklist)
>         }
>
>         /* Save default state */
> -       link->aspm_default =3D link->aspm_enabled;
> +       if (parent->bus->bus_flags & PCI_BUS_FLAGS_NO_ASPM_DEFAULT)
> +               link->aspm_default =3D parent->bus->aspm_bus_link_state;
> +       else
> +               link->aspm_default =3D link->aspm_enabled;

Could you avoid using the new flag by assuming that if
parent->bus->aspm_bus_link_state was zero, link->aspm_enabled would
take effect?  So the check would be something like

if (parent->bus->aspm_bus_link_state)
        link->aspm_default =3D parent->bus->aspm_bus_link_state;
else
        link->aspm_default =3D link->aspm_enabled;

>
>         /* Setup initial capable state. Will be updated later */
>         link->aspm_capable =3D link->aspm_support;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f392..7e1c305c419c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -256,10 +256,11 @@ enum pci_irq_reroute_variant {
>
>  typedef unsigned short __bitwise pci_bus_flags_t;
>  enum pci_bus_flags {
> -       PCI_BUS_FLAGS_NO_MSI    =3D (__force pci_bus_flags_t) 1,
> -       PCI_BUS_FLAGS_NO_MMRBC  =3D (__force pci_bus_flags_t) 2,
> -       PCI_BUS_FLAGS_NO_AERSID =3D (__force pci_bus_flags_t) 4,
> -       PCI_BUS_FLAGS_NO_EXTCFG =3D (__force pci_bus_flags_t) 8,
> +       PCI_BUS_FLAGS_NO_MSI            =3D (__force pci_bus_flags_t) 1,
> +       PCI_BUS_FLAGS_NO_MMRBC          =3D (__force pci_bus_flags_t) 2,
> +       PCI_BUS_FLAGS_NO_AERSID         =3D (__force pci_bus_flags_t) 4,
> +       PCI_BUS_FLAGS_NO_EXTCFG         =3D (__force pci_bus_flags_t) 8,
> +       PCI_BUS_FLAGS_NO_ASPM_DEFAULT   =3D (__force pci_bus_flags_t) 16,
>  };
>
>  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
> @@ -665,6 +666,9 @@ struct pci_bus {
>         void            *sysdata;       /* Hook for sys-specific extensio=
n */
>         struct proc_dir_entry *procdir; /* Directory entry in /proc/bus/p=
ci */
>
> +#ifdef CONFIG_PCIEASPM
> +       unsigned int    aspm_bus_link_state;    /* Bus owner provided lin=
k state */
> +#endif
>         unsigned char   number;         /* Bus number */
>         unsigned char   primary;        /* Number of primary bridge */
>         unsigned char   max_bus_speed;  /* enum pci_bus_speed */
> --

