Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9134D50B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 18:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhC2Q0I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 12:26:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhC2QZv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 12:25:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AF7B61581;
        Mon, 29 Mar 2021 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617035150;
        bh=0EVKIiaOtq/to7gLMb+86TA0gHr/tQAEYRLHHbsUC4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8n7uTHJAzUPRPgnVpR4K0N/kMlliRnLSRKWy6KhDNOzF829VOIgvOe9T+BCj3jjP
         jz8zB+7Ivw/ZUFmYSsIP+X+eeBW8dIJsasmp/3xsma2a20qGgCAnBK4eLNJF08a1cG
         wLJftFjH1NkjqE+/KxM8YTYd88UTFSkTlEkqpRfbkueBFk1Zlz8/VjjTe6OMPErzAt
         z5TD/HEVt2NsLPHtstMjNRzuD/+wOFRIv0BHAeWh1NryfF+NLmz1RQ8asFU/DhGizu
         jP4oZ4ikSmfupZDKqLSksdKBHp+83013DvpGP+/Z5WfGNsQsOyd/8V7OMkFLVulslV
         OsP3BgT2iUWpg==
Date:   Mon, 29 Mar 2021 17:25:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
Message-ID: <20210329162539.GG5166@sirena.org.uk>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <20210326191906.43567-3-jim2101024@gmail.com>
X-Cookie: Never give an inch!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 26, 2021 at 03:19:00PM -0400, Jim Quinlan wrote:

> +		/* Now look for regulator supply properties */
> +		for_each_property_of_node(child, pp) {
> +			int i, n = strnlen(pp->name, max_name_len);
> +
> +			if (n <= 7 || strncmp("-supply", &pp->name[n - 7], 7))
> +				continue;

Here you are figuring out a device local supply name...

> +	/*
> +	 * Get the regulators that the EP devices require.  We cannot use
> +	 * pcie->dev as the device argument in regulator_bulk_get() since
> +	 * it will not find the regulators.  Instead, use NULL and the
> +	 * regulators are looked up by their name.
> +	 */
> +	return regulator_bulk_get(NULL, pcie->num_supplies, pcie->supplies);

...and here you are trying to look up that device local name in the
global namespace.  That's not going to work well, the global names that
supplies are labelled with may be completely different to what the chip
designer called them and there could easily be naming collisions between
different chips.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBh/4MACgkQJNaLcl1U
h9CBWAf+I2BBpKEnzXlvB4wE7J2QCR2XiA+uopR9ffHtsAi0kV5enhrdLXrr4Bm+
N6a0ro57hzySpi7sjE9wgqzkktaD+BnnQMhY3kma9bTZ67uWeZLrrVZKArL8GI7f
DgYy+oiPVeshhMaBQSGg3TsiTf/cNFi4F5VskQqh4vf+FNk/gl4sHmdwypaSSLj6
7LUlrIprc0qrBsieHlp99bLM1eKlVLZqFOskRLjnGfT6OPh/2+qYMjzJDJfry3ED
b3FG3h0dDvC0tp1EF2tnZH183OJrgvA+UShr8nukUi2g/HzeF9pInvNZ4pVnwklI
Cdi96b6gs3qmRccjIlLWyJjsqxDO8w==
=Z7jE
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--
