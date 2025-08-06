Return-Path: <linux-pci+bounces-33477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BDFB1CD42
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C7F3BBB79
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6B2BE7BA;
	Wed,  6 Aug 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Xk9zDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198092BEFE3;
	Wed,  6 Aug 2025 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511112; cv=none; b=AA/lk+N1P5bL5Oy90hTme3zh11z6WTo5psgS4+cd2J2XBLc7XBFrfw5RWYLKnEgbI81pv+P72CiwPzd8sH5fgRAKDyH/anYAU6trf5WjNoraFLdBKYF/dGhjNmbKOBx3P6VIacnV1QFDbEeIxBQ491fydOIYYqEMbGo3Dg/vz1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511112; c=relaxed/simple;
	bh=thD/Of/yZrsz5YALm+IVNUPGov6aTCrS+IiN3NX3GvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QXSbQyBm4pG56hQNuxD3aCQUPNr9lVsIuJkBvTScuY7poZWoBsISMLzsga5q56702C9//wpJV8AHuD1I7rHbHJ1A8TRp3v6nCMJDBjgR6RYYuXmLcMvSc1pOJzMXC4+wyZMEfzU/y2h19UzkONukR9fmIfej+OPn2XJF8VrZmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Xk9zDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BACC4CEE7;
	Wed,  6 Aug 2025 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754511111;
	bh=thD/Of/yZrsz5YALm+IVNUPGov6aTCrS+IiN3NX3GvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J0Xk9zDW0CujTX8F42jTSzcq9Wcx8h10099n9MAiXetOsIEQIeXWuAIQpRuN6nN5F
	 zmK6f9RQGYEXpH0i+89aBImJm/VWUPXJV+G4XWZZ1H+V/W1wtNKVw8We7YGsO/warz
	 rDz1j9PPljXhjYPzHxbX2SU5pqPGtyjOdIxD/ui0IJ+WGR8CN5Xi/G2szxi0Nq1H8U
	 lrxjCAD1UowytPJabdUbfF0AzDDveVfky4ulmcbgPsBvpGubUMGkGk99kdRKOzq9NG
	 eV9uKuLuReNOn3EUDXiSiioJmS5802OA8Jx7gOadhu7KMo3/ATWFJieqZPQfKt1Ltg
	 inW8VBzs1Mgkg==
Date: Wed, 6 Aug 2025 15:11:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: ibmphp: Remove space before newline
Message-ID: <20250806201150.GA14787@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731100017.2165781-1-colin.i.king@gmail.com>

On Thu, Jul 31, 2025 at 11:00:17AM +0100, Colin Ian King wrote:
> There is an extraneous space before a newline in a handful of
> debug_polling and err messages. Remove the spaces.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to pci/hotplug for v6.18, thanks!.  Will be rebased to
v6.17-rc1 when that's tagged.

> ---
>  drivers/pci/hotplug/ibmphp_hpc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
> index a5720d12e573..2324167656a6 100644
> --- a/drivers/pci/hotplug/ibmphp_hpc.c
> +++ b/drivers/pci/hotplug/ibmphp_hpc.c
> @@ -124,7 +124,7 @@ static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 i
>  	unsigned long ultemp;
>  	unsigned long data;	// actual data HILO format
>  
> -	debug_polling("%s - Entry WPGBbar[%p] index[%x] \n", __func__, WPGBbar, index);
> +	debug_polling("%s - Entry WPGBbar[%p] index[%x]\n", __func__, WPGBbar, index);
>  
>  	//--------------------------------------------------------------------
>  	// READ - step 1
> @@ -147,7 +147,7 @@ static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 i
>  		ultemp = ultemp << 8;
>  		data |= ultemp;
>  	} else {
> -		err("this controller type is not supported \n");
> +		err("this controller type is not supported\n");
>  		return HPC_ERROR;
>  	}
>  
> @@ -258,7 +258,7 @@ static u8 i2c_ctrl_write(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8
>  		ultemp = ultemp << 8;
>  		data |= ultemp;
>  	} else {
> -		err("this controller type is not supported \n");
> +		err("this controller type is not supported\n");
>  		return HPC_ERROR;
>  	}
>  
> -- 
> 2.50.0
> 

