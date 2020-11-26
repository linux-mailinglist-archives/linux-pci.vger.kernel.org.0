Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351962C533F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbgKZLti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730735AbgKZLti (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Nov 2020 06:49:38 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 115FB20678;
        Thu, 26 Nov 2020 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606391377;
        bh=9e4yaA6CcohD3sgKshLtFCqZxBH1iZur10IvEDoTtrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQty6a3tWyYqJjQviHpFGeRLxcjHF+P3k3KQ3qQlFgdR4tYRM8pK0rIU2CAvfZ/1K
         TjDnABJYCL2kXRaGxoZqnUxfEwluBH8Y+HQPPEPAyWr+oHFeRNeb9HUV59zGkoR2ju
         81uKAzFMy08X5lLFzz5Uo1vuwtvm9Isrj0S2tdNU=
Date:   Thu, 26 Nov 2020 11:49:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/6] PCI: brcmstb: Add control of EP voltage
 regulator(s)
Message-ID: <20201126114912.GA8506@sirena.org.uk>
References: <20201125192424.14440-1-james.quinlan@broadcom.com>
 <20201125192424.14440-3-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20201125192424.14440-3-james.quinlan@broadcom.com>
X-Cookie: Serving suggestion.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2020 at 02:24:19PM -0500, Jim Quinlan wrote:

> +	for (i = 0; i < PCIE_REGULATORS_MAX; i++) {
> +		ep_reg = devm_regulator_get_optional(dev, ep_regulator_names[i]);
> +		if (IS_ERR(ep_reg)) {

Does PCI allow supplies to be physically absent?  If not then the driver
shouldn't be using regulator_get_optional() and much of the code here
can be deleted.

> +static void brcm_set_regulators(struct brcm_pcie *pcie, bool on)
> +{

This is open coding the regulator bulk APIs.

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+/ljcACgkQJNaLcl1U
h9BIAAf/QqjxCH8S51N4QuGM0DaR1GewyFK4OXnt3/H++qbgzoNsOF8XLIKc/tqg
tYD1zmUpQYD44YaQ9HKIdsXUZ8LYfxL1OFgzKhi3Af6OWsG5Fp2A5VxoeWNTFAJQ
QtlbGx0eBXRurktsqrwTPTbpygjTdYTOLbmF1Mn4jKvAk8JeU6/i6UG9ozlCd0VK
qIrPLyLNkzx74vaZZUGBM5nZoiR2g9MgaQo3vSXIHJsms5yITf2eU1B43hGOU0+o
HDwViSGHWGrCXBV55A2XbPWy3FzucuOiF36EeItx8Z/H6s5UVAixsUgqlibkYFeY
LV6yhHjuY7o9jDuZj2WUVSL8ZdUHJw==
=ub0o
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
