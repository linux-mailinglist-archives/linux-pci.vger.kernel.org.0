Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2219E748
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDDTUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Apr 2020 15:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgDDTUi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Apr 2020 15:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 634ADAEF7;
        Sat,  4 Apr 2020 19:20:35 +0000 (UTC)
Message-ID: <6b81402dd7ab6431f69dba301ce07822cb8dd753.camel@suse.de>
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
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com,
        Rob Herring <robh+dt@kernel.org>
Date:   Sat, 04 Apr 2020 21:20:27 +0200
In-Reply-To: <20200402193820.GA32107@google.com>
References: <20200402193820.GA32107@google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LNav0Mbq0jkFum1SVnUz"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-LNav0Mbq0jkFum1SVnUz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-02 at 14:38 -0500, Bjorn Helgaas wrote:
> [+cc Rob for DT platform device dependency question]
>=20
> On Thu, Apr 02, 2020 at 04:27:23PM +0200, Nicolas Saenz Julienne wrote:

[...]

> > Sorry it wasn't clear enough, I'll redo this comment. Also note that
> > the PCIe bus and the XHCI chip are hardwired, so that's the only
> > device that'll ever be available on the bus.
> >=20
> > VIA805's XHCI firmware has to be loaded trough RPi's firmware
> > mailbox in between the PCIe bus probe and the subsequent USB probe.
> > Note that a PCI reset clears the firmware. The only mechanism
> > available in between the two operations are PCI Fixups. These are
> > limited in their own way, as I can't return -EPROBE_DEFER if the
> > firmware interface isn't available yet. Hence the need for an
> > explicit dependency between pcie-brcmstb and raspberrypi's firmware
> > mailbox device.
> >=20
> > Your concern here showcases this series' limitations. From a high
> > level perspective it's not clear to me who should be responsible for
> > downloading the firmware.=20
>=20
> I think it's fairly common for drivers to download firmware to their
> devices.  I guess there's not really any need to download the firmware
> until a driver wants to use the device, right?
>=20
> > And I get the feeling I'm abusing PCI fixups. I haven't found any
> > smart way to deal with this three way dependency of
> > platform/non-platform devices.
>=20
> So IIUC, the three-way dependency involves:
>=20
>   1) brcm_pcie_probe(), which initialize the PCI host controller
>   platform device, enumerates PCI devices, and makes them available
>   for driver binding,

Yes, and also resets the PCI bus, which will clear VL805's firmware (the XH=
CI
chip).

>   2) the firmware mailbox initialization (maybe
>   rpi_firmware_probe()?),
>
>   3) quirk_usb_early_handoff(), which downloads firmware to the VL805
>   PCI USB adapter via rpi_firmware_init_vl805(), which uses the
>   firmware mailbox?

And yes, that's the general idea.

> Is there some way to express a dependency between
> "raspberrypi,bcm2835-firmware" (the platform device claimed by
> rpi_firmware_probe() and "brcm,bcm2711-pcie"?  If we could ensure that
> rpi_firmware_probe() runs before brcm_pcie_probe(), would that solve
> part of this?

That's ultimately what this patch tries to achieve. If there was a way to
offload it to DT it would be way nicer.

Regards,
Nicolas


--=-LNav0Mbq0jkFum1SVnUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6I3fwACgkQlfZmHno8
x/7yVwf/WCJwmohpLUsUVej5HvbKKbr47tjWtIup3ZkGd73iGu0ksx2odYhV02XX
i++eva/mzXf9XTFBvpfpaExqIrEiKjbzPhpm6Vgt0J7q4uB/T1LYN6q+jfKP5Dbo
sCrxifMx7JSqM1r5ZKFUPHd1rOqiTzR+MpLsgcjvqI/NwDdm8dramibWKiIR74OU
7n1hvoW5S2nMfLjSbwW7UAxv9XIg9WLpobebE94QaYGAsGSDzqTPI4ZDXpP+9Y9p
zE8KUuxi611Nus5Pz6DrgUTrnz2tMvZBOxiIbClGduGRQdy/U1oRLOf2SK3/LD0Q
zu9X6I23eZhtVtQ5l4Wtynxkx6oK8A==
=N5AC
-----END PGP SIGNATURE-----

--=-LNav0Mbq0jkFum1SVnUz--

