Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5536444923
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 20:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhKCTsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKCTsR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 15:48:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 470E960FC2;
        Wed,  3 Nov 2021 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635968741;
        bh=oQwHcJhV75tudfQz9JXIXP43sTr35k5qkbqxxjX+yiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEPxrZxNGUovzKG1LrS+HDz5/l5tZHMXk4siPp76mEGXc3nj0QBLS60Y5Sy1DCFmt
         AZ9NEd4tU+cTquvmOTbNQsjQaavLv6VxzkRuIdSyAJHbw7ELVRjL69+wsnm6aUrxvv
         eTKtqR2IF6HaomD2FIgbJdHcibP/JYH0nXf5gOO/lQ4tWZ/jh1JJDgvVxgPbz4ZKmL
         w1pLghMJ4H7mnb0CP1AzgbnuJNVtj3u52doug3GMD567ewPpxWvzLmwDm2/WN5fl2J
         pK5+EBJWMAAat+L0K2ODFqhndIozbScA55wM7QRZ3IH5P18DwmYRWd6siMdrqevrS1
         Vnb+8AOdMIXvQ==
Date:   Wed, 3 Nov 2021 19:45:35 +0000
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
Subject: Re: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <YYLm3z0MAgBK24z5@sirena.org.uk>
References: <20211103184939.45263-1-jim2101024@gmail.com>
 <20211103184939.45263-6-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Bn4OUkL+bJRmBog"
Content-Disposition: inline
In-Reply-To: <20211103184939.45263-6-jim2101024@gmail.com>
X-Cookie: Thank God I'm an atheist.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4Bn4OUkL+bJRmBog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 03, 2021 at 02:49:35PM -0400, Jim Quinlan wrote:

> +	for_each_property_of_node(dn, pp) {
> +		for (i = 0; i < ns; i++) {
> +			char prop_name[64]; /* 64 is max size of property name */
> +
> +			snprintf(prop_name, 64, "%s-supply", supplies[i]);
> +			if (strcmp(prop_name, pp->name) == 0)
> +				break;
> +		}
> +		if (i >= ns || pcie->num_supplies >= ARRAY_SIZE(supplies))
> +			continue;
> +
> +		pcie->supplies[pcie->num_supplies++].supply = supplies[i];
> +	}

Why are we doing this?  If the DT omits the supplies the framework will
provide dummy supplies so there is no need to open code handling for
supplies not being present at all in client drivers.  Just
unconditionally ask for all the supplies.

--4Bn4OUkL+bJRmBog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGC5toACgkQJNaLcl1U
h9AbFAf+IFo802ZTgImd/SOw0tU2P5NR02kU1F9YzvxpTqde6/5HYQJYWeMUGJDa
egO5QI0PCRh68Eq3wY4QCunv4kMkJW9zF3fD6xkCUD024RTFQyb2OPuCz34SSnVP
9IJ2e8fB8h7v0eSyg22SKBgzkzh6bPh8nK5KdlvNyeOoG3t+x8O1CKmvs74C8hpV
tRadkEXmR46hD6JP+KiJj4oMnREO0pA0qdhwk1E2tNlA74+teWapp0tU9nW7vXb8
805+lD1BTiuq3hYLrxWuio/CFznhUqStn8gibTWTeiwSdcE/s1JP8uRmpE0Gv3X0
6bsCS1K7SyqqIte2HSRbv0Qj8p8eIg==
=MzLw
-----END PGP SIGNATURE-----

--4Bn4OUkL+bJRmBog--
