Return-Path: <linux-pci+bounces-3669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF198592C9
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 21:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBD2B20C8E
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428697F490;
	Sat, 17 Feb 2024 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAecfohW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D26A024;
	Sat, 17 Feb 2024 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708202615; cv=none; b=RtcrNlToqbkMeh5eli83DuISnQXC16truZveGemxttsoyQwGjnoCJraY9aZlNKXz9N9kt/7TjAMRofC92WdpmZqNr0QOOhuvn9PAFZKzlj0pM8jn0Rvvix3vwa/bkNffWTw24/L4Yr8lej34AAR+d55IJVSDoF5+MdlODhUYeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708202615; c=relaxed/simple;
	bh=E6LVY0jyOMzyQvE2PHS8poQ7j8DUOqfa7MfcV3PR2qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2N9rM4GuUlHGw+bToZMgj9r8XDe2w4mfBzp7CbWCPhe08W18IacNmz+SIoJnD2SgnI4Sp52TJVnXZPr15AlXLXRwj3qPAk527huunPXvVdI38pXnTO4xLpBNL8sb/fnvmzEkN64f3KX9tLrPFriSgV0q2Cz8+/dt/4rjaRtznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAecfohW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08B4C433F1;
	Sat, 17 Feb 2024 20:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708202614;
	bh=E6LVY0jyOMzyQvE2PHS8poQ7j8DUOqfa7MfcV3PR2qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAecfohW+IJqaLkNGE7g8xML4Qs2FKZsau7yveR8TiJ6L3WA76boZ0oXP0914cfWB
	 uRs0x5kDLFokHV5Cp5HtR0Msj3By0u1iIuTzFn74parSYqAQkBIzwglt6mSlppgWyy
	 nB548ZQd+sF3xdChKxGAaXDAALtbxnANx3WhMvz8nZmvATSjOep/ocJMCS6i6PDjnK
	 KXiqtTk+vXLRbVEESgl/RzZNh46pql8L2FJ2BJzpCtqn1SwkYL1HCPvnRpHrlhV9lJ
	 e30LjKoHTXHWnfq5BKfqAB96du/na1YhLfvkFLMa4ppJEp14/HhdqYxv4OMdKerGyC
	 Te1x7q1SX0iKA==
Date: Sat, 17 Feb 2024 20:43:31 +0000
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
Message-ID: <ZdEac8I5aI9YLq6A@finisterre.sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-4-brgl@bgdev.pl>
 <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk>
 <CAMRc=Mf9Sro4kM_Jn8_v=cyO5PxCp6AnBdeS9XspqVDGKdA_Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4JPKTS4lZXvnOqCl"
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf9Sro4kM_Jn8_v=cyO5PxCp6AnBdeS9XspqVDGKdA_Dg@mail.gmail.com>
X-Cookie: You might have mail.


--4JPKTS4lZXvnOqCl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 07:32:16PM +0100, Bartosz Golaszewski wrote:
> On Sat, Feb 17, 2024 at 4:48=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.
> > Look at what existing commits in the area you're changing are doing and
> > make sure your subject lines visually resemble what they're doing.
> > There's no need to resubmit to fix this alone.

> This is quite vague, could you elaborate? I have no idea what is wrong
> with this patch.

The subject line does not look like the subject line for a regulator
patch rendering it almost invisible in my inbox.  As you will see if you
follow the above suggestion and look at other commits to the same area
you should see that subject lines should start regulator:.

--4JPKTS4lZXvnOqCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXRGnIACgkQJNaLcl1U
h9Cz7Qf+L7vTsGPGjWXms+ypHuuzrseRY+5tqVWHSXyldocHF3sZ+8P7xcqUzAKl
OSLoaJD1RINGVTJodBoPBZ8w+8cJW5rYqn2m9fx/cRr+0bS96WUsrGD9HYTkz7VC
QsORvLoiq2VYhEOaT4dRZxEXAEMgu8wfJ1tpZSFciws/lfvNBcIY0EjI0Nud1tND
HIXvt3iwCGm0lW+ppB93ZjOZiw4vMMJchH0R3piJ9l4EKvrMGiDYdNb1H2YuINzS
zq3lBvkkKTsY7oNfocA683WAe7N2l4d4MhUcm0TP4Be2BzuT9nvgZNRFWK/fa90r
vaY0Cs9mXiyitePpzt2YKY//+qSyLw==
=9A+9
-----END PGP SIGNATURE-----

--4JPKTS4lZXvnOqCl--

