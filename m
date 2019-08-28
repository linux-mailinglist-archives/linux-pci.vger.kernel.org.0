Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2B49A067B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfH1PlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 11:41:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfH1PlJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 11:41:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id j11so239759wrp.11
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2019 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ecfP7qpyNlbTo0mYeWkbfVtR/L95yNWsOdHy9lsC0g=;
        b=MOvdiN099d0TBYShN6TegYOOoYhOR6y9OJkGN0Q5RgQW2q3tIeh9V2u2tI5RCSjs/H
         urJH9GwWHKK/TT2BwkRvB/zahP9Os1NTNuLOKA8iSGUatmZhyUe7IBaB1TKB6qnMBG3y
         cobufCyrKe1INRxyxDRHij1O9aLy0funznfx/oOzej4zjwb7mbsZ8vgETxRROmCHOH0k
         u4PdCkYB/MGiOgHr3EFxvrY+vzTClzSVA2FCaDOhR65cmBbbHvctuWm7llqI7qpEPhny
         5pzQcEmE18iw2KD9X4ZBB3FisYzs41xEhnCy+g63/NVBl6vEBJqc+YiU8oyHXRgUizCB
         t49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ecfP7qpyNlbTo0mYeWkbfVtR/L95yNWsOdHy9lsC0g=;
        b=sfcHxEcMfw0g7BaBb1Q8vObZsA0oUnUfiwClEO3ugYfn7sxsuLovD54mycd07fXrM1
         nIEGM8Ppff/R122JXk+vRKgSkwu9ISXhTl2NZMRYU+/KIE2TL7SglNSuuR/XMtsAYeuX
         vww2G6BWdUYToFgf2iifh6Ts5jJmb5LxO348RREbMIdbbAqb9cGPHSXb7HM+TAKTCAv/
         87O+G9SnBFsZ6lriED/Hjn4ZgTzsiP8Ir5hajeZsBMihYo+qyhnVUbxqbv4bGD5kXn85
         //eG2PG139ADZWp2O6n9bVTBf7MHoRWBF7txkL+GT3Fbz7KmRfPf5OA3oePHU4a0B0LB
         bPuA==
X-Gm-Message-State: APjAAAUKtzZKgs7op4y982T22yhww3xnU6LyXsvN0qpG5UL+Le6RbxL3
        j8LMx4/xnWQQE0zZd1q/XMKszojD
X-Google-Smtp-Source: APXvYqwXitvjr5rnB28mAKox1kJplaWTPvWdxJTnr2ZAmk2hrgkYdM/08UCk7mPugyWBK2e4FbGLwA==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr5596071wro.158.1567006866932;
        Wed, 28 Aug 2019 08:41:06 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id x6sm7253035wmf.6.2019.08.28.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 08:41:04 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:41:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Properly handle optional regulators
Message-ID: <20190828154103.GA10422@ulmo>
References: <20190828150737.30285-1-thierry.reding@gmail.com>
 <20190828153243.GZ14582@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <20190828153243.GZ14582@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 04:32:44PM +0100, Andrew Murray wrote:
