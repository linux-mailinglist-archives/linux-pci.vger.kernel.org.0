Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED543B31D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhJZNZC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 09:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhJZNZC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Oct 2021 09:25:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BFFD60EB9;
        Tue, 26 Oct 2021 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635254558;
        bh=/KUvPPMxXbje75GPUHbAEgXl10p2kIaA2/60Ct5288Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Il4ZnHvswG9jP2UhgtSN2YBo33pc5SfnkXbebj0HsWWUfdPGbCOO151mZITcEWbDZ
         P7SW+LVyLKNJ+hk4UK+cvIkXYphawRlpRNikKI3fpNgKYz3TCHl9JkCj0h0NzLKRhA
         Z3LmxpjL8WrdBV8obJPkJp3Beawjl8Mar/kA8avpECEOYL+V486MPO/Da32WNPvCj3
         YmuerP4XTW7Qzx6tua2wrc48360k0XCjMPRIliWZ3LEYFCjGrMndnAWzTZ+VJK1g2g
         qiaYxEMY8W9SQNXaeBWAQqfBNnPzX97NLSS27rVk3/4ErG0b3lfe0pmdwT4iw6rHOC
         qGoAJhp1NUD+Q==
Date:   Tue, 26 Oct 2021 14:22:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/6] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <YXgBGWCOF3LVXcuC@sirena.org.uk>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk>
 <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
 <YXMVSVpeC1Kqsg5x@sirena.org.uk>
 <CA+-6iNxQAekCQTJKE5L7LO6QF+UC6xnyE=XVq_7z3=4hp8ASXQ@mail.gmail.com>
 <YXbF+VxZKkiHEu9c@sirena.org.uk>
 <2eec973e-e9f0-1ef7-a090-734dab5db815@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gDFq9v3imEYJoQxi"
Content-Disposition: inline
In-Reply-To: <2eec973e-e9f0-1ef7-a090-734dab5db815@gmail.com>
X-Cookie: Times approximate.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--gDFq9v3imEYJoQxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 25, 2021 at 03:04:34PM -0700, Florian Fainelli wrote:
> On 10/25/21 7:58 AM, Mark Brown wrote:

> > Other vendors have plenty of variation in board design yet we still have
> > device trees that describe the hardware, I can't see why these systems
> > should be so different.  It is entirely normal for system integrators to
> > collaborate on this and even upstream their own code, this happens all
> > the time, there is no need for everything to be implemented directly the
> > SoC vendor.

> This is all well and good and there is no disagreement here that it
> should just be that way but it does not reflect what Jim and I are
> confronted with on a daily basis. We work in a tightly controlled
> environment using a waterfall approach, whatever we come up with as a
> SoC vendor gets used usually without further modification by the OEMs,
> when OEMs do change things we have no visibility into anyway.

This doesn't really sound terribly unusual frankly, which means it
shouldn't be insurmountable.  It also doesn't sound like a great
approach to base ABIs around.

> We have a boot loader that goes into great lengths to tailor the FDT
> blob passed to the kernel to account for board-specific variations, PCIe
> voltage regulators being just one of those variations. This is usually
> how we quirk and deal with any board specific details, so I fail to
> understand what you mean by "quirks that match a common pattern".

If more than one board needs the same accomodation, for example if it's
common for a reset line to be GPIO controlled, then a common property
could be used by many different boards rather than requiring each
individual board to have board specific code.  This is on some level
what most DT properties boil down to.

> Also, I don't believe other vendors are quite as concerned with
> conserving power as we are, it could be that they are just better at it
> through different ways, or we have a particular sensitivity to the subject.

I'm fairly sure that for example phone vendors pay a bit of attention to
power consumption.

> > If there are generic quirks that match a common pattern seen in a lot of
> > board then properties can be defined for those, this is in fact the
> > common case.  This is no reason to just shove in some random thing that
> > doesn't describe the hardware, that's a great way to end up stuck with
> > an ABI that is fragile and difficult to understand or improve.

> I would argue that at least 2 out of the 4 supplies proposed do describe
> hardware signals. The latter two are more abstract to say the least,
> however I believe it is done that way because they are composite
> supplies controlling both the 12V and 3.3V supplies coming into a PCIe
> device (Jim is that right?). So how do we call the latter supply then?
> vpcie12v3v...-supply?

The binding for a consumer should reflect what's going into that
consumer, this means that if you have 12V and 3.3V supplies then the
device should have two distinct supplies for that.  The device binding
should not change based on how those supplies are provided or any
relationship between the supplies outside the device, there should
definitely be no reason to define any new supplies for this purpose -
that would reflect a fundamental misunderstanding of the abstractions in
the API.

If (as it sounds) you've got systems with two supplies with GPIO enables
controlled by a single GPIO then you should just describe that directly
in device tree, this is quite common and there is support in there
already for identifying and reference counting the shared GPIO in that
case.

> > Potentially some of these things should be being handled in the bindings
> > and drivers drivers for the relevant PCI devices rather than in the PCI
> > controller.

> The description and device tree binding can be and should be in a PCI
> device binding rather than pci-bus.yaml.

Well, it's a bit of a shared responsibility where the thing being
provided is a standards conforming connector rather than there being an
embedded device with much more potential for variation.

> The handling however goes back to the chicken and egg situation that we
> talked about multiple times before: no supply -> no link UP -> no
> enumeration -> no PCI device, therefore no driver can have a chance to
> control the regulator. These are not hotplug capable systems by the way,
> but even if they were, we would still run into the same problem. Given
> that most reference boards do have mechanical connectors that people can
> plug random devices into, we cannot provide a compatible string
> containing the PCI vendor/device ID ahead of time because we don't know
> what will be plugged in. In the case of a MCM, we would, but then we
> only solved about 15% of the boards we need to support, so we have not
> really progressed much.

I would expect it's possible to make a PCI binding for a standard
physical layer bus connection as part of the generic PCI bindings, for
example by using some standard invalid ID for the device ID that can't
exist in a physical system or just omitting the device ID.  That seems
like a fairly clear case of being able to describe actual hardware that
physically exists - you can see the physical socket on the board.

> > In any case whatever gets done needs to be documented in the bindings
> > documents.

> Is not that what patch #1 does?

It just updated the example, it didn't document any new properties.  The
standard supplies are documented in the patch to the core standard that
was referenced so they're fine but not the extra Broadcom specific ones
that I've raised concerns with.

--gDFq9v3imEYJoQxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF4ARgACgkQJNaLcl1U
h9BKWAf/RCzQQJ5dg/BIDAAzLJyI3ncPdc8Q0uGqF2RUSCAIB5ebCQggNoN+koOG
T85DeEL9jcnOuSOrKd4wS6/wxVn6hwLjFdO3PnXws6yIh4b/QcD5ZLviXxHrmv1y
cKcViwvCRdz+rR71nls+fOfyrT6oeNP+NOMM4wQ1ksAG8j447XaCgrObLI8YQp13
34Cefvn4f/nUs9TILZYv8m4YUbwT4iBrVuaUZOoNuqioRPdMxQ4aFse9C5f45pnA
qLo/VdjO59OcEQgYEpPju4HOXKx22KGGjgQ9BwABE54s3RxNT5mFAMTQ8dgDIxsd
oeDwJ7YTCjsl5SUljtOPW9/TJObNNQ==
=Cpic
-----END PGP SIGNATURE-----

--gDFq9v3imEYJoQxi--
