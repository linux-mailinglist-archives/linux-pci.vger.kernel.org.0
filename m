Return-Path: <linux-pci+bounces-41298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24FC602FB
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 595873500B3
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94769274B3A;
	Sat, 15 Nov 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hegVytWf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DAE219E8D;
	Sat, 15 Nov 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763200888; cv=none; b=Irm4CACWT/tIr+1VUTPPOFzXcPfQpA8sVwdGhsZtGLfp9QxtTE/QpZTDWUQSCQWv5np85NFYVUIUySucn+zQ+So9SxZwXzaTFISovjapQnnRFuB2d9jvZEUwsb/8gF4WDCZ2ebhXCvT3yPSST4dN8yCVkFm1jOkE2/Zoj3WGALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763200888; c=relaxed/simple;
	bh=HpAHnMhc8Vo2IprEXsmiQzzvRuicic5L/MkbfXbUEkg=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=bBxZ3wVaAsl0INy+g9dqQVM2hbTdJW1byuOev9uTqkUAphbCvgP92CK8448v/TUzaBuzkMJKQMhmchXV+EQliC26yOB1FubJRziDaeFqw6MaCabQmAdFQvnFAM9FgSKNGE1/YVTUANCWy7WeMxa5VXDeskPD/JX4R9UcqWR9jS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hegVytWf; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id EE6F040FDD;
	Sat, 15 Nov 2025 11:01:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763200883; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z8ENjA1O7KsiohjnVwrpnU2+8wRrzBEXFU0FKDVm6Vs=;
	b=hegVytWfQX3nP/0CyzpqP7bgtbxhgrhc/nnXYmahru2+e65IfcdZ7lDUJ/Dpn6KnIVYtQC
	z1BZ3sf5qmY/ipJEFBiYcE0WO89reg2fyGeg+4vIjUa4krObEcZg5cnQZtIxVujq1oEwlB
	4LqCbXm0lE1Jugf4jhRCpxNcUJpcFDENBBduvKJSbfb3HrAseumPP/4mlByaqRGvXisxMH
	Vf73esieTh727fByzOtgII2VdPFPvBZ9buAeqA4IesUx+wfisGQBcaaqnTbPw2wWgk4ixG
	RkOTWnoPNa61s3p8uERWKgliME7y/PRPc/n5Nkmy1S0vnhXYz2yl5HPF1uyJAQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <aRhNIcGcQKp2ylqN@geday>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
 <c8a6d165-2cdd-cd0d-4bed-95dfa5ff30d2@manjaro.org> <aRhNIcGcQKp2ylqN@geday>
Date: Sat, 15 Nov 2025 11:01:21 +0100
Cc: linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <85d1543b-ea91-5f0f-59d6-e00fcf720938@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 2/3] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-host=3A?= comment danger of =?utf-8?q?5=2E0?= GT/s 
 speed
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
X-Rspamd-Fuzzy: 83c865715b7113a59b93546ee6a88838d4bbcab70d4a53f23333084f29fd2604053233ae0ec2379f12cfaacb3af815deb6e782a9b018734885047e902d4f57c0

On Saturday, November 15, 2025 10:51 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> On Sat, Nov 15, 2025 at 10:30:49AM +0100, Dragan Simic wrote:
> > On Saturday, November 15, 2025 10:10 CET, Geraldo Nascimento <geral=
dogabriel@gmail.com> wrote:
> > > According to Rockchip sources, there is grave danger in enabling =
5.0
> > > GT/s speed for this core. Add a comment documenting that danger a=
nd
> > > discouraging end-users from forcing higher speed through DT chang=
es.
> > >=20
> > > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b=
4c21b@rock-chips.com/
> > > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-rockchip-host.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/driver=
s/pci/controller/pcie-rockchip-host.c
> > > index ee1822ca01db..7e6ff76466b7 100644
> > > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > > @@ -332,6 +332,11 @@ static int rockchip=5Fpcie=5Fhost=5Finit=5Fp=
ort(struct rockchip=5Fpcie *rockchip)
> > >  		/*
> > >  		 * Enable retrain for gen2. This should be configured only aft=
er
> > >  		 * gen1 finished.
> > > +		 *
> > > +		 * According to Rockchip this path is dangerous and may lead t=
o
> > > +		 * catastrophic failure. Even if the odds are small, users are
> > > +		 * still discouraged to engage the corresponding DT option.
> > > +		 *
> > >  		 */
> > >  		status =3D rockchip=5Fpcie=5Fread(rockchip, PCIE=5FRC=5FCONFIG=
=5FCR + PCI=5FEXP=5FLNKCTL2);
> > >  		status &=3D ~PCI=5FEXP=5FLNKCTL2=5FTLS;
> >=20
> > Looking good to me, thanks for this patch!  There's no need
> > to emit warnings here, because they'd be emitted already in
> > the rockchip=5Fpcie=5Fparse=5Fdt() function.
> >=20
> > Please feel free to include
> >=20
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> >
>=20
> I disagree, I think the comment stands.
>=20
> Even if we reduce to one line, ex:
>=20
> + May cause damage

Ah, perhaps I wasn't clear enough, so let me clarify a bit.  The
comment you added is fine, I just referred to no need for emitting
a warning at that point, because it would be emitted already.


