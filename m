Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F11DC042
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 10:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbfJRIwF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 04:52:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:37206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390341AbfJRIwF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 04:52:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE43CB58A;
        Fri, 18 Oct 2019 08:52:02 +0000 (UTC)
Message-ID: <c0fe3d2189130449a2de64b5a0ed4b3325a7602e.camel@suse.de>
Subject: Re: [PATCH] x86/PCI: sta2x11: use default DMA address translation
 ops
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     rubini@gnudd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Fri, 18 Oct 2019 10:51:58 +0200
In-Reply-To: <20191017224120.GA68948@google.com>
References: <20191017224120.GA68948@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-D/Da0HTt+jTkSHPetqZA"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-D/Da0HTt+jTkSHPetqZA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,
thanks for having a look at it.

On Thu, 2019-10-17 at 17:41 -0500, Bjorn Helgaas wrote:
> Hi Nicolas,
>=20
> I'm hoping Christoph will chime in and one of the x86 guys will merge
> this, since I'm not a DMA expert.  Trivial comments/questions below.
>=20
> On Wed, Oct 16, 2019 at 06:51:37PM +0200, Nicolas Saenz Julienne wrote:
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
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > -	pci_read_config_dword(pdev, AHB_BASE(0), &map->amba_base);
> > +
> > +	pci_read_config_dword(pdev, AHB_BASE(0), &amba_base);
> > +	dev->dma_pfn_offset =3D PFN_DOWN(-amba_base);
> > +	dev->bus_dma_mask =3D amba_base + STA2X11_AMBA_SIZE - 1;
>=20
> I think of a mask as typically being one less than a power of two, but
> that's not the case here, e.g., STA2X11_AMBA_SIZE - 1 =3D=3D 0x1fffffff
> (512MB-1), so if amba_size is 1G, the mask will be 0x5fffffff.
>=20
> Just double-checking to be sure that's what you intend.

Yes I'm aware of it.

I know it's counter-intuitive name wise but dma-direct uses it more like a =
top
address than a mask (see for example 'dma_capable()' in dma-direct.h). Ther=
e is
at least another driver using 'dev->bus_dma_mask' as such (see
arch/powerpc/sysdev/fsl_pci.c).

That said, I agree it something Christoph should ratify for this to get mer=
ged.

> > +	pci_set_consistent_dma_mask(pdev, amba_base + STA2X11_AMBA_SIZE - 1);
> > +	pci_set_dma_mask(pdev, amba_base + STA2X11_AMBA_SIZE - 1);
>=20
> Maybe add a local variable instead of repeating the "amba_base + ..."
> expression three times?

Noted.

> >  	/* Configure AHB mapping */
> >  	pci_write_config_dword(pdev, AHB_PEXLBASE(0), 0);
> > @@ -252,14 +156,25 @@ static void sta2x11_map_ep(struct pci_dev *pdev)
> >  		pci_write_config_dword(pdev, AHB_CRW(i), 0);
> > =20
> >  	dev_info(&pdev->dev,
> > -		 "sta2x11: Map EP %i: AMBA address %#8x-%#8x\n",
> > -		 sta2x11_pdev_to_ep(pdev),  map->amba_base,
> > -		 map->amba_base + STA2X11_AMBA_SIZE - 1);
> > +		 "sta2x11: Map EP %i: AMBA address %#8x-%#8llx\n",
> > +		 sta2x11_pdev_to_ep(pdev), amba_base, dev->bus_dma_mask);
>=20
> This would read better as
>=20
>   amba_base, amba_base + STA2X11_AMBA_SIZE - 1
>=20
> I know that's the same dev->bus_dma_mask, but a "mask" is not the
> obvious name for the end of a range.

Ok.

I just got a notification from my mail server that it failed to deliver the
mail to Christoph, it seems I misspelled it.

I'll fix all this and send a v2.

Regards,
Nicolas


--=-D/Da0HTt+jTkSHPetqZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl2pfS8ACgkQlfZmHno8
x/4BlggAjXVad2D9BpeA/AXkKKdJTH3wSyCFD3j0jU4OWOxaxDTJo1RUC/cs+lZI
mTpxt6/DvoMX/c771nFhDITH1Pld8C9gQxZ9gi6rs0JfhdiX94tql1pCbAxs1OXL
4nMhsotG6DR0nodVoT3xU5A86NfQoR3MqrNeIG849yskFjpSDvjoQdf1uVM2qc5l
9wWuniwT1NQ0FaddVpPJdxPI+pe4J0VFVnJpTYw5T2OKk84dEVKdRyIby+ydVUwQ
quaTw3ko1X1cAH1fXyaUpaC4zzB7MBZ9AqQJFQbjHlM3JjGmRfoZnKBBAftm2+JX
WJ5EhUljkQ6UFy9hDrcY8IqS4Oe1dg==
=vTJy
-----END PGP SIGNATURE-----

--=-D/Da0HTt+jTkSHPetqZA--

