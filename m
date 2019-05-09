Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5003418BBC
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfEIO3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:29:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45438 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIO3k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 10:29:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so3324894wra.12;
        Thu, 09 May 2019 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xWQU6HJH+19i6j9SZLF0Xo/UujJbAMxC5DGiEW5/RI=;
        b=dNld1tRMWhScFFIYBQTNr36NdyqHPJBBuidx7PBQmoja8v8uo7bZnFssQQNGj+Juml
         rUWxFv6FIIAvfMRQfDAx6MPB8Oaa+E3LwUab5/vncJoqvG3L5x4MhxbNlVYIFbNLGDG0
         +xKHo9n3ApmtE6L2MtKfyUtkAy4Lk4vz3051kaQathhUbDWc+NcPAQvKdGEn9R1sllVL
         grrcQLFVYxnfBa8f8255I+5Tini28fKnMnOKinWYefbF+6Elo3kE+iSFm2IHtVD6wZC0
         XM2RVNUakc89pBwFF8/c0I2084bPBP6WTPLb1NKEM1pm3FA3vvUefZPjzjuvBV8qlxeU
         f+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xWQU6HJH+19i6j9SZLF0Xo/UujJbAMxC5DGiEW5/RI=;
        b=rNzCzHshqbfCGNzyw/83QMippKurZ44LIdnC48JPjmmuW/ZMiBNeyylpX/IRF3sMwu
         C5CYFh0TpYSsPJnk+G+qI2FzLAsDQoc5x/ntBT1vVYws3dOB0Ct0Ljvq+KFIiit6nVk8
         HZk7ejbgAcFx258VQzOERNhOYVQ9QpzMyQD0d9CaneJ3to9IdOb/ahu1vtVfhZSiUtuA
         ew8BjgY2RjgvBeV1UAaHCG3O+GBjgAC+4QcSVXf6EBD+09bBbXUckljk5Iqv5zlvuClf
         s6Mgl2MUeV6El9NS7Fg25iMlqYkSTfJgWig1u8NFPaDVH7jijuPpwWH0DhOhSxlXhb0E
         2w2w==
X-Gm-Message-State: APjAAAVrqVJOPNKw8Yweh+DA9KOl6yTsfeeZiQTNLTflW6ALuYKRZ+lf
        KrK7iNRrekq94TRzKh3LBnA=
X-Google-Smtp-Source: APXvYqyb0lhrBZThDyGeJUFUut4m2ERXjMWfITwRs9SlAmS5NR6+jGnmbVmsSX7pQldOSlTckmLmIA==
X-Received: by 2002:adf:81a2:: with SMTP id 31mr3433428wra.165.1557412178431;
        Thu, 09 May 2019 07:29:38 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id n15sm3263760wmi.42.2019.05.09.07.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 07:29:37 -0700 (PDT)
Date:   Thu, 9 May 2019 16:29:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 20/28] PCI: tegra: Use legacy irq for port service
 drivers
Message-ID: <20190509142936.GQ8907@ulmo>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-21-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3mUD2hqWbnBptYHy"
Content-Disposition: inline
In-Reply-To: <20190423092825.759-21-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3mUD2hqWbnBptYHy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 02:58:17PM +0530, Manikanta Maddireddy wrote:
> Tegra signals PCIe services like AER, PME, etc over legacy IRQ line.
> By default, service drivers register interrupt routine over MSI IRQ line.
> Use pcie_pme_disable_msi() function to disable MSI for service drivers.
>=20
> PME and AER interrupts registered to MSI without this change,
> cat /proc/interrupts | grep -i pci
> 36: 21 0 0 0 0 0 GICv2 104 Level       PCIE
> 37: 35 0 0 0 0 0 GICv2 105 Level       Tegra PCIe MSI
> 76: 0  0 0 0 0 0 Tegra PCIe MSI 0 Edge PCIe PME, aerdrv, PCIe BW notif
>=20
> PME and AER interrupts registered to legacy IRQ with this change,
> cat /proc/interrupts | grep -i pci
> 36: 33 0 0 0 0 0 GICv2 104 Level      PCIE, PCIe PME, aerdrv, PCIe BW not=
if
> 37: 52 0 0 0 0 0 GICv2 105 Level      Tegra PCIe MSI
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2: No change
>=20
>  drivers/pci/controller/pci-tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)

I think I mentioned this before, but it would be nice to make this
setting per-controller rather than system-global. In practice I guess
this doesn't really matter at this point, and I'm not sure how much
Bjorn cares, so:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 72634ce6d3da..edc6a0f27397 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -41,6 +41,7 @@
>  #include <soc/tegra/pmc.h>
> =20
>  #include "../pci.h"
> +#include "../pcie/portdrv.h"
> =20
>  #define INT_PCI_MSI_NR (8 * 32)
> =20
> @@ -2721,6 +2722,9 @@ static int tegra_pcie_probe(struct platform_device =
*pdev)
>  		goto put_resources;
>  	}
> =20
> +	/* Switch to legacy IRQ for PCIe services like AER, PME*/
> +	pcie_pme_disable_msi();
> +
>  	pm_runtime_enable(pcie->dev);
>  	err =3D pm_runtime_get_sync(pcie->dev);
>  	if (err) {
> --=20
> 2.17.1
>=20

--3mUD2hqWbnBptYHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUOVAACgkQ3SOs138+
s6HCxA//UrUL86LMU95RJrjuqvwVYJKT0fSy7PVkjFQQcnF3C+aVPEG/OyiG/B8B
5nwRFNZfmen44uPLeEqbBW8G4kMhFeackzeVTBCHxMUCFnJg6j1hlxqtWJgSo9Lt
se00pexpTVeFsG8s3r7ovdkAtLeWRtgt4W6ldwre7mrSpzQiXs6H7uPB10Z/0QYN
/XkHEoOmivy7AjOSKjBNTox/8vH/buzrbhmnZhYM5wMpT80AaeQ3Laj9s7SWTLvf
ETGaEVwM2KnEouBydan3YXENlSz/auglamH7radXcOHYLGCD35fssZtBb0kUAD2+
pMN6kJOmJmJ0LVAFBDraE8IMRKE4ybfX1i+iZKNLLg0X/cciAy5/4+PID+zYN/92
aPPS1ZeBrRy9kGHQe4xcpgJkcD0yOAtHmXyB5BZrK/CEXwUANRElsMN3MitAfx/9
gR+3orUkfw7dKh5ptyrhmxDo9WOwxC3BvQO5r/xXyaxSCApcEget3Y2sJRJ+pX4G
1RjaFdoSPV4sas+qilLWuXGtRcFZVYzb2FOP0jpOEY/RxMfjTISnQDtW/kttSwrt
uVknQgtMzTPDa7ra6cuufQE8syse2T5rrF/N0r5+3u0/vjQA8sI21rriXi3I8nNJ
BbK01FlMYnj/QS2cavbotIduJkCd50x4r/IpmMTBg+09E6MhJxo=
=ePGI
-----END PGP SIGNATURE-----

--3mUD2hqWbnBptYHy--
