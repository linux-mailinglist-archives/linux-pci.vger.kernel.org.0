Return-Path: <linux-pci+bounces-38374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AC2BE4A83
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3A3400BF5
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6082B3BB48;
	Thu, 16 Oct 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIvd7NAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF242BAF4
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633188; cv=none; b=rHRR19ypEQR1AXbPayoOo85j5w/2zDrg1/NNmDplXUpdbMdDmXegNh6FXYYZ6PCQK2PgSpuUjysmi4g4MX7/ankHH5t5Yemsn27nIKsS3f/T/wBnOAImZ+dZzIJhQZhQCD25dFer2uZFVfI6IAOiSR+CNCbNPL1ofixoPXL0ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633188; c=relaxed/simple;
	bh=sdnwPn36A/jptUj0STKS93EhPg6/1zgvrxlbOb6DRB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I8/k4xB5289K8N2TgWFDn5aBfJSva09bqrZf86LBMjcG1hbj0i2+ebdXaQe6Ctf3RZ5p9u/21GATUif5YM92QuUviDbPSj19uRTSmyfdd70qvIO78AsT4AO2TosSRf3MbhynnLHlrGfBVC2O5kfS/Hy27DpVTGGyvPlsnIccn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIvd7NAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A601C4CEF1;
	Thu, 16 Oct 2025 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760633187;
	bh=sdnwPn36A/jptUj0STKS93EhPg6/1zgvrxlbOb6DRB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WIvd7NAc7OPE2zUSJRyZHfEa1xSj7OKJJvMR5UJ8cOF3WT5MTiuK9rfLRBCj2qIek
	 Wmip6kwuTxvEYqdjCvuP7ilIqK8wkLAziDVUsSwCTSW+8WmSeU4y5D+FE6OobB4oy4
	 VPGwDoMgUJt5TQhllrw3+FNpWxyPxsDEnZwk/0knvXJ+BjFbSPTA1rByu7sE6PxQZx
	 Hefb91kyEv8gzefbQtBkUWs1+zmZAaHEcrSwUXhDSYKc+KzCZ8O4mjRx9ZQOo2jVR0
	 FyUPSpKK7BAPmilhgdxxR3uwycZv+72PadNBOnoRmoWLxJeaNpjGzzvOT6B59aVNaW
	 AcK8aYVKFuVeQ==
Date: Thu, 16 Oct 2025 11:46:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: bjorn@helgaas.com, Todd Brandt <todd.e.brandt@intel.com>,
	Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [Bug 220658] New: [BISECTED] PCI MSI patch causes boot crash on
 HP Spectre x360 Convertible 14-ea0xxx
Message-ID: <20251016164626.GA988785@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bug-220658-41252@https.bugzilla.kernel.org/>

[+to linux-pci, just breadcrumbs to connect more dots,
+cc Inochi,
+bcc Hervé D., feel free to respond if you'd like your email in
Reported-by and Tested-by for the fix at https://patch.msgid.link/20251014014607.612586-1-inochiama@gmail.com]

On Mon, Oct 13, 2025 at 08:18:18PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=220658
> 
>            Summary: [BISECTED] PCI MSI patch causes boot crash on HP
>                     Spectre x360 Convertible 14-ea0xxx
>     Kernel Version: 6.18.0-rc1
>           Reporter: todd.e.brandt@intel.com
>             Blocks: 178231
>         Regression: Yes
>            Bisected 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b
> 
> Created attachment 308797
>   --> https://bugzilla.kernel.org/attachment.cgi?id=308797&action=edit
> hp_spectre_boot_crash_dmesg.jpg
> 
> As of 6.18.0-rc1 the HP Spectre crashes on boot and throws an exception after
> about 30 seconds. I've attached a jpg of the crash on the screen. I bisected
> the issue first to this merge commit:
> 
> ------------------------------------------------------
> commit 03a53e09cd723295ac1ddd16d9908d1680e7a1bf
> Merge: 3b2074c77d25 c33c43f71bda
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Sep 30 16:00:29 2025 -0700
> 
>     Merge tag 'irq-drivers-2025-09-29' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
>     Pull irq chip driver updates from Thomas Gleixner:
> ------------------------------------------------------
> 
> The first bad commit is within this merge applied to 6.17.0-rc1. I can't remove
> it clean but if I build on the commit just prior the failure goes away. So that
> offending commit is:
> 
> ------------------------------------------------------
> commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b
> Author: Inochi Amaoto <inochiama@gmail.com>
> Date:   Thu Aug 14 07:28:32 2025 +0800
> 
>     PCI/MSI: Add startup/shutdown for per device domains
> 
>     As the RISC-V PLIC cannot apply affinity settings without invoking
>     irq_enable(), it will make the interrupt unavailble when used as an
>     underlying interrupt chip for the MSI controller.
> 
>     Implement the irq_startup() and irq_shutdown() callbacks for the PCI MSI
>     and MSI-X templates.
> 
>     For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the parent startup
>     and shutdown functions are invoked. That allows the interrupt on the parent
>     chip to be enabled if the interrupt has not been enabled during
>     allocation. This is necessary for MSI controllers which use PLIC as
>     underlying parent interrupt chip.
> 
>     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
>     Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>     Link:
> https://lore.kernel.org/all/20250813232835.43458-3-inochiama@gmail.com
> 
> 
> Referenced Bugs:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=178231
> [Bug 178231] Meta-bug: Linux suspend-to-mem and freeze performance optimization
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.

