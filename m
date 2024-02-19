Return-Path: <linux-pci+bounces-3741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8716E85ACB7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165531F24D9C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455A8535B5;
	Mon, 19 Feb 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T45+FMhR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96E535AA;
	Mon, 19 Feb 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372797; cv=none; b=khX1RLajPfHcVZLvL6AXr3N3VW41tIVsn69fGnPiW4kuU7Fb7MltNey6Tth9glYtisI2egrGx2gnChmITfgQiidhKhweAQNfeTq5hklHDo9APbKUngECRQ3gPlO+Br+Hcx737xItXedBssIbfFuX3lmUslkP1iq19mYkJP1dfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372797; c=relaxed/simple;
	bh=V7d3FUHDHjaNVIGYicTJg7/TYe1drwX4p1eQCSxDewU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEkUdzFfjg/A48XyX4qZ9hiot+D8QSaaebNav2umvx3rtsFIohZKU/SIAjecWaLa04OxYmGoX5pkoSYnSKBc9hcG/B/WJBWk0y95apqMssFSWxNuLL7URzHgXiVS1gdaBMTS7gvMxTJqmxHu45xn9oc25tHI8bmUnvR8I2I+RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T45+FMhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CC0C433C7;
	Mon, 19 Feb 2024 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372796;
	bh=V7d3FUHDHjaNVIGYicTJg7/TYe1drwX4p1eQCSxDewU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T45+FMhRUYku0IayKkrM4fevhsmPoINGwzAQ9OuvUumK7yoDAV0cFQPSR/JcJDNn6
	 IH86pdnnzsLO36yg9DvE/hK7dOZdenbuAKHEeg7OE2f+zxYFLmduoDZWzOGylGlVnZ
	 hoZoC5s4uP59yejL+WA87fY9xoX0np9crzdCKJA5yIqCoqjmyOKHS5oPLcM09Bb3BI
	 tHtxC/ShPCBum7nM440EwXfy4XGKPa6Nf0ATZqLhlndytiG9amoUQaXq+Oc2LvR9/l
	 KFDaKUBuG237eYDJ8O8YsLz3vgf0BC2UAqhKruifhPeeCoSZcvsGjOs3/8Y+Y8knzI
	 waWE8KNaC6a5A==
Date: Mon, 19 Feb 2024 19:59:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
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
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
Message-ID: <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
 <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emYsqvRPUjKAiXsY"
Content-Disposition: inline
In-Reply-To: <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
X-Cookie: Kleeneness is next to Godelness.


--emYsqvRPUjKAiXsY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wrote:

> > > +                     vreg_pmu_aon_0p59: ldo1 {
> > > +                             regulator-name =3D "vreg_pmu_aon_0p59";
> > > +                             regulator-min-microvolt =3D <540000>;
> > > +                             regulator-max-microvolt =3D <840000>;
> > > +                     };

> > That's a *very* wide voltage range for a supply that's got a name ending
> > in _0_p59 which sounds a lot like it should be fixed at 0.59V.
> > Similarly for a bunch of the other supplies, and I'm not seeing any
> > evidence that the consumers do any voltage changes here?  There doesn't
> > appear to be any logic here, I'm not convinced these are validated or
> > safe constraints.

> No, the users don't request any regulators (or rather: software
> representations thereof) because - as per the cover letter - no
> regulators are created by the PMU driver. This is what is physically
> on the board - as the schematics and the datasheet define it. I took

The above makes no sense.  How can constraints be "what is physically on
the board", particularly variable constrants when there isn't even a
consumer?  What values are you taking from which documentation? =20

The cover letter and binding both claimed (buried after large amounts of
changelog) that these PMUs were exposing regulators to consumers and the
DTS puports to do exactly that...

> the values from the docs verbatim. In C, we create a power sequencing
> provider which doesn't use the regulator framework at all.

For something that doesn't use the regulator framework at all what
appears to be a provider in patch 16 ("power: pwrseq: add a driver for
the QCA6390 PMU module") seems to have a lot of regualtor API calls?

--emYsqvRPUjKAiXsY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXTszEACgkQJNaLcl1U
h9Cnngf+IYF9pPUvDAr0+9oD3KtUt4+wAyqpvCYd3QuvT98XgcKtkxuBF8yVrn3o
LceeY91qW8Y/CLz4ZXDqVdWCd1bOtiU48jYXX29ZuQciuXy20B+0LuJ8hkYSkAUk
JZplf/496WYrFs/92k/NhBU5djkuEGpxjp+LD+0mGJT3RJphr59zb8ToDh3Fi3Xo
9Vw/tkd7v+/tZY7g+OJsbnSi1/WHnHYepYRh9O5eO7CYRsHw1sHELt2X5s+wQKv7
rB+MB9piVE3Vjuys5hjODJMTFg5eZJix6jHU+9xKA5FxezF9mo1Yan6MceBP4ZBK
IU9LsWWcwWsnu9mgk5kBM58ddzUI/A==
=aUMd
-----END PGP SIGNATURE-----

--emYsqvRPUjKAiXsY--

