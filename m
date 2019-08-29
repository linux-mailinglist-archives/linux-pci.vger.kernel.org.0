Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F205A22D7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 19:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfH2Rzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 13:55:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfH2Rzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 13:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5b1z3wsMTj6Fc0lCxdaYS1Ks0PpSv86VRBGLPfw0HTo=; b=dnEOfDfHintJMltKgJoddaMu6
        ioCR1afN3JjTsGTxFg10Tz6KSWC0rqPbU0+mr8l43DGdUERjFA9aS/U68ihA7aguWJ34SVYvu2EvR
        78DuzgSoMctut6z/EKUiiCqevjSNGZKuNDCJywN4rh0egZ2Vf42G0+mpc6UsbFSo0/jYI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3Odx-0002hV-Ve; Thu, 29 Aug 2019 17:55:34 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C568327428D1; Thu, 29 Aug 2019 18:55:32 +0100 (BST)
Date:   Thu, 29 Aug 2019 18:55:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829175532.GH4118@sirena.co.uk>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
 <20190829114603.GB13187@ulmo>
 <20190829130323.GE4118@sirena.co.uk>
 <20190829145820.GB19842@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline
In-Reply-To: <20190829145820.GB19842@ulmo>
X-Cookie: Lensmen eat Jedi for breakfast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2019 at 04:58:20PM +0200, Thierry Reding wrote:

> However, the same PCI controller can also be used with onboard devices
> where no standard 3.3 V and 12 V need to be supplied (as in the PCIe
> slot case above). Instead there are usually different power supplies
> to power the device. Also, since these supplies are usually required to
> bring the device up and make it detectable on the PCI bus, these
> supplies are typically always on. Also, since the PCI controller is not
> the consumer of the power supplies, it's impossible to specify which
> supplies exactly are needed by the device (they'd have to be described
> by a binding for these devices, but drivers couldn't be requesting them
> because without the supplies being enabled the device would never show
> up on the PCI bus and the driver would never bind).

These on board devices that might have non-standard supplies are more of
a problem as you say.  This is a general problem with enumerable buses
that get deployed in embedded contexts, things like clocks and GPIOs can
also be required for enumeration.  Ideally we'd have some pre-probe
callback that could sort these things out but that's core device model
work I've never found the time/enthusiasm to work on.  IIRC there is
already a PCI binding for DT so I guess we could do something like say
it's up to the driver for the PCI device and just call probe() even
without enumeration and require the device to power things up but that
feels very messy.

> Do you think those 3.3 V and 12 V regulators would qualify for use of
> the regulator_get_optional() API? Because in the case where the PCIe
> controller doesn't drive a PCIe slot, the 3.3 V and 12 V supplies really
> are not there.

It doesn't fill me with joy.  I think the main thing is working out
where to attach the supply.

The cleanest and most idiomatic thing from a regulator perspective for
the physical slots would be for the supplies to be attached to the PCI
slot rather than the controller in the DT, even though they will get
driven by the controller driver in practice.  This would mean that
controllers would have optional slot objects with mandatory regulators,
the controller would then have to cope with powering the slot up before
enumerating it but would be able to power it off if nothing's plugged in
and save a bit of power, it also copes with the case where individual
slots have separately controllable power.  I'm not sure how this plays
more generally but since the slots are a physical thing you can point to
on the board it doesn't seem unreasonable.  Every time I see these
supplies attached to the controller for a bus it always feels a bit
wrong, especially in interactions with soldered down devices.

That feels cleaner than saying that the controller has a couple of
optional supplies, it plays a bit better with soldered down devices and
with slots having distinct supplies and it generally feels a bit more
consistent.  I'm not super sure I'm *happy* with this approach though,
it feels a bit awkward with the device model.

> > When I say users shouldn't be using this API I mean _get_optional()
> > specifically.

> True, even if the regulator is specified as optional in the bindings,
> using regulator_get() would effectively make it optional for the driver
> given that it returns the dummy.

Unless the hardware can genuinely cope with there being literally no
power supply there (as opposed to some fixed voltage thing) it probably
shouldn't be specifying the supply as optional in the bindings either :/

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1oEZMACgkQJNaLcl1U
h9BYzAgAg/2U6Vux/AUotH/WL8pVV3YWMdZrTT3k59KAYmok8Tl95Bu4/b1Ye0C9
+PvYiued7lIerUAY3NBzocN+20kqV6MKiy0KikRkKHXLx04V3BB41NCZibjoRM1s
pXESEq2UhuaOdrvTxR/6hokISkaO1knJP90U0t9mepqkweEcHBQHEk1IWC+PoFG1
JQOYFDz8zXdACLIKYU0+CXCQxJ8jW1JN5dnCV7G9zAij+2/PVJjRIbw3w2kxQT6O
tENzrsZuNeKzggvvDUnzD8YNrctEeIg4Ke11NfYPxcyAGXxBYKPzGRs+g263j7rG
VTbwTOKAKEFqArxOlgCK83zml9DisQ==
=lz1a
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--
