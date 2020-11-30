Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1D2C83DE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 13:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgK3MHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 07:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbgK3MHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 07:07:16 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73896206D8;
        Mon, 30 Nov 2020 12:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606737995;
        bh=uzsewMbuRPvdcwhky3sUJyq7j9PBe57NmyVkNT2cuvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wNDSXLoyY4LX33S/nf+hOeZePD9IsiUHgAiN971WF4LlQojCK5r4D0OUv9vOoA/e7
         e8Ot9tl8Ka9G+TcRJJXUAGhbwylCwTYuF8VSlGNaG9dJRT0AjIMKGBXvj5lz3lQtdO
         ELzIBYTdJkyMaXkHtTaRdNAUEsqlD1shmed+ptsY=
Date:   Mon, 30 Nov 2020 12:06:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/6] PCI: brcmstb: Add control of EP voltage
 regulator(s)
Message-ID: <20201130120606.GA4756@sirena.org.uk>
References: <20201125192424.14440-1-james.quinlan@broadcom.com>
 <20201125192424.14440-3-james.quinlan@broadcom.com>
 <20201126114912.GA8506@sirena.org.uk>
 <CA+-6iNzJAf_bKVjbw8bkh3qmSU++m6-DoFKQvBTTZGonYJGXfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <CA+-6iNzJAf_bKVjbw8bkh3qmSU++m6-DoFKQvBTTZGonYJGXfg@mail.gmail.com>
X-Cookie: Space is limited.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 27, 2020 at 03:26:53PM -0500, Jim Quinlan wrote:
> On Thu, Nov 26, 2020 at 6:49 AM Mark Brown <broonie@kernel.org> wrote:

> > Does PCI allow supplies to be physically absent?  If not then the driver
> > shouldn't be using regulator_get_optional() and much of the code here
> > can be deleted.

> First, as an aside, I'm  a little confused about the purpose of
> devm_regulator_get_optional(...);  the other  xxx_get_optional() calls
> I am familiar with (eg clock, reset, gpio) return NULL if the desired
> item does not exist, and then NULL can be used as a valid pointer for
> the rest of the API.  Not so here.

The other APIs that cloned the regulator API don't have the dummy
support that the regulator has and unfortunately changed the sense a bit
there.

> > > +static void brcm_set_regulators(struct brcm_pcie *pcie, bool on)
> > > +{

> > This is open coding the regulator bulk APIs.

> Except that a bulk regulator "get"  requires that all supplies are
> present.  I would have to first scan the node's properties for the
> "-supply" properties and fill in the bulk regulator structure.  I'm
> fine with doing that.

No, you should never do that.  If the supplies can be physically absent
then you should use regulator_get_optional() which allows you to do
whatever needs doing to configure the hardware for the missing supply.
If it's just that the supply may not be described in the DT but has to
be there for the device to operate then the code should use the normal
regualtor APIs - a dummy regulator will be provided if there's no supply
described.

> However, a previous incarnation of this  commit was reviewed by RobH,
> and if I understood him correctly he wanted the actual names of the
> possible regulators to be used and specified in the bindings doc.   I
> just followed the example of "pcie-rockchip-host.c" whose bindings doc
> was reviewed by RobH.

That is just plain bad code, the binding may well be fine but I can't
see any excuse for that driver to be using _optional() there.

Another subsystem I'm going to have to keep an eye on :(

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/E4C0ACgkQJNaLcl1U
h9ASVAf/dAzCzBS05ZDDJT3IWk8wIMrO9CCPEMAfYPfqF2cDecsYmWGeMci5N1BK
Psu0U9QMod0gBFody7uur6MDmWtta/yTvsXnxyoPOCxy2uyW+kOSXkv5czAevU5C
ojaUWaKRi+jv1z4pnMnC3ujHjv3rz+j+PDRUSx5tFcYEk4l41jt9ROrroybhEdjT
oWNz3aRq0ho06udUBLutr2rUChL4rVYx4menujiC93X9BPd/tDBqtdJgy/G56eBE
lO1kno/55Epva9bnji0snGJCCGIh8n640TDHiDmWJjY649CwgoiaUw15fgMs2iV0
UHhac7bZs7vk8VTGMuwDfHg577bmJQ==
=vrSY
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
