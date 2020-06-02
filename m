Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852921EB90F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 12:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBKFZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 06:05:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:46340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgFBKFZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 06:05:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F90EAD12;
        Tue,  2 Jun 2020 10:05:25 +0000 (UTC)
Message-ID: <7cbe4da8ba4a1524824473f8c58720f412a00fc2.camel@suse.de>
Subject: Re: [PATCH v8 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        gregkh@linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Jun 2020 12:05:20 +0200
In-Reply-To: <20200505161318.26200-5-nsaenzjulienne@suse.de>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
         <20200505161318.26200-5-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ePWuOhLXkyI0rM3f0PjZ"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-ePWuOhLXkyI0rM3f0PjZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-05 at 18:13 +0200, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideoCore. Inform VideoCore that VL805 was just reset.
>=20
> Also, as this creates a dependency between USB_PCI and VideoCore's
> firmware interface, and since USB_PCI can't be set as a module neither
> this can. Reflect that on the firmware interface Kconfg.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

It was pointed out to me on the u-boot mailing lists that all this could be
implemented trough a reset controller. In other words have xhci get the res=
et
controller trough device-tree, assert it, ultamately causing the firmware
routine to be run.

As much as it pains me to go over stuff that's already 'fixed', it seems to=
 me
it's a better solution. On one hand we get over the device-tree dependency =
mess
(see patch #3), and on the other we transform a pci-quirk into something le=
ss
hacky.

That said, before getting my hands dirty, I was wondering if there is any
obvious reasons why I shouldn't do this, note that:

- We're talking here of a PCIe XCHI device, maybe there's an issue integrat=
ing
  it with DT, given the fact that, as of today, it's not really represented
  there.

- There is no reset controller support in xhci-pci, maybe there are good
  reasons why. For instance, it's not something that's reflected in any way=
 in
  the spec.

Regards,
Nicolas

>=20
> Changes since v5:
>  - Fix Kconfig issue with allmodconfig
>=20
> Changes since v4:
>  - Do not split up error message
>=20
> Changes since v3:
>  - Add more complete error message
>=20
> Changes since v1:
>  - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
>    gets compiled when needed.
>=20
>  drivers/firmware/Kconfig      |  3 ++-
>  drivers/usb/host/pci-quirks.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 8007d4aa76dc..b42140cff8ac 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -178,8 +178,9 @@ config ISCSI_IBFT
>  	  Otherwise, say N.
> =20
>  config RASPBERRYPI_FIRMWARE
> -	tristate "Raspberry Pi Firmware Driver"
> +	bool "Raspberry Pi Firmware Driver"
>  	depends on BCM2835_MBOX
> +	default USB_PCI
>  	help
>  	  This option enables support for communicating with the firmware on th=
e
>  	  Raspberry Pi.
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.=
c
> index 92150ecdb036..0b949acfa258 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -16,6 +16,9 @@
>  #include <linux/export.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> +
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
>  #include "pci-quirks.h"
>  #include "xhci-ext-caps.h"
> =20
> @@ -1243,11 +1246,24 @@ static void quirk_usb_handoff_xhci(struct pci_dev
> *pdev)
> =20
>  static void quirk_usb_early_handoff(struct pci_dev *pdev)
>  {
> +	int ret;
> +
>  	/* Skip Netlogic mips SoC's internal PCI USB controller.
>  	 * This device does not need/support EHCI/OHCI handoff
>  	 */
>  	if (pdev->vendor =3D=3D 0x184e)	/* vendor Netlogic */
>  		return;
> +
> +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_VIA && pdev->device =3D=3D 0x3483=
) {
> +		ret =3D rpi_firmware_init_vl805(pdev);
> +		if (ret) {
> +			/* Firmware might be outdated, or something failed */
> +			dev_warn(&pdev->dev,
> +				 "Failed to load VL805's firmware: %d. Will
> continue to attempt to work, but bad things might happen. You should fix
> this...\n",
> +				 ret);
> +		}
> +	}
> +
>  	if (pdev->class !=3D PCI_CLASS_SERIAL_USB_UHCI &&
>  			pdev->class !=3D PCI_CLASS_SERIAL_USB_OHCI &&
>  			pdev->class !=3D PCI_CLASS_SERIAL_USB_EHCI &&


--=-ePWuOhLXkyI0rM3f0PjZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7WJGAACgkQlfZmHno8
x/6SjQf/Qywc5xMG/WfuS5YbTgjiJzIg9nJVk2umtOVQOaE6cXK6I2HUcLXKSphG
ZAIxOSd8yG38RZGU/E/XCiWpYe0uEjJYnR4gKLF4/QsTwWKvjXvksXvcZYD/d4/U
JJeFUPeutvO90Q3WSiUowjt0/uEaH8PDdYSvPfqe/DZt6loaIHXJXhv8M1e/R8a8
Jatksa8pTD5uVBYYJFgY83Mrwd/SJ8/LthiE5FCHc1z1L3sbaChf+26xKtvn3iHU
j1taE9o84y6m2IqDVDLZVeU2yuYt/VPOsnA5JarsZX/y1HoFg9OdoJL7GTazUefj
q6BBn3BmYTUIQvDBgXg/JY1MYyNoEA==
=5e/e
-----END PGP SIGNATURE-----

--=-ePWuOhLXkyI0rM3f0PjZ--

