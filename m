Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF919E736
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 20:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDS5A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Apr 2020 14:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:57942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDS5A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Apr 2020 14:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F0F4AC1D;
        Sat,  4 Apr 2020 18:56:58 +0000 (UTC)
Message-ID: <c481353b58fb31a07cb4e46e958524d6a76f6bba.camel@suse.de>
Subject: Re: [PATCH v6 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com
Date:   Sat, 04 Apr 2020 20:56:54 +0200
In-Reply-To: <20200402194005.GA35725@google.com>
References: <20200402194005.GA35725@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-p9pbaJPFripypjQjuxEN"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-p9pbaJPFripypjQjuxEN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-02 at 14:40 -0500, Bjorn Helgaas wrote:
> On Thu, Apr 02, 2020 at 01:32:35PM +0200, Nicolas Saenz Julienne wrote:
> > On Wed, 2020-04-01 at 15:37 -0500, Bjorn Helgaas wrote:
> > > On Tue, Mar 24, 2020 at 07:28:10PM +0100, Nicolas Saenz Julienne wrot=
e:
> > > > On the Raspberry Pi 4, after a PCI reset, VL805's firmware may
> > > > either be loaded directly from an EEPROM or, if not present, by
> > > > the SoC's VideCore. The function informs VideCore that VL805 was
> > > > just reset, or requests for a probe defer.
>=20
> Is VL805 the XHCI USB device?  A hint here would help non-RPi experts
> know how this fits into the topology.

Yes, VL805 is the XHCI USB device. I'll keep it in mind for the next series=
.

Regards,
Nicolas


--=-p9pbaJPFripypjQjuxEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6I2HYACgkQlfZmHno8
x/60Swf/dHo4U3CvX6bsiKxokbAwApPj1NiCCdvWHdfOj3JGJFeJiSE8WFwbv9zv
+jDO9Z90fC0euf2TVeg5msEHjcBzlfjNQezZX38k9XNLGVElcRDDDOI6Lu8n7s86
Cn8ftjDDiD7Ykx0XUgBfgYC1g2hKRofw9C0ry2qPzYMZ9REpnC8ea9Vybng77DGF
WA6nzjrS7yVqzzyzzmg8d2FEU0AonJQS5QFVyA0f0ged7QSyykWoAgM8SmL1nIYc
VSw0Ve90xvAifAy1IUUh8TLqKAKa3kLU1ibktQqOtIapI6GXXiNtTLXjLIVdhZxm
5YGazz8bz28YbzNjd8x2rKUDyRd7pw==
=vU+J
-----END PGP SIGNATURE-----

--=-p9pbaJPFripypjQjuxEN--

