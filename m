Return-Path: <linux-pci+bounces-37979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF21BD63FD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66A604E611A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1B2C11F0;
	Mon, 13 Oct 2025 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJMsDYlN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47208156CA
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388460; cv=none; b=lpfyfl80EfifkKwAWBWaNPTa9v+S1gjP4OzrMet2dOk1t42OaDkXR/6g8AhByKLvOyK+uYDE/4BgCXsMN5XiYlrrciOkn+X2hPIRHfGCnDzlrXNvDlmPzfh3oDdbiM/+sf8X8ipMDtpXHLJGnxh4/XwHrlJqhihY7HDPGtXAEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388460; c=relaxed/simple;
	bh=kYvQ6Hxo3oTP6IQRe2qtT/XA9KSMdq81htQikgmGJRo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kGo+SyZTTis+q1TS7+ieZcNCQR0HeHxiMaFdfm9NlYXKiSw7e9bYgOYI4rvGb6Ni2sNKHrJXd6KBmxjOFBjo9BpwlNyB6h74gkocOvlS3H79FdJiY6Y3OD0nkPbiPUmAcopfUeeesitsIdhGMD3FTdX2p/WQg49FTuCGk03YUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJMsDYlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1744C4CEE7;
	Mon, 13 Oct 2025 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760388459;
	bh=kYvQ6Hxo3oTP6IQRe2qtT/XA9KSMdq81htQikgmGJRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HJMsDYlNsEUq6Xsj3YLeohufjHnbH7IezTaebVxN/cEWEfbuFt+f1L4nIFD0ho525
	 JVlmIkMBL7hoTE+dL/bENGmYWa07THqVtpYONRcJLC5KUwGvAiEncfTSkRRkcAcPLa
	 qGqyNyDnV5Qt0hRSHCNpk1SQzhazo6p4aWq/nxWYtGKkfb3CBsTqYa/smsOPF+Wa1y
	 MV6kPQZnFU7GVMzpsLzgJvGA5P6y/p2JmaQzbFXypX7JIa+HYPdY41Zkwee7mBgRbb
	 o3Or96vxaouUfX1EmywOXq7OAsGgLxK/IzZoh1WLOFhQWpnnMhR9u2A8oKwJKLELSA
	 QdrcNkYQCKk+Q==
Date: Mon, 13 Oct 2025 15:47:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, tzimmermann@suse.de,
	Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/VGA: Select SCREEN_INFO
Message-ID: <20251013204738.GA863114@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013175524.GA850308@bhelgaas>

On Mon, Oct 13, 2025 at 12:55:25PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 13, 2025 at 10:44:23AM -0500, Mario Limonciello (AMD) wrote:
> > commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> > a screen info check") introduced an implicit dependency upon SCREEN_INFO
> > by removing the open coded implementation.
> > 
> > If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> > would now return false.  Add a select for SCREEN_INFO to ensure that the
> > VGA arbiter works as intended. Also drop the now dead code.
> > 
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Applied to for-linus for v6.18, thanks!

Oops, dropped because of this regression:

  https://lore.kernel.org/r/176038554347.1442.9483731885505420131@15dd6324cc71

> > ---
> > v2:
> >  * drop dead code (Ilpo)
> > ---
> >  drivers/pci/Kconfig  | 1 +
> >  drivers/pci/vgaarb.c | 8 +-------
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 7065a8e5f9b14..c35fed47addd5 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -306,6 +306,7 @@ config VGA_ARB
> >  	bool "VGA Arbitration" if EXPERT
> >  	default y
> >  	depends on (PCI && !S390)
> > +	select SCREEN_INFO
> >  	help
> >  	  Some "legacy" VGA devices implemented on PCI typically have the same
> >  	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> > diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> > index b58f94ee48916..8c8c420ff5b55 100644
> > --- a/drivers/pci/vgaarb.c
> > +++ b/drivers/pci/vgaarb.c
> > @@ -556,13 +556,7 @@ EXPORT_SYMBOL(vga_put);
> >  
> >  static bool vga_is_firmware_default(struct pci_dev *pdev)
> >  {
> > -#ifdef CONFIG_SCREEN_INFO
> > -	struct screen_info *si = &screen_info;
> > -
> > -	return pdev == screen_info_pci_dev(si);
> > -#else
> > -	return false;
> > -#endif
> > +	return pdev == screen_info_pci_dev(&screen_info);
> >  }
> >  
> >  static bool vga_arb_integrated_gpu(struct device *dev)
> > -- 
> > 2.43.0
> > 

