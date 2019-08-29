Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D69A1A9E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfH2ND3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 09:03:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40586 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2ND3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4s58QXaMIlH01m1TC9KA3ewASPsD6dw6M/r4xmn2G1E=; b=TQKGx7mp8ULy//fWBf6UgESO2
        EDufQF7wKLRX/lwWB9dxWdbc098qD4BGMz0gXOgB5z0hGNq+359Y1BSNX7BIiy0OV/IFucdCuJ/wm
        4BhjBtc+q4RJPVhmi1AIL1x7z8CNeyukZraf5ODORVD2sT7P59+DTwWQDB5xabAWzKo3g=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3K5E-00025R-DI; Thu, 29 Aug 2019 13:03:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A39F927428D1; Thu, 29 Aug 2019 14:03:23 +0100 (BST)
Date:   Thu, 29 Aug 2019 14:03:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829130323.GE4118@sirena.co.uk>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
 <20190829114603.GB13187@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <20190829114603.GB13187@ulmo>
X-Cookie: Lensmen eat Jedi for breakfast.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 01:46:03PM +0200, Thierry Reding wrote:
> On Thu, Aug 29, 2019 at 12:17:29PM +0100, Mark Brown wrote:

> > Why would we return NULL?  The caller is going to have to check the
> > error code anyway since they need to handle -EPROBE_DEFER and NULL is
> > never a valid thing to use with the regulator API.

> I think the idea is that consumers would do something like this:

> 	supply =3D regulator_get_optional(dev, "foo");
> 	if (IS_ERR(supply)) {
> 		/* -EPROBE_DEFER handled as part of this */
> 		return PTR_ERR(supply);
> 	}

> 	/*
> 	 * Optional supply is NULL here, making it "easier" to check
> 	 * whether or not to use it.
> 	 */

> I suppose checking using IS_ERR() is equally simple, so this mostly
> boils down to taste...

Or setting a flag saying which mode to drive the chip in for example.

> The PHY subsystem, for instance, uses a similar approach but it goes one
> step further. All APIs can take NULL as their struct phy * argument and
> return success in that case, which makes it really trivial to deal with
> optional PHYs. You really don't have to care about them at all after you
> get NULL from phy_get_optional().

That case really doesn't exist for the regulator API, that's the case
which is handled by the dummy regulator in the regulator API - it really
is rare to see devices that operate without power.  I suspect the PHY
case is similar in that there always is a PHY of some kind.  If a
consumer can be written like that then it just shouldn't be using
regulator_get_optional() in the first place.

> > > Looking at some of the consumer drivers I can see that lots of them d=
on't
> > > correctly handle the return value of regulator_get_optional:

> > This API is *really* commonly abused, especially in the graphics
> > subsystem which for some reason has lots of users even though I don't
> > think I've ever seen a sensible use of the API there.  As far as I can
> > tell the graphics subsystem mostly suffers from people cut'n'pasting
> > from the Qualcomm BSP which is full of really bad practice.  It's really
> > frustrating since I will intermittently go through and clean things up
> > but the uses just keep coming back into the subsystem.

> The intention here is to make it more difficult to abuse. Obviously if
> people keep copying abuses from one driver to another that's a different
> story. But if there was no way to abuse the API and if it automatically
> did the right thing, even copy/paste abuse would be difficult to pull
> off.

I fail to see how returning NULL would change anything with regard to
the API being abused, if anything I think it'd make it more likely to
have people write things that break for probe deferral since it's not
reminding people about error codes (that's very marginal though).

> > No, they'd all still be broken for probe deferral (which is commonly
> > caused by off-chip devices) and they'd crash as soon as they try to call
> > any further regulator API functions.

> I think what Andrew was suggesting here was to make it easier for people
> to determine whether or not an optional regulator was in fact requested
> successfully or not. Many consumers already set the optional supply to
> NULL and then check for that before calling any regulator API.

I think that really is very marginal.

> If regulator_get_optional() returned NULL for absent optional supplies,
> this could be unified across all drivers. And it would allow treating
> NULL regulators special, if that's something you'd be willing to do.

Not really, no.  What we're doing at the minute at least mitigates
against the problems we used to have with people just not handling
errors at all and having the dummy regulator gives us some opportunity
to do checks on API usage in the consumers that would otherwise not get
run which helps robustness for the systems where there are real,
controllable regulators providing those supplies.

> In either case, the number of abuses shows that people clearly don't
> understand how to use this. So there are two options: a) fix abuse every
> time we come across it or b) try to change the API to make it more
> difficult to abuse.

I don't think there's much that can be done to avoid abuse of the API,=20
I've thought of things like having a #define around the prototype for
"yes I really meant to use this" which consumers would have to define in
an effort to try to flag up to developers and reviewers that it's not
normal.

> > > I guess I'm looking here for something that can simplify consumer err=
or
> > > handling - it's easy to get wrong and it seems that many drivers may =
be wrong.

> > The overwhelming majority of the users just shouldn't be using this API.
> > If there weren't devices that absolutely *need* this API it wouldn't be
> > there in the first place since it seems like a magent for bad code, it's
> > so disappointing how bad the majority of the consumer code is.

> Yeah, I guess in many cases this API is used as a cheap way to model
> always-on, fixed-voltage regulators. It's pretty hard to change those
> after the fact, though, because they're usually happening as part of
> device tree bindings implementation, so by the time we notice them,
> they've often become ABI...

I don't follow here?  Such users are going to be the common case for the
regulator API and shouldn't have any problems using normal regulator_get().=
 =20
When I say users shouldn't be using this API I mean _get_optional()
specifically.

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1nzRoACgkQJNaLcl1U
h9DGvwgAhhRyTe3K/y76rLrLIpKhca5KN5mxTI6axL/+RjUTIZfMCKkVP6d7JIGO
ABWkwjKgb5buwsL5BaBhDLy/M6VRs8eBIOObg0C/ZyqjASVsuZsRYc28jDXbdKMG
BOrDbfOL9HkP/M3WzRsA0GyxZN8H2iqGShNStdZ3faHtEkRRi0OqfPJKD/y5F1P4
G/I3uuumt6YzYKmoIM0OU/ZhH8LWDgpHRLJC8P3z09T3TyCxLAAg7tUlSZER2oFB
yWWJr1f24dYPivMmyxIOUHu82/xa8JCRR17UKtMIVluCa2sHeQacwqha6TiEggpr
Va1dESKFk68YefFofTMjipR7l9rOmQ==
=H8OM
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
