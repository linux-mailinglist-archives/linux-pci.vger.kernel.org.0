Return-Path: <linux-pci+bounces-40572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF401C3F6E0
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 11:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A7B4EF628
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB945305E09;
	Fri,  7 Nov 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="LTXY4niJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76E3054F7
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511285; cv=none; b=PioTgU/stRGCS1fhHy4gXmP1B9NZZ1Ido07yHbhwwEtEbkeE0IicBkX1sS5cEEKiSmrdT+wHL21FkKaRaRI6isb3iH74UUk571f24I6SXnWMG6AwRzA0Akt45S1Bzr5uZ+lyZ15z/axstUzZ8dnRKNy+OhhYG4C22qM2Xh2/1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511285; c=relaxed/simple;
	bh=TP2dy+fVEjwce+7ZoFimG80olGzbpEy03H4vsRCTukg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mk+QABN/kjdPrn26ncotxFftb+wjWAkIt59KUKyzzPbZKF6hhf3ZlU/L6YUPHl7pHACk9EcjMeFTLO2a08DBl5Zn/IkriBssc1OWl/BKCn0VRPvdl9OmGIGkKfFyIOfIUffugXdQj4E+8B6F7iyJlPP0z6qKIGIJsWO+4317S7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=LTXY4niJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762511271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXxxLdb7XheOy75RFTu6qpzQ1CR6/qzHUiLBzTJbIfo=;
	b=LTXY4niJ2Q4v9blFZDDIDMhmT6YuANss37XVrUPjaWkBRYbGPvukGIrKWMjfMtjCz9X4y2
	D0icX131qTv+kScD53gosbMyEh9nKGD7IdwIhnbkx9kmiVcrc3fXJVV8w0StZO3YlSuV6u
	N0fDkWwwzBQPhuNam3hUStygGtLEykiDTBETx/DGwquha8F2AIUK55iJQQjrfXkvH8ri19
	JWvm9c3kuu8nOS8c0V9jSfOMNKS9NziiYCuireCSED3VE6TV87pkiPaoZ/tU7QArHk1qe1
	UkRkKnx8n4UE05b8wzlOpUbvsSK+LAJmaMEErMTaPXGlZ7HCyBphXEv2Ab2MQw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Nov 2025 11:27:45 +0100
Message-Id: <DE2E3LND1O81.25N3JM01890FT@cknow-tech.com>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>,
 <linux-rockchip@lists.infradead.org>, "Shawn Lin"
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
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com> <20251103181038.GA1814635@bhelgaas> <aQrKtFT0ldc70gKj@geday> <DE0N4LA8MOJD.236O12UZ3I3C4@cknow-tech.com> <aQu_-JDy7qqeviUm@geday>
In-Reply-To: <aQu_-JDy7qqeviUm@geday>
X-Migadu-Flow: FLOW_OUT

Hi Geraldo,

On Wed Nov 5, 2025 at 10:22 PM CET, Geraldo Nascimento wrote:
> On Wed, Nov 05, 2025 at 10:06:53AM +0100, Diederik de Haas wrote:
>> I have a Samsung PM981 (without the 'a') and AFAICT it works fine.
>> I had noticed that the PERST# (pinctrl) was missing, but 'ep-gpios'
>> was/is new to me and I hadn't had time to research that properly yet.
>> Good to see you already found it yourself :-)
>
> Would you mind testing the following DT change to make sure your PM981
> continues to work fine?

I just learned the the PCIe system on rk3399 is indeed different from
the systems where I use it with (rk3568 & rk3588). And 'ep-gpios' is
only used with rk3399 based devices (in the Rockchip dts tree), which
explains why I hadn't seen that before.
Which in turn means I can't test your proposed change.

I guess I was triggered by RFC patch 2 which said 'a known quirky
device' while my Samsung PM981's are working fine ... but with DW based
IP. You did specify in your cover letter the connection with Rockchip
PCI IP, which apparently can make a (lot of?) difference.
Me finding the PERST# pinctrl in a few minutes and we finding
improvements in RockPro64's PCI 'config' recently, indicated to me that
a new look into the dts definition may be warranted, before changing
``drivers/pci/controller/pcie-rockchip-host.c`` for everyone.

Cheers,
  Diederik

> Thank you,
> Geraldo Nascimento
>
> ---
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch=
/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> index aa70776e898a..b3d19dce539f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> @@ -383,7 +383,7 @@ &pcie_phy {
>  };
> =20
>  &pcie0 {
> -	ep-gpios =3D <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	ep-gpios =3D <&gpio0 RK_PB4 (GPIO_ACTIVE_HIGH | GPIO_SINGLE_ENDED)>;
>  	num-lanes =3D <4>;
>  	pinctrl-0 =3D <&pcie_clkreqnb_cpm>;
>  	pinctrl-names =3D "default";


