Return-Path: <linux-pci+bounces-34554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8E9B3174A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6F61D00952
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A72FB60B;
	Fri, 22 Aug 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG5aOP25"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496EC2ECD06;
	Fri, 22 Aug 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864860; cv=none; b=NRBRqB75IfTFt6F1GRxeDqgG0bGjAxF9FlrTYW6CB1I6o86fRHDUgINmyVvOqN38brNruQkeHPVg87EBtIc+u/lgJr0c0R+9OHiegO+I0NjjJq+bZ5r0zQWAhGG6dgM7B+NuaW7/OAF+TkMFezmE65KkZMiiWl3b9B8TCfOlSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864860; c=relaxed/simple;
	bh=mTJhF/BUDSVW9qsIepE2kodROp+3P/RuOXWIZZEbz2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQ5yCoWwFh6cx6JFM7Iay4ji6BmnvyjMOm89GIIPIFlQqDzGMX4NmtbdD15Qw9WjDNqNtIw0aA9urgjsFOzpMQ1M0FGpvB3eB/IyR2kFxcPz+WQty0xfcdE5ue2xRUC98PEiiSApBtSpN9T+kasl+/32ErURBHiAH8bI8Rw8z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG5aOP25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287DFC4CEF1;
	Fri, 22 Aug 2025 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755864860;
	bh=mTJhF/BUDSVW9qsIepE2kodROp+3P/RuOXWIZZEbz2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DG5aOP25pHW45GbVNJaaQmFvai7cMm3NT5BNYgudFIW8JwMeMDGEaTDWcH5Fo+8oV
	 aLzAbzGWxrCwuTx+LvOEI6YPr47D2vGGq4nvo1uE9ncQ1ovMOc6MEsGWWgh7KBfnhY
	 hSCarJyod7eVr7lhG0GYbAmDTFogNNMOH6Mspu9P1rH0smkeLJcIHdOeIurCyGRH9+
	 IyeKSk6JsKY5H2tfKmUfx9d/f5OcyQ/WxOVOgrJqDuMyUjUZHRZ0ptDREpRW39JFAf
	 b/t6Wgb4BFHUuNoTV8p+llhR7+QRNn8MV0i63Y0JZsWhOEcRf7Vn+6N3OyNXYtrUo3
	 pXWQAOe17nItA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30ccec59b4bso1649279fac.3;
        Fri, 22 Aug 2025 05:14:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdkyqPUhp9LdytIrOl+uG+/HMphWP/lmMHZMFIW0rQ/ttODQ+SAd96zeTcCQ9VPIjXCuJzfLGhWVc=@vger.kernel.org, AJvYcCUyklljCx83gMN8Dot78KR23M5ngJlBQwP/ef3OaIAK3E+QgkHQLHcUXn0wAZQolJWx9i6iu/Eg9T+p@vger.kernel.org, AJvYcCWC5gf5NVO3vlJ2WB02T//6axXLceEhgjnP5efBpi8O7z+jkXmLM7yr6IP5B5hOCcKO0HlU2cSWff4LNag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUWmkNLKRy8O/ZYFgPyPAEZTtAr0IBEh1Wen0GGxov+biR34I
	Hxe+qnNlcc+BpD0dD+xYYsUmc7IWOwBF5YjTHzm1c1GmolICOr6JrVW2/jupBF/g10hV18sPeul
	Q73YIuUOcuD1s5upCLTXCjKlmQUAJCy0=
X-Google-Smtp-Source: AGHT+IEWHa1tu80kztln5BulBF+tV07twYAtImEOLSbpU1ZRtppC39W+GqQwuCsbMH8qg3q4aA1idNQ54Q+fFdFiomg=
X-Received: by 2002:a05:6870:6124:b0:2ff:a860:3402 with SMTP id
 586e51a60fabf-314dcbb854amr1259934fac.12.1755864859383; Fri, 22 Aug 2025
 05:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822031159.4005529-1-david.e.box@linux.intel.com> <20250822031159.4005529-2-david.e.box@linux.intel.com>
