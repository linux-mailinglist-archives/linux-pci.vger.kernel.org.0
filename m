Return-Path: <linux-pci+bounces-3254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3684EA8F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C988C1C22045
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746F4F1EE;
	Thu,  8 Feb 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyu4EKQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65148CC6;
	Thu,  8 Feb 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427995; cv=none; b=E5O75ee/CMwHUsdUyqPw6NbcIBm4JUIhFp7ZLIk2U7KLBrV91O37YLxDxXVUUjqTacVwSH7YeFU7Ij0/ztQF9zv2vuG6vL9dZK5XHNebPrHQ2LWDvDQmnCXEAFT+2DrgcE+f1K2F+lBAdsFcnr1MPfuy3l0IgxftGU9h1pLr7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427995; c=relaxed/simple;
	bh=yo5vnXHyIx1FjoDcm/XP6Pmz2W7lO68ZWNXRyinSzU0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S+WriaTXvYZQ7QV3PpCZ5TT9mAT8Fub1vM5g4zhMN5KS6NeA16W+gg+EepXNTSs/DKR6ApLwMF9apjcfdj9Q8IohBxcEzjLAvQqkZnZHkGmTmJ/sA1Lf8eF0Xnd3py1XasVZa/Vt8ErkIhl+CGN49wunZWj3yLXsDqyrSVokN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyu4EKQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA95C433C7;
	Thu,  8 Feb 2024 21:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427995;
	bh=yo5vnXHyIx1FjoDcm/XP6Pmz2W7lO68ZWNXRyinSzU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Tyu4EKQyJh2dKk37zRS2anU8j/iZ2zwUN7w5kpYFhTWzXsiJ6MP+JQW0L4K8ZG1wT
	 cvGVZ++h8vKACSSugeZQQWuRVkVtah7vp2UBq2YuEMkzv51hNDaz2TOcOgEv8WFfrU
	 CXeBCRacRwBGPCZPPP00L9xBxt9AEaW6DB0GfgIPrgwLb05lqVcoJCdyYOrNAaDlgu
	 PrPAfauiA48Ox1EeTs+pE2Z8+RpZ0zGZX9j+RLDOXz9XA6cK1k61aec/0+dzYjhiY9
	 eO5f8BWrvF5bm7fWS5CK2ojmoCXn2ZNGNfryDtB+xBYpl4RvRlwwuLPAlPrejVfh5f
	 MQZO0aFZCVEKw==
Date: Thu, 8 Feb 2024 15:33:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Eric Dumazet <edumazet@google.com>, alexis.lothore@bootlin.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Fix a sleeping issue in a RCU read section
Message-ID: <20240208213313.GA973325@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d9ec4a10235def0e764ff1f5be881ba12e16e8.1704397858.git.christophe.jaillet@wanadoo.fr>

On Thu, Jan 04, 2024 at 08:52:35PM +0100, Christophe JAILLET wrote:
> It is not allowed to sleep within a RCU read section, so use GFP_ATOMIC
> instead of GFP_KERNEL here.
> 
> Fixes: ae21f835a5bd ("PCI/P2PDMA: Finish RCU conversion of pdev->p2pdma")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied with Logan's Reviewed-by to pci/p2pdma for v6.9, thanks!

> ---
> This patch is speculative.
> It is based on a discussion related to another patch. See [1].
> 
> It also matches the doc, IIUC. See [2]
> 
> [1]: https://lore.kernel.org/all/20240104143925.194295-3-alexis.lothore@bootlin.com/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/RCU/whatisRCU.rst#n161
> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 0c361561b855..4f47a13cb500 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -661,7 +661,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  	p2pdma = rcu_dereference(provider->p2pdma);
>  	if (p2pdma)
>  		xa_store(&p2pdma->map_types, map_types_idx(client),
> -			 xa_mk_value(map_type), GFP_KERNEL);
> +			 xa_mk_value(map_type), GFP_ATOMIC);
>  	rcu_read_unlock();
>  	return map_type;
>  }
> -- 
> 2.34.1
> 

