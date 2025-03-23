Return-Path: <linux-pci+bounces-24462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64723A6CF69
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 14:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E6F16E6DD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF389F4ED;
	Sun, 23 Mar 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wouterbijlsma.nl header.i=@wouterbijlsma.nl header.b="aWTh+nU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PueZtNh0"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A077282EE
	for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742735267; cv=none; b=OoSyZYr2DK2mWzyS/mUKootuFCHPg2axRGRoiRWbNyIyGogR0ubtmEnW3y5gJ9sFqjPhMhyU4XAbuXf+HQkf5PttVpafh5vspV0TzQF4qOBfXqSQtZCOiitXJK0trw/3EoVv2PCziAtShj1arIVqHpXFOVnkRA1DSspDEUy7CQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742735267; c=relaxed/simple;
	bh=MlVKhUoPdxIB7mCIpB0vhJnWF9JMR1imiMJaliOqVKA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oJV0sO38BZ64pYCDxayJRSBonW/oewC54Fq1Z6zxKmoWT+lD1g0S77DNcqeMyM7Ce3EJfEYevzSy9Qc+EXzgNxwvnvZAirXfwGSBaA1ElseykS/p0IocuJrzxPcBtcSFdvypP0Twf9rCLiD4+IpQbzGWo+m2kl1P/jVmGhoE09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wouterbijlsma.nl; spf=pass smtp.mailfrom=wouterbijlsma.nl; dkim=pass (2048-bit key) header.d=wouterbijlsma.nl header.i=@wouterbijlsma.nl header.b=aWTh+nU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PueZtNh0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wouterbijlsma.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wouterbijlsma.nl
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74C4725400B8;
	Sun, 23 Mar 2025 09:07:42 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-05.internal (MEProxy); Sun, 23 Mar 2025 09:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wouterbijlsma.nl; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1742735262; x=1742821662; bh=YJg9gvdgUkS4YUYBLQuhb
	WFvO41j2NLlAm9JwfRBtAM=; b=aWTh+nU0Y/beym4WOfv8k+/uUZFbKVVkMp1LZ
	sNljic7rhaCEK19okfCmf0rjqIcH9RBD/uCf9Bw4wvttB6dIEhICQ8RZoqJzX0Qb
	K7BkRVTePvrLIRxY0YecmzUS3tG/QemovrJIUAG0IqFpOXQFQbWRDW8rfD3X2VZG
	j6zXIWNk4mkw2GLDNM9ks3vU2tv3yISuOaTIr52VlUUyEPk0dMKadCqjCG8i67kG
	StmixdMSFXjAaewny5YG9wV8qVww/F/1TMIXp42a0lwFnPKXr108C3H7rR6W0xeb
	XBFLongpTTJzZiDq/cjWDxXSng3lfjWbsE+UDQ4zW/ZAg7iTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742735262; x=
	1742821662; bh=YJg9gvdgUkS4YUYBLQuhbWFvO41j2NLlAm9JwfRBtAM=; b=P
	ueZtNh0mb4FU6sTZpiHLpaxc0lux7KSrKb4/zg0LU9fNB1KQuO9w2k5f9PtDMpBE
	hD5azc3CCI5dKF61J2Htj6TY4x+xI8HqyqqXU25to/HkNzW6YcJCmSbff6wU3QwN
	SgpKOC6PwE5dLKFyy9VJG9ShVZGJZiaiiuBrBUeMqDevr5Wx8I/m63drYHaUzjPU
	Ska3jpQtusD78OMdMWAYdwb4lqZH+QPnvgdGy0/5IIoql2h04mLF4q92eglV8+Ei
	8vkRqaz3F1U6Y+hIgfL8rrMUq/SSm7ej1E7Ye5v/4VK2+m/GfMwX7d+VAqYuEW32
	02Q2wsZmS4KqRPWhFVDiQ==
