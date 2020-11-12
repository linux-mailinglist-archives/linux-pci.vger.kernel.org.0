Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC80E2B01A3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 10:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKLJHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 04:07:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:38790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgKLJH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 04:07:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D358AF0D;
        Thu, 12 Nov 2020 09:07:26 +0000 (UTC)
Message-ID: <77ba062d8ce103db81fcc7ac8b802e1b54befda8.camel@suse.de>
Subject: Re: [PATCH v2] PCI: brcmstb: Fix race in removing chained IRQ
 handler
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Martin Kaiser <martin@kaiser.cx>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Nov 2020 10:07:25 +0100
In-Reply-To: <20201111215354.21961-1-martin@kaiser.cx>
References: <20201108184208.19790-1-martin@kaiser.cx>
         <20201111215354.21961-1-martin@kaiser.cx>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nlC5Zykkv/JgdsEcxKIv"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-nlC5Zykkv/JgdsEcxKIv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-11 at 22:53 +0100, Martin Kaiser wrote:
> Call irq_set_chained_handler_and_data() to clear the chained handler
> and the handler's data under irq_desc->lock.
>=20
> See also 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained
> IRQ handler").
>=20
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!

> v2:
>  - rewrite the commit message to clarify that this is a bugfix
>=20
>  drivers/pci/controller/pcie-brcmstb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> index bea86899bd5d..7c666f4deb47 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -606,8 +606,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
> =20
>  	if (!msi)
>  		return;
> -	irq_set_chained_handler(msi->irq, NULL);
> -	irq_set_handler_data(msi->irq, NULL);
> +	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
>  	brcm_free_domains(msi);
>  }
> =20


--=-nlC5Zykkv/JgdsEcxKIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+s+00ACgkQlfZmHno8
x/7+Ggf/Zh+wMFcBh01rd+OOjl5oKxh2JrHjuK+wk3LOOacpflQn74tOURADGmC3
hfrCxT2hKd5SwI6zFBYpzeMxf7TflZgg3UeeO/ITLEbX+Cp3whQJNXRSSxpXTXbF
NJuYj12FpHDWJhYyBTGeKMDuH7eCZwnhK04zOTbCbIgQz9GvTzm+5LITfPy/Yj2W
z+GIs0lKp4IkeTMNc9kBrzTkBrtNS7TazVV+wy2XDh5ps7boaMMSWuoVncjIEn7B
hXwquankBQAo6hDocMlEvduR5SXN/gRNEFS9w1b/s8MdFMVjiRzj+31HMcCsOtKL
ZbGNGHQ1jNHYGk/h3DzEMVsXdpkhcA==
=We75
-----END PGP SIGNATURE-----

--=-nlC5Zykkv/JgdsEcxKIv--

