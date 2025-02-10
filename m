Return-Path: <linux-pci+bounces-21129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D37A2FDBD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 23:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D818D3A90F8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74F253F30;
	Mon, 10 Feb 2025 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMVQzcdN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316F1C5D6A;
	Mon, 10 Feb 2025 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227656; cv=none; b=fK6oEfPnk1oyEmd9miWmMt51Z07hIycuIfuIxzHGCCDWq3VhGldAVmtJDEJm0FtSaLVcSNWJ5h2mTqimjQfVImTK4ZcVxwhtY6hx/ir5KI3iWN/QaeA2xelxDdeuvAr6fumJN9elxwkiUO/Fgx7KNpwP8rfI0fAtkTkftfNgDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227656; c=relaxed/simple;
	bh=Ndp3Pvp3DkE/0UB6QNhcVOG9JupyDTKsubirAJ2gBLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=olG1/uep6iHQdPB0EtaeGjD3GpaiHWU2v6pqUCI4ZcNO9CIbLlj1OkOB4OecDK8cUryy5yiPVfElRevzta4P3zAyd92FCANaUOdttdcFPagiAi6cqYnHXTWuhT7P2RSh5JuwCFzGd6QrY2dY05c5rUCfYe/vxAKjndndHjmJkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMVQzcdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8E3C4CED1;
	Mon, 10 Feb 2025 22:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739227656;
	bh=Ndp3Pvp3DkE/0UB6QNhcVOG9JupyDTKsubirAJ2gBLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TMVQzcdNARn6CFZTTS7lHpJpnJgAwo2YC4HPztAvQi8arGez9ZXimMT2LWdonx3uB
	 2RDew0Zif3TbZ4zDlq5XBoaCjI/fK3bY73P6EmATUNxlkJN4gY2l4ZFaTb1gSxEiKF
	 H70wihzHWoEAYNn435ZYGlEoC9eoEuB491oTYffrtQ8jrEY0xOzPWvySonKpGWwq93
	 WVDNe/CZWsB7WXjw0MrmHwLiOVY/8oGjXorTiGYivaVmRGVvY2IZM18McDysz02cG4
	 QfYntT2qxTjr/xFTFXXLf0Xks1kE+KCAx9fapKl3yfvxkm6iSDBfc6Mcka+dg4Madl
	 B3/hJ8CFf6o+g==
Date: Mon, 10 Feb 2025 16:47:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
Message-ID: <20250210224734.GA21793@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210132740.20068-1-purvayeshi550@gmail.com>

On Mon, Feb 10, 2025 at 06:57:40PM +0530, Purva Yeshi wrote:
> Fix warning detected by smatch tool:
> Array of flexible structure occurs in 'pci_saved_state' struct
> 
> The warning occurs because struct pci_saved_state contains struct
> pci_cap_saved_data cap[], where cap[] has a flexible array member (data[]).
> Arrays of structures with flexible members are not allowed, leading to this
> warning.
> 
> Replaced cap[] with a pointer (*cap), allowing dynamic memory allocation
> instead of embedding an invalid array of flexible structures.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>

Applied with subject:

  PCI: Fix array of flexible structure usage in struct pci_saved_state

to pci/enumeration for v6.15, thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a7..648a080ef 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1929,7 +1929,7 @@ EXPORT_SYMBOL(pci_restore_state);
>  
>  struct pci_saved_state {
>  	u32 config_space[16];
> -	struct pci_cap_saved_data cap[];
> +	struct pci_cap_saved_data *cap;
>  };
>  
>  /**
> -- 
> 2.34.1
> 

