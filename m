Return-Path: <linux-pci+bounces-44782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C703D20660
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C3323009FE2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442AA22256B;
	Wed, 14 Jan 2026 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1clwwlK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21283155C82;
	Wed, 14 Jan 2026 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768410061; cv=none; b=a6jalYLNiVTj6cmB4TxPMerF4OHt8KY4xLSrFp54y7l1iGmX6annueys3eK0x57HmxHZKWnDZOmgL7im8wT8nKW9ITKT3cntRxzu8x5wOODx+pZxaOrBrKU7MXYwVR55RqLdlK8d6KtFxKa8vD+zLd4EgJmsDYfuouMSvwjc/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768410061; c=relaxed/simple;
	bh=+MSLC0nxsNHZ2kD3oC4yulpiHW4eZgvlDqwnh+CurQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jK1Tsahs1qxU3t6ttS5TDMXg+1LFF0znrqzfc/eU7dEE2/PaeB7Eo4MJZXY5CKo3guy6apt+VL1koUbBBRhg9zMbO87soh+IFt/ff5AnsoDpAn15fq5CNOV2ii5d0U3ZH85r64Hdy7QyJv1DhjeuguYClHT1OIEkPiXw3BNMNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1clwwlK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9FFC4CEF7;
	Wed, 14 Jan 2026 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768410060;
	bh=+MSLC0nxsNHZ2kD3oC4yulpiHW4eZgvlDqwnh+CurQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z1clwwlKVg75m28YLhi2wZUpknJW9owNHuLdphOzL5cJ7W8SwNe8D3FLbzpZQwi6d
	 CIDE12MxjnW/bGD/ifok+8a00OgtiTvXnT6/9+RYNjRHWKYW/bWAxAH+YkDnXwW7m7
	 hIe3Pr0brIURoJnleHLKjAH12vb+yCT0CI1dg/E9cZWY6R72OwZq9xCyLvUeCcxscf
	 hJ5Jwa9s1RfkLPdaeE9WDwMpNls56+BKsKdqwqmVy9CgkVqklPtAv1ZlWRUahSId0l
	 CGGXn15fgfsnBExHyeZO3ZRzuRdAKcz3FUoMIQIeuqoVMufyymCb477xtcatPcvR/1
	 S+EHC0DWxPXsA==
Date: Wed, 14 Jan 2026 11:00:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] PCI: Remove useless WARN_ON() from devres
Message-ID: <20260114170059.GA822278@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218092819.149665-2-phasta@kernel.org>

On Thu, Dec 18, 2025 at 10:28:20AM +0100, Philipp Stanner wrote:
> PCI's devres implementation contains a WARN_ON() which served to inform
> users relying on the legacy devres iomap table that this table does not
> support multiple mappings per BAR.
> 
> The WARN_ON() can be regarded as useless by now, since mapping a BAR
> multiple times is legal behavior and old users of pcim_iomap_table(),
> the accessor function for that table, did not break in the past PCI
> devres cleanup. New PCI users will hopefully notice that
> pcim_iomap_table() is deprecated and are unlikely to use it for mapping
> the same BAR multiple times.
> 
> Moreover, WARN_ON()s create noisy, difficult to read error messages
> which can be more confusing than helpful, since they don't inform the
> user about what precisely the problem is.
> 
> Remove the WARN_ON().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Applied to pci/misc for v6.20, thanks!

> ---
>  drivers/pci/devres.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 9f4190501395..f075e7881c3a 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -469,9 +469,6 @@ static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
>  	if (!legacy_iomap_table)
>  		return -ENOMEM;
>  
> -	/* The legacy mechanism doesn't allow for duplicate mappings. */
> -	WARN_ON(legacy_iomap_table[bar]);
> -
>  	legacy_iomap_table[bar] = mapping;
>  
>  	return 0;
> -- 
> 2.49.0
> 

