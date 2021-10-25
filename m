Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE1E439973
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhJYPA2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 11:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233625AbhJYPA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 11:00:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10E3E604E9;
        Mon, 25 Oct 2021 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635173884;
        bh=gb12UldNAZtl5t7hheGwicUK/s4j9IP8f1k6OWDhgXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fR/FMwix5xkpmXoCSZn3rxnazjfN4HCPeswqSBqxWjuaDGL9YhYWTdoUl0If0JwaB
         QAFsBs55bmDr8Q7xzPU8ZrCq4FLpCcq72+FITK6alMcWiHl1MkQ8OpRQUE4FZMxhLv
         565tqq8ea9RHtaGBhh4oMirEx3GS3OKGS9T6yVhfCSMecbioRCdduA6K3V19sLcCId
         SLfjRySYQ64xzynrVDCweK9sxws+f4U9ary47EEYTqtgqObagxQuxpXAiTaWaH/gQu
         RPtECAuxKcF1OKufeLbuJs1D0NKBf2EGCkbES4rlJOFC2m3rFxt4kjGtBkUYdlNebD
         HM7m+9V0IbcAg==
Date:   Mon, 25 Oct 2021 15:58:01 +0100
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
Message-ID: <YXbF+VxZKkiHEu9c@sirena.org.uk>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-5-jim2101024@gmail.com>
 <YXLLRLwMG7nEwQoi@sirena.org.uk>
 <CA+-6iNzmkB5sUL6aqA6229BhxBhF3RKvGsLh0JCYQwP_2wSGaQ@mail.gmail.com>
 <YXMVSVpeC1Kqsg5x@sirena.org.uk>
 <CA+-6iNxQAekCQTJKE5L7LO6QF+UC6xnyE=XVq_7z3=4hp8ASXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PZ7THjqgWtevkGC9"
Content-Disposition: inline
In-Reply-To: <CA+-6iNxQAekCQTJKE5L7LO6QF+UC6xnyE=XVq_7z3=4hp8ASXQ@mail.gmail.com>
X-Cookie: From concentrate.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--PZ7THjqgWtevkGC9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2021 at 09:50:09AM -0400, Jim Quinlan wrote:
> On Fri, Oct 22, 2021 at 3:47 PM Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Oct 22, 2021 at 03:15:59PM -0400, Jim Quinlan wrote:

> > That sounds like it just shouldn't be a regulator at all, perhaps the
> > board happens to need a regulator there but perhaps it needs a clock,
> > GPIO or some specific sequence of actions.  It sounds like you need some
> > sort of quirking mechanism to cope with individual boards with board
> > specific bindings.

> The boards involved may have no PCIe sockets, or run the gamut of the dif=
ferent
> PCIe sockets.  They all offer gpio(s) to turn off/on their power supply(s=
) to
> make their PCIe device endpoint functional.  It is not viable to add
> new Linux quirk or DT
> code for each board.  First is the volume and variety of the boards
> that use our SOCs.. Second, is
> our lack of information/control:  often, the board is designed by one
> company (not us), and
> given to another company as the middleman, and then they want the
> features outlined
> in my aforementioned commit message.

Other vendors have plenty of variation in board design yet we still have
device trees that describe the hardware, I can't see why these systems
should be so different.  It is entirely normal for system integrators to
collaborate on this and even upstream their own code, this happens all
the time, there is no need for everything to be implemented directly the
SoC vendor. =20

If there are generic quirks that match a common pattern seen in a lot of
board then properties can be defined for those, this is in fact the
common case.  This is no reason to just shove in some random thing that
doesn't describe the hardware, that's a great way to end up stuck with
an ABI that is fragile and difficult to understand or improve.
Potentially some of these things should be being handled in the bindings
and drivers drivers for the relevant PCI devices rather than in the PCI
controller.

> > I'd suggest as a first pass omitting this and then looking at some
> > actual systems later when working out how to support them, no sense in
> > getting the main thing held up by difficult edge cases.

> These are not edge cases -- some of these are major customers.

I'm trying to help you progress the driver by decoupling things which
are causing difficulty from the simple parts so that we don't need to
keep looking at the simple bits over and over again.  If these systems
are very common or familiar then it should be fairly easy to describe
the common patterns in what they're doing.

In any case whatever gets done needs to be documented in the bindings
documents.

--PZ7THjqgWtevkGC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF2xfkACgkQJNaLcl1U
h9DheAf+Mxu124PV4wH1oj+ow8hG66wJSKOh0nDrC+4ExhTwST+cMt4GnbLhn5Dc
ztOYVBXNhqlJnZGTcgwlpq2v92bGlhSlf4aiT4UuWk4bIZq7a9arM1hsus5IdJzO
3ms8+PS+0zM9ZYepifcMOqEVRfhBCWjgcSgBjKEnOLymqjulC3yfwTldtTBxZySE
VQ8Q646fKpVBuQ+BC8pJZF3FMi0e9Rp8R92sFCKtH1my6lIcOy62EMgR2hCERp/u
yvXzZm22RoC63Tehgza5RgjtWRRvOHXes/qUuFZCIOMaVNxFN5PBK1ksa5hEgWFI
ZdqubpsSQnBf+yYc/XyU0XfDDOeVIg==
=SK4g
-----END PGP SIGNATURE-----

--PZ7THjqgWtevkGC9--
