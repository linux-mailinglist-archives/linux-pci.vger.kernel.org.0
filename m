Return-Path: <linux-pci+bounces-8877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DD90B7C9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 19:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1055B2652B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1B168488;
	Mon, 17 Jun 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzwgGJqt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD33166314
	for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643878; cv=none; b=D8DQJrsgHTO7+yC3Hmk6/m2bneeUvC+detf1HDBCzQmNrLYGKr9f4Gt5cYemYMul6uZqtLKnuLFolMM5WwEPlKVOAyClA4gHY2XjPdoahA9a0merWkrD/DFDT1cd0HYC3ol7zsqlo1tbRPqAD1W7J1gibhcW2b0lH0Q9qpo1p1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643878; c=relaxed/simple;
	bh=Sbr38IEyzbv30pXjCsiqVpPar3snX1VFic8GHD1Hvao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg9Zgf538Y3CHEc3ljG1GLrvCxNbc3GAouSLY7GRepUYNQBdnZ2x3l8O6r+bmQwXEH9sTUgXmfoVjFBGCF3pvJnZ4RtUTCkrxgHHSTiV9sP7XaXsgDBFWbB63EXpk5LG13wwzAKKLDd8+x9zRvsBHrZaSOj6VBLLPOPkmMnBRXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzwgGJqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98C1C2BD10;
	Mon, 17 Jun 2024 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643878;
	bh=Sbr38IEyzbv30pXjCsiqVpPar3snX1VFic8GHD1Hvao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzwgGJqtlUtYED4n+IxCbPTdg75/4xtQzWgErNbUXSQrPA/59raIJ8+GKyWg2R0sY
	 4eKzJUuNBLSezBbX6WuGn28ZIU9MbjMkdnqDZ8nKUQ8BI6+IXB9Lsw/td7TuHJDmbB
	 kU9jfuDBSp5NUsQaO37W0N7+pV1n6RqtyTz4k91l5BwqfFi2QArOdNpD0aUm4N6zsB
	 uW3QkwX1W1qkLuXYeK+eVqS2AuemuXIG21FJmsURg/b4oYa6WzsDokiGCU0YM8690/
	 Mc6DnNBcOPZ+4nYm0YFBuRhIaZUIDv6Dfkl1E0FFeX31HlQu9SM9x7h0lEYk49GPkf
	 3xjaZGGev6AbQ==
Date: Mon, 17 Jun 2024 11:04:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Subject: Re: [PATCHv2 2/2] PCI: err: ensure stable topology during handling
Message-ID: <ZnBso88fjsf54dkq@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612181625.3604512-1-kbusch@meta.com>
 <20240612181625.3604512-3-kbusch@meta.com>
 <Zm2gpY_Yi9JTrS_5@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm2gpY_Yi9JTrS_5@wunner.de>

On Sat, Jun 15, 2024 at 04:09:41PM +0200, Lukas Wunner wrote:
> Below is a small patch which acquires a ref on child.  Maybe this
> already does the trick?

Thanks, it appears your idea works! I've run it through 100 test
iterations successfully; previously it would reliably panic within 5 or
fewer iterations.

I also need the first patch from this series, though, otherwise it
inevitably deadlocks. I'd be interested to hear if you have any thoughts
on that one.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Tested-by: Keith Busch <kbusch@kernel.org>

> -- >8 --
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 2a8063e..82db9a8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4753,7 +4753,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
>   */
>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  {
> -	struct pci_dev *child;
> +	struct pci_dev *child __free(pci_dev_put) = NULL;
>  	int delay;
>  
>  	if (pci_dev_is_disconnected(dev))
> @@ -4782,8 +4782,9 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  		return 0;
>  	}
>  
> -	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
> -				 bus_list);
> +
> +	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
> +					     struct pci_dev, bus_list));
>  	up_read(&pci_bus_sem);
>  
>  	/*

