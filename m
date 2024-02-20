Return-Path: <linux-pci+bounces-3801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074D85CC2F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 00:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535791C227F0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E51154BF7;
	Tue, 20 Feb 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVw8eBpT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BD15444C;
	Tue, 20 Feb 2024 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472666; cv=none; b=NOlWbgbqZ2zl1iHh8CkO8jCkR5fS87PjWZSCzlGgEVLGrc+V9BqDTuYnIqEYXDZCyknJVqBPld+xBcQFbfvtOCEfQpNlSe4/i1avKs37tHOUuze64Hpy64pUbl5nKlaGlnZKajFihzRHFFb2ghrJbD/4shPfOzgGoRuRzXFZBAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472666; c=relaxed/simple;
	bh=Zxy/pymnMx5rTDOnldO5AbT5UwWB1Dt3XC+eanXoo2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJWSICJMZ44PGLmO5i8WNKcBHnIF6c01TpUO+mJQZnKoeb/cy7Q/GsAbeDyB06siKzPLQgOIDDIGBnTm1L+yFy5qte8azTRiz5LE3s4iQo145BFRoA7mcV7RrPARMPtFV2RjaGCrrCLgFeQkz7w5LIMX5ntvALi4A/9rtHrN+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVw8eBpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2019DC433F1;
	Tue, 20 Feb 2024 23:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708472665;
	bh=Zxy/pymnMx5rTDOnldO5AbT5UwWB1Dt3XC+eanXoo2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVw8eBpTCjdftSTyEbvxYQwqBQu3kUyua3/5maqJotrEpeQPF8MT/1EbtFAFQFqfY
	 K0t7zPYZFcaMD3RHTzSC0Uzv22Ugf1jGS0lzKX4sZDiF2uJlHtf54PreCVaOTr3Tfw
	 EsNQcr25WGsNXahnwTYIKVKmHvjdlK1vnLLqa/lqMd9ZP0CJAoHHVpjm1IDApXd34L
	 K8FF/7Nu8P3ZfXeqfPWePnahSDfkXSU50X19KYac3SI+AfDNsTcHOD0rG9WKxl6ASe
	 5A+s/TjQHvdaFIsr3eOLqD/cnd9vXh+RwYFkBVZ9DdjLYfhoL8QluOXvPfeX7MKiVt
	 orv+kbQUnDC4w==
Date: Tue, 20 Feb 2024 23:44:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
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
Message-ID: <53f0956f-ee64-4bd6-b44f-cbebafd42e46@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-15-brgl@bgdev.pl>
 <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk>
 <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
 <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
 <17bbd9ae-0282-430e-947b-e6fb08c53af7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w1C+bNORgZucbhbU"
Content-Disposition: inline
In-Reply-To: <17bbd9ae-0282-430e-947b-e6fb08c53af7@linaro.org>
X-Cookie: E = MC ** 2 +- 3db


--w1C+bNORgZucbhbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 10:21:04PM +0100, Konrad Dybcio wrote:
> On 20.02.2024 13:47, Mark Brown wrote:

> > Are you *sure* this actually happens (and that the regulators don't
> > figure it out by themselves), especially given that the consumers are
> > just specifying the load once rather than varying it dynamically at
> > runtime which is supposed to be the use case for this API?  This API is
> > intended to be used dynamically, if the regulator always needs to be in
> > a particular mode just configure that statically.

> *AFAIU*

> The regulators aggregate the requested current (there may be
> multiple consumers) and then it's decided if it's high enough
> to jump into HPM.

Yes, that's the theory - I just question if it actually does something
useful in practice.  Between regulators getting more and more able to
figure out mode switching autonomously based on load monitoring and them
getting more efficient it's become very unclear if this actually
accomplishes anything, the only usage is the Qualcomm stuff and that's
all really unsophisticated and has an air of something that's being
cut'n'pasted forwards rather than delivering practical results.  There
is some value at ultra low loads, but that's more for suspend modes than
for actual use.

--w1C+bNORgZucbhbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXVOUsACgkQJNaLcl1U
h9B4Sgf/U1Mvu4f6A7qzABpKd9BB7OcLPxH6iSmo8bzo4Tx8MZhge4nd6FITJ9Qr
BMMbYW8osslMnOrHCH0Pat8hVGnQqDL6a0xURC3B0/E1PLgC9f0+licqpxxQTRqL
V2Mm42QnAwLrug2ACCRxhByQxjl8c4eknu+KFgpJtIJNfM5UlnJ4kF4voEBkQBIC
/69z0ZVKAyuebe3Q+EtAh/Vm0HA2d6cb9JsjqOSQnoyFXEqExFuqEZoIhdzrn9bM
Y6j+npu1uSv+PyaTRXnB6Kf7SZdk1cmghtBmYh/hSh3tjsZvJw5i9GBc3UklYcl+
oSruwA9tsK/zK0w2x1N+Iah+Bv2l9g==
=u1/w
-----END PGP SIGNATURE-----

--w1C+bNORgZucbhbU--

