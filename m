Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F63444A7F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 22:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhKCVzC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 17:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhKCVzB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 17:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECC73610EA;
        Wed,  3 Nov 2021 21:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635976344;
        bh=V/b4RPe+KlKMwlq2NVIwE02LwYXgoYqfcsIIQPEMlik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXRdL45mPMhb9fHhdFwxq1r9oH2XDVICseRyZZ0nq1Q5YtLD56tMiVwffbDB9hsgB
         //QND5nBe77QrgUkzGrfF+3W09PjkvHo0Eiyf2RCOUgSgrBDbrBzuon85T8JVbMM6b
         Wbi2twOSQSlG+662LO05WulrrUApWF33skbei5Mtv5FPTEU3G4MJ9Dm9Vt3QehkbTc
         Hb8NvLuXUS8yBYpzhF3vh9ofblDU4anXGJWRS0OflhfTg3C82Dsbnd034nq+ZWjjl4
         lYzD+0eMzTyCQq+HFWVWMQhYDNHOCBsvzzcp7Bs7NS7cnTFzYECOsAIlEf09PA0Wqd
         g6/+jbhMgolgg==
Date:   Wed, 3 Nov 2021 21:52:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <YYMEkjlbFdeIjror@sirena.org.uk>
References: <20211103184939.45263-1-jim2101024@gmail.com>
 <20211103184939.45263-6-jim2101024@gmail.com>
 <YYLm3z0MAgBK24z5@sirena.org.uk>
 <CA+-6iNzkg4R8Kt=Q=sgdB++HHStRSHRUOUTvAfjZr31-FUrzNA@mail.gmail.com>
 <CA+-6iNziZv0UycoaoFhscmp39Z2Y2bHrWUpFW4f9MBK-uM24qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9AXClGSRiYH1zTCu"
Content-Disposition: inline
In-Reply-To: <CA+-6iNziZv0UycoaoFhscmp39Z2Y2bHrWUpFW4f9MBK-uM24qA@mail.gmail.com>
X-Cookie: Thank God I'm an atheist.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9AXClGSRiYH1zTCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 03, 2021 at 04:34:34PM -0400, Jim Quinlan wrote:
> On Wed, Nov 3, 2021 at 4:25 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:

> > I did it to squelch the "supply xxxxx not found, using dummy
> > regulator" output.  I'll change it.

> Now I remember: if I know there are no vpciexxx-supplly props in the
> DT, I can skip executing all of the buik regulator calls entirely, as
> well as walking the PCI bus as in brcm_regulators_off().

> Do you consider this a valid reason?

No, the whole point in the core code providing dummy supplies is that it
removes the complexity introduced by client drivers trying to guess if
there's supplies available or not.  If they do that then we end up with
a bunch of code duplication and issues if there's any changes or
extensions to the generic bindings.

--9AXClGSRiYH1zTCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGDBJEACgkQJNaLcl1U
h9Dkjwf/QMk7OC27Jh/s6EzEAKCqj6WwCPuFlh1Vz8bufodISNcXsKUqGWTxJNiM
FjoP//ePLiCy2DaXo4KIrgPREdIDAPBiIWvO+NvSH9ZBLu/SiAJXj0hAHyhkmdz+
wPKuJJ/ybkVCclDPe7ulcMIaScGg/MD5fDmRDHEenY0NPK5RO9IXVMlNQCxMIoQW
/0L9Zmxy8jHWUJXXKP53eIHngmuwVvnaQxQDHNFy7gl+HCe0VE7EcmTRDXamTKeO
P6Oh3U5o/XfhQEeTtBYS9X9ZhHTGc/S+/Biwg2hoi5JmSVb3ypoIvjRLXZwub2FL
rBXMLpU9bR+q553FS0AzhAZJYGGZcQ==
=seGl
-----END PGP SIGNATURE-----

--9AXClGSRiYH1zTCu--
