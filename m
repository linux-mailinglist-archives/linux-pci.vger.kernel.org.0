Return-Path: <linux-pci+bounces-42578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D3C9F6F5
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA24303AEA9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D296217F27;
	Wed,  3 Dec 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROwZCnyA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5012FD1CA
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775336; cv=none; b=mUhSp23kKYJjkNDJwkvRkCnqghZIpY9e4d/3yFKw576ZzsVTp2R7QLQ+hYO4d0qB3EIOG0PNtbWz6MSAjJOP8nI9HMu0X+TNYGjTdrt6KY19ezwPxR+/CdRBWrdFqP3Z5JbZ0UkhJUw31tUUu9vXHzqQvINWfTxeKH9WGsdBmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775336; c=relaxed/simple;
	bh=VPYeeJqAyq2vBS9rX2nXm9E/1cXub4tBcdgXq6N6PKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGZpkRDyxlQ0jvhqlEe/4ZQ0yR8GEbhuJh/oImxBFoBAW4+QVS3Ui8tppRc5cPQots4hnYd5gzGLb8kz8AQBmncrXI+E57e0FoGIYMkPZ+1Ol3SCLI+uk0yEYX5emtcmOl/S65NOQ9+/uK/uunfVMxHdYsqRvx+Ht4wpQtLBDgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROwZCnyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6155C19422
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764775335;
	bh=VPYeeJqAyq2vBS9rX2nXm9E/1cXub4tBcdgXq6N6PKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ROwZCnyAWDumu9o+FvIftUFepqnkdx8s0JMIaNd00J+80JwCfCmldHuOKs2gbGOsv
	 jdw2Be/23WsdS31woXDSOW+OpdSxTPMz2KrFUngHwRZNcA+YzcGAsfUcPNyFpioxvy
	 R6jA9JFte8QUSgOLnSxdbWh3sfp2W+WckBqO1ovZX7Bqba8a4C5U6DHY0206PXRlbI
	 bahm7HEl/Bn3M7kw2amoGCdaywKmYf3507pb3tjFfAGBSlAb0U2nDCA3iHk52rBq5O
	 Iqi+TJ18A3cZ6ygLJGc3EBuU3/MDta+mHOglmZkUoBNWQhVlgwrVfZhaeg8ub5J0mu
	 8NzWCJVDza81Q==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c7aee74dceso2223333a34.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 07:22:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/HUt4QrmCorxtMOxL1ZD1McSLZckNzR32bgZdzXOEPZKHQelgcyoLBDzt0kQW2JDqkTNRYeWC/mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjmGkX5btcF6rcVq7R/WomGRGENbXtK4k+G3q2dBfPg0Uo08v
	sABrQQtHXqkb5db/VWCk8yPudmibLugRStiPsX/HCedhCoaw/ssaTzjw0w+w62t5P0cEHJcXkMk
	uRCTXod1IoZ2bC/0Vt1Mk0yrcjGv0WzI=
X-Google-Smtp-Source: AGHT+IE3b08bCD3/4VErWRNcQlpE2EFdC3tHZ0Uxw4O0hb1sDw0fs/uiA/8QSEme8G5UVVUMZMUjqzsmh4ROJ9eClxY=
X-Received: by 2002:a05:6830:25c3:b0:7c7:5f8c:71a3 with SMTP id
 46e09a7af769-7c94db1660bmr1512302a34.2.1764775335174; Wed, 03 Dec 2025
 07:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202.174007.745614442598214100.rene@exactco.de>
 <20251202172837.GA3078292@bhelgaas> <aS9f-K_MN0uYUCYx@google.com>
 <aS_BYeSApI2XuPcD@wunner.de> <20251203142743.GD2580184@black.igk.intel.com> <E5E42CF4-7D6B-4081-AD59-CAC09FCB1890@exactco.de>
In-Reply-To: <E5E42CF4-7D6B-4081-AD59-CAC09FCB1890@exactco.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Dec 2025 16:22:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ighf93oi7peW7jRf4XsvBQe3ryLcnFqkL7aWN5TmBqsw@mail.gmail.com>
X-Gm-Features: AWmQ_bnC6kfsEYFa1ZnOAGU5658xGE6FIjrOMXszjoIDHjUsdjjwUAHNjdX7I-8
Message-ID: <CAJZ5v0ighf93oi7peW7jRf4XsvBQe3ryLcnFqkL7aWN5TmBqsw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC systems
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Brian Norris <briannorris@chromium.org>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Riccardo Mottola <riccardo.mottola@libero.it>, Manivannan Sadhasivam <mani@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 3:48=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de> wro=
te:
>
> Hi,
>
> > On 3. Dec 2025, at 15:27, Mika Westerberg <mika.westerberg@linux.intel.=
com> wrote:
>
> =E2=80=A6
>
> >> A Thunderbolt controller exposes a PCIe switch.  Daisy-chained
> >> Thunderbolt devices are thus visible to the OS as nested switches.
> >> If we followed the approach you're suggesting, users would have to
> >> manually allow runtime PM on every Switch Upstream and Downstream Port
> >> as well as the Root Port and they'd have to do that upon hotplugging
> >> a device.  Yes, yes, users could add a udev rule to allow runtime PM
> >> automatically by default, but that's exactly the policy we have hardco=
ded
> >> in the kernel right now, so why the change?
> >>
> >> I expect massive power regressions for users (not least Chromebook
> >> users) if we made that change.
> >>
> >> The discrete Thunderbolt controller in my machine consumes 1.5W
> >> when nothing is attached.  Some laptops have multiple of these.
> >> Recent CPUs with integrated Thunderbolt/USB4 may fail to transition
> >> the package to a low power state unless the Thunderbolt ports go
> >> to D3hot.
> >>
> >> So I don't think this approach is a viable option.
> >
> > I agree.  If this is limited to some older RISC machines (based on the
> > $subject) perhaps this could be solved by adding udev rules to block
> > runtime PM on those certain ports?
>
> Let=E2=80=99s not overcomplicate it for now. All we have are a couple of =
old Unix
> RISC workstations. Let=E2=80=99s see if we can somehow fix them for real =
first.
>
> Given the feedback that D3Hot =E2=80=9Cshould=E2=80=9D more often work I =
went ahead
> and changed the patch in T2/Linux removing the 2015 check and all arch
> except SPARC and let our prosumer enthusiast users find out if something
> else breaks first to gather more data points.
>
> I=E2=80=99ll try to find time to debug the SPARC64 Sun Blade 1K issue, bu=
t I have
> some other TODO first, so it might be January for more work on that.
>
> Maybe we should push a patch to only disable this for SPARC64 to stable
> In the meantime?
>
> https://svn.exactcode.de/t2/trunk/package/kernel/linux/hotfix-legacy-pci-=
bridge-d3.patch
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2b53219fda3b..869d204a70a3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3067,10 +3067,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge=
)
>                         return false;
>
>                 /*
> -                * Out of caution, we only allow PCIe ports from 2015 or =
newer
> -                * into D3 on x86.
> +                * It should be safe to put PCIe ports to D3.
>                  */
> -               if (!IS_ENABLED(CONFIG_X86) || dmi_get_bios_year() >=3D 2=
015)
> +               if (!IS_ENABLED(CONFIG_SPARC64))
>                         return true;
>                 break;
>         }

I would prefer

if ((IS_ENABLED(CONFIG_X86) && dmi_get_bios_year() >=3D 2015) ||
!IS_ENABLED(CONFIG_SPARC64))
         return true;

