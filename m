Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9A35756E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 22:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbhDGUHh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 16:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345853AbhDGUHg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 16:07:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E16061158;
        Wed,  7 Apr 2021 20:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617826047;
        bh=a6BQBkYBckWILIt+kdw/GGz0d9VSJVSXsYtBOcNTfvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upetZLxnv0XQGf4pDHYqYTctrM9Xl9I3ZxX+a4L/3q9zB+Bs5gKE37JiLKMvdzsxO
         bNYCYzvb+lH6XQqK44xPxAwqJ3t0oJCBJjVQ8i+n6lKop77Ra/qnEoe44JrhZ/A2U4
         u+Hv4xtNHEQ456WmvBYp2+MTv2KK/5Z9+AZH7r3YJ7GBIO0N0CkEOW/90sdManEu+R
         l21XFXLYa2FrKEotLm7Bl6yKccwZrsFE3rP7x/8TVHtr5RfR9MaV1S7OkaGg7S04X8
         GGCsk7xj8nI0Tu43OA/OVHsd2dPnldPZXCYxbfqIchUgqelXazhAuGX3O5EaTZG29a
         NpuVEx6sRNnlA==
Date:   Wed, 7 Apr 2021 21:07:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
Message-ID: <20210407200709.GG5510@sirena.org.uk>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk>
 <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk>
 <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
 <20210407112713.GB5510@sirena.org.uk>
 <03852d1a-1ee4-fd29-8523-4673c35f83cd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
In-Reply-To: <03852d1a-1ee4-fd29-8523-4673c35f83cd@gmail.com>
X-Cookie: Dry clean only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 07, 2021 at 11:35:57AM -0700, Florian Fainelli wrote:
> On 4/7/2021 4:27 AM, Mark Brown wrote:

> > Frankly I'm not clear why you're trying to handle powering on PCI slots
> > in a specific driver, surely PCI devices are PCI devices regardless of
> > the controller?

> There is no currently a way to deal with that situation since you have a
> chicken and egg problem to solve: there is no pci_device created until
> you enumerate the PCI bus, and you cannot enumerate the bus and create
> those pci_devices unless you power on the slots/PCIe end-points attached
> to the root complex. There are precedents like the rockchip PCIe RC
> driver, and yes, we should not be cargo culting this, which is why we
> are trying to understand what is it that should be done here and there
> has been conflicting advice, or rather our interpretation has led to
> perceiving it as a conflicting.

As you note below I've pointed you at Slimbus which has a similar
problem and solves it at a bus level although it thought of this from
day one which makes life easier; I do think it'd be good to get this
stuff in the driver core since it's an issue that affects every
enumerable bus in the end but nobody's summoned up the enthusiasm for
that (including me).

> If the regulator had a variation where it supported passing a
> device_node reference to look up regulator properties, we could solve
> this generically for all devices, that does not exist, and you stated
> you will not accept changes like those, fair enough.

I'm certainly not enthusiastic about the idea and the likely abuse isn't
inspiring, and of course regulators aren't the only resource that might
be needed to get something up and running and would need to be extended
in the end.  That said I've not seen any concrete proposals either.

> When you suggested to look at soundwire for an example of "software
> devices", we did that but it was not clear where the sdw_slave would be
> created prior to sdw_slave_add(), but this does not matter too much.

Looks like sdw_acpi_find_slaves() and sdw_of_find_slaves().

> Let us say we try to solve this generically using the same idea that we
> would pre-populate pci_device prior to calling pci_scan_child_bus(). We
> could do something along these lines:

...

> - from there on we try to get the regulators of those pci_device objects
> we just allocated and we try to enable their regulators, either based on
> a specific list of supplies or just trying to enable all supplied declared.

I'd suggest specfying the supplies that PCI provides to slots in the
spec with standard names and just using that list, at least as a start.
That'd probably cover most cases and allow the binding to be written at
the generic PCI level rather than having individual devices need to name
their supplies for the binding documentation and validation stuff which
seems easier.  Devices with extra stuff can always extend the binding.

> - now pci_scan_child_bus() will attempt to scan the bus for real by
> reading the pci_device objects ID but we already have such objects, so
> we need to update pci_scan_device() to search bus::devices and if
> nothing is found we allocate one

> Is that roughly what you have in mind as to what should be done?

Yes, pretty much.  Ideally there'd be some way for drivers to get a
callback prior to enumeration to handle any custom stuff for embedded
cases but unless someone actually has a use case for that you could just
punt.

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBuEOwACgkQJNaLcl1U
h9AdLwf/RsAf7UG+ffz3mi2yHRfdLT+R1kAAHHjvZu3yk1w4XvfbIGwyQ0GqFjsh
bVGHEaP41hJtr+0o8FQOk2warQy4R2aq1rFUAFUsa3j126r6CmanfM7bBTWPwhxx
5PL2C3RC27LH4RBK851FFVDOsQ4+Wb7DjGEMxsxaEfadT+EUWGAeNauSyXXefrmZ
Kpwkcwj2Bif3E8oGWcugThD/rcgI15cf32LKRrwMj259Ba/RiCaZBOUM3AFd72Ep
BVqo9whlen+wRXMYEGDdC2mnW+yyGQAb36KObjAU0rcHQoHJL8HbT1l02B2oFhKN
MoH3G5M+ZMogQd8ebBqRK4Eh0WlJIQ==
=bCrR
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--
