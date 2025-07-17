Return-Path: <linux-pci+bounces-32366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D63B08A33
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D3175008
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A9D29899D;
	Thu, 17 Jul 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/MU4FY1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BF28BAB6;
	Thu, 17 Jul 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746624; cv=none; b=WRRg6vrbupjiqv3prteQpGXt1oOvl0inWjG6sR2X6gJcMAq4+W4ALSPgs0PFuh+TU2wl0LYQNe6IzSIU1783QsHxZ6ktvR7lFT4VpNuHeBGrPVLvekjF3bKm+6pUx7TKA0oEyVtf8THGz8/Xrt72n7nN9Rpo3SkY0tasQ4p2Utg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746624; c=relaxed/simple;
	bh=7rOtkwR8GZNy1nCNIIUgrxN5oDXOmZQQxgq8jrIoLgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1PrNpgFM1vkHWgLO5RmaOVZ36HgLoBsS02Gfe2OdTdSbec6qoZYOGmqagLp3vQuEuQxgU7Veiu4uWDRwcMs64ybCHHvVH9bdcYkm52mgcoloTkrIlIqLAWh9irG4k6uWTdiKWxXhPJ0OkN/nNxme/rbS3qorsgtPXCcjZEn2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/MU4FY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590F5C4CEE3;
	Thu, 17 Jul 2025 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752746624;
	bh=7rOtkwR8GZNy1nCNIIUgrxN5oDXOmZQQxgq8jrIoLgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P/MU4FY1UmvdmW5yE6ynZ/DZpmn9ghWnN8roZHcUtlmsSeFgRYyKaawRRgLPByIBn
	 9SiaEDTswtKg0dX0GsW0DVXYmNtMm+DAyAjScLI2ADdQsBQeenpruq8P5AqqvgLne+
	 c2G2JDEmRrIVYBceQXesLY8OG4znKZiJQT6Re0aZQWOzlMQdgojWnGutLIoVut5OV7
	 sk53YAc6dJ4gQixnaq2GPK57/iCkZNOXvymVxvisMJkJ4pF0dm2X6C/Imnc5WmEcR4
	 0aDvtnlRJJ9kxpi9ZaV+x/mCPhLdYqDx23y45D4rXDQflNP8aY2Ahl5nLLRb2n/Act
	 skGOO6xiRLwJg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-41b4bf6ead9so538894b6e.3;
        Thu, 17 Jul 2025 03:03:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUo3wsVVrpfvEB7BZmqVbwsjv3L69GaUBWZpZ3HN4F7lZC2aTAOIeQ1HvWdCWkdLKpZeIKhhlg0c+35opU=@vger.kernel.org, AJvYcCUu+cOkfDXgQ5OYdQyrcSyBP1lFrqdAkzhHimG1QIIjK9QD3FTm6wyUXT0VNqS/yiFky43oqrEkxaI=@vger.kernel.org, AJvYcCX7KGz1LuytYPwSczC0jIxwnjzb4UYciXilez7bOrbDIJ5ZPrwAM31r63tkdKh+ya3a1V/W7EqQfRid@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dQpi2HnqckYG2wf2MmI5jhX+KGTMm/mSyM5M/XnzlM6F4kcm
	vrWxJeA6oFldsWGCrxLynvdaopTLwLsfcSZfNvCJ3bHnBq43TxbtfloVROoUgyxJJLy7Rc0erEd
	PiGzXwcClqIWoJuqoh9jRFzCUiCTiFZk=
X-Google-Smtp-Source: AGHT+IGv5pmrlERV7QI0wWb9a4bOLhsu0PihzaBebqr1DPGZ2nCMpw1rJwKBvvbnuTn3QIcBMj5O1HOOKV0twchdio0=
X-Received: by 2002:a05:6808:2112:b0:406:3370:3bc6 with SMTP id
 5614622812f47-41d032fb23fmr4471962b6e.2.1752746623595; Thu, 17 Jul 2025
 03:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717004034.2998443-1-david.e.box@linux.intel.com> <4xcwba3d4slmz5gfuwypavxqreobnigzyu4vib6powtbibytyp@mmqcns27vlyr>
