Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4812044D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 12:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLPLpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 06:45:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727425AbfLPLpa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 06:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9077BAD54;
        Mon, 16 Dec 2019 11:45:28 +0000 (UTC)
Message-ID: <cc827c6d4ea0d760b7df217a98bdee6b0c684137.camel@suse.de>
Subject: Re: [PATCH v5 0/6] Raspberry Pi 4 PCIe support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        james.quinlan@broadcom.com, mbrugger@suse.com,
        f.fainelli@gmail.com, phil@raspberrypi.org, wahrenst@gmx.net,
        jeremy.linton@arm.com, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Date:   Mon, 16 Dec 2019 12:45:26 +0100
In-Reply-To: <20191216113646.GT24359@e119886-lin.cambridge.arm.com>
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
         <20191216113646.GT24359@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DLw2p4RvYw24q5zmQ4Z4"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-DLw2p4RvYw24q5zmQ4Z4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-16 at 11:36 +0000, Andrew Murray wrote:
> On Mon, Dec 16, 2019 at 12:01:06PM +0100, Nicolas Saenz Julienne wrote:
> > This series aims at providing support for Raspberry Pi 4's PCIe
> > controller, which is also shared with the Broadcom STB family of
> > devices.
> >=20
> > There was a previous attempt to upstream this some years ago[1] but was
> > blocked as most STB PCIe integrations have a sparse DMA mapping[2] whic=
h
> > is something currently not supported by the kernel.  Luckily this is no=
t
> > the case for the Raspberry Pi 4.
> >=20
>=20
> Hi Nicolas,
>=20
> This series looks good to me now. Unless there is further feedback I'll a=
sk
> Lorenzo to merge this when he returns in the new year.

Thanks!

> Thanks for the log2.h efforts - perhaps this can be picked up again one d=
ay.

I'm not giving up on it yet :)

Regards,
Nicolas


--=-DLw2p4RvYw24q5zmQ4Z4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl33blYACgkQlfZmHno8
x/5aYwf+N1/Ua9CzF4VJc5Fs8Q99JDhaoGWxqIBldY6pt0TGhmCO6ao6z9UCUGde
3n5X7AZwwbVuSQlBbnGxCP4Ji+4O8O/tsc/PmcFN4dt0FALtUD1lbEwFq6khdQqN
DaeJqlyjvkQkZifOGYjNH2UjzI4dCyxtFDOMSNr8YP3RcSdjwV01zghOdSSjaV05
X5jUsfAf5AB8eabnkNt+C7FORGf7T8Ll3LdhCgtNJOf3GyIwkotQ2TlqckA8xhqS
hPRTW9DaXn6IWYAX3kCwrFhoX4/qxddXhz6GOw5HA5Lh25Zq8Zq4KG3xOlsI9HRy
j0AIKO9Pmg+mDDa936sR1oijKJZm3w==
=Axoa
-----END PGP SIGNATURE-----

--=-DLw2p4RvYw24q5zmQ4Z4--

