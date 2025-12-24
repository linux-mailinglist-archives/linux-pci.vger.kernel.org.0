Return-Path: <linux-pci+bounces-43660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62518CDC4B0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 13:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55DF5300ACD9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB73370E5;
	Wed, 24 Dec 2025 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="rIH3fAA1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496131771B;
	Wed, 24 Dec 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580944; cv=none; b=ilKn70hx8xqBkErGOUM1ITwUKzbfz06QNde+kykRqlX+jimpL29/Qw2g80raNbRj5GEKQ+/NUCtcte3jFzaM9nOzdnGHdj6gztIeEismn6mA8cl5pDyQuI2ycamnYqgkNFSoOZHjLeu271Ecwy/PIuVcr+Yso5DLRRBB79hgMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580944; c=relaxed/simple;
	bh=He22hg7Pf60Vb1jpOAaSsU0Q2mSrOPk6nn6TP4vK02Y=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=COE1K+Lyc9vq160Lj54B7Qq3rcLRdiOcI/aF5/3EvRc9LGENyW8DJs0Bm0OPY1dAXRDslb40BGM0xyQARmrmh5sUvUdZ6fpmIGuNkuMvRNHEZ8QWnUF3chrdiQAJiMBi/2FGfDTIlp3ipS3/CmbFNtbN08KshtaM6LhRHFEFBSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=rIH3fAA1; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 06125418A6;
	Wed, 24 Dec 2025 13:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1766580933; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=He22hg7Pf60Vb1jpOAaSsU0Q2mSrOPk6nn6TP4vK02Y=;
	b=rIH3fAA1weXMcnywGhw9J/NjYO7gM+SD1P8ggPsnJGW0N/G85XXy2sVfaEMeJUa6ars1h3
	852lv/3i/IkLSgvI1ILhibJABZR4sNHlsMvLKMy2qMPvR4BwSxj4MCh25Bkcj0g4MrQEYn
	81tFoyjdNzI3EvfwL6K6QBSkg1k/ylSxyBHevgh9Pw22k/hbGYJ3Bdadmi8TniM0jOmk1W
	Qyyz5uGhdXO//fq37KF+HmSj8Rf1DD3rNpG9xR1RWlXu6e6fIXJIDvnxGN3p4Xc1E82h9Z
	fXtIuIK3OhE1jg2EhX89ikMCDdrR0z4ASzaXwIMmKSeNyhYUN45R4qOiyIRoQw==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <CANAwSgQPQUBi6VVb+hZNraMt71vnRpki+YK_at=Luo4aPVtOPg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
 <CANAwSgQ726J_vnDKEKd94Kq62kx8ToZzUGysz4r3tNAXvfAbGA@mail.gmail.com> <CAEsQvctSY7-RQEQF2TmJU2qKPZOe9TC5g-7Jat0LQKRHYz_6dQ@mail.gmail.com> <CANAwSgQPQUBi6VVb+hZNraMt71vnRpki+YK_at=Luo4aPVtOPg@mail.gmail.com>
Date: Wed, 24 Dec 2025 13:55:29 +0100
Cc: "Geraldo Nascimento" <geraldogabriel@gmail.com>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: "Anand Moon" <linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <0afea20b-be22-2404-5a8e-c798ed45f2fd@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 1/4] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?= 
 limit RK3399 to =?utf-8?q?2=2E5?= GT/s to prevent damage
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Anand,

On Wednesday, December 24, 2025 09:04 CET, Anand Moon <linux.amoon@gmai=
l.com> wrote:
> On Wed, 24 Dec 2025 at 11:08, Geraldo Nascimento
> <geraldogabriel@gmail.com> wrote:
> > On Wed, Dec 24, 2025 at 2:18=E2=80=AFAM Anand Moon <linux.amoon@gma=
il.com> wrote:
> > > On Tue, 18 Nov 2025 at 03:17, Geraldo Nascimento
> > > <geraldogabriel@gmail.com> wrote:
> > > > Shawn Lin from Rockchip has reiterated that there may be danger=
 in using
> > > > their PCIe with 5.0 GT/s speeds. Warn the user if they make a D=
T change
> > > > from the default and drive at 2.5 GT/s only, even if the DT
> > > > max-link-speed property is invalid or inexistent.
> > > >
> > > > This change is corroborated by RK3399 official datasheet [1], w=
hich
> > > > says maximum link speed for this platform is 2.5 GT/s.
> > > >
> > > > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip=5FRK=
3399=5FDatasheet=5FV2.1-20200323.pdf
> > > >
> > > To accurately determine the operating speed, we can leverage the
> > > PCIE=5FCLIENT=5FBASIC=5FSTATUS0/1 fields.
> > > This provides a dynamic mechanism to resolve the issue.
> > >
> > > [1] https://github.com/torvalds/linux/blob/master/drivers/pci/con=
troller/pcie-rockchip-ep.c#L533-L595
> >
> > not to put you down but I think your approach adds unnecessary comp=
lexity.
> >
> > All I care really is that the Kernel Project isn't blamed in the
> > future if someone happens to lose their data.
> >
> Allow the hardware to negotiate the link speed based on the
> available number of lanes.
> I don=E2=80=99t anticipate any data loss, since PCIe will automatical=
ly
> configure the device speed with link training..

Please, note that this isn't about performing auto negotiation
and following its results, but about "artificially" limiting the
PCIe link speed to 2.5 GT/s on RK3399, because it's well known
by Rockchip that 5 GT/s on RK3399's PCIe interface may cause
issues and data corruption in certain corner cases.


