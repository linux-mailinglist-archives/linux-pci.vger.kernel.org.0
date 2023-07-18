Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F675867B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGRVGH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 17:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRVGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 17:06:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BEA198C;
        Tue, 18 Jul 2023 14:06:05 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 88FAE6607069;
        Tue, 18 Jul 2023 22:06:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689714363;
        bh=P8NfQ7uDwtPYApAvymtjd67EMP/MgNzxJCZGTG1lf9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ck5xHUSxGTBnWjiwmCdofgUj66JYAJkf7+mfvFzo89gNFmGrCkzFbdpvcWCdTer4Y
         2V0O0M1lPNqa/+2k+Do8oVAIF0N3seNqhGFnavwoS7HskyI/u3gbIvqEXxUB7OKyO9
         /Sodz0w4oBY4OQczw+7S9juPU26NIzbQCelnw7D6wQ3qDu0IH9LjebDQpVlk2Ugu6I
         Dd0+NV6vdK54FeSCOM8M9P9iDbOAuri7xMUQc8r0rYUYT3Py3Wsz8OBCB2t2iHFAQd
         Zm/fxII+Wd6aNAwJfvTsrRsXZG9XzYCYLqgjpMcbJArUUTK06neDsSuu0i8G78M6B4
         r64RzPKNEqsgA==
Received: by mercury (Postfix, from userid 1000)
        id 9867710607FA; Tue, 18 Jul 2023 23:06:01 +0200 (CEST)
Date:   Tue, 18 Jul 2023 23:06:01 +0200
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
Message-ID: <20230718210601.6hrmnl5lbtl6vinp@mercury.elektranox.org>
References: <20230717173512.65169-1-sebastian.reichel@collabora.com>
 <20230717173512.65169-3-sebastian.reichel@collabora.com>
 <ZLarQUvUK3v3m6Cg@bart.dudau.co.uk>
 <20230718160137.sfitnkl6gmyi75jx@mercury.elektranox.org>
 <ZLbqPB5yP7Kn6FT6@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="negfuutklnlaveud"
Content-Disposition: inline
In-Reply-To: <ZLbqPB5yP7Kn6FT6@bart.dudau.co.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--negfuutklnlaveud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 18, 2023 at 08:38:36PM +0100, Liviu Dudau wrote:
> On Tue, Jul 18, 2023 at 06:01:37PM +0200, Sebastian Reichel wrote:
> > On Tue, Jul 18, 2023 at 04:09:53PM +0100, Liviu Dudau wrote:
> > > On Mon, Jul 17, 2023 at 07:35:12PM +0200, Sebastian Reichel wrote:
> > > >  	pipe_phy1_grf: syscon@fd5c0000 {
> > > >  		compatible =3D "rockchip,rk3588-pipe-phy-grf", "syscon";
> > > >  		reg =3D <0x0 0xfd5c0000 0x0 0x100>;
> > >=20
> > > What tree is based this on? Even after applying your PCIe2 series I d=
on't have the above
> > > node so the patch doesn't apply to mainline.
> >=20
> > You are missing naneng-combphy support:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.gi=
t/commit/?h=3Dv6.6-armsoc/dts64&id=3D6ebd55b3bba383e0523b0c014f17c97f3ce807=
08
>=20
> Thanks! It looks like the PCIe2 commit that adds support to rk3588(s).dtsi
> files is also missing an #include <dt-bindings/phy/phy.h> for the PHY_TYP=
E_PCIE
> use, otherwise the DTS fail to compile.

Yes, that's also already in linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/co=
mmit/?h=3Dv6.6-armsoc/dts64&id=3D34d6c15d8e86256ef2456c604b1c8d8242720871

Greetings,

-- Sebastian

--negfuutklnlaveud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS2/rUACgkQ2O7X88g7
+poRUQ//bWq65lFTU9ZY7ptS5NZJgJGv19zMVv12ex71HIVrPglf+IXlKlCG76yv
HygNtK+lU7MnATs9ZcTMf0oW95sr/6GQRwsnAOlqspsdx3vnpqVZASdAYYiF64jI
9MBjsXXey4VbvnLqSUO6KyORxWpIQV/rT6ppewTxdRU02b5T9WmGUmKsFXcnAewL
Y5+rLhfPncD9RuSewzXeBoY4S337sZB7q8CzOzZrtEq2hTiZQUcNFd8LF7EgF+er
PnoVgC1mhuYbnmaphfTW1A9lP7TBLvRcGi6EiI4Qa9i0PLcaWPdZ3zEbnqjBeZdP
nVOTVr4Z8ZgP9JG6em5lcQBOQPO/Ae1ne9A8n98kmc6xQqpiFkx38XCwOgwqBxHT
gOXj8qFI022fWG8VmS7pBest26nZ6/TYNlHXxdq2FtA9fG8+Pk029pDHUpX6yLNw
zpIj3zkaPHzdFywJ0aFJH2zTHxQFTCkgvfDjlqWOjfSzR2v4yNr5uurVEE+nEDo0
o2SoEUXX53l0Pcbewa6tTgD+pnVNgsDnydXsN6qvhXK7/4m5aNGBsJqI5hvFbELF
D9iu3XUkcUI2sin1c8SO+OwBsBfFem24u/0ODDqkx87wyzXSnbXR0NzDF+DwD5Wm
8h1cyB2ja3yC3/+YSsXtovn1sxuJlOOM+rtHJe2Ht/N/OJk59Y0=
=Brsb
-----END PGP SIGNATURE-----

--negfuutklnlaveud--
