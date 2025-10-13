Return-Path: <linux-pci+bounces-37935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0DBD59C9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 19:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E793A2420
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC5F267B94;
	Mon, 13 Oct 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ2usoal"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C825D546
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378126; cv=none; b=KHk2+BRcuqpoIikBtcXVLoa9eRDN1aqUp0Yv3fD1YPbrPjtnjmqPudTHaZaPojNGxV2udXxmv9CcsxntukFpqbMPa2wXxnsTwpZJGdv63G2Ws0TF2hlyynkxHkl4/WO/5jZUmlHV2q/9APPNFvY75UPxIKRjS8fg7lttDjkOgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378126; c=relaxed/simple;
	bh=sNy/pN36tv+R9jKy/e64kF/Gbg7wyEheooXi+qlh9Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fi7fPGGCvbarSENJnlq+FOKnYJMN6MjMSXgK2nfyMIRYCFF4JDQGYVCvME8bQ4AKcpqaA6qUMWW7bfQr1WZ/L/tlnp4dOHsiQ7lvvi5cuac0xhWpMCc1bv234I43A6rYKK5yUjLnpi0Ro4YwS6va3ac8M0Rkgv8EgahD2cUEvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ2usoal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9C3C4CEFE;
	Mon, 13 Oct 2025 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760378125;
	bh=sNy/pN36tv+R9jKy/e64kF/Gbg7wyEheooXi+qlh9Fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iZ2usoalOt+ENVdv0BNae9iMgS5XSaIVWEJpSOJf09jgQTAMptg93CkzuGAZ0SMhX
	 wnmvtE0uECk5bjEyV0ZxIBwhr+7thrTbKPMxFzjAq7TEwA0vSQmYdXoHcpaqD19KKo
	 FoxhFbALgMccmdMInL8MBU1pdhtx8gzEL0E+hPFQiXy7GR2+aCO53qKodElRKrXqFg
	 8fjdJHm8hijeX89KbYR+zZbBZIlrNE16PL0aGbbwHrfa5rEXUcKKxFTOdk0jTzLv70
	 XSAYQpQUjapFx4hNJKTcXjceqFpMXM8LDHz3P8lIvoXL45Ve4bfGYLej0DecftXo0G
	 a9f1cjiBw32QQ==
Date: Mon, 13 Oct 2025 12:55:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de,
	Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/VGA: Select SCREEN_INFO
Message-ID: <20251013175524.GA850308@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013154441.1000875-1-superm1@kernel.org>

On Mon, Oct 13, 2025 at 10:44:23AM -0500, Mario Limonciello (AMD) wrote:
> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") introduced an implicit dependency upon SCREEN_INFO
> by removing the open coded implementation.
> 
> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> would now return false.  Add a select for SCREEN_INFO to ensure that the
> VGA arbiter works as intended. Also drop the now dead code.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied to for-linus for v6.18, thanks!

> ---
> v2:
>  * drop dead code (Ilpo)
> ---
>  drivers/pci/Kconfig  | 1 +
>  drivers/pci/vgaarb.c | 8 +-------
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7065a8e5f9b14..c35fed47addd5 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -306,6 +306,7 @@ config VGA_ARB
>  	bool "VGA Arbitration" if EXPERT
>  	default y
>  	depends on (PCI && !S390)
> +	select SCREEN_INFO
>  	help
>  	  Some "legacy" VGA devices implemented on PCI typically have the same
>  	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index b58f94ee48916..8c8c420ff5b55 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -556,13 +556,7 @@ EXPORT_SYMBOL(vga_put);
>  
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
> -#ifdef CONFIG_SCREEN_INFO
> -	struct screen_info *si = &screen_info;
> -
> -	return pdev == screen_info_pci_dev(si);
> -#else
> -	return false;
> -#endif
> +	return pdev == screen_info_pci_dev(&screen_info);
>  }
>  
>  static bool vga_arb_integrated_gpu(struct device *dev)
> -- 
> 2.43.0
> 

