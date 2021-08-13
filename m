Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5F53EB9AF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbhHMQCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 12:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241349AbhHMQCD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 12:02:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30C7E60FC4;
        Fri, 13 Aug 2021 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628870496;
        bh=eLebXlVu6RTNHtlBr3MavHA+nmxGCpm8/vDDNL6AUJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCPNX7RlFSfcKvVLfK2y3Jl5XFpmpFMn/kFwVRo0Yoh5n0Dt39MJ/G2VOFkSu6EaT
         81qqm+Tirad290QNC5mwKRYU1AC01XG7bh1YNmctzFD3PlIyPZIg9KwvYYaAPKPVOP
         exymlxMegRBNS7Sv1uMS4fWU20aC52D/6AGCf70RKaPModZQq+tL4MJDOhp0Zh7b0r
         zz/FnO5Glda91rNuaxbJL6z3+Px/1ru3G0HO056j2qeNaOzhkvPTdbOZWVqXdLWdDt
         s5GSNFMIzjgMoNTI/a6CTsBJ3/6nYaspQ09ogRyn+1Wm5IN2nwX0/zdoYQsRk1UlEL
         0zVjmIWLErASA==
Date:   Fri, 13 Aug 2021 17:01:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference
 in probe
Message-ID: <20210813160116.GE5209@sirena.org.uk>
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <CAL_JsqJ4Dadf00pJxEDd14zbWyN99s1A2L4fxZSkZddeg2pV6g@mail.gmail.com>
 <81b9a25d-f12f-90e0-0b05-b5e396f14c08@arm.com>
 <CAL_JsqLWVLRDdkR62BSv69oW3QCLVebgpU1TKtxvzZmD4wuP4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLWVLRDdkR62BSv69oW3QCLVebgpU1TKtxvzZmD4wuP4Q@mail.gmail.com>
X-Cookie: E Pluribus Unix
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 13, 2021 at 10:57:44AM -0500, Rob Herring wrote:
> On Fri, Aug 13, 2021 at 8:47 AM Robin Murphy <robin.murphy@arm.com> wrote:

> > In fact it's the other way round - "optional" in this case is for when
> > the supply may legitimately not exist so the driver may or may not need
> > to handle it, so it can return -ENODEV if a regulator isn't described by
> > firmware. A non-optional regulator is assumed to represent a necessary
> > supply, so if there's nothing described by firmware you get the (valid)
> > dummy regulator back.

> Ah yes, regulators is the oddball. Surely no one else will assume the
> same behavior of _optional() variants across subsystems... ;)

It would be silly to copy the *whole* pattern!

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEWl0sACgkQJNaLcl1U
h9AWngf9EmuXkHFWSOYnfO7Y0ZVqCKtx2n3Z4yWOugf8kKVfrU/Jl4Vd5eE/P5gF
5OVayvHPX8JCwCtV/EPX6vQQoGbPD6rbNyWmsRkCN73iqT3WBIieZqEDmbvNo9UI
bW30zehOnqz2NuSie+qk0RZ23hLVdhEVbidMVnZjnXUtiPHR8K6e5o4ugdXBnasP
LuAzqewWfVnzglouTgPJbWu52Gf9R6TO/k1OC8UhFEQP+nk8tEnOGZel7nuHMBdD
5E469rHqG/n2gMyGPVVIQckcgGokMjnF1nwyQ6O5fLRMAQVpf4WHRUybcsjzbDx+
KBQxF1a6o8r3bOPWZcAEdLM5DjJLHw==
=NuQM
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
