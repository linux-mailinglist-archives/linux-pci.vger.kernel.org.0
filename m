Return-Path: <linux-pci+bounces-3739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304285AA84
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 19:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BECDB2172B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315E747A61;
	Mon, 19 Feb 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfqY9KQ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4543BB38;
	Mon, 19 Feb 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365797; cv=none; b=OkkR24XqeowG8mZTYEsDwV5YrIo4CvruhQ1f7RJ3XHQ9bTknx6q67cg2xKV4B6YX0wjK1FlvLJ5jQIItDa0EaFA5MfjaJJMAUhCRd6B2c/+rl6s+fC/qdwXV67x84H3/IAtFPl5MNqJLTMfdMQftwIHuB9t4aL7glst0VpOPEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365797; c=relaxed/simple;
	bh=fN+7T2/ux9us6GFbiDO1by9SUDxjo7ndhirheQxhNXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bepM8ERrso06Ez8EGnkVmhsOiCF3QnebYpn6K4GKvFiTFmIgV7ZIjNqkrJDhbWBu3YdWbM6kDz9Gs8pFBZzZdvmDMboTUbj9JbQCx+m4gsfj6Aal8f2pfcRwxjk+LqjbnZZaEqBJB2CAw5hkgpEYaVNgldl9kWD2yL8nU8r6jng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfqY9KQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C34AC433C7;
	Mon, 19 Feb 2024 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708365796;
	bh=fN+7T2/ux9us6GFbiDO1by9SUDxjo7ndhirheQxhNXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfqY9KQ2bRFKYwmsH0uzlhQyYe3wi0lQtfF7J8Or2LPWCBwIxdtqUsol0P/TlsPNu
	 f1BUTTd8v03NxJR9Z0g7YY2jn/DzGiBkgj+7joJ6q0wQtM6sPhewKU/xHuu6GCZQ5p
	 rWMW75ggpoPmQYwiqKmNBEC/RAyW+ATsoH4mYNfSDWRVO257rLekRm9FP+wh+Lr01m
	 +9uQfeHQK7NEMIUsbHpl36G6qlB/KqsksKYBm7o8VDBvj9+I6LpLyMFPbXdCoV06v0
	 MSXnA/g8Yq91VWXrESrD1xa+CDhVggBP5/3ZKsVL1zs/FWwOqOL/YAHcB0w11B4cCO
	 p6B0OBYRWtBFA==
Date: Mon, 19 Feb 2024 18:03:03 +0000
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
Message-ID: <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-10-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Ec75K1sOfBNW6oj"
Content-Disposition: inline
In-Reply-To: <20240216203215.40870-10-brgl@bgdev.pl>
X-Cookie: Kleeneness is next to Godelness.


--6Ec75K1sOfBNW6oj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wrote:

> +			vreg_pmu_aon_0p59: ldo1 {
> +				regulator-name = "vreg_pmu_aon_0p59";
> +				regulator-min-microvolt = <540000>;
> +				regulator-max-microvolt = <840000>;
> +			};

That's a *very* wide voltage range for a supply that's got a name ending
in _0_p59 which sounds a lot like it should be fixed at 0.59V.
Similarly for a bunch of the other supplies, and I'm not seeing any
evidence that the consumers do any voltage changes here?  There doesn't
appear to be any logic here, I'm not convinced these are validated or
safe constraints.

--6Ec75K1sOfBNW6oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXTl9YACgkQJNaLcl1U
h9AVgQf/Zstl1AGU01IOsCVbEoRgtQnUVnvdCJmcKksR0WQRA9Ez7ZgGXt2kYGCV
fJfjGIuSto9RcICB8ifx7MrgId9TmPvp9N9Duh87hY01bzM7kmk/pXX7HMBJlU4T
c6IC7feW5hVtwO7i+xWu4xEjmtGtBPcyhkNuN5x/niH5MHtFqqsBsd7GKz36dJL0
Ow7999ejPBXXTJSWrIUHN2SQyPmr/06rondsVSlNct8OVA/sjIjPtv7z/642ETwR
QgVxlgM46BBusYa9IzPbpnE60VsWiecTGBALHtpwtM83iSdQhNnoNJf1l1khPwsp
za6sxl3vD4FWj+gFYkh1oMTuE/Jp1g==
=WZdq
-----END PGP SIGNATURE-----

--6Ec75K1sOfBNW6oj--

