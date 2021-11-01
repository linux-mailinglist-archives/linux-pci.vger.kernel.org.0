Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9830E441D69
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 16:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhKAP3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 11:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAP3E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 11:29:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0463D60EFF;
        Mon,  1 Nov 2021 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635780391;
        bh=h4iGd6cr9CkWZ/2uXIv6yBztpreBVJk7SOBYU7X8w40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5lF6nx3Ja1ekZ71dP5J3UwGPvBvogGLM/wCdoD2tSWBxVkPehtxmGbFmluI5IblJ
         /z7rA0mveTfjU/0V427dCg5ChmCaxjft54tWssCBUAaVUuC9r0IvfcUUCBYLJX3kem
         qxSqbjcLewC/KKYTl6GN8XXDrbfXE5kdyaFLQ4WojeH5rqdhzipiWrba+bp/Bwl0VG
         9gzVpVCL9T7PMDqZ027q7+Q72ehbobxHX5860AeXwCU3vGn9I4UkeiZUz0ROpD3VKn
         X+3iLou/AZMCVElVz61mgKGAELn2G40eD0rVy7s8uZWtiIDYbqv63xdvmnBXza2kEp
         aQekosToplORA==
Date:   Mon, 1 Nov 2021 15:26:26 +0000
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
Subject: Re: [PATCH v6 8/9] PCI: brcmstb: Do not turn off regulators if EP
 can wake up
Message-ID: <YYAHIuH2e3/0lfE2@sirena.org.uk>
References: <20211029200319.23475-1-jim2101024@gmail.com>
 <20211029200319.23475-9-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8dxReNanw4ioI4Z+"
Content-Disposition: inline
In-Reply-To: <20211029200319.23475-9-jim2101024@gmail.com>
X-Cookie: Don't Worry, Be Happy.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8dxReNanw4ioI4Z+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 29, 2021 at 04:03:16PM -0400, Jim Quinlan wrote:

> If any downstream device may wake up during S2/S3 suspend, we do not want
> to turn off its power when suspending.

Reviwed-by: Mark Brown <broonie@kernel.org>

--8dxReNanw4ioI4Z+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGAByEACgkQJNaLcl1U
h9A1GQf/e0HkIVeAwccGp+uEfVXVkQ+UrHkc/RiDsNgooNj4u5cb99wgoQDkQnat
Jz8TzVIRprUWNRfJHcJE4H5eSVLdSKNW9+GcFzRfAxfmbSHLq7UMgkr7R4O/5ecG
bI3/nSFD0QqOfkL4Cxgw60tU/ZudU737hFrQq+DghIPmyXACUeO6QJVuYivgRgN/
Cs4SHSuxswb7SoWN7vSppBxG98oQBg722+hI0VhjZ6rhNr+9FzGNtZontvVORUeK
3eGJER8mR3p6pEVO3iXmkxZDYgjjsdQRInruP2VvVGNQhlO91u2F+RpLivfXe9ZD
nfPAx0mfprpCDtmGJrn0y4DlJxuRjQ==
=wdLw
-----END PGP SIGNATURE-----

--8dxReNanw4ioI4Z+--
