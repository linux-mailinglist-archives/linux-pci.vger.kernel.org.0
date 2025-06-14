Return-Path: <linux-pci+bounces-29809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8F8AD9B35
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF463ADDC7
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9834A1E32DB;
	Sat, 14 Jun 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="gkyXv30G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLhlQXtN"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DD2E11D0;
	Sat, 14 Jun 2025 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888723; cv=none; b=bn/UzQCDaMNfKJU/DfGulv8HkLA2F7E6SB+GG7K25JykMLNLO6PGOfJzetcdeymWjeenv+io42IE8LGHcONRVS5hZRC/UC/tk/9HRKMomas6CV7r0gQaLRGC0xIm/y+LtjzN+ydgUxVyouuzY/psjENCsBYs4QFlRqKePJ7GfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888723; c=relaxed/simple;
	bh=6FQqvrMW6BzcSWx6HE338rJtMQzsjrlGYTTNIdRMw44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MyTTxsbEdKccw14vDUOhlV72/fRaJodyDRI04kKdGZBukHS7j+ztMaGxYSFZJmND4uhKcHT79ja+dnRoQW/LxvxwJ2+0Fb0r3QzuD4X1KOTLavBxPs99JVDHE4hzAXX8GOfN7PF0AYnhAN+YYyTWPA/p41WZR3uPoDMD43MMD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=gkyXv30G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLhlQXtN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ADCE911400BF;
	Sat, 14 Jun 2025 04:11:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 14 Jun 2025 04:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749888719; x=1749975119; bh=JwG6ow84k0
	7PawGfenasYl7lKn5ZP5JhzPigKUfXkws=; b=gkyXv30GagEsyTHnObiMwLOBwy
	kUma1xRlwwVl0J2YHVsgwj4KBhgSSn/7edLwh04ieoylyxOxCcc/6tO/78n381Tr
	Pn4BAhI68BdhHP5ZRurhLBuXlZlFfGHmhm09g60ulaqciOZnqct448yKAzsxl8G0
	fJ1303El+rQ+xhSk+btlFjI7fRAK6UeAZvDswa1MD5XcNnnBFRlSiptaoZ57iR63
	JL4rCP4N+OMdic8SOzRcB1HGAngKW0QO6DE4UkXKpvpD3dsZAFw/aYLJoTLlAaCI
	+y7fi3/ns+qFL+XW2xByHaUxEP/DXTh0jsfD8SeCtZcRwucprZc/EGqvvCJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749888719; x=1749975119; bh=JwG6ow84k07PawGfenasYl7lKn5ZP5JhzPi
	gKUfXkws=; b=hLhlQXtNzT9DaOfQTpCuB498ZYvUCyebN6AixnScNcs7jjDVK31
	BV03uu4/vnON2lonpM2+dbHua0yUO5ADbB/61wnQElEYBeIjpqVmJ519vt/o3YBG
	UN28qj8ch1pMo0PADgjaEYaOoFCQrODsK4uyrDWS5asPPJbsUmmfKLqwimv3P/vR
	VHv347uTtD93aK2kY0/ffH4zIkhDCMqZYv5/HPhcP7/PNp5B/mnG0mybJZ5HRVN5
	uNmecII8qXky1OTbDso+esPrghAc/nUCc02tBcWfops8Gkyv+1VQ7xAWKhmDJfkJ
	zKMSan20EDVaD6mxae5DhQ6wSmIPmNSrm9w==
X-ME-Sender: <xms:zi5NaFDgZsC0vAzg9nSyDLApHyaqL4EPBwmQq6gug3ao_ycW0hN8ww>
    <xme:zi5NaDh-C8viH4gwazTOQEMAI22_Q6N8vaCHHYFDL9yX3W_ZMCre_btF8zMfiOJPb
    2iy9O0gV-3h-ZjXlA>
