Return-Path: <linux-pci+bounces-5111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49988A959
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190081C64534
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6353149C7A;
	Mon, 25 Mar 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwGTfZ4S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA612C55D;
	Mon, 25 Mar 2024 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377233; cv=none; b=R292hLSvKxzJN6UVcsrAay7BaxOkTzO7g21MaC79QO0s7ug409dRCbepK71qXXcVeEwsJ1tQODj9gy/Cx1M8FLnMPjf2SOltLNulc7l1dmAdPCyU8DA6HG/0LVNKP7AWIKdlwnCHPZYWmJHm3bXSzr7G88rGydll64Ybek45B1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377233; c=relaxed/simple;
	bh=I8gGjUabBFBdinEZ8w3xLeRQEfRy+mHaSAx/ueiu+40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPDnTgyZ+zD/h3SbirmDL4jk9SA4VKL3TvsKuCAcDfAvhSxCfQXTwDxGVkrKFOKv7IgpgnKc7pdaDkPR99oeJ1FVx42OQVxyiJuZtUNDLaaOU0nImgZPH3mlVt+g42uOvdFsMQBiDhLBjwyXejzy8Fg1nPYbHxydqjti1HhncaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwGTfZ4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA51C433C7;
	Mon, 25 Mar 2024 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377232;
	bh=I8gGjUabBFBdinEZ8w3xLeRQEfRy+mHaSAx/ueiu+40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwGTfZ4ShLOkmcP2SDowGUP24PHw40nxwQ0YvPPEMQoc9ATkG5gM8iZxzfOnu5sRD
	 UwSN8WIBhDTUqSGcf70UElmHWw4r+uQJbXCj6GVa/HUOSTqZ8SjItI/TLZfjLKFYVb
	 jVgHhwDEcWppwKLrXjpTUcw8+6wmFPrumLvMm0dZewht8np1+OcS0EZkB/G30kbtZi
	 95N5Z7T58ICVBDySFjaI2c6LS4Jvr4xorat/fbqwktT0ORUOJWzGrCuKqnZhZZS7CT
	 muoF2CaxPRzjQFv+XRluV81Q5NVeAVQYqFGBhKcsDxvfwURItxgT/oQf5PN7eSCw5l
	 J6x8GepzXZ4bg==
Date: Mon, 25 Mar 2024 14:33:43 +0000
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
Subject: Re: [PATCH v6 01/16] regulator: dt-bindings: describe the PMU module
 of the QCA6390 package
Message-ID: <4d8d55a8-fcf2-47b6-ac0e-2bbb99bb895a@sirena.org.uk>
References: <20240325131624.26023-1-brgl@bgdev.pl>
 <20240325131624.26023-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cru5I7A758SJZEDj"
Content-Disposition: inline
In-Reply-To: <20240325131624.26023-2-brgl@bgdev.pl>
X-Cookie: Evil isn't all bad.


--Cru5I7A758SJZEDj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 02:16:09PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
> are powered by the Power Management Unit (PMU) that takes inputs from the
> host and provides LDO outputs. This document describes this module.

Acked-by: Mark Brown <broonie@kernel.org>

--Cru5I7A758SJZEDj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBi0YACgkQJNaLcl1U
h9AdIwf/SWJguM6qR3+2+NfBzS3BClbo5tKAaN7frc+HgiFkmcN+TDdydwp+qfxf
t33nHRvZIdzfbxrYkACIlOO6o55gf1Cahrrsb9l0Lp4MzBxcC/oKnrQbqIxldiJ9
LYcYPT+9yhvRkPTkiqIpbJG9WMJwdNVPILl1NEIQBdMA6UNmC7xbBEUh4BRD8qbi
v8qSPzhQj/7O3MTfD+/d1JrH9fVXUY1roL37PiDSW0XkQo6oIyTa2oEKjEibyPig
amlwRcPUhjelQwkhTc8jH/fH1DmXkkK/Uw04Y77VKP5dhUdPo4hDVUJTAoOp/rmt
l5q8gRzt2QPqjhuQmXVXBsXA1PoApw==
=yWUc
-----END PGP SIGNATURE-----

--Cru5I7A758SJZEDj--

