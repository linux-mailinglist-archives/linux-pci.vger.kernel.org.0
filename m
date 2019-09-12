Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF08B0BD2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfILJrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 05:47:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfILJrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 05:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nd0o0f4/7BjLAconWp05z7n4at/FQXG4cF5ZBRu8Iz8=; b=FZECb2efh+R1EzviX/GYgZl2a
        lPck10VYa9Dj7/IVHkMV6O21mBR2fETXaolP9KAiwHpIF6QqnHL6ru/4UvyDVhzNJXf1Zqt5EExpA
        MzLsu1BM5dm+CI7+qFVmEDHujNsHNNRxWoRyH0xvvB8deJ6KUmyUZ/Lv3HU65DJOKqkQo=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8Lgs-0006SK-MV; Thu, 12 Sep 2019 09:47:02 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id D4417D00AB0; Thu, 12 Sep 2019 10:46:51 +0100 (BST)
Date:   Thu, 12 Sep 2019 10:46:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] Cleanup arm64 driver dependencies
Message-ID: <20190912094651.GH2036@sirena.org.uk>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2eauhx3HRLXw1WRo"
Content-Disposition: inline
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2eauhx3HRLXw1WRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2019 at 03:48:44AM +0530, Amit Kucheria wrote:

> I was using initcall_debugging on a QCOM platform and ran across a bunch of
> driver initcalls that are enabled even if their SoC support is disabled.

What exactly is the problem you're trying to fix here?  For the
drivers I looked at these were bog standard register the driver
with the subsystem type initcalls on optional drivers so not
doing anything particularly disruptive or anything like that.
For any given system that's going to be an issue for the
overwhelming majority of drivers on the tree, including those
that aren't associated with any particular architecture.

--2eauhx3HRLXw1WRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl16FAsACgkQJNaLcl1U
h9DVVgf6Aty/MAqUrwPqV8+kec9c5CmVjUbla+Dxmxbc4XJOZLGCsCRCoPINUSy7
IHCZ2hFHKKPnv5Jt7YQ0iwEiEQ4i93A1zc8OPGuiJ+R7I1MBAmtzS8OkLN+hTK2Y
jtp8IcYRXPWPFSio2smmqIE0CoAlCVfxMYwgQp5a96Ra3qOnQm5x4LC5M278KJLP
HrorLSGCRanptsaI5xCgfG0hUjMzJI8F4/Cd1LBt082FOXSaGMptsRmBKco2ea/4
AWJ9eTsf+TYSSy1qJwFqd7GXKNRY03RU+PFhs76MNmVZdowkRKVFM8y+nGBNbPmp
It+dwnrew9x+7L0s0apty/0gLRnzyA==
=ZOLi
-----END PGP SIGNATURE-----

--2eauhx3HRLXw1WRo--
