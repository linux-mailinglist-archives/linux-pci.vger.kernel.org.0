Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383A0F9016
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 13:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKLM72 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 07:59:28 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3783 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfKLM72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 07:59:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcaac760000>; Tue, 12 Nov 2019 04:58:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 04:59:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 04:59:26 -0800
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov 2019 12:59:25
 +0000
Date:   Tue, 12 Nov 2019 13:59:23 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191112125923.GA4168874@ulmo>
References: <71f545f7-f14a-d2d9-215c-b3fb22000a5c@nvidia.com>
 <20191111223235.GA38578@google.com>
MIME-Version: 1.0
In-Reply-To: <20191111223235.GA38578@google.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573563510; bh=ycfFOIvRlmgi9+fxjLvIRFVgGgk/b7RuIXgEn8JGmno=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=igtWdYWLBHE0BMhgGQTz4+z/DkZcR2Obo/bLCYcngi2ypi55y1Gug/QTKdjusr8dE
         QTy+X2ZA4iDpL813H81X3JPiQnmx+WZcgAN2y+OuTIXll8IU+d8bRh4d4iSvz6dMDt
         nk3T+grPCRsfaXG5CxMbfdJJ79gXnJUUiIFbex3cPcyWRo5ionq9AXga3RlaW2pU1r
         ytU3zILpUusmH+LVR5dMOpAikrMwnKiR/r8uv0pkCWyPVr2aXDsWrvqstnUhLsULKz
         R0hV/ylj4529mtd83UMz/pr62Yr/fxlTGwTkPCG+XVtEq5Hub8PUPoVwUB6VaXYQZE
         NqTJ3kCsQCmDQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 04:32:35PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 11, 2019 at 11:31:18AM +0530, Vidya Sagar wrote:
> > On 11/6/2019 10:11 PM, Bjorn Helgaas wrote:
>=20
> > > Based on Vidya's backtrace, I think the resume path with problems
> > > is this:
> > >=20
> > >    pci_pm_resume_noirq
> > >      pci_pm_default_resume_early
> > >        pci_power_up
> > >          if (platform_pci_power_manageable(dev))
> > >            platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay =
here?
> > >          pci_raw_set_power_state
> > >          pci_update_current_state
> > >            pci_device_is_present        # <-- config read returns CRS
> > >=20
> > > So I think your suggestion is that Vidya's firmware should be
> > > doing the delay inside platform_pci_set_power_state()?
> > >=20
> > > Vidya, you typically work on Tegra, so I assume this is on an
> > > arm64 system?  Does it have ACPI?  Do you have access to the
> > > firmware developers to ask about who they expect to do the delays?
> >
> > Yes. This is on arm64 (Tegra) and we don't have any ACPI or any
> > other firmware for that matter. PCIe is brought up directly in the
> > kernel.
>=20
> I assume that your device is coming out of D3cold because apparently
> you're seeing a CRS status from the config read when
> pci_update_current_state() calls pci_device_is_present().  CRS status
> should only happen after reset or power-on from D3cold, and you're not
> doing a reset.
>=20
> I'm pretty sure platform_pci_power_manageable() returns false on
> your system (can you confirm that?) because the only scenarios with
> platform power management are MID (Intel platform) and ACPI (which you
> don't have).
>=20
> Maybe you have some other platform-specific mechanism that controls
> power to PCI devices, and it's not integrated into the
> platform_pci_*() framework?

My understanding after reading the PCIe specification is that CRS is a
mechanism that allows an endpoint to signal that it isn't ready yet for
operation after reset or power-on from D3cold. There's nothing in there
that's platform specific. This is really only for specific endpoints.

I don't see how adding platform specific PM code would help in this
case. At a platform level we don't know if users are going to plug in a
PCI endpoint that needs a long delay before it's ready after reset and/
or exit from D3cold.

I do understand that perhaps pci_device_is_present() is perhaps not the
best place to do complex CRS handling, but if a mechanism is clearly
described in the specification, isn't it something that should be dealt
with in the core? That way we don't have to quirk this for every device
and platform.

The PCIe specification says that:

	Software that intends to take advantage of this mechanism must
	ensure that the first access made to a device following a valid
	reset condition is a Configuration Read Request accessing both
	bytes of the Vendor ID field in the device's Configuration Space
	header.

So doesn't that mean that pci_device_is_present() is already much too
late because we've potentially made other configuration read requests in
the meantime?

Wouldn't it make more sense to push the CRS handling up a bit? The
existing pci_power_up() function seems like it would be a good place.
For example, adding code to deal with CRS right after the platform PCI
PM calls but before pci_raw_set_power_state() seems like it would fit
the restrictions given in the above quote from the specification.

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3KrKkACgkQ3SOs138+
s6EBtg//bSfrwh2XTLS0dlRcXbzAkOCBBDRDpOnfOwwGoAk1dBQg9lC9sVjT7k0L
EzAgyr+nWC5DNdEsosEt2PGLYIu5KwWKr1AKn6aNkmOL8DHCaSSgCYMmX681z8Tz
Epvgukume4Kn9bkBx4cgQZxZ0POB8fpQvZk3Cjaw6dRxcDGouxzUULO23D3tLK3J
k0re/dYx55ghNznky2+94Yf5tKeLq53H2b7V/US5qOcampd0ZFaFOD1fQiVb3Sz8
6/aHkhUQhcPMg/P5g+R/UV5BJooq1LvesQH1ArNAwy+WtRUzYef/e1ZekMypHLai
8IPdQEM0o7jYwwe6nKMySzUWpumVw7Q9A7nRxBhz8jZAkKfov1ki45k2ReOTGnhz
9uS6O+w8K0bv+2PDQz95T4zuIk/1k26YcjV4d3RkfePIFsxLPp35DI90UBy5ncX0
hNhceMPMCM6NxqD3l7BDlfW3PzmjroKGRRQEbsfYVEInIMkg5hdkf6CHoJIGDfRL
kY+ggzY5Tiokkfvu04mJoCEjcazCk9QdCMnWUmAryvAm+i5TA7TFrxRpe/k1C3RE
Hqud5Ekr+dfwWDdrzpFCtXMeGE09W9avqEFCv1UFh2K2jsjOxFS5KhOoPIq/fMhx
7dGC11PqWs/OGBCDOLcumY/KkUrh8aLKoJuPtfQwezMJfgHOmaA=
=hgJH
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
