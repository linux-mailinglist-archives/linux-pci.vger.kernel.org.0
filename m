Return-Path: <linux-pci+bounces-34525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B2B30FFC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40F25C6869
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC682E4242;
	Fri, 22 Aug 2025 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NccGRekl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8122DA1F;
	Fri, 22 Aug 2025 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846457; cv=none; b=h57aYL6sEa7v5BAk2vC26xLj8tgfPKiEH+2JfojfcIy/bxUKL8dnbJRMpGbpzW7L6WmXpid16m0r+1zrB/aolh5ARrpDZg0KEdJ7eVR8G6/ov+P8oUUHqdrFA8/aIvgI5EyGshK95Cei8a2Fbubx6xsj/J69JXC77fC/meAEYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846457; c=relaxed/simple;
	bh=eFjUMHUt0cqG2Jg9kVk61VNn4wRs0IYrVevcBf8iLgQ=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=Tx1ohU6mzVXAhYrUSVYM63t4u00886cZ2QdIJf5r4iufSLGH4oXaGaPoF9y/AVCLXuvh4T3U2IzuQ8pNEadXGEXEze9jNKor7WvmtSytsCh/rq0HaabkXEoQwXJeRhbCyCzDYK/rAj1csTNG4zKbl6zyCOXNUNj3xiWxTgIoVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NccGRekl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B7BC4CEF1;
	Fri, 22 Aug 2025 07:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755846456;
	bh=eFjUMHUt0cqG2Jg9kVk61VNn4wRs0IYrVevcBf8iLgQ=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=NccGReklmqCnUA3l3f1eX4NBJSuAPP2uyLrayPBfdgSNHnP0IfUovjoZ1H9Ey88sK
	 pXvLm+7FGdze6NXdakA649EB5z+3tk0RvxVODXU13/C308aBpRWtgnTMC5aMPHJR3x
	 7vFS8meacajsxa2/PPl4OcE7v8IPbni44rENtNknHc+MDZt5pYvt44DsWVje0FqQbT
	 9IWEegL1XaGnkIEHFNic63SgHjntiX/YVNaPtKIHXZZfzAZrYD4ovMZdrVpA6z/ee3
	 T9kIBlfe2p3qAWQnCZ4jlxybihshDhNJr1L8sz8oRr0MaQNwDZlsYoW+ymEIdFHQZ1
	 IbEfbKCA8iAvg==
Content-Type: multipart/signed;
 boundary=b660723d7c71fe66a8d5284828740da87301191961cc9ade6033fee8d519;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 22 Aug 2025 09:07:32 +0200
Message-Id: <DC8RMCPRX0UZ.3RP6IGY2KJ96@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Lee Jones" <lee@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <linux-gpio@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Linus Walleij" <linus.walleij@linaro.org>, "Marcos Del Sol Vives"
 <marcos@orca.pet>
Subject: Re: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some
 behaviour
X-Mailer: aerc 0.16.0
References: <20250821101902.626329-1-marcos@orca.pet>
 <20250821101902.626329-2-marcos@orca.pet>
 <CACRpkdb7PZTx8WPQP8Jrj_sR8X2ejK3OgA+9v2PUaOcTM4NnrQ@mail.gmail.com>
In-Reply-To: <CACRpkdb7PZTx8WPQP8Jrj_sR8X2ejK3OgA+9v2PUaOcTM4NnrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

--b660723d7c71fe66a8d5284828740da87301191961cc9ade6033fee8d519
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Aug 21, 2025 at 6:40 PM CEST, Linus Walleij wrote:
> On Thu, Aug 21, 2025 at 12:19=E2=80=AFPM Marcos Del Sol Vives <marcos@orc=
a.pet> wrote:
>
> >  static int gpio_regmap_direction_output(struct gpio_chip *chip,
> >                                         unsigned int offset, int value)
> >  {
> > -       gpio_regmap_set(chip, offset, value);
> > +       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> > +       int ret;
> > +
> > +       if (gpio->flags & GPIO_REGMAP_DIR_BEFORE_SET) {
> > +               ret =3D gpio_regmap_set_direction(chip, offset, true);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               return gpio_regmap_set(chip, offset, value);
> > +       }
> > +
> > +       ret =3D gpio_regmap_set(chip, offset, value);
> > +       if (ret)
> > +               return ret;

Could you add a short paragraph to the commit message that you've
added error checking? Something like:

  While at it, add the missing error check in
  gpio_regmap_direction_output().

> >
> >         return gpio_regmap_set_direction(chip, offset, true);
>
> I guess this looks like this because it is just copied from
> gpio-mmio.c:

Yeah probably :)

With that above fixed:

Reviewed-by: Michael Walle <mwalle@kernel.org>

--b660723d7c71fe66a8d5284828740da87301191961cc9ade6033fee8d519
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaKgXNRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jthgGAlUzF29UFMA6LEvdR2kGAquyMoQlL4UWk
pJ01H/occlJZeqvd9r+hkSyY7bWwq8aaAYCtjM+AoHZVLJnJCD/jXZTr1OgOLNUc
cKRKCuw1/60rGz1ceFXiLiDpcTY4sNlASxw=
=Snu8
-----END PGP SIGNATURE-----

--b660723d7c71fe66a8d5284828740da87301191961cc9ade6033fee8d519--

