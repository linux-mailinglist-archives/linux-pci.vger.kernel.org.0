Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA9F2BA6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbfKGJ6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:58:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:41222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbfKGJ6U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:58:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68354AFA7;
        Thu,  7 Nov 2019 09:58:18 +0000 (UTC)
Message-ID: <6391b0574abbe9f669fd5b8c539d306fb64aaba7.camel@suse.de>
Subject: Re: [PATCH 0/4] Raspberry Pi 4 PCIe support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org
Date:   Thu, 07 Nov 2019 10:58:16 +0100
In-Reply-To: <5e3df7af-d7be-2408-7b53-13a0e38e9478@gmail.com>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
         <5e3df7af-d7be-2408-7b53-13a0e38e9478@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9+CcCd+frESmTBhEBdh8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-9+CcCd+frESmTBhEBdh8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-06 at 13:51 -0800, Florian Fainelli wrote:
> On 11/6/19 1:45 PM, Nicolas Saenz Julienne wrote:
> > This series aims at providing support for Raspberry Pi 4's PCIe
> > controller, which is also shared with the Broadcom STB family of
> > devices.
> >=20
> > There was a previous attempt to upstream this some years ago[1] but was
> > blocked as most STB PCIe integrations have a sparse DMA mapping[2] whic=
h
> > is something currently not supported by the kernel.  Luckily this is no=
t
> > the case for the Raspberry Pi 4.
> >=20
> > Note that the driver code is to be based on top of Rob Herring's series
> > simplifying inbound and outbound range parsing.
> >=20
> > [1] https://patchwork.kernel.org/cover/10605933/
> > [2] https://patchwork.kernel.org/patch/10605957/
>=20
> Thanks for picking up on this Nicolas. Can you amend the MAINTAINERS
> file with something along those lines such that PCIe binding and driver
> changes are picked up by both the BCM2835 and BCM7XXX entries?
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba1095547fd..4276a30f3294 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3196,6 +3196,8 @@ S:        Maintained
>  N:     bcm2711
>  N:     bcm2835
>  F:     drivers/staging/vc04_services
> +F:     Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +F:     drivers/pci/controller/pcie-brcmstb.c
>=20
>  BROADCOM BCM47XX MIPS ARCHITECTURE
>  M:     Hauke Mehrtens <hauke@hauke-m.de>
> @@ -3251,6 +3253,7 @@ F:        drivers/bus/brcmstb_gisb.c
>  F:     arch/arm/mm/cache-b15-rac.c
>  F:     arch/arm/include/asm/hardware/cache-b15-rac.h
>  N:     brcmstb
> +F:     Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>=20
>  BROADCOM BMIPS CPUFREQ DRIVER
>  M:     Markus Mayer <mmayer@broadcom.com>
>=20

Ok, noted, I'll add that patch to v2.


--=-9+CcCd+frESmTBhEBdh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3D6rgACgkQlfZmHno8
x/7uuwf/dOmDBfR85tFZWNiXZ87/YYUeVY/OGHACLI0ieSBKa2qdCJSFl4TzWe6I
Ur9nlLsi4MEtNTtUlE919ZlLuC7Y8R4J0bIK5vCY/AnRcnWvPyQXqyjMnv+BkhDu
sLc8I3YEGAtVL05o7P+63+Jb8RqDoQVOBOXPP6LAHSn2amevOGp6UUETlsW7KNVo
FHMO7fHmlpdW+Wdk9nzzVJ65NEk8SeyqM8AgCCm5QVrvMVwkiMHemcYoN7UH/SuJ
oHZVup66FLWCxOqOWdQHcb4cUMPh9da0ZmJwSJJ40yBH4Q7UP6HYzhMlHjkVED5Y
QzNn1tWx78yWq5mKFaSMxBNhWBUSDQ==
=XJ+I
-----END PGP SIGNATURE-----

--=-9+CcCd+frESmTBhEBdh8--

