Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D6A192A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2019 13:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfH2LqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Aug 2019 07:46:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41653 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfH2LqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2019 07:46:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so3076892wrr.8
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2019 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hb3Ow4R/QLLoepohlnYAJ/6iYApU90c7BZJ1g4eHIZI=;
        b=Y7FGL+dQXLjY1YXOMevLXAICEYO/dHtGmCBaig7Sb6IT512OQf/8TvpRUg5zaT++L5
         TvdKk/LRAOljnXAzXKZCJb72XgTmZMQZn8DOPrP9B2XsXtZyQtrebWiJ7A/mnTpusNcF
         xYetsvbn1o6QQAbkt+9aRswq+9v6IaOO9gZMAEc+Zp891V7o3MDGXPp4X7sKztKoruYI
         X3VwDn86Anc490uQzqTVhCC37yLpq5yhNQkx/8r4V782f8EcHWWUJVOAE6zzh6UzcGHU
         ZegwxwEj2c1wbTrCk9nsp+/SuTRMnX+cEUe4b6poN0wCxTux13wmqJoR/frY71cla3+S
         58TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hb3Ow4R/QLLoepohlnYAJ/6iYApU90c7BZJ1g4eHIZI=;
        b=PHw91wXR7G8t70ACF2cyuVIki8G/S+DZF+aDFtSv6Dspfl5SuwzOpRvRPJkeqx3QQV
         Su01kbM/HuSTHBxOxMSwFdENw2SjJGkqikpoFFRDjUUaeppVoKGF/yt3YDLI2nWVykPH
         F53zOy8vgkYE1saW7EJfayNH+c/RBUE9I6+20VlG1xAk4JvDpxZrqecL/1ajtxZEnId9
         7HRMk6vUe6QZBp85VbsE76o+FKHyF+RzKa1uBc3ejoywtz9l7RdjGxCR+mVT6zM/jVFk
         wMLnvREgVKfFUW0n5d1z1gYuaPtAnqhlonqIrSoPBqCeGe8qRuKv5khgGBDRwsDbZrtp
         ivlQ==
X-Gm-Message-State: APjAAAXXU/hxHXxG011MnKNycBEXknSEhfS4pnC83wP0gwI9haBqqbxN
        fkM6QLLiv0fNqlCU5OXuDqE=
X-Google-Smtp-Source: APXvYqzA8PUnhDpIHnXoJVy1pG6jTuSYmw7wu1TKOKmUnagXvWvghF1jI8SJ+zhRI1BIw7wkGDIx7w==
X-Received: by 2002:adf:f3c8:: with SMTP id g8mr1630226wrp.58.1567079165965;
        Thu, 29 Aug 2019 04:46:05 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id c132sm3750490wme.27.2019.08.29.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:46:04 -0700 (PDT)
Date:   Thu, 29 Aug 2019 13:46:03 +0200
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
Message-ID: <20190829114603.GB13187@ulmo>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
 <20190828163636.12967-5-thierry.reding@gmail.com>
 <20190828212655.GG14582@e119886-lin.cambridge.arm.com>
 <20190828214901.GM4298@sirena.co.uk>
 <20190829100933.GH14582@e119886-lin.cambridge.arm.com>
 <20190829111728.GC4118@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20190829111728.GC4118@sirena.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 12:17:29PM +0100, Mark Brown wrote:
> On Thu, Aug 29, 2019 at 11:09:34AM +0100, Andrew Murray wrote:
>=20
> > But why do we return -ENODEV and not NULL for OPTIONAL_GET?
>=20
> Why would we return NULL?  The caller is going to have to check the
> error code anyway since they need to handle -EPROBE_DEFER and NULL is
> never a valid thing to use with the regulator API.

I think the idea is that consumers would do something like this:

	supply =3D regulator_get_optional(dev, "foo");
	if (IS_ERR(supply)) {
		/* -EPROBE_DEFER handled as part of this */
		return PTR_ERR(supply);
	}

	/*
	 * Optional supply is NULL here, making it "easier" to check
	 * whether or not to use it.
	 */

I suppose checking using IS_ERR() is equally simple, so this mostly
boils down to taste...

