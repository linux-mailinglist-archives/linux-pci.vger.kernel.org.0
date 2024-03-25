Return-Path: <linux-pci+bounces-5112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C188B478
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 23:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3216BA2544
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916A15B573;
	Mon, 25 Mar 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcCXfc3H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A11474C1;
	Mon, 25 Mar 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377273; cv=none; b=E+aUb4ki+p+aI5t7pxgo6Sdp46B0QdDaLNlqdPkQE4HUX+5c2qz3G4VBA97SBW1LD4WI+wIOi+RY3eztvF5w7Bw8GgMtSCXzuchvVW2sW7kXcWuW+sk/gkSjS9M33h4IkMhQSeZ23p422Iu6LJfnNLWoSEFleSW9RJLeYKa7SgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377273; c=relaxed/simple;
	bh=UCESJeGnm4JbuMkNd6rEIBMlcGTPe5bgbsKg1q5ymy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/BikgTrW5n8ybGw3TZZfZ9J8toHz2tLK7LGue7aM0mr9Z026fNciDqvUm6TQ1aubmyhBAAw22KaLLmSZferUldUY4rE5bLbbrqT5exdnae50YnhlxocL1rnw8F9kQaMT8ojuWR6q//zEolCGjeoTiHH0bIpjtqHdnjpk5YOCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcCXfc3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70180C43390;
	Mon, 25 Mar 2024 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377272;
	bh=UCESJeGnm4JbuMkNd6rEIBMlcGTPe5bgbsKg1q5ymy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcCXfc3H2WCW9N5DANps5NIFiIOvDjTZAMxeiWtxlA4Ov0TwyL2dl7EfhswHnFa2f
	 g+M9HHYHMtPmHWXOHFAqfVOegcEfJZRLvEg0n0WIhekrfjVxQYzrxa7HlcLcyxUUlf
	 rqG92B/qdqQr26sYjZEo7M/j4uol1d8iIKOJiGWVx8LblZKZoft9jpuqKpyNNc8pCR
	 yjLtGpNyDKpZFmr4rrTzH6zh9Wzo9b1H1kEPVJajguIRdc5du4sLRd7LTelrxDCotI
	 9RaeK+GZpqJSHwZJgt5v8qFdhfC+1xI/G2VEyAJX/QICByTyTbUb3IgD7vZNYNpYEJ
	 TqNOCKLLgrNiQ==
Date: Mon, 25 Mar 2024 14:34:22 +0000
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
Subject: Re: [PATCH v6 02/16] regulator: dt-bindings: describe the PMU module
 of the WCN7850 package
Message-ID: <e9352c4d-00c1-494c-a9b6-b0ae8870087d@sirena.org.uk>
References: <20240325131624.26023-1-brgl@bgdev.pl>
 <20240325131624.26023-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uZZ7E7Yd65fnC7GL"
Content-Disposition: inline
In-Reply-To: <20240325131624.26023-3-brgl@bgdev.pl>
X-Cookie: Evil isn't all bad.


--uZZ7E7Yd65fnC7GL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 02:16:10PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> The WCN7850 package contains discreet modules for WLAN and Bluetooth. They
> are powered by the Power Management Unit (PMU) that takes inputs from the
> host and provides LDO outputs. Extend the bindings for QCA6390 to also
> document this model.

Acked-by: Mark Brown <broonie@kernel.org>

--uZZ7E7Yd65fnC7GL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBi24ACgkQJNaLcl1U
h9DvpQf/aDvnSe5G1vXuvYzVYVZkcvouB3JQroLnfFKG5XZBqVSaLuK90TUecGjE
FQMweu3bbGsfmjyAyxswaEVTaNHibP5XNEmKi1kkoDMG1ok7Zn8VjYBPBlA8LxxC
AjuGTfnNx9yBUhxxJ0DkIpJvzsJM74MN09RtSdJPOAcrOU/glQXFobbNN73W2EfN
bKYk68fXJ1K0IIGs9TxJK+h2lj4VcGRBBk2fuyYsggT2auKWMXNcw1x//PqXMWnm
M9X3q1MZz5igvNREPHMB2zyzFQa9QWi8JNm+Ft+znj6IiTOs5Ai1YO7G0Bt2yBjb
2Kx1BtsuQNL+aPbUsETWfbb2v2Av3g==
=R5mu
-----END PGP SIGNATURE-----

--uZZ7E7Yd65fnC7GL--

