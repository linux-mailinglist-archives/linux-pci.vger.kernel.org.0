Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02A758197
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 18:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGRQBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjGRQBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 12:01:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38221737;
        Tue, 18 Jul 2023 09:01:41 -0700 (PDT)
Received: from mercury (dyndsl-091-248-212-239.ewe-ip-backbone.de [91.248.212.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06D716607029;
        Tue, 18 Jul 2023 17:01:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689696100;
        bh=fjD/ofT/AJheOC0PpncIwEm97OhHZA/Z2aAcGGQekfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgKIwJjTZLCYtJFI9C3oTjp3n/iC1v4sfaZySSF6luarFGrq212CEA63pyZN4Wv4w
         I9SYa9dQcjJfBCZSbae+1xeSgfb3V/Eo6CrPj5rv3RovFYVc9xJa18Iq8xboSoO/uX
         Ye1IpLqjlGbw5GA4KE2SgMCqCGLsCfRqDhFErHd9biSHPiz/NxzIRsxMr3OgOrtosv
         Ee9kTJptGs/bqm+oj806e66MWjpUt6u0QiaPfobNNYJd5lXFKjNG2MRRnE9odSH0uG
         x+QLk2GR9Q1M0YGcNg1GixOkLrl2bV1YJ9un0qyRUbK1FJFfef7sxMruE4vmApL/MN
         Uo0XN6rFUBzAA==
Received: by mercury (Postfix, from userid 1000)
        id 78BB510607FA; Tue, 18 Jul 2023 18:01:37 +0200 (CEST)
Date:   Tue, 18 Jul 2023 18:01:37 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, John Clark <inindev@gmail.com>,
        Qu Wenruo <wqu@suse.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: rk3588: add PCIe3 support
Message-ID: <20230718160137.sfitnkl6gmyi75jx@mercury.elektranox.org>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
 <20230717173512.65169-3-sebastian.reichel@collabora.com>
 <ZLarQUvUK3v3m6Cg@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xub73vban4yxnem"
Content-Disposition: inline
In-Reply-To: <ZLarQUvUK3v3m6Cg@bart.dudau.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--4xub73vban4yxnem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liviu,

On Tue, Jul 18, 2023 at 04:09:53PM +0100, Liviu Dudau wrote:
> On Mon, Jul 17, 2023 at 07:35:12PM +0200, Sebastian Reichel wrote:
> > Add both PCIe3 controllers together with the shared PHY.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588.dtsi | 120 +++++++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot=
/dts/rockchip/rk3588.dtsi
> > index 88d702575db2..8f210f002fac 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > @@ -7,6 +7,11 @@
> >  #include "rk3588-pinctrl.dtsi"
> > =20
> >  / {
> > +	pcie30_phy_grf: syscon@fd5b8000 {
> > +		compatible =3D "rockchip,rk3588-pcie3-phy-grf", "syscon";
> > +		reg =3D <0x0 0xfd5b8000 0x0 0x10000>;
> > +	};
> > +
> >  	pipe_phy1_grf: syscon@fd5c0000 {
> >  		compatible =3D "rockchip,rk3588-pipe-phy-grf", "syscon";
> >  		reg =3D <0x0 0xfd5c0000 0x0 0x100>;
>=20
> What tree is based this on? Even after applying your PCIe2 series I don't=
 have the above
> node so the patch doesn't apply to mainline.

You are missing naneng-combphy support:

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/co=
mmit/?h=3Dv6.6-armsoc/dts64&id=3D6ebd55b3bba383e0523b0c014f17c97f3ce80708

-- Sebastian

--4xub73vban4yxnem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS2t1IACgkQ2O7X88g7
+pqi5w/+MtPLKzu0zQdj3a5g9sZvB/lE1Ajhuqbg99UmDnDpcKnAmovt4GrDpl9D
czMjsyIfV2yuvu3cb2quGMdn0oU61vE/Kbi5vnr9PWCWAeljpko+f45Qm9qR9GHb
+EWu4q5jtw5hsQrMLrGztOcKeM16eY/ArHFlwNtc2paHAS0AyAGDrJFsX31+3/b6
rWGd2bdbeo+06VOcFjNO+eZPPb2ayUOzgPk8pvtUrUbHlE2pUj6XAAlvLHk7Cb/x
yPkW9lw29OY/+acWnZTDBTCEGHfwHr8my8L3JN0K1ayMTFlDhDFWyxZCZH8iDweB
Aiwmhnt7hR1GhY9590dIgOjt+GV3Qph1G2wVAaWV4KMEbBG6xf+X3IpOwC55nqDt
W9/Z9wpb0OZye+JTIeap7L8tGPVP6SFjQdPf4fWt9D3O13EhgwHSOZLTCaq0oGXu
Cp05ioeDHq9NU/NA6YrOa8YBC/i9FfheGwaRGcpKqMakhMxk9TNpMWqDQ00ASY+9
33IgWjLXICSnrgogB0hXwrPwT7+loIBCbXNy8+U8F0IuICu0WCy6x0TlyDfJP+aM
vAscSUpMqYRHVPSbfO5eOS+dUtnBOLimZt5GpRYHu0cjSisD1rAh+kzPAGpsAE6W
sY9NKRcNxncmrDygY3nmTX6z7gVMVtPMXkBu19+KvRtq3y/o7U0=
=hXOJ
-----END PGP SIGNATURE-----

--4xub73vban4yxnem--
