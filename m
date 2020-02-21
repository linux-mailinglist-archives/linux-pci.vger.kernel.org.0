Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B784C1685B9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 18:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgBUR5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 12:57:08 -0500
Received: from foss.arm.com ([217.140.110.172]:44954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUR5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 12:57:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 557BE30E;
        Fri, 21 Feb 2020 09:57:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969893F6CF;
        Fri, 21 Feb 2020 09:57:06 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:57:03 +0000
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
Message-ID: <20200221175703.GJ5546@sirena.org.uk>
References: <20200221033640.55163-1-jaedon.shin@gmail.com>
 <20200221033640.55163-2-jaedon.shin@gmail.com>
 <20200221121231.GA5546@sirena.org.uk>
 <40c4de9c-efdc-4fae-ad6d-1ba51fbbece1@gmail.com>
 <20200221171127.GH5546@sirena.org.uk>
 <aff7e72b-c6d3-9d66-2726-1014a040b601@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline
In-Reply-To: <aff7e72b-c6d3-9d66-2726-1014a040b601@gmail.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2020 at 09:50:42AM -0800, Florian Fainelli wrote:
> On 2/21/20 9:11 AM, Mark Brown wrote:

> > The framework and/or driver can enumerate firmware information without
> > actually powering up the devices of course.

> The issue is not enumeration, it is ensuring that you will be able to
> establish the PCIe link with the EP. If there is no pci_device created
> because the bus scanning returned a link down, there is not much that
> can be done. Also the question is whether this logic belongs in the PCI
> bus layer or the driver.

Given that the interface with the devices is all standardized I'd have
expected it to be in the bus code as a first pass.

> > I would not be surprised to learn that most systems just mark the device
> > supplies always on, it's not like the devices will be able to use them
> > normally anyway.

> In the downstream PCIe driver which is this one is just a subset of
> until we close the gap, we have some additional logical to determine
> whether the EP device is wakeup enabled in order to leave its regulators
> turned on during system sleep so as to permit Wake-on-WLAN for instance.

Is that just using standard PCI stuff or is it custom for embedded
applications?

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5QGe8ACgkQJNaLcl1U
h9DPMgf/e4r5Gwi7L6QWp74/t0ncNlE8lT+mvnemgaNumxi8HWK/smVU+t35gvxo
dbdIrGGZLffZHrlCjmYjeVNjVLcWTFFr8XlczAjrSnbnlf1pnefF5Y+nN80hSZtR
mwQ50gnCPgM11jx7xybWdvJQczugxSG1bQnhSgi+E8wLtZi1MoGFo3NWkv1jMNr8
WcLdLgWdfAHnmhTVXYEuyxnpaO3HSDrmlQl8RGSalG/GvjrfSAjdQKVVmttjPGYc
HUgkJOLoTbNKtCMhZAQf3Y2hm8VAPuOlBkD0t1P1086I29uIctKE7LhxF553P3TR
mROjcuI9gQATJMw7UINisqe11KMyGw==
=88yz
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--
