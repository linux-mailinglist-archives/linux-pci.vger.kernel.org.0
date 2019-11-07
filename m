Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDA38F36FC
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfKGSYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 13:24:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:42680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfKGSYK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 13:24:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 707D4ACA5;
        Thu,  7 Nov 2019 18:24:07 +0000 (UTC)
Message-ID: <2dcc3fca914a454006bcf2e9bd4479a30228e9fa.camel@suse.de>
Subject: Re: [PATCH 2/4] ARM: dts: bcm2711: Enable PCIe controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org, mbrugger@suse.com,
        james.quinlan@broadcom.com
Date:   Thu, 07 Nov 2019 19:24:03 +0100
In-Reply-To: <50074e33-17bf-d555-cbf6-4ec079472ecd@gmx.net>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
         <20191106214527.18736-3-nsaenzjulienne@suse.de>
         <50074e33-17bf-d555-cbf6-4ec079472ecd@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TlMxNcfADV/A26dcLaFO"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-TlMxNcfADV/A26dcLaFO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-07 at 18:44 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> please move this patch behind the driver patches, which is the better ord=
er.
>=20
> Am 06.11.19 um 22:45 schrieb Nicolas Saenz Julienne:
> > This enables bcm2711's PCIe bus, wich is hardwired to a VIA Technologie=
s
> > XHCI USB 3.0 controller.
> AFAIU this only applies to the Raspberry Pi 4, since the VIA is outside
> of the SoC.
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  arch/arm/boot/dts/bcm2711.dtsi | 47 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711=
.dtsi
> > index a9d84e28f245..c7b2e7b57da6 100644
> > --- a/arch/arm/boot/dts/bcm2711.dtsi
> > +++ b/arch/arm/boot/dts/bcm2711.dtsi
> > @@ -288,6 +288,53 @@
> >  		arm,cpu-registers-not-fw-configured;
> >  	};
> >=20
> > +	scb {
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <1>;
> > +
> > +		ranges =3D <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
> > +			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
> > +
> > +		pcie_0: pcie@7d500000 {
> > +			compatible =3D "brcm,bcm2711-pcie";
> > +			reg =3D <0x0 0x7d500000 0x9310>;
> > +			msi-controller;
> > +			msi-parent =3D <&pcie_0>;
> > +			#address-cells =3D <3>;
> > +			#interrupt-cells =3D <1>;
> > +			#size-cells =3D <2>;
> > +			linux,pci-domain =3D <0>;
> > +			brcm,enable-ssc;
> > +			interrupts =3D <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names =3D "pcie", "msi";
> > +			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> > +			interrupt-map =3D <0 0 0 1 &gicv2 GIC_SPI 143
> > +							IRQ_TYPE_LEVEL_HIGH
> > +					 0 0 0 2 &gicv2 GIC_SPI 144
> > +							IRQ_TYPE_LEVEL_HIGH
> > +					 0 0 0 3 &gicv2 GIC_SPI 145
> > +							IRQ_TYPE_LEVEL_HIGH
> > +					 0 0 0 4 &gicv2 GIC_SPI 146
> > +							IRQ_TYPE_LEVEL_HIGH>;
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
> > +				      0x0 0x80000000>;
> In case this bug will ever be fixed, do you see this as a future proof
> practical solution?

The dts I provide should work on any bcm2711 (fixed or not) and any future
kernel, with the downside that we'll perform some unnecessary buffer bounci=
ng.

If we were able to address the whole 32bit address space on some future bcm=
2711
we'd be forced to update the dma-ranges in the bootloader based on the SoC
revision.

The driver should work with any sensible dma-range, I even did a test emula=
ting
the 4GB inbound memory setup.

Regards,
Nicolas


--=-TlMxNcfADV/A26dcLaFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3EYUMACgkQlfZmHno8
x/7I8gf+Krf4eAVjY+gGoFj4B/+Wk2M4/i71Ubp+SIWiZarPgzumoZIAaDv91+YO
qwHAuQGIEnx8YvltDs3CkbNUJBzwuQAZQ9Ve652E8P/f4+wM+XVegdIWTk3M1G2/
t2N8OH87E+Ag8pGV9bfAtFi7oyFC3a+HDGLTAN1RezBLzlnn1EhN7fr4xXT7lQA7
HPmn9BjtUkQaXDMSghNPH9TaEVpEVxeRx9pXrDVaNQGeQN3RtfpznjbQj7GFHnG/
HYtWFf8ha82VlW+9EoWIXxKx0GQgZq9pehmr3cFgETyxUFf0AQCgVE0yhOXW/f5X
4xQXvqZLhwYBafJgw6LKn6qwz0vlpw==
=9wr0
-----END PGP SIGNATURE-----

--=-TlMxNcfADV/A26dcLaFO--