X-ME-Sender: <xms:nQfgZ65CPGSa1mpQmeiiigEK9nzveH7pTx5jnN4FWO9HCxvmui4wfw>
    <xme:nQfgZz7U7nV36KCJBM_PeZTTUH3bA8ZtGdAfm214IUADDdg9E_yK_pUvrl_vcc5Ip
    6WYSuCyBicpTUdPHtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfhghouhhtvghruceuihhjlhhsmhgrfdcuoeifohhuthgvrhesfi
    houhhtvghrsghijhhlshhmrgdrnhhlqeenucggtffrrghtthgvrhhnpedtvdekvdejgfdv
    ueevjeejtdffieeuveejleejgefgveekgeejgedvfeejudffteenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifohhuthgvrhesfihouhhtvghr
    sghijhhlshhmrgdrnhhlpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    fieslhhinhhugidrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlih
    hnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghr
    gheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhptghise
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshesfihunhhnvghr
    rdguvg
X-ME-Proxy: <xmx:nQfgZ5dq6C3UeO7tQ9uBR6jpSAn5Sga8ULXI3M0YnnO637WqybJWWQ>
    <xmx:nQfgZ3J40NVxkLR6NJHy2mah7gElhKd6MFL9PJRpaTN2zv8YxR-soQ>
    <xmx:nQfgZ-J4VXdDYH1FfXh9SoVUR2vTp9PmFFWhxEsWiOFh7oacxxTNFg>
    <xmx:nQfgZ4wgPodPU4Ztjx3I81nd2q1IJJQaWmcfn-Ny-OtjKP0iQW2Nsw>
    <xmx:ngfgZwgfS5GZthHSkqH-XJdRyUkG3QgiOpTdtbv_DLzbHXZdDiXF4doy>
Feedback-ID: ib07144fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2248D3020080; Sun, 23 Mar 2025 09:07:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ta2a36078c6d4967f
Date: Sun, 23 Mar 2025 14:07:20 +0100
From: "Wouter Bijlsma" <wouter@wouterbijlsma.nl>
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: "Lukas Wunner" <lukas@wunner.de>, "Bjorn Helgaas" <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, "Ilpo Jarvinen" <ilpo.jarvinen@linux.intel.com>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>
Message-Id: <eaa54741-e15c-457b-9313-1d5bcb518860@app.fastmail.com>
In-Reply-To: <20250323125652.GJ1902347@rocinante>
References: 
 <3b6c8d973aedc48860640a9d75d20528336f1f3c.1742669372.git.lukas@wunner.de>
 <20250323112456.GA1902347@rocinante>
 <2e16d6af-7d7d-47a7-9c69-26f0765a83d6@app.fastmail.com>
 <20250323125652.GJ1902347@rocinante>
Subject: Re: [PATCH] PCI/bwctrl: Fix NULL pointer deref on bus number exhaustion
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> Would you be happy to provide your "Tested-by:" tag?

You can use 'Tested-by: Wouter Bijlsma <wouter@wouterbijlsma.nl>'

-Wouter


On Sun, Mar 23, 2025, at 1:56 PM, Krzysztof Wilczy=C5=84ski wrote:
> Hello,
>=20
> > The patch is working, no kernel crashes and shutting down after hotp=
lugging the Thunderbolt 4 dock does not hang anymore, thanks!
>=20
> Thank you for testing!  Appreciated!
>=20
> > I still see messages in the kernel log that 'devices behind bridge a=
re unusable' because 'no bus can be assigned to them', 'Hotplug bridge w=
ithout secondary bus, ignoring', etc. These all refer to the Thunderbolt=
 4 bridge. Adding "pci=3Dhpbussize=3D0x33" to the kernel doesn't make a =
difference. Adding "pci=3Drealloc,asssign-busses,hpbussize=3D0x33" actua=
lly does 'fix' the bus allocation failures (or at least I don't see any =
messages in the log anymore), but then amdgpu fails to initialize the IG=
P.
>=20
> We can fix any outstanding issues or drop this patch.  I leave it to h=
ot
> plug experts like Ilpo, Bjorn and Lukas to make the call here.
>=20
> > Anyway, all devices connected to the Thunderbolt 4 dock appear to wo=
rk (USB, screens, ethernet) even despite these bus allocation failures, =
so I will just ignore them.=20
> >=20
> > Thanks again!
>=20
> Would you be happy to provide your "Tested-by:" tag?
>=20
> Krzysztof
>=20

