Return-Path: <linux-pci+bounces-43448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE01CD2393
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 01:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845B53016347
	for <lists+linux-pci@lfdr.de>; Sat, 20 Dec 2025 00:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B92745E;
	Sat, 20 Dec 2025 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="CCw2mjCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIv2rUp5"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B48488;
	Sat, 20 Dec 2025 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766189207; cv=none; b=gZFgxCDibFZ66r5NEoI83WID+LzY3BqC8pVumfQzEaxXwXng3WjfYUPT/aplfzUnbgjK1d/YZWSzcioiBp1M/IWL/3zsK/ZVe+/HHwoQvoahke4bbJML6OAXb1HHHSHOaYk3jTw2G7ihwQHfjebv5i+GH112s4yXDgtNzwuR3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766189207; c=relaxed/simple;
	bh=4M/ENON5+ldxqNSBQHms6uF7rBvjqthFygVjLS1hmnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTrXXsDYRSG+keKYSuFiVMHvHuhxgZFdFyZ7kf1JaaXRN+BGqpbNpOlUgRoeuufY/Vj1pbekq5ALhpMRMK80pjJu4MXaEr6PGiakvUIlUTSQtk5PPj9wXDaMoq/uALbeaiGI6f/sqs07X0hAHVyTio10LoGthiNsRNN2H9WmeoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=CCw2mjCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jIv2rUp5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4ACB214000C8;
	Fri, 19 Dec 2025 19:06:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 19 Dec 2025 19:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766189202;
	 x=1766275602; bh=uP2unCIWDU3A7v1w9Vm1SuytIFKF6aoaLTx9wKRYXoQ=; b=
	CCw2mjCSiwG8rLbZSlDPJ47f81xTGqW+OEu/4NmMasTnU1XjzXHWrHkEFFojeTHy
	1M3XXYneLwUNf29DgmdUlZXUmZbtnERxnPiFmNNtw9GNkQCsDAKQyKk1jH814Pua
	5xXxZW9Hujh8GYJPY80b9joslTBL4Fs3D84Br5KxXfyjfu0iK0WhQnIvtu5LeJ4H
	DjL4Wdq0oXBEf9JfisCpXDqbf/pm/Kt9O5vkECOcrQs2sLUuF2J/lgIf9MQG2iQA
	FKM0tVXL2EbiDKBFJ3wxeusVEeWzPb+4w1vihjRgqhoq1+j4cy7kUG9DZfa7XwpV
	x9ShNAXlpD/fVRviPc7Pdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766189202; x=
	1766275602; bh=uP2unCIWDU3A7v1w9Vm1SuytIFKF6aoaLTx9wKRYXoQ=; b=j
	Iv2rUp5wIU0K0+VM4VVVXLK9iGPIege+y4RleSWFheISmM+lKYW/RekV63oBdqqm
	eN8q1jPc+dgAxATYfJHOMKLgxb4vX4vTHZECNWX2Rbjbbu3u8Qr3YAgkSlFoGSmm
	Lebxd94DuxvmoW0gaN9mmc74IRrNTJXx9RCeq2Tk0sRf0l8kI6HcxslVyTqTEKLw
	GC75VFowGPIQ05l9tBLpSypPVhgroQ4eoneUAaCZfog+/L7obFYF9vLMq4seQrJV
	/B3iH3kxpPAeEk5udTE67LG8io7U4ffpw5zSwmJMnoPeOC4H15+03kQ2PJhHMO4l
	eQtlZUlnF+0thEntOPrzQ==
X-ME-Sender: <xms:kehFaRtjDe6JPwtTaNnEft1TjxsWvspsMj_uYWmBxKaPfOWIbkNnMQ>
    <xme:kehFaTbOnS3dYxHgPpaVTyyUDa6-wn0RDl4JX6QN10uxZsuOF8P1j_1QOAXKtXykY
    ub55tlhrY9n_xAOHkqynemeIZsKBSXBU8K23qt6fJAmGMZ2DxI_0Q>
