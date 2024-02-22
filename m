Return-Path: <linux-pci+bounces-3872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DC185F968
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFDE1F26E78
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B11468ED;
	Thu, 22 Feb 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAXC9Rtr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9B3133983;
	Thu, 22 Feb 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607724; cv=none; b=Gs1aXxe6VauxSnUVCSWHS8S/lpKsyWOpHD1WK87suC9MkPq0aaa6ci/gqjLxmEehTmADGp5CJ0pD9lyNnFGwXOihyy8Q/+279auTzKxLA7b0/1uRiIx6dO500CqensJRKVMribzOlbV8u1T0B9fY8HBxNQou9k3tItx/5uuEavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607724; c=relaxed/simple;
	bh=aB8RgiNf0b3kbIk2EGDRYvCms7pKp1j8q6BKO6yIq/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhP4qkfpFfozg0MqGrXYT/ZTvG2y3MsXjFM7fx0ciymRRhZieSPM5ideE/X+zs2BRCG2M0HFUFXva8cTYLALb4sE0HyU1pUbGWynTI37Rx2RAH1sy7NoArnC3oFClBryxRuxgtX00pvu3NAnzizegxEgt6Gbws6anSSGJdO1xWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAXC9Rtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DB5C433F1;
	Thu, 22 Feb 2024 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708607724;
	bh=aB8RgiNf0b3kbIk2EGDRYvCms7pKp1j8q6BKO6yIq/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAXC9RtrQiqpyOnfoqyu0u+2vXpVzPFJ3ndzmwkc9guJrM2Z4wTrrVPKnVjsM8CRI
	 W4AXe+DEgOQA9Whp7t1wsytVkVsTDh4uevn5WtQO0SOlFtn+qXuU7Tnssm7MJUxvAx
	 TBWGMhti93fSfj0GuGbKuXNCf1rwM6aNChG+D1TEE7OKuiLkb0bdpYM49p/DIDMsey
	 0toi475K7XKQVtSF8ochYNgc4oDv7EYcBoQKFVThZlJ/AQuQCJdpE2Bi23Kc4X3ka7
	 TCj0PCTsIrg0DClyDT+zwBxfW42sT+Mj776Mq1THBjH1zfrM/7oujYr8Daus67dJD7
	 +poFkuMnxjP5Q==
Date: Thu, 22 Feb 2024 13:15:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5 14/18] PCI/pwrctl: add a power control driver for
 WCN7850
Message-ID: <68e401c6-6e59-4c35-8f05-40f6c5eb6849@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-15-brgl@bgdev.pl>
 <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk>
 <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
 <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
 <17bbd9ae-0282-430e-947b-e6fb08c53af7@linaro.org>
 <53f0956f-ee64-4bd6-b44f-cbebafd42e46@sirena.org.uk>
 <CAMRc=MedCX_TGGawMhr39oXtJPF4pOQF=Jh2z4uXkOxwhfJWRw@mail.gmail.com>
 <52fba837-989b-4213-8af7-f02cd8cb48c8@sirena.org.uk>
 <CAMRc=MeF7xVjRKetg1A3MNO4yMasPA2GC7MLCBrOiwO5UBv6LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6adMmEGd2zLJf/T"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeF7xVjRKetg1A3MNO4yMasPA2GC7MLCBrOiwO5UBv6LA@mail.gmail.com>
X-Cookie: I have accepted Provolone into my life!


--s6adMmEGd2zLJf/T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 01:26:59PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 22, 2024 at 1:21=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Thu, Feb 22, 2024 at 10:22:50AM +0100, Bartosz Golaszewski wrote:

> > > Removing it would be out of scope for this series and I don't really
> > > want to introduce any undefined behavior when doing a big development
> > > like that. I'll think about it separately.

> > This is new code?

> It's a new driver but Qualcomm standard has been to provide the load
> values. If it's really unnecessary then maybe let's consider it
> separately and possibly rework globally?

That doesn't seem a great reason to add more instances of this - it's
more instances that need to be removed later, and somewhere else people
can cut'n'paste from to introduce new usage.

--s6adMmEGd2zLJf/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXSOAACgkQJNaLcl1U
h9CO+Af/UBAXsJGE9NN3tPz9CpviI1Xv3S28cWiubEXVJ+NzA4+IAt4j+1Y5bKls
HytSvkTYjWKuVt+/QPMjUDjahFueK0iMxyfNIv9YmcADzKx4NV4kqoV9vA2lSe3b
EvLpCG3N8rmHABUkHyTNAsUYDzAmia49miT9t3G0KFNzsPvbNTYzRosMRndYzd4S
dBlL/MthOmihCZmaRB4F+41mNCzmvz9FyDcwqzavI9CX2fM7oOviI1wmSla2dxrh
kyAn7uj2Tve+uBidpIiVZb7QKxHC/JSQR88IkKjhjXnAVlzhPIeuuuXCWXCOzlEE
nHjsO+Kzdq6sXue+dcbfP+GMhe7IEQ==
=2jGd
-----END PGP SIGNATURE-----

--s6adMmEGd2zLJf/T--

