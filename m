Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D91FF000
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 12:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFRKyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 06:54:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727825AbgFRKyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 06:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01E55AC53;
        Thu, 18 Jun 2020 10:54:13 +0000 (UTC)
Message-ID: <6b8edfca3890f026bd0a33591d6fd1f9691e7e4e.camel@suse.de>
Subject: Re: [PATCH 04/15] PCI: brcmstb: Use pci_host_probe() to register
 host
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
Date:   Thu, 18 Jun 2020 12:54:12 +0200
In-Reply-To: <20200522234832.954484-5-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
         <20200522234832.954484-5-robh@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OPGLGZsMisDLgv+ey9Oy"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-OPGLGZsMisDLgv+ey9Oy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-22 at 17:48 -0600, Rob Herring wrote:
> The brcmstb host driver does the same host registration and bus scanning
> calls as pci_host_probe, so let's use it instead.
>=20
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Don't know if I'm a little late for this series but:

Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-OPGLGZsMisDLgv+ey9Oy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7rR9QACgkQlfZmHno8
x/7VRQf/bPWts76212hIHit8+p5DzB+2Blgg7QpJyU2JvqGZJMBwvogWjXz8SfD/
eNOwoD9ggoyzg+BMDb72y4r46gwJNyYPlJCmrAs8i2Fl084eCwIJ8tcyjEV407i7
+Z2tsG4Z+OZuS/NJwco/yE3YI+UFTtNz7Scka1XkEgoMDsudljc+kQDGZzwVacDL
oCrrwdOxlErLaBd8A8TU8VYYZDFG9Oq5aAPildR3DvJWBXmMA1eTss6Ak6ctXmM2
+JfRcX3v5k/Q8rV8wFjklO18SvVmx5RvW+ELZ2DCDpg3q/Ny+ODVmqwPnMrVO6k0
XCSmwzx8e0yqRYjEHsdlTXpFnf6zNQ==
=Rx7M
-----END PGP SIGNATURE-----

--=-OPGLGZsMisDLgv+ey9Oy--

