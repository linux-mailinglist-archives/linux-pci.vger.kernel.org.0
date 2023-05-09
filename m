Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0DE6FC0BD
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 09:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEIHvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIHvT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 03:51:19 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C310A;
        Tue,  9 May 2023 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SHJ8rFSlgUKip49JflDFe5hQHWXdms45Qv37jV17d5w=; b=LYJOKkK6psZo49sTPJGzmdoj7k
        5VuwqsJLQyo80OVasAwU0HX77BHFvCBgRQg5VlaGeG16uQMkJH0sxUjnpGndUa2NrUlpcdu0MmGwR
        8a+2hCdugNMm4+7LbgABnPvnClCTEKabCqh1vrFC1m8haVpwaG0MlVkA0Wd58mpmgPiff/Z9jFOXJ
        zh0tV+dMSY4R/lh2aW87IqCycGgmqCSD/1RxryqqtT5I2emqQ0XBWL6YF84Od8oVwNmWDuXGaV5zc
        dKB7cM5T4euJqhlvTn3FEks/0vaE2zsaLlSv/Vpuii9iCSvEZr646+3rEhiPez4ppW3wlE0T/WUBu
        /xTybutQ==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1pwI7v-008YdF-Qy; Tue, 09 May 2023 07:51:16 +0000
Date:   Tue, 9 May 2023 09:51:13 +0200
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] PCI: brcmstb: Don't assume 2711 bootloader leaves
 PERST# asserted
Message-ID: <20230509075113.5cosbeaoykdoiefa@mraw.org>
Organization: Debian
References: <20230508220126.16241-1-jim2101024@gmail.com>
 <20230508220126.16241-5-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udbgdswpzmjgu2ia"
Content-Disposition: inline
In-Reply-To: <20230508220126.16241-5-jim2101024@gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--udbgdswpzmjgu2ia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Jim Quinlan <jim2101024@gmail.com> (2023-05-08):
> The current PCIe driver assumes PERST# is asserted when probe() is invoke=
d.
> The reasons are as follows:
>=20
> (1) One Broadcom SOC (7278) causes a panic if the PERST# register is
>     written during this time window.
>=20
> (2) If PERST# is deasserted at Linux probe() time, experience and QA
>     suspend/resume tests have shown that some endpoint devices fail if the
>     PERST# is pulsed (deasserted =3D> asserted =3D> deasserted) quickly i=
n this
>     fashion, even though the timing is in accordance with their datasheet=
s.
>=20
> (3) Keeping things in reset tends to save power, if for some reason the
>     PCIe driver is not yet present.
>=20
> Broadcom STB and CM SOCs bootloaders always have PERST# asserted at
> probe().  This is not necessarily the case for the 2711/RPi bootloader,
> so, for 2711/RPi SOCs, do what Raspian OS does and assert PERST#.
>=20
> [1] https://lore.kernel.org/linux-pci/20230411165919.23955-1-jim2101024@g=
mail.com/T/#m39ebab8bc2827b2304aeeff470a6c6a58f46f987

It would probably make sense to remove that [1] link entirely, to match
the reference removal between v4 and v5.


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--udbgdswpzmjgu2ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmRZ+3EACgkQ/5FK8MKz
VSDPThAAnjd8pxRB2dH/ulH/Kg5l7D03KJPKpRRNXw9EvnVD25SsERIcoGvzS6+E
b6UhVz/DznrrMZIa3m4URUkYZjAKOs4epXEpIHMLY6hHtdlSq4fVNN4MGjVGF8Gv
P4ZRrh8MgX8dbGsWpew146ftkUAlDxF2tJH+m5/URm6ME6equZYmyY/hcak2GE7X
i74oEb8UkC3QfTXKL4APwfSirU8XoyjTjdmfkB8PENVMfh61Z0SM4x+f9vSVYEwX
AqkCHruEO4IfmP7A1d1vsjP0dGdYDojknZnNBBeBGfUGisFMN0QFqBoUfcXOJuuF
b6UjJT2RNgFyVmqRKvP4nVEFpIj23eah/2uBDfgLbS/6dqbwKTuxgZonHkASJkLK
gh67DnvMOht93JV0hT43XObjm6v+2yh4TXXNnVniywMhSGNEuJjrr4fYxS1Puq80
DzoxRvgAfpe2xRUBom0/SxJGBJKOZFzZmSQh5B2yaeizei7p2mdaWXCfKEtMDbI1
Z8K2rK5iXEidcDbu4Xw8znhWjg8/ukKH7dlAlkzYGY/aM8unpIEasHPJFos0oU1A
JyRrDsmHgMfhU8VllwcaU7g/Nef4WcFAwoBxWBm1lWW7YlpP9k0emwcRtMYm9fZz
Tbt/RWlpSLNku1m4GauKpOOS7cstZF5/727QA0ep4re31xQEdPI=
=y2a+
-----END PGP SIGNATURE-----

--udbgdswpzmjgu2ia--