In-Reply-To: <4xcwba3d4slmz5gfuwypavxqreobnigzyu4vib6powtbibytyp@mmqcns27vlyr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 12:03:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+v5pUP39vTWpNNK2D8=X2UdjUTtZ7yQHCQ2k=r2kkMg@mail.gmail.com>
X-Gm-Features: Ac12FXw0F3fW0Ni1AOjBKlz7FJyLFH9p4D5QuxV48pg-f3fFKFgAFPcHzR4KkRs
Message-ID: <CAJZ5v0h+v5pUP39vTWpNNK2D8=X2UdjUTtZ7yQHCQ2k=r2kkMg@mail.gmail.com>
Subject: Re: [RFC 0/2] PCI/ASPM: Allow controller-defined default link state
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "David E. Box" <david.e.box@linux.intel.com>, rafael@kernel.org, bhelgaas@google.com, 
	vicamo.yang@canonical.com, kenny@panix.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:55=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Jul 16, 2025 at 05:40:24PM GMT, David E. Box wrote:
> > Hi all,
> >
> > This RFC series addresses a limitation in the PCIe ASPM subsystem where
> > devices on synthetic PCIe hierarchies, such as those created by Intel=
=E2=80=99s
> > Volume Management Device (VMD), do not receive default ASPM settings
> > because they are not visible to firmware. As a result, ASPM remains
> > disabled on these devices unless explicitly enabled later by the driver=
,
> > contrary to platform power-saving expectations.
> >
> > Problem with Current Behavior
> >
> > Today, ASPM default policy is set in pcie_aspm_cap_init() based on valu=
es
> > provided by BIOS. For devices under VMD, BIOS has no visibility into th=
e
> > hierarchy, and therefore no ASPM defaults are applied. The VMD driver c=
an
> > attempt to walk the bus hierarchy and enable ASPM post-init using runti=
me
> > mechanisms, but this fails when aspm_disabled is set because the kernel
> > intentionally blocks runtime ASPM changes under ACPI=E2=80=99s FADT_NO_=
ASPM flag.
> > However, this flag does not apply to VMD, which controls its domain
> > independently of firmware.
> >
> > Goal
> >
> > The ideal solution is to allow VMD or any controller driver managing a
> > synthetic hierarchy to provide a default ASPM link state at the same ti=
me
> > it's set for BIOS, in pcie_aspm_cap_init().
> >
>
> I like the idea and would like to use it to address the similar limitatio=
n on
> Qcom SoCs where the BIOS doesn't configure ASPM settings for any devices =
and
> sometimes there is no BIOS at all (typical for SoCs used in embedded usec=
ases).
> So I was using pci_walk_bus() in the controller driver to enable ASPM for=
 all
> devices, but that obviously has issues with hotplugged devices.
>
> > Solution
> >
> > 1. A new bus flag, PCI_BUS_FLAGS_ASPM_DEFAULT_OVERRIDE, based on Rafael=
's
> > suggestion, to signal that the driver intends to override the default A=
SPM
> > setting. 2. A new field, aspm_bus_link_state, in 'struct pci_bus' to su=
pply
> > the desired default link state using the existing PCIE_LINK_STATE_XXX
> > bitmask.
> >
>
> Why would you need to make it the 'bus' specific flag? It is clear that t=
he
> controller driver is providing the default ASPM setting. So pcie_aspm_cap=
_init()
> should be able to use the value provided by it for all busses.
>
> Like:
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2ad1852ac9b2..830496e556af 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -791,6 +791,7 @@ static void aspm_l1ss_init(struct pcie_link_state *li=
nk)
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blackli=
st)
>  {
>         struct pci_dev *child =3D link->downstream, *parent =3D link->pde=
v;
> +       struct pci_host_bridge *host =3D pci_find_host_bridge(parent->bus=
);
>         u32 parent_lnkcap, child_lnkcap;
>         u16 parent_lnkctl, child_lnkctl;
>         struct pci_bus *linkbus =3D parent->subordinate;
> @@ -866,8 +867,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state=
 *link, int blacklist)
>         }
>
>         /* Save default state */
> -       if (parent->bus->bus_flags & PCI_BUS_FLAGS_NO_ASPM_DEFAULT)
> -               link->aspm_default =3D parent->bus->aspm_bus_link_state;
> +       if (host && host->aspm_bus_link_state)
> +               link->aspm_default =3D host->aspm_bus_link_state;
>         else
>                 link->aspm_default =3D link->aspm_enabled;
>
> This avoids the usage of the bus flag (which your series is not at all ma=
king
> use of) and allows setting the 'host_bridge::aspm_bus_link_state' easily =
by the
> controller drivers.

This is very similar to what I have just suggested and I like this one.

Thanks!

