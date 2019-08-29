Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72939A1E21
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfH2O6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 10:58:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34543 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfH2O6Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 10:58:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so4432727edb.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+z2UAcPOH1b4iX+VTPNkAwcBdbQ/nEJuFsgpjTPszgk=;
        b=cNwTv1P+qWIZxsJfAzf9TA4HH9bFORHYHTg97KGuYFkELy5Zh1M3u8nXoz1HV/oEeK
         1iIii21+KqOnBTGgC+RMoLz+rgLqYRfgCMyqc9UY7GUFxhJ7g0q20bc2kcmYz5Gm6yVb
         1PkzlP7Jum92TYsxxij8uU8wc6bl64v69HEBV63/DkS+LGQowZcBStCUiYtoexLC/DHz
         Rx8t8xXAaTXSdxDuulzRh5oR2wrWd+KT3YZExiJpRHq86+Uf4OBUxybAwU4xDzqj6gS3
         HPkTqr3H7yUJbAqsT79wGB/pX02NzKZPGVoDLHq3HUIsF/oBw58Tgu7xR2ovdQdtHXZi
         ZcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+z2UAcPOH1b4iX+VTPNkAwcBdbQ/nEJuFsgpjTPszgk=;
        b=Mw1MYsMKQMAYT/F+rWoyDFIzuUwB4IIgIKMaXco2X3YVW3tNZRyFXLrJI5qsI2sOvY
         lZTld6rmKuq29rjNY7l+mK+e+St2JSPuysqkzFIMouXDbVgsVlRGENpQVycLsJG1wteg
         os/I9RtTYPoyu20pse2N2/oDyXGxQ7fk5+EpwqufhY0VE5D78JHAni0TRh6i+yxYBZh8
         RsR+MMhIu4svTvh5VrIWZIF+tbuRNEMaYzHaM7g1Mh85kgltJZuFZgCg4p4tnLZ24msf
         1Zv0+Aw2ck3rEjIRqT/3dPy3t9bsj4F4WsIc0axgusMBprVUmpks2YJYnmGmkWa1Yv4A
         StZQ==
X-Gm-Message-State: APjAAAUpMKpUef18aoS22SupPIcfBBSjieWmGcW/dzL8s3O0wgomDiws
        SH+LksdD+YDLMBXhOfZ/o5Y=
X-Google-Smtp-Source: APXvYqy0yytk5dDF4j0wcZkpdeuPPNbeQ2uDJLnEdSNjFrKN2NzFw1qe7r6Pwdx+pYzhB+kbhcYpLQ==
X-Received: by 2002:aa7:d58d:: with SMTP id r13mr10142181edq.118.1567090702627;
        Thu, 29 Aug 2019 07:58:22 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f15sm416704ejx.14.2019.08.29.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:58:21 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:58:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 5/5] PCI: iproc: Properly handle optional PHYs
Message-ID: <20190829145820.GB19842@ulmo>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
 <20190829114603.GB13187@ulmo>
 <20190829130323.GE4118@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20190829130323.GE4118@sirena.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 02:03:23PM +0100, Mark Brown wrote:
> On Thu, Aug 29, 2019 at 01:46:03PM +0200, Thierry Reding wrote:
> > On Thu, Aug 29, 2019 at 12:17:29PM +0100, Mark Brown wrote:
>=20
> > > Why would we return NULL?  The caller is going to have to check the
> > > error code anyway since they need to handle -EPROBE_DEFER and NULL is
> > > never a valid thing to use with the regulator API.
>=20
> > I think the idea is that consumers would do something like this:
>=20
> > 	supply =3D regulator_get_optional(dev, "foo");
> > 	if (IS_ERR(supply)) {
> > 		/* -EPROBE_DEFER handled as part of this */
> > 		return PTR_ERR(supply);
> > 	}
>=20
> > 	/*
> > 	 * Optional supply is NULL here, making it "easier" to check
> > 	 * whether or not to use it.
> > 	 */
>=20
> > I suppose checking using IS_ERR() is equally simple, so this mostly
> > boils down to taste...
>=20
> Or setting a flag saying which mode to drive the chip in for example.
>=20
> > The PHY subsystem, for instance, uses a similar approach but it goes one
> > step further. All APIs can take NULL as their struct phy * argument and
> > return success in that case, which makes it really trivial to deal with
> > optional PHYs. You really don't have to care about them at all after you
> > get NULL from phy_get_optional().
>=20
> That case really doesn't exist for the regulator API, that's the case
> which is handled by the dummy regulator in the regulator API - it really
> is rare to see devices that operate without power.  I suspect the PHY
> case is similar in that there always is a PHY of some kind.  If a
> consumer can be written like that then it just shouldn't be using
> regulator_get_optional() in the first place.

