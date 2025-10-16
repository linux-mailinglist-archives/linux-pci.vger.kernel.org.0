Return-Path: <linux-pci+bounces-38381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5EBE4CD3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86D104E0808
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9533469C;
	Thu, 16 Oct 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiWKwPe+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A3334695
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634864; cv=none; b=J1myFqjogOaGiMCE+oS4HlQs708tydBXAX0LUq9ff4vXYi2HXJXlLms2JdRV/k1qH4OM6ioMSO+8S+i23V1wIGcogSOdg1RvY+K6y6n1w49SmxCboM43pIuvR+FswYSuBIiQkGh8KDABIbxmc6iLnK/XNBQJzsCLTSnBeb7UkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634864; c=relaxed/simple;
	bh=pUGKwEHzhhG/p5cMRzKMdz4zj00wg0okQfFLUG8q+mY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=To+fgad3SQ5Dt5hewCgBElrQnCamQHYi2odjWik2vb9BNLrHVs9WuwY14AV6bOkTsbVNbuOuwvERWjGNUELJrGI1M9AxsCgGHk3TBE2A8jOs0yPRTsD8+a4XfiODwn7RK67E9nt0xYGj3btQHFDnT/hW3GnFmfOOXKhmf+81JT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiWKwPe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DE6C4CEF1;
	Thu, 16 Oct 2025 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760634863;
	bh=pUGKwEHzhhG/p5cMRzKMdz4zj00wg0okQfFLUG8q+mY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tiWKwPe+UlYqcRmqxDwx+H+9p24YjpioHUanKWabAfmeTCQR3Oafj1xmUSOeDp6dJ
	 wRththzaF3QchIO0NOOhuFAGYvmW4vUdKnF1WDWPw7JtFvAQCBjIAE676HVKkhwwyD
	 XUCGMci2HnBn2H00Z86m8r2GdeO8bqFm782bOQO0ODpcBBCiAYsZeM3DOa4vUwgZcf
	 gmUP+K+tM26y5nkyVip3AtGuaN18fWOsHWyF5oWFuFk7p9CIX86ywetQ3HbJJAu53A
	 mp5lrX3SVkXhH8Px9E/6utHkn2rmfKpqLK3FfgnPaY317zZNxo3Uoj3T9p1Nx264R0
	 5XC9ir+DbhpFA==
Date: Thu, 16 Oct 2025 12:14:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [pci:for-linus] BUILD REGRESSION
 f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01
Message-ID: <20251016171422.GA991021@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdee889f-b154-4532-ba8d-ae5910ce1613@kernel.org>

On Thu, Oct 16, 2025 at 11:35:07AM -0500, Mario Limonciello wrote:
> On 10/16/25 11:28 AM, Bjorn Helgaas wrote:
> > On Thu, Oct 16, 2025 at 11:18:38AM -0500, Mario Limonciello wrote:
> > > On 10/16/25 11:15 AM, Bjorn Helgaas wrote:
> > > > On Thu, Oct 16, 2025 at 07:26:50AM +0800, kernel test robot wrote:
> > > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
> > > > > branch HEAD: f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01  PCI/VGA: Select SCREEN_INFO on X86
> > > > 
> > > > Just making sure you've seen this, Mario.
> > > 
> > > I didn't see this, thanks for including me.
> > > 
> > > > I *think* f0bfeb2c51e4 is the most recent version, and it was
> > > > on pci/for-linus, so I'll drop it for now.
> > > 
> > > Are you sure the failure is caused by "PCI/VGA: Select
> > > SCREEN_INFO on X86"?
> > 
> > I'm not sure.  I looked briefly for a more detailed report but
> > didn't find it.  Maybe didn't look hard enough.  This email seems
> > like a summary that could possibly have included a link to
> > details.
> 
> I looked at https://lore.kernel.org/oe-kbuild-all/ and don't see one
> there either.
> 
> I think you should keep the patch in.  As it pertains to arch
> specific stuff it behaves identically to pre-337bf13aa9dda.

Yep, added back as 54a880a5af73 ("PCI/VGA: Select SCREEN_INFO on X86"):

commit 54a880a5af73 ("PCI/VGA: Select SCREEN_INFO on X86")
Author: Mario Limonciello (AMD) <superm1@kernel.org>
Date:   Mon Oct 13 17:08:26 2025 -0500

    PCI/VGA: Select SCREEN_INFO on X86
    
    commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a
    screen info check") introduced an implicit dependency upon SCREEN_INFO by
    removing the open coded implementation.
    
    If a user didn't have CONFIG_SCREEN_INFO set, vga_is_firmware_default()
    would now return false.  SCREEN_INFO is only used on X86 so add a
    conditional select for SCREEN_INFO to ensure that the VGA arbiter works as
    intended.
    
    Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
    Reported-by: Eric Biggers <ebiggers@kernel.org>
    Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
    Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
    Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
    Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    Tested-by: Eric Biggers <ebiggers@kernel.org>
    Link: https://patch.msgid.link/20251013220829.1536292-1-superm1@kernel.org


diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7065a8e5f9b1..f94f5d384362 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -306,6 +306,7 @@ config VGA_ARB
 	bool "VGA Arbitration" if EXPERT
 	default y
 	depends on (PCI && !S390)
+	select SCREEN_INFO if X86
 	help
 	  Some "legacy" VGA devices implemented on PCI typically have the same
 	  hard-decoded addresses as they did on ISA. When multiple PCI devices
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index b58f94ee4891..436fa7f4c387 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -556,10 +556,8 @@ EXPORT_SYMBOL(vga_put);
 
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
-#ifdef CONFIG_SCREEN_INFO
-	struct screen_info *si = &screen_info;
-
-	return pdev == screen_info_pci_dev(si);
+#if defined CONFIG_X86
+	return pdev == screen_info_pci_dev(&screen_info);
 #else
 	return false;
 #endif