> On Wed, Aug 28, 2019 at 05:07:37PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > regulator_get_optional() can fail for a number of reasons besides probe
> > deferral. It can for example return -ENOMEM if it runs out of memory as
> > it tries to allocate data structures. Propagating only -EPROBE_DEFER is
> > problematic because it results in these legitimately fatal errors being
> > treated as "regulator not specified in DT".
> >=20
> > What we really want is to ignore the optional regulators only if they
> > have not been specified in DT. regulator_get_optional() returns -ENODEV
> > in this case, so that's the special case that we need to handle. So we
> > propagate all errors, except -ENODEV, so that real failures will still
> > cause the driver to fail probe.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/pci/controller/pcie-rockchip-host.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/=
controller/pcie-rockchip-host.c
> > index 8d20f1793a61..ef8e677ce9d1 100644
> > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > @@ -608,29 +608,29 @@ static int rockchip_pcie_parse_host_dt(struct roc=
kchip_pcie *rockchip)
> > =20
> >  	rockchip->vpcie12v =3D devm_regulator_get_optional(dev, "vpcie12v");
> >  	if (IS_ERR(rockchip->vpcie12v)) {
> > -		if (PTR_ERR(rockchip->vpcie12v) =3D=3D -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > +		if (PTR_ERR(rockchip->vpcie12v) !=3D -ENODEV)
> > +			return PTR_ERR(rockchip->vpcie12v);
> >  		dev_info(dev, "no vpcie12v regulator found\n");
>=20
> In the event that -ENODEV is returned - we don't set vpcie12v to NULL, ho=
wever
> it seems that this is OK as vpcie12v is tested with IS_ERR before use eve=
rywhere
> else in this file.

Yeah, I was trying to keep the diff small here. There doesn't seem to be
any canonical way to mark regulators as "not available". This driver
leaves it set as an error pointer, the Tegra PCI driver sets it to NULL.
They're both valid ways to do it as long as they use the proper checks
before using them. So I wasn't trying to force one way or another, just
kept it the way it was and only fixed the problematic checks.

> By the way it looks like this patch pattern could be applied right across=
 the
> kernel, there are also others in PCI: pci-imx6 and pcie-histb.c - not sur=
e if
> you wanted to fix those up too.

I hadn't checked any other drivers, but I can take another look and
prepare patches for them.

> Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Thanks,
Thierry

> >  	}
> > =20
> >  	rockchip->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpcie3v3");
> >  	if (IS_ERR(rockchip->vpcie3v3)) {
> > -		if (PTR_ERR(rockchip->vpcie3v3) =3D=3D -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > +		if (PTR_ERR(rockchip->vpcie3v3) !=3D -ENODEV)
> > +			return PTR_ERR(rockchip->vpcie3v3);
> >  		dev_info(dev, "no vpcie3v3 regulator found\n");
> >  	}
> > =20
> >  	rockchip->vpcie1v8 =3D devm_regulator_get_optional(dev, "vpcie1v8");
> >  	if (IS_ERR(rockchip->vpcie1v8)) {
> > -		if (PTR_ERR(rockchip->vpcie1v8) =3D=3D -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > +		if (PTR_ERR(rockchip->vpcie1v8) !=3D -ENODEV)
> > +			return PTR_ERR(rockchip->vpcie1v8);
> >  		dev_info(dev, "no vpcie1v8 regulator found\n");
> >  	}
> > =20
> >  	rockchip->vpcie0v9 =3D devm_regulator_get_optional(dev, "vpcie0v9");
> >  	if (IS_ERR(rockchip->vpcie0v9)) {
> > -		if (PTR_ERR(rockchip->vpcie0v9) =3D=3D -EPROBE_DEFER)
> > -			return -EPROBE_DEFER;
> > +		if (PTR_ERR(rockchip->vpcie0v9) !=3D -ENODEV)
> > +			return PTR_ERR(rockchip->vpcie0v9);
> >  		dev_info(dev, "no vpcie0v9 regulator found\n");
> >  	}
> > =20
> > --=20
> > 2.22.0
> >=20

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1moI8ACgkQ3SOs138+
s6F7AA//RclYPyFWgwjoCkQPsUjwPF986Gum7Zcjlo1Zkt4qcKq3R3wKPfd88eaq
/21fo0lQN5keqY+cTezH7so5LGEx1KTUmDi/e/d78dSFSm1Xcn4xg8INC8gY3boL
gwQMhsOr5tG/bR+mVbmS5gaITGJW53EOfWTtQg3pluzJdMuWjrVgwB82dIrsQLD7
wqD5p1Byf7JsEi035munGTUavP5SS1wHYWWX/OkncEQvyAHcYrk/+hOP0bKJQ7Nj
x+MhLqwc/jPTOfsiHGW2m8WazwLPtHfhI/y9QB1Bdb2nXrBoVC83/Jh6172NW4iX
etNOSy+51U19U1fGmBU/lB1GwoxcHWmaNebquAF1lBeTS+HjB/WgLkQw44rEFbkr
wP2n+hGOn7/I2dhgEJ5TokF+oxnFw4DLIXWmiyT0O0W8xU7CxNCYJsY2gHdfl0Yc
R4ib9+zFxTktefBNVgBcNIF0KXjnwUOcdV9rGcWMJeDTW9ua/VLgK6eOpIl+lNnh
nCl0lJEypiZoemzKAmJxiDAvy0Jzza2nT5Nxz6sPWsJn+C/V0RSiBVjiS+uTOqB2
q1BvIMhw4ZGK6Q6ZX2OASEjgivNu7yhAvR+iqeDUEDRPVW4aGmJqp08uzg9GOWpP
oljMoPWyxRWGAOJtiIHrF1lTetunVdDWm5h4XHkYFy/92cRbhpw=
=rwiw
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
