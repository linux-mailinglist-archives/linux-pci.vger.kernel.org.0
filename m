Return-Path: <linux-pci+bounces-34411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E1B2E692
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5D7188DB19
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768327AC32;
	Wed, 20 Aug 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqIL5ITc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E819007D;
	Wed, 20 Aug 2025 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721712; cv=none; b=JW8eE2dQVJ4z++44b77BkGZqgTdw3WelLNwilIVkk9CBMHvsqWH8d2DxNiFJDhxHY4d7LuaXzWijjJNukLY/TCt0KEWBfK9CFpepxCA8P+yvTi9hrSl+Pr2FbhTcuHlQDxebjimtbx9e/V4Xygcnz1sK45xJ7suVvsxc9ik8J7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721712; c=relaxed/simple;
	bh=C1ll2EQlPEA5XO+Evquc8cSLPIUfEm2wj77bw4FhA8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cde+83h3wPsyZT/Vu1+SgOqy+JUtHkRJ5qYB5L0ziNnhJ6oPcKSrzkHbkP6dbE1H/sa0fVchy/JLtAHSSgjbWt88SCglJpFJmg61fqrXfqAB92Edgv2xM2lK1IrflUiT26M6j7r5+Q0Q+DwHAWOvq8Dvhu65P/ylrRuOx9Qh7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqIL5ITc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E636BC4CEE7;
	Wed, 20 Aug 2025 20:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755721712;
	bh=C1ll2EQlPEA5XO+Evquc8cSLPIUfEm2wj77bw4FhA8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NqIL5ITc6S9dFHM9U9B2aZJFz9D8sXA43XwdnSd51EeWfHhThyqrlXkCxXRXBWqhE
	 MYCCLFMbPrVBUdEAeDXA/kybKeyGOtTYXYviSwub/4OX2YIKh5ASP0M4ieWGc9Nrgm
	 cvwNB2h5yOoDc6yQ9lw22Q04db/KtLFHn3lPUSLB2OrokoiOelCsKMFCx3FrX2BtpO
	 GOPI7oB3t7AgF1p+ASat3DKrh03hwMh4p7ULrNHdopYJNQcNPuXcta5NnWKovgmtmQ
	 mdGviL+2NHHC9gMvHEbY7qTif6d84QYyLWmaV2thkNugBDcpEh+dfHHrXgufHNu/3g
	 SY9VkGjcPGMJw==
Date: Wed, 20 Aug 2025 15:28:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sungho Kim <sungho.kim@furiosa.ai>
Cc: bhelgaas@google.com, logang@deltatee.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: p2pdma: Fix incorrect pointer usage in devm_kfree()
 call
Message-ID: <20250820202830.GA638988@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820105714.2939896-1-sungho.kim@furiosa.ai>

On Wed, Aug 20, 2025 at 07:57:14PM +0900, Sungho Kim wrote:
> The error handling path in the P2P DMA resource setup function contains
> a bug in its `pgmap_free` label.
> 
> Memory is allocated for the `p2p_pgmap` struct, and the pointer is stored
> in the `p2p_pgmap` variable. However, the error path attempts to call
> devm_kfree() using the `pgmap` variable, which is a pointer to a member
> field within the `p2p_pgmap` struct, not the base pointer of the allocation.
> 
> This patch corrects the bug by passing the correct base pointer,
> `p2p_pgmap`, to the devm_kfree() function.
> 
> Signed-off-by: Sungho Kim <sungho.kim@furiosa.ai>

Applied to pci/p2pdma for v6.18, thanks!

> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index da5657a02..1cb5e423e 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -360,7 +360,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  pages_free:
>  	devm_memunmap_pages(&pdev->dev, pgmap);
>  pgmap_free:
> -	devm_kfree(&pdev->dev, pgmap);
> +	devm_kfree(&pdev->dev, p2p_pgmap);
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
> -- 
> 2.48.1
> 

