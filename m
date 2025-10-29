Return-Path: <linux-pci+bounces-39721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88BC1D04D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147DD4050BB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47B1F418F;
	Wed, 29 Oct 2025 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN1IOm2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E02749C4
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766497; cv=none; b=WWfy+0YCqSOVNErj849R5nWPzw2reVTnZbZEOQXUv9qRKgoICg9DtwTQgdAzYO07f63WG5smtKm54tj1luo5Lhjthint6tufAKA8gTywRpCFs8qqYYpbm4g8L03Lpu9ZRomjMJHNQXLRFqBkQGGJnh0KzV7B+g7YxyrrBjvWu3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766497; c=relaxed/simple;
	bh=Tsj/0L4nIezX/uH/bFWSuyha92vXCESDlrdriIrS6hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K0w3NcPC0+1S4F41ptoPjPu4OXYXZgeuAHNRcn0XwTEUKCxgHU1SbCl+CdmpXgjwkXfHQqU39utWK5XdvOnyhavbN0+e3WQ1JnVtnwwrdnk9GuAEBsMjzFG1PWVp++CZB9XN70r8SZmavz08iQ36n132k9xy+4uhIEiB0VMdTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN1IOm2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02402C4CEF7;
	Wed, 29 Oct 2025 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761766497;
	bh=Tsj/0L4nIezX/uH/bFWSuyha92vXCESDlrdriIrS6hQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WN1IOm2euVXmfOktgXrcojHNyETaWKRW3Ve2bpS2eDgBPbY4LHVEaapwFZk7TfYk+
	 vpGIIX0a3lXToqMWCDhm5NPHPfepHJahKz9M8nVCfqImTYJKIUuMkQbnhHzRYyrAuG
	 11Jaw89Y1WdQGBpAJU79QsMMaNA9waD+pgKOzw6KGkWm7UK2YPVwO6qqtnOeFxIAM9
	 kW2TEsyY8e7WQ9MC3s6O+TJkfhvSpjp2WejOu0RsldvSTgQIQgeFS0DJr4QqrjYT53
	 FPMA3zHlIjJ/bMJYlR/sF2PHpyfBmcP2A5dwJKsAA74C6cEM+oCku2Ul3Z+YP/jOqe
	 +QdS4SzhFkqjQ==
Date: Wed, 29 Oct 2025 14:34:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	Aaron Erhardt <aer@tuxedocomputers.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Don't assume the only VGA device on a system is
 `boot_vga`
Message-ID: <20251029193455.GA1576217@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029185940.2499129-1-superm1@kernel.org>

On Wed, Oct 29, 2025 at 01:59:33PM -0500, Mario Limonciello (AMD) wrote:
> Some systems ship with multiple display class devices but not all
> of them are VGA devices. If the "only" VGA device on the system is not
> used for displaying the image on the screen marking it as `boot_vga`
> because nothing was found is totally wrong.
> 
> This behavior actually leads to mistakes of the wrong device being
> advertised to userspace and then userspace can make incorrect decisions.
> 
> As there is an accurate `boot_display` sysfs file stop lying about
> `boot_vga` by assuming if nothing is found it's the right device.
> 
> Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
> Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Do we need a Fixes: here?  A stable cc?

The bugzilla suggests this might be a regression and hence v6.18
material?

> ---
>  drivers/pci/vgaarb.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 436fa7f4c3873..baa242b140993 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>  		return true;
>  	}
>  
> -	/*
> -	 * Vgadev has neither IO nor MEM enabled.  If we haven't found any
> -	 * other VGA devices, it is the best candidate so far.
> -	 */
> -	if (!boot_vga)
> -		return true;
> -
>  	return false;
>  }
>  
> -- 
> 2.43.0
> 

