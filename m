Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFDD3A27B4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 11:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFJJHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJJHc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 05:07:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C75C061574;
        Thu, 10 Jun 2021 02:05:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so5565805wmq.1;
        Thu, 10 Jun 2021 02:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p5NiQOW29LgoYtGrn9lsDMjFWiJOYahPMH/NM1fxUjY=;
        b=VtuwuJx5q6q/8As+IDf2U+DbywdWX2CvfZeh3vVnd+R3EFbXpkc5IBFJ9l7X/8u8tv
         +QkmPqORMla9MD5vWJsUtVv8UmBluEilH1HD00yPcmFWQc8erR+07HbeOpX4DKNF6WQX
         UnwE3R2jCNCX/NSwbqxCtjbX8rDCFY5RxgflUFdXbF9RGKqhgsHAmoQIgzwC1NrcyE5B
         bSiqJDvtajoslw+uxMVUcWx8HZs6lHg57ZGUSzvDE5KrCl32Y5nhu8uJW2pp0UaVzCU4
         t5DezuyEIrv4Bqv3dR6/PeEtsnjhAbxUsQQlikHT/74JceFTGcLOYWRbuymgAC9zpB+Y
         C6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p5NiQOW29LgoYtGrn9lsDMjFWiJOYahPMH/NM1fxUjY=;
        b=pDcu/7WGu7WeUKXY7TzhhHQ/C6n/VNVl/s4USC7XjY2gNnkGNyVhZ4EFaxOg82uSe3
         +nxAMeInTq5TRkW1mGbM0Mm1GGo4tdh5tZUY8tdnWjGS6r5T0pT0ovwG9+P/YsY8N8Hs
         Y+z2j+8aFgVZnEXwGPMEEL9IvN6xD5t0r17edNEICjnFaeq2/Y2RP9kxQ+3lOZmWeIws
         DDX9opGseb/7lAJJ9KojLw9z6GhL/ZUP56mBK07aHU3P0zORJitdXbWEG8gmjIec9ax+
         WZ75o/SE6OYpe1F+7t4P6XOVQ/6nStmBYUgnTLhbhNn4nWmlIgouiENt2LBlWGijqu9I
         NSRQ==
X-Gm-Message-State: AOAM5304U4CONmXfLx/lIFR9fbAL/rjlG41YltTgTsmrUbHRgkmTHiRn
        kJSxlixVfK57R9k0h9T5kEo=
X-Google-Smtp-Source: ABdhPJwmWfEo2v+zBcV4ZNP9QUikLPHe4xyLK/775zUaAG9OoPoNbRaXn8D/IH3gbbLT7UEAccOcyw==
X-Received: by 2002:a05:600c:2cd2:: with SMTP id l18mr3897426wmc.142.1623315920472;
        Thu, 10 Jun 2021 02:05:20 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j7sm2693281wrm.93.2021.06.10.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:05:19 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:07:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V4] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <YMHWNusvLtwKWlQe@orome.fritz.box>
References: <20210610064134.336781-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aQWUWpnN9KJKqFLO"
Content-Disposition: inline
In-Reply-To: <20210610064134.336781-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--aQWUWpnN9KJKqFLO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 07:41:34AM +0100, Jon Hunter wrote:
> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> errata") caused a few build regressions for the Tegra194 PCIe driver
> which are:
>=20
> 1. The Tegra194 PCIe driver can no longer be built as a module. This
>    was caused by removing the Makefile entry to build the pcie-tegra.c
>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
>    so that we can build the driver as a module.
> 2. 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
>    errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
>    driver. But if we set CONFIG_PCIE_TEGRA194=3Dm to build the driver as a
>    module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
>    (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the

I think the correct way to write conditionals that are true on =3Dy and =3Dm
is to use:

	#ifdef IS_ENABLED(CONFIG_PCIE_TEGRA194)

but that doesn't fix the issue of not getting the quirks included when
CONFIG_PCIE_TEGRA194=3Dm.

>    driver. Given that the ACPI quirk code for Tegra194 is completely
>    independent of the native Tegra194 PCIe driver, move this code into
>    its own file so that it can be built independently and we can remove
>    the "#ifdef CONFIG_PCIE_TEGRA194" in the native driver. Note that
>    given the native Tegra194 PCIe driver is only used with device-tree,
>    this will not cause any conflicts.
> 3. The below build warnings to be seen with particular kernel
>    configurations. Fix these by moving these structure definitions to
>    within the necessary guards.
>=20
>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
>   	=E2=80=98event_cntr_data_offset=E2=80=99 defined but not used [-Wunuse=
d-const-variable=3D]
>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
>   	=E2=80=98event_cntr_ctrl_offset=E2=80=99 defined but not used [-Wunuse=
d-const-variable=3D]
>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
>   	=E2=80=98pcie_gen_freq=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>=20
> Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errat=
a")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V3:
> - Moved ACPI quirk code into separate source file
>=20
> Changes since V2:
> - Update the commit message per Bjorn's feedback
> - Moved the structure definitions within the necessary guards as opposed
>   to wrapping the existing defintions with the appropriate guards.
>=20
> Changes since V1:
> - Added fixes tag
> - Fixed 'defined but not used' compiler warnings
>=20
>  drivers/pci/controller/dwc/Makefile           |   3 +-
>  .../pci/controller/dwc/pcie-tegra194-acpi.c   | 108 ++++++++++++++
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 138 +++---------------
>  3 files changed, 128 insertions(+), 121 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-tegra194-acpi.c

We've had a similar problem with Tegra210 EMC and the EMC frequency
table parsing code. The EMC frequency table parsing code needs to be
always built-in because it is stashed into a linker section. However
we still want the driver to be able to be a loadable module. The only
way I know how to achieve that is by splitting up the sources files
like you do here, so I this looks like a correct fix:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--aQWUWpnN9KJKqFLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDB1jYACgkQ3SOs138+
s6HLLBAArU5vNgX8kJNJFsVVYw3Azstm43F6ZHniLPd1GmbqncxAzbNoK6u9PryZ
s1dJzzlHvvA/t2KA2YtcxGdUII5hF4cYUxXvQK0tTSqU2JyCVT/9lvx4qQou24i0
GmkBp8yPanRJYHLntm8YJHETaGew6i/dXjfLAxIgpJGm3uBC/KNnSBr59a34+5zF
1LG1pzLojFV8zUS/a/zw2Krpq2vvudK6JTGNp5w5gifMFRM/11TMc4Sh7al6DlEX
AH9qoLpCL/kK4mWrFTxEtfw5NEwdmjsMQ3smHKTyZs8ZPxab2EZ2CRM6b3EI1TNK
EryNLPUrpgWtH5cJc9AU7APUesTmWlLQkWGytreuWNCTPfNPFG1hHxM9EWDbiv0K
t2fVvyIIu6EWQG+kdSHh0nH5lgunhNJnx0CoqQXT8iurhLBArbE2q8/hw2rpS6vE
FIDgzEIwSe8rvr49z8k1phQhXH0Ce77UQmz4PNMXk/rDBqCI7b2RfecVXbO1pvVo
DyB53alhO5Vuo1h4FK633ovx8qXZRBjt+3a9EBwlYqBd9mK00kLq9e1hHSYz7aNf
mbyCgNDDP98QcqzqD+f7hx4wBkjBi/4HrqJ4HwkDmuDv+QV3G12qjzjEA6/Xq/yQ
RfqGp1iXJ3/n4nMyS0kDSxyU7wtdks2XYb2jYpq6wg9N8dyJWro=
=Y3lX
-----END PGP SIGNATURE-----

--aQWUWpnN9KJKqFLO--
