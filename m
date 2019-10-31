Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC21EADAD
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 11:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfJaKnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 06:43:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:56310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfJaKnp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 06:43:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0DD1B337;
        Thu, 31 Oct 2019 10:43:43 +0000 (UTC)
Message-ID: <51101de0f3b0fc5a3678c1ee0c723b131471f1b6.camel@suse.de>
Subject: Re: [PATCH v2 2/2] x86/PCI: sta2x11: use default DMA address
 translation
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@infradead.org>, rubini <rubini@gnudd.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, helgaas@kernel.org,
        linux-pci@vger.kernel.org
Date:   Thu, 31 Oct 2019 11:43:40 +0100
In-Reply-To: <20191030214548.GC25515@infradead.org>
References: <20191018110044.22062-1-nsaenzjulienne@suse.de>
         <20191018110044.22062-3-nsaenzjulienne@suse.de>
         <20191030214548.GC25515@infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bbEBxDInIIIWgIikHBah"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-bbEBxDInIIIWgIikHBah
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-30 at 14:45 -0700, Christoph Hellwig wrote:
> On Fri, Oct 18, 2019 at 01:00:44PM +0200, Nicolas Saenz Julienne wrote:
> > The devices found behind this PCIe chip have unusual DMA mapping
> > constraints as there is an AMBA interconnect placed in between them and
> > the different PCI endpoints. The offset between physical memory
> > addresses and AMBA's view is provided by reading a PCI config register,
> > which is saved and used whenever DMA mapping is needed.
> >=20
> > It turns out that this DMA setup can be represented by properly setting
> > 'dma_pfn_offset', 'dma_bus_mask' and 'dma_mask' during the PCI device
> > enable fixup. And ultimately allows us to get rid of this device's
> > custom DMA functions.
> >=20
> > Aside from the code deletion and DMA setup, sta2x11_pdev_to_mapping() i=
s
> > moved to avoid warnings whenever CONFIG_PM is not enabled.
>=20
> Looks sensible to me:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>=20
> But I can't tested it either, and kinda wonder if this code is actually
> still used by anyone..

Maybe Alessandro can shine some light on this (though I wonder his mail is =
stil
valid).


--=-bbEBxDInIIIWgIikHBah
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl26utwACgkQlfZmHno8
x/5LdQf+NbC/ulCg/psnqPVhawPBGEveu8OIRa8NXE28iGjBsmKrzd7vEIVEypbC
Sw8rUc2flbEyE88NX6sNKmDqFn8ydOU7IxtM4CFJV/XS3UjSLccTVJDyvB1afF67
roBReMJNAqGkE/sV3n0gGMUuvK7Vv1Z3uLRvsNM8refMHm2+62ochGBWPiB0Th3v
X7djIjJ9qsnvjKeIadD6OIUqooHSnpgWlRBOxTYmc5B8fJdl8Hv7iKwMdkp2Ffdr
VRinylQj0Gzj+UWyQmlaxeSUNw/35uKRsyNnOQbLO2C270IUEPmnsyS46DtTxz0F
vcxXHYj8h41TqtqdM78XSj6A31RcYQ==
=wltj
-----END PGP SIGNATURE-----

--=-bbEBxDInIIIWgIikHBah--

