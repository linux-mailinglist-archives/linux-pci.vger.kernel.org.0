Return-Path: <linux-pci+bounces-41292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B31C60279
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993E43B969A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8099526CE32;
	Sat, 15 Nov 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tBZqzkYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F01E47A5;
	Sat, 15 Nov 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763199384; cv=none; b=l+L14tL2O3xcxlj9SEKHaQ5ofgv6s2Uz4UvQXPpIxZAul6Y/Lt428oUrhft7BvqSbXhzXjhsv0MGbASwmfmqsrVvJHrqCn63uR0nJA+ssWJ/pF4PmZX8yHJSxLfjF4sL8EqzLGuvm3L/8qeVh+BOYTemUq3y2x8tIrFxUYRHGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763199384; c=relaxed/simple;
	bh=k3qx4a9OUlr3S+1zaknt+FdkIq5OJZEIWut+tK6sG+I=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=X0Qs464DrybySc5oXJAiYIaQCmIp7ly3WXYpCXQLdx32m+8EmSA0RKcOtIK1Km628QRtR+BP7eEdeB9NUkXI+6zDxi/T/guI8BDsLXj2YyhPmgkhGqmFAKanLpNWWRhAvTeK5UbzYiN3Gzk5BkxoKDUqIQ+DJYaxMfAbYCJmGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tBZqzkYu; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 3E22A40CFC;
	Sat, 15 Nov 2025 10:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763199380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UzICdbwM2QoJFmjW7cfRmbb0BC19M1jM3pFg7zouo8c=;
	b=tBZqzkYu0lbdplajSnwSL2r48T/TPSQZF2qdPmJABx0UTAtkqH7vedj4hECQ54IztXtivd
	eYkLF/qcNHRlSEIVapRn14EwaO9eiLzGcybRdYrYtYLu4VPH3adezVlGhdg6/ssDRzw3U6
	vNodMnb6kXXvuN1AAaqz4L5KrJ/3xbE6Y7wl1OrmQArI0tea9aFB4xzhICw0/KdkXUO7ej
	Kb6DuIkFvqtLwgufG6k7q864+albj31iJSoxS96q/O1VWtT02TxqG/zY5JB9ATmNzS/XnQ
	n6APHB2pRTg9VTr/ZXueaTntLzACQ6iw3Y94owyefLKaYTM2xLwh5kHzzUBEIA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <53332edec449b84d8a962f2b5995667766359772.1763197368.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com> <53332edec449b84d8a962f2b5995667766359772.1763197368.git.geraldogabriel@gmail.com>
Date: Sat, 15 Nov 2025 10:36:17 +0100
Cc: linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3f13841d-030b-0202-61be-412c0ab9df6b@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 3/3] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= drop max-link-speed =?utf-8?q?=3D?= <2> in 
 helios64 PCIe
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> Shawn Lin from Rockchip strongly discourages attempts to use their
> RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catastrophi=
c
> failures that may happen. Even if the odds are low, drop from last us=
er
> of this property for the RK3399 platform, helios64.
>=20
> Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for pcie co=
mpletion to helios64")
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21=
b@rock-chips.com/
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b=
/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> index e7d4a2f9a95e..78a7775c3b22 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> @@ -424,7 +424,6 @@ &pcie=5Fphy {
> =20
>  &pcie0 {
>  	ep-gpios =3D <&gpio2 RK=5FPD4 GPIO=5FACTIVE=5FHIGH>;
> -	max-link-speed =3D <2>;
>  	num-lanes =3D <2>;
>  	pinctrl-names =3D "default";
>  	status =3D "okay";

Looking good to me, this rounds up the prevention of issues
coming from buggy PCIe Gen2 on RK3399.

Please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Though, could you, please, add patch 4/3 to this series, which
would remove the redundant parameter "max-link-speed =3D <1>" from
rk3399-nanopi-r4s.dtsi?


