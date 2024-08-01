Return-Path: <linux-pci+bounces-11144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62BB9454CF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 01:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237281C21900
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 23:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35014AD30;
	Thu,  1 Aug 2024 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDu2DMAO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B061482E2
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722553968; cv=none; b=ngIQhhfNaVbbvIfZ52MJ8eyz2yRUV9LetNoqnwMMtvBI+2HbF2MLVfOFAZHJV8bR/PxxFeamchEvPHCxf63KDVGZLgLEmPE8hc3WqE9AR5NKgTnqjeaKya6KZt6ey1B29HjVSOQB1C3Hyz2cimwCiUyQnP75ji25mIJhXsjvlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722553968; c=relaxed/simple;
	bh=GuKccZNEcrusD82Kvvc8HvoAWdJiUIGMKPbJIKKTgbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uKJl4hQATJan8fvH/tXwlblJ5c35YRRTacSnpeoTz77s0YR14nThYtA3pV9hCLGth37D72pCDSjr+1tU6NUm6hxkekvjbLwMIGg0R4w4SMTPqUeVZaZ3S2RkPmcux6+GWDIfUrHs0WPOiWGhrEi+9y38vwcFPRyQ1cZtBxQN7zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDu2DMAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85857C32786;
	Thu,  1 Aug 2024 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722553967;
	bh=GuKccZNEcrusD82Kvvc8HvoAWdJiUIGMKPbJIKKTgbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pDu2DMAOsGmaQaEuCYlNUTyz/CdVkn1RqIWAK7E4X+dXzNvM44Lrle3kANlIcAh8B
	 k1uTYem9AVFwknxW+d/t41VeTgo+ay4lGQr6SvQ4zYHxKtqRoYK3oGEQ0ZvbwjfMqd
	 +NHxCPqOSuPF5YXLcad+U2GWMRySe8vq68Nu4/9zPexwQKdmhULghgCpCv8lrDX5ZF
	 fPKo9egX7EAfu4p1Vi6CFk7cqeQkDzyKHz97Dg+JosSr6hF2Ft7aL3o+9n7niGNRUx
	 ZzEMIik2b99ZOMRliMiZjac7zIm6Ai2kV4xruNHdbnyyO154nxzMJ3+EYtflavYubZ
	 IQ31fb9tggYpQ==
Date: Thu, 1 Aug 2024 18:12:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Ming Wang <wangming01@loongson.cn>
Subject: Re: [PATCH] PCI: Prevent LS7A Bus Master clearing on kexec
Message-ID: <20240801231245.GA127499@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726092829.2042624-1-chenhuacai@loongson.cn>

On Fri, Jul 26, 2024 at 05:28:29PM +0800, Huacai Chen wrote:
> This is similar to commit 62b6dee1b44aa23b39355 ("PCI/portdrv: Prevent
> LS7A Bus Master clearing on shutdown"), which prevents LS7A Bus Master
> clearing on kexec.
> 
> Only skip Bus Master clearing on bridges because endpoint devices still
> need it.

I think we need some explanation here and a hint in the comment below
about why this is needed.

I guess the point is to work around the LS7A defect that clearing
PCI_COMMAND_MASTER prevents MMIO requests from going downstream, and
we may need to do that even after .shutdown(), e.g., to print console
messages?

And in this case we rely on .shutdown() for the downstream devices to
disable interrupts and DMA?

s/62b6dee1b44aa23b39355/62b6dee1b44a/

> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4..b7d3a4d8532f 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -517,7 +517,7 @@ static void pci_device_shutdown(struct device *dev)
>  	 * If it is not a kexec reboot, firmware will hit the PCI
>  	 * devices with big hammer and stop their DMA any way.
>  	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> +	if (kexec_in_progress && !pci_is_bridge(pci_dev) && (pci_dev->current_state <= PCI_D3hot))
>  		pci_clear_master(pci_dev);
>  }
>  
> -- 
> 2.43.5
> 

