Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0433175FFBE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGXTWa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 15:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGXTW3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 15:22:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00296122;
        Mon, 24 Jul 2023 12:22:28 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E03856607036;
        Mon, 24 Jul 2023 20:22:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690226547;
        bh=aLQXdltzJfxQ4uDLWVoF/awD22D2bQ3Zo59NB+NIdPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MM9tk0RTRZVJxNlAEHgfxstWMNLt++yB3cQGLsxEmKv4CXyO7KkPeu0V8/S36vl3U
         e+9DH60i7YSH7bPS5mlaqXw/CLr4G/R02YwrRgaoU7FZa5+sqgIB65NnA2ziPlcWeS
         7XNKXuaHtSHH248rdbZVU7atsRU5bLHx6602hJUeXJS4PPGZJUi7GPb1vWrYHrcNzh
         QGwfAUgWbmXekx8MAKHctbUyFQEXSF6VYqxaKHrBaIZXeTl3LX7d8XavsmZ9RpzTbp
         BD+1mphVt47FQMtajBt+/O2SgnBal13fnYCB2/s8o/DQ9Kd/vpRgjMsQFgeDx+wZGY
         AByGuLJZQBSpg==
Received: by mercury (Postfix, from userid 1000)
        id 597F01067453; Mon, 24 Jul 2023 21:22:23 +0200 (CEST)
Date:   Mon, 24 Jul 2023 21:22:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Qu Wenruo <wqu@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Simon Xue <xxm@rock-chips.com>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, John Clark <inindev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, kernel@collabora.com,
        Vinod Koul <vkoul@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 0/2] RK3588 PCIe3 support
Message-ID: <20230724192223.5jnu5wgrzmmjz5z5@mercury.elektranox.org>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
 <169022594803.2911118.12432442062352790360.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nexk2ndejsfescch"
Content-Disposition: inline
In-Reply-To: <169022594803.2911118.12432442062352790360.b4-ty@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--nexk2ndejsfescch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Mon, Jul 24, 2023 at 09:12:35PM +0200, Heiko Stuebner wrote:
> On Mon, 17 Jul 2023 19:35:10 +0200, Sebastian Reichel wrote:
> > This adds PCIe v3 support for RK3588. The series depends on the PCIe
> > v2 series [0], since the the same binding is used. It has been tested
> > on Rockchip EVB1 and Radxa Rock 5B.
> >=20
> > Note, that the PCIe3 PHY driver is currently missing bifurcation
> > support for RK3588. Thus after this series only PCIe3x4 is usable
> > (in aggregated x4 mode) without adding support for the PHY's
> > "rockchip,pcie30-phymode" DT property, which allows configuring
> > how the lanes are distributed. Aggregated 3x4 mode seems to be the
> > most common configuration. Both EVB1 and Rock 5B use it, so I
> > cannot test anything else anyways.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [2/2] arm64: dts: rockchip: rk3588: add PCIe3 support
>       commit: 0acf4fa7f187cd7e3dad93f1ee14e9509687621e

Applying this without the PCIe 2 series being applied introduces
warnings for the RK3588 dtbs_check, as mentioned in the second
setence of the text you quoted :)

(FWIW RK356x already has the same warnings, though)

-- Sebastian

--nexk2ndejsfescch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS+z2MACgkQ2O7X88g7
+pro9g//epEbLx9hS9MzsBCHWVh8CFoCTo1K5A7BQ7xhse1I8Lt5W+CHnuwMPbfK
VukzVll6W+sDQqmiVvwCGz9tB3cFk+SC8whOSDCdE4RoQ/OYIoVeC4EansyAarKF
t7m3Ol8N2qgQHhE49T21otdL72TPqP3fQuUuD5hYwGgGQpTgJat0L6+SdLTqSjE7
StBWwGhsDyS5WhnsVXMTGU+FSHp3gL16+zgeARqMc+6GJFa6Hl7FZEV0AjoFZa2L
VyRxxg0VIca6gvz8RvJWrGKWGeApFM/M5PWOZYQZ8eCggcSIL4zIpi6t4BVJhfBD
ERv3l/P5h5/S5Tc1IIw5Y57MqbHtpbQzQBwc6P7DUzjRZE+lsAA4U2QqBBSLw2KY
Xt3DPS6k134wIDd/e3WPJjh8zT3OU1OsZuaMtL0fQeMPvV1Bc9nuBtHOl84D9fm4
57FZUGOewRbL9QGTqFPMb6wF/rT3KZmj5sIIAvhtBUoybhzcFDN438ZJ3vPzmE7K
ocb8RW/2zhX5RgFO8s2sOsJq/D7ZCmLeVRs4CLAWvt05zDsgX2yE3bgZW+74xTWe
mSzVWncL2+OPmQSy7Aw0nWEyyLlE7lCdCXN+I8dAce23LgbydLvHvhEt7qPDvCP0
u9sw6VUb8F2tDu4GR9P+OtHG/nzFIUPETHv8sIDHftc4IEJUoLI=
=47as
-----END PGP SIGNATURE-----

--nexk2ndejsfescch--
