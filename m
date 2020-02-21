Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCBD168483
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBURLa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 12:11:30 -0500
Received: from foss.arm.com ([217.140.110.172]:43978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgBURLa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 12:11:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52BA730E;
        Fri, 21 Feb 2020 09:11:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA313F68F;
        Fri, 21 Feb 2020 09:11:28 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:11:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
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
        linux-pci@vger.kernel.org, Jim Quinlan <james.quinlan@Broadcom.com>
Subject: Re: [PATCH v2 1/2] PCI: brcmstb: Add regulator support
Message-ID: <20200221171127.GH5546@sirena.org.uk>
References: <20200221033640.55163-1-jaedon.shin@gmail.com>
 <20200221033640.55163-2-jaedon.shin@gmail.com>
 <20200221121231.GA5546@sirena.org.uk>
 <40c4de9c-efdc-4fae-ad6d-1ba51fbbece1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <40c4de9c-efdc-4fae-ad6d-1ba51fbbece1@gmail.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2020 at 08:33:36AM -0800, Florian Fainelli wrote:
> On 2/21/2020 4:12 AM, Mark Brown wrote:

> > No, this isn't a good idea - the set of supplies the device has is
> > fixed when the silicon is produced, it's not something that needs to
> > vary per board.  This means that the binding should have a fixed list of
> > supplies, per SoC if that's needed.

> These are not the supplies for the PCIe I/Os on the SoCs side, but the
> supplies for the PCIe end-point connected to the SoCs. More on that below.

Then the "slots" (obviously at least some of these are soldered down
rather than on actual slots) should be represented in DT and the
controller or bus should know that it needs to iterate over them to
bring up the chips.  I would also expect that there are standard names
in the PCI specs for the standard supplies that go into devices as part
of the bus spec which would mean that there should still be no need to
encode names like this.

> If you describe the regulators as properties of the PCIe EP nodes which
> are child nodes of the PCIe RC node (as we should), you will not be able
> to manage all of them within your pci_driver instance, because if there
> is no power to the EP you just do not enumerate it, therefore no
> pci_device is created.

The framework and/or driver can enumerate firmware information without
actually powering up the devices of course.

I would not be surprised to learn that most systems just mark the device
supplies always on, it's not like the devices will be able to use them
normally anyway.

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5QDz4ACgkQJNaLcl1U
h9D7MQf/YeQ1FAZw9dB7Kfcm1KJh5ahq4yucqHlg1gPLoilrZyl49an8LGVphqrg
xaSJ/iWvuoiYz9WkG8/18my3ckt8bdexU8rsw3FJOvljJxY4bL4caT9uRovqO/Gx
8aYf2FGDqaTWNA5MWDRHYP4vS6OSlu2Dq8QZAp8B4nII2XP+Y+FHi0X+oLGAsSub
owUznmwx0P/KsCEhWJP722VTq1+il5WrZZnqgE4Qvf9EtIwvBgz5EA+GVqWG+QGT
9qep25/GEqCx/kfgVzYvldCdzezJc7T43T8bNMrDNyRF7g2wQFoPy4aX/Tn8QL4v
t1AWpMfPlRi8XT/pENcm0eEBl5aRQg==
=GtTF
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
