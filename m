Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88FC1DD3
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfI3JVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 05:21:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727935AbfI3JVA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 05:21:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF5F1B087;
        Mon, 30 Sep 2019 09:20:57 +0000 (UTC)
Message-ID: <202216c6e456bfd1a30f7cdb000aa714e3855e10.camel@suse.de>
Subject: Re: [PATCH 00/11] of: dma-ranges fixes and improvements
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Date:   Mon, 30 Sep 2019 11:20:55 +0200
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/7Fyj1jMsFE0z7R36gtv"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-/7Fyj1jMsFE0z7R36gtv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-26 at 19:24 -0500, Rob Herring wrote:
> This series fixes several issues related to 'dma-ranges'. Primarily,
> 'dma-ranges' in a PCI bridge node does correctly set dma masks for PCI
> devices not described in the DT. A common case needing dma-ranges is a
> 32-bit PCIe bridge on a 64-bit system. This affects several platforms
> including Broadcom, NXP, Renesas, and Arm Juno. There's been several
> attempts to fix these issues, most recently earlier this week[1].
>=20
> In the process, I found several bugs in the address translation. It
> appears that things have happened to work as various DTs happen to use
> 1:1 addresses.
>=20
> First 3 patches are just some clean-up. The 4th patch adds a unittest
> exhibiting the issues. Patches 5-9 rework how of_dma_configure() works
> making it work on either a struct device child node or a struct
> device_node parent node so that it works on bus leaf nodes like PCI
> bridges. Patches 10 and 11 fix 2 issues with address translation for
> dma-ranges.
>=20
> My testing on this has been with QEMU virt machine hacked up to set PCI
> dma-ranges and the unittest. Nicolas reports this series resolves the
> issues on Rpi4 and NXP Layerscape platforms.
>=20
> Rob
>=20
> [1]=20
>=20
https://lore.kernel.org/linux-arm-kernel/20190924181244.7159-1-nsaenzjulien=
ne@suse.de/
>=20
> Rob Herring (5):
>   of: Remove unused of_find_matching_node_by_address()
>   of: Make of_dma_get_range() private
>   of/unittest: Add dma-ranges address translation tests
>   of/address: Translate 'dma-ranges' for parent nodes missing
>     'dma-ranges'
>   of/address: Fix of_pci_range_parser_one translation of DMA addresses
>=20
> Robin Murphy (6):
>   of: address: Report of_dma_get_range() errors meaningfully
>   of: Ratify of_dma_configure() interface
>   of/address: Introduce of_get_next_dma_parent() helper
>   of: address: Follow DMA parent for "dma-coherent"
>   of: Factor out #{addr,size}-cells parsing
>   of: Make of_dma_get_range() work on bus nodes

Re-tested the whole series. Verified both the unittests run fine and PCIe's
behaviour is fixed.

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Also for the whole series:

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-/7Fyj1jMsFE0z7R36gtv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2RyPcACgkQlfZmHno8
x/5aaggAjeyCHdUtuhmPYMOr0eHC3qN6bd3dUsbXdN2lP82cn6S6n08OsHIfHaS/
mKzeb3RK8lHn7v8Pv/nfe7UU93Lxx4Dyq4D4vXXTWyTFNg67C/KxtJswHvKhdQBX
u/r/OIhCnewJLTEZV9g44OFAko61Zuf8mp8KIwSjj+vfUXORyUc/KLfFYNt6b8Fb
YQRdgTyuF4Xhy/XYdxn8uCcDKkz0MtQ1Z9yJiao0h1c5p1Hia8Xhilq7uglx6+/3
w6Izh+0OAiDP30yMBVW+5APyhFPUdfzlP3hdifrkv8LiwCyMsukutfWawrm0r9E6
Ubrk8jYhhRg1qlpwQQ9V6QeapBjgsA==
=14/S
-----END PGP SIGNATURE-----

--=-/7Fyj1jMsFE0z7R36gtv--

