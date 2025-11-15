Return-Path: <linux-pci+bounces-41293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF7C60291
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85B5B34F1FF
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB123A99E;
	Sat, 15 Nov 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KEPIayOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33A238176;
	Sat, 15 Nov 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763199766; cv=none; b=leYy7YTAm/wnD4+jX8ks+a8ZcEB0vKa4Z6OfBkFfagZDvFCzOGPXdwiFmA6Ig8DnkwcDyAVJmLp4bXsBt4lWsnvGnIcJxegPe2zzXYpzAI/9AGlYDhf2e2XUYa2l0+0ouP+FwvpaeXUPo5KfxDREvYwiA6ElO5oOs2SfZV4eEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763199766; c=relaxed/simple;
	bh=vo3c+pkoeeFE2QuRBRYBVPd28ngx/oScFWX7HJm6FCE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=nF82+WbpGjWlgsl6kU+wofkvWy0tgU5LEIieGqsWOmZJVajw3D3Ql8SQXYiJ1KxtWe1aw/ppCBesayVM+9vPqEJa2alHl8aQJvjGpDZsehWiQXuXSO3sdcntYP2KTzp5l0Lg04vvtTwOPLIYYC+H96EQvJMWObduUWjcJZ4gMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KEPIayOC; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 62E6640F84;
	Sat, 15 Nov 2025 10:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763199762; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FBn2uCQLq/EGJJqCPd52OCAnYeNta9e163MwUwrIP1Q=;
	b=KEPIayOCDkJaICHXVtBk/6q2ymZba6rbil4oa1+z35iVZ4sPbdVBsDcSroCOAEmQw2EqzS
	vw7J36AtQ+hxgnmyjyQBsSgg3OOPN81KV/TvIuVwaT9b10pTdoM31/gH+KAGwTvOBWKI97
	/+ivnot5bOrYS6KpYyV+toQ6sOkb3Ztt6NWfLxSu2d4S5oCoLwVe4l577dfFqSOQ9RQUgj
	b/9fwDXztOG9RDqq0ZYDB3NfGJlRcM+7kqaSh7+KWOkCPLRWSv4tPVbp9JSnSqvc2/TXW9
	xGZ6p3zmLFvmOWJbPT2fCwqfUY/xZwMfgrv06H9u0It+nAIMR0ndygAy2fPonA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <3f13841d-030b-0202-61be-412c0ab9df6b@manjaro.org>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com> <53332edec449b84d8a962f2b5995667766359772.1763197368.git.geraldogabriel@gmail.com> <3f13841d-030b-0202-61be-412c0ab9df6b@manjaro.org>
Date: Sat, 15 Nov 2025 10:42:40 +0100
Cc: "Geraldo Nascimento" <geraldogabriel@gmail.com>, linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Dragan Simic" <dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7d300769-9803-9c0c-60bb-4a724619d8e0@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 3/3] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= drop max-link-speed =?utf-8?q?=3D?= <2> in 
 helios64 PCIe
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Rspamd-Fuzzy: 79fd1ee6b46a4d5bc75ee1800a866e5c0cabd930fd8d0f33d70452539bd7c99d792844c6f78cc1edc19ec7c0b159150d703bb5216ec666c196796747076035b9

On Saturday, November 15, 2025 10:36 CET, "Dragan Simic" <dsimic@manjar=
o.org> wrote:
> On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geraldo=
gabriel@gmail.com> wrote:
> > Shawn Lin from Rockchip strongly discourages attempts to use their
> > RK3399 PCIe core at 5.0 GT/s speed, citing concerns about catastrop=
hic
> > failures that may happen. Even if the odds are low, drop from last =
user
> > of this property for the RK3399 platform, helios64.
> >=20
> > Fixes: 755fff528b1b ("arm64: dts: rockchip: add variables for pcie =
completion to helios64")
> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c=
21b@rock-chips.com/
> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts=
 b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > index e7d4a2f9a95e..78a7775c3b22 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> > @@ -424,7 +424,6 @@ &pcie=5Fphy {
> > =20
> >  &pcie0 {
> >  	ep-gpios =3D <&gpio2 RK=5FPD4 GPIO=5FACTIVE=5FHIGH>;
> > -	max-link-speed =3D <2>;
> >  	num-lanes =3D <2>;
> >  	pinctrl-names =3D "default";
> >  	status =3D "okay";
>=20
> Looking good to me, this rounds up the prevention of issues
> coming from buggy PCIe Gen2 on RK3399.
>=20
> Please feel free to include
>=20
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
>=20
> Though, could you, please, add patch 4/3 to this series, which
> would remove the redundant parameter "max-link-speed =3D <1>" from
> rk3399-nanopi-r4s.dtsi?

Sorry, I forgot to note that the patch summary would read a bit
better if it were reworded like this:

  arm64: dts: rockchip: Remove redundant max-link-speed from helios64 b=
oard dts


