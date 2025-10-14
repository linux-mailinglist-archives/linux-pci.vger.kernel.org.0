Return-Path: <linux-pci+bounces-38095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27CBDBA57
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 00:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41381356763
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 22:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1403081DC;
	Tue, 14 Oct 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkMu9J96"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BD2EC0AC
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480862; cv=none; b=Z63k8UtUmPIGA4gdmPoNXCz5M4/mRVTFdbN05BtVTGb4h/J1IXKK4iutaagu3Hn4AnZXwZ8w5yP8Q3aWvwIktXVY7v1fN4u0O1u51R0/hnFwWBbQGZ2oJCx24NGrPZKYO+nXHrM416R3k/3LQcvAXzp1/4hvuD2pZ0kSmaIW0wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480862; c=relaxed/simple;
	bh=mMkV7AwkQ4nLcxstSTdjrBQgdkP2To/5xR41FohUtiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DZDiulSCBj/d1/GwQWdzHEf8ScHiicWuhRoxTHnGgAu2V/Jb/M9jy7oh6OwaeKcxm7g4oGaBAkle7ScFtR1G4Qkcf+LZ6MDPoFJ5Zv8HTI459r3UZO15/XFndBHnJykNUttVsJhz7Z7F457bVPuVl1IqH6sLFzIv4Qo43tdA2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkMu9J96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144FEC4CEE7;
	Tue, 14 Oct 2025 22:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760480862;
	bh=mMkV7AwkQ4nLcxstSTdjrBQgdkP2To/5xR41FohUtiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AkMu9J96uBO8irm1HcPhKPFs8mUZF5672j+2SwrCE1sA+CF3kMpp802yprGuuIGYX
	 kto+yT5qqiy7UdzrC06hhQrUiuZqOnppWCN1XcTJ9Dc6huIdvfw1BZkzw8Sa9QMK6L
	 uTncqkGffyHoXOsE2Qw8i5g8Ep2VC7ibxtiiW+nYIO6Yv65QJyHvSwyIBVRSosfCN3
	 MRknL82FUt7nwZKgYsYUBHzvvpB/dA7fDglp/gsyNWFpGfX4+NS9Fj7AbR96GAl7St
	 HuBsrjiMy4SNFjWv4DvMt8nRnXKoF4FndmhEJ7jud78xLu66riYbs4Y6SD2aMqigoY
	 bnNxZP5vwt0dQ==
Date: Tue, 14 Oct 2025 17:27:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de,
	Eric Biggers <ebiggers@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/VGA: Select SCREEN_INFO on X86
Message-ID: <20251014222740.GA913183@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013220829.1536292-1-superm1@kernel.org>

On Mon, Oct 13, 2025 at 05:08:26PM -0500, Mario Limonciello (AMD) wrote:
> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") introduced an implicit dependency upon SCREEN_INFO
> by removing the open coded implementation.
> 
> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> would now return false.  SCREEN_INFO is only used on X86 so add add a
> conditional select for SCREEN_INFO to ensure that the VGA arbiter works
> as intended.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied to pci/for-linus for v6.18, thanks!

> ---
>  drivers/pci/Kconfig  | 1 +
>  drivers/pci/vgaarb.c | 6 ++----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7065a8e5f9b14..f94f5d384362e 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -306,6 +306,7 @@ config VGA_ARB
>  	bool "VGA Arbitration" if EXPERT
>  	default y
>  	depends on (PCI && !S390)
> +	select SCREEN_INFO if X86
>  	help
>  	  Some "legacy" VGA devices implemented on PCI typically have the same
>  	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index b58f94ee48916..436fa7f4c3873 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -556,10 +556,8 @@ EXPORT_SYMBOL(vga_put);
>  
>  static bool vga_is_firmware_default(struct pci_dev *pdev)
>  {
> -#ifdef CONFIG_SCREEN_INFO
> -	struct screen_info *si = &screen_info;
> -
> -	return pdev == screen_info_pci_dev(si);
> +#if defined CONFIG_X86
> +	return pdev == screen_info_pci_dev(&screen_info);
>  #else
>  	return false;
>  #endif
> -- 
> 2.43.0
> 

