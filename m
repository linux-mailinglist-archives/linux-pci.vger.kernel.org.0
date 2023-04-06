Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16C16DA4B3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 23:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDFVbf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 17:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjDFVbe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 17:31:34 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443EA27D;
        Thu,  6 Apr 2023 14:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5lYMx1AJfwdjuXMvx33uKHvBVXBN3hKr68FwdEgC5KY=; b=C4Hkc9uodAPp0nt7zWvcGENzK9
        yXg8OLttG/vkoj3n8yhB9v9cbmay7wCYj2BOcEc9rtc1SmDo4r4wXqnFtoKmj/doMwwGK3CEzabLv
        cuSrpFieMIWOOmf3tm3/ffrfm5TvAeTyNS3HxZeuYIILTf4konjQnaA20ITp1m9Tm1ITQnyc3iv4v
        5IFZbpHa1k4BHVtGAtAS2J6KuLY7RRxxuXng6zNHEptulc8alJhDvhwlIn3gXA3wpEoQwYUWTWrZP
        jKDLU64zY9LmT1GJy1lzvNRgC+B/09qsF5Fk+WQ2sucaMYc6yI1oQxKTunr95PdmIT1fxkFgA4Qwi
        etWzcG3w==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1pkXCY-00CCYR-DM; Thu, 06 Apr 2023 21:31:27 +0000
Date:   Thu, 6 Apr 2023 23:31:23 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>, Hank Barta <hbarta@gmail.com>
Subject: Re: [PATCH v1 0/3] PCI: brcmstb: Clkreq# accomodations of downstream
 device
Message-ID: <20230406213123.wcztrbmhdpukoby2@mraw.org>
Organization: Debian
References: <20230406124625.41325-1-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huvxf4pce7occ4no"
Content-Disposition: inline
In-Reply-To: <20230406124625.41325-1-jim2101024@gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--huvxf4pce7occ4no
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <jim2101024@gmail.com> (2023-04-06):
> The current driver assumes the downstream devices can provide clkreq# for
> ASPM.  These commits accomodate devices w/ or w/o clkreq# and also handle
> L1SS-capable devices.
>=20
> The Raspian Linux folks have already been using a PCIe RC property
> "brcm,enable-l1ss".  These commits use the same property, in a
> backward-compatible manner, and the implementaion adds more detail and al=
so
> automatically identifies devices w/o a clkreq# signal, i.e. most devices
> plugged into an RPi CM4 IO board.
>=20
> Jim Quinlan (3):
>   dt-bindings: PCI: brcmstb: Add two optional props
>   PCI: brcmstb: Clkreq# accomodations of downstream device
>   PCI: brcmstb: Allow setting the completion timeout
>=20
>  .../bindings/pci/brcm,stb-pcie.yaml           | 12 +++
>  drivers/pci/controller/pcie-brcmstb.c         | 93 +++++++++++++++++--
>  2 files changed, 95 insertions(+), 10 deletions(-)
>=20
>=20
> base-commit: 99ddf2254febae9eab7fb0bcc02c5322243f5c49

I've just verified with the exact same hardware as in Bugzilla#217276
that latest master (v6.3-rc5-137-gf2afccfefe7b) still gets a kernel
panic at boot, which goes away once those 3 patches are applied. Do you
need any extra information, log excerpt, or something like that?


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--huvxf4pce7occ4no
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmQvOicACgkQ/5FK8MKz
VSBVCw/+MGW7YQ5aLMIMlsR3WkQfONllYhPGqTdxSLKft0xScIntkoX19WwNK9sk
VsMzs461n5ZQQbjJfN9GlKjkPBYOa24nTn0u6Sqa/tDEmBWzvoNSmXut7ak8Dh2t
4ih/LWqRmqbWlu9zb2dNeJG4w0jWHyeYlKRsoLxAXViH2LpPdHXTq7aBci4rSV7g
Ui6wTO2FMhv9LPehezB6lFi2HqT18zTQnsZqalFufang4esARaqCKVGGZ6ZQ5ugH
fW0rI6Ept0CXH5nmFjzP696vGNNrps7HD7RzDFPzY/rOgjbDh6UuyntFW79qIRkY
k/bV0vTlS0PNkHdKXc2w4eVgIDWDL2QsxsCckOIw4DDtzz/KMcaeIlD5ueuDt16t
EA3otoIiOMkei/kWKJRb2Z0ow3dDdWW/5P/0JqZc1S6zPO+5KQuhwe1LBfGrnZbL
KEGU4KBmV6WvkyL9ZDZHP37R3CnD9afe/w6AJWZqNiNKSde0VqPgzSY6cqMwRGPS
FttoeN9VHMZjesviHdCH0mXiB2c75ihvcsX18eWXSbWHpE7KU6B8aH5ye1zhEw7r
PdPTBd19gnOlSMYZEAG5q0dVkdsC0ja4mmwL73xAx0kYHHO1Qq5sM3IY3qhi+4T6
OhYQlKu2FrD1qZkVnugXOIwyragOmlBrSbvHnWOMFcj/d8VK9K0=
=pyNy
-----END PGP SIGNATURE-----

--huvxf4pce7occ4no--
