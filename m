Return-Path: <linux-pci+bounces-41426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2504C65004
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A766128F8B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFA29D282;
	Mon, 17 Nov 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="C/KqexO6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C529CB4C;
	Mon, 17 Nov 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395154; cv=none; b=CpYBy/ftzh3tg+NLJr4EUfhwNmEII2NERwdfWc7IDtnn53RucVvVgNTv/WjkvXXBa52fniWE0aWCZm24wHryfKOJNzLCF/akbVrUGx9kiP9VvHs8hXBH/r0mZ75uJxe2RGNuCB5MmnoD7JrVmm4b9o5rjyrI0V82JfYQp4pVQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395154; c=relaxed/simple;
	bh=AzUm5SyQnN+H3BhkLDc4TI3blmZP45mMPd046i1WLic=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=q079XAt5eOWEge3fSghxC+vJXEqZ/S21myG9vjPxj6WWsjZCMH1FToKj01oZgvHs0eni7fo6Q9rke780X7lbhycrTQB/N08iNINrc5s5vJdMcaLDKC9wp0BOU074HjEMHI4qhyO2NnmPfQkUSsgTU8QUmLboPEdp+engxvtomnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=C/KqexO6; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id D540841095;
	Mon, 17 Nov 2025 16:59:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763395149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zkn44FjR+pCfEjpttwFCzM+vdwVOm3Tq+gRyYYZrqaw=;
	b=C/KqexO6h7lCq322ARNRT5+LGtjamGKURkllK3HzjYPHOKO9anlQ9NZ7A6nMfVY0JJmEr6
	AUcCqnVVFSWbcP1G6B2+XD6fpN3hpt3UMc3HkCbS/itsh2YIWPbChNvUNF6kB4Wr4pg524
	xncW8KuE0cfGMsYpvmDrGcGTWB94CziDsnu/UdoBqFNVDe0mZphVfLrqHes/XibvRfT4kQ
	A355rmGB9ABLCSljkVTlTOkGCSXo7EByB/NmHg5T6VrgaghIGlHn4ixJomMtGonqWEZTnl
	5tdONmWdhYwJtUasEUF/pLGlkPryYIH+QkXvy0btaKmwHxax6los3e4QVCvtVQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <aRrIhA1uv_aIneOc@geday>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <8f3cc1c1-7bf7-4610-b7ce-79ebd6f05a6e@rock-chips.com>
 <257951b7-c22e-9707-6aba-3dc5794306bb@manjaro.org> <aRrIhA1uv_aIneOc@geday>
Date: Mon, 17 Nov 2025 16:59:05 +0100
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4afa0534-5458-ac0c-6c92-38ed52aea00b@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 0/3] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?=
 =?utf-8?q?_5=2E0?= GT/s speed may be dangerous
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo,

On Monday, November 17, 2025 08:02 CET, Geraldo Nascimento <geraldogabr=
iel@gmail.com> wrote:
> On Mon, Nov 17, 2025 at 04:57:11AM +0100, Dragan Simic wrote:
> > On Monday, November 17, 2025 04:42 CET, Shawn Lin <shawn.lin@rock-c=
hips.com> wrote:
> > > =E5=9C=A8 2025/11/15 =E6=98=9F=E6=9C=9F=E5=85=AD 17:10, Geraldo N=
ascimento =E5=86=99=E9=81=93:
> > > > In recent interactions with Shawn Lin from Rockchip it came to =
my
> > > > attention there's an unknown errata regarding 5.0 GT/s operatio=
nal
> > > > speed of their PCIe core. According to Shawn there's grave dang=
er
> > > > even if the odds are low. To contain any damage, let's cover th=
e
> > > > remaining corner-cases where the default would lead to 5.0 GT/s
> > > > operation as well as add a comment to Root Complex driver core,
> > > > documenting this danger.
> > >=20
> > > I'm not sure just adding a warn would be a good choice. Could we =
totally
> > > force to use gen1 and add a warn if trying to use Gen2.
> >=20
> > I think that forcing 2.5 GT/s with an appropriate warning message
> > is a good idea.  That would be like some quirk that gets applied
> > automatically, to prevent data corruption, while warning people
> > who attempt to "overclock" the PCIe interface.
>=20
> Alright, I'll send v2 with this suggestion in mind. So that driving t=
he
> core at 5.0 GT/s will require patching and compiling own kernel.
>=20
> > > Meanwhile amend the commit message to add a reference
> > > of RK3399 official datesheet[1] which says PCIe on RK3399 should =
only
> > > support 2.5GT/s?
> > >=20
> > > [1]https://opensource.rock-chips.com/images/d/d7/Rockchip=5FRK339=
9=5FDatasheet=5FV2.1-20200323.pdf
> >=20
>=20
> Shawn, URLs have the bad habit of changing or simply disappearing, so=
 I
> don't think it's a good idea to put URL in the commit message.

Ah, it's actually perfectly fine, there's always Wayback Machibe
to rescue references/URLs that may disappear over time.  Wikipedia
relies heavily on exactly that mechanism, for example.

[2] https://web.archive.org/

> Also, the datasheet just mentions that RK3399 supports only 2.5 GT/s,
> it does not mention possible damage from driving the core at 5.0 GT/s=
.

True, but having an additional reference doesn't hurt, especially
because the revision history mentions, albeit vaguely, an update
to the PCIe specification in version 1.1.of the datasheet.  Though,
if we had the version 1.0 publicly available for comparison, that
would've been much better. :)

> > Also, rewording the patch summary as follows below may be good,
> > because that would provide more details:
> >=20
> >   PCI: rockchip: Warn about Gen2 5.0 GT/s on RK3399 being unsafe
> >=20
> > Or, if we'll go with the automatic downgrading, like this:
> >=20
> >   PCI: rockchip: Limit RK3399 to Gen1 2.5 GT/s to prevent breakage
>=20
> Dragan, these are good ones, thanks. Though I think I'll omit Gen1/Ge=
n2
> wording since I know how much Bjorn dislikes those terms.

I'm glad that you like those, and I also thought about not including
the GenX parts, because they're basically a bit redundant. :)


