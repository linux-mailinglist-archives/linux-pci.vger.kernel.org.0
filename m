Return-Path: <linux-pci+bounces-3766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8485BD30
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 14:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D76286DBB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C366A32D;
	Tue, 20 Feb 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCdvBwJ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A24482FA;
	Tue, 20 Feb 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435896; cv=none; b=rybErF8g4CkykPPfXF0iH8CweThjayXN+sU6YW2Yw70lgsFQ5C7dtthqawFMhRgEN8Nv5jnzx1uk7q7kPh1NZXKiQO1gpfCgeWldK8M73W7iIccsAKv92Z6qSpkAr5daSVw2FmOvjygLzIn9J9iCnu5sMA46EFryx6S2/8opk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435896; c=relaxed/simple;
	bh=Om4nwbIVaGL4qkTV+9XeVJq/OQVsY234eiAuH2YW+nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWy3iEk1/trh9YC4xQNo1I8REKCgcucBwh6oKz8LTJK/cYjauPsb0Yl9gCgEf9qmiD8+nVdjqy0R9FzgqaUYy9RVedF8tc/JomMAw2pCCUVnz18KU+dlkNOHg5vn9UQmTts0XuYm/+sU2d+tzRx/DUiHpgZ6vHkP1IUjBU47kR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCdvBwJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6216C433F1;
	Tue, 20 Feb 2024 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708435896;
	bh=Om4nwbIVaGL4qkTV+9XeVJq/OQVsY234eiAuH2YW+nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCdvBwJ5g4P6QCqmo1jWb+twkXRB9GwNdPKu+6MMASAH79965qHZD0Lb53JKBWrBo
	 AYAxQPNBQWSXDGupFhdKQ8xuMy7Tr0aisE2OiPHTyLXgSh6cYNkkEi8e9I2nxhrt+B
	 cG/FoxwOPcckd8n699VEJnUiCmBJtwEDyFiGv6AMhQuQsqhgWoMnpDfYIrb+BPFVkv
	 KUaoNRnP2s2EQIVLlRbkHTtMU/CO+jDpAkVOztMbQDCEsQdXqWtyuKORe1JTiVor4K
	 tYnDdmXiE6o3CKmABeogdmMXU9db4lIIl8r71H0YoZ1s+0bh5wKp+9QbjIkO0vy5Z7
	 Vxy1qGz+v569A==
Date: Tue, 20 Feb 2024 13:31:25 +0000
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
Message-ID: <5a3f5e1b-8162-4619-a10b-d4711afe533b@sirena.org.uk>
References: <20240216203215.40870-1-brgl@bgdev.pl>
 <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk>
 <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk>
 <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WgMc8yUhf91ALlog"
Content-Disposition: inline
In-Reply-To: <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
X-Cookie: E = MC ** 2 +- 3db


--WgMc8yUhf91ALlog
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:16:10PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> > On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote:

> > > No, the users don't request any regulators (or rather: software
> > > representations thereof) because - as per the cover letter - no
> > > regulators are created by the PMU driver. This is what is physically
> > > on the board - as the schematics and the datasheet define it. I took

> > The above makes no sense.  How can constraints be "what is physically on
> > the board", particularly variable constrants when there isn't even a
> > consumer?  What values are you taking from which documentation?

> The operating conditions for PMU outputs. I took them from a
> confidential datasheet. There's a table for input constraints and
> possible output values.

That sounds like you're just putting the maximum range of voltages that
the PMU can output in there.  This is a fundamental misunderstanding of
what the constraints are for, the constraints exist to specify what is
safe on a specific board which will in essentially all cases be much
more restricted.  The regulator driver should describe whatever the PMU
can support by itself, the constraints whatever is actually safe and
functional on the specific board.

> And what do you mean by there not being any consumers? The WLAN and BT
> *are* the consumers.

There are no drivers that bind to the regulators and vary the voltages
at runtime.

> > > the values from the docs verbatim. In C, we create a power sequencing
> > > provider which doesn't use the regulator framework at all.

> > For something that doesn't use the regulator framework at all what
> > appears to be a provider in patch 16 ("power: pwrseq: add a driver for
> > the QCA6390 PMU module") seems to have a lot of regualtor API calls?

> This driver is a power sequencing *provider* but also a regulator
> *consumer*. It gets regulators from the host and exposes a power
> sequencer to *its* consumers (WLAN and BT). On DT it exposes
> regulators (LDO outputs of the PMU) but we don't instantiate them in
> C.

Right, which sounds a lot like being a user of the regualtor framework.

--WgMc8yUhf91ALlog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXUqa0ACgkQJNaLcl1U
h9B24wf+Lz2wjf7I6W3InKvWNmGf3yUaGumEqSnMFkL3stpkvgqYLbA8ReYHbIUT
79XKO978Mxiz1EmV4P5JJlLodwosB8KwgRLoP9jJBJuUmza9tplD5bE7e7T0+aQy
HhywB2qi8aAR11BzU3hSdONfTa32ME+bcqKqAmRf3LORwIYvgdMDmqmuaqUToQfe
m/9kN5kWczPASPOUb7WfF+78lEvBZmRZZNQ+gaYiMgIkY8vrxWgQjeLASfIIMPwt
v72d6hMS/cdZEVFON8Lz7La1SJdqpFl4jjIiehjedX9tHoSddFDUbowQaUspH7zh
8LY9xVabmnUn+13LLE2JwgbELkPl+g==
=taRx
-----END PGP SIGNATURE-----

--WgMc8yUhf91ALlog--

