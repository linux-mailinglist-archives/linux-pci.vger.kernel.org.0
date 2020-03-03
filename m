Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4EC177501
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgCCLI3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 06:08:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:45256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727880AbgCCLI3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 06:08:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94B6DB235;
        Tue,  3 Mar 2020 11:08:27 +0000 (UTC)
Message-ID: <312c3305eef7534d534729d598372dbf5f3985cf.camel@suse.de>
Subject: Re: [PATCH v3 0/4] Raspberry Pi 4 VL805 firmware load support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Date:   Tue, 03 Mar 2020 12:08:25 +0100
In-Reply-To: <1583225019.12738.6.camel@suse.com>
References: <20200302155528.19505-1-nsaenzjulienne@suse.de>
         <1583225019.12738.6.camel@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sEW+kSSPV6dhPiAM6dbu"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-sEW+kSSPV6dhPiAM6dbu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On Tue, 2020-03-03 at 09:43 +0100, Oliver Neukum wrote:
> Am Montag, den 02.03.2020, 16:55 +0100 schrieb Nicolas Saenz Julienne:
> > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either b=
e
> > loaded directly from an EEPROM or, if not present, by the SoC's
> > VideCore. This series adds support for the later.
>=20
> What happens if runtime PM strikes, in particular, how do
> you deal with D4cold?

The RPi4 PCIe driver doesn't support runtime PM for now. Neither upstream n=
or
downstream. So I'd say it's not a problem. The same goes for suspend/resume=
,
which IIRC the Raspberry Pi foundation doesn't support.

Regards,
Nicolas


--=-sEW+kSSPV6dhPiAM6dbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5eOqkACgkQlfZmHno8
x/730ggAtedF+4sYfc1p/xdd/IO7Clu3ry4x2yh+qY/per8vXN+9dzI79YgdwAtg
SlRDlijesH4//PYu7gdwIqaF86WMYuPCRT8Q8mWlcL+Lrgz1GGkmFSuFDnGH0nep
M0L9F0BXK+efUQhKuTtdtRP2UJXg00bKI4hVHLtEHNGrOZYJoVKmxjDlw2n20KSO
zjq6rt6HvCCUH1saZC4r6++T3EhCG1QjUAoyycsAJKNH86xc+P5VV9+cQfH1zJpI
Rim6oxWfTT69JUb9DY5NkA0xWWFpV/4YyTW9gQiXgQgIBrsCcYLlu+B/xhZwifKm
ITeQhFnX2203t32AD+fEBIJUmxNaJg==
=XmXV
-----END PGP SIGNATURE-----

--=-sEW+kSSPV6dhPiAM6dbu--

