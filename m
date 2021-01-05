Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7BA2EAE9A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 16:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbhAEPe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 10:34:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbhAEPez (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 10:34:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 605DF22AAB;
        Tue,  5 Jan 2021 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609860854;
        bh=6LNNf9Ps64nYPsfS29WeXyehMYYqGfzkFag3C65Fpwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dY6lqOTpyS3rKOArMrV8ZwHksktSKfjnNUUxbI/Qrj1LvMqRYJ6j1IM9x9tDCoAVK
         ctVqyJcovX11sb+f6f4WurSnS+pohg9I+/Ba1MfDnIO+asbbJYBPIA9h0nwvscK7iA
         q7eYQ8SxKADgNMpxuh5A9eIZt+uy31I7LZNMTdGVGaHltSVizOfKqo0NAWYY6o7JDH
         adw6jajHlxM7S269fdKIT4UD1bFOHjQCCcHwjRECEbErYBSxfFvYN8AuCUr1rQs0aM
         i7/JnbGi3Qu+QhaK3cvx3sLyTaRNN7A8ogd5CIb2R86H6W/2LENxH55+XKebV8QRng
         +loyTKjGdw+Tg==
Date:   Tue, 5 Jan 2021 15:33:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20210105153347.GE4487@sirena.org.uk>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-2-james.quinlan@broadcom.com>
 <20201209140122.GA331678@robh.at.kernel.org>
 <CANCKTBsFALwF8Hy-=orH8D-nd-qyXqFDopATmKCvbqPbUTC7Sw@mail.gmail.com>
 <20210105140128.GC4487@sirena.org.uk>
 <CANCKTBtNgyBTNwwtbtMkR9nFwq+AZyAZmGX9XXfhwf27zwjG_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline
In-Reply-To: <CANCKTBtNgyBTNwwtbtMkR9nFwq+AZyAZmGX9XXfhwf27zwjG_Q@mail.gmail.com>
X-Cookie: I'm ANN LANDERS!!  I can SHOPLIFT!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2021 at 10:09:21AM -0500, Jim Quinlan wrote:
> On Tue, Jan 5, 2021 at 9:01 AM Mark Brown <broonie@kernel.org> wrote:

> > > For us, the supplies are for the EP chip's power.  We have the PCIe
> > > controller turning them "on" for power-on/resume and "off" for
> > > power-off/suspend.  We need the "xxx-supply" property in the
> > > controller's DT node because of the chicken-and-egg situation: if the
> > > property was in the EP's DT node, the RC  will never discover the EP
> > > to see that there is a regulator to turn on.   We would be happy with

> > Why can't the controller look at the nodes describing devices for
> > standard properties?

> It just feels wrong for the driver (RC) of one DT node to be acting on
> a property of another driver's (EP) node, even though it is a subnode.

This is something we do for other buses, for example where there's
device specific tuning that is actually implemented in the controller
hardware.

> There is also the possibility of the EP driver acting upon the
> property simultaneously; we don't really have control of what EP
> device and drivers are paired with our SOCs.

If the device is trying to do something with a supply that's a standard
part of the bus outside of the bus it seems like that's going to lead to
problems no matter what, due to the discovery issues the device must be
coordinating with the bus somehow.

> In addition, this just pushes the binding name issue down a level --
> what should these power supplies be called?  They are not slot power
> supplies.  Can the  Broadcom STB PCIe RC driver's binding document
> specify and define the properties of EP sub-nodes?

I assume the supplies have some name in the PCI specs, whatever names
are used there would probably be appropriate.

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/0htoACgkQJNaLcl1U
h9CY8wf9HuKx8WrUVOm/JnM4g7BRzRrN0zbKNo27TY0gXTi97ROAnd+1hDclFSnn
N5C2FGBEeTzpc2zyUyiyMO7iiqFC1NJ1bPp0vXFaVN4g1nBBTAt9bMdIbKAGiWmt
sJGRDPZtrc67RCH9PDcGOqiXqxy+p4nuBZl9GgLGcr/FLpNe8WISnLmXW0KTGMgf
6KEkVTTHqMuJzrcj5NlDMQZKjcdJ3tmKDXDYMj4CV+PJPbnJStKpdFxzi3aueDE5
K5z8O/3iAm3690g40V4jQBRGT/SlEMpsdc+bQx+9AEoMGZ3Q2EZfIXs8y3OqhPU6
enmqPZx9J+0Dn/hn4g4l1iyAoOfG+w==
=7I/C
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
