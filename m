Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E21CC411
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEITU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 15:20:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgEITU3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 May 2020 15:20:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5D12AB99;
        Sat,  9 May 2020 19:20:29 +0000 (UTC)
Message-ID: <cae7a4e19281fa3a7a0f89bd7812212c8e2e829f.camel@suse.de>
Subject: Re: [PATCH v8 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Rob Herring <robh@kernel.org>, f.fainelli@gmail.com,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.gover@raspberrypi.org, helgaas@kernel.org,
        linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Date:   Sat, 09 May 2020 21:20:24 +0200
In-Reply-To: <c9449111-f646-3925-36e6-f4492ad5f90a@gmx.net>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
         <20200505161318.26200-3-nsaenzjulienne@suse.de>
         <20200507214859.GA562@bogus> <c9449111-f646-3925-36e6-f4492ad5f90a@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NYv+jnSD7ETBXidQR5XT"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-NYv+jnSD7ETBXidQR5XT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-05-09 at 12:02 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 07.05.20 um 23:48 schrieb Rob Herring:
> > On Tue,  5 May 2020 18:13:15 +0200, Nicolas Saenz Julienne wrote:
> > > The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip
> > > that implements xHCI. After a PCI reset, VL805's firmware may either =
be
> > > loaded directly from an EEPROM or, if not present, by the SoC's
> > > co-processor, VideoCore. RPi4's VideoCore OS contains both the non pu=
blic
> > > firmware load logic and the VL805 firmware blob. The function this pa=
tch
> > > introduces triggers the aforementioned process.
> > >=20
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > >=20
> > > ---
> > >=20
> > > Change since v7:
> > > - Use usleep_delay()
> > > - Add comment about PCI errors
> > > - Don't wait on error
> > > - Typos
> > >=20
> > > Change since v6:
> > > - Add test to avoid loading the firmware when not needed
> > > - Since we have it around, print VL805's firmware version, it'll make
> > > debugging easier in the future
> > > - Correct typos
> > > - Add a clearer view of HW topology in patch description
> > >=20
> > > Changes since v4:
> > > - Inline function definition when RASPBERRYPI_FIRMWARE is not defined
> > >=20
> > > Changes since v1:
> > > - Move include into .c file and add forward declaration to .h
> > >=20
> > >  drivers/firmware/raspberrypi.c             | 61 ++++++++++++++++++++=
++
> > >  include/soc/bcm2835/raspberrypi-firmware.h |  7 +++
> > >  2 files changed, 68 insertions(+)
> > >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> i modified the code a little bit for testing, but also successfully
> tested it without my modifications:
>=20
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 0d1422b..f3f4c2d 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -337,8 +337,10 @@ int rpi_firmware_init_vl805(struct pci_dev *pdev)
>          * further down the line.
>          */
>         pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET,
> &version);
> -       if (version)
> -               goto exit;
> +       if (version) {
> +               pci_info(pdev, "VL805 EEPROM firmware version %08x\n",
> version);
> +               return 0;
> +       }
> =20
>         dev_addr =3D pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 1=
5 |
>                    PCI_FUNC(pdev->devfn) << 12;
> @@ -353,9 +355,8 @@ int rpi_firmware_init_vl805(struct pci_dev *pdev)
> =20
>         pci_read_config_dword(pdev, VL805_PCI_CONFIG_VERSION_OFFSET,
>                               &version);
> -exit:
> -       pci_info(pdev, "VL805 firmware version %08x\n", version);
> =20
> +       pci_info(pdev, "VL805 RAM firmware version %08x\n", version);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(rpi_firmware_init_vl805);
>=20
> Here are the my results with 3x Raspberry Pi 4:
>=20
> VL805 EEPROM firmware version 000137ad
> VL805 EEPROM firmware version 00013701
> VL805 RAM firmware version 000137ad
>=20
> So the whole patch series is:
>=20
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks for taking the time!

Regards,
Nicolas


--=-NYv+jnSD7ETBXidQR5XT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl63AngACgkQlfZmHno8
x/5TSAf7BczpOl3QIubfrvp77qkSKnOA+Vb+zg5XlulurMIug2l+pqDVUw0G/+Gp
uwxEH4O0JxRg83lzCVFnP3Occ7dH5q5GA2yzBpcgVYvRLmlXw7NECJ1CqfAuB56S
YDSBEQk1Pm4fcAIufJCJ8hH25TxuMXoK+2qEq2WYY7x9RY3FiarvCFw+XV4ayX4n
s4rf/5spkVR3L1t6fMxmD6TQaGBwc6Ww2VFDTwJSTMjqxgU7iNHmjypv7XxaLuYl
MkvpDgAyxuxI0R/MblN/rdNO2Fd2LCAQi5rU3VvEfcrrq6fm5YIt5sxnHzAOMfvK
aIuwkpFCcR+EWHlJ7pQ4+dYrITgvPg==
=iV4L
-----END PGP SIGNATURE-----

--=-NYv+jnSD7ETBXidQR5XT--

