Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FF2EAC91
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 15:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbhAEOCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 09:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbhAEOCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 09:02:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0EAC22AAB;
        Tue,  5 Jan 2021 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609855316;
        bh=ASplVFuNkPaZ936Orl5wWvFQMIR51qVCfXTsdj5Q8Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWcB9rYOjo3v/q7hy/2jXAAJmAJKNcWXzgaf/a8Kz8yvhK/1jF17ndDs8aMoLFjLg
         0GOh9ayC59rH8FVaUND2G3Axlymnx0vHGuug2q4h5Azprqa6yaABFNwoVRcZcMFAZN
         411H8B7g2C1hr1s96q2o65tyiYbVz8/P5Ki2YmLR5+FYOnc5dwDvGJNvEw1QiUzk9n
         0+AMaDah3es210bjQI+R2qgTjPqaGOOuHcTbG1iAGhx7/7IU11UbomszOWQMz07iUc
         T8OtsUpmWtH5EVKVlf0Ww0iOcELRNHQvjz8REtrHOOZNWDb7eeY4yBXRA6zgIQXYtd
         g5m7EAYu8o3EQ==
Date:   Tue, 5 Jan 2021 14:01:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20210105140128.GC4487@sirena.org.uk>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-2-james.quinlan@broadcom.com>
 <20201209140122.GA331678@robh.at.kernel.org>
 <CANCKTBsFALwF8Hy-=orH8D-nd-qyXqFDopATmKCvbqPbUTC7Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <CANCKTBsFALwF8Hy-=orH8D-nd-qyXqFDopATmKCvbqPbUTC7Sw@mail.gmail.com>
X-Cookie: I'm ANN LANDERS!!  I can SHOPLIFT!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2021 at 05:12:11PM -0500, Jim Quinlan wrote:

> For us, the supplies are for the EP chip's power.  We have the PCIe
> controller turning them "on" for power-on/resume and "off" for
> power-off/suspend.  We need the "xxx-supply" property in the
> controller's DT node because of the chicken-and-egg situation: if the
> property was in the EP's DT node, the RC  will never discover the EP
> to see that there is a regulator to turn on.   We would be happy with
> a single supply name, something like "ep-power".  We would be ecstatic
> to have two (ep0-power, ep1-power).

Why can't the controller look at the nodes describing devices for
standard properties?

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/0cTcACgkQJNaLcl1U
h9DIbwf+NHMTbyBOhHAFuUOWo4I6SmPq9+RsD3YDgS59K1pPy618QRiBt/+c2TSw
lV5lD8CiHXjlbVytAV+iw2xwmzsRI78YTuYz4o0GwKp2bKz23NQbGaCd8KN5oIEA
ToNd53+zPtoRXHP61UC3DOJbDHVdAmYo7vHWh+VFrwl4V2Z/97MokfQ1CL6uIdRh
NMwgaP2Hw8v6spI4q9rdpqEbzSaik7OkuNpFzDRRN2d/fB+NFv561M+lDAN7Ukyk
CZbPC5l01SLY2dO6JugfEvf9lduKTU+QCfIQ2+BVOPA1C5r7Idrbg/s+ZSEoaX3L
kGbxqKu3ifqx3n4xjDya93k/Ftrt/Q==
=cqQe
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
