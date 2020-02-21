Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC2167D2C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 13:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgBUMMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 07:12:34 -0500
Received: from foss.arm.com ([217.140.110.172]:37960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgBUMMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 07:12:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA44630E;
        Fri, 21 Feb 2020 04:12:33 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32C603F68F;
        Fri, 21 Feb 2020 04:12:33 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:12:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: brcmstb: Add regulator support
Message-ID: <20200221121231.GA5546@sirena.org.uk>
References: <20200221033640.55163-1-jaedon.shin@gmail.com>
 <20200221033640.55163-2-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20200221033640.55163-2-jaedon.shin@gmail.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2020 at 12:36:39PM +0900, Jaedon Shin wrote:

> +  supply-names:
> +    description: List of regulator supplies to use for PCIe
> +

No, this isn't a good idea - the set of supplies the device has is
fixed when the silicon is produced, it's not something that needs to
vary per board.  This means that the binding should have a fixed list of
supplies, per SoC if that's needed.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5PySwACgkQJNaLcl1U
h9CVWQf+O9qBCs/Lb8Xyx/Xp50BEVAE/kse9ndOMrfqxRwPtK7kvpDaBpP5neV60
5t4Q/Q6eePsRFeY5/FtSagvQb2JrXzgRpvTcMvBGrK825H5MXM/SDmG9812XzlkE
8p6lTmi5bG/SzCiFVlwKK2h4cQvCsMM9pqLtgaelPYfjovxGA0r6p6gcsB7MIU2S
5UYKgcO+3Wio0DEM7u2nWEQqjO8ql0e7COzAUOMATt7n+GD9h6NpfaS3wkexZ8PO
dz/NJ0QV9Yo/GjQ2i546feXuoeHXfpgJeIHZOb430S1c++14JhRHEezk3x49sHCL
c9nDdvFeMHQZQpLzSiioS8/X3XKitQ==
=fULJ
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
