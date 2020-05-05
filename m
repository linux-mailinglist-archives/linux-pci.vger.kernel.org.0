Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8425D1C56B6
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgEENX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:23:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:46206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbgEENX7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 09:23:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBA43AB3D;
        Tue,  5 May 2020 13:23:59 +0000 (UTC)
Message-ID: <7946e8efb23376a395d32b2ae2ea240c519502b9.camel@suse.de>
Subject: Re: [PATCH v2 1/4] PCI: brcmstb: Don't clk_put() a managed clock
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 05 May 2020 15:23:54 +0200
In-Reply-To: <20200501142831.35174-2-james.quinlan@broadcom.com>
References: <20200501142831.35174-1-james.quinlan@broadcom.com>
         <20200501142831.35174-2-james.quinlan@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-j/ZrGLyXvIzAV7yVCtRN"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-j/ZrGLyXvIzAV7yVCtRN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-01 at 10:28 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
>=20
> clk_put() was being invoked on a clock obtained by
> devm_clk_get_optional().
>=20
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas

>  drivers/pci/controller/pcie-brcmstb.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-brcmstb.c
> b/drivers/pci/controller/pcie-brcmstb.c
> index 6d79d14527a6..454917ee9241 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -899,7 +899,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie=
)
>  	brcm_msi_remove(pcie);
>  	brcm_pcie_turn_off(pcie);
>  	clk_disable_unprepare(pcie->clk);
> -	clk_put(pcie->clk);
>  }
> =20
>  static int brcm_pcie_remove(struct platform_device *pdev)


--=-j/ZrGLyXvIzAV7yVCtRN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6xaOoACgkQlfZmHno8
x/4zFAf6A28BXIGgiFx4cGET/exjJuFYtSEdnxdHqrU3xmv0+qw+NJRL+o6kzhqa
Pb1Wx5+R2KV1NbiU0BKwzhHL8vj2KiE2k/zi14dvyEoy1EHsnu3aQ96eeXralUOU
AjubnENtm+mfBPX03xZaWzjRGs4fgrJbqEEE3INb8Iji4X85iMhTh46ylY49Hkdz
oM0lPWTRTAEXQLzBONZe7VQi+S0Zd1t8mY0IZV8nJYifwqgvYoJdSvXzNxCfJ3fA
slYEVGW5maJEO/qHsWKyJYE17mwWPGeskeAVF4dQWQt1rDPc1vm+AsaCJzjPLMhM
904BWZ69Lu3pdxhAiLGBX8dd+oRvzA==
=A2C7
-----END PGP SIGNATURE-----

--=-j/ZrGLyXvIzAV7yVCtRN--

