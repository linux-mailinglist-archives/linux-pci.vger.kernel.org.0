Return-Path: <linux-pci+bounces-4641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A48875EC2
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 08:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15FAC1C21652
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353A4F5E6;
	Fri,  8 Mar 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b="l1/oRpbk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.exaion.in (mail.exaion.in [91.239.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3BC2AD39
	for <linux-pci@vger.kernel.org>; Fri,  8 Mar 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.239.56.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883777; cv=none; b=BpbK6hOcHB/xicU6aF1Qi8EoaIe9nEgx9+6UKJuDlFmp/lrppfSgFfl/J8QezZ6BlhylYJ51/5PwDfq7HikcgirsRHdve+6ySZDN6C4Tg5kuZv5j79Dd+vVxyzLVA7dvqAlN4LaKZVwfQtuCZ0FOM2Ot9L9yu8RR3gpLUL6Me78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883777; c=relaxed/simple;
	bh=v1kbTJ5mq9GPLRxPMQoi93t77Yd9Lz1EuMH7TDquDmI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbqvbZvUelNARyk+l50RXimonDSL0X0UdLFZhzG9kIXhsE6qlK1jWYAtbPNw5qkM4O0mBQojHnvni73aJVtgIJPG81OmHc2+3vSqKkfgJTJBzLXu2uRESRXz0i3L+hbRfPJhiVc6oZtenca8q/Z0HuyyO8Knojz1ZfpUyT+oMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com; spf=pass smtp.mailfrom=exaion.com; dkim=pass (2048-bit key) header.d=exaion.com header.i=@exaion.com header.b=l1/oRpbk; arc=none smtp.client-ip=91.239.56.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=exaion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exaion.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B16344126;
	Fri,  8 Mar 2024 08:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exaion.com; s=dkim;
	t=1709883768; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=v1kbTJ5mq9GPLRxPMQoi93t77Yd9Lz1EuMH7TDquDmI=;
	b=l1/oRpbk76PVhcN1yjce5fq4kurrOUJzdwM5iohVYovHtp/qmyvhIGsgik5G1kGdPOnkP5
	EORwgFiH6VLKeu4kuz58oI156zMppzx1RrVoGN1mTY9BMoYATu8RYiYP56N5KHn7HFfWce
	tDfsejviLzVxqf7yfs7hbEUYXGfz3w9j8OUmXMKHTlMQNTd0asoJYX6YmA3RyNWOfY7vdj
	RHQqsfmq5iK9jdiiYmled1nXjY8ddDfY9aJUqQWOQn90MjWsHx9fAZyD0OS0VATPZfnO2O
	Crbobf+HT04QGy67MmoE4oCFP2WN2eeXUGmnh2JR9Jv/0UfIBKPjTkSG4cSYAw==
Message-ID: <484c002341c1c161437fa568c236a8ac1576a482.camel@exaion.com>
Subject: Re: [Regression] [PCI/VPD] Possible memory corruption caused by
 invalid VPD data (commit found)
From: Josselin Mouette <josselin.mouette@exaion.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Date: Fri, 08 Mar 2024 08:42:41 +0100
In-Reply-To: <20240307231131.GA658799@bhelgaas>
References: <20240307231131.GA658799@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Le jeudi 07 mars 2024 =C3=A0 17:11 -0600, Bjorn Helgaas a =C3=A9crit=C2=A0:
> [+cc Hannes]
>=20
> [BTW, the patches are whitespace damaged, so they don't apply.=C2=A0 Look=
s
> like tabs got converted to spaces]

I=E2=80=99ll be damned for trying to interact here with corporate email, wo=
n=E2=80=99t
I? :) Sorry about that.

> On Thu, Mar 07, 2024 at 05:07:50PM +0100, Josselin Mouette wrote:
> > We=E2=80=99ve been observing a subtle kernel bug on a few servers after
> > kernel
> > upgrades (starting from 5.15 and persisting in 6.8-rc1).=C2=A0The bug
> > arises
> > only on machines with Mellanox Connect-X 3 cards and the symptom is
> > RabbitMQ disconnections caused by packet loss on the system
> > Ethernet
> > card (Intel I350). Replacing the I350 by a 82580 produced the exact
> > same symptoms.
>=20
> It looks like both I350 and 82580 use the igb driver?

