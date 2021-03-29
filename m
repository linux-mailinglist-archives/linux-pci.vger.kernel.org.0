Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BBB34D946
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhC2Uq0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 16:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231134AbhC2Upy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 16:45:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00E9861924;
        Mon, 29 Mar 2021 20:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617050754;
        bh=Tn6txlmT/d5Y6cdWpSK86evJAyAI5ibaFDr8ZhPHJ7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilUFPx4hc92t2Aj4EYfhXwfBLx9FIgfYhx08XN4s09fLHol3ENfrlglaL1lCfsKaE
         QBBft64uV6XYkBYaIVasY9QFVUV0Ysk2k/5cHBw+UuGX3E8iOTAl6TOASLulPINCNu
         NegRpZT1iGQaUWL6fDINp2rePSxHQeySAt6qyuOufxvqzuqTNYd64lPcqcFIKTvAhs
         fi+JyNlIHBXJpL+ocTnGeKCtU/4NqjHv2OrL3JhRyBLMi2GShp23yJ/5C2fo+rOcLg
         QkEV5uVt+e1NL3alss/vkRHLGWAmLOWZ5BwgiZ4J931YIcStCVo55Etf9VKzFkBDO0
         NdTMOLu6/6l8A==
Date:   Mon, 29 Mar 2021 21:45:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
Message-ID: <20210329204543.GJ5166@sirena.org.uk>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-3-jim2101024@gmail.com>
 <20210329162539.GG5166@sirena.org.uk>
 <CANCKTBsBNhwG8VQQAQfAfw9jaWLkT+yYJ0oG-HBhA9xiO+jLvA@mail.gmail.com>
 <20210329171613.GI5166@sirena.org.uk>
 <CANCKTBvwWdVgjgTf620KqaAyyMwPkRgO3FHOqs_Gen+bnYTJFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <CANCKTBvwWdVgjgTf620KqaAyyMwPkRgO3FHOqs_Gen+bnYTJFw@mail.gmail.com>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 03:48:46PM -0400, Jim Quinlan wrote:

> I'm not concerned about a namespace collision and I don't think you
> should be concerned either.  First, this driver is for Broadcom STB
> PCIe chips and boards, and we also deliver the DT to the customers.
> We typically do not have any other regulators in the DT besides the
> ones I am proposing.  For example, the 7216 SOC DT has 0 other

You may not describe these regulators in the DT but you must have other
regulators in your system, most devices need power to operate.  In any
case "this works for me with my DT on my system and nobody will ever
change our reference design" isn't really a great approach, frankly it's
not a claim I entirely believe and even if it turns out to be true for
your systems if we establish this as being how regulators work for
soldered down PCI devices everyone else is going to want to do the same
thing, most likely making the same claims for how much control they have
over the systems things will run on.

> regulators -- no namespace collision possible.  Our DT-generating
> scripts also flag namespace issues.  I admit that this driver is also
> used by RPi chips, but I can easily exclude this feature from the RPI
> if Nicolas has any objection.

That's certainly an issue, obviously the RPI is the sort of system where
I'd imagine this would be particularly useful.

> Further, if you want, I can restrict the search to the two regulators
> I am proposing to add to pci-bus.yaml:  "vpcie12v-supply" and
> "vpcie3v3-supply".

No, that doesn't help - what happens if someone uses separate regulators
for different PCI devices?  The reason the supplies are device namespaced
is that each device can look up it's own supplies and label them how it
wants without reference to anything else on the board.  Alternatively
what happens if some device has another supply it needs to power on (eg,
something that wants a clean LDO output for analogue use)?

> Is the above enough to alleviate your concerns about global namespace collision?

Not really.  TBH it looks like this driver is keeping the regulators
enabled all the time except for suspend and resume anyway, if that's all
that's going on I'd have thought that you wouldn't need any explicit
management in the driver anyway?  Just mark the regualtors as always on
and set up an appropriate suspend mode configuration and everything
should work without the drivers doing anything.  Unless your PMIC isn't
able to provide separate suspend mode configuration for the regulators?

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBiPHYACgkQJNaLcl1U
h9DcTgf+OZsWq4Kiw9u8jT0Zh0uDMR6gGhzcyfOahqmUWp9hC1kN/GHXDI3w4TeJ
hP0LpX8fmakwqDIpzcznWQlCXP/ugmDG4NUXvYUdZuXA2eVLtjLJBBDOLR1OLp/b
qVagVEC1Mj56FjMqlM2a76+DEj9q3l0MbYPlEldMKuxv3PeAK2QswG2jfJkITImg
Ab9UhzhJb7ocDfTcgxOEyYhzhFWppAJrJZ+ZprHqDktAJAz9g6SP/kzAWNM+/X33
iXmxoro4y4Ri2cRoZWLZRlFaQqSraj0ayRuTMebWd0FCUlG6eaiFGUYNc52+jHdy
yaHM7wnjraDdfm4WS1wVzjHh+I0YDA==
=rc28
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