One recent example, which is actually what spawned this series of
cleanups, that comes to mind here is the case where we need regulators
to supply power to a PCI device. The PCI device that consumes power is
itself not listed in the device tree, because it is usually enumerated
via the PCI bus. However, we still have to provide power to a PCI slot
to make sure the device powers up and can be enumerated in the first
place. For this particular case it's pretty obvious that the supplies
are in fact required.

However, the same PCI controller can also be used with onboard devices
where no standard 3.3 V and 12 V need to be supplied (as in the PCIe
slot case above). Instead there are usually different power supplies
to power the device. Also, since these supplies are usually required to
bring the device up and make it detectable on the PCI bus, these
supplies are typically always on. Also, since the PCI controller is not
the consumer of the power supplies, it's impossible to specify which
supplies exactly are needed by the device (they'd have to be described
by a binding for these devices, but drivers couldn't be requesting them
because without the supplies being enabled the device would never show
up on the PCI bus and the driver would never bind).

Do you think those 3.3 V and 12 V regulators would qualify for use of
the regulator_get_optional() API? Because in the case where the PCIe
controller doesn't drive a PCIe slot, the 3.3 V and 12 V supplies really
are not there.

> > > > Looking at some of the consumer drivers I can see that lots of them=
 don't
> > > > correctly handle the return value of regulator_get_optional:
>=20
> > > This API is *really* commonly abused, especially in the graphics
> > > subsystem which for some reason has lots of users even though I don't
> > > think I've ever seen a sensible use of the API there.  As far as I can
> > > tell the graphics subsystem mostly suffers from people cut'n'pasting
> > > from the Qualcomm BSP which is full of really bad practice.  It's rea=
lly
> > > frustrating since I will intermittently go through and clean things up
> > > but the uses just keep coming back into the subsystem.
>=20
> > The intention here is to make it more difficult to abuse. Obviously if
> > people keep copying abuses from one driver to another that's a different
> > story. But if there was no way to abuse the API and if it automatically
> > did the right thing, even copy/paste abuse would be difficult to pull
> > off.
>=20
> I fail to see how returning NULL would change anything with regard to
> the API being abused, if anything I think it'd make it more likely to
> have people write things that break for probe deferral since it's not
> reminding people about error codes (that's very marginal though).

People would of course still need to check the return value for errors.
Returning NULL would only make sure that if there's really no regulator
there's a standard way to signal that. And drivers could always use
similar code patterns to deal with optional regulators. Right now there
are two patterns: set regulator to NULL if the regulator is not
available (and use !supply checks before calling regulator APIs) or
leave the regulator set to whatever error pointer was returned (and use
!IS_ERR() checks before calling regulator APIs).

In many cases above, the drivers will continue without a regulator
irrespective of the error code returned. If we return NULL in exactly
only the case where the regulator is not there and an ERR_PTR()
otherwise, it becomes much clearer that all errors should just be
propagated to the caller (including -EPROBE_DEFER) and otherwise we can
continue with appropriate NULL checks.

Again, yeah, this might be marginal.

> > > No, they'd all still be broken for probe deferral (which is commonly
> > > caused by off-chip devices) and they'd crash as soon as they try to c=
all
> > > any further regulator API functions.
>=20
> > I think what Andrew was suggesting here was to make it easier for people
> > to determine whether or not an optional regulator was in fact requested
> > successfully or not. Many consumers already set the optional supply to
> > NULL and then check for that before calling any regulator API.
>=20
> I think that really is very marginal.
>=20
> > If regulator_get_optional() returned NULL for absent optional supplies,
> > this could be unified across all drivers. And it would allow treating
> > NULL regulators special, if that's something you'd be willing to do.
>=20
> Not really, no.  What we're doing at the minute at least mitigates
> against the problems we used to have with people just not handling
> errors at all and having the dummy regulator gives us some opportunity
> to do checks on API usage in the consumers that would otherwise not get
> run which helps robustness for the systems where there are real,
> controllable regulators providing those supplies.
>=20
> > In either case, the number of abuses shows that people clearly don't
> > understand how to use this. So there are two options: a) fix abuse every
> > time we come across it or b) try to change the API to make it more
> > difficult to abuse.
>=20
> I don't think there's much that can be done to avoid abuse of the API,=20
> I've thought of things like having a #define around the prototype for
> "yes I really meant to use this" which consumers would have to define in
> an effort to try to flag up to developers and reviewers that it's not
> normal.
>=20
> > > > I guess I'm looking here for something that can simplify consumer e=
rror
> > > > handling - it's easy to get wrong and it seems that many drivers ma=
y be wrong.
>=20
> > > The overwhelming majority of the users just shouldn't be using this A=
PI.
> > > If there weren't devices that absolutely *need* this API it wouldn't =
be
> > > there in the first place since it seems like a magent for bad code, i=
t's
> > > so disappointing how bad the majority of the consumer code is.
>=20
> > Yeah, I guess in many cases this API is used as a cheap way to model
> > always-on, fixed-voltage regulators. It's pretty hard to change those
> > after the fact, though, because they're usually happening as part of
> > device tree bindings implementation, so by the time we notice them,
> > they've often become ABI...
>=20
> I don't follow here?  Such users are going to be the common case for the
> regulator API and shouldn't have any problems using normal regulator_get(=
). =20
> When I say users shouldn't be using this API I mean _get_optional()
> specifically.

