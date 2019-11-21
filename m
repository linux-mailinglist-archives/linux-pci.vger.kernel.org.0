Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD511105573
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 16:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKUP0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 10:26:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:55978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfKUP0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 10:26:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92733B12D;
        Thu, 21 Nov 2019 15:26:05 +0000 (UTC)
Message-ID: <7dce4b4ae17e67a4cd093c7e3e709c9f1bb694f9.camel@suse.de>
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        linuxppc-dev@lists.ozlabs.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Thu, 21 Nov 2019 16:26:00 +0100
In-Reply-To: <20191121152457.GA525@lst.de>
References: <20191121092646.8449-1-nsaenzjulienne@suse.de>
         <20191121152457.GA525@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AVtHArOyK73WmsFla+MI"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-AVtHArOyK73WmsFla+MI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-21 at 16:24 +0100, Christoph Hellwig wrote:
> On Thu, Nov 21, 2019 at 10:26:44AM +0100, Nicolas Saenz Julienne wrote:
> > Using a mask to represent bus DMA constraints has a set of limitations.
> > The biggest one being it can only hold a power of two (minus one). The
> > DMA mapping code is already aware of this and treats dev->bus_dma_mask
> > as a limit. This quirk is already used by some architectures although
> > still rare.
> >=20
> > With the introduction of the Raspberry Pi 4 we've found a new contender
> > for the use of bus DMA limits, as its PCIe bus can only address the
> > lower 3GB of memory (of a total of 4GB). This is impossible to represen=
t
> > with a mask. To make things worse the device-tree code rounds non power
> > of two bus DMA limits to the next power of two, which is unacceptable i=
n
> > this case.
> >=20
> > In the light of this, rename dev->bus_dma_mask to dev->bus_dma_limit al=
l
> > over the tree and treat it as such. Note that dev->bus_dma_limit should
> > contain the higher accesible DMA address.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> I've tentatively added this patch to the dma-mapping tree based on
> Robins principal approval of the last version.  That way tomorrows
> linux-next run should still pick it up.

Thanks!


--=-AVtHArOyK73WmsFla+MI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3WrIgACgkQlfZmHno8
x/4/VAf/dsxMKNREPohHeI7vgp+6EimdhbVCl85q5A/tDQBGfxT0jH8qWWHH8vIe
jOcJJvY2x/QgJp2yJjQDvqH8jmakrl/jXYcLKMs2m5/4ZBEZn+ZE1aHndjaHsVYV
hIwCCJHOYYakbn6bZqyqRuFZsmEoGaP2ep/8+pRnI9Rqsm9iAJfJGL9GFCIq8GMp
9EYLurmczPVdlj6upREqPVBlmwjZ+5mJlJ2mLBdHuECEok0EqNyAQx27xprA3s4Q
zwGXR3RGjsgDBpLkmpp3p85VWai+dh/9ETFqr1IV9xQwKtUfXN3ioKBBKeWzlAZd
MiNU31P6cP68zLbbRggeBCaoZBoq6w==
=j1XI
-----END PGP SIGNATURE-----

--=-AVtHArOyK73WmsFla+MI--

