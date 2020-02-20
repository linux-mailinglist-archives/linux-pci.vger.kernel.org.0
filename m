Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E81665F5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBTSO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 13:14:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:51584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgBTSO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Feb 2020 13:14:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13AACAC16;
        Thu, 20 Feb 2020 18:14:23 +0000 (UTC)
Message-ID: <cab8c0d70fd30c49579199d002b81b87ed34a920.camel@suse.de>
Subject: Re: [PATCH v2 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 20 Feb 2020 19:14:20 +0100
In-Reply-To: <10a53db8-960e-eea7-1e8d-790de9a79e71@broadcom.com>
References: <20200219123933.2792-1-nsaenzjulienne@suse.de>
         <20200219123933.2792-4-nsaenzjulienne@suse.de>
         <10a53db8-960e-eea7-1e8d-790de9a79e71@broadcom.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RsrYh3XIvQNMFLjrdUpB"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-RsrYh3XIvQNMFLjrdUpB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-19 at 11:21 -0800, Florian Fainelli wrote:
> On 2/19/20 4:39 AM, Nicolas Saenz Julienne wrote:
> > xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
> > RPi4's VideoCore firmware interface to be up and running. It's possible
> > for both initializations to race, so make sure it's available prior
> > starting.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>=20
> It does not look like there is something making sure that
> CONFIG_RASPBERRYPI_FIRMWARE is being selected or depended on, should we
> have a "default XHCI_PCI" added to drivers/firmware/Kconfig?

I think having that would enable the firmware interface for all XHCI_PCI us=
ers,
which isn't ideal. The firmware call has stubs for the case the firmware
interace isn't compiled, so no problem there. Ultimately we want to enable
CONFIG_RASPBERRYPI_FIRMWARE only when the built image targets the RPi4
(reglardless of being arm64/arm32). But I don't think that's feasible.

Regards,
Nicolas


--=-RsrYh3XIvQNMFLjrdUpB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5OzHwACgkQlfZmHno8
x/7JXggAp1+xWNqaL/5ExpM/n9Su+Z/6pLAFYSYbVlKAzipGxgOD4a9FH3jJ8p4J
mACCkp+9psxkkQfoNW4s+edRXTKEJ8rH/Zv1tRJ3CpViHb8b95XW3zO6xWb2BLln
Y+Q8VVvplVzQxci+Qo6oQki1hgvwm2lvTcbnD6w3yu0U3LUKKDzkZHQLVUtvXU9m
thco7iOswNEq9FshjSLyrUdeZvtuYjx3zHNO5tFz7+Zo226CTPe9teoUjBMmlppv
iLDJwBPAmT1QJNjDCP+ziduGh2IH14Wmf5IMofn7p9wnxCvvlL4CfZp9+QLtI2UH
A7w2lxIPiOh0ERYep91DEHD/Jy3Hcw==
=mdiV
-----END PGP SIGNATURE-----

--=-RsrYh3XIvQNMFLjrdUpB--

