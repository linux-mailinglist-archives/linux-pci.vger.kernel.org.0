Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 392A6F8B93
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 10:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKLJSQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 04:18:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:43154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfKLJSQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 04:18:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4A7AAE65;
        Tue, 12 Nov 2019 09:18:14 +0000 (UTC)
Message-ID: <31e7037674b388919b28c6b13d4b4f71b011d9ee.camel@suse.de>
Subject: Re: [PATCH 2/4] ARM: dts: bcm2711: Enable PCIe controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        mbrugger@suse.com, f.fainelli@gmail.com, phil@raspberrypi.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 10:18:12 +0100
In-Reply-To: <20191107103705.GX9723@e119886-lin.cambridge.arm.com>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
         <20191106214527.18736-3-nsaenzjulienne@suse.de>
         <20191107103705.GX9723@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GShpbkW8CowbTJFvOKc+"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-GShpbkW8CowbTJFvOKc+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 2019-11-07 at 10:37 +0000, Andrew Murray wrote:
> > +			ranges =3D <0x02000000 0x0 0xf8000000 0x6 0x00000000
> > +				  0x0 0x04000000>;
>=20
> Is legacy I/O supported by this controller?
>=20

No, it isn't.

Regards,
Nicolas


--=-GShpbkW8CowbTJFvOKc+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3KeNQACgkQlfZmHno8
x/5iUgf+LjXdBQ4FjWn71+T/EcTk9J/bddIQmKOu98J3Tg6Gshv3uodKu0oH8FcW
Ebw2xoianZ+9h3R6JO4DRyXyzM8z5jSbUbzS9RtfIkjaTc1rp+/EUo4WOIos/va1
5PtnNBT2Ked9JKSaYAfA1RUYxTyvUqRe0gmCB6tK8LDIIrtjvHw+NJt2UxatosZf
hbdEzFV23h7dSAEtibilo0Tsu/tQG2QcrcJb2EClIwaFprttPViyFqXcLt4NdmfU
7nYY4CJtzBsx8aLVHYXKcJ3UuhodbmFo9Z4BDA881tKDlHKRq7fA0qinkDV5LYjy
vqUlWp8b1ko68z8uvqshd2KfjjLumA==
=DWxZ
-----END PGP SIGNATURE-----

--=-GShpbkW8CowbTJFvOKc+--

