Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEDC741DDB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 03:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjF2B7u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 21:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjF2B7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Jun 2023 21:59:39 -0400
Received: from stravinsky.debian.org (unknown [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C59270A;
        Wed, 28 Jun 2023 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YChyS4nbtccbfNNu4X1A8v3ecoV4guD+QWtTyEZmb9U=; b=Zqqr+smxp55qdZwF34DftF8llx
        j1un6BP2dCog0gdIk8uXiquY+6GJso4mPHx0RLbYxJRgDO3JAnuk0MauwEct7RQHVLzcPWOYrZU3S
        hluJWKTArm8fnHQcrB9YM3iQXWKQbebPARM/yemRImQL4kLZR9fOTMhsWgz7ezB181DBDRtRMuD8l
        IAGGRuDalj8Zotrhd9zKPxpp1hpr9YZM6Ux5Re5Hr8GKR2j19hK7f3FB0yepPKnq2gfL37jACo1g9
        xlKP6wld0uGYSKUvu9kyxBqAyOh+sq4HwydUdWS0HRC5v9/92DLXTObmNGWDNr2a7tjp4+QqlTGfL
        9hL+OOOQ==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1qEgwL-005i06-9G; Thu, 29 Jun 2023 01:59:22 +0000
Date:   Thu, 29 Jun 2023 03:59:18 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 0/5] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20230629015918.v4u7atl3ep3aetgj@mraw.org>
Organization: Debian
References: <20230623144100.34196-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7befo4br4255cxtj"
Content-Disposition: inline
In-Reply-To: <20230623144100.34196-1-james.quinlan@broadcom.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7befo4br4255cxtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <james.quinlan@broadcom.com> (2023-06-23):
> v6 -- No code has been changed.
>    -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyril)
>    -- Changed sign-off and author email address for all commits.
>       This was due to a change in Broadcom's upstreaming policy.

I've just run some more tests to be on the safe side, and I can confirm
everything is still looking good with the updated series and the updated
base commit.

Test setup:
-----------

 - using a $CM with the 20230111 EEPROM
 - on the same CM4 IO Board
 - with a $PCIE board (PCIe to multiple USB ports)
 - and the same Samsung USB flash drive.

where $CM is one of:

 - CM4 Lite Rev 1.0
 - CM4 8/32 Rev 1.0
 - CM4 4/32 Rev 1.1

and $PCIE is one of:

 - SupaHub PCE6U1C-R02, VER 006
 - SupaHub PCE6U1C-R02, VER 006S


Results:
--------

 1. With an unpatched kernel, I'm getting the dreaded Serror for all
    $CM/$PCIE combinations. That's reproducible with:
     - the 6.1.y kernel shipped in Debian 12;
     - a locally-built v6.4-rc7-194-g8a28a0b6f1a1d kernel.

 2. With a patched kernel (v6.4-rc7-194-g8a28a0b6f1a1d + this series),
    for all $CM/$PCIE combinations, I'm getting a system that boots,
    sees the flash drive, and gives decent read performance on the USB
    flash drive (200+ MB/s on the CM4 Lite, 220+ MB/s on the non-Lite
    versions).


In passing, since that looks like it could be merged finally: I suppose
it's fair to say this series adds support for hardware that wasn't
working before, which means it's not a candidate for inclusion via
stable@ (even if it gets rid of a nasty failure to boot depending on
what hardware is plugged in at that time)?

In other words, downstream distributions should be expected to either
adjust their build systems to pick some future Linux release or consider
backporting this series on their own, to each base Linux version they
support?


Thanks again for all the help figuring this out.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--7befo4br4255cxtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmSc5XMACgkQ/5FK8MKz
VSA3Sg//fgoP825n1pCIyd3e2L9YZB3DWHb6OWdjrkcyyLL4YEn6BapxdPkjwMpk
JAK7iCo1grklQEvdqMrkoc4mRHsjN/3Hkx9GzRguiU28AqaMkazc3s+GnRJtoUnO
zWNPnwnwsaeIGmB0uIXWLxtp1A9naSO/zOPwD/INCWYbC2EAT4sEPb+A4qqtMrz/
CGXalNZb58prYVJrlZ2fcQL3SGrgf4lcob7JqtZcL9pHE5uaS7sOhSQdxQI1JgTC
/6bjJGvBAyLLlOA8rTR8vYgmXbaFX12aVJ9OOn0tByScMc7VNikVPSTo7/Oc630t
ElCEnxxIc/cslSXhM1xlhUMgGY8WIrr1G0qNM7LPVoC4FPWsOjdFXj0ooChEKaHW
ZqKrJ7UDlq7rTIwyzJTVCbZJw+QVt8Qz6ffaQgbJ5jGkVIxrjFgfMvfNeRIhEF8a
c6PJiLNm8QRh2h497F+J2PopC/i9kEL/k5ySoa1rOzqUPReXhN57Q5xQRivOZDdw
nMa7m5eX0gbtvjX3qaCwVIIcwpVaWAeiOEm2/B3aAKiPVPmibw0sdCRtoSflh2NZ
dq2ReO2rJZhNHgeOD3oY6L0vU7w2dN8k56eh+JVcWzksjqPgbndq0U54oFnuBnfL
I7qN6WjGtPPQeYf/j9ngJkuKTPY/BUxUTP0cBkFrgQMHqnTJOyA=
=yUbx
-----END PGP SIGNATURE-----

--7befo4br4255cxtj--
