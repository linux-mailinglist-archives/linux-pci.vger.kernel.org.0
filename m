Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CADC3EB94A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhHMPba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 11:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236719AbhHMPba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 11:31:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3121660EFE;
        Fri, 13 Aug 2021 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628868663;
        bh=JwwGuM2BqIZs9zpC6YK9XxufVemngqiGneP+sZSA5EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nY+lSNQfv/TGRqXFuBK6yyZ+uB+4HSKjc/j9LO6e58ZoSk14cW/PUEQNjB5DLvLhN
         lMhrIUjU/WuzgPgUU6//eeGHdLehuYWzFyVKlqQlvqK0zwN4Nj1FvtXYUP4fTqPt3i
         to1skHlqSY4vjJrIVdPn5AArct8g1S6Qoq8rLlD4yPGEUhdqNoDSU9Vd930ZB8+keI
         x8AdZ/iwxMZWnG6JUYDnHDzxlMTmlWHYZ8IZc0UOquPLKMwHY/Gkx9skO4wLDHtNU4
         OQDQ5X+H9Wn/Ask4Ayu162cwaIIPmc1OfTzU0RomfWNpzzxgAYqoWxqH5EHXTfskEd
         xSlpw2OeXKg2w==
Date:   Fri, 13 Aug 2021 16:30:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference
 in probe
Message-ID: <20210813153043.GB5209@sirena.org.uk>
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <20210813135412.GA7722@kadam>
 <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
 <20210813143250.GA5209@sirena.org.uk>
 <566c26bb-c488-8c86-f47e-6a748b9b6c77@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <566c26bb-c488-8c86-f47e-6a748b9b6c77@arm.com>
X-Cookie: E Pluribus Unix
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 13, 2021 at 04:00:45PM +0100, Robin Murphy wrote:
> On 2021-08-13 15:32, Mark Brown wrote:

> > It also encourages *really* bad practice with error handling, and in
> > general there are few use cases for optional regulators where there's
> > not some other actions that need to be taken in the case where the
> > supply isn't there (elimintating some operating points or features,
> > reconfiguring power internally and so on).  If we genuninely don't need
> > to do anything special one wonders why we're trying to turn the power on
> > in the first place.

> Sure, once you get into it, regulators are arguably a rather deeper area
> than GPIOs, so in terms of the NULL-safe aspect anything beyond
> enable/disable - for the sake of keeping trivial usage simple - would be
> pretty questionable for sure.

enable and disable are among my biggest worries frankly, if the device
was supposed to have power and that didn't work then there's probably
some kind of issue.

> A lot of the usage of regulator_get_optional() seems to be just making sure
> some external thing is powered between probe() and remove() if it's not
> hard-wired already, so maybe something like a
> devm_regulator_get_optional_enabled() could be an answer to that argument
> without even touching the underlying API.

I'm fairly sure a lot of the regulator_get_optional() usage is just
abuse of the API, every so often I get fed up enough to send patches
converting users that look like you describe to normal regulator API
calls.  People really don't get the dummy regulator stuff and seem to
think that _get_optional() is what you use to avoid writing any error
handling code :(

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEWkCIACgkQJNaLcl1U
h9A88Af/fCT+eznJ+OGWktrk7Ss4jZUVj0ZLLoXhrm38qQ1Sm9WRQr1d4TETmjlY
L6xIUzkJae36oARdmMDMBCOHytAdCL5Lu55IkKXcISEWFqGJB3Yi5Ea3ddW2F03H
zHXEo0Pcn8OXoipdFM/LYNVYy3YqAlhPWFCA4fVw2w95RBj4R477UF+Vd7LLaP8x
8xriyUuvHtZ7Kh56e3kBvtBxxQkzR+aOoLPI/bj0gapS7PIOOuLfrltPB3fRyb65
7oXj276oOT7SmYeLVkAPQxbtEcMrHwPFKB7LoAZcTTdsVu69QsNEPjQzrTyYzLnl
ZtjyaaqarWXZHcu1tJKDUQqN8evk/Q==
=b8Pd
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
