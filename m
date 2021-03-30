Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419BE34EC78
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhC3PbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 11:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232432AbhC3Pag (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Mar 2021 11:30:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 847AD619A7;
        Tue, 30 Mar 2021 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617118235;
        bh=v1dbBvYnlnpeTi3yQZ8GGvJpMY8lThR6ab6uDmszjNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ty9EUPL3HTj8+YrfsfYyzLPCIKZuI8lC98RSM576+OaLbAQtCG9IyX+JMnsZbZjb2
         b3iF6sKWOqywqKAtqXDBC2EVlssXjBIIiNxcHGSfgQFHDa0gCoXj/lGn/sFaYlWSdO
         4Rc3grw7579SkDENhbiqf2Uy81ekouIzL4RiDjovcXuZei+fwFZtHywx//4XaCsPR7
         FHgP2mVFsuX3CKmO0F0GDV7WUPdsYwOlfkzBA2enlSvLzscXw1SkHAUJ568xfgFaqM
         MDCpT9XQQC77ZEQ9CcRJGiMpQz0QZ60WTKOmT90LWEH2lkF30ayIPoftEE6OLuwl7Z
         /+xEaYmRTLUyg==
Date:   Tue, 30 Mar 2021 16:30:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20210330153023.GE4976@sirena.org.uk>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-2-jim2101024@gmail.com>
 <20210330150816.GA306420@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <20210330150816.GA306420@robh.at.kernel.org>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 30, 2021 at 10:08:16AM -0500, Rob Herring wrote:
> On Fri, Mar 26, 2021 at 03:18:59PM -0400, Jim Quinlan wrote:

> > +                    pcie-ep@0,0 {
> > +                            reg =3D <0x0 0x0 0x0 0x0 0x0>;
> > +                            compatible =3D "pci14e4,1688";
> > +                            vpcie12v-supply: <&vreg12>;

> For other cases, these properties are in the host bridge node. If these=
=20
> are standard PCI rails, then I think that's where they belong unless we=
=20
> define slot nodes.

For a soldered down part I'd expect we'd want both (if the host even
cares) - for anything except a supply that I/O or something else shared
is referenced off there's no great reason why it has to be physically
the same supply going to every device on the bus so each device should
be able to specify separately.

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjRA8ACgkQJNaLcl1U
h9ANmwf7BttjRKh+uxAdgHhy0rI2LYRxFUkT8SfE/LGAEH8CvkYc4HHNnh0Ej99C
FwJ0PuvncXiHwDAJnbhiiOTNvb7b8yaQFR/IBYXJ1QWXj2LGaLZAmRKVKxtwRJmq
R5YMCL0owt8qits6jfUtrJgzwxRjmG7Rh1ailPmE30WMvd8zchuSaDWAdT6BaNdt
jeWaonyazB0MM1TzVtR9Aiov/vMfdBLT692mVzO4QCtCmoUwDU0PInMh5lKcihYQ
65HCHT/xknVn7Rph+qacZKLozK+skalElePvTK79cYb9+8LhwnOZ8FsIQ98ACQNI
zvtnhgexwvQ8tldRw8qp8iB3eDzlCg==
=hPcY
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
