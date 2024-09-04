Return-Path: <linux-pci+bounces-12773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011596C49E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BE01F213A5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F19649631;
	Wed,  4 Sep 2024 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFs4Q608"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FC374FF;
	Wed,  4 Sep 2024 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469245; cv=none; b=MsCu5a6RuCjN4RRV2U+awjyRv4b9RZvz++9NmA8G240fd/v8AZhTieYvhYiHgEmdKIUYP3AZKdK/qtBiqeI9mhchAjVZWnlXd3vD01S1FIihVqGbDMHtSQLKrg9RVg03H/28pnaieM6EE9c4O6w9t5EyfVMo6STTnE1aZO+0rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469245; c=relaxed/simple;
	bh=W7tyF895qn4+3mvsOG3cOeeo5wL/ONqmkzwYccW6yzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OErsBkWdV8devltGn4ZbrJRBGcZrd/a3r/r9VvbFqYnmQ+DL0tHZkN719SKgHEv5tUsLyF42AT541xADCbjUaHCCGurjhumENmjod+Q24v7/v3UiqCqcopGa5a63Uof7UUetyudbpe4EPupSE0CcWn95LmpXxhUci4al6RG9KNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFs4Q608; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1694C4CEC2;
	Wed,  4 Sep 2024 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725469245;
	bh=W7tyF895qn4+3mvsOG3cOeeo5wL/ONqmkzwYccW6yzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LFs4Q608D/9lSjMZewlt21eDmm6aNXJvd1Q4Z/mzDmOD9nS0R06L0IlKcjTEgkZ0O
	 BXzDjjI2Ph6dF9r6Fyqn96PgKc/UFY3n8zUfxpmA5KkB9uYWHFE3wQAfswWzk670nC
	 /sUEw29VOEDCY4qQXepBdM6YKotOJ3mE3zisTyYRNQE1cXDoBb1i2WNBtXaDJANCFk
	 MbCO+jk6UUZj5Rjr0ysopWklbtoRhPfy4SaqWg+n9luTblYuv230Jo8Fu22O49Yp9d
	 T7Bs7lkI4eXw4h1pDHSPdgP8t8J3URJRlvElrGRKF+MKoot3fYoPMUO3CcOCY0StmT
	 YMFxt0Ie6cfpw==
Date: Wed, 4 Sep 2024 12:00:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: jim2101024@gmail.com, nsaenz@kernel.org, lorian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] PCI: brmstb: Fix type mismatch for num_inbound_wins
 in brcm_pcie_setup()
Message-ID: <20240904170042.GA336896@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904161953.46790-2-riyandhiman14@gmail.com>

On Wed, Sep 04, 2024 at 09:49:54PM +0530, Riyan Dhiman wrote:
> Change num_inbound_wins from u8 to int in brcm_pcie_setup() function to correctly 
> handle potential negative error codes returned by brcm_pcie_get_inbound_wins().
> The u8 type was inappropriate for capturing the function's return value,
> which can include error codes.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Apparently a fix for 46c981fd60de ("PCI: brcmstb: Refactor for chips
with many regular inbound windows"), which is currently queued on the 
pci/controller/brcmstb branch?

I agree, this looks good, and we should squash it into 46c981fd60de.

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e8332fe5396e..b2859c4fd931 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1030,7 +1030,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	struct pci_host_bridge *bridge;
>  	struct resource_entry *entry;
>  	u32 tmp, burst, aspm_support;
> -	u8 num_out_wins = 0, num_inbound_wins = 0;
> +	u8 num_out_wins = 0
> +	int num_inbound_wins = 0;
>  	int memc, ret;
>  
>  	/* Reset the bridge */
> -- 
> 2.46.0
> 

