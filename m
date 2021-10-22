Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8665243790E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhJVOdy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhJVOdx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 10:33:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5225C61205;
        Fri, 22 Oct 2021 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634913094;
        bh=cfEFo3LpKlhhVZBcoudy/fAkGQElG4mDWEf7Rjtcs78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKOscxQDyqs3oAgcYmyzntTkbSA1XBC7+XDl9Xp6K1aXZdUXl19uqWb9FOir4BgcN
         wnCQIkcKWHfCzIL2kiMETvLxk57ziylaLk51GtRihGx9YXkoFrPYuYJ06CzSImOUdf
         9zS9+ezInTPs4+ySDVjgid6DcIyB8uaR266cEY2fcqSmVIslHi0/HrLADndiMzXHXY
         OU//tLacknV7S5gFXvG6tl1Wa4a9j4b2XHzeiliX6abUaISX1HQrXmBN41E+tFlvgg
         TDwyUOqEW0IG5DfGxknUBhve8vx8bkjIV0xL+89pkvmZUymEr/pVW3QM74LaEwnDyX
         LLR4B1/u/oNzA==
Date:   Fri, 22 Oct 2021 15:31:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
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
Message-ID: <YXLLRLwMG7nEwQoi@sirena.org.uk>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-5-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AM0J5V7/rxX+1iNP"
Content-Disposition: inline
In-Reply-To: <20211022140714.28767-5-jim2101024@gmail.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--AM0J5V7/rxX+1iNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 22, 2021 at 10:06:57AM -0400, Jim Quinlan wrote:

> +static const char * const supplies[] = {
> +	"vpcie3v3-supply",
> +	"vpcie3v3aux-supply",
> +	"brcm-ep-a-supply",
> +	"brcm-ep-b-supply",
> +};

Why are you including "-supply" in the names here?  That will lead to
a double -supply when we look in the DT which probably isn't what you're
looking for.

Also are you *sure* that the device has supplies with names like
"brcm-ep-a"?  That seems rather unidiomatic for electrical engineering,
the names here are supposed to correspond to the names used in the
datasheet for the part.

> +	/* This is for Broadcom STB/CM chips only */
> +	if (pcie->type == BCM2711)
> +		return 0;

It is a relief that other chips have managed to work out how to avoid
requiring power.

--AM0J5V7/rxX+1iNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFyy0MACgkQJNaLcl1U
h9D1hQf+LBOR+YjLJNeGeYxEatscR2LtzZZqMkcZMyqeV6V3e43RxwegQ2ilmKsD
GX3rKlu/xNSTyzTePj6rppuy0MSeBLyqpTIe86YJVe5U5lSr0bogIW7w1WvVDRpX
sQjA6GBzZ78kkbOdRjVTLdUDtjNKtTbmPO7dLUIZ52FxcCNsMaT1XJ3VOEaIR59z
j/lqYxr6Lqx5VSdCTCeLeQLp8CFeZPh4rYXiuaIy2APqw+6Ir9H6DfCMFxh4iCvO
464NiTAbHaJUHAJ0yysf3sNyArmjiVSOWRefyHOOuNeWEmCJsJyT8CGRrjYoMZTA
cy1CI5T2C0rY0sY8dQaE1Y30GUQ4NQ==
=7os3
-----END PGP SIGNATURE-----

--AM0J5V7/rxX+1iNP--
