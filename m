Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49691CEAFD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 19:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfJGRwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 13:52:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbfJGRwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 13:52:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 194BFAE1A;
        Mon,  7 Oct 2019 17:51:57 +0000 (UTC)
Message-ID: <1f6089709ec8f77d12453f08730b0058345a352b.camel@suse.de>
Subject: Re: [PATCH 05/11] of: Ratify of_dma_configure() interface
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Mon, 07 Oct 2019 19:51:13 +0200
In-Reply-To: <CAL_JsqLo0jtDcCDf5VTc+_grO3fJ1MsDTE8Bj=B0J+eLk3hpZg@mail.gmail.com>
References: <20190927002455.13169-1-robh@kernel.org>
         <20190927002455.13169-6-robh@kernel.org>
         <20190930125752.GD12051@infradead.org>
         <95f8dabea99f104336491281b88c04b58d462258.camel@suse.de>
         <CAL_JsqLnKxuQRR3sGGtXF3nwwDx7DOONPPYz37ROk7u_+cxRug@mail.gmail.com>
         <0557c83bcb781724a284811fef7fdb122039f336.camel@suse.de>
         <CAL_JsqLo0jtDcCDf5VTc+_grO3fJ1MsDTE8Bj=B0J+eLk3hpZg@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RfW6mXnOY9RVgKryA6oE"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-RfW6mXnOY9RVgKryA6oE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 20:53 -0500, Rob Herring wrote:
> > > > But I think that with this series, given the fact that we now treat=
 the
> > > > lack
> > > > of
> > > > dma-ranges as a 1:1 mapping instead of an error, we could rewrite t=
he
> > > > function
> > > > like this:
> > >=20
> > > Now, I'm reconsidering allowing this abuse... It's better if the code
> > > which understands the bus structure in DT for a specific bus passes i=
n
> > > the right thing. Maybe I should go back to Robin's version (below).
> > > OTOH, the existing assumption that 'dma-ranges' was in the immediate
> > > parent was an assumption on the bus structure which maybe doesn't
> > > always apply.
> > >=20
> > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > index a45261e21144..6951450bb8f3 100644
> > > --- a/drivers/of/device.c
> > > +++ b/drivers/of/device.c
> > > @@ -98,12 +98,15 @@ int of_dma_configure(struct device *dev, struct
> > > device_node *parent, bool force_
> > >         u64 mask;
> > >=20
> > >         np =3D dev->of_node;
> > > -       if (!np)
> > > -               np =3D parent;
> > > +       if (np)
> > > +               parent =3D of_get_dma_parent(np);
> > > +       else
> > > +               np =3D of_node_get(parent);
> > >         if (!np)
> > >                 return -ENODEV;
> > >=20
> > > -       ret =3D of_dma_get_range(np, &dma_addr, &paddr, &size);
> > > +       ret =3D of_dma_get_range(parent, &dma_addr, &paddr, &size);
> > > +       of_node_put(parent);
> > >         if (ret < 0) {
> > >                 /*
> > >                  * For legacy reasons, we have to assume some devices=
 need
> >=20
> > I spent some time thinking about your comments and researching. I came =
to
> > the
> > realization that both these solutions break the usage in
> > drivers/gpu/drm/sun4i/sun4i_backend.c:805. In that specific case both
> > 'dev->of_node' and 'parent' exist yet the device receiving the configur=
ation
> > and 'parent' aren't related in any way.
>=20
> I knew there was some reason I didn't like those virtual DT nodes...
>=20
> That does seem to be the oddest case. Several of the others are just
> non-DT child platform devices. Perhaps we need a "copy the DMA config
> from another struct device (or parent struct device)" function to
> avoid using a DT function on a non-DT device.
>=20
> > IOW we can't just use 'dev->of_node' as a starting point to walk upward=
s the
> > tree. We always have to respect whatever DT node the bus provided, and =
start
> > there. This clashes with the current solutions, as they are based on th=
e
> > fact
> > that we can use dev->of_node when present.
>=20
> Yes, you are right.
>=20
> > My guess at this point, if we're forced to honor that behaviour, is tha=
t we
> > have to create a new API for the PCI use case. Something the likes of
> > of_dma_configure_parent().
>=20
> I think of_dma_configure just has to work with the device_node of
> either the device or the device parent and dev->of_node is never used
> unless the caller sets it.

Fine, so given the following two distinct uses of
of_dma_configure(struct device *dev, struct device_node *np, bool ...):

- dev->of_node =3D=3D np: Platform bus' typical use, we imperatively have t=
o start
  parsing dma-ranges from np's DMA parent, as the device we're configuring
  might be a bus containing dma-ranges himself. For example a platform PCIe=
 bus.

- dev->of_node !=3D np: Here the bus is pulling some trick. The device migh=
t or
  might not be represented in DT and np might be a bus or a device. But one
  thing I realised is that device being configured never represents a memor=
y
  mapped bus. Assuming this assumption is acceptable, we can traverse the D=
T
  tree starting from np and get a correct configuration as long as dma-rang=
es
  not being present is interpreted as a 1:1 mapping.

The resulting code, which I tested on an RPi4, Freescale Layerscape and pas=
ses
OF's unit tests, looks like this:

int of_dma_configure(struct device *dev, struct device_node *np, bool force=
_dma)
{
	u64 dma_addr, paddr, size =3D 0;
	struct device_node *parent;
	u64 mask;
	int ret;

	if (!np)
		return -ENODEV;

	parent =3D of_node_get(np);
	if (dev->of_node =3D=3D parent)
		parent =3D of_get_next_dma_parent(np);

	ret =3D of_dma_get_range(parent, &dma_addr, &paddr, &size);
	of_node_put(parent);

	[...]
}

Would that be acceptable?

Regards,
Nicolas


--=-RfW6mXnOY9RVgKryA6oE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2bexEACgkQlfZmHno8
x/4bKAf+P/rR6qUNJNu0v4BM+BoxWKPz1uoSsKaXAf/WrbARW9vSD2R+aL23gwZX
qtjjZK0SbTy8jfEBqgzDYFd6jmOCmPJdPU81w1mfJlNcj1asQnXMa5U6YKig1Vkw
//dDLUR0eDFAvemXBO9u9xa0j4fWr8K5ewBogDsWR2VALGeJ+v8cX6X30KDKglH+
k/NJ4JxfMHPfwygV1JQDX+0ypNdcgX9Gdy4DHoX2HXS0d5BSKntw2qB0P595VDOo
a3J3M1wo4f6yyxHFmtm4SWvv6ipvHKx3R409xosuaUTjiu/8RaNWtF7aTNTAwy6I
byrfMtJMaPVwSWxJNicSDC0wWwbuYA==
=F4oK
-----END PGP SIGNATURE-----

--=-RfW6mXnOY9RVgKryA6oE--

