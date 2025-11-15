Return-Path: <linux-pci+bounces-41299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB9FC6030B
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79549357D30
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2132877CF;
	Sat, 15 Nov 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="te3MMx4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99B199FBA;
	Sat, 15 Nov 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763201005; cv=none; b=CZ5nmM2dpakdxMvu52nSAURqgELCzpwGtkLKCguAGd6Rx0INHzKTYZ6PyXjZ65cRrgPr87iRbWqn9wDZjk8ftNK9STC+NtJ0R69WOcVnh43m9AkVWPxsyEnL55vWMj+nJDHaXLmtG2QmEbHv4fusMIwDRVeTp+y4TmLWsqhImxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763201005; c=relaxed/simple;
	bh=jSzIH+aBLEEmskur2MSBYXf6MBwSuj5ITfquT2DcuUM=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=WfIq9Lu66WkGWux48QxnufHZoatSHAAvF1wy+hJ7eFlr8FJ6ftJGiYrwyW2ECsNXqiCs6Ja8VKRycZE+rh1pneyyVDrlNrE4Z+cfYpDY7saln8YBF/0YtB6BJv0ygtu+zjz1hiM9oaw8JC7hXCoc6FIxlk95Y30naZQALqEKHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=te3MMx4t; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 8DC29410BE;
	Sat, 15 Nov 2025 11:03:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763201000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OhDLdVDlCvXeDp/tg/EoSLGGgeXipYMI7B6maDjTSSE=;
	b=te3MMx4tA4VoWA6jAGFbPK5AuHoMITcFgQi18NVYV1IEKbLCgcMSqZIle7VKGoL1OZJwKu
	13qV+OKJeqiyZ3ywB026KMmTLmslaTGw35KrC+5zh4Y94tZYdRb9VXXLE4bdgar5wMB3uV
	fwOdaWfvzl1RUqXGIZxvxFh8CVkSSeD3gLQYhWJ1szHmDO1SUUQukEOSud9tmyg5umiSL5
	RjoXV2VUajjJrsVZ6dOZmE+0vMsSMoNPaxtHORubjCPlPqlbU5LN0wyDKg2/DSgIF831l1
	ea8LOvh8kReW1Lgxo/117H+F7aWmnOdnY4nq2VhU1QbIw0iM95g1vx7+MI6qaQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <aRhOK_aDoJYfgbRJ@geday>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <53332edec449b84d8a962f2b5995667766359772.1763197368.git.geraldogabriel@gmail.com>
 <3f13841d-030b-0202-61be-412c0ab9df6b@manjaro.org>
 <7d300769-9803-9c0c-60bb-4a724619d8e0@manjaro.org> <aRhOK_aDoJYfgbRJ@geday>
Date: Sat, 15 Nov 2025 11:03:19 +0100
Cc: linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a99f926c-e65f-8d0d-67bf-0dd4f9211970@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 3/3] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= drop max-link-speed =?utf-8?q?=3D?= <2> in 
 helios64 PCIe
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Rspamd-Fuzzy: 79fd1ee6b46a4d5bc75ee1800a866e5c0cabd930fd8d0f33d70452539bd7c99d792844c6f78cc1edc19ec7c0b159150d703bb5216ec666c196796747076035b9

On Saturday, November 15, 2025 10:55 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> On Sat, Nov 15, 2025 at 10:42:40AM +0100, Dragan Simic wrote:
> > On Saturday, November 15, 2025 10:36 CET, "Dragan Simic" <dsimic@ma=
njaro.org> wrote:
> > > On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <ger=
aldogabriel@gmail.com> wrote:
> > > > Shawn Lin from Rockchip strongly discourages attempts to use th=
eir
> > > > RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catas=
trophic
> > > > failures that may happen. Even if the odds are low, drop from l=
ast user
> > > > of this property for the RK3399 platform, helios64.
> > > >=20
> > > > Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for p=
cie completion to helios64")
> > > > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b8896=
8b4c21b@rock-chips.com/
> > > > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64=
.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > > > index e7d4a2f9a95e..78a7775c3b22 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > > > @@ -424,7 +424,6 @@ &pcie=5Fphy {
> > > > =20
> > > >  &pcie0 {
> > > >  	ep-gpios =3D <&gpio2 RK=5FPD4 GPIO=5FACTIVE=5FHIGH>;
> > > > -	max-link-speed =3D <2>;
> > > >  	num-lanes =3D <2>;
> > > >  	pinctrl-names =3D "default";
> > > >  	status =3D "okay";
> > >=20
> > > Looking good to me, this rounds up the prevention of issues
> > > coming from buggy PCIe Gen2 on RK3399.
> > >=20
> > > Please feel free to include
> > >=20
> > > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > >=20
> > > Though, could you, please, add patch 4/3 to this series, which
> > > would remove the redundant parameter "max-link-speed =3D <1>" fro=
m
> > > rk3399-nanopi-r4s.dtsi?
> >=20
> > Sorry, I forgot to note that the patch summary would read a bit
> > better if it were reworded like this:
> >=20
> >   arm64: dts: rockchip: Remove redundant max-link-speed from helios=
64 board dts
>=20
> No, I think:
>=20
> arm64: dts: rockchip: Remove dangerous max-link-speed from helios64 b=
oard dts
>=20
> Is more accurately described. With focus on the dangerous, we're not
> liable.
>=20
> Redudant max-link-speed only for nanopi-r4s include definitions I thi=
nk!

Indeed, you're right.  It was obviously an -ENOCOFFEE on my part. :)


