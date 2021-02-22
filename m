Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBDF321BCF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhBVPsM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 10:48:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:55658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231500AbhBVPsH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Feb 2021 10:48:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA433AD73;
        Mon, 22 Feb 2021 15:47:23 +0000 (UTC)
Message-ID: <c188698ca0de3ed6c56a0cf7880e1578aa753077.camel@suse.de>
Subject: RPi4 can't deal with 64 bit PCI accesses
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Robin Murphy <robin.murphy@arm.con>
Date:   Mon, 22 Feb 2021 16:47:22 +0100
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2vObhEbCJZFrLJMv1iYe"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-2vObhEbCJZFrLJMv1iYe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,
Raspberry Pi 4, a 64bit arm system on chip, contains a PCIe bus that can't
handle 64bit accesses to its MMIO address space, in other words, writeq() h=
as
to be split into two distinct writel() operations. This isn't ideal, as it
misrepresents PCI's promise of being able to treat device memory as regular
memory, ultimately breaking a bunch of PCI device drivers[1].

I'd like to have a go at fixing this in a way that can be distributed in a
generic distro without prejudice to other users.

AFAIK there is no way to detect this limitation through generic PCIe
capabilities, so one solution would be to expose it through firmware
(devicetree in this case), and pass the limitations through 'struct device'=
 so
as for the drivers to choose the right access method in a way that doesn't
affect performance much[2]. All in all, most of this doesn't need to be
PCI-centric as the property could be applied to any MMIO bus.

Thoughts? Opinions? Is it overkill just for a single SoC?

Regards,
Nicolas

[1] https://github.com/raspberrypi/linux/issues/4158#issuecomment-782351510
[2] Things might get even weirder as the order in which the 32bit operation=
s
    are performed might matter (low/high vs high/low).


--=-2vObhEbCJZFrLJMv1iYe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAz0goACgkQlfZmHno8
x/51WAf+P4m0o3Zf4MyAwnKhuvCKj1FZALj/AdsWETPKfnW0w+kzUentV+8JAqQ9
isR5mzRZTQ2650jCgSKHotdAeizmj5aVRjcp7e8crzOSd/QHcUo+CdLX4JObp22P
/KdbwttMLn5GkbDhQ3shBY/TQS52YXTjigdTIDrOhfqVgqBeP0rlZFCYDT2fM0L0
QNU9wbpx6ybgFhJWjPX0NeZfbGl64ZMJBEb3hYWklIqKV2Ut9cbQ/a+P69AG3VZv
D0l4w5ix5Ee5BJT9xYT6yqBlAUvnszm346MF8hKY8aMZHGnIHheFl2UddOUUmhI4
WrxqeVOw9A3zLOJEfC4xrq4dgYTQ6g==
=hCqg
-----END PGP SIGNATURE-----

--=-2vObhEbCJZFrLJMv1iYe--

