Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBD91D1141
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 13:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEML0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 07:26:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:38228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEML0E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 07:26:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 957CDAF36;
        Wed, 13 May 2020 11:26:05 +0000 (UTC)
Message-ID: <e3f5ea8acdeee14571f77060b5711fce46d86bd1.camel@suse.de>
Subject: Re: [PATCH v8 0/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Date:   Wed, 13 May 2020 13:26:00 +0200
In-Reply-To: <20200513111717.GA32365@e121166-lin.cambridge.arm.com>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
         <20200513111717.GA32365@e121166-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AhWRdoINwjRGD4bp+/gD"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-AhWRdoINwjRGD4bp+/gD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-13 at 12:17 +0100, Lorenzo Pieralisi wrote:
> On Tue, May 05, 2020 at 06:13:13PM +0200, Nicolas Saenz Julienne wrote:
> > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either b=
e
> > loaded directly from an EEPROM or, if not present, by the SoC's
> > co-processor, VideoCore. This series adds support for the later.
> >=20
> > Note that there are a set of constraints we have to consider:
> >  - We need to make sure the VideoCore firmware interface is up and
> >    running before running the VL805 firmware load call.
> >=20
> >  - There is no way to discern RPi4's VL805 chip from other platforms',
> >    so we need the firmware load to happen *before* running
> >    quirk_usb_handoff_xhci(). Failure to do so results in an unwarranted
> >    5 second wait while the fixup code polls xHC's non-existing state.
> >=20
> > By Florian's suggestion I've been spending some time exploring the devi=
ce
> > link[1] API in order to see if that could save us from explicitly creat=
ing
> > probe dependencies between pcie-brcmstb and firmware/raspberrypi (patch=
 #3).
> > Technically these dependencies could be inferred from DT. It turns out
> > Saravana
> > Kannan has been looking at this already. A new boot mechanism, activate=
d
> > with
> > fw_devlink=3Don takes care of the device probe ordering on devices with
> > consumer/supplier relationships. For now this relationship is created b=
ased
> > on
> > the usage of generic DT properties, but has no support for vendor-speci=
fc DT
> > properties, which we'd be forced to use in order to create a relationsh=
ip
> > between our two devices since our setup is highly non generic. There wi=
ll
> > probably be at some point support for such properties, and we will then=
 be
> > able
> > to revisit some of this code.
> >=20
> > All this is based on the work by Tim Gover in RPi's downstream
> > kernel[2].
> >=20
> > [1] https://www.kernel.org/doc/html/v4.13/driver-api/device_link.html
> > [2]=20
> >=20
https://github.com/raspberrypi/linux/commit/9935b4c7e360b4494b4cb6e3ce79723=
8a1ab78bd
> >=20
> > ---
> >=20
> > Changes since v7:
> >  - Address Stefan's comments
> >=20
> > Changes since v6:
> >  - Make rpi_firmware_init_vl805() more robust
> >  - Rewrite comments and patch descriptions to be more accessible to non=
 RPi
> >    fluent people
> >  - Removed Florian's Reviewed-by in patch #2 as function changed
> >    substantially
> >  - Tested with/witout u-boot
> >=20
> > Changes since v5:
> >  - Fix issues reported by Kbuild test robot
> >=20
> > Changes since v4:
> >  - Addressed Sergei's comments
> >  - Fix potential warning in patch #2
> >=20
> > Changes since v3:
> >  - Addressed Greg's comments
> >=20
> > There was no v2, my bad.
> >=20
> > Changes since v1:
> >  - Addressed Floarians comments
> >=20
> > Nicolas Saenz Julienne (4):
> >   soc: bcm2835: Add notify xHCI reset property
> >   firmware: raspberrypi: Introduce vl805 init routine
> >   PCI: brcmstb: Wait for Raspberry Pi's firmware when present
> >   USB: pci-quirks: Add Raspberry Pi 4 quirk
> >=20
> >  drivers/firmware/Kconfig                   |  3 +-
> >  drivers/firmware/raspberrypi.c             | 61 ++++++++++++++++++++++
> >  drivers/pci/controller/pcie-brcmstb.c      | 17 ++++++
> >  drivers/usb/host/pci-quirks.c              | 16 ++++++
> >  include/soc/bcm2835/raspberrypi-firmware.h |  9 +++-
> >  5 files changed, 104 insertions(+), 2 deletions(-)
>=20
> Hi Nicolas,
>=20
> should I queue this series via the PCI tree ? Just let me know, most of
> the changes are not in the PCI tree, asking in order to
> minimize/simplify conflicts handling if possible.

Yes, I agree, it's better if you take the whole thing.

Thanks,
Nicolas


--=-AhWRdoINwjRGD4bp+/gD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl672UkACgkQlfZmHno8
x/6lzQgAtDUjnjJd0Zuqd4pj4VT1XSzzQNMButVbZ5d+gcCtJR68q5lNzhejWtjL
hc8ncq03srEPDueXQiuwqK/kMxG9emt5s65ZAW7cmlzNeq300bdyQLbJKRApXdPO
ACtx3+KFOvLfOmeFzTD94DZL8yrfsTs3aEDuOgJeUfTheiUyySR3W+tWLUsJ9Fwo
aT3NaDPv/7raoV3TOJ/+lfXHZ3Mu2fbvawVjDaea0ksVLCgHP+0RKVljzIty9HUJ
TCuM5xm6H817e4x2d41HQliJeHTxAuA5ZUKHrYmtrJ3Z76Fs+XrwesCvM+vha9VS
5zKyHpHrTNN0ORi89ZN5EtKhUNrpvg==
=XtBQ
-----END PGP SIGNATURE-----

--=-AhWRdoINwjRGD4bp+/gD--

