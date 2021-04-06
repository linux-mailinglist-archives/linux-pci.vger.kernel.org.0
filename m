Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF049355A35
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbhDFRXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232593AbhDFRXq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 13:23:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6676E613A3;
        Tue,  6 Apr 2021 17:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617729817;
        bh=NyyInCGNE1uoqUdzMm+iyXPpAi1wH034+5K530RbhVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aw1rFiIi9kuo8mcTCSms4+kYvK4ZKBCqmVUZSzPoRCYSCuDqBnv3lwm7DWUXjXe3i
         GmegKho+YrvnC4RQkDRN3EUhoIe5QEjz1EEPXx5xlPLnLf43VJecf7Q39NPXNqytWX
         +NFyvnZpWT4xo+sWfZvCGheMIQ3kQ7KBBnotbMh6i5S5iYhg6CfrWIKtt6s1ISLebv
         Eu0wGvTjzS2xtW39v2fkQwq55rBVMj/crNYX8xgfoposk0d42xM2kzYNM3QvyHfhOz
         tTAUqfW1mLzdBAycwrAbhrqe4BapVaf1ffu0bvjtC6FvXURKR55T51Oop7LUwDUt5o
         gWk9IyuXx5DOg==
Date:   Tue, 6 Apr 2021 18:23:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
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
Message-ID: <20210406172320.GO6443@sirena.org.uk>
References: <20210401212148.47033-1-jim2101024@gmail.com>
 <20210401212148.47033-4-jim2101024@gmail.com>
 <20210406163439.GL6443@sirena.org.uk>
 <CANCKTBvP66su2bXNMbawMfe3T7mpiQsRsG5xLfSPL2BWPNYFyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5wfsVCgeKAcINk2"
Content-Disposition: inline
In-Reply-To: <CANCKTBvP66su2bXNMbawMfe3T7mpiQsRsG5xLfSPL2BWPNYFyw@mail.gmail.com>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Y5wfsVCgeKAcINk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 12:59:16PM -0400, Jim Quinlan wrote:
> On Tue, Apr 6, 2021 at 12:34 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Apr 01, 2021 at 05:21:43PM -0400, Jim Quinlan wrote:

> > This is broken, the driver knows which supplies are expected, the device
> > can't function without these supplies so the driver should just
> > unconditionally request them like any other supply.

> Some boards require the regulators, some do not.  So the driver is

No, some boards have the supplies described in firmware and some do not.

> only  sure what the names may be if they are present.  If  I put these
> names in my struct regulator_bulk_data array and do a
> devm_regulator_bulk_get(), I will get the following for the boards
> that do not need the regulators (e.g. the RPi SOC):
>=20
> [    6.823820] brcm-pcie xxx.pcie: supply vpcie12v-supply not found,
> using dummy regulator
> [    6.832265] brcm-pcie xxx.pcie: supply vpcie3v3-supply not found,
> using dummy regulator

Sure, those are just warnings.

> IIRC you consider this a debug feature?  Be that as it may, these
> lines will confuse our customers and I'd like that they not be printed
> if possible.

You can stop the warnings by updating your firmware to more completely
describe the system - ideally all the supplies in the system would be
described for future proofing.  Or if this is a custom software stack
just delete whatever error checking and warnings you like.  The warnings
are there in case we've not got something mapped properly (eg, if there
were a typo in a property name) and things stop working, it's not great
to just ignore errors.

> So I ask you to allow the code as is.  If you still insist, I will
> change and resubmit.

Remove it, conditional code like this is just as bad in this driver as
it is in every other one.

--Y5wfsVCgeKAcINk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsmQgACgkQJNaLcl1U
h9DskAf/VoxLSYNHU72exjKJW5JNuftwTxIV64p9P+6X6YdAKyPe9hjIpEgRW4Or
hLFl5JECdDbLp6+8pCfLwwOqapayysqV1xmDyFEz8aa4YNfEcMQ6oi+ON+577tV5
o/BkG2BrsGSGgFnwRpaS3fMYpDQZotjJ0mNLdpFOej5kM0NQ42Lm/7m00Ac/YJAM
Br5LGIpvPhVuCQdnZlTSS2eOp62zN0G6keC3Cqa/ZB3OsItyPEbbvyY4g/g3eO+7
9CzNGFYfkde6XvvLL63FyDayAw1deqPzMlgWZEV5cCxKmWOM54dWL2bulCluwZFM
TzoqocIqZAFCIgi5kUw4p0p2WlJNiQ==
=olsV
-----END PGP SIGNATURE-----

--Y5wfsVCgeKAcINk2--
