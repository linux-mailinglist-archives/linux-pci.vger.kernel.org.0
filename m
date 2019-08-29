Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1306DA17ED
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfH2LRe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 07:17:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2LRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 07:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HtmG+dCPEeWQzFu0OvEe2yrO1XknJ8B7vjHNJN+kyH4=; b=f3MjT4CHkrblBLAaF+oNx9P/K
        OC7OV47buHCl1ELt1LJ1mhC2MKJj5OFqrSo3rN26TvpPMd4MOIGhsSWRzX5aEN/CpxniZyldOWEq0
        eP5Czo9wxNLMBhtGSZ1uqVTREMrZtDhMIWQuNTRxAwi5wGRlL2zqNu5ub/S9KVAJXAauk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3IQj-0001Dg-Vx; Thu, 29 Aug 2019 11:17:30 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 175A327428D1; Thu, 29 Aug 2019 12:17:29 +0100 (BST)
Date:   Thu, 29 Aug 2019 12:17:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829111728.GC4118@sirena.co.uk>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
X-Cookie: Lensmen eat Jedi for breakfast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 11:09:34AM +0100, Andrew Murray wrote:

> But why do we return -ENODEV and not NULL for OPTIONAL_GET?

Why would we return NULL?  The caller is going to have to check the
error code anyway since they need to handle -EPROBE_DEFER and NULL is
never a valid thing to use with the regulator API.

> Looking at some of the consumer drivers I can see that lots of them don't
> correctly handle the return value of regulator_get_optional:

This API is *really* commonly abused, especially in the graphics
subsystem which for some reason has lots of users even though I don't
think I've ever seen a sensible use of the API there.  As far as I can
tell the graphics subsystem mostly suffers from people cut'n'pasting
=66rom the Qualcomm BSP which is full of really bad practice.  It's really
frustrating since I will intermittently go through and clean things up
but the uses just keep coming back into the subsystem.

> Given that a common pattern is to set a consumer regulator pointer to NULL
> upon -ENODEV - if regulator_get_optional did this for them, then it would
> be more difficult for consumer drivers to get the error handling wrong and
> would remove some consumer boiler plate code.

No, they'd all still be broken for probe deferral (which is commonly
caused by off-chip devices) and they'd crash as soon as they try to call
any further regulator API functions.

> I guess I'm looking here for something that can simplify consumer error
> handling - it's easy to get wrong and it seems that many drivers may be w=
rong.

The overwhelming majority of the users just shouldn't be using this API.
If there weren't devices that absolutely *need* this API it wouldn't be
there in the first place since it seems like a magent for bad code, it's
so disappointing how bad the majority of the consumer code is.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1ntEgACgkQJNaLcl1U
h9ABVgf+PnY8jFt1zJObhfDV6Gu7VFlM/nzHD2Z12tEzA3hD2TOroMZZSaL7D5Xq
B0zOlO220NFjBWvStEp/08VUiTjojgZd1Yx1nVYU2EJExWT2krDLiiFBdmHiN3f2
VAdcd7Ihvzo80sOJS5VtV/ydOxC7/UKpZ+A3T9FsJu46eqfkSEfLXQMfFfl7KD6h
Qn73oLFW6b8MCNQ+hXa3z/8fOo8m7DGm5HUzhN2pnLEwOzNOHUtkQq/vAA4XWlCe
aWfM4h5EDzkILenDC7g3ujdLmthwsDtQhHyGACoXds6rj0KhxZPjTx1B/P+/kKja
5cqeTgEgOlf/ZiUhej8henwpqMT6gA==
=lW4s
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
