Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F1B0C2A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfILKDS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 06:03:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730580AbfILKDR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 06:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fKTvRv6acI6xTKbQcP4YowzP1qiooahYb40b5oOq4F8=; b=LVfeEOZxnZs9uLcyFI5eOvY0Y
        sHTEK9YhOvAX4uoCWNT+ZXbnxfhjIhq2IKF2WPB/K+pwwTogjzyHr3njGvltSjsEbrN61/dsd2zi4
        HckiBBMdLRqYpztgOJOcJ7f7J8msc14CMj0ZugjpX/Bei6tDG7lgmfhnL7/OXspPSXlWk=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8LwT-0006Tr-73; Thu, 12 Sep 2019 10:03:09 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7DAE7D00AB0; Thu, 12 Sep 2019 11:03:08 +0100 (BST)
Date:   Thu, 12 Sep 2019 11:03:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 0/4] Cleanup arm64 driver dependencies
Message-ID: <20190912100308.GJ2036@sirena.org.uk>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
 <CAK8P3a2zGJx7SCA4LUHPGTybN8GU16Ah3H0FbaOEwR3H7uGCnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2+N3zU4ZlskbnZaJ"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2zGJx7SCA4LUHPGTybN8GU16Ah3H0FbaOEwR3H7uGCnA@mail.gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2+N3zU4ZlskbnZaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2019 at 11:29:00AM +0200, Arnd Bergmann wrote:

> Generally speaking, the way that works best is

> config SUBSYS_DRIVER_FOO
>        tristate "SUBSYS support for FOO platform"
>        depends on ARCH_FOO || COMPILE_TEST
>        depends on SUBSYS
>        default "m" if ARCH_FOO

> This means it's enabled as a loadable module by default (use
> default "y" instead where necessary) as long as the platform
> is enabled, but an x86 allmodconfig build also includes it
> because of COMPILE_TEST, while any configuration without
> ARCH_FOO that is not compile-testing cannot enable it.

Indeed, though we shouldn't be adding any default m/y to things
that don't already default on.

--2+N3zU4ZlskbnZaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl16F9sACgkQJNaLcl1U
h9Ci2Af7B7FanodOlLyNC/81WlZgesS4wjgnyaCyQT3+zuq2s1GhWqi5hjCHjEoj
ETYClFdHppnDJyaZOc5r5Qsfc70PFx9yOhfW+CCj+HSKr5t+vdCBUDgvt3g96iOD
7ysX9c0wyFOkUrz925HBBAiQ0itApHDy/4T8RvruV/N3AfDWO/PWIEbycIXIoFez
9v3E3yq5VgiiGY6zrOY8eWXWDGCkGvyxNef+b5QfezQ9KN64Z4MxaQ1gIVv5e/3Y
8D2CLhuuyEhs17nVO8SdkWi9n2XTFO0WrKgw+clKE42DwYTQvaeT82ZDO7QKF67t
UTzhdPw57kbA4tBu966JVyebsrMBMw==
=+Vyp
-----END PGP SIGNATURE-----

--2+N3zU4ZlskbnZaJ--
