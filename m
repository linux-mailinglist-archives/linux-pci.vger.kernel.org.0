Return-Path: <linux-pci+bounces-31890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B300CB00C5F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865046417CB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EF82FD86C;
	Thu, 10 Jul 2025 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5KYpuI7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF225B1D2;
	Thu, 10 Jul 2025 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177211; cv=none; b=TVIU6lKQ6MnQb1yvAPpeuIFqUKpPiUdZXmHLt9oyuWHEzNBxKFFEA+kj4DNqecE6Fb4rLW8xBTbQqV8/Suvtit8ZQIml36ipvBAUVpnaqDtIah4WwS+AAnCDexeTKq7ghp60FAHK1DxOTFUr60tugid18rhpJm/5Hqrs8k4eGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177211; c=relaxed/simple;
	bh=LAGiC2+0XfOzw1ORGZUeQz0hI4p/gihgz2wJQsqIs50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzV+FvE9or6deFpz5xlkii2CBTpAxBHtncgEg00BgYLSwLY/WFcylejrADluZturKFGI0G1kfD4Im26RqvGxdAnhIBP/zEfnNSbG8zqBiR1k0WxLuWsAtHo+H9ivMY5lFHzT/PL+dYsQZ12WUXE8sGqRWcL0qkt0WzQLtU6hCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5KYpuI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973FFC4CEF6;
	Thu, 10 Jul 2025 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752177210;
	bh=LAGiC2+0XfOzw1ORGZUeQz0hI4p/gihgz2wJQsqIs50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g5KYpuI7ZIzE6dQ3vjx/NhG9KoBI47IJA0asxt6j46TG1G8Nu88plI5Ek2zfdUTy7
	 iuyhu2yPR9mu8Ek1Z8AVDY9M6GvRxl3CDMfRpoiAhu99VhnA1XajC7jRkeLKHNj0wN
	 vFgvlrgRMirJgWT59JOZ1MV64BmZmglD8ElMeslvXbLzyJPPLUc9t+g+y8CC/mqyS6
	 lNhhrBqwWLvEyguoxThg/p3bFsE5Y8PpnBDgfRfTyGRPD7sm6f5v8Py8aC+M4E0yYP
	 5Z1Zw+h5zNupHbHHLgg6qrr70WjTsDK+icIHdLbP7rEGD8qtD6J94g6xWT38DOhhia
	 d27JmLf4+/i/Q==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2e95f0b6cb7so479238fac.3;
        Thu, 10 Jul 2025 12:53:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXwka7X3i7qIaRHK19vT4TgiEzMZkylnjxxbnuHat5HUzY7ADZR9wzarCT5caJEhCKe5L0Z8xs/oNz@vger.kernel.org, AJvYcCWOQ/3jMqIzsNMDQyIrxiJSRv7ptwlbgugdROHMdfnCY0HQpv3GzQeAqJmUvTjlVW3oeOT9y2QnWUk=@vger.kernel.org, AJvYcCWb443Ptl9A5R3QEVDNeE3PA28pBEFDeGl2G3qYOlpnagCNhlr5R25pBt4LRHtHvbV0SvzJPLRiOv4viSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfiIRHjdFf/VX+kDNgdh4awxXrmnAyU7b4Q+ZLwUmH8YmiV0EH
	S670yIC7+rSnW4xl0MLZoA488340mbGeLEsITuFeJ26aWoFR/QFU8zlmfLRcjDQyX7PeE6F5okX
	g7Q6FQyFdYd/fkZN91cdw32BdlswsO/4=
X-Google-Smtp-Source: AGHT+IEEk0T+9hKHAB3bzgxk2q+cxy2hrS8HEynzA9IAfDJVDWz/njQkMODs6jKyQF79w9XU51rZNAv3nPJ14ojsTBo=
X-Received: by 2002:a05:6870:478a:b0:2d4:d07c:7cc5 with SMTP id
 586e51a60fabf-2ff2676e951mr387582fac.12.1752177209706; Thu, 10 Jul 2025
 12:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710011647.990046-1-david.e.box@linux.intel.com>
