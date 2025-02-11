Return-Path: <linux-pci+bounces-21217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2C0A31625
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C56167E99
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35524265617;
	Tue, 11 Feb 2025 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Y3KI4V45";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PuIdKcoi"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2226561E;
	Tue, 11 Feb 2025 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303767; cv=none; b=Y+0OWI5ukWCfUaaF4Kgddt+YBOUbVDY29M5Two1DigUCgqf46y0olA8aII7oV8le4HM9gLo/R/nDzLAWOSJosjp94r5XCStpwoDwqS1nvziSoniW2le5MkU17JoaDm+6a/9z4RM8aTlRKtWpLpZ6tCnpzLSo6c9ABKogBtA4Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303767; c=relaxed/simple;
	bh=Xa7y6K1Qhmf0KFju6mI8Ir+r6sZnxutlLgz2KiBWSNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBNbsR67ESyun3EHFJ9bY2sdF+7ebYkr9Ru79Jgm0lqB7XnxWgjj57n7y0kApmxIKNFNf0vD9raGEWC5+rXqpEU6BbxFpUrz734/iW726qXZwSGktX5WYE57wOhjTi9Cul2fq1qbTiiDuWse4S5mspv+NnDrn1J58L4Y65/XBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Y3KI4V45; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PuIdKcoi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9824B254018D;
	Tue, 11 Feb 2025 14:56:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 11 Feb 2025 14:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739303763; x=1739390163; bh=epwxQFHUzo
	u0AS6zngleyrj2kSoa7B4YSwiIu8wQtjE=; b=Y3KI4V45NezA1qE5yeBl04qz3Q
	ZI578HcLfb3E99kGcEXnuskaagS0/CBgipqbixyia2zroUpnXL3hayPEVVr110vQ
	vacmA18lPpZCWUsudOOcrLFZCvJwNRWrWou7Y83aIsq2B/1oSsDhi1KPbH2jj3YL
	a/c3TNRCpXs1dThVrnIANjB+Q5rpgAQ2QOg0kchPoKnXlsnmSJ+RGZxdabsixaYb
	76jvwUbhZykvFGfBFZOqFNRg3f1TXst/P1wVqoKLWfNOLMSsfPxQwHs8evJ7/RI2
	C/ygbbUub7BQcFhs4VtdUYDO3zajYZnZasiLCjjP6Py6wtcLhnXcUKvUSTMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739303763; x=1739390163; bh=epwxQFHUzou0AS6zngleyrj2kSoa7B4YSwi
	Iu8wQtjE=; b=PuIdKcoiISA2Mj6HkxGCur70LIgn3unIEhsEogGf0Qgl3wOtISQ
	8CVXPeNBWVray5UK+7RHDKS44kh75cVV3Us4WvUgf+oRGLfU9UwF/oYZ7FaSh1+g
	pMat52BydsvpUNd9ropmeUSeQhfWZdq3wTcaG0XA3jwdafcPinG0sFSUwTikWAWs
	ummGsE5OkuzLYsZeyJ83MSdwWyc4LrnCGlptFopiLx6S8hNlTZyXZsp1itKt0ovu
	E8j0yo5zIsjonXG+OHhmDA8TpDhHAQHaNCNM6WpL3gd5+zdldDFE/ijaP8QliJEn
	GJIQXllZWlWVLonhQzd2+4vdd++OsLpHf6A==
X-ME-Sender: <xms:U6urZx4Jx2M1BiER2JuCliehziOSHm2sm3hLfWh_KW_N96xrIZYobg>
    <xme:U6urZ-7xjQH6UVpt9pW5nx0poaxEZs8tH2igPTR7D2Qe5d7QTWbeq5Iq_hAVLYd_-
    1QTOMVn2cgaCMDU2Y8>
X-ME-Received: <xmr:U6urZ4culJOFc6q3vgVzdTtHF1jNpeKSpuRDvRzKeOMZRlXBgV7eM7bwbjdiPL3X4I2hnXjpOOsTYZGMHToNlqN1aBTAoIwB1cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
    tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehl
    phhivghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifsehlihhnuh
    igrdgtohhmpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmhes
    lhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U6urZ6KFPDM77OeoiNNtNkt0GXYN8LHAzWdqPJnC-sP8eKfl_PE9ug>
    <xmx:U6urZ1I2cBpLGTwc3XTEWSpWOgDkPscGCPYqJyS6PdMXnRiGEJFvVg>
    <xmx:U6urZzxpE8PCP2tDx8D5_3DVLfPSDc3Tgviu3UE1kL7iadmhz-0x7Q>
    <xmx:U6urZxJIvf087XWKdGGgj1PX-j6cWibBHf-nh1lhi6AmbWFxvOxIIw>
    <xmx:U6urZ-VS5uXCSNQHLsK0xhlCKUxIaYdsstddAUorKqgl1ji-zPtL7Ss6>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 14:56:02 -0500 (EST)
Date: Tue, 11 Feb 2025 20:56:01 +0100
From: Janne Grunau <j@jannau.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: Add depends on PAGE_SIZE_16KB
Message-ID: <20250211195601.GB810942@robin.jannau.net>
References: <20250211-pci-16k-v1-1-7fc7b34327f2@rosenzweig.io>
 <20250211183859.GA51030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211183859.GA51030@bhelgaas>

On Tue, Feb 11, 2025 at 12:38:59PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 11, 2025 at 01:03:52PM -0500, Alyssa Rosenzweig wrote:
> > From: Janne Grunau <j@jannau.net>
> > 
> > The iommu on Apple's M1 and M2 supports only a page size of 16kB and is
> > mandatory for PCIe devices. Mismatched page sizes will render devices
> > useless due to non-working DMA. While the iommu prints a warning in this
> > scenario, it seems a common and hard to debug problem, so prevent it at
> > build-time.
> 
> Can we include a sample iommu warning here to help people debug this
> problem?

I don't remember and it might have changed in the meantime due to iommu
subsystem changes. What currently happens is that
apple_dart_attach_dev_identity() fails with -EINVAL. I can't say whether
that results in a failure to probe now. I'll test and report back.

Janne

