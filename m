Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842161C56F5
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgEENbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 09:31:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgEENbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 09:31:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 06B06AC7B;
        Tue,  5 May 2020 13:31:37 +0000 (UTC)
Message-ID: <71f91033780ee9d95da2be44884d4d47efb03b5f.camel@suse.de>
Subject: Re: [PATCH v2 4/4] PCI: brcmstb: Disable L0s component of ASPM if
 requested
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
Date:   Tue, 05 May 2020 15:31:32 +0200
In-Reply-To: <20200501142831.35174-5-james.quinlan@broadcom.com>
References: <20200501142831.35174-1-james.quinlan@broadcom.com>
         <20200501142831.35174-5-james.quinlan@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/WMc+4hb6CwtaW97uLCZ"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-/WMc+4hb6CwtaW97uLCZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-01 at 10:28 -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
>=20
> Some informal internal experiments has shown that the BrcmSTB ASPM L0s
> savings may introduce an undesirable noise signal on some customers'
> boards.  In addition, L0s was found lacking in realized power savings,
> especially relative to the L1 ASPM component.  This is BrcmSTB's
> experience and may not hold for others.  At any rate, if the
> 'aspm-no-l0s' property is present L0s will be disabled.
>=20
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Modulo the new generic dt property:

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-brcmstb.c
> b/drivers/pci/controller/pcie-brcmstb.c
> index 5b0dec5971b8..73020b4ff090 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -41,6 +41,9 @@
>  #define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
>  #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
> =20
> +#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
> +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
> +
>  #define PCIE_RC_DL_MDIO_ADDR				0x1100
>  #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>  #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
> @@ -693,7 +696,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	int num_out_wins =3D 0;
>  	u16 nlw, cls, lnksta;
>  	int i, ret;
> -	u32 tmp;
> +	u32 tmp, aspm_support;
> =20
>  	/* Reset the bridge */
>  	brcm_pcie_bridge_sw_init_set(pcie, 1);
> @@ -803,6 +806,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		num_out_wins++;
>  	}
> =20
> +	/* Don't advertise L0s capability if 'aspm-no-l0s' */
> +	aspm_support =3D PCIE_LINK_STATE_L1;
> +	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> +		aspm_support |=3D PCIE_LINK_STATE_L0S;
> +	tmp =3D readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +	u32p_replace_bits(&tmp, aspm_support,
> +		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +
>  	/*
>  	 * For config space accesses on the RC, show the right class for
>  	 * a PCIe-PCIe bridge (the default setting is to be EP mode).


--=-/WMc+4hb6CwtaW97uLCZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6xarQACgkQlfZmHno8
x/5F2Af+NaU0XhF5SOoN9k/cqs0QD3cUh2gPJSrKgygCuqC79eeu2CIH9k3OmXSK
2ArwxrQvKZS8cw8icZPETD6PuD5Z0bWmeUbl7dbTZwReORzCUeFGGjbFJUCw6mLv
gzxQ1QTT60/rf2BeVu520PJeCB/KAnsiqwNo63UJhGYsdExXwGLyQqmgldCCfktl
9i8QE/4C4Ne3A1QXj0aowFHD9pCI54bYj3UeDFo2Z7C0Hb2vMAt+KDkGiR40dDF2
FBaM1gII/IUVqt12qLngl2aYjCWa8VQro6Hz53IM/Bkf1QVUbjYNq3GsIXph4sLQ
81jE683L/9ZlfI95hcoWXr8aaqGdsQ==
=aXbi
-----END PGP SIGNATURE-----

--=-/WMc+4hb6CwtaW97uLCZ--