X-ME-Received: <xmr:zi5NaAlmS6qsQiRpwpb38xGcsskOqIN-ZJr3_np_kUk0lkM1vxCnXjzugnPnK7eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvtdefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeen
    ucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecugg
    ftrfgrthhtvghrnhepteehvedugfejgfehhfeijeduleekleejgedvkeeuuefhhfegvdev
    feetveegteeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtth
    hopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopeguvghmihho
    sggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhgvrghnqdhphhhilhhiphhpvgeslhhinhgrrhhordhorhhgpdhrtghpthhtoh
    epthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepihhomhhmuheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehvihhrthhurghlihiirghtihhonh
    eslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:zi5NaPzz9WLREwOUmXgHGi6s23wP9rJuE91XYIWG8w3ghasIhexzJA>
    <xmx:zi5NaKQOgcy3PSuA6Pa2zR8Fxy5J1YTL4PlYzYWsCXEwU-rd8ptseQ>
    <xmx:zi5NaCYwMT4n6R5fUj4BDtXnakfTN7xQUMJKdykf5IGXb-IYDGKrgw>
    <xmx:zi5NaLQ12XVeoD3ulN_c6bWNoRTq73959RAvTaFn_usvHu1KaUvOjA>
    <xmx:zy5NaMdjv7sfT76u3aPl5hQPDSgggaNcXF4tEluNgtp4ONnn9K7_rC9X>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 04:11:58 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 465FF2462C4EE; Sat, 14 Jun 2025 10:11:56 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Demi Marie Obenour <demiobenour@gmail.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devel@spectrum-os.org, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Virtio interrupt remapping
In-Reply-To: <6b661c62-c322-4f2b-8e4a-da1d5c5e48a1@gmail.com>
References: <c40da5dc-44c0-454e-8b1d-d3f42c299592@gmail.com>
 <20250613181345.GA1350149@myrica>
 <6b661c62-c322-4f2b-8e4a-da1d5c5e48a1@gmail.com>
Date: Sat, 14 Jun 2025 10:11:52 +0200
Message-ID: <877c1ed9o7.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Demi Marie Obenour <demiobenour@gmail.com> writes:

> On 6/13/25 14:13, Jean-Philippe Brucker wrote:
>> Hi,
>>=20
>> On Fri, Jun 13, 2025 at 01:08:07PM -0400, Demi Marie Obenour wrote:
>>> I=E2=80=99m working on virtio-IOMMU interrupt remapping for Spectrum OS=
 [1],
>>> and am running into a problem.  All of the current interrupt remapping
>>> drivers use __init code during initialization, and I=E2=80=99m not sure=
 how to
>>> plumb the struct virtio_device * into the IOMMU initialization code.
>>>
>>> What is the proper way to do this, where =E2=80=9Cproper=E2=80=9D means=
 that it doesn=E2=80=99t
>>> do something disgusting like =E2=80=9Cstuff the virtio device in a glob=
al
>>> variable=E2=80=9D?
>>=20
>> I'm not familiar at all with interrupt remapping, but I suspect a major
>> hurdle will be device probing order: the PCI subsystem probes the
>> virtio-pci transport device relatively late during boot, and the virtio
>> driver probes the virtio-iommu device afterwards, at which point we can
>> call viommu_probe() and inspect the device features and config.  This can
>> be quite late in userspace if virtio and virtio-iommu get loaded as
>> modules (which distros tend to do).>=20
>> The way we know to hold off initializing dependent devices before the
>> IOMMU is ready is by reading the firmware tables. In devicetree the
>> "msi-parent" and "msi-map" properties point to the interrupt remapping
>> device, so by reading those Linux knows to wait for the probe of the
>> remapping device before setting up those endpoints. The ACPI VIOT
>> describes this topology as well, although at the moment it does not have
>> separate graphs for MMU and interrupts, like devicetree does (could
>> probably be added to the spec if needed, but I'm guessing the topologies
>> may be the same for a VM).  If the interrupt infrastructure supports
>> probe deferral, then that's probably the way to go.
>
> I don't see any examples of probe deferral in the codebase.  Would it
> instead be possible to require virtio-iommu (and thus virtio) to be
> built-in rather than modules?

It's certainly possible to have an optional feature in the kernel that
depends on a module being built in where it otherwise wouldn't have to be.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaE0uyAAKCRBbRZGEIw/w
op9sAQCBEK39AU0uG82apXlVJycAj+vYG4hJGp4AKjRa1oUInAD8DE0FHvSy5oob
9ZDBmNcIqygQjmlHb2pkCf+AglE69gU=
=uvU/
-----END PGP SIGNATURE-----
--=-=-=--

