Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752001C56BF
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgEENZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:25:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:46738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbgEENZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 09:25:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55C02AB89;
        Tue,  5 May 2020 13:25:13 +0000 (UTC)
Message-ID: <a23de9954ffca762bdcd075c4ed02b1a17af3eb5.camel@suse.de>
Subject: Re: [PATCH v2 2/4] PCI: brcmstb: Fix window register offset from 4
 to 8
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 05 May 2020 15:25:07 +0200
In-Reply-To: <20200501142831.35174-3-james.quinlan@broadcom.com>
References: <20200501142831.35174-1-james.quinlan@broadcom.com>
         <20200501142831.35174-3-james.quinlan@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WdhCVQQ77luNuTrwjynR"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-WdhCVQQ77luNuTrwjynR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-01 at 10:28 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
>=20
> The outbound memory window registers were being referenced
> with an incorrect stride offset.  This probably wasn't noticed
> previously as there was likely only one such window employed.
>=20
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>=20
> Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller
> driver")
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas

>  drivers/pci/controller/pcie-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-brcmstb.c
> b/drivers/pci/controller/pcie-brcmstb.c
> index 454917ee9241..5b0dec5971b8 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -54,11 +54,11 @@
> =20
>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
>  #define PCIE_MEM_WIN0_LO(win)	\
> -		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
> +		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
> =20
>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
>  #define PCIE_MEM_WIN0_HI(win)	\
> -		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
> +		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
> =20
>  #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
>  #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f


--=-WdhCVQQ77luNuTrwjynR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6xaTMACgkQlfZmHno8
x/7l/wgAqNRIM6mZcLbEIafYCYznZMUminRZvoGWDMa0AwR/Ei3ngd3/mhph4nuA
lsn6NfNF2SbIpz7gE+UslD9UW6L8MWG9M0cAfMKPyJQuqkGjYa/0cTBJIr+VVTfc
fsbKn/xCa5Dku8sbKXAvjxMh3hzgFrZrYIlnJwdLPvD4oxUHkDoXLJyowalp4scx
MELFQgm2NyYvznpYRhKwnbIYZNqQis9RpZgimsrLpjOTXYFeARKZAY+p63cn4c8u
kiANyMwcDyNARBa4B5cjg7gxT20kwIQDMPGj63lp8wknIuIkwf9mKuhiglcrjlHF
bNmX73xmfHGy7qSbCisqETc6qyxKsA==
=PUO0
-----END PGP SIGNATURE-----

--=-WdhCVQQ77luNuTrwjynR--

