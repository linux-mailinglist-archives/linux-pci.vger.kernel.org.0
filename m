Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D610A437
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 19:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKZSwM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 13:52:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:45252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbfKZSwL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Nov 2019 13:52:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38C30ABD6;
        Tue, 26 Nov 2019 18:52:08 +0000 (UTC)
Message-ID: <45feed391bbd95c46f64b31cf8817d4f773c8da1.camel@suse.de>
Subject: Re: [PATCH v2] dma-mapping: treat dev->bus_dma_mask as a DMA limit
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 26 Nov 2019 19:51:59 +0100
In-Reply-To: <0b851d0e-37c7-062e-c287-05f8c8a54c16@arm.com>
References: <20191121092646.8449-1-nsaenzjulienne@suse.de>
         <20191123165108.GA15306@ubuntu-x2-xlarge-x86>
         <20191125074412.GA30595@lst.de>
         <0b851d0e-37c7-062e-c287-05f8c8a54c16@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-B9dp7hYRMOcivm0VMcWv"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-B9dp7hYRMOcivm0VMcWv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-25 at 16:33 +0000, Robin Murphy wrote:
> On 25/11/2019 7:44 am, Christoph Hellwig wrote:
> > On Sat, Nov 23, 2019 at 09:51:08AM -0700, Nathan Chancellor wrote:
> > > Just as an FYI, this introduces a warning on arm32 allyesconfig for m=
e:
> >=20
> > I think the dma_limit argument to iommu_dma_alloc_iova should be a u64
> > and/or we need to use min_t and open code the zero exception.
> >=20
> > Robin, Nicolas - any opinions?
>=20
> Yeah, given that it's always held a mask I'm not entirely sure why it=20
> was ever a dma_addr_t rather than a u64. Unless anyone else is desperate=
=20
> to do it I'll get a cleanup patch ready for rc1.

Sounds good to me too

Robin, since I started the mess, I'll be happy to do it if it helps offload=
ing
some work from you.

Regards,
Nicolas


--=-B9dp7hYRMOcivm0VMcWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3ddE8ACgkQlfZmHno8
x/5fVwgAnN7cpWXNHEbGgqyZcMqmBWCtR0bMa/xIu1xNgr/CAwMMZj0Z3/+6d18p
mlU5N6AqlkTxefP9mV5ZxBzugcsriGR4+qJ05kZZAMxAeG625qDkfhSEl0FmUZRT
WmEv98IN0aFzHEjZJAyPDNV8Ff1a3JpoHKQmnYs5z438rMZt49CPBC0jNPFdaEuj
v9ry1DkR+cGYuD1WRyBQJjtze14XoG7ZCu0o9Htc02GZHq3OuabxDikuTC+UJ1jR
BZX4ak4qGpJUGYT8fQA7IOA94Sd/N/CHMrDp8yv5f/kRcprKqgGX8PnMCUOPf4ns
PsCZZGhEKvVwZy3/+QzWSYQ7q20O8w==
=WYKI
-----END PGP SIGNATURE-----

--=-B9dp7hYRMOcivm0VMcWv--

