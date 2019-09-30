Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3BBC2207
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfI3Nc7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 09:32:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729738AbfI3Nc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 09:32:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20575ADD5;
        Mon, 30 Sep 2019 13:32:57 +0000 (UTC)
Message-ID: <95f8dabea99f104336491281b88c04b58d462258.camel@suse.de>
Subject: Re: [PATCH 05/11] of: Ratify of_dma_configure() interface
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Mon, 30 Sep 2019 15:32:55 +0200
In-Reply-To: <20190930125752.GD12051@infradead.org>
References: <20190927002455.13169-1-robh@kernel.org>
         <20190927002455.13169-6-robh@kernel.org>
         <20190930125752.GD12051@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-J2uUUCx3PD1vZZDm+yYn"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-J2uUUCx3PD1vZZDm+yYn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-30 at 05:57 -0700, Christoph Hellwig wrote:
> On Thu, Sep 26, 2019 at 07:24:49PM -0500, Rob Herring wrote:
> > -int of_dma_configure(struct device *dev, struct device_node *np, bool
> > force_dma)
> > +int of_dma_configure(struct device *dev, struct device_node *parent, b=
ool
> > force_dma)
>=20
> This creates a > 80 char line.
>=20
> >  {
> >  	u64 dma_addr, paddr, size =3D 0;
> >  	int ret;
> >  	bool coherent;
> >  	unsigned long offset;
> >  	const struct iommu_ops *iommu;
> > +	struct device_node *np;
> >  	u64 mask;
> > =20
> > +	np =3D dev->of_node;
> > +	if (!np)
> > +		np =3D parent;
> > +	if (!np)
> > +		return -ENODEV;
>=20
> I have to say I find the older calling convention simpler to understand.
> If we want to enforce the invariant I'd rather do that explicitly:
>=20
> 	if (dev->of_node && np !=3D dev->of_node)
> 		return -EINVAL;

As is, this would break Freescale Layerscape fsl-mc bus' dma_configure():

static int fsl_mc_dma_configure(struct device *dev)
{
	struct device *dma_dev =3D dev;

	while (dev_is_fsl_mc(dma_dev))
		dma_dev =3D dma_dev->parent;

	return of_dma_configure(dev, dma_dev->of_node, 0);
}

But I think that with this series, given the fact that we now treat the lac=
k of
dma-ranges as a 1:1 mapping instead of an error, we could rewrite the funct=
ion
like this:

static int fsl_mc_dma_configure(struct device *dev)
{
	return of_dma_configure(dev, false, 0);
}

If needed I can test this.

Regards,
Nicolas


--=-J2uUUCx3PD1vZZDm+yYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2SBAcACgkQlfZmHno8
x/4Nzwf+LG0gvylrOQLw5x/IHv2Kgv6fhZ0lnwVON/shyUQa9M2SJ6AmcGSBXL/D
poq3K8WHsQdr5e2yEyy2/lT92p6qSNbdIDjOeDyq3YskHZP6SBm/nC2l/dtDU9z6
fv3/gGTWP7ckQI4v4690kUZ4Txb3ndCWgrf7GXn7JKT7uDaqmIsiefi0S+YU8Y2L
mr1dudpZ3wAnCI0uA6Za8Db6QQ2lCtGHvchLzv0dC8n4qlMMipuWGFD8y/R6BGw7
90iinlHnoJrL07DjWy4nVFPqvXnFUADXr5eXAijh+ZQ7kCFOKHwYvEB7Zrh0mEw8
bdGzfMEbXgkzUdAaLb8mb48VqHBsOg==
=Byb8
-----END PGP SIGNATURE-----

--=-J2uUUCx3PD1vZZDm+yYn--