The PHY subsystem, for instance, uses a similar approach but it goes one
step further. All APIs can take NULL as their struct phy * argument and
return success in that case, which makes it really trivial to deal with
optional PHYs. You really don't have to care about them at all after you
get NULL from phy_get_optional().

> > Looking at some of the consumer drivers I can see that lots of them don=
't
> > correctly handle the return value of regulator_get_optional:
>=20
> This API is *really* commonly abused, especially in the graphics
> subsystem which for some reason has lots of users even though I don't
> think I've ever seen a sensible use of the API there.  As far as I can
> tell the graphics subsystem mostly suffers from people cut'n'pasting
> from the Qualcomm BSP which is full of really bad practice.  It's really
> frustrating since I will intermittently go through and clean things up
> but the uses just keep coming back into the subsystem.

The intention here is to make it more difficult to abuse. Obviously if
people keep copying abuses from one driver to another that's a different
story. But if there was no way to abuse the API and if it automatically
did the right thing, even copy/paste abuse would be difficult to pull
off.

> > Given that a common pattern is to set a consumer regulator pointer to N=
ULL
> > upon -ENODEV - if regulator_get_optional did this for them, then it wou=
ld
> > be more difficult for consumer drivers to get the error handling wrong =
and
> > would remove some consumer boiler plate code.
>=20
> No, they'd all still be broken for probe deferral (which is commonly
> caused by off-chip devices) and they'd crash as soon as they try to call
> any further regulator API functions.

I think what Andrew was suggesting here was to make it easier for people
to determine whether or not an optional regulator was in fact requested
successfully or not. Many consumers already set the optional supply to
NULL and then check for that before calling any regulator API.

If regulator_get_optional() returned NULL for absent optional supplies,
this could be unified across all drivers. And it would allow treating
NULL regulators special, if that's something you'd be willing to do.

In either case, the number of abuses shows that people clearly don't
understand how to use this. So there are two options: a) fix abuse every
time we come across it or b) try to change the API to make it more
difficult to abuse.

> > I guess I'm looking here for something that can simplify consumer error
> > handling - it's easy to get wrong and it seems that many drivers may be=
 wrong.
>=20
> The overwhelming majority of the users just shouldn't be using this API.
> If there weren't devices that absolutely *need* this API it wouldn't be
> there in the first place since it seems like a magent for bad code, it's
> so disappointing how bad the majority of the consumer code is.

Yeah, I guess in many cases this API is used as a cheap way to model
always-on, fixed-voltage regulators. It's pretty hard to change those
after the fact, though, because they're usually happening as part of
device tree bindings implementation, so by the time we notice them,
they've often become ABI...

Thierry

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1nuvkACgkQ3SOs138+
s6GOcg//Vjzbpp1jHpOKCO7il/z3r1AyHWWl8aAgqKlnj2IP262Dhz7fqG7R2B+Y
GpHDGxPP1fsnRzOzHmLMpDH9YH0qfxn1tIDQHDCDYwjE93lbngamOPzYAnkMblNy
Ahy43jm3WQ76kUAvEghVSm+KczzU5Iqoh3UY5gsffUsAw3sT/GcSUhQZi93nI5by
wKToxOnhBWR0x2EDsNHtDILW/UpZpseFLTuX/7vsHODdMB5tL6NBKpWMawGpkn8o
A/8g/nN4abp5hmejdfGJ5+rQx2Ior0Hh9HiFOU8F6QRI1wESZ9hWYOW9ScMu6Qss
0a39VGybWTiEEAKbz672xHCCvQqAJf9qB1f5MDDkuQDhgIkECFdT8xLtFUdlVhaj
CF0uoT2+UgS7NDcTOLtCkh97b285Cc312ZMgLGOBfEDXq97hq3j6EiILfxnBcyhB
U4eH6eg4766mrTtNitr4oGqCxQMs2C8r7JHQNsItcsPl7nQeMqAuyo9eLk38sL/4
B7Is/Vn64EyjrfZKNI7Uyb0i6AGjHR57yjrUfzUqH9AFB0hiyJiVXS4iTPM/ay6a
VbxIivu219Y21PCmbcX645tZYz+7r5Rac0hQBJEuF2f+KQeq9Wf1NEJztPVV/wHQ
C24rk9hNndtRcKJ7iaMZp0K/YZVcF45qMzELAP+ZbBeGEnf0DUE=
=dr9R
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
