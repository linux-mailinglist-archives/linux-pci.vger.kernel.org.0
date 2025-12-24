Return-Path: <linux-pci+bounces-43702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D548DCDCE62
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0D0300DC8A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C61326D74;
	Wed, 24 Dec 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dEvno/hn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81455145A1F;
	Wed, 24 Dec 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595132; cv=none; b=C8aePBXOV4Zb+H66nriVNvntci9scWeBzKC3VunO/WPrBQHMx0RM0OJEJGT3x+j3olFfa/mSkaGmWDOjHQhPMQWPXM6zBV9VqR2ZO1qh4PWORRoC/XniTWHxP5qqxff0KY3XdamUKsNLYUX7bhhM/B6rFveviycGu+y1e4UtS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595132; c=relaxed/simple;
	bh=C33Wmkz7HToOa4OG19kHvAVpDFDENgAzSEEehlQUsVA=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=kZ4FYE9eLWl48biQb0fZUJ9hL6QTQ/+jSZvaT4aqe8QXXfXDC2yvhNEgCks4tifuH7nRIJzjBUoW6ouZTzUiw9f2xA07lymx8AGdZ3JigrQhLZBVX38F0E9w1dWcF2mKMN4ek0RSSNCKSVE8Qn9GNIEDjM+4GvN85YSzrxIL/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dEvno/hn; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id A395C418A6;
	Wed, 24 Dec 2025 17:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1766595126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FAlvebUUG2bzxrDciua9nbFHHFRu5loYHuWIcI/vSNo=;
	b=dEvno/hnZfKDLt2EyPrnqbHoMqCokv0GPc7Jm8I91GfJpoPGEwhch2O7dQfp1s8hW836sI
	wFaAFNDJyNtyLf9maDbvEEg4urvKf8jzsX7gYppR0zWFIxgU16vEWkapdEErOcNSKjqWUo
	1IZWg0Pf/ZVelylRiuqZjULdC3AC972jpo1xLp2wtZ5jGWxCU5qm5oH6SmnvFhim8dFzFz
	waqBqGmYY4mYo1Umz0pLBa6VuOg1Pg7agGkPEa74d8I0HK7z0YyKIVWQOIVhv32ZF6h+Oj
	esDxaolb8W5uxwBz8WqrhgwpFgNzjG6nWBJfhceZLRuAWROpPcL6U27JXTVOiQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <CANAwSgS6UeR4PJnWDxxcQbdH8u_4uNiQxCTugQS35LcPvpiwMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
 <CANAwSgQ726J_vnDKEKd94Kq62kx8ToZzUGysz4r3tNAXvfAbGA@mail.gmail.com>
 <CAEsQvctSY7-RQEQF2TmJU2qKPZOe9TC5g-7Jat0LQKRHYz_6dQ@mail.gmail.com>
 <CANAwSgQPQUBi6VVb+hZNraMt71vnRpki+YK_at=Luo4aPVtOPg@mail.gmail.com> <0afea20b-be22-2404-5a8e-c798ed45f2fd@manjaro.org> <CANAwSgS6UeR4PJnWDxxcQbdH8u_4uNiQxCTugQS35LcPvpiwMQ@mail.gmail.com>
Date: Wed, 24 Dec 2025 17:52:03 +0100
Cc: "Geraldo Nascimento" <geraldogabriel@gmail.com>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Johan Jonker" <jbx6244@gmail.com>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: "Anand Moon" <linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <648aa5c0-9e58-2404-4250-e83b8a748601@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 1/4] =?utf-8?q?PCI=3A?==?utf-8?q?_rockchip=3A?= 
 limit RK3399 to =?utf-8?q?2=2E5?= GT/s to prevent damage
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

On Wednesday, December 24, 2025 17:11 CET, Anand Moon <linux.amoon@gmai=
l.com> wrote:
> On Wed, 24 Dec 2025 at 18:25, Dragan Simic <dsimic@manjaro.org> wrote=
:
> > On Wednesday, December 24, 2025 09:04 CET, Anand Moon <linux.amoon@=
gmail.com> wrote:
> > > On Wed, 24 Dec 2025 at 11:08, Geraldo Nascimento
> > > <geraldogabriel@gmail.com> wrote:
> > > > On Wed, Dec 24, 2025 at 2:18=E2=80=AFAM Anand Moon <linux.amoon=
@gmail.com> wrote:
> > > > > On Tue, 18 Nov 2025 at 03:17, Geraldo Nascimento
> > > > > <geraldogabriel@gmail.com> wrote:
> > > > > > Shawn Lin from Rockchip has reiterated that there may be da=
nger in using
> > > > > > their PCIe with 5.0 GT/s speeds. Warn the user if they make=
 a DT change
> > > > > > from the default and drive at 2.5 GT/s only, even if the DT
> > > > > > max-link-speed property is invalid or inexistent.
> > > > > >
> > > > > > This change is corroborated by RK3399 official datasheet [1=
], which
> > > > > > says maximum link speed for this platform is 2.5 GT/s.
> > > > > >
> > > > > > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip=5F=
RK3399=5FDatasheet=5FV2.1-20200323.pdf
> > > > > >
> > > > > To accurately determine the operating speed, we can leverage =
the
> > > > > PCIE=5FCLIENT=5FBASIC=5FSTATUS0/1 fields.
> > > > > This provides a dynamic mechanism to resolve the issue.
> > > > >
> > > > > [1] https://github.com/torvalds/linux/blob/master/drivers/pci=
/controller/pcie-rockchip-ep.c#L533-L595
> > > >
> > > > not to put you down but I think your approach adds unnecessary =
complexity.
> > > >
> > > > All I care really is that the Kernel Project isn't blamed in th=
e
> > > > future if someone happens to lose their data.
> > > >
> > > Allow the hardware to negotiate the link speed based on the
> > > available number of lanes.
> > > I don=E2=80=99t anticipate any data loss, since PCIe will automat=
ically
> > > configure the device speed with link training..
> >
> > Please, note that this isn't about performing auto negotiation
> > and following its results, but about "artificially" limiting the
> > PCIe link speed to 2.5 GT/s on RK3399, because it's well known
> > by Rockchip that 5 GT/s on RK3399's PCIe interface may cause
> > issues and data corruption in certain corner cases.
> >
> It=E2=80=99s possible the link speed wasn=E2=80=99t properly tuned. O=
n my older
> development board,
> which supports this configuration, I haven=E2=80=99t observed any dat=
a loss.
>=20
> sudo lspci -vvv | grep Speed
>                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit
> Latency L1 <8us
>                 LnkSta: Speed 5GT/s, Width x1
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- S=
peedDis-
>                 LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
> Exit Latency L0s unlimited, L1 <2us
>                 LnkSta: Speed 5GT/s, Width x1
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- S=
peedDis-

Let me clarify, please...  This limitation to 2.5 GT/s came straight fr=
om
Rockchip a few years ago, described back then as an undisclosed errata.
Recently, we got some more details from Rockchip that confirmed 5 GT/s
as having issues in certain corner cases that cannot be validated by
performing some field tests or by observing the PCIe behavior under loa=
d.
Those corner cases with 5 GT/s, as described by Rockchip, are quite har=
d
to reach, but the possibility is still real.

To sum it up, yes, multiple people have reported 5 GT/s as "working for=
 me"
on their RK3399-based boards and devices, but that unfortunately means
nothing in this case, due to the specific nature of the underlying issu=
e.


