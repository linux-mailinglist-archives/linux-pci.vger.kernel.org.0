Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC14F437921
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhJVOmC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233013AbhJVOmB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 10:42:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72BCD60D07;
        Fri, 22 Oct 2021 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634913584;
        bh=/kREdby2MaCygfdKmXtv6/KT9DY695k+LMG+tV5yoSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tl99Sd6byAB8L5IZBV6npXt5p8b4+EBLhjcHyTSh7HddNV6sGZkvFRQp+sWmnD4IN
         cw7IP9meud38/yObU+/rg8IypaOUlit/qAjwZ/FK4Qxxb57aYZxzazRYas9AKzfAyr
         RlW9LiK8/J11WBrRzXTDiplMP8oMWjS42vGhjF0YmO5/LtBGZPqUd3msz92+iPPonu
         V0sST3baWqo/zHRSRMXx1k75sMhuF7S6y9xrJEqgyYmEzXFUNdGX0FshzK8Z4Rg7lz
         W1BWX7vxAsZdQoYR3KWbIh2YzmdHB7DC0Ni4RHTiuI3iBWYza5JVRgjbg/xuyl9OCd
         gCpt2yF9/9+9g==
Date:   Fri, 22 Oct 2021 15:39:41 +0100
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
Subject: Re: [PATCH v5 5/6] PCI: brcmstb: Do not turn off regulators if EP
 can wake up
Message-ID: <YXLNLWNKkcYodqCG@sirena.org.uk>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-6-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yTwZ2hIe3b8xECR7"
Content-Disposition: inline
In-Reply-To: <20211022140714.28767-6-jim2101024@gmail.com>
X-Cookie: I program, therefore I am.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--yTwZ2hIe3b8xECR7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 22, 2021 at 10:06:58AM -0400, Jim Quinlan wrote:

> +enum {
> +	TURN_OFF,		/* Turn regulators off, unless an EP is wakeup-capable */
> +	TURN_OFF_ALWAYS,	/* Turn regulators off, no exceptions */
> +	TURN_ON,		/* Turn regulators on, unless pcie->ep_wakeup_capable */
> +};
> +
> +static int brcm_set_regulators(struct brcm_pcie *pcie, int how)
> +{
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);

I can't help but think this would be easier to follow as multiple
functions, there is very little code sharing between the different
paths especially the on and off paths.

>  	if (pcie->num_supplies) {
> -		(void)brcm_set_regulators(pcie, false);
> +		(void)brcm_set_regulators(pcie, TURN_OFF_ALWAYS);

I should've mentioned this on the earlier path but it's not normal Linux
style to cast return values to void and looks worrying.

--yTwZ2hIe3b8xECR7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFyzSwACgkQJNaLcl1U
h9DBjAf+PZR0u4N6c3p1sLXU1e2ON+D7/zlUOuPGgmz6JyEPGjvDkpAk9+D0RiAP
TvKQFkBm7UBBWvpbucKXL/FsthSc0DRCnGtztqSEzl6wR7JWlysEPMvb5WHv/XyN
tdGTixfTJfeGxHfpyb//6NIz+CmjlZxihZ6FMEpcLM7B9J8u3KVNT24+43rY44h5
TT7bRAsFa3zbwf4V87BnpcZHi6YrhySSfIoq0UJIuncY1iOPAEl9hKY/WknLYJ6l
LdBXXmZeW7PRB+VPJeNNVn7rSxp55S36Cp24iRfWemJyqB304cxTKRpCxznEoVK/
YoA7AUMxZFbLFMNBxhHXEtT2wwz5Uw==
=9vkN
-----END PGP SIGNATURE-----

--yTwZ2hIe3b8xECR7--
