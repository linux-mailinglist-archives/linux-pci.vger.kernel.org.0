Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3E2A4D02
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 18:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgKCRc5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 12:32:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgKCRc5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 12:32:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97210ADE3;
        Tue,  3 Nov 2020 17:32:55 +0000 (UTC)
Message-ID: <3b4b1d0765b39e96e4c4d1fc6f05e1178c486096.camel@suse.de>
Subject: Re: [PATCH v1] PCI: brcmstb: variable is missing proper
 initialization
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Nov 2020 18:32:54 +0100
In-Reply-To: <ad4cbee6-c52e-cedc-fa79-3805e36377b4@gmail.com>
References: <20201102205712.23332-1-james.quinlan@broadcom.com>
         <ad4cbee6-c52e-cedc-fa79-3805e36377b4@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Y1BfcH8l7k1gAwSH6jtl"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-Y1BfcH8l7k1gAwSH6jtl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-02 at 13:07 -0800, Florian Fainelli wrote:
>=20
> On 11/2/2020 12:57 PM, Jim Quinlan wrote:
> > The variable 'tmp' is used multiple times in the brcm_pcie_setup()
> > function.  One such usage did not initialize 'tmp' to the current value=
 of
> > the target register.  By luck the mistake does not currently affect
> > behavior;  regardless 'tmp' is now initialized properly.
> >=20
> > Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controll=
er driver")
> > Suggested-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


--=-Y1BfcH8l7k1gAwSH6jtl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+hlEYACgkQlfZmHno8
x/7UmQf/QEPoyFXEKqZEvSUKhQM/wfdxv7GdwSdzHkvNK1H0UhjOvBgJYgEz38So
O3gjPjD9dhQjTzIk610uHdqhfX04slpJMKVsOKgyN6DOanBJsWrqBqlMuYVFjmnW
7ucizmbyUAN6/sQEDCARzSFQTY6a6ddZYZyEVGSggZtuTNZhIiez1KmLtV1Kp+Ot
yMp6XeMF7l6FHzqLXtmrkwbiBZsMxgDIgCJNFbmXqX7G8p1086bTHmBTq642Pz1B
VNVKu1woPrjipQJGoqud4x9CbdFMwVeDgRvnu2nqA+z5GopEPecUGXcNSWs8FFxv
CNYhiQXtY9xjyhUmhCEeQkbLLKJEqQ==
=Ssc4
-----END PGP SIGNATURE-----

--=-Y1BfcH8l7k1gAwSH6jtl--

