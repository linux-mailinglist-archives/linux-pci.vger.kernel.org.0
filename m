Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FD1FD555
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQTVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 15:21:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:34460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgFQTVg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 15:21:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E869ADC9;
        Wed, 17 Jun 2020 19:21:38 +0000 (UTC)
Message-ID: <9450f86c15ecd8435bcdbc395f8674172a975100.camel@suse.de>
Subject: Re: [PATCH v3 4/9] ARM: dts: bcm2711: Add reset controller to xHCI
 node
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, andy.shevchenko@gmail.com,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org, wahrenst@gmx.net,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed, 17 Jun 2020 21:21:31 +0200
In-Reply-To: <20200612171334.26385-5-nsaenzjulienne@suse.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-5-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lfIoWXagrdDHMww3Jq4T"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-lfIoWXagrdDHMww3Jq4T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Fri, 2020-06-12 at 19:13 +0200, Nicolas Saenz Julienne wrote:
> The chip is hardwired to the board's PCIe bus and needs to be properly
> setup trough a firmware routine after a PCI fundamental reset. Pass the
> reset controller phandle that takes care of triggering the
> initialization to the relevant PCI device.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>
> ---
>
> Changes since v2:
>  - Use dt-bindings to access IDs
>
> Changes since v1:
>  - Update to match new binding
>
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> index 0cef95058fb0..e20979013414 100644
> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
> @@ -4,6 +4,8 @@
>  #include "bcm2835-rpi.dtsi"
>  #include "bcm283x-rpi-usb-peripheral.dtsi"
>
> +#include <dt-bindings/reset/raspberrypi,firmware-reset.h>
> +
>  / {
>  	compatible =3D "raspberrypi,4-model-b", "brcm,bcm2711";
>  	model =3D "Raspberry Pi 4 Model B";
> @@ -207,6 +209,13 @@ phy1: ethernet-phy@1 {
>  	};
>  };
>
> +&pcie0 {
> +	usb@1,0 {
> +		reg =3D <0 0 0 0 0>;
> +		resets =3D <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
> +	};
> +};
> +

I'm now double-guessing this is correct. With this lspci -tv output:

[0000:00]---00.0-[01]----00.0  VIA Technologies, Inc. VL805 USB 3.0 Host Co=
ntroller

The DT patch should be more like this:

+&pcie0 {
+       pci@0 {
+               #address-cells =3D <3>;
+               #size-cells =3D <2>;
+               ranges;
+
+               reg =3D <0 0 0 0 0>;
+
+               usb@1,0 {
+                       reg =3D <0x10000 0 0 0 0>;
+                       resets =3D <&reset RASPBERRYPI_FIRMWARE_RESET_ID_US=
B>;
+               };
+       };
+};

Small details aside I'm pretty confident this is the way to go, but would
appreciate some comments/validation.

Regards,
Nicolas


--=-lfIoWXagrdDHMww3Jq4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7qbTsACgkQlfZmHno8
x/4CVggAn3Z1hf15FCwZBqJ5vtu95aPDbATL/d0KQ7jGrs66dTwaOP6aBJFw48YF
0wKRsvMe9LukIRSOBh9HluSEszmQj7/hUGRYcsXaBgmHeOVs9PCXDbJb0/XtgBwF
3EvokrD1MRS9bcpXwVOCKsMu+wjaGMlCiiJ6wmvD2ffybDPtYA19Xci86XF3Y2WT
PTeuhEXh+/+wADvH/z0Gi4ivdIAh6FGLbdaSSVgEpf1JChHkSH0anKhw78keHGWK
WXifnT/7XqG9VtvNNmFvQ1+q7MoyyJlzCn/NXfNuhjmBV+A6gxhefrVRq+P2yeb7
LzlXGvG8m8RsQQgt1TlpTQwfAjB8KQ==
=jUpw
-----END PGP SIGNATURE-----

--=-lfIoWXagrdDHMww3Jq4T--

