Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9C15D6EC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 12:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgBNLw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 06:52:27 -0500
Received: from foss.arm.com ([217.140.110.172]:60182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbgBNLw0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7F61FB;
        Fri, 14 Feb 2020 03:52:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226523F68F;
        Fri, 14 Feb 2020 03:52:24 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:52:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: brcmstb: Add regulator support
Message-ID: <20200214115223.GD4827@sirena.org.uk>
References: <20200213025930.27943-1-jaedon.shin@gmail.com>
 <20200213025930.27943-3-jaedon.shin@gmail.com>
 <CACRpkdZ9A_SJzxQ__f0oani+A97N3yLT3=oJ8z3vNJ5Ucyo8vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline
In-Reply-To: <CACRpkdZ9A_SJzxQ__f0oani+A97N3yLT3=oJ8z3vNJ5Ucyo8vA@mail.gmail.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 11:06:51AM +0100, Linus Walleij wrote:

> So what this does is just grab any regulators, no matter what they are
> named, and enable them? The swiss army knife used is the raw
> of_* parsing functions.

> I don't think that is very good practice.

This is a really bad idea, yes.

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GifYACgkQJNaLcl1U
h9B2eAf6AlfgcXVwjWMVaMTivIUygM0+voTVyprPV7jZikrhNh9WfCEYT2rCwl7V
x3IS1o4VC/DoWKAmIDRDoBWQtV/PAjcpZNNQKvoDgnDn2J7tw2E0z5Lv804vYYie
6t3PpH2Ej3keot9zw1ejqSXscYcDGSI9m20WQ24//GN02odOQoPJPxQy3mPCKo9o
WpjM3JuJUtxuLn5Yc5BLFRp2ExVTf1mHW7nq1ZqJnji8si5w5VEVG0G6f4xX7HDk
DyZl0KMSE/26bbZJbGLtllifM1zyjR/alO2uFht6OPmCgAV0vJGY89PPpsIhUngb
GfyDJRsCr9Q2PiyhC0U1hAliTG9V2A==
=vGa9
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
