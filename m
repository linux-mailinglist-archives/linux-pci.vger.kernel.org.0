Return-Path: <linux-pci+bounces-3771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8285BE45
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 15:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9233C1F2345D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC796D1A8;
	Tue, 20 Feb 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm+Ya5Ji"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0F6A8D4;
	Tue, 20 Feb 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438221; cv=none; b=SfCJvjhmEv/24NHtse3Whxp91YKtEkfvI9tfGWcTETxAeWlx13cPwrBLn+JzYrdPkFxe1Y9eL5Edr7TT1bYP0P67GzjV6EH9tg6MO+zGqSbuyOTZR4hju9pU96yK7d+z0LoWEtwJ9FZ2zY8KmqIW/gNdbmD7jrMfqYuviI/jSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438221; c=relaxed/simple;
	bh=g7ySRq9wVICEx9Nd4Soq3zjb4oVL4tzga3/RC80p8tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSMnk5cBN3q5JBkBNX0jfyxO3YEmsc09CgcPtfnWMVziXxLS+IO++VFiq3TNRNLLGEMUpDBOvpDFGWQzLDOcw7vZlwErcmx9BLnVofAkIBvCLa0KeU+/RxRYITylSSDGN+sr7pRw9eoFufjju3G/xdmaWEWoox0tZIW5wPPKgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm+Ya5Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5179AC433F1;
	Tue, 20 Feb 2024 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708438220;
	bh=g7ySRq9wVICEx9Nd4Soq3zjb4oVL4tzga3/RC80p8tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm+Ya5Ji9GWuHNAxfrcQd6I2ujiAInEXe/P3+PNGgSDevGXudNsGp2V/3RLHBAkOb
	 Ba9WTxCWVLl5wNyIFI4isq41BwQY+vRFVznQv40iE2Mz4cXSOSaEEuPFNrBM9mP7Ll
	 gBEkLKc7/vdpkvoOL2rNssVDZ9ummVyHIwQnQLEWcnBBcItGLQv9h+mYGWVHx0rI0z
	 4u3MnFOxXyv/m2m3D4ZxSbmZmOyZB3oeeOUualsoBByc0Op1jKoXwTfyE2/kLi8W9p
	 WV0cx5GH2DGpGrV4Zsnd6iOd2lLEsTSdXMln0WEGAqKiD6c0CEkl5McDMxQDvMGKU9
	 4UF370a9im90A==
Date: Tue, 20 Feb 2024 14:10:10 +0000
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
Message-ID: <4586127e-d224-48cd-9e56-a06a4a9d46bc@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
 <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
 <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
 <5a3f5e1b-8162-4619-a10b-d4711afe533b@sirena.org.uk>
 <CAMRc=MdTub4u0dm5PgTQPnYPuR=SRnh=ympEZqo_UyrQDrQw6w@mail.gmail.com>
 <f72723f3-f5c5-4c16-a257-e5f57c4f9e73@sirena.org.uk>
 <CAMRc=McFCauVwpATbVqCOtpyP_buKQDiN0OdZP9EfXmc3CgSUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p0M6Ter5LD+PPlml"
Content-Disposition: inline
In-Reply-To: <CAMRc=McFCauVwpATbVqCOtpyP_buKQDiN0OdZP9EfXmc3CgSUA@mail.gmail.com>
X-Cookie: E = MC ** 2 +- 3db


--p0M6Ter5LD+PPlml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 02:51:25PM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 20, 2024 at 2:48=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > It is generally a bad sign if there is a voltage range specified on a
> > regulator that's not got any indication that the voltage is going to be
> > actively managed, especially in situations like with several of the
> > supplies the DT was specifying where there are clear indications that
> > the supply is intended to be fixed voltage (or cases where every single
> > supply has a voltage range which would be highly unusual).  Looking at
> > the consumers might provide an explanation for such unusual and likely
> > incorrect constraints, and the lack of any consumers in conjunction with
> > other warning signs reenforces those warning signs.

> What do you recommend? No values at all in these regulators as it's
> the PMU which will manage those on its own once powered up by the host
> PMIC?

Unless something is actively going to change the voltages at runtime
or Linux needs to set a specific voltage (in which case minimum and
maximum should be identical) there should be nothing specified.

--p0M6Ter5LD+PPlml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUssEACgkQJNaLcl1U
h9A0+wf/dGVyaWOokSvLac7cy6ae2h/0zXhHIFK5iPDauJFh4S4DJ+qgYNXMraAH
Qv+OqeeDPmQZXSaVoSyeKyMhkn1i3MkxEeeUu3X4+RghPyRlA6UtcRYaXStSG0+U
dHZFqeoyVrQ4SnZhGRbLOIsO/dvjGtc7wQSglhml5ppRwEd8ma5IJhghT5PMiKf5
OqfbYKGn23QiTY6VqzzN13jC//ei6do3rutMY3EJ4U1wVR0mh27NHPRaZ04OVuyI
OBHICQ95FB+Rfd3rxNd9oquHi7GAzVnGBoYpyIgiswvNVuv0wEkkjBgKVq3rFPmk
Rj3zpctth3R9C7ObzByJhLuNcuzoPQ==
=pG1x
-----END PGP SIGNATURE-----

--p0M6Ter5LD+PPlml--

