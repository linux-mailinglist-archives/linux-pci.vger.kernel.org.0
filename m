Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4F68EE42
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBHLvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBHLvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:51:03 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2732F49038;
        Wed,  8 Feb 2023 03:51:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so20054665edb.7;
        Wed, 08 Feb 2023 03:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpzLHah2ZL4c5hmmwr1CJtR3jb4Zb36OkgfZKd35lY4=;
        b=RkVmwtEhaN7N5woOejLRThyE/j23ltCWLsvZ0Na/roneLm0C+KY2q3ke9VAsMJSbcN
         fIwCf2rEoZQOUnbMK0SusHW+qzHDkE61Gvas6LchiTNkftVlV5X3f2AbXDrf//jbZ9Jk
         MDFzwowVoWFalfFFtBXNiuA969ATZU2nmKjnTVDveaJ39EleF2zUGEgc0HosDqxwvZtg
         2XhPcA0Ple80nC9J+pCRTj9EHEMxARKD9MVtyUjhHoPaa65u9kYd4CPS0iz3NEqLm+sO
         kpO9gmoNCtWqhLKQOjsfl6BaqvOTePAFHtmdXbaeFLxbikD90sFPG2L5ThC3AOTEjQEV
         GrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpzLHah2ZL4c5hmmwr1CJtR3jb4Zb36OkgfZKd35lY4=;
        b=g6gcahPBICevUBYiV8bDpDs9ub5MdtE+QIKwfbEr67w4/sN9Ia1lDMSAgt3yGmcE9H
         3JiGpyDnAKWdQvVAGRe8phx60+GbsVfXcMr87kT6UjlVtyrXQ/K/YsZBrGgBiEZ+1EIS
         xpCM+z3/QtnMV2ryFYaPDFBbeKQ7YJU+yJMT9JSLf7kcA8FpvvgTBS8g1ijaAnnF54dD
         xmxL4jkvOIm+8gAARCVB4XUDvbgi9VLehqXVhSQZiD7qWzo/b/wX/rBAlBu2mIZg7qi/
         u08+WIyZDxOzRya9iCjtzHvfydxfOyDR7DoyVpqpgIOgBsAGKzmxUs5F10ifXxstf141
         LTLA==
X-Gm-Message-State: AO0yUKX68ZyHh0qcdwTbeO6sxva4CFiCmJ+Q4/PphDVmPS9h3o6BnsTH
        F1V6+gAyz+8PRcWKjpIp8Sc=
X-Google-Smtp-Source: AK7set9T3VrnWt1+Yy67oP/ix7PQzAEgXSPYqdjZBvU9LNpcaEVF5ZsF/CPXcyNhqswJYKvanqmrbw==
X-Received: by 2002:a50:ccc6:0:b0:4aa:c4bb:2372 with SMTP id b6-20020a50ccc6000000b004aac4bb2372mr7548080edj.32.1675857058573;
        Wed, 08 Feb 2023 03:50:58 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y12-20020a056402270c00b0049668426aa6sm7737717edd.24.2023.02.08.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 03:50:58 -0800 (PST)
Date:   Wed, 8 Feb 2023 12:50:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
Subject: Re: [RFC,v14 3/5] PCI / PM: Add support for the PCIe WAKE# signal
 for OF
