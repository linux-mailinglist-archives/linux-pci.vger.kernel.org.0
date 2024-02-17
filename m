Return-Path: <linux-pci+bounces-3661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC93E8590A5
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 16:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878241F218E2
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8657C6DE;
	Sat, 17 Feb 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oai0G6qL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF777A735;
	Sat, 17 Feb 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184889; cv=none; b=WxGTzcF5oDs5kh3oEuN3IgqSCMeEhMQMN1nKGlo45W4gbwIFhdcwTRTXPRpQnWzX6BcGIG5HI4ulzWqzcsd9UFfEJzueZhS8dTXuJmF6T/Pm6jDgIxLO1wrkCvhsRNvNLarrNd/Ml9frqbAwEpMx28PeEnTb7qj3wLl6sUviGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184889; c=relaxed/simple;
	bh=n957lHva6zeenMJ+yyB11NqmI51yboi14R4UBuEZ4d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=untcMPs61c7k1lphGrXn8VbBVg9kAPZIfDIYolFyKww7uwOzwx3RKw05QOVaAlAKZdsUUGZKTlph3jnDS9qvGZ5DQGMQE4eeDwIfuxAW/n7jXSkHscrB1GdeVN5oq3F1pYKL/JYiEEQ6MKlgGjoftEe5YrZDOM6Jxj1qml3VIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oai0G6qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF36CC433F1;
	Sat, 17 Feb 2024 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708184888;
	bh=n957lHva6zeenMJ+yyB11NqmI51yboi14R4UBuEZ4d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oai0G6qLzbylNPvS6aAPc55ThgalhgPu1SYKajhqffmpQesjJ2OqsAP/JoGNo3voU
	 TkrvaUuRD2SqntuJ/K01y5d1cfIh36BRU+bkXQuUhLqzj96BRf0TatZ/fIrmiHQBfy
	 wbMriDgDmlonGvNa5Az+exOwOL+XPPfFp0HKXkzfMTjkjZ8WwpTEqHcf10aTAm5TR1
	 Axyh29QvnrtErk40PPetNMIw+oj/HTCOjcH+PZHOTdLngCU2zbuqnsd5ZAYgaps59q
	 PvIb4F6sN53mvYvb7dnp8pd86GrjiYbn0psSCl9KANB/lgGL9B553RwT3SLIshZL/e
	 JlF0JcX0camYA==
Date: Sat, 17 Feb 2024 15:48:05 +0000
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
Subject: Re: [PATCH v5 03/18] dt-bindings: regulator: describe the PMU module
 of the QCA6390 package
Message-ID: <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XBBFEBnxsUybHGMW"
Content-Disposition: inline
In-Reply-To: <20240216203215.40870-4-brgl@bgdev.pl>
X-Cookie: You might have mail.


--XBBFEBnxsUybHGMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 09:32:00PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> The QCA6390 package contains discreet modules for WLAN and Bluetooth. They
> are powered by the Power Management Unit (PMU) that takes inputs from the
> host and provides LDO outputs. This document describes this module.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--XBBFEBnxsUybHGMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXQ1TQACgkQJNaLcl1U
h9BBnwf+JhH7AG76SVpXm/3RKzqDWuvpMu1DUot/+e5n8hK2kqMFn55zOAN2HEwL
bZLO+MD8fXjFjLXZQ+4K8xdooNenzvCyvfYuxE8RoyThkbheKCY+m8aQLTlik/R3
euRIOevSUYqQhYY1q5z5bgAEC6RwQi0sAHYATTbhqBjNi/MogEbXje1VBfStNYEb
tKWS7Yi/GPw22IXDH8PYurLmAXp9k65N8ajJX7pMcALn/uUvPQZT77TVLjZ4M9yp
a+0SiBJypHB9nTzWsA89yCH97/kWFYzAoE54vUxuQB4N6l0XgDyTyQIzIJfuNg0F
h5HG2zP3ZTX/v/CVQjc3Vp4maV3F5Q==
=r2fB
-----END PGP SIGNATURE-----

--XBBFEBnxsUybHGMW--