X-ME-Received: <xmr:kehFaQWZdncDqWiLg1J5EszKEu7nOQCMWWawwWG7b-QWQTOVcwAjh8rx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegleejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhggtgfgsehtqhertddttdejnecuhfhrohhmpeetlhgvgicuhghi
    lhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrghtth
    gvrhhnpefgffdvfeejjeeuveefteduhfegteefueehteefkeejvdduvdeuhefftdegjeek
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    gvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghjrgihghgrrhhgnhhsihhtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthho
    pehiohhmmhhusehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kehFaYTmBslcgXtrXJ_5iKz90G7PXfNT3B4hNv7UKHyMrVcQdsdKPg>
    <xmx:kehFaeMYfg3JWoxGiHO2mElYh9OHiJtMl40n2dUTrzRf13gggCVRHQ>
    <xmx:kehFaWT6PbifTwjvQvjV-LqDh3vjrwaQqWtMq8vGsCAGCXqp-mgfyw>
    <xmx:kehFachD_xOhNKUgbnKflG_3pToE5rEPcE6NKyyg9b_iS9Iux55LYQ>
    <xmx:kuhFadwZ0cWOGA2ugIgENtV1gdBZpbRyKCgWumKmqQ4AIIicaF-xTaNA>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 19:06:41 -0500 (EST)
Date: Fri, 19 Dec 2025 17:06:37 -0700
From: Alex Williamson <alex@shazbot.org>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
Message-ID: <20251219170637.2c161b7b.alex@shazbot.org>
In-Reply-To: <CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
	<20251215045203.13d96d09.alex@shazbot.org>
	<CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
	<CAHP4M8X=e+dP-T_if5eA=gccdbxkkObYvcrwA3qUBONKWW3W_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Dec 2025 11:53:56 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> Hi Alex.
> Kindly help if the steps listed in the previous email are correct.
>=20
> (Have added qemu mailing-list too, as it might be a qemu thing too as
> virtual-pci is in picture).
>=20
> On Mon, Dec 15, 2025 at 9:20=E2=80=AFAM Ajay Garg <ajaygargnsit@gmail.com=
> wrote:
> >
> > Thanks Alex.
> >
> > So does something like the following happen :
> >
> > i)
> > During bootup, guest starts pci-enumeration as usual.
> >
> > ii)
> > Upon discovering the "passthrough-device", guest carves the physical
> > MMIO regions (as usual) in the guest's physical-address-space, and
> > starts-to/attempts to program the BARs with the
> > guest-physical-base-addresses carved out.
> >
> > iii)
> > These attempts to program the BARs (lying in the
> > "passthrough-device"'s config-space), are intercepted by the
> > hypervisor instead (causing a VM-exit in the interim).
> >
> > iv)
> > The hypervisor uses the above info to update the EPT, to ensure GPA =3D>
> > HPA conversions go fine when the guest tries to access the PCI-MMIO
> > regions later (once gurst is fully booted up). Also, the hypervisor
> > marks the operation as success (without "really" re-programming the
> > BARs).
> >
> > v)
> > The VM-entry is called, and the guest resumes with the "impression"
> > that the BARs have been "programmed by guest".
> >
> > Is the above sequencing correct at a bird's view level?

It's not far off.  The key is simply that we can create a host virtual
mapping to the device BARs, ie. an mmap.  The guest enumerates emulated
BARs, they're only used for sizing and locating the BARs in the guest
physical address space.  When the guest BAR is programmed and memory
enabled, the address space in QEMU is populated at the BAR indicated
GPA using the mmap backing.  KVM memory slots are used to fill the
mappings in the vCPU.  The same BAR mmap is also used to provide DMA
mapping of the BAR through the IOMMU in the legacy type1 IOMMU backend
case.  Barring a vIOMMU, the IOMMU IOVA space is the guest physical
address space.  Thanks,

Alex

