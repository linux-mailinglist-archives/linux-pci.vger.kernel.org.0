Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A326F5EF0
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjECTKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjECTKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 15:10:50 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB0B7AB7;
        Wed,  3 May 2023 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vfvdDUxST/TqMGs2ydRU881qJNF4aH49FdBpxMofuJ0=; b=JLs+g9xs0MLmDTPqd5+nKMO8ir
        Y2u6LvHU9xKErSImBxIs70xY7WVtk6PGQImC9NxCP7gL0MO/hVm1uAvxzbBESjfTxuzGC3xWdSm8q
        AMddS+QQMkCW45A6K1IXlDKVM5JVBEHi1ZyTScNXVn685gOJ3/svPdtPrnHfOmlQ0RT1OlaVFzxng
        BaIKiIO91uq5kBwqkAU9w0oIrQqCGFLJuMKS2C3YkWC7sjlvpMmtZ2OHK8ow/nCFmyBNR6RKW4Rbe
        UAxo/PTL2lmRmHzXlqC3yomU44seu9chJXF0t3mHloydHzRUgQ/u3rWFG+Osulq4kaS8+AoGjyjSL
        IR9ifGOw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1puHs8-003gwQ-NP; Wed, 03 May 2023 19:10:42 +0000
Date:   Wed, 3 May 2023 21:10:37 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20230503191037.pqnpoiojdq5huyo6@mraw.org>
Organization: Debian
References: <20230428223500.23337-1-jim2101024@gmail.com>
 <20230502231558.5zt5tyxczd22ppjz@mraw.org>
 <CA+-6iNzD_YrrhDPfr0J7KA3rotbgDNB+vGOJyyRnW3-7G5vw6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7okzvijjcoe4r4d"
Content-Disposition: inline
In-Reply-To: <CA+-6iNzD_YrrhDPfr0J7KA3rotbgDNB+vGOJyyRnW3-7G5vw6Q@mail.gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--d7okzvijjcoe4r4d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <james.quinlan@broadcom.com> (2023-05-03):
> >                            +----------+----------+----------+
> >                            |   006    |   006S   |   VIA    |
> >   +------------------------+----------+----------+----------+
> >   | 1. CM4 Lite Rev 1.0    |    KP*   |    KP*   |  OK, 72  |
> >   |    pristine            |          |          |          |
> >   +------------------------+----------+----------+----------+
> >   | 2. CM4 Lite Rev 1.0    |  boot +  |  OK, 72  |  OK, 72  |
> >   |    + brcm,enable-l1ss  | timeouts |          |          |
> >   +------------------------+----------+----------+----------+
> >   | 3. CM4 8/32 Rev 1.0    |    KP    |    KP    |    KP    |
> >   |    pristine            |          |          |          |
> >   +------------------------+----------+----------+----------+
> >   | 4. CM4 8/32 Rev 1.0    |  OK, 69  |  OK, 69  |  OK, 69  |
> >   |    + brcm,enable-l1ss  |          |          |          |
> >   +------------------------+----------+----------+----------+
> >   | 5. CM4 4/32 Rev 1.1    |  boot +  |  OK, 69  |  OK, 69  |
> >   |    pristine            | timeouts |          |          |
> >   +------------------------+----------+----------+----------+
> >   | 6. CM4 4/32 Rev 1.1    |  OK, 82  |  OK, 69  |  OK, 69  |
> >   |    + brcm,enable-l1ss  |          |          |          |
> >   +------------------------+----------+----------+----------+
>=20
> Hello Cyril,
>=20
> I'm confused by your result table above which has a number of
> failures.  Further in your message you say:
>=20
> Takeaways:
>  - Upgrading the EEPROM solved all problems;
>  - brcm,enable-l1ss (which used to help) is not needed [...]
>=20
> May I conclude that if one uses a modern CM4 eeprom that these
> failures go away?

Sorry that wasn't clear enough. The table with failures, quoted above,
was with 3 compute modules in their stock configuration:
 - CM4 Lite Rev 1.0 (lines 1-2) had an 2021-02-16 EEPROM;
 - CM4 8/32 Rev 1.0 (lines 3-4) had an 2021-02-16 EEPROM;
 - CM4 4/32 Rev 1.1 (lines 5-6) had an 2021-12-02 EEPROM.

