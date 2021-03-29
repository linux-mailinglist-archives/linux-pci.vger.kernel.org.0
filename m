Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0234D5E2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 19:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhC2RQi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 13:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhC2RQZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 13:16:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D5C66192C;
        Mon, 29 Mar 2021 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617038185;
        bh=lOk2rEpOBpmcphuPTnLaYGl/F2yce+3XWy8O2WeWrLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mH1go9hmGq6rFQJXrykFffRlR5xbIrdEHI+q0sevwDLEOnC1tz8apgB9ANemB05J2
         Fs38WiXXMS1oaK5QkZMnFcUWSGssuNhPvwdhyOcFNQkZejLHhMyz8DTUR7zkYU/bzx
         hzou/tnxu0IB1VSf4unI80Xyy9Bo+FwJ/MTDLbsafyk/z04oFhnzs8vcA18gV4AsVp
         VgPqABCtUUGNIDDPDAHeKjGbeWArRyMAUPQ4gcDyDGfYx13IAncmYtiVNZKQeo1yvR
         Kh3wGxNkHY4sCI3+uKWpQAf5VH8tYM9pz8Fj1Ho2DUNJ9L2hQWFkkNATpKxnpvCZzM
         1zcpBPMEK9PXQ==
Date:   Mon, 29 Mar 2021 18:16:13 +0100
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
Message-ID: <20210329171613.GI5166@sirena.org.uk>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-3-jim2101024@gmail.com>
 <20210329162539.GG5166@sirena.org.uk>
 <CANCKTBsBNhwG8VQQAQfAfw9jaWLkT+yYJ0oG-HBhA9xiO+jLvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <CANCKTBsBNhwG8VQQAQfAfw9jaWLkT+yYJ0oG-HBhA9xiO+jLvA@mail.gmail.com>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 12:39:50PM -0400, Jim Quinlan wrote:
> On Mon, Mar 29, 2021 at 12:25 PM Mark Brown <broonie@kernel.org>

> > Here you are figuring out a device local supply name...

> > > +     /*
> > > +      * Get the regulators that the EP devianswerces require.  We cannot use
> > > +      * pcie->dev as the device argument in regulator_bulk_get() since
> > > +      * it will not find the regulators.  Instead, use NULL and the
> > > +      * regulators are looked up by their name.
> > > +      */
> > > +     return regulator_bulk_get(NULL, pcie->num_supplies, pcie->supplies);

> > ...and here you are trying to look up that device local name in the
> > global namespace.  That's not going to work well, the global names that
> > supplies are labelled with may be completely different to what the chip
> > designer called them and there could easily be naming collisions between
> > different chips.

> "devm_regulator_bulk_get(pcie->dev, ...)"; is your concern about the
> NULL for the device and if so does this fix it?  If not, what do you
> suggest that I do?

If you use the struct device for the PCIe controller then that's going
to first try the PCIe controller then the global namespace so you still
have all the same problems.  You really need to use the struct device
for the device that is being supplied not some random other struct
device you happened to find in the system.

As I said in my earlier reply I think either the driver core or PCI
needs something like Soundwire has which lets it create struct devices
for things that have been enumerated via software but not enumerated by
hardware and a callback or something which lets those devices take
whatever steps are needed to trigger probe.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBiC10ACgkQJNaLcl1U
h9DUJwf/VqPUciW9k3R4OCtAkqo9U5IDvuxu7r6XmO6YhMfYpZsdRQjZ7WVq2kd4
g12beRu3Qrwd9rxNX4pPNrk8QX/FdG14s5Ontfo0CczozmMfHCdMal9KjYr28Vfn
ls3Efc9obaW5PIvMXfk6D2om5EKueR171Sp3Do5HbHGap+KeZ0NTXEMmG3+n49h6
nn60OESqTZkS6tISfAWOVYx9JgCVomtWNOklGG4Bv9I1i/PZ+ta4i9/ajTFDZRCv
HC48/0pzLorlGSY04FsfQ3hXGFN1Oi332GOaJF4p0uaEKh0jNjYWdYAEpRkWG4zJ
7BX/ON0quzuXskns96Qfl7ISw89Hbw==
=+Rlm
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
