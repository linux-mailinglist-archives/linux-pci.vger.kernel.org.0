Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA50C1052E3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKUN0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 08:26:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:38506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbfKUN0T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 08:26:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B630AC45;
        Thu, 21 Nov 2019 13:26:17 +0000 (UTC)
Message-ID: <18109ee4f8d8c5ce0dc714217eef53ee42d5305f.camel@suse.de>
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, mbrugger@suse.com,
        maz@kernel.org, phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, Eric Anholt <eric@anholt.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Thu, 21 Nov 2019 14:26:15 +0100
In-Reply-To: <20191121120319.GW43905@e119886-lin.cambridge.arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
         <20191112155926.16476-5-nsaenzjulienne@suse.de>
         <20191119162502.GS43905@e119886-lin.cambridge.arm.com>
         <7e1be0bdcf303224a3fe225654a3c2391207f9eb.camel@suse.de>
         <20191121120319.GW43905@e119886-lin.cambridge.arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YC8AUFAYK8BdUfEkQttG"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-YC8AUFAYK8BdUfEkQttG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-21 at 12:03 +0000, Andrew Murray wrote:
> On Wed, Nov 20, 2019 at 08:53:30PM +0100, Nicolas Saenz Julienne wrote:
> One purpose of this function is to validate that the information given in=
 the
> device tree is valid - I've seen other feedback on these lists where the =
view
> is taken that 'it's not the job of the kernel to validate the DT'. Subscr=
ibing
> to this view would be a justification for removing this validation -
> especially
> given that the bindings you include have only one dma-range (in any case =
if
> there are constraints you ought to include them in the binding document).
>=20
> Though the problem with this point of view is that if the DT is wrong, it=
 may
> be possible for the driver to work well enough to do some function but wi=
th
> some horrible side effects that are difficult to track down to a bad DT.

As for the validation, I think in this specific case it's still worthwhile.=
 As
you might know, there is a bug on the first revision of RPI4's PCIe integra=
tion
which blocks any access higher than 3GB. Further revisions fix this and all=
ow
full memory addressing.

I've been working with Phil Elwell (from the RPi foundation) to solve this =
in a
way that plays well with upstream and this driver (I'll be able to test the=
 new
revision before this gets in). The solution is, unsurprisingly, for the
firmware to edit the DTB passed to the kernel based on the board revision.
Given that there is some live manipulation of the dma-ranges I'd rather lea=
ve
the validation check.

If you don't disagree with the above I'll add an extra code comment explain=
ing
why we feel the need to verify the device-tree contents.

Regards,
Nicolas


--=-YC8AUFAYK8BdUfEkQttG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3WkHcACgkQlfZmHno8
x/5fvQf/SGfuvvm/Gcihpp2EHLNBM3vOWITb9bWmwHmizoV71HY7NC7ua0H7BO04
ilLvP8UzpSSAw0HA3P7FfdIFOUlwVob7j98pytJzGhykxjhyacMJKEzhc/dDttth
Bghc8dxd3+QJucPmqw0n6aZsQmB7CJtM4DSx4cVJhTB6AGfzfQ7TgKyCeLVt5RmH
Oq6kT6DJ7Fc4A3OpJrAkgiLxhGXif4C9v6KH6d7c+95H0NmHl9qIwyYVGtKml4fT
7ZZsv6aG0NwvlMizK09lUeiun0zzY3wnwo7P3oVL/yH4fpfrxDvTEvjBMSU3yhxz
+N4VAl8PJi6HWTJaiiJ7tQGgKq2Ofg==
=ftB5
-----END PGP SIGNATURE-----

--=-YC8AUFAYK8BdUfEkQttG--