Upgrading them all to current 2023-01-11 led to the second table when I
tested again, where everything worked fine.

The 2 versions (2021-02-16 and 2021-12-02) are marked as stable in the
rpi-eeprom.git repository.

> You mentioned in a personal email that at least one of your "CM4" was
> running a Beta eeprom image.

That one was another CM4 Lite Rev 1.0, and had a 2020-10-02 EEPROM. That
one is marked as an old beta in the rpi-eeprom.git. (That CM4 Lite also
works very fine once the current 2023-01-11 is deployed on it.)

[Regarding EEPROM variety in the field: I've mentioned this topic on the
#debian-raspberrypi IRC channel, warning others about troubles that
might be linked to the EEPROM version. I've seen at least one CM4 user
report the 2020-10-02 beta EEPROM, and another one report a different
2022-04-26 stable EEPROM.]

> I'm much less concerned about folks having problems with old  or
> pre-release versions of the CM4 eeprom because (a) most of these folks
> are using Raspian Linux anyway and (b) they can just upgrade their
> eeprom.

That looks totally fair to me. So I can stop here, wait for the next
iteration of your patch series if there's one (rechecking everything
still works fine), and only the latest EEPROM matters? Sounds good.

> Further, the Rpi eeprom is closed-source and my questions on the Rpi
> forum  and Rpi Github have not yet led to any answers  about why a
> different eeprom image is changing the behavior of a clkreq signal.

The following doesn't shed much light but seems consistent with results
getting better with newer EEPROM versions (a number of =E2=80=9CPCIe=E2=80=
=9D hits, some
about probing, some about resets):
  https://github.com/raspberrypi/rpi-eeprom/blob/master/firmware/release-no=
tes.md

[If I had known how much of a difference an upgraded EEPROM would make,
and how easy it is to upgrade, I would have probably bothered you much
less with all those weird results=E2=80=A6 Sorry about that.]


The whole series is:

Tested-By: Cyril Brulebois <cyril@debamax.com>


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--d7okzvijjcoe4r4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmRSsa0ACgkQ/5FK8MKz
VSC0RBAAvA1uZTNBedOSof5kzCNp05mRkPl8jIRFLj7DDYMqF2zjzzjBVIrx4kXm
rE+YsIDiQVZiiaFHVcWDt2PDulJSJdJLvdHsCZeUHiSaxyKezrZfimr4sZkgXVf0
TBBhDAGIRWMom2V+RaSIyt8XyWfkaWVRa7+OJA+KwC3wVw2t1ah1mZyIGoWJNZjd
ig3IkPbIaY7uNeU4KNmmoYehXXbY/guvFiF9l7iwdcQmW790zPkhf41yfKSzYzu/
8cHVdB3wHFlLfg+eE50Vr9UTJfCTmWcH84pRoQA8QDPKZtX0GWMoFnRw4HAC2Fk7
AUU4yu6TaDuDlxwnsvveFwmKWbjjlBEhJ0Dnw+mdVA/NdcnyrDyOVDHWpZnZWD+N
VKKxbQ9k1yHUA4OQL47zQJIrfyUJOKG68Hu2dXBirRUh6G1ncuakKgI8lp8S09zH
gqw5LPNfqLyk3KCptdI+i1kin8mfJNzFsgjxcD/KDgSQPsnG0Xr5+ZOdKjXjrCVN
XNFSQqEIjSSsABmcya8DCx1kpLkUbpVvgszTLLGKCLidPREIAdj9mLYCV6/LM/sY
n5Y4cRUOutzsAnZusasiiFClIJrAibUWWeLUHiMdBhnuB5qIGdcYDe+lHpCb3NPM
78Cmb7FlvGWE7ZA8K9s2EtvyFsxOoh/wrKMUxSVlHaOisWrE3Us=
=IvjH
-----END PGP SIGNATURE-----

--d7okzvijjcoe4r4d--
