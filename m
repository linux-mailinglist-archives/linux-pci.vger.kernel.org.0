Return-Path: <linux-pci+bounces-41301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D4C60322
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 11:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00D96357BB7
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF584283C93;
	Sat, 15 Nov 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="HCsoERdx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116161487E9;
	Sat, 15 Nov 2025 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763201389; cv=none; b=JNLZSsxIVq+qO9dhrmhGRtVz2enJUgQjpkUd5FbQOSNts+5cM36PyZo/oi+gT1zOVSKDqwTdkkVmIckDsONs8+QP60bG6Z9t0QrUM4+N94PcYsKFRY0ENFsdaB3uLVOcPKVMOvV4qRQQo8Z9x6bfeyQVvjRVq/oCYSd0381WY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763201389; c=relaxed/simple;
	bh=ClDHYmHXBMEq/HclfUO+gZlb8Gpcje8kJA+i7q8KeDg=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=uytc+MmOwG+pG089b0remCuhNpsG3jiPx6uyn0BAG+RqcAA4+L6koblFsvi7VD8iM/VYdclwcrCeJSroXrdh3Nu5oRr84Hw6nzN4jfdDv0CqAztl4wGpUbMTCA8aVTknNJmdOKW9wk9gaML/sf53XuKWee4/zs2iEBof5Qj1RLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=HCsoERdx; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 205D6410BC;
	Sat, 15 Nov 2025 11:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1763201384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TAhpvtcxWm9IHGf9A0rzeueRcz+eQkl96FnuXumWLrE=;
	b=HCsoERdx+wCfcYL76RWyzHFmRdwscfp5+F2x9G6dYsGDNcPDgFrEg3+Inf5WtgfKdVQ9L3
	mKjZvKSI08VhpujHG8cgJQRVc+Tm36KvBN/RIxqmMTbqssa82gB6r4f4o3ITAPQrZdHtIH
	QllMadYz95++2zitEeh3AK1aWMyC+n2abp4SHCFJsG6EJV9hRZhsR2hjj0wFsrViVazJND
	vuJFR9JYWPbEa/vxk+5Y9g24/iUkgqBMzZxZOcsJjxmC7OkOdJcDa5CBcrtSUuoR3+izXh
	u5CDcEhyAmCAq6tNsd3ylzKmNAYjHY8VeLuxOGnk8NtB4MBHFQgyw1jLqnd8dQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <aRhQMRjffbeCeArE@geday>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
 <c8a6d165-2cdd-cd0d-4bed-95dfa5ff30d2@manjaro.org>
 <aRhNIcGcQKp2ylqN@geday>
 <85d1543b-ea91-5f0f-59d6-e00fcf720938@manjaro.org> <aRhQMRjffbeCeArE@geday>
Date: Sat, 15 Nov 2025 11:09:42 +0100
Cc: linux-rockchip@lists.infradead.org, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <52931e25-0d6f-ca0a-7c26-2c65ab11432e@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH 2/3] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-host=3A?= comment danger of =?utf-8?q?5=2E0?= GT/s 
 speed
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

On Saturday, November 15, 2025 11:04 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> On Sat, Nov 15, 2025 at 11:01:21AM +0100, Dragan Simic wrote:
> > On Saturday, November 15, 2025 10:51 CET, Geraldo Nascimento <geral=
dogabriel@gmail.com> wrote:
> > > On Sat, Nov 15, 2025 at 10:30:49AM +0100, Dragan Simic wrote:
> > > > Looking good to me, thanks for this patch!  There's no need
> > > > to emit warnings here, because they'd be emitted already in
> > > > the rockchip=5Fpcie=5Fparse=5Fdt() function.
> > > >=20
> > > > Please feel free to include
> > > >=20
> > > > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > > >
> > >=20
> > > I disagree, I think the comment stands.
> > >=20
> > > Even if we reduce to one line, ex:
> > >=20
> > > + May cause damage
> >=20
> > Ah, perhaps I wasn't clear enough, so let me clarify a bit.  The
> > comment you added is fine, I just referred to no need for emitting
> > a warning at that point, because it would be emitted already.
>=20
> OK, I get it now so I think it's time to send v2 with all that in min=
d
> :)

Please, wait a day or two before sending the v2, because that's
standard procedure.  Sending more than one version in the same day
is highly discouraged, because it doesn't give enough time to people
for reviewing, and may cause people to look at a wrong version.


