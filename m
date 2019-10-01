Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B7C3959
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 17:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJAPnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 11:43:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:55430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbfJAPnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 11:43:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 972FDAD2A;
        Tue,  1 Oct 2019 15:43:12 +0000 (UTC)
Message-ID: <0557c83bcb781724a284811fef7fdb122039f336.camel@suse.de>
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
Date:   Tue, 01 Oct 2019 17:43:09 +0200
In-Reply-To: <CAL_JsqLnKxuQRR3sGGtXF3nwwDx7DOONPPYz37ROk7u_+cxRug@mail.gmail.com>
References: <20190927002455.13169-1-robh@kernel.org>
         <20190927002455.13169-6-robh@kernel.org>
         <20190930125752.GD12051@infradead.org>
         <95f8dabea99f104336491281b88c04b58d462258.camel@suse.de>
         <CAL_JsqLnKxuQRR3sGGtXF3nwwDx7DOONPPYz37ROk7u_+cxRug@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Cs3oOlvxVqdSsNFddCdM"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-Cs3oOlvxVqdSsNFddCdM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 16:24 -0500, Rob Herring wrote:
> On Mon, Sep 30, 2019 at 8:32 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > On Mon, 2019-09-30 at 05:57 -0700, Christoph Hellwig wrote:
> > > On Thu, Sep 26, 2019 at 07:24:49PM -0500, Rob Herring wrote:
> > > > -int of_dma_configure(struct device *dev, struct device_node *np, b=
ool
> > > > force_dma)
> > > > +int of_dma_configure(struct device *dev, struct device_node *paren=
t,
> > > > bool
> > > > force_dma)
> > >=20
> > > This creates a > 80 char line.
> > >=20
> > > >  {
> > > >     u64 dma_addr, paddr, size =3D 0;
> > > >     int ret;
> > > >     bool coherent;
> > > >     unsigned long offset;
> > > >     const struct iommu_ops *iommu;
> > > > +   struct device_node *np;
> > > >     u64 mask;
> > > >=20
> > > > +   np =3D dev->of_node;
> > > > +   if (!np)
> > > > +           np =3D parent;
> > > > +   if (!np)
> > > > +           return -ENODEV;
> > >=20
> > > I have to say I find the older calling convention simpler to understa=
nd.
> > > If we want to enforce the invariant I'd rather do that explicitly:
> > >=20
> > >       if (dev->of_node && np !=3D dev->of_node)
> > >               return -EINVAL;
> >=20
> > As is, this would break Freescale Layerscape fsl-mc bus' dma_configure(=
):
>=20
> This may break PCI too for devices that have a DT node.
>=20
> > static int fsl_mc_dma_configure(struct device *dev)
> > {
> >         struct device *dma_dev =3D dev;
> >=20
> >         while (dev_is_fsl_mc(dma_dev))
> >                 dma_dev =3D dma_dev->parent;
> >=20
> >         return of_dma_configure(dev, dma_dev->of_node, 0);
> > }
> >=20
> > But I think that with this series, given the fact that we now treat the=
 lack
> > of
> > dma-ranges as a 1:1 mapping instead of an error, we could rewrite the
> > function
> > like this:
>=20
> Now, I'm reconsidering allowing this abuse... It's better if the code
> which understands the bus structure in DT for a specific bus passes in
> the right thing. Maybe I should go back to Robin's version (below).
> OTOH, the existing assumption that 'dma-ranges' was in the immediate
> parent was an assumption on the bus structure which maybe doesn't
> always apply.
>=20
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index a45261e21144..6951450bb8f3 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -98,12 +98,15 @@ int of_dma_configure(struct device *dev, struct
> device_node *parent, bool force_
>         u64 mask;
>=20
>         np =3D dev->of_node;
> -       if (!np)
> -               np =3D parent;
> +       if (np)
> +               parent =3D of_get_dma_parent(np);
> +       else
> +               np =3D of_node_get(parent);
>         if (!np)
>                 return -ENODEV;
>=20
> -       ret =3D of_dma_get_range(np, &dma_addr, &paddr, &size);
> +       ret =3D of_dma_get_range(parent, &dma_addr, &paddr, &size);
> +       of_node_put(parent);
>         if (ret < 0) {
>                 /*
>                  * For legacy reasons, we have to assume some devices nee=
d

I spent some time thinking about your comments and researching. I came to t=
he
realization that both these solutions break the usage in
drivers/gpu/drm/sun4i/sun4i_backend.c:805. In that specific case both
'dev->of_node' and 'parent' exist yet the device receiving the configuratio=
n
and 'parent' aren't related in any way.

IOW we can't just use 'dev->of_node' as a starting point to walk upwards th=
e
tree. We always have to respect whatever DT node the bus provided, and star=
t
there. This clashes with the current solutions, as they are based on the fa=
ct
that we can use dev->of_node when present.

My guess at this point, if we're forced to honor that behaviour, is that we
have to create a new API for the PCI use case. Something the likes of
of_dma_configure_parent().

Regards,
Nicolas


--=-Cs3oOlvxVqdSsNFddCdM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2TdA0ACgkQlfZmHno8
x/6K4AgAjioHwGF/mb4/iuCV18ZNbc5+28Uj8QSuVjilegKoNykY14Tj+cUOZScx
3EF7lURVACHKIEG1K4mOtTqx/gzU+CkDYq3h6j7WkGGOIVY9Uadlnj/Koe7b3WuN
CtyjG0ZpwC0Houf+sUzULF/oh70hKCQnGJqaw4zM11eaV3GWVFusupxh6VuZ61Ez
PFo9kjYEn9DJFCUYzlZBYmqo7KIXm17W2fiY6AqjPvYE7s4HoA3Y1IE3uofxIY0B
0jyx5feECFqXNM6OXhaOVDV5jiDrM2aFc1/w0IYU3dcaQxjkPFlb4yI7KtzE/HBT
DJ49VyTT04oQy0DYBsw8BXur1BGXCw==
=Iift
-----END PGP SIGNATURE-----

--=-Cs3oOlvxVqdSsNFddCdM--

