Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9027119C400
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 16:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgDBO12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 10:27:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgDBO12 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Apr 2020 10:27:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 81969AC44;
        Thu,  2 Apr 2020 14:27:25 +0000 (UTC)
Message-ID: <47c543e2144d5247743548b00d1931e9fc217f43.camel@suse.de>
Subject: Re: [PATCH v6 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com
Date:   Thu, 02 Apr 2020 16:27:23 +0200
In-Reply-To: <20200401204149.GA131584@google.com>
References: <20200401204149.GA131584@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UbnwTZ/sE1EQtQ8St3GX"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-UbnwTZ/sE1EQtQ8St3GX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Wed, 2020-04-01 at 15:41 -0500, Bjorn Helgaas wrote:
> On Tue, Mar 24, 2020 at 07:28:11PM +0100, Nicolas Saenz Julienne wrote:
> > xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
>=20
> Is there a function name for this fixup that you can mention?

Yes, rpi_firmware_init_vl805(), I'll update the description.

> > RPi4's VideoCore firmware interface to be up and running. It's possible
> > for both initializations to race, so make sure it's available prior to
> > starting.
>=20
> I guess "both initializations" means brcm_pcie_probe() and something
> else?  It'd be nice to include that function name here, too.

Noted, I'll be more explicit on the next version of the series. More in dep=
th
explanation below.

> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c
> > b/drivers/pci/controller/pcie-brcmstb.c
> > index 3a10e678c7f4..a3d3070a5832 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -28,6 +28,8 @@
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> > =20
> > +#include <soc/bcm2835/raspberrypi-firmware.h>
> > +
> >  #include "../pci.h"
> > =20
> >  /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config reg=
s */
> > @@ -917,11 +919,24 @@ static int brcm_pcie_probe(struct platform_device
> > *pdev)
> >  {
> >  	struct device_node *np =3D pdev->dev.of_node, *msi_np;
> >  	struct pci_host_bridge *bridge;
> > +	struct device_node *fw_np;
> >  	struct brcm_pcie *pcie;
> >  	struct pci_bus *child;
> >  	struct resource *res;
> >  	int ret;
> > =20
> > +	/*
> > +	 * We have to wait for the Raspberry Pi's firmware interface to be up
> > +	 * as some PCI fixups depend on it.
>=20
> It'd be nice to know the nature of this dependency between the
> firmware interface and the fixups.  This may be useful for future
> maintenance.  E.g., if PCI config access doesn't work until the
> firmware interface is up, that would affect almost everything.  But
> you say "some PCI fixups", so I suppose the actual dependency is
> probably something else.

Sorry it wasn't clear enough, I'll redo this comment. Also note that the PC=
Ie
bus and the XHCI chip are hardwired, so that's the only device that'll ever=
 be
available on the bus.

VIA805's XHCI firmware has to be loaded trough RPi's firmware mailbox in
between the PCIe bus probe and the subsequent USB probe. Note that a PCI re=
set
clears the firmware. The only mechanism available in between the two operat=
ions
are PCI Fixups. These are limited in their own way, as I can't return
-EPROBE_DEFER if the firmware interface isn't available yet. Hence the need=
 for
an explicit dependency between pcie-brcmstb and raspberrypi's firmware mail=
box
device.

Your concern here showcases this series' limitations. From a high level
perspective it's not clear to me who should be responsible for downloading =
the
firmware. And I get the feeling I'm abusing PCI fixups. I haven't found any
smart way to deal with this three way dependency of platform/non-platform
devices. I even looked into adding -EPROBE_DEFER support to fixups, but I f=
ear
that would entail moving them into the core device definition.

Regards,
Nicolas


--=-UbnwTZ/sE1EQtQ8St3GX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6F9ksACgkQlfZmHno8
x/7wXQf9GeRwGPIeI/wbeH0RFkXsyiFyaYxhvRtWla25hLtNxPLBoPWmR9sR5YP3
8ZM10ZELD5DqgwBhBeWqJk43ZzNYnJACp97N2fe7wZBVXFx9fCtlG1VmcqG02CiT
JkIgFDeAAq5tjbgWfKEBtTiLXch+C66Ja+7H7XOAm0RhEdVDqhrCI9lZecoHYWev
0TarGDoABp25KqujbYb/TXFzg4LPMEA39tNdvt8slPf28Z5En4IdPUpogXQ6+fA6
WbbY64G1WCnBQBlnB/XFRX+cuVRcwX+FImDSzSowaEZHeuMyC1qXQcmMHkym59KP
0cMQjaZhNNzZpO26RCF2+eJSzDzS5Q==
=jbBy
-----END PGP SIGNATURE-----

--=-UbnwTZ/sE1EQtQ8St3GX--

