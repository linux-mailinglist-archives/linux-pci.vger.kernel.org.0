Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE9C1024FC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKSM5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 07:57:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:53112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727255AbfKSM5v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 07:57:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B69FB1A0;
        Tue, 19 Nov 2019 12:57:47 +0000 (UTC)
Message-ID: <dd074ef5c23ba56598e92be19e8e25ae31b75f93.camel@suse.de>
Subject: Re: [PATCH] dma-mapping: treat dev->bus_dma_mask as a DMA limit
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Burton <paulburton@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        phil@raspberrypi.org, linux-acpi@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>, Len Brown <lenb@kernel.org>,
        devicetree@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 Nov 2019 13:57:43 +0100
In-Reply-To: <20191113161340.27228-1-nsaenzjulienne@suse.de>
References: <20191113161340.27228-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KZ1OEZ2plCMDP0ydmpq5"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-KZ1OEZ2plCMDP0ydmpq5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-13 at 17:13 +0100, Nicolas Saenz Julienne wrote:
> Using a mask to represent bus DMA constraints has a set of limitations.
> The biggest one being it can only hold a power of two (minus one). The
> DMA mapping code is already aware of this and treats dev->bus_dma_mask
> as a limit. This quirk is already used by some architectures although
> still rare.
>=20
> With the introduction of the Raspberry Pi 4 we've found a new contender
> for the use of bus DMA limits, as its PCIe bus can only address the
> lower 3GB of memory (of a total of 4GB). This is impossible to represent
> with a mask. To make things worse the device-tree code rounds non power
> of two bus DMA limits to the next power of two, which is unacceptable in
> this case.
>=20
> In the light of this, rename dev->bus_dma_mask to dev->bus_dma_limit all
> over the tree and treat it as such. Note that dev->bus_dma_limit is
> meant to contain the higher accesible DMA address.
>=20
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20

Hi Rob & Christoph,
do you mind if I append v2 of this into my upcoming v3 RPi4 PCIe support
series, I didn't do it initially as I thought this was going to be a
contentious patch.  But as it turned out better than expected, I think it
should go into the PCIe series. In the end it's the first explicit user of =
the
bus DMA limit.

Here's v2 in case you don't know what I'm talking about:
https://www.spinics.net/lists/arm-kernel/msg768459.html

Regards,
Nicolas


--=-KZ1OEZ2plCMDP0ydmpq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3T5scACgkQlfZmHno8
x/7FNgf/TPvrVamDNHipGFKFiSr22YaNYJU4aGZyFuJab0Z9dF35ZbNQqx3sXA83
gyltGXByQ4c747nqq+LWQTaXLvI4NEMDu/ueQ6T4Vgs0ijtKvI9hVjrjlKU7UVsR
/v+6HHolAP4q5zxgJbL3PRMlFeJlLs9xRbikBEmGDbc4INP8nBSUiQmk4lrgCAwH
xV11EcSTA5eKJPS1jpsEP/vKwfu7LQ9ASExtpK5Oud7ZBD8zq1qKQBSVMGXQ1m9L
l0ok+gqBZtMgwKtigs9mAr0Y09evU1GOVS0ttcncZ854J6/+hr9nuK8eXyhLEm0J
l/jpo2vtZH0gMy68b+P8LkDtGJisYg==
=9wOf
-----END PGP SIGNATURE-----

--=-KZ1OEZ2plCMDP0ydmpq5--

