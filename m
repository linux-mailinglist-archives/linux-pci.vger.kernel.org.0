Return-Path: <linux-pci+bounces-5885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF3289C7BE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDB31F23319
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648D13F428;
	Mon,  8 Apr 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWH7wp7H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B613F425;
	Mon,  8 Apr 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588662; cv=none; b=hBMbWTheo0Sk7m3t31RXIZ7vYkcbpe9VHqDRFM+zAHlgiZmol2dUbVvqTa6u24PDefSYHUCueycKopiLq8D+o7ZCCI0XWNvjR5IcHaCsXvGg8+0SV0HJl7K/lpoQ4DJWSUNilCDUkuuehfP4BcpN3Xq+o1hjNkGEt9sOg321zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588662; c=relaxed/simple;
	bh=BVnd/s+ToAz0ywi5pWEfazLOqaEnySYG1PsThMrrUIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvoTa4dgOPJo4TPvJ7FIA6fMvJ+whXzZ9wF0aYYXwkeg0ybmlxPinsJ6dKeQLs0G//Rhdo+cNRNQfOjhGFwtl2nSyq66VxhRR/PiTN8uRxvorlJfii77zqtf8blmRgGv8ulyJ7SP54x5jOxjGZwbi7tWOz2r3x4o5UINJIURIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWH7wp7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD631C433C7;
	Mon,  8 Apr 2024 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712588662;
	bh=BVnd/s+ToAz0ywi5pWEfazLOqaEnySYG1PsThMrrUIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dWH7wp7Hu9BOVHI9bQPNePdPm/G+opP5dkZaZAnqiFmn297ty4pd0Ktx+pOMKUf+P
	 n3RTFilcntsGQnFXhJa/zR713Ze3b4BhmtWfTHECxnCA0AVamkQnDCZ+nuTuxJq3lk
	 rK1vubo9F5t74pZv/MGh1DCwHPaqpSXYrClVrPZDn2N3Y8PdgTv1EZ/5CKz5etOLMk
	 TVHgZRUTdC4ODZjgfwNX6W1DLhdCEz4H8BSXJ/OOK4tkY2mu7GrRtIpNs+hc4PLhUM
	 FkSbmoKZIX39LyGGdjU1LLJnmznstaN2g4e3qx3nLtuv5kz0oFZDe0CuLcPtdbWjZX
	 ZPVMNPl2xV/aw==
Date: Mon, 8 Apr 2024 08:04:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, John Fastabend
 <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 bhelgaas@google.com, linux-pci@vger.kernel.org, Alexander Duyck
 <alexanderduyck@fb.com>, davem@davemloft.net, Christoph Hellwig
 <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240408080420.7a6dad61@kernel.org>
In-Reply-To: <CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>
References: <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
	<20240404132548.3229f6c8@kernel.org>
	<660f22c56a0a2_442282088b@john.notmuch>
	<20240404165000.47ce17e6@kernel.org>
	<CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
	<678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
	<20240405122646.GA166551@nvidia.com>
	<CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
	<20240405151703.GF5383@nvidia.com>
	<CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
	<20240405190209.GJ5383@nvidia.com>
	<CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Apr 2024 09:05:01 -0700 Alexander Duyck wrote:
> > I'm being very clear to say that there are some core changes should
> > not be accepted due to the kernel's open source ideology.  
> 
> Okay, on core changes I 100% agree. That is one of the reasons why we
> have the whole thing about any feature really needing to be enabled on
> at least 2 different vendor devices.

The "2 different vendor"/implementation thing came up before so
I wanted to provide more context for the less initiated readers.
We try  to judge features in terms of how reasonable the APIs are,
overall system design and how easy they will be to modify later
(e.g. uAPI, depth of core changes).

Risks are usually more pronounced for stack features like GSO partial,
XDP or AF_XDP. Although my (faulty) memory is that we started with
just mlx4 for XDP and other drivers quickly followed. But we did not
wait for more than an ACK from other vendors.

We almost never have a second implementation for HW-heavy features.
TLS immediately comes to mind, and merging it was probably the right
call given how many implementations were added since. For "full" IPsec
offload we still only have one vendor. Existing TCP ZC Rx (page
flipping) was presented as possible with two NICs but mlx5 was hacked
up and still doesn't support real HDS.

Most (if not all) of recent uAPI we added in netdev netlink were
accepted with a single implementation (be it Intel's work + drivers
or my work, and I often provide just a bnxt implementation).

Summary -> the number of implementations we require is decided on case
by case basis, depending on our level of confidence..

I don't know if this "2 implementations" rule is just a "mental
ellipsis" everyone understands to be a more nuanced rule in practice. 
But to an outsider it would seem very selectively enforced. In worst
case a fake rule to give us an excuse to nack stuff.

