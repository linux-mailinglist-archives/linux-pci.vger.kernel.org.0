Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC312B076A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKLOPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 09:15:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOPu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 09:15:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAF7FAD80;
        Thu, 12 Nov 2020 14:15:48 +0000 (UTC)
Message-ID: <2a4cb4700b219ddd9a059cbf484b7715e8036409.camel@suse.de>
Subject: Re: [PATCH] PCI: brcmstb: Restore initial fundamental reset
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Phil Elwell <phil@raspberrypi.com>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Date:   Thu, 12 Nov 2020 15:15:47 +0100
In-Reply-To: <20201112131400.3775119-1-phil@raspberrypi.com>
References: <20201112131400.3775119-1-phil@raspberrypi.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kj56CaKwqrmu4j7oYRUw"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-kj56CaKwqrmu4j7oYRUw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-12 at 13:14 +0000, Phil Elwell wrote:
> Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> replaced a single reset function with a pointer to one of two
> implementations, but also removed the call asserting the reset
> at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> used for USB booting but then need to be reset so that the kernel
> can reconfigure them. The lack of a reset causes the firmware's loading
> of the EEPROM image to RAM to fail, breaking USB for the kernel.
>=20
> Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
>=20
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!

>  drivers/pci/controller/pcie-brcmstb.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index bea86899bd5d..a90d6f69c5a1 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -869,6 +869,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> =20
>  	/* Reset the bridge */
>  	pcie->bridge_sw_init_set(pcie, 1);
> +	pcie->perst_set(pcie, 1);
> +
>  	usleep_range(100, 200);
> =20
>  	/* Take the bridge out of reset */


--=-kj56CaKwqrmu4j7oYRUw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+tQ5MACgkQlfZmHno8
x/6jWQgAk54thLEXBh49VbpBlLcQJWjMfIHzmdKb1gmPLYY1UgL1zvF/tj8rIcjK
bF4il61p5btyIRi3eBAr9oyMyFauPSM/8h8gVcih02O4D9wTYRTuw4wkHUTlo0gl
za+66vju2Qpp7biZOAY3r+uNeNCPUE8y7SKdNA/hkLED8jtkdhv/Ez2JixgNk48X
zfCvShDayGS8NgNrIXJoEvIxde+Vo/sZupv9h2gf8Z/Q09+j6HK6oUtRUSN4rVUf
+10hcBvIWYidy5pJYrmYw/dhNeF390Cq5LXxBz+b5GqPpPQTUYXBpfxNE84fAUo4
R4aGOe8IPQsscOA3ZoE+d4msduMDbQ==
=9Y3S
-----END PGP SIGNATURE-----

--=-kj56CaKwqrmu4j7oYRUw--

