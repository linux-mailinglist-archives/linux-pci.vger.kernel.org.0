Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B376DE87E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 02:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDLA0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 20:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLA0c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 20:26:32 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E92D3;
        Tue, 11 Apr 2023 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oi+javVlViAf4EjInPqqFRpG+lPC235NHVxTYPy83Pc=; b=qGtIBd8qoTQvC9rbTN1JeCR3qW
        UVut0/l1N/MsnfNw4HUr00Qd9GxECbA3IRCRBsLaxF1jDR5T4SwN1BHsI51FzSOG5p/H07zZMLcqq
        vVBtg3p+/emgHINNlEVJXzwT3a7/QAyVOdErLabINOTj0no0nDzETKo9PLvVR/CGhofmGr/kS4Ep8
        8hKX1BQPoL9u74G+8I17P23jiKbUNpLHqv8MDTByX6LcZXV6z3PBIiLk1KuDO+8MZ/t4aN3AA9t02
        FQVmDOVdOS755tEs4MR5UT29UdaOyrpT9UzkUwM+Py6nW2XaQB8+IqcvWNP0mf69J5O5wef3FdaYT
        lpwBy6Vg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1pmOJb-00GhHJ-UI; Wed, 12 Apr 2023 00:26:24 +0000
Date:   Wed, 12 Apr 2023 02:26:21 +0200
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
Subject: Re: [PATCH v2 3/3] PCI: brcmstb: Set PCIe transaction completion
 timeout
Message-ID: <20230412002621.nuxkiflumz4vbang@mraw.org>
Organization: Debian
References: <20230411165919.23955-1-jim2101024@gmail.com>
 <20230411165919.23955-4-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhilsb22jfyf7zcz"
Content-Disposition: inline
In-Reply-To: <20230411165919.23955-4-jim2101024@gmail.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--zhilsb22jfyf7zcz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <jim2101024@gmail.com> (2023-04-11):
> Since the STB PCIe HW will cause a CPU abort on a PCIe transaction
> completion timeout abort, we might as well extend the default timeout
> limit.  Further, different devices and systems may requires a larger or
> smaller amount commensurate with their L1SS exit time, so the property
> "brcm,completion-abort-us" may be used to set a custom timeout value.
   ^^^^^^^^^^^^^^^^^^^^^^^^

> +	ret =3D of_property_read_u32(pcie->np, "brcm,completion-timeout-us",
> +				   &timeout_us);
> +	if (ret && ret !=3D -EINVAL)
> +		dev_err(pcie->dev, "malformed/invalid 'brcm,completion-timeout-us'\n");

v2 renames brcm,completion-abort-msecs into brcm,completion-timeout-us
but the commit message mentions the half-way brcm,completion-abort-us
property instead.

(Also spotted =E2=80=9Cimmplementation=E2=80=9D in 2/3 but I thought I'd sp=
are everyone
an extra mail.)


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--zhilsb22jfyf7zcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmQ1+qkACgkQ/5FK8MKz
VSDR9A//SGkUb7J8cgwWLrNmjetx04cvntLjkLt8/1iwZAGeEfIbD4VoeAxedneM
ZcsuIW9DwkS9pnU/TBhyuTAMQ0F+fTX4EeunPSmE6jjLUPffDD2Z7Pqlygblq59r
+n2i17q26DP4ol6Vq7yKMmhPjldfI9SaImL+DzOsMITGG/D46vTmXJh8cbKEEpAw
yZ163qBDJYnz5WI6fNbV/fU0NfIi2DiNHSDE1wWG5yEkAThchGGDXFabJIXuVWT4
mQfflVQtniOLIohENmJQNRdG+AdveTBTXZ3N6vriFJR0E64rUcno89PKRSdLuyv9
z7ihC+3AWGhZoIszb3R21bqU5kKJH/u62E9GB4BsQX/WwkGZD4bhUxExFak1ohaI
HmHtG9Hwr8+ddUkQuNAT2MLyI0mav98fDkL5KN7gnmlRzCnlFp2BiJCdmdmvt6HB
3BjRhfZSDNtv+vJIOUqYUUIS3DQ91Bj2e7TL9FuO99MDTzFKKjJ03A0A5xJxg2Sj
qqegAd9kXWZuYD2OGJuVGFGEpt10ff0+Kpd2dHUfWXwjOkucMEJYi5pUR6QDrs28
mLnO+llKJmf1W/3Idsci5yPNB7EjJfpMBsHspz+zzQD5EliZH5Nud98nL0jvKs4U
zUagyQ8qTk6CLy8XkqZAOizzuNvpyfIv8uROm035MjGn2HRZzDc=
=VjoP
-----END PGP SIGNATURE-----

--zhilsb22jfyf7zcz--