In-Reply-To: <20250710011647.990046-1-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Jul 2025 21:53:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWAaj5_hBC_1pZcA-cQ0Yz6hvQjbsv3Gmv6jN_utt4OQ@mail.gmail.com>
X-Gm-Features: Ac12FXz1_2170Nhzax8i_B5jtgfN9SEVFNmf4-T1qLKuTq3v00MF1G05oHjw8cY
Message-ID: <CAJZ5v0iWAaj5_hBC_1pZcA-cQ0Yz6hvQjbsv3Gmv6jN_utt4OQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Allow ASPM enablement for devices behind Intel VMD
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, andrea.righi@canonical.com, 
	vicamo.yang@canonical.com, kenny@panix.com, nirmal.patel@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 3:16=E2=80=AFAM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Devices behind Intel's Volume Management Device (VMD) controller reside o=
n
> a synthetic PCI hierarchy that is intentionally hidden from ACPI and
> firmware. As such, BIOS does not configure ASPM for these devices, and th=
e
> responsibility for link power management, including ASPM and LTR, falls
> entirely to the VMD driver.
>
> However, the current PCIe ASPM code prevents ASPM configuration when the
> ACPI_FADT_NO_ASPM flag is set, disallowing OS management. This leaves ASP=
M
> permanently disabled for these devices, contrary to the platform's design
> intent.
>
> Introduce a callback mechanism that allows the VMD driver to enable ASPM
> for its domain, bypassing the global ACPI_FADT_NO_ASPM restriction that i=
s
> not applicable in this context. This ensures that devices behind VMD can
> benefit from ASPM savings as originally intended.
>
> Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611c=
ef@panix.com
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

First of all, thanks for doing this work, much appreciated!

> ---
>  drivers/pci/controller/vmd.c | 28 ++++++++++++++++++++++++++--
>  drivers/pci/pci.h            |  8 ++++++++
>  drivers/pci/pcie/aspm.c      | 36 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 8df064b62a2f..e685586dc18b 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -21,6 +21,8 @@
>
>  #include <asm/irqdomain.h>
>
> +#include "../pci.h"
> +
>  #define VMD_CFGBAR     0
>  #define VMD_MEMBAR1    2
>  #define VMD_MEMBAR2    4
> @@ -730,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci_hos=
t_bridge *root_bridge,
>  }
>
>  /*
> - * Enable ASPM and LTR settings on devices that aren't configured by BIO=
S.
> + * Enable LTR settings on devices that aren't configured by BIOS.
>   */
>  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
>  {
> @@ -770,10 +772,27 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev=
, void *userdata)
>          * PCIe r6.0, sec 5.5.4.
>          */
>         pci_set_power_state_locked(pdev, PCI_D0);
> -       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);

Do I think correctly that this doesn't work because of the
aspm_disabled check in __pci_enable_link_state()?

