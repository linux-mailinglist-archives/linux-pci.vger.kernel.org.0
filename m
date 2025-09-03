Return-Path: <linux-pci+bounces-35399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03CB42804
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 19:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21227ADBC1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9DB2BE646;
	Wed,  3 Sep 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BpPy2gUq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvNkCiz9"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EA4C92;
	Wed,  3 Sep 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920815; cv=none; b=fOuTIfT+GoqsFDt9EcWnnOZZOYNS2BJJRbZGkSQW1LZeYUZR2WAXXdr93/4KGBe5BHLK/C5Ifva1c7hjvd+be5LcuY8z46LiBlVu6YAlBhe3MsTevBbWIJ1YLt8njzjMcASp9PCj/CqNC8JhskogE4lrGBwvsPTNxnlO0EGBuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920815; c=relaxed/simple;
	bh=7NdrYuGFYwsKWCgftnQXPOGs8B1+f1ykKQoWQgrkJMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me5/MvnfcLYQjczWL9Gn5E1cmLVsmbx92SVoF8irhjbiiVEjcTdSPUjRLquYKw3ZWcM2UiElI/nAxZyuVqVpBxcBdDjn4rV+3eSBinqPifb7Ajb2GVydneAGNRaW7p4JbXeQ6NHYN8ErdunJ9gbFST7H8s3m38Q+e5nN9MO2yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BpPy2gUq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvNkCiz9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C54BCEC0398;
	Wed,  3 Sep 2025 13:33:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 03 Sep 2025 13:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756920812; x=1757007212; bh=1XNf5/0MJV
	7kREAd04x9fYTARlNqLAp/5VDO0xJS12E=; b=BpPy2gUqB9aVf5uXHsQaXF1n1H
	Rz7jCUrhVcziqgZ2dwc/yv1S6HQA02ms9KtH4Y6LwShA1QZAs46m93l0ybNCUmXa
	dVztJ7uFBT0BOVGQMxzORwlXeANEUodBhb9eeLLLE22mHal/G4O6dwBLOIkAWJff
	qOcqqYVAz6WlqsnzmapRGJW8t91aZmFdhB7pcd2JvEKFIOJWz91DCalCNTChqY7k
	0eJhQ1FrzdOcP/opIqJQ4A0mTijQYZShiSwTxwBLiIWp+9vDxSSXU0knlEY1PIqa
	tT6qbkS7d5gJ5243xLecGNVfJtpA/sD6etWPoRXY24d/MhMjfbsvCjLT4bpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756920812; x=1757007212; bh=1XNf5/0MJV7kREAd04x9fYTARlNqLAp/5VD
	O0xJS12E=; b=VvNkCiz9s85LG7PTTvYBnR7hlmVj83MSdm8BS1ymnbALXLuUoHt
	ZyrSRz4vW7ZIYUmCOA9X5Z0Ks8udVThysof0bAvQwrM67uu9HIiDc6dqCzBh6/DI
	lhW6Qpx2Fqypcl4uc2Fshn2aDA81e93Nmt7w+qC36ppoyzdNaXcc3UtbdDOYL4Xz
	kCBRNyjDj/qbDHbEMfrjVqL4RZu+yLFFH7vPsD+9uoi1FEKBPLnfJ0PyZeXX4rD0
	H+iSvjmGP4CzapzeCejGCQgn5TM45oC3p+S1/Hshv/PwQXwGl8J0mJALGBvUf2t4
	JA3dWsmO6ZUTh2t36RP4dVVvN9BK1x3cw2Q==
X-ME-Sender: <xms:7Hu4aLTFTLuiWEfOPnWdBudGG7RZeFQF-7JKiMBVDqHq7SBamjPvjg>
    <xme:7Hu4aHPz2NzDKUuX-ZysFiPZuglL2EinF194MQkQK-Cbob-k2lp1Efnk3XbYNy5l_
    j6ICthyq01dWvsXxg>
X-ME-Received: <xmr:7Hu4aIV4h23v9Wca_czC-YYHxdQaKvYzNOqStKO5Zu4hu3ozQAzzve9ZnY43vR1uZ7JOY3dbjLQ2YVpFOdD1ZHjQc9msp_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujggfsehttdfstddtreejnecuhfhrohhmpeflrghnucfrrghl
    uhhsuceojhhprghluhhssehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epveehvdfhkefhueeitddtgffgfeetjefggfetleduvdeggffhueehgefhkeekkeffnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhlrg
    hushdrkhhuughivghlkhgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghs
    rdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphgrlhhise
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhivghrrghlihhsiheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhifihhltgiihihnshhkiheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7Hu4aCjwgUbGTTqfgpsDrVz3DGUYa_G95wBr-xOfaR4mOJDw6JYPcg>
    <xmx:7Hu4aJjQZD3DzuqQgfaWyOskn4YLr6bu93Hp1LCL5ErxdAGINxj0nA>
    <xmx:7Hu4aIFrX2xIvocCAbMxC1rQTOjmFGRKcSs_8aJjIc5KqdMtVpWq9Q>
    <xmx:7Hu4aOD3zOUkfPh6xOQRTlbuly4rg4e9ZTrIkfUQszu8TBcInXPI5g>
    <xmx:7Hu4aDNhCzPnNJmwOw_RR1_8LWiGkDIyDn7nnMstHxqO_fwSsH0LB5SQ>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 13:33:32 -0400 (EDT)
Date: Wed, 3 Sep 2025 19:33:30 +0200
From: Jan Palus <jpalus@fastmail.com>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Fix the use of the for_each_of_range()
 iterator
Message-ID: <pedyo2xru5fmbh6ordly2o3gj63k2vakheqp75ri47mzuupi66@qchlw4pmwhny>
References: <20250902151543.147439-1-klaus.kudielka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902151543.147439-1-klaus.kudielka@gmail.com>
User-Agent: NeoMutt/20250510

On 02.09.2025 17:13, Klaus Kudielka wrote:
> The blamed commit simplifies code, by using the for_each_of_range()
> iterator. But it results in no pci devices being detected anymore on
> Turris Omnia (and probably other mvebu targets).
> 
> Analysis:
> 
> To determine range.flags, of_pci_range_parser_one() uses bus->get_flags(),
> which resolves to of_bus_pci_get_flags(). That function already returns an
> IORESOURCE bit field, and NOT the original flags from the "ranges"
> resource.
> 
> Then mvebu_get_tgt_attr() attempts the very same conversion again.
> But this is a misinterpretation of range.flags.
> 
> Remove the misinterpretation of range.flags in mvebu_get_tgt_addr(),
                                                               ^^^^

Just noticed the typo. Should be mvebu_get_tgt_attr().

> to restore the intended behavior.
> 
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> Reported-by: Jan Palus <jpalus@fastmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220479
> ---
>  drivers/pci/controller/pci-mvebu.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

