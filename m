Return-Path: <linux-pci+bounces-40661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 458A2C44AA0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 01:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C26E4E3CEB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 00:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1879CD;
	Mon, 10 Nov 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="p5coiec0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877D186A;
	Mon, 10 Nov 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762732914; cv=none; b=CDOMD9y0Yj1uIXxlGTHAGIyqBqCu/izKkbOW3wyafy9PKwAICmLGOPPa0V5eRbH85tPAHQX0Nv+YUvaFm07VC2CVUofPb59+tdedXEQMTX/8ewu2hlgZgA1mil0aSSSHqFkDzVV77+aoV0dPL43s21s+dcDpV8gvf0beb20ilmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762732914; c=relaxed/simple;
	bh=boEt92pvufryw9RvNZhERPjve8rb53gH4tnegmN2dms=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=sjEyOgknlo9fQaA/IK8pa7ZaYobgslfZrc6oS76WelVG3QNAHJDrYdVsrSmH21/7AkzGgZVlOofoSe8wke3cufxi7zzG6BPhKNb/EIUHQm2xg3U62+EgYdIQC1M6IUzhC682b+4XnMfexnRJFFGs1NFCxf9u0hGGSKARFQgqhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=p5coiec0; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id EE2FB40D4F;
	Mon, 10 Nov 2025 00:51:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1762732313; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bMO0Xh/gfO71OBjtqH4H2HrKhuVX7nihY7FUTST9A6w=;
	b=p5coiec0jIz8jGLRKlEkXQMVidbjTUU4AcOrE1Hlva3eIznRyivAHM/Cz6b/FlTFBBt9gH
	L9KfxFKgkJTKHYSj53KoRXOI/jYiYk6bHgOdMkSyrssd4v0bXWaSLI6bDGY2lcpPMozRpL
	idOl9E/QefRxTUENpUalR2pGrjggafIhF+lAddGXcvyXQ6MCDE9A91e2heWF4v8vtrzaU1
	fXKCrfXXLubUhuVb9OeRIKIFSP5RlryQNtJn1ltBav2OWQYRii31dD+HvHDXRKnwVruhBj
	mBldwgLd5X7OZbcaQZCpyAbXjL4+d8svf5L2SAY4ZaS1KQbP1bjve58T+0L1Ow==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <aQrKtFT0ldc70gKj@geday>
Content-Type: text/plain; charset="utf-8"
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
 <20251103181038.GA1814635@bhelgaas> <aQrKtFT0ldc70gKj@geday>
Date: Mon, 10 Nov 2025 00:51:49 +0100
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <17220ae9-9e0e-cb0b-63bd-eaf9a6ed6411@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [RFC PATCH 2/2] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-host=3A?= drop wait on PERST# toggle
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

On Wednesday, November 05, 2025 04:55 CET, Geraldo Nascimento <geraldog=
abriel@gmail.com> wrote:
> I did some more testing, intrigued by why would a delay of more than
> 5 ms after the enablement of the power rails trigger failure in
> initial link-training.
>=20
> Something in my intuition kept telling me this was PERST# related,
> and so I followed that rabbit-hole.
>=20
> It seems the following change will allow the SSD to work with the
> Rockchip-IP PCIe core without any other changes. So it is purely
> a DT change and we are able to keep the mandatory 100ms delay
> after driving PERST# low, as well as the always-on/boot-on
> properties of the 3v3 power regulator.
>=20
> This time everything is within the PCIe spec AFAICT, PERST# indeed
> is an Open Drain signal, and indeed it does requires pull-up resistor
> to maintain the drive after driving it high.
>=20
> I'm still testing the overall stability of this, let's hope for the
> best!
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/=
arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> index aa70776e898a..1c5afc0413bc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> @@ -383,13 +383,14 @@ &pcie=5Fphy {
>  };
> =20
>  &pcie0 {
> -	ep-gpios =3D <&gpio0 RK=5FPB4 GPIO=5FACTIVE=5FHIGH>;
> +	ep-gpios =3D <&gpio0 RK=5FPB4 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5F=
DRAIN)>;
>  	num-lanes =3D <4>;
> -	pinctrl-0 =3D <&pcie=5Fclkreqnb=5Fcpm>;
> +	pinctrl-0 =3D <&pcie=5Fclkreqnb=5Fcpm>, <&pcie=5Fperst>;
>  	pinctrl-names =3D "default";
>  	vpcie0v9-supply =3D <&vcca=5F0v9>;	/* VCC=5F0V9=5FS0 */
>  	vpcie1v8-supply =3D <&vcca=5F1v8>;	/* VCC=5F1V8=5FS0 */
>  	vpcie3v3-supply =3D <&vcc3v3=5Fpcie>;
> +	max-link-speed =3D <2>;

FWIW, we shouldn't be enabling PCIe Gen2 here, because it's been
already disabled for the RK3399 due to unknown errata in the commit
712fa1777207 ("arm64: dts: rockchip: add max-link-speed for rk3399",
2016-12-16).  It's perfectly reasonable to assume the same for the
RK3399Pro, which is basically RK3399 packaged together with RK1808,
AFAIK with no on-package interconnects.

>  	status =3D "okay";
>  };
> =20
> @@ -408,6 +409,10 @@ pcie {
>  		pcie=5Fpwr: pcie-pwr {
>  			rockchip,pins =3D <4 RK=5FPD4 RK=5FFUNC=5FGPIO &pcfg=5Fpull=5Fup>=
;
>  		};
> +		pcie=5Fperst: pcie-perst {
> +			rockchip,pins =3D <0 RK=5FPB4 RK=5FFUNC=5FGPIO &pcfg=5Fpull=5Fup>=
;
> +		};
> +
>  	};
> =20
>  	pmic {


