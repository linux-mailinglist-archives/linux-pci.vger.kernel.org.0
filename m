Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB93EB997
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbhHMPyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 11:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241487AbhHMPyh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 11:54:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29E29601FD;
        Fri, 13 Aug 2021 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628870050;
        bh=tJWVgi5froVJvA8ey2vsX+89Npe4dBRwLUBJHkjVxxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSAdvmE+CD8W/vpFYSjqLytsYxktaeVxeQW3Jxkim70RLVERPDJMnGQkecCWcRlxa
         aqREybTG41HncW8Lp8kOKktqfWUjNHVvuOjhjQe9ppr+WjONx/3uhIulEPVEIyM/yG
         jWfZ/h4qzyc9IHkCYvo47+RM6Phl9bZPMcP834OumIlPHz5o1tLMrEIO9a7ajcw6Q7
         IJ2ZbTSR2AgJAllxB1n8uY6yOQfN2f8osQNECE1P73UcsVkiuQDcjS3NVy+wluIojD
         6DB4UWsdbXaje0HmVc4/p3Tu2FgRU2XrvsHuBvVWwAA14T1JxOAYmMqGdYJ2fkTsI/
         zfw0s4opj+hwA==
Date:   Fri, 13 Aug 2021 16:53:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference
 in probe
Message-ID: <20210813155350.GC5209@sirena.org.uk>
References: <20210813113338.GA30697@kili>
 <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <20210813135412.GA7722@kadam>
 <2917a1c8-d59b-43b1-1650-228d20dfc070@arm.com>
 <20210813143250.GA5209@sirena.org.uk>
 <20210813154505.GC7722@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <20210813154505.GC7722@kadam>
X-Cookie: E Pluribus Unix
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 13, 2021 at 06:45:05PM +0300, Dan Carpenter wrote:
> On Fri, Aug 13, 2021 at 03:32:50PM +0100, Mark Brown wrote:
> > On Fri, Aug 13, 2021 at 03:01:10PM +0100, Robin Murphy wrote:

> > > Indeed I've thought before that it would be nice if regulators worked=
 like
> > > GPIOs, where the absence of an optional one does give you NULL, and m=
ost of
> > > the API is also NULL-safe. Probably a pretty big job though...

> > It also encourages *really* bad practice with error handling

> I'm not necessarily 100% positive what you mean by this.  I think you
> mean you don't like when people pass invalid pointers to free functions?

No, it's the case where people don't bother checking if they got the
regulator in the first place, don't bother checking if when they tried
to enable the regulator that actually worked, and don't do whatever
extra handling they need to do to configure the system for the fact that
one of the power supplies is missing.  It really only helps in the case
where you can just ignore the regulator completely.

> But making regulator code NULL-safe wouldn't affect error handling
> because NULL wouldn't be an error.
>=20
> 	p =3D get_optional();
> 	if (IS_ERR(p))
> 		return PTR_ERR(p);
> 	enable(p);

Your example already misses the error handling on enable...

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEWlY0ACgkQJNaLcl1U
h9C+gQf/ViZcfsBNoNvLiykQAQseACeSDusRgV0howjP0zujMhkdfwwpnudqKcsf
DbhucuvGyD0G27s4xKKb1J4oU7r8ogVSNgc2eGyIciT85dsSVFGn1wYCVICmxCQk
0s+rakCrDjbTYunX9f7k/0JhzxJ43Q432DY+ro1vEc0Iwi9ZeEg+cGAjg6JVwxYW
2+5djM+OKFuB8nlXSxlRu+bUaD7/40Mgz4nvWMC97esw9SbMvPJqisaIfjuh6im6
9e+Olu8uN4clwg4UcSgwnOiKM0lvgMf1XQZzpzlWkuHY/ffo1jVrmGGACaEg40AW
XdY2AeFvANNrXHSvhHIt3xREICEjEg==
=qDSo
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
