Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5261E2A5047
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCTkc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 14:40:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:48474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCTkc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 14:40:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 79D53AF84;
        Tue,  3 Nov 2020 19:40:30 +0000 (UTC)
Message-ID: <b168ae648524797f1332e69461d622454715ddd5.camel@suse.de>
Subject: Re: [PATCH v1] PCI: brcmstb: variable is missing proper
 initialization
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 03 Nov 2020 20:40:28 +0100
In-Reply-To: <20201103193816.GA258457@bjorn-Precision-5520>
References: <20201103193816.GA258457@bjorn-Precision-5520>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nvKhNR6RmsfIw8RNZUdB"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--=-nvKhNR6RmsfIw8RNZUdB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-03 at 13:38 -0600, Bjorn Helgaas wrote:
> On Mon, Nov 02, 2020 at 03:57:12PM -0500, Jim Quinlan wrote:
> > The variable 'tmp' is used multiple times in the brcm_pcie_setup()
> > function.  One such usage did not initialize 'tmp' to the current value=
 of
> > the target register.  By luck the mistake does not currently affect
> > behavior;  regardless 'tmp' is now initialized properly.
>=20
> This is so trivial that there's probably no reason to post this again,
> but if you post a v2 for some reason, please update the subject to
> match the convention ("PCI: brcmstb: Verb ..."), e.g.,
>=20
>   PCI: brcmstb: Initialize "tmp" before use
>=20
> The commit log does not say what the patch does, leaving it to the
> reader to infer it.
>=20
> Lorenzo will likely fix this up when he applies it.
>=20
> Incidental curiosity: where should I look to see what
> u32p_replace_bits() does?  "git grep u32p_replace_bits" shows several
> calls, but no definitions.

It's a bunch if defines in 'include/linux/bitfield.h'

Regards,
Nicolas


--=-nvKhNR6RmsfIw8RNZUdB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+hsi0ACgkQlfZmHno8
x/6Jwwf/fz2BWj+g88awStcBOFOc9sXJRLSGq0DxmNG6MtFYwxGOSDOTAh0VqvW6
la8BdNx+7q8i4uVjQMvRa22YOi78htWFb4nareJjldrEhn1yrxHZ7VLwEfDJFUiB
ei5f3YDbDR0D2KH+RMv3z9wPJmGIo1GSq1wZj+nthMrtIQVZ4PXlo2fZis16I1xd
QC8GsduMkqcJm3EHJSte4SFJQu5CLBX6UDKlvE6GrmWbb+nqYxESrHSnGgVJTt11
7qbCs7pcNEt4pIWmca3w5iITCC4+v7GE2oRAMZZPw6jl5dgBWGaitJG9/Ij+pIoh
Y4aRLvUjEfs5+tX3CkAH8sa7UoMIug==
=CS09
-----END PGP SIGNATURE-----

--=-nvKhNR6RmsfIw8RNZUdB--

