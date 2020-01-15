Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D6413C167
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAOMp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 07:45:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:52176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAOMp1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 07:45:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BCDC4ADE7;
        Wed, 15 Jan 2020 12:45:25 +0000 (UTC)
Message-ID: <330ca207dcbcb41b9d094fb2606c45e4173fa8f6.camel@suse.de>
Subject: Re: [PATCH v5 0/6] Raspberry Pi 4 PCIe support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     devicetree@vger.kernel.org, f.fainelli@gmail.com, maz@kernel.org,
        phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, mbrugger@suse.com,
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
        andrew.murray@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Wed, 15 Jan 2020 13:45:23 +0100
In-Reply-To: <20200115120238.GA7233@e121166-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
         <20200115120238.GA7233@e121166-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-F2otfZC9sOf6KTpP904O"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-F2otfZC9sOf6KTpP904O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-01-15 at 12:02 +0000, Lorenzo Pieralisi wrote:
> On Mon, Dec 16, 2019 at 12:01:06PM +0100, Nicolas Saenz Julienne wrote:
> > This series aims at providing support for Raspberry Pi 4's PCIe
> > controller, which is also shared with the Broadcom STB family of
> > devices.
> >=20
> > There was a previous attempt to upstream this some years ago[1] but was
> > blocked as most STB PCIe integrations have a sparse DMA mapping[2] whic=
h
> > is something currently not supported by the kernel.  Luckily this is no=
t
> > the case for the Raspberry Pi 4.
> >=20
> > Note the series is based on top of linux next, as the DTS patch depends
> > on it.
> >=20
> > [1] https://patchwork.kernel.org/cover/10605933/
> > [2] https://patchwork.kernel.org/patch/10605957/
> >=20
> > ---
> >=20
> > Changes since v4:
> >   - Rebase DTS patch
> >   - Respin log2.h code into it's own series as it's still contentious
> >     yet mostly unrelated to the PCIe part
> >=20
> > Changes since v3:
> >   - Moved all the log2.h related changes at the end of the series, as I
> >     presume they will be contentious and I don't want the PCIe patches
> >     to depend on them. Ultimately I think I'll respin them on their own
> >     series but wanted to keep them in for this submission just for the
> >     sake of continuity.
> >   - Addressed small nits here and there.
> >=20
> > Changes since v2:
> >   - Redo register access in driver avoiding indirection while keeping
> >     the naming intact
> >   - Add patch editing ARM64's config
> >   - Last MSI cleanups, notably removing MSIX flag
> >   - Got rid of all _RB writes
> >   - Got rid of all of_data
> >   - Overall churn removal
> >   - Address the rest of Andrew's comments
> >=20
> > Changes since v1:
> >   - add generic rounddown/roundup_pow_two64() patch
> >   - Add MAINTAINERS patch
> >   - Fix Kconfig
> >   - Cleanup probe, use up to date APIs, exit on MSI failure
> >   - Get rid of linux,pci-domain and other unused constructs
> >   - Use edge triggered setup for MSI
> >   - Cleanup MSI implementation
> >   - Fix multiple cosmetic issues
> >   - Remove supend/resume code
> >=20
> > Jim Quinlan (3):
> >   dt-bindings: PCI: Add bindings for brcmstb's PCIe device
> >   PCI: brcmstb: Add Broadcom STB PCIe host controller driver
> >   PCI: brcmstb: Add MSI support
> >=20
> > Nicolas Saenz Julienne (3):
> >   ARM: dts: bcm2711: Enable PCIe controller
> >   MAINTAINERS: Add brcmstb PCIe controller
> >   arm64: defconfig: Enable Broadcom's STB PCIe controller
> >=20
> >  .../bindings/pci/brcm,stb-pcie.yaml           |   97 ++
> >  MAINTAINERS                                   |    4 +
> >  arch/arm/boot/dts/bcm2711.dtsi                |   31 +-
> >  arch/arm64/configs/defconfig                  |    1 +
> >  drivers/pci/controller/Kconfig                |    9 +
> >  drivers/pci/controller/Makefile               |    1 +
> >  drivers/pci/controller/pcie-brcmstb.c         | 1007 +++++++++++++++++
> >  7 files changed, 1149 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/brcm,stb-pcie=
.yaml
> >  create mode 100644 drivers/pci/controller/pcie-brcmstb.c
>=20
> Applied patches [1,3,4] to pci/brcmstb, please have a look to check
> everything is in order after the minor update I included.

Looks good to me.

Thanks,
Nicolas


--=-F2otfZC9sOf6KTpP904O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4fCWMACgkQlfZmHno8
x/7eNAf9E5M7dM+K4pFouDMsP1SzO9yIUBi8WCbONKVbOsyQ6p7LQBY4Kzj3sLoL
NB1VQMbdAD9+0ZxluUkMeuOxdiJU2CPHdEh8efJuyGzr3qMr4w8raGvUsOnAOzy9
zBgwz3k6phZZwcVHV+N/tNGQYbhHud7N09NHLLDZKN1GLYd3ezgoE72apUFKYvHi
7D7nByGSTSI6mhnQoRR243ct0usUQG4HHsB7ddDTno5sCNd9ViLPPtFna2bA9x6w
B/7ahcSzHd1z3MamuEyNYNgZ173kYI4pZmovxkWX/Nm+qAbJioQK/hmaCwsBl+jQ
8fAZVXVrBG8TYkR/zbChpgjg/RM3Tw==
=lFyM
-----END PGP SIGNATURE-----

--=-F2otfZC9sOf6KTpP904O--

