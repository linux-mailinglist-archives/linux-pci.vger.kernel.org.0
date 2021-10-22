Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E508437ED7
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhJVTwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 15:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232380AbhJVTwS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 15:52:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59486610FF;
        Fri, 22 Oct 2021 19:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634932201;
        bh=jwMPmB0H7xo3mn8douB10ZBq+16xN4lZpM6uy8QxG9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISgo/73wtU88GuydGF1LrZFMivJ0v9w7eDKsbF13R6rIuFKACOZniNOzVV4X4B5oz
         bhu4kLVHqflWTAxamJDBthxP69vENoXLgzwBVVenwlY5VB2KiGUc4LSaLTRBM0qnS+
         oLtgVs7jFh4gQThFUztvQKXgthAEDH9CFs0mFtyl0NuKnwfgFdi3zHNepgEFkNmfDc
         /v12+Y1rN2M6wM/L8I8tMIU8U+nTbGA5n9ZoVrAP6yI7hYKco1rgy0Mpe12wK7+P4q
         HeqEFJh6HOakH/IfNmSKPwgZ+QV4qeHYZa1PY0aSHuVfPOGGBPi4ZDmwEhZ/UTTwXE
         UsSPRZ3PRYXdg==
Date:   Fri, 22 Oct 2021 20:49:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
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
Message-ID: <YXMV5Uhe4s2mMWZn@sirena.org.uk>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-2-jim2101024@gmail.com>
 <YXLPZ4CsQMjHPpJS@sirena.org.uk>
 <CA+-6iNz3PMsYDds_uoh_xNoPop-tLn1O9U9wnTmTx+pZyN5ZFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Bye8kAx8ud+gq9M"
Content-Disposition: inline
In-Reply-To: <CA+-6iNz3PMsYDds_uoh_xNoPop-tLn1O9U9wnTmTx+pZyN5ZFA@mail.gmail.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--/Bye8kAx8ud+gq9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 22, 2021 at 03:24:50PM -0400, Jim Quinlan wrote:

> Just to be clear, and assuming that the brcm-ep-[ab] supply names are
> green-lighted by you and Rob, are you saying
> I have to update the github site or our YAML file?  If the latter, it
> seems odd to be describing
> an EP-device property in the YAML for an RC driver since the github
> site already describes the EP-device.

If you're extending the binding to have additional features beyond what
the generic binding has then I'd expect something in the device specific
binding.  This doesn't seem different to how controllers and devices for
other buses frequently add properties on top of the generic properties
for the bus.

--/Bye8kAx8ud+gq9M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFzFeUACgkQJNaLcl1U
h9Dydgf9GDlnjcoBJeK+uP0hv76ds3RnTnpYLu/UsmaibCKXoH14KBs4M4BCKT1D
yXcBk0yCXaFCFAGYfU2l1LT4V01/dFLs1SgEORIUyVYM/djKHIaSfCe2dIr+tzKH
tAYZS2wZOLKUS/2TrAk14kUO7kYbz0CsoJzbpyALO7jpVbuBY1tvJAlsTlzgNiVo
iLIb02PxJZdNC+8tD2eXLmWkEbABT5Slb3Y4U6lw61FWcpSaCreaVK04pBT6HyfK
qHgOoWG0ERaagiiEdt1i/i5/AxUKVMShDxb/SqqAZIx5HFWhMtuqza4z1sLAx6Bv
Svjh9CjaxOW9QnB+le6hZNEBIrp0IQ==
=mHsy
-----END PGP SIGNATURE-----

--/Bye8kAx8ud+gq9M--
