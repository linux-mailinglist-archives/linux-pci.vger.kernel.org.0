Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F8E1004CE
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 12:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKRL5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 06:57:08 -0500
Received: from foss.arm.com ([217.140.110.172]:33256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfKRL5I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 06:57:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D6E41FB;
        Mon, 18 Nov 2019 03:57:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F006A3F6C4;
        Mon, 18 Nov 2019 03:57:06 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:57:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     shawn.lin@rock-chips.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, heiko@sntech.de,
        lgirdwood@gmail.com, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: rockchip: Make some regulators non-optional
Message-ID: <20191118115705.GB9761@sirena.org.uk>
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
> are thus fundamental to PCIe being usable at all. As such, it makes
> sense to treat them as non-optional and rely on dummy regulators if
> not explicitly described.

Reviewed-by: Mark Brown <broonie@kernel.org>

This not only makes sense it's a fix.  regulator_get_optional() should
only be used if the supply may be physically absent (eg, when the
feature can be left unpowered or where there's an option to switch in an
internal regualtor). =20

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ShxAACgkQJNaLcl1U
h9DCtgf/RQHTCds9GoZ1Sj3Tl0J5+R70EQ9c6ISqtLqjuDF/emFg+BU55Dke2NTj
0eNey3v6n5wVJjD9wSyJ8+WVnMtlSAY7LT7tyMmZGt9PNzzJbFZwiF+7ep/Na16w
5+mt+ntFxabbeb1pGl8G/A8nF8j5AjrMmTYwRBXiF/kPKyZn2HjDknuIX+pbDmvB
vwb00AIe6ffnIBIyjuAz9GKdZWhXmrFJ0zhTjXJX3FDVWEZF6opRvssMoyT+f3Dp
MwheEYpDTqA+EpAqj7MgKTYM4aXQGLpeGq58FnYc0VJYc/ste4D2jT0hwLdPVhju
VKbmII5/jnkdEF1IJ73y1lbEXMF8Hg==
=lbFC
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
