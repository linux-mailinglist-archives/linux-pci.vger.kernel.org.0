Return-Path: <linux-pci+bounces-43272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7CCCB512
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 11:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E72301819B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 10:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FFB33CEA1;
	Thu, 18 Dec 2025 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="pIsna1Jw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A662F3621;
	Thu, 18 Dec 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052802; cv=none; b=Y74WDuhMRlO100CzgaQEdbNjnORxDLNvXOpadn7RlCOoIWD5C4TTGhs7hkb8XKLEUlfbNrWQHSU56dMbTEX+gUD9o+H10KPWy28wrLvQOS5ZENEnFecJXKNz7zSDPcKd3dR/ot5S2RaYKJnhSr83akF51ut6yQMLqN9nlPktgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052802; c=relaxed/simple;
	bh=AluQXahrkuxDalkkn365wmM3+k/GQwCu4bWiiV3a2Ww=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=lJsnL/WdhfqQFImkPGE6rbxtcvJ4jDAx6U/zGDF/ft5TakGRgwvhVrB3NzxvnVOCwsDI+K4yVZvB6jxZNrTg7OkDWIX2RJER3Ufv4wb5C4GiaHfFl/b338eunr0aDK0SYzAYqvpG8t5vzn8b3u1zztArP33YxPvImTfbj4ddeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=pIsna1Jw; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id A7CEF417D6;
	Thu, 18 Dec 2025 11:13:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1766052793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qem8ZP+yDudSM4rWioIewZLF1OHQf2ievkUplCtY2mM=;
	b=pIsna1JwNg8vU0xABStqy6mAATplVrqC1O7JmOuFKXA0z/Oy/TC5FMsv4ynfcA0uVNw0K/
	VY6H1SPK/uguUuDIGU88wgsm3tVsjd4J31+G7RDI90yaeALyO6HeMPC3zkn3hqMhyt6/Wc
	zgev/YylCGFOg64bEg/b1h5lgvFMzgdWlQYvJq15Xh1KEwtykuc4kvPsDz2QJk1/+5+q85
	UBG26lGzzWmk//X0BNCQK/k2ytYZwR9DPwFen6tgleqnyPHZJ2wiuTKgDDAUeRzt9bBhYD
	KUFXU6MZg7OuSejxmT/UQrflxq1U36sKWnHgbAzrYjxLGZ8eB+2bNEt0psbvng==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <DF197NIRHLIJ.3LIG9GJGJQLQX@cknow-tech.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com> <qncj72c3owrw7rvnj6jit2sbn4ojyr3kztcjailfxtdboan6sy@ddh5g7v4fcvt> <3ea8ac20-6332-0c0c-645b-36ca4231c109@manjaro.org> <DF197NIRHLIJ.3LIG9GJGJQLQX@cknow-tech.com>
Date: Thu, 18 Dec 2025 11:13:10 +0100
Cc: "Manivannan Sadhasivam" <mani@kernel.org>, "Geraldo Nascimento" <geraldogabriel@gmail.com>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: "Diederik de Haas" <diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <656e9b4e-c350-f808-701e-e49e8dad7062@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 1/4] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?= 
 limit RK3399 to =?utf-8?q?2=2E5?= GT/s to prevent damage
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Diederik,

On Thursday, December 18, 2025 11:01 CET, "Diederik de Haas" <diederik@=
cknow-tech.com> wrote:
> On Thu Dec 18, 2025 at 10:47 AM CET, Dragan Simic wrote:
> > On Thursday, December 18, 2025 09:05 CET, Manivannan Sadhasivam <ma=
ni@kernel.org> wrote:
> >> On Mon, Nov 17, 2025 at 06:47:05PM -0300, Geraldo Nascimento wrote=
:
> >> > Shawn Lin from Rockchip has reiterated that there may be danger =
in using
> >> > their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT=
 change
> >> > from the default and drive at 2.5 GT/s only, even if the DT
> >> > max-link-speed property is invalid or inexistent.
> >> >=20
> >> > This change is corroborated by RK3399 official datasheet [1], wh=
ich
> >> > says maximum link speed for this platform is 2.5 GT/s.
> >> >=20
> >> > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip=5FRK3=
399=5FDatasheet=5FV2.1-20200323.pdf
> >> >=20
> >> > Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from R=
C driver")
> >> > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968=
b4c21b@rock-chips.com/
> >> > Cc: stable@vger.kernel.org
> >> > Reported-by: Dragan Simic <dsimic@manjaro.org>
> >> > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> >> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> >> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> >> > ---
> >> >  drivers/pci/controller/pcie-rockchip.c | 10 ++++++++--
> >> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >> >=20
> >> > diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pc=
i/controller/pcie-rockchip.c
> >> > index 0f88da378805..992ccf4b139e 100644
> >> > --- a/drivers/pci/controller/pcie-rockchip.c
> >> > +++ b/drivers/pci/controller/pcie-rockchip.c
> >> > @@ -66,8 +66,14 @@ int rockchip=5Fpcie=5Fparse=5Fdt(struct rockc=
hip=5Fpcie *rockchip)
> >> >  	}
> >> > =20
> >> >  	rockchip->link=5Fgen =3D of=5Fpci=5Fget=5Fmax=5Flink=5Fspeed(n=
ode);
> >> > -	if (rockchip->link=5Fgen < 0 || rockchip->link=5Fgen > 2)
> >> > -		rockchip->link=5Fgen =3D 2;
> >> > +	if (rockchip->link=5Fgen < 0 || rockchip->link=5Fgen > 2) {
> >> > +		rockchip->link=5Fgen =3D 1;
> >> > +		dev=5Fwarn(dev, "invalid max-link-speed, set to 2.5 GT/s\n");
> >> > +	}
> >> > +	else if (rockchip->link=5Fgen =3D=3D 2) {
> >> > +		rockchip->link=5Fgen =3D 1;
> >> > +		dev=5Fwarn(dev, "5.0 GT/s is dangerous, set to 2.5 GT/s\n");
> >>=20
> >> What does 'danger' really mean here? Link instability or something=
 else?
> >> Error messages should be precise and not fearmongering.
> >
> > I agree that the original wording is a bit suboptimal, and I'd sugg=
est
> > to Geraldo that the produced warning message is changed to
> >
> >   "5.0 GT/s may cause data corruption, limited to to 2.5 GT/s\n"
> >
> > or something similar, to better reflect the actual underlying issue=
.
>=20
> s/limited to to/therefore limit speed to/ ?

That would work well in a book or an article, while slightly terse
wording is usually preferred in the messages produced by the kernel,
or in log messages in general.  Such an approach compacts as much
information as possible in as few words as possible, while still
remaining (mostly) grammatically correct.


