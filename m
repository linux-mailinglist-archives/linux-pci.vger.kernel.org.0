Return-Path: <linux-pci+bounces-3768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09085BD84
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD65D1C22379
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9426A8B3;
	Tue, 20 Feb 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kzgo/kMY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA06A8A2;
	Tue, 20 Feb 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436933; cv=none; b=qk4R1MkPq3EP5Z8v1TKQjOvO/YKlOqWARYtlYhF8YWa7FPsCmHhEcGSGdNgHfWlKV5W4Lg2oFfjdN8/64sCegeo2TgyLpEUM8QRGnTrALmhhzi+yj1GTOrP4fSFV2oOK4nk2+42hJgLW3sN8/tbjf0GwILHlIRZeXtc3YNwWxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436933; c=relaxed/simple;
	bh=YC8rgxMYsXiObwoLfeP5CLE6j1/Tcmi0OcU5mPnZIww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuLz/4X7Nmaj9TpWE/FQndyhcEZTMQ3v9qR+Ge5Y+M0UlQvGvTJczOu3fYtkXBm9Wdcad9DV7oPvlxXJGhOmPHngE7H7bdK0Uu313HPHQUFR9cTOSqGzRErgQlfyF/03khxFGRwbUd/Sw5AtIXHey9EevXDC9+4jkquGLIUV9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kzgo/kMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FBDC433C7;
	Tue, 20 Feb 2024 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708436933;
	bh=YC8rgxMYsXiObwoLfeP5CLE6j1/Tcmi0OcU5mPnZIww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kzgo/kMY6kB8e16x373X+nZBYRtZPWjbszF/D10p4CrIs0z1D+/0cZouLeQB91n2j
	 Gqy/BbAgiAHBMGPwPdGFVDf+u3kZgkwlW08V2RE/dLN2F4bEnxEmLXXZ8E4BV/si12
	 1Bqf7tscKk+MgaQXW3tGv0Igcn2yO1AEvI58V7Bq/D2AQ0jY9LZh3udQPlnEwFC0hD
	 CbHrl3JULRp6TrqbQH9VQcyAjoG4CJtWq9LkjxSDf9EoE9wqjWcD+fSFJwgPEcZvgL
	 EW9IyDQgJPN1weelAN2llqQOZ9zLb5reAZvuQWF+aeLgGbd2BcvleXJ5gFGLeJBJiB
	 0jDjiI4KxrkVw==
Date: Tue, 20 Feb 2024 13:48:42 +0000
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
Message-ID: <f72723f3-f5c5-4c16-a257-e5f57c4f9e73@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
 <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
 <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
 <5a3f5e1b-8162-4619-a10b-d4711afe533b@sirena.org.uk>
 <CAMRc=MdTub4u0dm5PgTQPnYPuR=SRnh=ympEZqo_UyrQDrQw6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TzIdp7BUtsKYDYnZ"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdTub4u0dm5PgTQPnYPuR=SRnh=ympEZqo_UyrQDrQw6w@mail.gmail.com>
X-Cookie: E = MC ** 2 +- 3db


--TzIdp7BUtsKYDYnZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 02:38:33PM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 20, 2024 at 2:31=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Tue, Feb 20, 2024 at 12:16:10PM +0100, Bartosz Golaszewski wrote:

> > > And what do you mean by there not being any consumers? The WLAN and BT
> > > *are* the consumers.

> > There are no drivers that bind to the regulators and vary the voltages
> > at runtime.

> Even with the above misunderstanding clarified: so what? DT is the
> representation of hardware. There's nothing that obligates us to model
> DT sources in drivers 1:1.

It is generally a bad sign if there is a voltage range specified on a
regulator that's not got any indication that the voltage is going to be
actively managed, especially in situations like with several of the
supplies the DT was specifying where there are clear indications that
the supply is intended to be fixed voltage (or cases where every single
supply has a voltage range which would be highly unusual).  Looking at
the consumers might provide an explanation for such unusual and likely
incorrect constraints, and the lack of any consumers in conjunction with=20
other warning signs reenforces those warning signs.

--TzIdp7BUtsKYDYnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUrboACgkQJNaLcl1U
h9AUegf4sL0ibn2WhQVo2jE/mB56ayVY4daCFJmLey10o3xzG6j5CHdfj7ZENBPk
kozPN2BW9C/e0Er+hMKCtTgvm7nJUfVKNcxMd73sXUj44E9Bx57GVOwlBzREZd0w
O1taO3DNZOTQqwGEaYjjeX9Rac+LU0m0+s/PHv5SbgO7ZlvvHUX0u2sEhyM4Sopl
NZ1NA+cK9TLOo3ZZjtH5EF8sXMtvRaZr01MwXp+2fljFIkJLx84wdv1oVmOR0I8r
vobnh7aFX0dyCHgCD1cWqm/QqR0Um0Fc9utXOXTByvvR6L4VlYZvCXnmgvw9Hn1O
4UdINenyan4K1XpHuoZicZYZbwpU
=v6IJ
-----END PGP SIGNATURE-----

--TzIdp7BUtsKYDYnZ--

