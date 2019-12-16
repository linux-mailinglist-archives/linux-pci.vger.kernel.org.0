Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A039120397
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLPLS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 06:18:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbfLPLS1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 06:18:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C713AD4F;
        Mon, 16 Dec 2019 11:18:25 +0000 (UTC)
Message-ID: <e94310c04571b23e57d802aecb4789d7c6d35d74.camel@suse.de>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for brcmstb's
 PCIe device
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Matthias Brugger <mbrugger@suse.com>, andrew.murray@arm.com,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        phil@raspberrypi.org, jeremy.linton@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, james.quinlan@broadcom.com,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Mon, 16 Dec 2019 12:18:23 +0100
In-Reply-To: <39a8ab96-2b32-1d9c-63cd-8114a58f723c@suse.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
         <20191216110113.30436-2-nsaenzjulienne@suse.de>
         <39a8ab96-2b32-1d9c-63cd-8114a58f723c@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4ZM5h4FNm971ZXqZ/T37"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-4ZM5h4FNm971ZXqZ/T37
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-16 at 12:14 +0100, Matthias Brugger wrote:
> > +
> > +  msi-controller:
> > +    description: Identifies the node as an MSI controller.
>=20
> are you missing "type: boolean" here?

As per RobH's suggestion[1] I assumed the type on msi-controller and msi-pa=
rent
is alredy defined.

Regards,
Nicolas

[1] https://patchwork.kernel.org/patch/11239717/#23008585


--=-4ZM5h4FNm971ZXqZ/T37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl33Z/8ACgkQlfZmHno8
x/7P7gf+NuNPpIsO6gLiH8DJTHrzG+A4soBpSgB0r3XzWZfc0Rem+xaaojNEVDTT
po1m4X5pXKLejfpfB7srdeIweCg2xg3Pm61W6750iDhgKOtF7CNj91zkYkkSMIvs
0lvWgo25TX1z3O/Z+dfRrPSMKMR1Rhos4KLxFALXiSakdoPsaoetmz7pkAdgXwqr
0jKv3rerg41Q0yJi/zQSJcbvFCGd05ghq2Z+SdUtnqu5Iw/VEmorK6bo22W911w9
3Kr9RHGM6dtTTMqS3rZWk3zfx1HuwhXjU93ObTavjtYqSL0UrCt9RCLoMgDA95hM
f44IH0GrZdZuUqHOO0YN77qenyPzlg==
=xgVD
-----END PGP SIGNATURE-----

--=-4ZM5h4FNm971ZXqZ/T37--

