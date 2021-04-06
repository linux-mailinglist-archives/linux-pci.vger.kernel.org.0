Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAF2355946
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 18:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhDFQfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 12:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232063AbhDFQfF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 12:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 483E0613D0;
        Tue,  6 Apr 2021 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617726896;
        bh=XdkKx3ghLIT0Ejhdj9Cvusnxkw7C1EMzq4enDuOyDew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g99Ud9NNlNe4tWGftQKH/G14uTrjkg6jlClnqz5hV7Pco+8erWyuxpynms47A7MQb
         pUTIjQxDsMD4svON52rw9HN0DvKkKduLVZg3ftHmsQlid4m1hBjk0EyKSqu/lR1bh4
         cHaFCZ5eecekXeAz2clprhUUypgFOpIu6rGSRMnDjgz1RBA7jX1PY+Cjg8YPGeXAaf
         IhzBbuYJo54I78mKI0NVk4qFb0BaSGKKoUPJTM+ECW1IFjmgBr6Z8rnp5JG16hxQhl
         u4K919VPJG8hgQoHxh6TM8B5G3vkwIqwqJ2ZtNFHIr3u6j0j5IGi8wLxogx/mRONes
         8R6La/tTfSsWw==
Date:   Tue, 6 Apr 2021 17:34:39 +0100
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
Subject: Re: [PATCH v4 3/6] PCI: brcmstb: Add control of slot0 device voltage
 regulators
Message-ID: <20210406163439.GL6443@sirena.org.uk>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-4-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7S+EREVcBHk3zUG"
Content-Disposition: inline
In-Reply-To: <20210401212148.47033-4-jim2101024@gmail.com>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--p7S+EREVcBHk3zUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 01, 2021 at 05:21:43PM -0400, Jim Quinlan wrote:

> +	/* Look for specific pcie regulators in the RC DT node. */
> +	for_each_property_of_node(np, pp) {
> +		for (i = 0; i < ns; i++)
> +			if (strcmp(supplies[i], pp->name) == 0)

This is broken, the driver knows which supplies are expected, the device
can't function without these supplies so the driver should just
unconditionally request them like any other supply.

--p7S+EREVcBHk3zUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsjZ4ACgkQJNaLcl1U
h9Aq4wf/RJ4KoV5Bjz46S5UVDEaAemzgqsSPUMZKuWSEbCnsPFzhpvHj9aqX2CkG
ELR9Fyj9O1r4TKtG3L/RsqiCIJrB6cMBN1n2Ad1Ji5isiZxvzjRJ2trQo/2g3jB5
plVpVy8Ee3qRyfoU6mGu7RrC6vn25wRu0TgMwaf0lge4Wuo9Xi8TGsqmjaIpu5yl
SGpp5RmMScIdmc9WiOsjtFmP89K5j9TMmYc2oRRVTVMaav1x7ghnxtsEIX/ecBuk
QzSIC5GmwS3BhlAns98kRUYr8s9NhuMsVtCuRT3tuNbLGpQxLOxx/9tymh4Qwxeg
PnuEs/O1mzPHMtECWiG8WKiUNlteOA==
=fgu8
-----END PGP SIGNATURE-----

--p7S+EREVcBHk3zUG--