True, even if the regulator is specified as optional in the bindings,
using regulator_get() would effectively make it optional for the driver
given that it returns the dummy.

Thierry

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1n6AkACgkQ3SOs138+
s6F3Kw//ULb4CHXxG+jutbvN7X/1OMkXzw358CvGKDo1KEiUPWTdbE1r8rqb/G7m
3Khsn/TmEmrUqCVzE/AJ8iU0jDnXQIZyMqhrqD+VqBzIJArofxnV1S1YJyakqg6U
MyY5NWvswL39EUL/ir0ulKaB0rFIHhG0ENjERatIbBhtQ+hTYyJQV3ONbSUbVDHY
2fiUOsUP1+3lxA1+KPruXELM0xQpJECJ+k11gbnjuKme2GoxR0OcLz+oh86wH1MX
sOx5TK+ktfMJ8mBwiD/rZzfHMZ5SiSxlR/+OR5ue4EE8a50t9hr1jSiAhSGhPPzG
qp+pZ4Z8fw2SOC4uxmIjsCn1FAKgorUWhbyP08cE7JsTMpVZ0WGR1lcmANeraAm9
IChEIW8kJzZFz5j6QcG+YiFa//+Mqn+Z1zc6h+LCm5WzIW2Cg9ajogMkPAeOho8G
sZFArXJKVy/2YkaGWcF6JLhyNbOO5raS+ZTt/TYI3zkPAH2sehjjJssTYoVW5HHb
YH9bp0u1I9nhv1G6Iitq9EbaNZuvOiw1w3cTaaR6m16xL//4Xhq3adSKOf0A6GDs
jAOwR24p5FOjWfZVg3oAB3YcdLCZiXNzNS9QOiNC9AEJIfJdKALIvHtTspRP9hHJ
Oc7+l55eVqhNo1EPdPXSx9gsloY/Nl/KNBvCl1C6PFLszVtzKbo=
=UskK
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
