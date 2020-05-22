Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A111DE2BF
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 11:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgEVJRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 05:17:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEVJRP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 05:17:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4597EB215F;
        Fri, 22 May 2020 09:17:14 +0000 (UTC)
Message-ID: <75a1dd87d18103f1e8b0afbd1e0718c74c4a77d4.camel@suse.de>
Subject: Re: [PATCH 04/15] PCI: brcmstb: Add compatibily of other chips
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 22 May 2020 11:17:08 +0200
In-Reply-To: <CA+-6iNyqtFguHJ=sB=nKoghX6PR9ve5OuyafPw88mfSmhe+c8Q@mail.gmail.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
         <20200519203419.12369-5-james.quinlan@broadcom.com>
         <5a52e39ce99214877e83104b8ea9f95c0d5b4e90.camel@suse.de>
         <CA+-6iNyqtFguHJ=sB=nKoghX6PR9ve5OuyafPw88mfSmhe+c8Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IGhRx3S6S3ntSbJkcWLj"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-IGhRx3S6S3ntSbJkcWLj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-21 at 15:35 -0400, Jim Quinlan wrote:
> On Wed, May 20, 2020 at 7:51 AM Nicolas Saenz Julienne

[...]

> > >  /*
> > > @@ -602,20 +667,21 @@ static struct pci_ops brcm_pcie_ops =3D {
> > >=20
> > >  static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pc=
ie,
> > > u32
> > > val)
> > >  {
> > > -     u32 tmp;
> > > +     u32 tmp, mask =3D  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MAS=
K];
> > > +     u32 shift =3D pcie->reg_field_info[RGR1_SW_INIT_1_INIT_SHIFT];
> >=20
> > I don't think you need shift here, IIUC u32p_replace_bits() will take c=
are
> > of
> > all the masking and shifting internally, moreover, you'd be able to dro=
p the
> > shift entry from reg_field_info.
> I believe that u32p_replace_bits requires at least one of the value or
> mask to be compile time constants to work and we don't have that here.

Of course, sorry for the noise then.

Regards,
Nicolas


--=-IGhRx3S6S3ntSbJkcWLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7HmJQACgkQlfZmHno8
x/70WAf+JoTHq0ZhGNKW8bxgqcUyLEW3dAtHwfItO+wAuflXC/o+CEKjpSFs2+j0
pG6Vatt7V46ZMMUgZb3clhJxgd2VQ/rJYIRPr8l9E7OplbhGdbmjXMD1CyD4y+j7
vyGxrliBdi63YKcBdLGwXjuzDG3kn2b35qWONfBb6j5n8N0tfQPUKNbJcw0VxVFB
0vC0MCEDYxGCWrW0jifLamw1U5OYZTN59aX7BW/9+csiXoWGLdwu8TmO1G3GAUf9
7hA1B8n9ReG8le34eQbsufe/qRrQuGwaBvjbYkMkOML2N8GL1tNDkglGA7OlAL+h
pDvQnKJkJltAZ5+bOP4gaILPBLVVzQ==
=eV6J
-----END PGP SIGNATURE-----

--=-IGhRx3S6S3ntSbJkcWLj--

