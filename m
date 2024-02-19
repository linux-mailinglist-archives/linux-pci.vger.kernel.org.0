Return-Path: <linux-pci+bounces-3738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37685AA59
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 18:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B9B1C21879
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4EA4594E;
	Mon, 19 Feb 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byeh1ywY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B93B19D;
	Mon, 19 Feb 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365004; cv=none; b=UY9v+yJgbQsnWavknczJLWcznEGgtRq466TYc3v6oEwEZsamV1FvzfqGPqcm4m9M0qoYA36ASvHSAhiuGa3Z7idiEP0CoQyUbye/gOiBDtlHaF2SV6Li1lwLv4TCH2dZHI1gAmqDPZoSOT+kNp77GQ0m9b+/u8mP8Z8WVRIOpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365004; c=relaxed/simple;
	bh=UvHxv7xepbJxpy9+6O5z19tRjX3zU46AaArjEk6oaqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGbTluVABLEiApUe4MqhCDiRDDovHh5xX/VNgsZ+FSMBUFZak6+/dwikHDg3DFUhgChCIhxREiINKN9Z1lWP6ncTqj00qIwujHmu18qt99/eRkMZMO/pBDvmagN5nWim/0mi6YqLgLmrO2JFGHpCgsf9JudlfPeHxUSIBSfNSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byeh1ywY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B81C433F1;
	Mon, 19 Feb 2024 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708365003;
	bh=UvHxv7xepbJxpy9+6O5z19tRjX3zU46AaArjEk6oaqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Byeh1ywYb7LFUazgOuI5zH2TrdYxfCCsIPl7883Pp0qneK0V0Dq876TSb8vfaWBKf
	 Z7v8XNYcJBDe0fgC7/GWxKowMHWwuFXKus6EYvnQZSt6rwFgJqUlV8yECROn4uRrYE
	 ap7565fNBc4aIg7mGSG8vM64fUH8OXpfLE/qDxO07PLLbo17ctl+PoR/RRZ6J8QxJt
	 KwHMaimwy35Nyc5s6Qj5l1J51qR/jEKojuKbYgKHKj0P8XfJL8ZkFS7KI1ZKMlafV3
	 DGk5xTgJAdS3/ssEih8TDlfWENpTEnxKoNDV9AcnOakdQlC4bXnZ7wU1ojeu3m9dgn
	 kSaNB8meAZvvw==
Date: Mon, 19 Feb 2024 17:49:53 +0000
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
Message-ID: <d5d603dc-ec66-4e21-aa41-3b25557f1fb7@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-15-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zhaxDJmWzXDQsJtR"
Content-Disposition: inline
In-Reply-To: <20240216203215.40870-15-brgl@bgdev.pl>
X-Cookie: Kleeneness is next to Godelness.


--zhaxDJmWzXDQsJtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2024 at 09:32:11PM +0100, Bartosz Golaszewski wrote:

> +static struct pci_pwrctl_wcn7850_vreg pci_pwrctl_wcn7850_vregs[] = {
> +	{
> +		.name = "vdd",
> +		.load_uA = 16000,
> +	},

I know a bunch of the QC stuff includes these load numbers but are they
actually doing anything constructive?  It keeps coming up that they're
causing a bunch of work and it's not clear that they have any great
effect on modern systems.

> +static int pci_pwrctl_wcn7850_power_on(struct pci_pwrctl_wcn7850_ctx *ctx)
> +{
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(ctx->clk);
> +	if (ret)
> +		return ret;

This won't disable the regulators on error.

--zhaxDJmWzXDQsJtR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXTlMAACgkQJNaLcl1U
h9CbcAf/TbzIjHqTiQO+FHev6hCBpVYxHMM5DOvWBX9ZL+ZhfvUuEcLsSRXWlokW
HhtoUNnGZDtqJVvKNBZcDL0ltgO81LrS+YQNT/z252knsVjqxFknViXPRqK7rN8Z
16HIEb5HegfAIZRRoBnR/G8nSdn78grXMJU42wUOAI7yaMfDFq4073C3oK8BvIAE
VVWmJKdPIK8vwfyS9ugKW3ncdjLg7zjxlmmK8BfpIUZDrsv/mCeDOWQFgOqmoL2u
xoyg8EmT9wL6lEWBxAkWxtljU4T2rZvFSxBT9uZW3M0xy83QF/G59Thp+ggKTkls
f+7PMN+ly3LgO93wRdhXNTSBN6vI6w==
=wO5a
-----END PGP SIGNATURE-----

--zhaxDJmWzXDQsJtR--

