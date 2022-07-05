Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DDC5678D9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiGEU4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 16:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGEU4A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 16:56:00 -0400
Received: from hobbes.mraw.org (hobbes.mraw.org [195.154.31.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8579A13FBB;
        Tue,  5 Jul 2022 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mraw.org;
        s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IMDw5cu1s4DvVXN1/rOltSNRmEohjKczRaIEqn7FbJM=; b=rlN5KVoQM0WYnzmev/AXq5zAKu
        ZTrho6IJ2AItZ/aq9tcygI0GwpfIBd6GvWp4PNhtYCPe8BIJuQ8pDgmuQZFm3J7q9pC6/+8cCUqeN
        fzs+8CMHgeauxMLr1saKgIQ8MWurwNKwTmp/OjWBrB6AY9X7DD0r8uo7uAeremUhhs7IgJMvU+XoQ
        D8LWyf1Ma9zq6N9eSVSy4WMwRKAQGSnPIybNNUpJC1dZ0J2dqWq0Qha7p4TK8Ibg6de9eoyu4rUk4
        Sq66ph+U7MHxUu4Lx5E82CINpC0AD4/oWovmfqz09QbjGB+y/2c85qJhHa3QwzkHm2khQz/RSMmAz
        TWP4tcvw==;
Received: from 82-64-171-251.subs.proxad.net ([82.64.171.251] helo=mraw.org)
        by hobbes.mraw.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1o8paK-000vMG-LO; Tue, 05 Jul 2022 22:55:52 +0200
Date:   Tue, 5 Jul 2022 22:55:51 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Re-submit reverted patchset
Message-ID: <20220705205551.phbaqqpgyg3pvtv7@mraw.org>
Organization: Debian
References: <20220701162726.31346-1-jim2101024@gmail.com>
 <1a50e8b0-1453-4561-bc3d-c428bb65288a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="56o5nyaljsegk6fh"
Content-Disposition: inline
In-Reply-To: <1a50e8b0-1453-4561-bc3d-c428bb65288a@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--56o5nyaljsegk6fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli@gmail.com> (2022-07-01):
> On 7/1/22 09:27, Jim Quinlan wrote:
> > A submission [1] was made to enable a PCIe root port to turn on regulat=
ors
> > for downstream devices.  It was accepted.  Months later, a regression w=
as
> > discovered on an RPi CM4 [2].  The patchset was reverted [3] as the fix
> > came too late in the release cycle.  The regression in question is
> > triggered only when the PCIe RC DT node has no root port subnode, which=
 is
> > a perfectly reasonsable configuration.
> >=20
> > The original commits are now being resubmitted with some modifications =
to
> > fix the regression.  The modifcations on the original commits are
> > described below (the SHA is that of the original commit):
> >=20
> > [830aa6f29f07  PCI: brcmstb: Split brcm_pcie_setup() into two funcs]
> >      NOTE: In the originally submitted patchset, this commit introduced=
 a
> >      regression that was corrected by a subsequent commit in the same
> >      patchset.  Let's not do this again.
> >=20
> >      @@ -1411,6 +1411,10 @@ static int brcm_pcie_probe(struct platform_=
device *pdev)
> > 	    if (ret)
> > 		    goto fail;
> >=20
> >      +       ret =3D brcm_pcie_linkup(pcie);
> >      +       if (ret)
> >      +               goto fail;
> >=20
> >=20
> > [67211aadcb4b  PCI: brcmstb: Add mechanism to turn on subdev regulators]
> >      NOTE: Not related to the regression, the regulators must be freed =
whenever
> >      the PCIe tree is dismantled:
> >=20
> >      @@ -507,6 +507,7 @@ static void pci_subdev_regulators_remove_bus(s=
truct pci_bus *bus)
> >=20
> >      if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
> > 		    dev_err(dev, "failed to disable regulators for downstream device\=
n");
> >      +       regulator_bulk_free(sr->num_supplies, sr->supplies);
> > 	    dev->driver_data =3D NULL;
> >=20
> >=20
> > [93e41f3fca3d  PCI: brcmstb: Add control of subdevice voltage regulator=
s]
> >      NOTE: If the PCIe RC DT node was missing a Root Port subnode, the =
PCIe
> >      link-up was skipped.  This is the regression.  Fix it by attempting
> >      link-up even if the Root Port DT subnode is missing.
> >=20
> >      @@ -503,11 +503,10 @@ static int pci_subdev_regulators_add_bus(str=
uct pci_bus *bus)
> >=20
> >       static int brcm_pcie_add_bus(struct pci_bus *bus)
> >       {
> >      -       struct device *dev =3D &bus->dev;
> > 	    struct brcm_pcie *pcie =3D (struct brcm_pcie *) bus->sysdata;
> > 	    int ret;
> >=20
> >      -       if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus-=
>parent))
> >      +       if (!bus->parent || !pci_is_root_bus(bus->parent))
> > 		    return 0;
> >=20
> > 	    ret =3D pci_subdev_regulators_add_bus(bus);
> >=20
> > [1] https://lore.kernel.org/r/20220106160332.2143-1-jim2101024@gmail.com
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D215925
> > [3] https://lore.kernel.org/linux-pci/20220511201856.808690-1-helgaas@k=
ernel.org/
>=20
> On a Raspberry Pi 4B:
>=20
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>

As it stands, CM4 support in master is less than ideal: the mmc issues
I've mentioned in some earlier discussion are making it very hard to
draw any definitive conclusions. Soft reboots or cold boots don't seem
to make a difference: the storage might not show up at all, leading to
getting dropped into an initramfs shell, or it might show up but further
accesses can be delayed so much that the system proceeds to booting but
very slowly, and it might even lead to getting dropped into some
emergency/maintenance mode.

This affects both the CM4 Lite variant (no internal storage =3D SD card in
the CM4 IO slot) and some CM4 non-Lite variant (with internal storage),
with messages like this one getting repeated:

    [  310.105020] mmc0: Timeout waiting for hardware cmd interrupt.
    [  310.110864] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI =
REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    [  310.117390] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00009902
    [  310.123918] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
    [  310.130445] mmc0: sdhci: Argument:  0x000001aa | Trn mode: 0x00000000
    [  310.136971] mmc0: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
    [  310.143496] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
    [  310.150021] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00007187
    [  310.156548] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00018000
    [  310.163074] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
    [  310.169600] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
    [  310.176126] mmc0: sdhci: Caps:      0x00000000 | Caps_1:   0x00000000
    [  310.182652] mmc0: sdhci: Cmd:       0x0000081a | Max curr: 0x00000001
    [  310.189178] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
    [  310.195704] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
    [  310.202230] mmc0: sdhci: Host ctl2: 0x00000000
    [  310.206728] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

That happens with current master (v5.19-rc5-56-ge35e5b6f695d2), with or
without this patchset.

That being said, I'm not able to reproduce the showstopper regression
that I reported against the initial patchset (booting was breaking in
the very first few seconds), so I suppose it's fine to propose the
following even if that's somewhat tainted by those mmc issues.


With Raspberry Pi CM4 (Lite and non-Lite), mounted on a CM4 IO Board:
 - with a PCIe to quad-USB board, USB storage and USB keyboard;
 - without anything in the PCIe slot.

Tested-by: Cyril Brulebois <cyril@debamax.com>


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--56o5nyaljsegk6fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmLEpVQACgkQ/5FK8MKz
VSDhORAAwP9kv4QhHbbkxl+smQ34WckE+NL0Iiaf6zW7D/XHQnMXO9goHKbhltsu
lf5YTyEH69CFI1vVxxDq79FYHGHFFyurOBy4wizMkgDt0SobymWBgfN7h4STYzq1
rvP9l7pu5K4TD2e1CmoTXNOOBiTVaAUWtk3l/MS6UA3JAbIVK4QkzwWRAxgw93rl
KX24NseAM27mgh7noQPAuYrD5RRhGFoH+uBV+kjK4JDk/dc6ow23KTX8Ui0euiEi
x8yZjxuKyFCjRJWolROc0IYXetyBesH3D9Xq2OMj6WQZX2QaogwD1BqFzAE42Udf
G4gBCUPYrOsaF8wJfIcSLDXF094PvImKx/vm3VVW+6UO/rX5M5A3rzXOiuvSS2xm
Gjj6sve07USNE+YjG+qV4O/ATvSY3QZKnm5CJFfSBjyNF1Zs8iExdUqRBTgKY1X6
7EQd9N4qJaPaMF1r3qfOSaO3gyvOAjPcEm750LhA9eUCKMVw/Nj4dhTBKnHLXJr7
la0egHgrmlM6sD514pkOws/XYk5ro8x1ckOsJv/XDprtFH6Zx9Lf9QJ/h+p0T4jW
pcsB7MG6n6KXcublCWVMvqEoEd5wJWClqX4oxKhrO2GtH1jolHl/ARUKsY0ebj2F
SWnTD48lJilPI4reKTVzWP4WB3ixdTgGCQ7G4/h2UPa5mxzi1Nc=
=7Mn5
-----END PGP SIGNATURE-----

--56o5nyaljsegk6fh--
