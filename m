Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1B109B6E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKZJnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 04:43:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:35112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbfKZJnn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 04:43:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBD8DBBFE;
        Tue, 26 Nov 2019 09:43:40 +0000 (UTC)
Message-ID: <26c9cb9434fe59b61884e0e43d116fbff6c8590a.camel@suse.de>
Subject: Re: [PATCH v3 3/7] ARM: dts: bcm2711: Enable PCIe controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Phil Elwell <phil@raspberrypi.org>, andrew.murray@arm.com,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, jeremy.linton@arm.com,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 26 Nov 2019 10:43:39 +0100
In-Reply-To: <ede90a60-8194-4035-01c2-2673f4a8cfe7@raspberrypi.org>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
         <20191126091946.7970-4-nsaenzjulienne@suse.de>
         <ede90a60-8194-4035-01c2-2673f4a8cfe7@raspberrypi.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MjOyRhx4Yk8pEyDha5vk"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-MjOyRhx4Yk8pEyDha5vk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-26 at 09:37 +0000, Phil Elwell wrote:
> Hi Nicolas,
>=20
> On 26/11/2019 09:19, Nicolas Saenz Julienne wrote:
> > This enables bcm2711's PCIe bus, which is hardwired to a VIA
> > Technologies XHCI USB 3.0 controller.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > This will likely need a rebase once the RPi GENET patches land.
> >=20
> > Changes since v2:
> >    - Remove unused interrupt-map
> >    - correct dma-ranges to it's full size, non power of 2 bus DMA
> >      constraints now supported in linux-next[1]
> >    - add device_type
> >    - rename alias from pcie_0 to pcie0
> >=20
> > Changes since v1:
> >    - remove linux,pci-domain
> >=20
> > [1] https://lkml.org/lkml/2019/11/21/235
> >=20
> >   arch/arm/boot/dts/bcm2711.dtsi | 41 +++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 41 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711=
.dtsi
> > index 667658497898..2e121fc8b3d0 100644
> > --- a/arch/arm/boot/dts/bcm2711.dtsi
> > +++ b/arch/arm/boot/dts/bcm2711.dtsi
> > @@ -288,6 +288,47 @@ IRQ_TYPE_LEVEL_LOW)>,
> >   		arm,cpu-registers-not-fw-configured;
> >   	};
> >  =20
> > +	scb {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <1>;
> > +
> > +		ranges =3D <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
> > +			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
> > +
> > +		pcie0: pcie@7d500000 {
> > +			compatible =3D "brcm,bcm2711-pcie";
> > +			reg =3D <0x0 0x7d500000 0x9310>;
> > +			device_type =3D "pci";
> > +			#address-cells =3D <3>;
> > +			#interrupt-cells =3D <1>;
> > +			#size-cells =3D <2>;
> > +			interrupts =3D <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names =3D "pcie", "msi";
> > +			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> > +			interrupt-map =3D <0 0 0 1 &gicv2 GIC_SPI 143
> > +							IRQ_TYPE_LEVEL_HIGH>;
> > +			msi-controller;
> > +			msi-parent =3D <&pcie0>;
> > +
> > +			ranges =3D <0x02000000 0x0 0xf8000000 0x6 0x00000000
> > +				  0x0 0x04000000>;
> > +			/*
> > +			 * The wrapper around the PCIe block has a bug
> > +			 * preventing it from accessing beyond the first 3GB of
> > +			 * memory. As the bus DMA mask is rounded up to the
> > +			 * closest power of two of the dma-range size, we're
> > +			 * forced to set the limit at 2GB. This can be
> > +			 * harmlessly changed in the future once the DMA code
> > +			 * handles non power of two DMA limits.
> > +			 */
> > +			dma-ranges =3D <0x02000000 0x0 0x00000000 0x0 0x00000000
> > +				      0x0 0xc0000000>;
>=20
> The comment doesn't match the data here - I think for now the size field=
=20
> needs to be reduced to 2GB to match the comment.

You're right, my bad, should've edited it out. The good part is that with t=
his
commit[1], which will soon be in Linus' tree, we don't need to fake dma-ran=
ges
size anymore.

So for the record, the comment should state the following:

	/*
	 * The wrapper around the PCIe block has a bug
	 * preventing it from accessing beyond the first 3GB of
	 * memory.
	 */

Regards,
Nicolas

[1] https://lkml.org/lkml/2019/11/21/235


--=-MjOyRhx4Yk8pEyDha5vk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3c88sACgkQlfZmHno8
x/7oswgAh8iyNGIM8/MJDFgcwiJ/KpGC9jc+vkjrrB7lLjA2i2L72hTIiHL4BbzE
6sM5qVV7uml+1a9QwNLMsHkJQrK4VXdJohQEkPG+qqa1qWuYuQX9JIqA4CGowiMZ
X/tWSCI5DJS3npMmiOCXlh7zZBaZx90iuJZXMqWRKHuEXlw5nN/rfkYiMyf4J0kD
xquAH7gT/Tx5O20oh9cKjOoa745pbnX7At6qwIg7DTbU8mb2zLJWLhHA/GZmfkv3
dmzw2btV71x+s3JVkfdzzA9g+Ttm+MUbu4GJzVqkshuEUU3BR6If7xBQTh7EH51C
HFvZfdwyqnMSXjipC6RpifYEEX5tGQ==
=sINh
-----END PGP SIGNATURE-----

--=-MjOyRhx4Yk8pEyDha5vk--

