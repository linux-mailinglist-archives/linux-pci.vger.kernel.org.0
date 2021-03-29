Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223B734D98D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhC2Vbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 17:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhC2Vbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 17:31:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16C2661987;
        Mon, 29 Mar 2021 21:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617053496;
        bh=8ghVlDWkzL0HiWRkkw2+JJFtOaLFpyBnexad2aWMoYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwuYLQes1JJrvn7+77m7Vfeh4h3B/sr5B71bKCq4je3izd9m/Mmf3118e8VERoKce
         9BARcFZxMUU8jSnUgQzaNpkk32WbzFhkLP2/qEy7EPw3rton/m9Dkf+T7aF3EXFqJ8
         hOjHRDNKGlxUlV1tTJSGmSftRet8OejhBl/7Lx1umA8XdH+CScdoF+hp6d71kSh9NF
         9LwE6P8R/iEu8y2Kq6jyz9JHBItkhYFMyh6e/+y2yEFNjUr8NcmP/pHPrInD4nvTuH
         0ZETd5C+IjpeR4w0vWFT+i+G5IjqJAEadRwPry00OeAdAWFGA9ZXqroIDXc+sV2pOL
         yfSQ206wBLAPQ==
Date:   Mon, 29 Mar 2021 22:31:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
Message-ID: <20210329213125.GK5166@sirena.org.uk>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-3-jim2101024@gmail.com>
 <20210329162539.GG5166@sirena.org.uk>
 <CANCKTBsBNhwG8VQQAQfAfw9jaWLkT+yYJ0oG-HBhA9xiO+jLvA@mail.gmail.com>
 <20210329171613.GI5166@sirena.org.uk>
 <CANCKTBvwWdVgjgTf620KqaAyyMwPkRgO3FHOqs_Gen+bnYTJFw@mail.gmail.com>
 <20210329204543.GJ5166@sirena.org.uk>
 <e364818a-daa3-7313-3ad2-41dbe6e5be62@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tv3+oRj6D9L8lW+H"
Content-Disposition: inline
In-Reply-To: <e364818a-daa3-7313-3ad2-41dbe6e5be62@gmail.com>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Tv3+oRj6D9L8lW+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 02:09:58PM -0700, Florian Fainelli wrote:
> On 3/29/21 1:45 PM, Mark Brown wrote:

> > management in the driver anyway?  Just mark the regualtors as always on
> > and set up an appropriate suspend mode configuration and everything
> > should work without the drivers doing anything.  Unless your PMIC isn't
> > able to provide separate suspend mode configuration for the regulators?

> We have typically GPIO-controlled and PMIC (via SCMI) controlled
> regulators. During PCIe enumeration we need these regulators turned on
> to be successful in training the PCIe link and discover the end-point
> attached, so there an always on regulator would work.

> When we enter a system suspend state however there are really two cases:

> - the end-point supports Wake-on (typically wake-on-WLAN) and we need
> its power supplied kept on to support that

> - the end-point does not support or participate in any wake-up, there we
> want to turn its supplies off to save power

> How would we go about supporting such an use case with an always on
> regulator?

With a PMIC most PMICs have a system suspend mode with separate
regulator configuration for that and there's seprate regulator API
control for those, including DT bindings.  If that needs runtime
configuration for something hidden by SCMI I'd hope the SCMI regulator
stuff has facilities for that, if not then I guess a spec extension is
needed.  If you want to dynamically select if something is on during
suspend there's not really a way around regulator API support.

For a GPIO regulator you probably need something that does a disable on
the way down, assuming that the GPIO/pin controller doesn't end up
having it's own suspend mode control that ends up powering things off
anyway.  With GPIOs pinctrl on the pins rather than exposing as a
regulator might be enough.

--Tv3+oRj6D9L8lW+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBiRywACgkQJNaLcl1U
h9A9Wgf/YVc41hHYybrh8iBYOVdDtq3M8kN3ICbhU/Sqw/lFzvvHwP6Upwk2Z+e9
TDF04FrxRmLCXiWSLENBrN+RtxxqGENtz7upbWX8dyFdc/ET8ZSN6aick09KbecO
7dNwRSq+jMh1ckT3afATGi43JS1EJq9rohRYP7VbcZbcoErS3Z1rlefrJYWcGWXS
xO/zH+v0Z1EO3CsT0HmAxsoGP2ndQ7NAMlyclaNxKtuUT5LlDAJ90fsqG3h6LwDt
AlRQODfKwxkfDn8is0NnQrJLvFl8lbfngkUyezU2p66Y8M6/vtICvJ36LELTCo1c
mHQkYF0rB+mAegH37R8x1jhoBSAydw==
=RXG3
-----END PGP SIGNATURE-----

--Tv3+oRj6D9L8lW+H--
