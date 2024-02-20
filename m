Return-Path: <linux-pci+bounces-3765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231D885BC91
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC30B2574C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7A269D1D;
	Tue, 20 Feb 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+70rKxC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D89482FA;
	Tue, 20 Feb 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433279; cv=none; b=SgiSZnYTQFrCgJUet+d/Td4HLRll7FM3Q8+TF0DeENcrUOQgO/p/8B3EIZzBJ9o5VPzYnoBrP9mHgCp37p4437xOzJuml7tFTw+NtiPct8mwuejDpr/NZeCmRigzIdpAWcGf3ufM3GqhF1BU34girSZuWAs8aK3YxMcfeoX9Bas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433279; c=relaxed/simple;
	bh=ViefJugypi9Weib1Uaokne/i9seCAk+ZC9k+nnoVcWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enLCj+eUSP5TOx+bEoLMQG+hF3q7+nNHGkL/E1BCT54YYJ0ANFxY7FNOl4nub2lO5mtpoxSH9+X+PZIW/CAyB5kIPm3f7N6y+MeEwpq2QVYnNb03CZ/f8JFI7xGJ8KYTWEEsPQtqirIlkpFGRA+8dym6LVL+hyMvnlHO83vMQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+70rKxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF8AC433C7;
	Tue, 20 Feb 2024 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433278;
	bh=ViefJugypi9Weib1Uaokne/i9seCAk+ZC9k+nnoVcWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+70rKxC/6pwXD95cIIDMA1V+jnd/1+CGcXC46So93DH3Xkfgy1cC8BWRR3qI4542
	 kCHuo10Mnf3HQionPq2GoeJHytdnySZN+AtXrVQy7+ULywO7SE8Z3CUfiJ8NRj1Ywd
	 z7mhQpiMcCcX40rL7NcE6M0QXbOPdV03WEInkMea6IY5d/oCerFF4v6U7n7ekmm2u2
	 QpqT8/H1cFo+jxS7xEUsTnd2m+nfD2Tamm1ILj4nnQhRbMCeNhB4jl4Y2W3k5YORzJ
	 UTeGrLpyNukJdQCdQuzVaR5Vu6MU4U2KSZ2E7pwDn9cfOhwfnPepW50PFYspCXupGX
	 9bF65zzZydcSA==
Date: Tue, 20 Feb 2024 12:47:48 +0000
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
Subject: Re: [PATCH v5 14/18] PCI/pwrctl: add a power control driver for
 WCN7850
Message-ID: <ea08a286-ff53-4d58-ae41-38cca151508c@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-15-brgl@bgdev.pl>
 <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk>
 <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g16doyZ3qKVdSFBl"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeUjKPS3ANE6=7WZ3kbbGAdyE8HeXFN=75Jp-pVyBaWrQ@mail.gmail.com>
X-Cookie: E = MC ** 2 +- 3db


--g16doyZ3qKVdSFBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:22:42PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 19, 2024 at 6:50=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Fri, Feb 16, 2024 at 09:32:11PM +0100, Bartosz Golaszewski wrote:

> > > +static struct pci_pwrctl_wcn7850_vreg pci_pwrctl_wcn7850_vregs[] =3D=
 {
> > > +     {
> > > +             .name =3D "vdd",
> > > +             .load_uA =3D 16000,
> > > +     },

> > I know a bunch of the QC stuff includes these load numbers but are they
> > actually doing anything constructive?  It keeps coming up that they're
> > causing a bunch of work and it's not clear that they have any great
> > effect on modern systems.

> Yes, we have what is called a high-power mode and a low-power mode in
> regulators and these values are used to determine which one to use.

Are you *sure* this actually happens (and that the regulators don't
figure it out by themselves), especially given that the consumers are
just specifying the load once rather than varying it dynamically at
runtime which is supposed to be the use case for this API?  This API is
intended to be used dynamically, if the regulator always needs to be in
a particular mode just configure that statically.

--g16doyZ3qKVdSFBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUn3MACgkQJNaLcl1U
h9Coegf/cTLhALjTXQxrUSAhLhbbWi2aaHJ5OUWXQhSYshGlFNvzP1TpP2FeROeb
YSX+KygQ7NlKk/LLQsU/f6IKcmlMVTO2M+gFe02zg3SiufZoJDPEmx9sqGAjE1gu
9MlGnfmzhg1wv2nFAsqol7OpYRmGiFWwItzkh+0gcGzM1Z0dofVRz+b7iJ/D1l8k
BmsnAqWMd6ePiTeyyZD1b2vwbIPLNYLDq0T3iL3ubP8H0tf1HkDXZCLW26RgabHJ
uNqpcRzG+kxblNPuDu8G3w7SfLPcOQ8YjLJhiKm9ADl7Wktqh+Lx/Z0EWJBwYi+2
gt31H+Otddbe7zUMgos8YlMmD1oumQ==
=gJLX
-----END PGP SIGNATURE-----

--g16doyZ3qKVdSFBl--

