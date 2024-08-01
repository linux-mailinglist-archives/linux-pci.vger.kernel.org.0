Return-Path: <linux-pci+bounces-11146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1691E945509
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 01:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BD11F22BE8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 23:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7114D451;
	Thu,  1 Aug 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acQr4igk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1313E04C;
	Thu,  1 Aug 2024 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722556528; cv=none; b=BUZgeIebbklmjANrt9oKGP/0Hr3zhdEBaEIXu9nzAG+sr3Wt8Mw4zLtgHL6UeVs5lrOpZ9kHufpgNVCnynTRVP0volS3/1MQRQh0UI2xVSZq90rREecn7nDYlgc3uzSgC0fPh4WZFDKh8QwncRI0N2VGeuLiHnY/+ililNZ/OAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722556528; c=relaxed/simple;
	bh=/kOT2ZW0E6g1IHZG0hWnLMP1ClTzTmx1Ik99DYN5zLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=po2LpQUwyXFmOdjs/2267bSkmadv9a4FR3nVH6da8w7kx0W/A6Sntou2fVqU1YoDhEnUS7M0Xn0jjvY2pPzItKNSE2CaKGQcY8ZwPTXfvU+GJh2zESRwjG1fmdLJpGt/Veb7wthlqDL5cJd+1OHKFq3wt8jtyTpJWhQf22e2P0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acQr4igk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC0C32786;
	Thu,  1 Aug 2024 23:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722556528;
	bh=/kOT2ZW0E6g1IHZG0hWnLMP1ClTzTmx1Ik99DYN5zLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=acQr4igkIUlJgQgFtrjWtks5FPYSC7y7Tj1HKX691FXExd6O/fCVmdod3ItDfFWsv
	 2dfPPT7BhjrVocDyvnr5YbRNO2mJXT09Gv79hFTFbP350v0+AZF1xIIORmW4v9evyB
	 SlTnXUsXf4WM4lwq45OaNMIrJCghRS5h8PRenrPhWlVkXji9RuYQN59FmRoahChOx6
	 2AEbBafvL3oodYULbrTIumA/14B8zaZGkpq7tNIjhfsdbrpPwNFf0B+KWwQjQaOMKk
	 UTryedTee2Xi3WaIKXpT+fp9VzhnI6isbzFSEumueRrQ+HIUBFheuFwJOM4bwoD+b7
	 YhYe5xnuz1bow==
Date: Thu, 1 Aug 2024 18:55:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Hunter <david.hunter.linux@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Rob Herring <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] of.c: replace of_node_put with __free improves cleanup
Message-ID: <20240801235526.GA129068@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719223805.102929-1-david.hunter.linux@gmail.com>

[+cc Rob, Jonathan]

On Fri, Jul 19, 2024 at 06:38:05PM -0400, David Hunter wrote:
> The use of the __free function allows the cleanup to be based on scope
> instead of on another function called later. This makes the cleanup
> automatic and less susceptible to errors later.
> 
> This code was compiled without errors or warnings.

I *think* this looks OK, but I'm not comfy with all this scope magic
yet, so would like Jonathan and/or Rob to take a peek too.

And is there some way to include a hint here about how to find the
implicit of_node_put()?  I think it's this from 9448e55d032d ("of: Add
cleanup.h based auto release via __free(device_node) markings"):

  +DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))

but it did take some looking to find it.

If it looks good, I'll tweak the commit log to use imperative mood:
https://chris.beams.io/posts/git-commit/
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94

since this technically says what *could* happen but not what the patch
*does*.

> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> ---
>  drivers/pci/of.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index b908fe1ae951..8b150982f5cd 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -616,16 +616,14 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  
>  void of_pci_remove_node(struct pci_dev *pdev)
>  {
> -	struct device_node *np;
> +	struct device_node *np __free(device_node) = pci_device_to_OF_node(pdev);
>  
> -	np = pci_device_to_OF_node(pdev);
>  	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
>  		return;
>  	pdev->dev.of_node = NULL;
>  
>  	of_changeset_revert(np->data);
>  	of_changeset_destroy(np->data);
> -	of_node_put(np);
>  }
>  
>  void of_pci_make_dev_node(struct pci_dev *pdev)
> -- 
> 2.34.1
> 

