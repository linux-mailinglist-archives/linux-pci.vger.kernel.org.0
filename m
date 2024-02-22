Return-Path: <linux-pci+bounces-3863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30785F7FE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57A61F21CAB
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B6605B8;
	Thu, 22 Feb 2024 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vais+w7d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075355C28;
	Thu, 22 Feb 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604507; cv=none; b=Z8xJ3xZsVFNTHO/YjKKJzrpI6I9tzF6C7tuoZDhAe6lzSZrXpsLN4nI+fVZWJlhR25OY08R6zTg0uhsjBKDZUY3U2aQ3JfqHhOmThqn3wqCXsYljwak89oYSqDoXk9Y/gh1e7iCC4+UpYUUMeYR9NEbyadX218spl5A9DgFtqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604507; c=relaxed/simple;
	bh=EqZbzaH/qaB7a7IKc6JYTdatq4CHgvMWc4c4mJHW2hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVjtJUg6NUJ5CM35VO8VXbepV/5gVRPM799nC637htVLwp30Vkr29y/MxlWFwdiSyuCIcyUTmm5daNeBhwbSODwh+31ZU6djOzVTj1djWdL/445r0Pdcb6xfvt069m5WRnr/qTz2ihDF0JX0b434506R7vM0Iwz7SQsrMo9lsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vais+w7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E0DC433C7;
	Thu, 22 Feb 2024 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708604506;
	bh=EqZbzaH/qaB7a7IKc6JYTdatq4CHgvMWc4c4mJHW2hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vais+w7dVBc+Xk4EvckzPmvM6a/2KjvGzm2VDrn7oZd6lT1sMCuOcX1qDb2PMDCEW
	 IZALOUfq5R7czopyD6Q8n/kouh0W3vDg13fw2wPev+9aOxAzv5iSFTj01WlgeRtm8q
	 rfrlSSvGHi8dMfB4nzhaZ81mQagcgNVTDsSzCfY3Yk76RiQvI4C+1mW9qVZN85sa5q
	 Uz3u+hqODk6ps05MFS1CAhRh/TkO/5AAWb5UNCazW0O8MTp8aD1OJpRyMUiaGn3Rcm
	 lv9vU3NJ1hmnoVZQ4RN+226xKHklRHGaTs1CBXAw5vmIXparkNzLdJs/W+pgHBWnYG
	 hT7MEcGskAyYw==
Date: Thu, 22 Feb 2024 12:21:36 +0000
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
Message-ID: <52fba837-989b-4213-8af7-f02cd8cb48c8@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-15-brgl@bgdev.pl>
 <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk>
 <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
 <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
 <17bbd9ae-0282-430e-947b-e6fb08c53af7@linaro.org>
 <53f0956f-ee64-4bd6-b44f-cbebafd42e46@sirena.org.uk>
 <CAMRc=MedCX_TGGawMhr39oXtJPF4pOQF=Jh2z4uXkOxwhfJWRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/jaeVyfzRnxNsGp"
Content-Disposition: inline
In-Reply-To: <CAMRc=MedCX_TGGawMhr39oXtJPF4pOQF=Jh2z4uXkOxwhfJWRw@mail.gmail.com>
X-Cookie: I have accepted Provolone into my life!


--M/jaeVyfzRnxNsGp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:22:50AM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 21, 2024 at 12:44=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:

> > Yes, that's the theory - I just question if it actually does something
> > useful in practice.  Between regulators getting more and more able to
> > figure out mode switching autonomously based on load monitoring and them
> > getting more efficient it's become very unclear if this actually
> > accomplishes anything, the only usage is the Qualcomm stuff and that's
> > all really unsophisticated and has an air of something that's being
> > cut'n'pasted forwards rather than delivering practical results.  There
> > is some value at ultra low loads, but that's more for suspend modes than
> > for actual use.

> Removing it would be out of scope for this series and I don't really
> want to introduce any undefined behavior when doing a big development
> like that. I'll think about it separately.

This is new code?

--M/jaeVyfzRnxNsGp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXPE8ACgkQJNaLcl1U
h9CIHwf/XP89jkt/tlGa4jICwu1iztzFqaiTJkTcvJjUXga/U61RNmUVRGfMlGTs
NbXYJFbdHP6Rz6ClY+/Ws+p1AsrvAOj18ufykhqOSOf5OBAsi8Lzeex5WSN0LZKs
iT7v2mfE45b+lM8yTNapT0z3KoAKh9QWJHmohYHG+cJadqgoYuv8zZfPVWIBJhFD
I6jZ37EHzRJ5t9CgmJBA84tQojwDT3sie2EuZQ+wTGvaPloUU3LJuAv+ZF5LMsIi
o+kwTHP7xgkb5VD9I6EcO70CHkzvwSKLXzuhvEB4jGlrWNXjL7ZYjPyoruUMbtrS
LRRnFjVnLkvTL1/Jg1GArsnIQd7Xow==
=UdGL
-----END PGP SIGNATURE-----

--M/jaeVyfzRnxNsGp--

