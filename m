Return-Path: <linux-pci+bounces-40325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F94C34B57
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A3F3A251B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013F2F90EA;
	Wed,  5 Nov 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="aQkDEf0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2679296BA9
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333633; cv=none; b=bDbgKkTJ9BuJVThbQVV7wml+XyowcX9ZqQplO03fcjFXGiAvv8g+VMVPzjafZZ+q6/bGihMnPOGnk7VcXGcOsdopMKHUPPV5jw7+KIIlW5QL1dSWH5RYhC6vRU1gsX8BHHH/TPUDr9qBc76Ig22Z9pO154LcsjCdWXTBsLncQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333633; c=relaxed/simple;
	bh=p+xlPEEIT60PvRFxaXDOjwppSGNh4m6IA68mgt+Ffd4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e7nkKwX0okpKqwAuhjzrBrukJnXsTDwfI0uIfjmDMj2s2SRwZ/3Js/mxH7EJpXZ9HUZfEkdGDP6b82ot8qEaQG2yGO4u+yHlIVXUlRYK5b1eSlbqdCM9eX7qwJmU9Qio4Pr6U9QtBJvK24vuK30+E/jCKSIYYTCjM0zpsKOpbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=aQkDEf0o; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762333619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20X0FggjNIZtK2wTcA0T98MzwYS7d/pU6xJcudRoIkA=;
	b=aQkDEf0o1hZDlA0jt/SAK7d1jIzuk83Wctvw7Khhjx221G75fVkjY6y1QChQga2p0H/gx7
	jb80JscYaEXymno4WJMr7sszvCliTv/kGLD5aPpkUxXzuRqF+LkkqfxPFih1rr28zE2J5F
	Nj4j+BNbr3lDj3fzWXfFiSEnTYem1pnhUR9c9vbgezDW3NOmMRyx8jOQBlK+rwIJRQ5dn4
	cPCszNjP4TFptEs6ceoB1Ye5Vpg52GLT54a2vP6c7ydi7ZQ3/JmqQEDGRhGO6hyULD+3U+
	nFWJc2Q+h1lvn//Uu3Vn7Ypoy5RnrjIoRappU70Tf1Txx5KyWKhpEUk1DdPkTw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 10:06:53 +0100
Message-Id: <DE0N4LA8MOJD.236O12UZ3I3C4@cknow-tech.com>
Cc: <linux-rockchip@lists.infradead.org>, "Shawn Lin"
 <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>,
 <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Johan Jonker" <jbx6244@gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>, "Bjorn Helgaas"
 <helgaas@kernel.org>
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com> <20251103181038.GA1814635@bhelgaas> <aQrKtFT0ldc70gKj@geday>
In-Reply-To: <aQrKtFT0ldc70gKj@geday>
X-Migadu-Flow: FLOW_OUT

On Wed Nov 5, 2025 at 4:55 AM CET, Geraldo Nascimento wrote:
> On Mon, Nov 03, 2025 at 12:10:38PM -0600, Bjorn Helgaas wrote:
>> On Mon, Nov 03, 2025 at 03:27:25AM -0300, Geraldo Nascimento wrote:
>> > With this change PCIe will complete link-training with a known quirky
>> > device - Samsung OEM PM981a SSD. This is completely against the PCIe
>
> Something in my intuition kept telling me this was PERST# related,
> and so I followed that rabbit-hole.
>
> It seems the following change will allow the SSD to work with the
> Rockchip-IP PCIe core without any other changes. So it is purely
> a DT change and we are able to keep the mandatory 100ms delay
> after driving PERST# low, as well as the always-on/boot-on
> properties of the 3v3 power regulator.
>
> This time everything is within the PCIe spec AFAICT, PERST# indeed
> is an Open Drain signal, and indeed it does requires pull-up resistor
> to maintain the drive after driving it high.
>
> I'm still testing the overall stability of this, let's hope for the
> best!

I have a Samsung PM981 (without the 'a') and AFAICT it works fine.
I had noticed that the PERST# (pinctrl) was missing, but 'ep-gpios'
was/is new to me and I hadn't had time to research that properly yet.
Good to see you already found it yourself :-)

Cheers,
  Diederik

> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch=
/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> index aa70776e898a..1c5afc0413bc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> @@ -383,13 +383,14 @@ &pcie_phy {
>  };
> =20
>  &pcie0 {
> -	ep-gpios =3D <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	ep-gpios =3D <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	num-lanes =3D <4>;
> -	pinctrl-0 =3D <&pcie_clkreqnb_cpm>;
> +	pinctrl-0 =3D <&pcie_clkreqnb_cpm>, <&pcie_perst>;
>  	pinctrl-names =3D "default";
>  	vpcie0v9-supply =3D <&vcca_0v9>;	/* VCC_0V9_S0 */
>  	vpcie1v8-supply =3D <&vcca_1v8>;	/* VCC_1V8_S0 */
>  	vpcie3v3-supply =3D <&vcc3v3_pcie>;
> +	max-link-speed =3D <2>;
>  	status =3D "okay";
>  };
> =20
> @@ -408,6 +409,10 @@ pcie {
>  		pcie_pwr: pcie-pwr {
>  			rockchip,pins =3D <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
>  		};
> +		pcie_perst: pcie-perst {
> +			rockchip,pins =3D <0 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
>  	};
> =20
>  	pmic {
>