Yes indeed. I wanted to try hardware from another vendor entirely, but
we don=E2=80=99t have that in stock unfortunately.

> > Bjorn advised (thanks!) to look for what process is reading that
> > VPD
> > data. In our case it is libvirtd, and enabling debugging in
> > libvirtd
> > turned out a very interesting exercise, since it starts spewing
> > gabajillions of VPD errors, especially in the Intel 82580 data.
>=20
> Can we dig into these errors a bit?=C2=A0 I assume most of these come fro=
m
> libvirtd (not the kernel)?

Yes, it=E2=80=99s libvirtd that does the parsing.=20

virPCIDeviceNew:1496 : 15b3 1003 0000:16:00.0: initialized
 =E2=86=92 That=E2=80=99s the Connect-X 3
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x4
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x4
 (several thousands of these)
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0
 (tens of thousands of those)
debug : virPCIVPDParse:748 : Encountered an invalid VPD: does not have a VP=
D-R record
virPCIDeviceFree:1526 : 15b3 1003 0000:16:00.0: freeing

Then it tries reading again the Connect-X 3 VPD a couple times, before
giving up.

Then we reach the 82350:
virPCIDeviceNew:1496 : 8086 150e 0000:86:00.1: initialized
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x5
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x8
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0xa
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x5
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x8
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0xc
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0xe
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0xc
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x4
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x4
virPCIVPDParse:734 : Encountered an unexpected VPD resource tag: 0x7
virPCIVPDResourceGetKeywordPrefix:70 : internal error: The keyword is not c=
omprised only of uppercase ASCII letters or digits
virPCIVPDParseVPDLargeResourceFields:517 : Could not determine a field valu=
e format for keyword: ^KN
virPCIVPDResourceGetKeywordPrefix:70 : internal error: The keyword is not c=
omprised only of uppercase ASCII letters or digits
virPCIVPDParseVPDLargeResourceFields:517 : Could not determine a field valu=
e format for keyword: 0^E
virPCIVPDParseVPDLargeResourceFields:529 : internal error: A field data len=
gth violates the resource length boundary.
virPCIVPDParse:740 : Encountered an invalid VPD
virPCIDeviceFree:1526 : 8086 150e 0000:86:00.1: freeing

(Multiply by the number of 82350 ports and the number of attempts.)

> The VPD for different devices should be independent, so maybe an mlx4
> VPD buffer overflow corrupted an igb VPD buffer, probably more likely
> in libvirtd than in the kernel.

=E2=80=A6 or maybe not, see later.

> > That igb data does not look corrupt when we revert the change
> > mentioned
> > earlier, and we don=E2=80=99t see the packet loss either.
>=20
> When you revert 5fe204eab174 ("PCI/VPD: Allow access to valid
> parts of VPD if some is invalid"), you see no VPD errors either from
> the kernel or from libvirtd except this one?
>=20
> =C2=A0 mlx4_core 0000:16:00.0: missing VPD_STIN_END at offset 32769

We do have these as well, nothing new:
pci 0000:1b:00.0: [Firmware Bug]: disabling VPD access (can't determine siz=
e of non-standard VPD format)
(This is a LSI Megaraid controller, which thankfully doesn=E2=80=99t seem t=
o
cause any havoc.)

But actually with patch 0002 we also get these:
igb 0000:86:00.0: invalid VPD tag 0xff (size 65535) at offset 132

So we would not have one, but TWO buggy pieces of firmware here. Which
provides a perfect explanation for why the igb warnings disappear as
well.=C2=A0

This, plus the insane size of the libvirtd logs (we=E2=80=99re talking mill=
ions
of lines when it loops over invalid VPD data, over and over again),
leads me to another hypothesis: libvirtd could spend so much time
parsing VPD data it will actually fail to handle network packets in
time before a timeout; timeouts being low in the AMQP protocol.

Thanks again for pushing me in the right direction. I hope we=E2=80=99re on=
to
something.

--=20
Josselin MOUETTE
Infrastructure & security architect
EXAION