Message-ID: <Y+OMoKOfduwj2PYp@orome>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-4-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1q5Qd0tqx26fwrBX"
Content-Disposition: inline
In-Reply-To: <20230208111645.3863534-4-mmaddireddy@nvidia.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--1q5Qd0tqx26fwrBX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 04:46:43PM +0530, Manikanta Maddireddy wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>=20
> Add of_pci_setup_wake_irq() to parse the PCIe WAKE# interrupt from the
> device tree and set the wake irq. Add of_pci_teardown_wake_irq() to clear
> the wake irq.
>=20
> Call of_pci_setup_wake_irq() in pci_device_probe() to setup PCIe WAKE#
> interrupt during PCIe Endpoint enumeration.
>=20
> Enable or disable PCIe WAKE# interrupt in platform_pci_set_wakeup().
>=20
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>=20
> Changes in v14:
> pci_platform_pm_ops structure is removed in latest kernel, so dropped
> pci-of driver. Instead, enable wake in platform_pci_set_wakeup().
>=20
> Changes in v13:
> Fix compiler error reported by kbuild test robot <fengguang.wu@intel.com>
>=20
> Changes in v12:
> Enable the wake irq in noirq stage to avoid possible irq storm.
>=20
> Changes in v11:
> Only support 1-per-device PCIe WAKE# pin as suggested.
>=20
> Changes in v10:
> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
>=20
> Changes in v9:
> Fix check error in .cleanup().
> Move dedicated wakeirq setup to setup() callback and use
> device_set_wakeup_enable() to enable/disable.
>=20
> Changes in v8:
> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
>=20
> Changes in v7:
> Move PCIE_WAKE handling into pci core.
>=20
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
>=20
> Changes in v5:
> Rebase.
>=20
> Changes in v3:
> Fix error handling.
>=20
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq.
>=20
>  drivers/pci/of.c         | 49 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-driver.c | 10 ++++++++
>  drivers/pci/pci.c        |  7 ++++++
>  drivers/pci/pci.h        |  8 +++++++
>  4 files changed, 74 insertions(+)
>=20
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ff897c40ed71..1c348e63f175 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -13,6 +13,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/pm_wakeirq.h>
>  #include "pci.h"
> =20
>  #ifdef CONFIG_PCI
> @@ -705,3 +706,51 @@ u32 of_pci_get_slot_power_limit(struct device_node *=
node,
>  	return slot_power_limit_mw;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> +
> +int of_pci_setup_wake_irq(struct pci_dev *pdev)
> +{
> +	struct pci_dev *ppdev;

Perhaps "parent" since that's what it is referring to? ppdev is a bit
vague.

> +	struct device_node *dn;
> +	int ret, irq;
> +
> +	/* Get the pci_dev of our parent. Hopefully it's a port. */
> +	ppdev =3D pdev->bus->self;
> +	/* Nope, it's a host bridge. */
> +	if (!ppdev)
> +		return 0;
> +
> +	dn =3D pci_device_to_OF_node(ppdev);
> +	if (!dn)
> +		return 0;
> +
> +	irq =3D of_irq_get_byname(dn, "wakeup");
> +	if (irq =3D=3D -EPROBE_DEFER) {
> +		return irq;
> +	} else if (irq < 0) {
> +		/* Ignore other errors, since a missing wakeup is non-fatal. */
> +		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);

dev_dbg() maybe? As it is this would add an annoying info message for
basically every PCI controller on every DT-based board out there.

Thierry

--1q5Qd0tqx26fwrBX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjjKAACgkQ3SOs138+
s6Gc1g//QDcPcTt+z4P1/kQA57KiH2zlcgzNOHcfKJtNlVguNQSSAG5ebtfi2RMP
ZuKRK6HIBVEV7ar3yse0qNIZoYLldgL8x4vSsyPJsZu0GBwZEF+B181I/2KJ9gk9
qM72LtQb7vc3HAoqSxmYT8JWSlQfsBVOEtEQoMphev34JXNivf5HsasEm2umzjnf
lCP+jiCyBDiK+RWGckOuYtNTfIUussbHFt1oMbSHomRpEKr4nLlhYrfGbUiCB4wz
MTecWQI1y4o6LYG/CUDYM/2mepNPmmcjBUA4Xn/eI+lRrX+SKFmsSx5bkZUikHFl
6lfJwuPYiAjwcPUa88+LdvKb1l6/OuVgmk0H6ei/FBqEBWDmf8GQbH7V9H/UhWxP
BnSpsrI5U2/eaLGwWC/Di/79rdQbkw2XdjaJqjKPL8UfBoeGRNSRP3QHrnoTXyus
33VXhRrgVKL71a37tt3j0ZUzrwJwERg+TeY7WhoCn1+pjIwLUq9lFpQYFyDjc0Sw
qK9Haxrs9jsjpI2M+AEb6DtkBw7u76sYyU3De9Yc5QILcFnj+mtfLbsLS9wlOhZY
EEonuEpDhRkGFqHp5Wd4Ff0Qjm04QcPd5/zwDCu5F3WG/7H7RphNlrTKSqsDkF7a
bgHtdYdeHec0rSwIIbHG1wMUFKkyuLIYJrChvR8pcFkAi0V4XbA=
=ULUl
-----END PGP SIGNATURE-----

--1q5Qd0tqx26fwrBX--