>         return 0;
>  }
>
> +static long vmd_get_link_state(struct pci_dev *pdev, void *data)
> +{
> +       struct pci_bus *vmd_bus =3D data;
> +       struct pci_bus *bus =3D pdev->bus;
> +
> +       while (bus) {
> +               if (bus =3D=3D vmd_bus)
> +                       return PCIE_LINK_STATE_ALL;
> +
> +               if (!bus->self)
> +                       break;
> +
> +               bus =3D bus->self->bus;
> +       }

If I'm not mistaken, it would be sufficient to do a check like

    if (pci_dev->bus->ops =3D=3D &vmd_ops)
            return PCIE_LINK_STATE_ALL;

instead of the above, or if not then why not?

> +
> +       return -ENODEV;
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features=
)
>  {
>         struct pci_sysdata *sd =3D &vmd->sysdata;
> @@ -785,6 +804,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, uns=
igned long features)
>         resource_size_t membar2_offset =3D 0x2000;
>         struct pci_bus *child;
>         struct pci_dev *dev;
> +       struct pcie_aspm_vmd_link_state vmd_link_state;
>         int ret;
>
>         /*
> @@ -911,6 +931,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>                 return -ENODEV;
>         }
>
> +       vmd_link_state.cb =3D vmd_get_link_state;
> +       vmd_link_state.data =3D vmd->bus;
> +       pci_register_vmd_link_state_cb(&vmd_link_state);
> +
>         vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
>                                    to_pci_host_bridge(vmd->bus->bridge));
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..dcf7d39c660f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -821,6 +821,12 @@ void pci_configure_aspm_l1ss(struct pci_dev *dev);
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>
> +
> +struct pcie_aspm_vmd_link_state {
> +       long (*cb)(struct pci_dev *pdev, void *data);
> +       void *data;
> +};
> +
>  #ifdef CONFIG_PCIEASPM
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> @@ -828,6 +834,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev, =
bool locked);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  void pci_configure_ltr(struct pci_dev *pdev);
>  void pci_bridge_reconfigure_ltr(struct pci_dev *pdev);
> +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *sta=
te);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> @@ -835,6 +842,7 @@ static inline void pcie_aspm_pm_state_change(struct p=
ci_dev *pdev, bool locked)
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev)=
 { }
>  static inline void pci_configure_ltr(struct pci_dev *pdev) { }
>  static inline void pci_bridge_reconfigure_ltr(struct pci_dev *pdev) { }
> +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *sta=
te) { }
>  #endif
>
>  #ifdef CONFIG_PCIE_ECRC
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 29fcb0689a91..c609d3c309be 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -320,6 +320,27 @@ static int policy_to_clkpm_state(struct pcie_link_st=
ate *link)
>         return 0;
>  }
>
> +static struct pcie_aspm_vmd_link_state vmd_state;
> +
> +void pci_register_vmd_link_state_cb(struct pcie_aspm_vmd_link_state *sta=
te)
> +{
> +       mutex_lock(&aspm_lock);
> +       vmd_state.cb =3D state->cb;
> +       vmd_state.data =3D state->data;
> +       mutex_unlock(&aspm_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_register_vmd_link_state_cb);
> +
> +static long pci_get_vmd_link_state(struct pci_dev *pdev)
> +{
> +       int state =3D -ENODEV;
> +
> +       if (vmd_state.cb)
> +               state =3D vmd_state.cb(pdev, vmd_state.data);
> +
> +       return state;
> +}
> +
>  static void pci_update_aspm_saved_state(struct pci_dev *dev)
>  {
>         struct pci_cap_saved_state *save_state;
> @@ -794,6 +815,7 @@ static void pcie_aspm_cap_init(struct pcie_link_state=
 *link, int blacklist)
>         u32 parent_lnkcap, child_lnkcap;
>         u16 parent_lnkctl, child_lnkctl;
>         struct pci_bus *linkbus =3D parent->subordinate;
> +       int vmd_aspm_default;
>
>         if (blacklist) {
>                 /* Set enabled/disable so that we will disable ASPM later=
 */
> @@ -865,8 +887,20 @@ static void pcie_aspm_cap_init(struct pcie_link_stat=
e *link, int blacklist)
>                 pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_l=
nkctl);
>         }
>
> +       /*
> +        * Devices behind Intel VMD operate on a synthetic PCI bus that B=
IOS
> +        * and ACPI do not enumerate or configure. ASPM for these devices=
 must
> +        * be managed by the VMD driver itself, independent of global ACP=
I ASPM
> +        * constraints. This callback mechanism allows selective ASPM
> +        * enablement for such domains.
> +        */
> +       vmd_aspm_default =3D pci_get_vmd_link_state(parent);
> +
>         /* Save default state */
> -       link->aspm_default =3D link->aspm_enabled;
> +       if (vmd_aspm_default < 0)
> +               link->aspm_default =3D link->aspm_enabled;
> +       else
> +               link->aspm_default =3D vmd_aspm_default;

Well, this is not nice.

First off, it adds VMD-specific stuff to otherwise generic ASPM code.
Second, it doesn't actually do anything about the aspm_disabled checks
all over the place, so they will still trigger even though ASPM will
be effectively enabled for devices on the VMD bus.

>
>         /* Setup initial capable state. Will be updated later */
>         link->aspm_capable =3D link->aspm_support;
>
> base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> --

It appears to me that the underlying problem is that aspm_disabled is
global and it is set during PCI root bus creation in
acpi_pci_root_add().  Thus it affects all of the PCI buses even though
the BIOS says that it wants to control ASPM for this particular PCIe
hierarchy.  If there were another PCI root enumerated by ACPI where
the OS would be allowed to control ASPM, it would not work just like
the VMD case.

To me, this suggests an approach based on moving the "ASPM disabled
because the BIOS wants to control it" setting to pci_bus_flags_t and
setting it on a per-hierarchy basis.  Since the VMD bus is a separate
PCIe hierarchy from the kernel perspective, it will not have this flag
set and the OS should be able to configure ASPM for devices on that
bus.

Do I think correctly or am I overlooking something here?

