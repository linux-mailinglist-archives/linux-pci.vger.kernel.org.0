Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647EB17DE07
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 11:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCIK4E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 06:56:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgCIK4E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 06:56:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5CB0EAD8E;
        Mon,  9 Mar 2020 10:56:02 +0000 (UTC)
Message-ID: <1b8dac648f554095755379b505ea28a440d7a925.camel@suse.de>
Subject: Re: [PATCH v4 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     tim.gover@raspberrypi.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, wahrenst@gmx.net
Date:   Mon, 09 Mar 2020 11:55:57 +0100
In-Reply-To: <16c98273-a639-374d-e784-0d015aeee634@cogentembedded.com>
References: <20200306114348.5172-1-nsaenzjulienne@suse.de>
         <20200306114348.5172-4-nsaenzjulienne@suse.de>
         <16c98273-a639-374d-e784-0d015aeee634@cogentembedded.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-yufnYxnrASv6QOp1sHw0"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-yufnYxnrASv6QOp1sHw0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-03-07 at 12:55 +0300, Sergei Shtylyov wrote:
> On 06.03.2020 14:43, Nicolas Saenz Julienne wrote:
>=20
> > xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
> > RPi4's VideoCore firmware interface to be up and running. It's possible
> > for both initializations to race, so make sure it's available prior
> > starting.
>=20
>      Prior to starting?

Of course, thanks!

Nicolas


--=-yufnYxnrASv6QOp1sHw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5mIL0ACgkQlfZmHno8
x/5Mvwf/U7iuxfkYayr+H7nxHE88bB6RJjaZmpq0JkgeI18h6/MvgpxmOuzrjOnK
VTPUGmw30F0dKzwEXh5jc09cTiIaarpXk0xDuIF53MQLhiToWRpBwF5du6lIZbym
HndNI+mnUkOx4C0x/Qo+uY+2fmlau5/zDclq5m1PD9BfUfr2+fU3z5WSCP04+NHh
LhYempQI0VIvBRepKy69F/PHbJ2gXhDKAczaTz/izsRJ6z5NJqhJKQw3hzqiPy5o
PUQGVobT03enITrvL10XbM99phOfxuOjfGHHGR2Ex85rcIHRC5s8pJlbfMu9N22N
tvpZ6FtIaCvEgO8dGHgHKXyQSNg4Fg==
=MleZ
-----END PGP SIGNATURE-----

--=-yufnYxnrASv6QOp1sHw0--

