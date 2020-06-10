Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0B1F57F4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgFJPiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 11:38:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:34326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgFJPiH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 11:38:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9CE7BAE33;
        Wed, 10 Jun 2020 15:38:09 +0000 (UTC)
Message-ID: <82a21cbdca6bced2ee8e4e5a857faaa31a672193.camel@suse.de>
Subject: Re: [PATCH v2 2/9] reset: Add Raspberry Pi 4 firmware reset
 controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
Date:   Wed, 10 Jun 2020 17:37:58 +0200
In-Reply-To: <6ab60539-5aa2-17dc-21d5-1bae9ec259f6@broadcom.com>
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
         <20200609175003.19793-3-nsaenzjulienne@suse.de>
         <6ab60539-5aa2-17dc-21d5-1bae9ec259f6@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iY+/tawMFmcwHBpEZ1lp"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-iY+/tawMFmcwHBpEZ1lp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-09 at 11:14 -0700, Florian Fainelli wrote:
>=20
> On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> > Raspberry Pi 4's co-processor controls some of the board's HW
> > initialization process, but it's up to Linux to trigger it when
> > relevant. Introduce a reset controller capable of interfacing with
> > RPi4's co-processor that models these firmware initialization routines =
as
> > reset lines.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> >=20
> > Changes since v1:
> >   - Make the whole driver less USB centric as per Florian's comments
> >=20
> >  drivers/reset/Kconfig             |  11 +++
> >  drivers/reset/Makefile            |   1 +
> >  drivers/reset/reset-raspberrypi.c | 126 ++++++++++++++++++++++++++++++
> >  3 files changed, 138 insertions(+)
> >  create mode 100644 drivers/reset/reset-raspberrypi.c
> >=20
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index d9efbfd29646..97e848740e13 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -140,6 +140,17 @@ config RESET_QCOM_PDC
> >  	  to control reset signals provided by PDC for Modem, Compute,
> >  	  Display, GPU, Debug, AOP, Sensors, Audio, SP and APPS.
> > =20
> > +config RESET_RASPBERRYPI
> > +	tristate "Raspberry Pi 4 Firmware Reset Driver"
> > +	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=3Dn &&
> > COMPILE_TEST)
> > +	default USB_XHCI_PCI
> > +	help
> > +	  Raspberry Pi 4's co-processor controls some of the board's HW
> > +	  initialization process, but it's up to Linux to trigger it when
> > +	  relevant. This driver provides a reset controller capable of
> > +	  interfacing with RPi4's co-processor and model these firmware
> > +	  initialization routines as reset lines.
> > +
> >  config RESET_SCMI
> >  	tristate "Reset driver controlled via ARM SCMI interface"
> >  	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index 249ed357c997..16947610cc3b 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -21,6 +21,7 @@ obj-$(CONFIG_RESET_OXNAS) +=3D reset-oxnas.o
> >  obj-$(CONFIG_RESET_PISTACHIO) +=3D reset-pistachio.o
> >  obj-$(CONFIG_RESET_QCOM_AOSS) +=3D reset-qcom-aoss.o
> >  obj-$(CONFIG_RESET_QCOM_PDC) +=3D reset-qcom-pdc.o
> > +obj-$(CONFIG_RESET_RASPBERRYPI) +=3D reset-raspberrypi.o
> >  obj-$(CONFIG_RESET_SCMI) +=3D reset-scmi.o
> >  obj-$(CONFIG_RESET_SIMPLE) +=3D reset-simple.o
> >  obj-$(CONFIG_RESET_STM32MP157) +=3D reset-stm32mp1.o
> > diff --git a/drivers/reset/reset-raspberrypi.c b/drivers/reset/reset-
> > raspberrypi.c
> > new file mode 100644
> > index 000000000000..5fc8c6319a20
> > --- /dev/null
> > +++ b/drivers/reset/reset-raspberrypi.c
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Raspberry Pi 4 firmware reset driver
> > + *
> > + * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset-controller.h>
> > +#include <soc/bcm2835/raspberrypi-firmware.h>
> > +
> > +struct rpi_reset {
> > +	struct reset_controller_dev rcdev;
> > +	struct rpi_firmware *fw;
> > +};
> > +
> > +enum rpi_reset_ids {
> > +	RASPBERRYPI_FIRMWARE_RESET_ID_USB,
>=20
> You should probably move this to a header file under
> include/dt-bindings/reset/ in order to ensure that what gets referenced
> by the DTS is in sync with what the driver knows about.
>=20
> With that:
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks! Will fix that on v3.

Regards,
Nicolas


--=-iY+/tawMFmcwHBpEZ1lp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7g/lYACgkQlfZmHno8
x/64wwf/RYKRcYtQrYP84kh2wNnt3cg/Wpd0S0ByYf3aEG+uXl+47UxwFvgXD9Tt
BK/xqLnRFfh/6zlU/3EDUB3zsWySdJbXHr2zRLZeTbRF7oAQ3cEcWBs91l8hmc8V
Rjm8Fhv7PlmW8EsPmR8uhlI2aCqtN4zJfppNClZP4SNL3L1aLTO1RwQkwwWLdZbp
ffSWvsFeGUIKvEeWj+UTgABfQN9KDnDFfsLvLXsmHEhLjYJ8Nc+HHLiuWcseU2Bg
amIjktOYU2r6oUihyqB5Sou67Cq5zEJXHCKN/WFzCLc+5KsAaAMsIQa9tABTBOcp
N2OVcD5P30BJgAL8WcjZJsWtKqDftg==
=8vmx
-----END PGP SIGNATURE-----

--=-iY+/tawMFmcwHBpEZ1lp--

