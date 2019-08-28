Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003D0A0CB1
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 23:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1VtG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 17:49:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57188 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfH1VtF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 17:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fC5sjt4MIhFSGtkVL/sP3eYBa4YlL/cGDscVvzG7WNc=; b=NwGUw730cUnyF+Mf+6709LYhW
        7TMti+3tppYhsVBhwcF5b6DkwMGTgENut0SOiQ1OFFO/HQCm0Zo72VqhfSAsH6s4VCZic27n/pAjD
        Hfy4L8vEuJkVigTYS7dbMb0b9PTW+nriwyL7DXGWRUaYMy0P1KVPvM3xkZ1Vu2lGayTJs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i35oM-0006pU-5X; Wed, 28 Aug 2019 21:49:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2B62C2742B61; Wed, 28 Aug 2019 22:49:01 +0100 (BST)
Date:   Wed, 28 Aug 2019 22:49:01 +0100
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
Message-ID: <20190828214901.GM4298@sirena.co.uk>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkcDP0v44wDpNmbp"
Content-Disposition: inline
In-Reply-To: <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
X-Cookie: Oatmeal raisin.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kkcDP0v44wDpNmbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 10:26:55PM +0100, Andrew Murray wrote:

> I initially thought that you forgot to check for -ENODEV - though I can s=
ee
> that the implementation of devm_phy_optional_get very helpfully does this=
 for
> us and returns NULL instead of an error.

> What is also confusing is that devm_regulator_get_optional, despite its
> _optional suffix doesn't do this and returns an error. I wonder if
> devm_phy_optional_get should be changed to return NULL instead of an error
> instead of -ENODEV. I've copied Liam/Mark for feedback.

The regulator API has an assumption that people will write bad DTs and
not describe all the regulators in the system, this is especially likely
in cases where consumer drivers initially don't have regulator support
and then get it added since people often only describe supplies actively
used by drivers.  In order to handle this gracefully the API will
substitute in a dummy regulator if it sees that the regulator just isn't
described in the system but a consumer requests it, this will ensure
that for most simple uses the consumer will function fine even if the DT
is not fully described.  Since most devices won't physically work if
some of their supplies are missing this is a good default assumption. =20

If a consumer could genuinely have some missing supplies (some devices
do support this for various reasons) then this support would mean that
the consumer would have to have some extra property to say that the
regulator is intentionally missing which would be bad.  Instead what we
do is let the consumer say that real systems could actually be missing
the regulator and that the dummy shouldn't be used so that the consumer
can handle this.

--kkcDP0v44wDpNmbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1m9swACgkQJNaLcl1U
h9CvwAf+IdgMLodtIS3mS68GuvKGBp8tkC7vXg5RMAn7ZGojmDwhf0K6OQeoQPjq
3Nb/iOM+I3jGMjmGshxkfhng0/bUx4XimLNPNHn9mDU1NVo2vcPZj5nKYXB2yYGM
XR2HRuimsNeDUOjWLL3leJPIWV44p7MVUg/67sKbsvWgIaj0u3VzRM1bnshcQn5S
q6fxAtU91SHwUimw7sDTL56qNar6dCdR7sxaT/5L1o096H+afgKWn9YXN4nVsp2D
kHLgqqbK6SBJ61d//+01SrDK1jHY+g/13mgaExx4cOKqKeJVfvzJLTkVmHwXxUOa
oUEQJHyZo+tEqAjlkZbbBIlLMyGHMw==
=vJqc
-----END PGP SIGNATURE-----

--kkcDP0v44wDpNmbp--