In-Reply-To: <20250822031159.4005529-2-david.e.box@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Aug 2025 14:14:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hHU0oni=wMAMThCknAZgX5K0iNYLvyeAmS4fkmheLQ8w@mail.gmail.com>
X-Gm-Features: Ac12FXx_KnIauHu_xSyE2LiQV_gI4Sw4XEiH3bwJ-pEjSWCeBBeLiLdeCNzyGWg
Message-ID: <CAJZ5v0hHU0oni=wMAMThCknAZgX5K0iNYLvyeAmS4fkmheLQ8w@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] PCI: vmd: Use pci_host_set_default_pcie_link_state()
 to set ASPM defaults
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	mani@kernel.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:12=E2=80=AFAM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Now that pci_host_set_default_pcie_link_state() exists, set the VMD child
> domain with PCIE_LINK_STATE_ALL at bridge creation so core ASPM uses thos=
e
> defaults during ASPM and CLKPM capability init.
>
> Also remove the unneeded pci_set_power_state_locked(pdev, PCI_D0) and
> pci_enable_link_state_locked() calls now that the links are configured
> during enumeration.
>
> This aligns VMD behavior with platform expectations without per-controlle=
r
> ASPM tweaks at runtime.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

No issues found, so

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> Changes in V2:
>
>   -- Separated VMD changes into new patch.
>   -- Changed comment for VMD_FEAT_BIOS_PM_QUIRK to remove ASPM
>   -- Removed pci_set_power_state() and pci_enable_link_state_locked()
>      calls in vmd_pm_enable_quirk()
>   -- Use pci_host_set_default_pcie_link_state()
>
>  drivers/pci/controller/vmd.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index b679c7f28f51..b99e01a57ddb 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -71,10 +71,9 @@ enum vmd_features {
>         VMD_FEAT_CAN_BYPASS_MSI_REMAP           =3D (1 << 4),
>
>         /*
> -        * Enable ASPM on the PCIE root ports and set the default LTR of =
the
> -        * storage devices on platforms where these values are not config=
ured by
> -        * BIOS. This is needed for laptops, which require these settings=
 for
> -        * proper power management of the SoC.
> +        * Program default LTR values for storage devices on platforms wh=
ere
> +        * firmware did not. Required on many laptops for proper SoC powe=
r
> +        * management.
>          */
>         VMD_FEAT_BIOS_PM_QUIRK          =3D (1 << 5),
>  };
> @@ -733,7 +732,7 @@ static void vmd_copy_host_bridge_flags(struct pci_hos=
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
> @@ -747,7 +746,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, =
void *userdata)
>
>         pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
>         if (!pos)
> -               goto out_state_change;
> +               return 0;
>
>         /*
>          * Skip if the max snoop LTR is non-zero, indicating BIOS has set=
 it
> @@ -755,7 +754,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, =
void *userdata)
>          */
>         pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg=
);
>         if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> -               goto out_state_change;
> +               return 0;
>
>         /*
>          * Set the default values to the maximum required by the platform=
 to
> @@ -767,13 +766,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev,=
 void *userdata)
>         pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg=
);
>         pci_info(pdev, "VMD: Default LTR value set by driver\n");
>
> -out_state_change:
> -       /*
> -        * Ensure devices are in D0 before enabling PCI-PM L1 PM Substate=
s, per
> -        * PCIe r6.0, sec 5.5.4.
> -        */
> -       pci_set_power_state_locked(pdev, PCI_D0);
> -       pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
>         return 0;
>  }
>
> @@ -921,6 +913,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, uns=
igned long features)
>         WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>                                "domain"), "Can't create symlink to domain=
\n");
>
> +       pci_host_set_default_pcie_link_state(to_pci_host_bridge(vmd->bus-=
>bridge),
> +                                            PCIE_LINK_STATE_ALL);
>         vmd_acpi_begin();
>
>         pci_scan_child_bus(vmd->bus);
> --
> 2.43.0
>

