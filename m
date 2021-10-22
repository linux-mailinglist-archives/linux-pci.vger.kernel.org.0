Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A201437950
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhJVOwL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233375AbhJVOvc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 10:51:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2F2F6109F;
        Fri, 22 Oct 2021 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634914154;
        bh=br3zzsIh+fIbyso08MmFWkMgWQt3NJ7boS26v0g60gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuJiuGWXTPyHmp8zStuzSECUo2TbC+jpIobqQ0VwQETJ1k4Aq5PElvpeYvOuNL4Ah
         91NZMHvQ/84gWvVUb1uO1IuUM+IQxRU4kmfQDlkE26XG29b9B8ALS0bnQJRGL1cm0m
         w4oWTHU57QxbK3LXUhK3YUHtZJ7H5m4IeLUEKCpUoyqHSydeEkH7aZWX8OLzVumdV4
         XFLB8/mDHZG6oc6ScV9szv4dsPGtGyxVf8M/JG+4q6Rgl13wWWtPkl595/zvH6CGd2
         sWd3Vo41yfoRLjypCZTeug42gAKGPnBL9LzMo8cPvotv35fPSmhDsRYLFBLo8hbU+D
         uYzP4jMRhdCXw==
Date:   Fri, 22 Oct 2021 15:49:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <YXLPZ4CsQMjHPpJS@sirena.org.uk>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dIJNDwvrhJmF8hs5"
Content-Disposition: inline
In-Reply-To: <20211022140714.28767-2-jim2101024@gmail.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--dIJNDwvrhJmF8hs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 22, 2021 at 10:06:54AM -0400, Jim Quinlan wrote:

> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
>=20
> https://github.com/devicetree-org/dt-schema/pull/54

This contains updates to add the generic PCIe supply rails, not the
brcm-ep-a and brcm-ep-b supplies (which as I said on the other patch
look like they ought to be renamed).  That's fine since they're
obviously not generic PCIe things but this means that those bindings
need to be added to the device specific bindings here.  Currently
there's only an update to the examples.

--dIJNDwvrhJmF8hs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFyz2cACgkQJNaLcl1U
h9CYDAf/apZ2CgG4lUyprnecqVyJmeG+fANohDBxxKWjzNBC/4UOxJ5aTeXdD3RL
pRkYfG/BcoDFccJprugkG6JuxKV9aj3amKZrO1/w0Wp+eww9FjodQjfJvJkghSXw
RDAljaoA8FhBrm5ufNRrSwh+BOjGK4bdlCY9gSEDwH2oCVALFyDHaYE3mW7Im3Hx
3aH8oJXOunaxIXar/niOZar+h4AV6z42S3fwVy5vBN8Iwg4Ry+ZoBOmS54FL3O+p
Y7Pc0GPNPB5jcIiR5msgmP3Uwko8Ju8hDGGD1fV5yJlSeJhNyu3VECMPHYn3N99c
j7YJjE/4MeJo34NLjbBcGrXfEVWIYw==
=+inF
-----END PGP SIGNATURE-----

--dIJNDwvrhJmF8hs5--
