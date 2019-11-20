Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6641044F7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 21:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfKTUYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 15:24:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:47262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfKTUYu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 15:24:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0DC4B206;
        Wed, 20 Nov 2019 20:24:48 +0000 (UTC)
Message-ID: <681665dee34a47f26f7832d2c3e0e68a85b69e3f.camel@suse.de>
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        mbrugger@suse.com, phil@raspberrypi.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 20 Nov 2019 21:24:47 +0100
In-Reply-To: <f2202c4d-c2b4-c06a-8864-432380d0181f@arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
         <20191112155926.16476-5-nsaenzjulienne@suse.de>
         <20191119162502.GS43905@e119886-lin.cambridge.arm.com>
         <f2202c4d-c2b4-c06a-8864-432380d0181f@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OoRtF6MuxmmZ/WkBbsKp"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-OoRtF6MuxmmZ/WkBbsKp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Tue, 2019-11-19 at 12:20 -0600, Jeremy Linton wrote:
> Hi,
>=20
> On 11/19/19 10:25 AM, Andrew Murray wrote:
> > On Tue, Nov 12, 2019 at 04:59:23PM +0100, Nicolas Saenz Julienne wrote:
> > > From: Jim Quinlan <james.quinlan@broadcom.com>
> > >=20
> > > This commit adds the basic Broadcom STB PCIe controller.  Missing is =
the
> > > ability to process MSI. This functionality is added in a subsequent
> > > commit.
> > >=20
> > > The PCIe block contains an MDIO interface.  This is a local interface
> > > only accessible by the PCIe controller.  It cannot be used or shared
> > > by any other HW.  As such, the small amount of code for this
> > > controller is included in this driver as there is little upside to pu=
t
> > > it elsewhere.
> >=20
> > This commit message hasn't changed, despite earlier feedback.
> >=20
>=20
> Also, unless i'm mistaken this controller isn't I/O coherent on the rpi.

I'm not sure I get what you mean by I/O coherent.

Regards,
Nicolas


--=-OoRtF6MuxmmZ/WkBbsKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3VoQ8ACgkQlfZmHno8
x/7CIQf+N1s97C0orm13r3hHzluqTXyvjXEFM7l6iozSh3owLfyySyUqoQMk4GuU
c9lMxac+7u+lhG6r4TuAQnolTAgLA1Ufzjk1ZpZZ5lBI+meoPyouMUxMh85wxALx
JObhQOg/NLBFb/pLdfZeWrUgSxicDkJlkU9Wm63FItku5yaQjW0jfCNmAm6WpTXK
91SvkHzg10I5r4jHMyQw7Rqcet+KuMn8vyCgxLX9VkputmAPdl1yzLoXjvdZBPpO
8PHcZNiomyFwTEz1AFjKxDbuNzlWkAC/zSMGZl/skIC4FJPpNx3SqVC1UDAonI7+
0i4lMZKzCutFxwH1yIXE93bHPpQnAw==
=Z4RA
-----END PGP SIGNATURE-----

--=-OoRtF6MuxmmZ/WkBbsKp--

