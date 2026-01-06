Return-Path: <linux-pci+bounces-44130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A594ECFB4D6
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 23:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64CC93012DD2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4E2E718F;
	Tue,  6 Jan 2026 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="d7uKE5Od";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/PV7krE"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7341C63;
	Tue,  6 Jan 2026 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740234; cv=none; b=Z7Y5rgP3736nwvLLI31rwww95ihWNlHP666K+f524MN4mpE++O1j/HObBHURq6+szsFGbe1q/kxeFjFp9+57cyT41Wed6tLkz7yFVRHKB6CU4F0Ejn4/Hrx+vMXHebC1PkzFnY26Mvm0LxIj2onHZrxdqsQQQB01wLNhfI9rcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740234; c=relaxed/simple;
	bh=IZ5oFAXeLmg2fJkkun1bfPICW7AWCqURB9x0jY/b1W4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUfFeT/NYqHJ8XTi+lUiyKBrfChAy7XANZFC9lSU5W3CY0zAro/c3mZ/gZ3Q0Bo7IJcYLtoF5X9KYLuxn8tbsQ9KzmapMzq3kVaO7Ckj5GeWsagPYU9Dv5ntlkcdW63DkGuUdVYEsEDoeDQ8WHIvg975bI9R9dRa1dDPcqKphOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=d7uKE5Od; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/PV7krE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F0C101D00127;
	Tue,  6 Jan 2026 17:57:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 Jan 2026 17:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767740230;
	 x=1767826630; bh=A2oM0i/RZZFjG1HFXcuUq5dzkmISfukUY5yQMo3PfzM=; b=
	d7uKE5OdWNX0QholdywdcUNa68Tse3WfpoEU19J0ui1jmLvAzTK8TIzBZLVMm6iz
	rEYxUDTwq9Ghh496BD/0cbN8fZBQGy0TRJTzPsG1j/V5Bo0KUVMz17X08iXQXGgy
	n+nnDlrOdaUS0hbne0FqkK8IjUOwzHwXTOv8usMBojH2hnjYhbnWj5PfUpT9GLj/
	Q4az5SezMxMWJRB1OYx4mWcnEQC3bes1TpJshLLfE1YUlPQ/NErE7f/qJW3YUApi
	OTnVK+ua++qYQkc6Wmpf069E3Lyxloxaqh0UVXKCamCuqFdqcP8qrq4OoXt3iSR0
	/0uOvxmEEfHKU6W0ruFVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767740230; x=
	1767826630; bh=A2oM0i/RZZFjG1HFXcuUq5dzkmISfukUY5yQMo3PfzM=; b=e
	/PV7krEkYWkPDWYF/PE0AJHWwYkilZWlio4NJKUYRtJWpqRiBrGYaumDBq7ZzIAB
	uMvriC5h7HdAKMNIPn2SECi6T9artBoUlQ990T/MtjXewYt1YshlMDWHB/dOThKn
	TA/aE/Op6fWNw/HU3ZpgqMMmnWLE44BHdfbuwbSTRJSuo+JHAopTpuDPZCHL/sC7
	IyooL7eYG0sJx+MxNS8Oq9rJIpcykFRUnezuNykguGMrUeyAS+zQc+jFFZFWYmMO
	X//ynRcpkPFVC2G2lyHj5+vxEtiTh1RHXzTu77bacjj+ZcPz+0oAr0P0gHvUA77k
	+pYI2jHSjramDMG42Zbng==
X-ME-Sender: <xms:RpNdabOh3kYHzFnXtmP2na9XkkdlDVwCS4Cqx__idkFlnAWnNYxifA>
    <xme:RpNdaf_I_vECxk7M4rEB69oAQgZBMVQ48Pl58mxkWKBBu2tb_n_rJHGBmW49jegoB
    _iX2m81Yjb8eIF00PmXHI8gNLyG_GI9YltPWMdcq8-0LX2n3Ocffw>
X-ME-Received: <xmr:RpNdaQ49Y4evrb_9P8z7p8Z3qHhFWtIh9EV3CjJ2l-k-3LiZnKWcWiVcUo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhephedvtdeuveejudffjeefudfhueefjedvtefgffdtieeiudfhjeejhffhfeeu
    vedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvlh
    hgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheplhhoghgrnhhgseguvghlthgrthgvvgdrtghomhdprhgtphhtthhopehjghhgseii
    ihgvphgvrdgtrgdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RpNdad6QuxtQOxGpsF7-EcbdnayWM7drdn1hf-aVRffr9zeuCSYvww>
    <xmx:RpNdaRpzb-Z1Xyia6EKujHSNaqPWM70rHN6u-UFuMQ8abZtcBb0d6g>
    <xmx:RpNdaWM-iRl9MGrp4tmG6UlJ8LiA2HXv_t_ok4K3CZfIPcRjKjKCYA>
    <xmx:RpNdaR1X3hGOWxwTwHQYf9_I0j1cHk-u4fnxwaHxPhan_UdOKOtbfg>
    <xmx:RpNdabPCozEeyeAKcmc2zKB0eFiszi9Hfmr6jgR1yMPo_sQKsTLGkxDH>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 17:57:09 -0500 (EST)
Date: Tue, 6 Jan 2026 15:57:08 -0700
From: Alex Williamson <alex@shazbot.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ankit Agrawal <ankita@nvidia.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add missing struct p2pdma_provider
 documentation
Message-ID: <20260106155708.47915065.alex@shazbot.org>
In-Reply-To: <20260106221852.GA381083@bhelgaas>
References: <20260104-fix-p2p-kdoc-v1-1-6d181233f8bc@nvidia.com>
	<20260106221852.GA381083@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 16:18:52 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Sun, Jan 04, 2026 at 02:51:28PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Two fields in struct p2pdma_provider were not documented, which resulted
> > in the following kernel-doc warning:
> > 
> >   Warning: include/linux/pci-p2pdma.h:26 struct member 'owner' not described in 'p2pdma_provider'
> >   Warning: include/linux/pci-p2pdma.h:26 struct member 'bus_offset' not described in 'p2pdma_provider'
> > 
> > Repro:
> > 
> >   $ scripts/kernel-doc -none include/linux/pci-p2pdma.h
> > 
> > Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the core logic")
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Closes: https://lore.kernel.org/all/20260102234033.GA246107@bhelgaas
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>  
> 
> Applied to pci/misc for v6.20, thanks!
> 
> Alex, let me know if you'd rather take this (you merged f58ef9d1d135).

Nope, makes sense to follow get_maintainer.pl for the standalone
follow-ups.  Sorry we didn't spot it on the way in.  Thanks,

Alex

> 
> > ---
> >  include/linux/pci-p2pdma.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> > index 517e121d2598..873de20a2247 100644
> > --- a/include/linux/pci-p2pdma.h
> > +++ b/include/linux/pci-p2pdma.h
> > @@ -20,6 +20,8 @@ struct scatterlist;
> >   * struct p2pdma_provider
> >   *
> >   * A p2pdma provider is a range of MMIO address space available to the CPU.
> > + * @owner: Device to which this provider belongs.
> > + * @bus_offset: Bus offset for p2p communication.
> >   */
> >  struct p2pdma_provider {
> >  	struct device *owner;
> > 
> > ---
> > base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
> > change-id: 20260104-fix-p2p-kdoc-3f503e6d6a55
> > 
> > Best regards,
> > --  
> > Leon Romanovsky <leonro@nvidia.com>
> >   


