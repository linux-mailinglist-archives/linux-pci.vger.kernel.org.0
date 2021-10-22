Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19C437ECF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhJVTtn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 15:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232291AbhJVTtn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 15:49:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6C1C6054F;
        Fri, 22 Oct 2021 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634932045;
        bh=elylJ5DK71Sd3YVpxunlz+xGpKaVn2wMbBAxU/va2o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8HqeFePwlc4fnnseqePAzUxdq1pw7MQtR2B/h6KZGC9SiBkH6zb/3JU74UkQbRxx
         teKkwL6v+HybfBazbznSb/OdvLjfzqBJl4rJJ3j0DJA8ibSgvA9sLpSVQG9sxTggCk
         OiS0veFA0kcfGIUgn7IDKNdRwiwfCDxJ8NeJIJDjm6/fHPkClc+dEzfGYhcagH9J4f
         EAVW1WYly/cJFB2PIMEiYrCH/1twjIGTOhLupA5Fu4begjRRqshekSO9QS7ad2rGg+
         faLNSVswu0ToC90QGxJvXH6nQPtAfuhpvSeNuSbZGwgf0Z/61bixtM+zXCoNMCjWFj
         A1vcYPC00G+aA==
Date:   Fri, 22 Oct 2021 20:47:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <YXMVSVpeC1Kqsg5x@sirena.org.uk>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk>
 <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/HP9my2BKYsQFs5z"
Content-Disposition: inline
In-Reply-To: <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--/HP9my2BKYsQFs5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 22, 2021 at 03:15:59PM -0400, Jim Quinlan wrote:

> Each different SOC./board we deal with may present different ways of
> making the EP device power on.  We are using
> an abstraction name "brcm-ep-a"  to represent some required regulator
> to make the EP  work for a specific board.  The RC
> driver cannot hard code a descriptive name as it must work for all
> boards designed by us, others, and third parties.
> The EP driver also doesn't know  or care about the regulator name, and
> this driver is often closed source and often immutable.  The EP
> device itself may come from Brcm, a third party,  or sometimes a competitor.

> Basically, we find using a generic name such as "brcm-ep-a-supply"
> quite handy and many of our customers embrace this feature.
> I know that Rob was initially against such a generic name, but I
> vaguely remember him seeing some merit to this, perhaps a tiny bit :-)
> Or my memory is shot, which could very well be the case.

That sounds like it just shouldn't be a regulator at all, perhaps the
board happens to need a regulator there but perhaps it needs a clock,
GPIO or some specific sequence of actions.  It sounds like you need some
sort of quirking mechanism to cope with individual boards with board
specific bindings.

I'd suggest as a first pass omitting this and then looking at some
actual systems later when working out how to support them, no sense in
getting the main thing held up by difficult edge cases.

> > > +     /* This is for Broadcom STB/CM chips only */
> > > +     if (pcie->type == BCM2711)
> > > +             return 0;

> > It is a relief that other chips have managed to work out how to avoid
> > requiring power.

> I'm not sure that the other Broadcom groups have our customers, our
> customers' requirements, and the amount and variation of boards that
> run our PCIe driver on the SOC.

Sure, but equally they might (even if they didn't spot it yet) and in
general it's safer to err on the side of describing the hardware so we
can use that information later.

--/HP9my2BKYsQFs5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFzFUgACgkQJNaLcl1U
h9CPbAf5AVRviOjhrMlt1aIvh3qkAFN8NkUZHgZBQPGwUahIDnxp+i29MMtN1EeA
RqnOwIlsoDbAybJGGG07q1nfLST16wGxF29Ohunl+grK9vnPrPQjvM+SGC+YMqBW
4IoTaOtrWzLOZJMNKu/hEIZ4GJg2lK/yczvN+bEy1c2r+FXOvkz6sz3O8HuJIVWo
Ig3asBtnmrtjG4fboMjP8EiK0fOaZ9G+pzOgXYRHpKUsCrARrq+ZPnE652ZNyeIR
X+UGa5X5Du8E0B/9fr3EJw1jKkYCgonZwHPKzJPWr5IzAw35h9jl7M26otE6y8X/
Lh6SPgA1sZftF8kVE0QnHE0xZUjJQQ==
=pd7f
-----END PGP SIGNATURE-----

--/HP9my2BKYsQFs5z--
