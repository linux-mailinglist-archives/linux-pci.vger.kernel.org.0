Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637E7203A4F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgFVPIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 11:08:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:59656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgFVPIM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 11:08:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 146E1C1BE;
        Mon, 22 Jun 2020 15:08:11 +0000 (UTC)
Message-ID: <4aaabc8ff39007a97a03f335c6a51313a2c59551.camel@suse.de>
Subject: Re: [PATCH v4 2/9] reset: Add Raspberry Pi 4 firmware reset
 controller
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        tim.gover@raspberrypi.org, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Mon, 22 Jun 2020 17:08:09 +0200
In-Reply-To: <CAHp75VcGoK=6FitfuzEhPZXSrtJiO_-XcD6jtg8SckprWhePgA@mail.gmail.com>
References: <20200622103817.476-1-nsaenzjulienne@suse.de>
         <20200622103817.476-3-nsaenzjulienne@suse.de>
         <CAHp75VcGoK=6FitfuzEhPZXSrtJiO_-XcD6jtg8SckprWhePgA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5dZZMAqUDgFzVYMirjlA"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-5dZZMAqUDgFzVYMirjlA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, 2020-06-22 at 17:42 +0300, Andy Shevchenko wrote:
> On Mon, Jun 22, 2020 at 5:26 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> > Raspberry Pi 4's co-processor controls some of the board's HW
> > initialization process, but it's up to Linux to trigger it when
> > relevant. Introduce a reset controller capable of interfacing with
> > RPi4's co-processor that models these firmware initialization routines =
as
> > reset lines.
>=20
> ...
>=20
> > +       struct device_node *fw_node;
>=20
> If you are going to use fwnode (as it should be), make sure the proper
> data type is in use, i.e. struct fwnode_handle.
>=20
> Otherwise, if you want to be OF centric (I discourage this, don't know
> if RPi4 is ever going to run RHEL or other distros that require non-DT
> firmwares), don't name fw_node. It's confusing.

I agree it is confusing. I'll rename it. On the other hand, this is strictl=
y DT
centric.

Regards,
Nicolas


--=-5dZZMAqUDgFzVYMirjlA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7wyVkACgkQlfZmHno8
x/7LrQgAqK9GE4KkBwZKTkd+hAygOJW7bI8wF1Pfgtu3Ar9DcW+9lpBhWOOp4T26
iSGn/L+0FM4yGtAaNOncUmNHfPN/wWSom9zNhRuK9hruXGcZcWdToQmzJegvZ2DM
PctEXsfMjfiwWpHIOuGf9GEEuCUiYIcMM5DPyV1+ZfytHrvYhqjdSIm7VLPocM4h
D37+XnrQcoF7DxgzFUmsnrP6qz00QlbfHUP5JMPa2DgWu6dLl89wIRUhyLRPGyqE
yHt8rmlZ8qOXrqAw5DjDoKAoRB2/jJARPdp5KgJMWB1x3C6NRbGiQoeDDTxMabcG
TXTpud6NEEOFvZeb0+HA0mLJQqNkZw==
=AKY0
-----END PGP SIGNATURE-----

--=-5dZZMAqUDgFzVYMirjlA--

